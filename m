Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C22489E03
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 18:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbiAJRHI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jan 2022 12:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbiAJRHI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jan 2022 12:07:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435A8C06173F
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 09:07:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D768761346
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 17:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F131AC36AE3;
        Mon, 10 Jan 2022 17:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641834427;
        bh=uSRmcrk/rMxc6Y0vOkh+x1pTujA0vIxTYCIx+RH6btk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XveBlLt+2AAkV+nD+QRtSqZ/vXLxzSuzYJL3V0LaWr8pJ8YEwOA7tFEJa2osk+aP8
         6aVxOgWtkmzUpBHkO0UW43wPD0dvZTYZVjlTwqwRXNVSEZnOr+82lWnzG0ZVDyKDpK
         H01spAQ4paisJjYOKj95Bh9LDrGoBHyUD3OhnGsgGP678BPj2xmiSExRXzF+WA8bJG
         gMrCefqYApruZVsgRprxTdFXl2ybDJcae6r3FNNGx6wr49HIQ1OS5yTAA20rYPw6On
         tM9lk4oOU+fLmDN8FAkfhs0X5P1TAheCHtiwVdVMaD1+4G/KdPhitUERUjD26QBDNb
         rd8i0tff9gVVw==
Date:   Mon, 10 Jan 2022 11:07:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/23] PCI: aardvark: Replace custom PCIE_CORE_INT_*
 macros with PCI_INTERRUPT_*
Message-ID: <20220110170704.GA60160@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220110015018.26359-2-kabel@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 10, 2022 at 02:49:56AM +0100, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Header file linux/pci.h defines enum pci_interrupt_pin with corresponding
> PCI_INTERRUPT_* values.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

> ---
>  drivers/pci/controller/pci-aardvark.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index ec0df426863d..62baddd2ca95 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -39,10 +39,6 @@
>  #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX_EN			BIT(6)
>  #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHCK			BIT(7)
>  #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHCK_RCV			BIT(8)
> -#define     PCIE_CORE_INT_A_ASSERT_ENABLE			1
> -#define     PCIE_CORE_INT_B_ASSERT_ENABLE			2
> -#define     PCIE_CORE_INT_C_ASSERT_ENABLE			3
> -#define     PCIE_CORE_INT_D_ASSERT_ENABLE			4
>  /* PIO registers base address and register offsets */
>  #define PIO_BASE_ADDR				0x4000
>  #define PIO_CTRL				(PIO_BASE_ADDR + 0x0)
> @@ -968,7 +964,7 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>  	bridge->conf.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
>  
>  	/* Support interrupt A for MSI feature */
> -	bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;
> +	bridge->conf.intpin = PCI_INTERRUPT_INTA;
>  
>  	/* Aardvark HW provides PCIe Capability structure in version 2 */
>  	bridge->pcie_conf.cap = cpu_to_le16(2);
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
