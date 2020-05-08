Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD901CB7A3
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 20:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgEHSvk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 14:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgEHSvk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 May 2020 14:51:40 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5A3A207DD;
        Fri,  8 May 2020 18:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588963900;
        bh=G0Uu5w3eBIja3ZOupFgWdBHmfnHRekLsvyYCif+pd5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kDmaDXrDaXsYKLqNvQ8A9gMAks0N3gYY6dGxvuPenkkFVJspAtgDNT5yoaYzeOZO0
         ZcyCjsy2Mo8mAsdsNISutBNbPmgWdxZPKktHB3gs2XbvNolR8NI2jma/Pyq3XUr/08
         YupB9oKpgmffnkJN7SxqrHjzqmLOT/1d9tCa0Z0k=
Date:   Fri, 8 May 2020 13:51:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] PCI: Don't disable decoding when mmio_always_on
 is set
Message-ID: <20200508185138.GA78849@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428011429.1852081-2-jiaxun.yang@flygoat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 28, 2020 at 09:14:16AM +0800, Jiaxun Yang wrote:
> Don't disable MEM/IO decoding when a device have both non_compliant_bars
> and mmio_always_on.
> 
> That would allow us quirk devices with junk in BARs but can't disable
> their decoding.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 77b8a145c39b..d9c2c3301a8a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1822,7 +1822,7 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* Device class may be changed after fixup */
>  	class = dev->class >> 8;
>  
> -	if (dev->non_compliant_bars) {
> +	if (dev->non_compliant_bars && !dev->mmio_always_on) {
>  		pci_read_config_word(dev, PCI_COMMAND, &cmd);
>  		if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
>  			pci_info(dev, "device has non-compliant BARs; disabling IO/MEM decoding\n");
> -- 
> 2.26.0.rc2
> 
