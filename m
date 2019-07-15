Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E5B6971A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2019 17:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbfGOPIp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jul 2019 11:08:45 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38991 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733095AbfGOPIo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2019 11:08:44 -0400
X-Originating-IP: 92.137.69.152
Received: from windsurf (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A1411C0004;
        Mon, 15 Jul 2019 15:08:41 +0000 (UTC)
Date:   Mon, 15 Jul 2019 17:08:40 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Grzegorz Jaszczyk <jaz@semihalf.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH] PCI: aardvark: fix big endian support
Message-ID: <20190715170840.326acd73@windsurf>
In-Reply-To: <1563200122-8323-1-git-send-email-jaz@semihalf.com>
References: <1563200122-8323-1-git-send-email-jaz@semihalf.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Grzegorz,

Thanks for this work. I indeed never tested this code on BE platforms,
and it is very possible that I overlooked endianness issues, so thanks
for having a look at this and proposing some patches. See some
questions/comments below.

On Mon, 15 Jul 2019 16:15:22 +0200
Grzegorz Jaszczyk <jaz@semihalf.com> wrote:

> Initialise every not-byte wide fields of emulated pci bridge config
> space with proper cpu_to_le* macro. This is required since the structure
> describing config space of emulated bridge assumes little-endian
> convention.
> 
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> ---
>  drivers/pci/controller/pci-aardvark.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 134e030..06a12749 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -479,8 +479,10 @@ static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>  {
>  	struct pci_bridge_emul *bridge = &pcie->bridge;
>  
> -	bridge->conf.vendor = advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff;
> -	bridge->conf.device = advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >> 16;
> +	bridge->conf.vendor =
> +		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff);
> +	bridge->conf.device =
> +		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >> 16);
>  	bridge->conf.class_revision =
>  		advk_readl(pcie, PCIE_CORE_DEV_REV_REG) & 0xff;

So conf.vendor and conf.device and stored as little-endian in the
emulated config address space, but conf.class_revision is stored in the
CPU endianness ?

>  
> @@ -489,8 +491,8 @@ static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>  	bridge->conf.iolimit = PCI_IO_RANGE_TYPE_32;

>  
>  	/* Support 64 bits memory pref */
> -	bridge->conf.pref_mem_base = PCI_PREF_RANGE_TYPE_64;
> -	bridge->conf.pref_mem_limit = PCI_PREF_RANGE_TYPE_64;
> +	bridge->conf.pref_mem_base = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
> +	bridge->conf.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);

Same here: why are conf.pref_mem_{base,limit} converted to LE, but not
conf.iolimit ?

Also, the advk_pci_bridge_emul_pcie_conf_read() and
advk_pci_bridge_emul_pcie_conf_write() return values that are in the
CPU endianness.

Am I missing something ?

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
