Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E5C2327BD
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 00:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgG2Wxp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 18:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgG2Wxo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 18:53:44 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1121C207E8;
        Wed, 29 Jul 2020 22:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596063224;
        bh=cEibLL/bXDofHAoCU9s5MewlMnFquDXY+eJhqMB4Jwc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gICzHMTZ63HFESjZa4lR45zvcawxtQsOxXbEx9ppm7AwW1lm/JW9Dn4atLwDoelN4
         8JQySGsIaVR54ca6K1H0thLiBZUnZ6YZFTDPbl4zHE1CjzZHmsRZcPAVm9oS4AnAJh
         fJbACZFUMFoVraUfXYtCuk6uo3zR6vZ1izZwdyuQ=
Date:   Wed, 29 Jul 2020 17:53:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Move pci_info() after pci_fixup_device() in
 pci_setup_device()
Message-ID: <20200729225341.GA1973599@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595833615-8049-1-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 27, 2020 at 03:06:55PM +0800, Tiezhu Yang wrote:
> In the current code, we can not see the PCI info after fixup which is
> correct to reflect the reality, it is better to move pci_info() after
> pci_fixup_device() in pci_setup_device().
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Applied to pci/enumeration for v5.9, thanks!

> ---
>  drivers/pci/probe.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2f66988..7c046aed 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1802,9 +1802,6 @@ int pci_setup_device(struct pci_dev *dev)
>  	dev->revision = class & 0xff;
>  	dev->class = class >> 8;		    /* upper 3 bytes */
>  
> -	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
> -		   dev->vendor, dev->device, dev->hdr_type, dev->class);
> -
>  	if (pci_early_dump)
>  		early_dump_pci_device(dev);
>  
> @@ -1822,6 +1819,9 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* Early fixups, before probing the BARs */
>  	pci_fixup_device(pci_fixup_early, dev);
>  
> +	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
> +		 dev->vendor, dev->device, dev->hdr_type, dev->class);
> +
>  	/* Device class may be changed after fixup */
>  	class = dev->class >> 8;
>  
> -- 
> 2.1.0
> 
