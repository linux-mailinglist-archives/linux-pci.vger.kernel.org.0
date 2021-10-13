Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0ED42C91D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 20:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbhJMS4A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 14:56:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhJMSz7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 14:55:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 334B26008E;
        Wed, 13 Oct 2021 18:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634151235;
        bh=A8IoIsWihagI3YspI5rm1b9XF17mv6LOfvUhY1VoL9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pHIrSXu4SUB/Pr2iuIqPVexucH8LP/y5kUcg0SPv3DC2nPSyN0hqilBg3JqNQsUC/
         jpOYWZ3KylwWxrjajrH2jRBGszbKF1bbUDCI5sUU7hvZA0rkGTVvWNr6pb5pGuKVMP
         Mc7pdKpIYB+IFpIPx69uq5pOeYfXrPcmn6A3XuVaAFBsKk1WJVu5VM8lpQZM5ofKkf
         MFdepVlQ90svuIBzE+kWTPcicNR/9Iz77DJnRgqM0Nef6k+A1ro/j1rO/Kh8fh1LN9
         Ml5Y24Kz6Qfl+9u7QDGZEl4l3l9imWY9Urv5+UX8F/dZGrNV4Vuqwkv52vqED/yoFD
         KdjSNku39Q6aw==
Date:   Wed, 13 Oct 2021 13:53:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [PATCH] PCI/VPD: Fix stack overflow caused by pci_read_vpd_any()
Message-ID: <20211013185353.GA1909717@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6211be8a-5d10-8f3a-6d33-af695dc35caf@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 13, 2021 at 08:19:59PM +0200, Heiner Kallweit wrote:
> Recent bug fix 00e1a5d21b4f ("PCI/VPD: Defer VPD sizing until first
> access") interferes with the original change, resulting in a stack
> overflow. The following fix has been successfully tested by Qian
> and myself.

What does "the original change" refer to?  80484b7f8db1?  I guess the
stack overflow is an unintended recursion?  Is there a URL to Qian's
bug report with more details that we can include here?

> Fixes: 80484b7f8db1 ("PCI/VPD: Use pci_read_vpd_any() in pci_vpd_size()")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Tested-by: Qian Cai <quic_qiancai@quicinc.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/vpd.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 5108bbd20..a4fc4d069 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -96,14 +96,14 @@ static size_t pci_vpd_size(struct pci_dev *dev)
>  	return off ?: PCI_VPD_SZ_INVALID;
>  }
>  
> -static bool pci_vpd_available(struct pci_dev *dev)
> +static bool pci_vpd_available(struct pci_dev *dev, bool check_size)
>  {
>  	struct pci_vpd *vpd = &dev->vpd;
>  
>  	if (!vpd->cap)
>  		return false;
>  
> -	if (vpd->len == 0) {
> +	if (vpd->len == 0 && check_size) {
>  		vpd->len = pci_vpd_size(dev);
>  		if (vpd->len == PCI_VPD_SZ_INVALID) {
>  			vpd->cap = 0;
> @@ -156,17 +156,19 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>  			    void *arg, bool check_size)
>  {
>  	struct pci_vpd *vpd = &dev->vpd;
> -	unsigned int max_len = check_size ? vpd->len : PCI_VPD_MAX_SIZE;
> +	unsigned int max_len;
>  	int ret = 0;
>  	loff_t end = pos + count;
>  	u8 *buf = arg;
>  
> -	if (!pci_vpd_available(dev))
> +	if (!pci_vpd_available(dev, check_size))
>  		return -ENODEV;
>  
>  	if (pos < 0)
>  		return -EINVAL;
>  
> +	max_len = check_size ? vpd->len : PCI_VPD_MAX_SIZE;
> +
>  	if (pos >= max_len)
>  		return 0;
>  
> @@ -218,17 +220,19 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>  			     const void *arg, bool check_size)
>  {
>  	struct pci_vpd *vpd = &dev->vpd;
> -	unsigned int max_len = check_size ? vpd->len : PCI_VPD_MAX_SIZE;
> +	unsigned int max_len;
>  	const u8 *buf = arg;
>  	loff_t end = pos + count;
>  	int ret = 0;
>  
> -	if (!pci_vpd_available(dev))
> +	if (!pci_vpd_available(dev, check_size))
>  		return -ENODEV;
>  
>  	if (pos < 0 || (pos & 3) || (count & 3))
>  		return -EINVAL;
>  
> +	max_len = check_size ? vpd->len : PCI_VPD_MAX_SIZE;
> +
>  	if (end > max_len)
>  		return -EINVAL;
>  
> @@ -312,7 +316,7 @@ void *pci_vpd_alloc(struct pci_dev *dev, unsigned int *size)
>  	void *buf;
>  	int cnt;
>  
> -	if (!pci_vpd_available(dev))
> +	if (!pci_vpd_available(dev, true))
>  		return ERR_PTR(-ENODEV);
>  
>  	len = dev->vpd.len;
> -- 
> 2.33.0
> 
