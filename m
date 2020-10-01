Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFD5280474
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 19:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732737AbgJARCW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 13:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732159AbgJARCB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 13:02:01 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7304207F7;
        Thu,  1 Oct 2020 17:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601571721;
        bh=CT8KJZLhDnaw9uZvQtE+9OTGUmasnl/Zxle8BsB9f7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fP3I5/GQyEn9m52+ewsMNnej5hCiXao7HJd6fAYFB4BKNW4KpIHl1D1v7CN1HaC+e
         pBLuXi3JRB8IhWkShy07N2vq0WxlePYHj32ZODZ4drP7tTzzTiYTs9yoFrW35g9zuH
         6CP1uoNLS5Je6og+MYHL9vjl3P2fqdyOoWN2hL48=
Date:   Thu, 1 Oct 2020 12:01:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Qian Cai <cai@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] pci: Fix -Wunused-function warnings for pci_ltr_*
Message-ID: <20201001170159.GA2706033@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001132850.7630-1-cai@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 01, 2020 at 09:28:49AM -0400, Qian Cai wrote:
> When CONFIG_PCIEASPM=n,
> 
> drivers/pci/pci.c:3098:12: warning: 'pci_ltr_encode' defined but not used [-Wunused-function]
>  static u16 pci_ltr_encode(u64 val)
>             ^~~~~~~~~~~~~~
> drivers/pci/pci.c:3076:12: warning: 'pci_ltr_decode' defined but not used [-Wunused-function]
>  static u64 pci_ltr_decode(u16 latency)
>             ^~~~~~~~~~~~~~
> 
> Fixes: 5ccf2a6e483f ("PCI/ASPM: Add support for LTR _DSM")
> Signed-off-by: Qian Cai <cai@redhat.com>

Fixed, thanks!

> ---
>  drivers/pci/pci.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index db8feb2033e7..e96e5933b371 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3069,6 +3069,7 @@ void pci_pm_init(struct pci_dev *dev)
>  		dev->imm_ready = 1;
>  }
>  
> +#ifdef CONFIG_PCIEASPM
>  /**
>   * pci_ltr_decode - Decode the latency to a value in ns
>   * @latency: latency register value according to PCIe r5.0, sec 6.18, 7.8.2
> @@ -3113,7 +3114,6 @@ static u16 pci_ltr_encode(u64 val)
>   */
>  void pci_ltr_init(struct pci_dev *dev)
>  {
> -#ifdef CONFIG_PCIEASPM
>  	int ltr;
>  	struct pci_dev *bridge;
>  	u64 snoop = 0, nosnoop = 0;
> @@ -3150,9 +3150,15 @@ void pci_ltr_init(struct pci_dev *dev)
>  		pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT,
>  				      nosnoop_enc);
>  	}
> -#endif
>  }
>  
> +#else
> +void pci_ltr_init(struct pci_dev *dev)
> +{
> +}
> +
> +#endif
> +
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
>  {
>  	unsigned long flags = IORESOURCE_PCI_FIXED | IORESOURCE_PCI_EA_BEI;
> -- 
> 2.28.0
> 
