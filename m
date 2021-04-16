Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2135F362A2D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 23:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbhDPVW5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 17:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344372AbhDPVWq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Apr 2021 17:22:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 815F76023F;
        Fri, 16 Apr 2021 21:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618608130;
        bh=yFAIhhbb3bsV+juDNHFWJa9uWEGJnKojtx+qbNU7Q48=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cRvVcXNghmk9WGhaWZV7QLAdKYI4czwzN85ceNAjCCVpO9jTJD78I/NgcucFzfjlr
         V5COFsD9MKE4ivm/jbCQzYI9fbZwz+oqi0yI2ntwGQ6F8oBhaCCpJSPfbrc12wnrpa
         CD/pViP+I/oay1FWF6ZJjagLuNdHeeMtkqhljb7j3Qpl0f89JwCaoFaOnkj5o2qmAI
         RHBpoGb07wLFHByhtQfDmHdQX+EmId1e/34/4Sk3fglnYip5h1YFZhjl4GM7SEOXuS
         aEhDSJ168tRbw2A2fhCKy7vElQa7DhH6oQKK8szzggZNNFbHs57HNNw0rxZ4J5K+gg
         hPk9MEu0HF1Aw==
Date:   Fri, 16 Apr 2021 16:22:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/VPD: Add helper pci_get_func0_dev
Message-ID: <20210416212209.GA2758189@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75d1f619-8a35-690d-8fc8-e851264a4bbb@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 16, 2021 at 09:52:07PM +0200, Heiner Kallweit wrote:
> The combined use of the PCI_DEVFN() and PCI_SLOT() macros in several
> places is unnecessarily complex. Use a simplified version and add
> a helper for it.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied with pci_get_func0_dev() as follows to pci/vpd for v5.13.
It's true that "devfn & 0xf8" is simpler, but it also exposes
implementation details that need not be exposed here.

  diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
  index b23bbab6802d..03a02af5a6a7 100644
  --- a/drivers/pci/vpd.c
  +++ b/drivers/pci/vpd.c
  @@ -28,6 +28,11 @@ struct pci_vpd {
	  unsigned int	valid:1;
   };
   
  +static struct pci_dev *pci_get_func0_dev(struct pci_dev *dev)
  +{
  +	return pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
  +}
  +

> ---
>  drivers/pci/vpd.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 42f762ab0..60573f27a 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -28,6 +28,12 @@ struct pci_vpd {
>  	unsigned int	valid:1;
>  };
>  
> +static struct pci_dev *pci_get_func0_dev(struct pci_dev *dev)
> +{
> +	/* bits 2:0 in devfn is the device function */
> +	return pci_get_slot(dev->bus, dev->devfn & 0xf8);
> +}
> +
>  /**
>   * pci_read_vpd - Read one entry from Vital Product Data
>   * @dev:	pci device struct
> @@ -305,8 +311,7 @@ static const struct pci_vpd_ops pci_vpd_ops = {
>  static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
>  			       void *arg)
>  {
> -	struct pci_dev *tdev = pci_get_slot(dev->bus,
> -					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> +	struct pci_dev *tdev = pci_get_func0_dev(dev);
>  	ssize_t ret;
>  
>  	if (!tdev)
> @@ -320,8 +325,7 @@ static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
>  static ssize_t pci_vpd_f0_write(struct pci_dev *dev, loff_t pos, size_t count,
>  				const void *arg)
>  {
> -	struct pci_dev *tdev = pci_get_slot(dev->bus,
> -					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> +	struct pci_dev *tdev = pci_get_func0_dev(dev);
>  	ssize_t ret;
>  
>  	if (!tdev)
> @@ -414,7 +418,7 @@ static void quirk_f0_vpd_link(struct pci_dev *dev)
>  	if (!PCI_FUNC(dev->devfn))
>  		return;
>  
> -	f0 = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> +	f0 = pci_get_func0_dev(dev);
>  	if (!f0)
>  		return;
>  
> -- 
> 2.31.1
> 
