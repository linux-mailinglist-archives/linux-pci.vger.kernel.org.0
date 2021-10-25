Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FC243A549
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 22:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhJYU7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 16:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234922AbhJYU7Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 16:59:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32B3660F4F;
        Mon, 25 Oct 2021 20:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635195422;
        bh=eyrRwYBeXVaLoEwRi+CNfg0wgXLpkCyw36WntjbrHVQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=twRa9vsH3jdOxGK6dQFwR7qB8MnshyDWZ8hyYEOzv0S6+BzvH4+5jpZogiaz/R+AQ
         HoTA+Dy9SDIqRTfEBg4V3P3JPHlD1MH4KdoZAFriV13LNvJihun4DhvIfoKf7cOHuv
         IHr/XtHzqH2Y9QfdB3Qs7voVxr2CcWBWGDxAXLpf1p2Q0SdZnpkHDoWJmPaWA+iNXk
         OmwHGjkXCUtcEBQF2IgW3rfQ1M6XNm3FypBnhwYkC4+ZlRHghj5cQyNYMeeF9fXWkD
         +E/Kbqbcv5UMT4hxFb6RWXdhsHHg6J7N1FSJfswrEuBlmzkXwKZHR/z/Yk0c7ArYJn
         cDLARcyOaDgVg==
Date:   Mon, 25 Oct 2021 15:57:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [PATCH] PCI/VPD: Fix stack overflow caused by pci_read_vpd_any()
Message-ID: <20211025205700.GA28333@bhelgaas>
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
> 
> Fixes: 80484b7f8db1 ("PCI/VPD: Use pci_read_vpd_any() in pci_vpd_size()")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Tested-by: Qian Cai <quic_qiancai@quicinc.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

What does this apply to?

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
