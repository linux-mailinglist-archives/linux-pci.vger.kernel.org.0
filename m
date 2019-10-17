Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC565DAC97
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 14:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502480AbfJQMo2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 08:44:28 -0400
Received: from [217.140.110.172] ([217.140.110.172]:41754 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2502502AbfJQMo1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 08:44:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34E741993;
        Thu, 17 Oct 2019 05:44:05 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D59D3F6C4;
        Thu, 17 Oct 2019 05:44:04 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:43:59 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Grzegorz Jaszczyk <jaz@semihalf.com>
Cc:     thomas.petazzoni@bootlin.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com
Subject: Re: [PATCH v2] PCI: aardvark: fix big endian support
Message-ID: <20191017124359.GA19340@e121166-lin.cambridge.arm.com>
References: <1563279127-30678-1-git-send-email-jaz@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563279127-30678-1-git-send-email-jaz@semihalf.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 16, 2019 at 02:12:07PM +0200, Grzegorz Jaszczyk wrote:
> Initialise every not-byte wide fields of emulated pci bridge config
> space with proper cpu_to_le* macro. This is required since the structure
> describing config space of emulated bridge assumes little-endian
> convention.
> 
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> ---
> v1->v2
> - add missing cpu_to_le32 for class_revison assignment (issues found by
> Thomas Petazzoni and also detected by Sparse tool).
> 
>  drivers/pci/controller/pci-aardvark.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Applied to pci/aardvark, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 134e030..178e92f 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -479,18 +479,20 @@ static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
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
> -		advk_readl(pcie, PCIE_CORE_DEV_REV_REG) & 0xff;
> +		cpu_to_le32(advk_readl(pcie, PCIE_CORE_DEV_REV_REG) & 0xff);
>  
>  	/* Support 32 bits I/O addressing */
>  	bridge->conf.iobase = PCI_IO_RANGE_TYPE_32;
>  	bridge->conf.iolimit = PCI_IO_RANGE_TYPE_32;
>  
>  	/* Support 64 bits memory pref */
> -	bridge->conf.pref_mem_base = PCI_PREF_RANGE_TYPE_64;
> -	bridge->conf.pref_mem_limit = PCI_PREF_RANGE_TYPE_64;
> +	bridge->conf.pref_mem_base = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
> +	bridge->conf.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
>  
>  	/* Support interrupt A for MSI feature */
>  	bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;
> -- 
> 2.7.4
> 
