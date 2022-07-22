Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943E457E792
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 21:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbiGVTmb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 15:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbiGVTmb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 15:42:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5024E63910;
        Fri, 22 Jul 2022 12:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4A7A61CCD;
        Fri, 22 Jul 2022 19:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147FFC341C7;
        Fri, 22 Jul 2022 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658518948;
        bh=Fi3NukUa0s7paqp1AppHpb7xH6EkFSvBVVmsZhvKYTk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rFv0h19MGL224aUJD6l6QxUs1iMM8NJAKMFxa+00aGnmLJYSgh6FtethmrthvMVPw
         wxGbICw6AbhrNccaZqQfSsDZhZM7VlGHfsNWQtIsJE05cjur50XXxk+rJcm1hFkayj
         i3jlA+LhD/FYT12xHKUWrFuXHTdmR0y+6E0/2huC+/Xh/O5brtkNAviQO8T6U6G2PN
         RC4PK5HD5iPfMQY5AMXPVln+etO7eiBgag2H+CJfeW6LhLKgjdxD6oByFrR2MYKkUn
         SV8YbXGLDXefMS60dgecc/W73x79Yg13KuDUWmxpX4ZmZRLL1KJ5SWeUMuCWqZeKWI
         JRps0I6Yh342A==
Date:   Fri, 22 Jul 2022 14:42:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/fsl-pci: Fix Class Code of PCIe Root Port
Message-ID: <20220722194226.GA1927257@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706101043.4867-1-pali@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 06, 2022 at 12:10:43PM +0200, Pali Rohár wrote:
> By default old pre-3.0 Freescale PCIe controllers reports invalid PCI Class
> Code 0x0b20 for PCIe Root Port. It can be seen by lspci -b output on P2020
> board which has this pre-3.0 controller:
> 
>   $ lspci -bvnn
>   00:00.0 Power PC [0b20]: Freescale Semiconductor Inc P2020E [1957:0070] (rev 21)
>           !!! Invalid class 0b20 for header type 01
>           Capabilities: [4c] Express Root Port (Slot-), MSI 00
> 
> Fix this issue by programming correct PCI Class Code 0x0604 for PCIe Root
> Port to the Freescale specific PCIe register 0x474.
> 
> With this change lspci -b output is:
> 
>   $ lspci -bvnn
>   00:00.0 PCI bridge [0604]: Freescale Semiconductor Inc P2020E [1957:0070] (rev 21) (prog-if 00 [Normal decode])
>           Capabilities: [4c] Express Root Port (Slot-), MSI 00
> 
> Without any "Invalid class" error. So class code was properly reflected
> into standard (read-only) PCI register 0x08.
> 
> Same fix is already implemented in U-Boot pcie_fsl.c driver in commit:
> http://source.denx.de/u-boot/u-boot/-/commit/d18d06ac35229345a0af80977a408cfbe1d1015b
> 
> Fix activated by U-Boot stay active also after booting Linux kernel.
> But boards which use older U-Boot version without that fix are affected and
> still require this fix.
> 
> So implement this class code fix also in kernel fsl_pci.c driver.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Pali Rohár <pali@kernel.org>

I assume the powerpc folks will take care of this.

> ---
>  arch/powerpc/sysdev/fsl_pci.c | 8 ++++++++
>  arch/powerpc/sysdev/fsl_pci.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 1011cfea2e32..bfbb8c8fc9aa 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -521,6 +521,7 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
>  	struct resource rsrc;
>  	const int *bus_range;
>  	u8 hdr_type, progif;
> +	u32 class_code;
>  	struct device_node *dev;
>  	struct ccsr_pci __iomem *pci;
>  	u16 temp;
> @@ -594,6 +595,13 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
>  			PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
>  		if (fsl_pcie_check_link(hose))
>  			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> +		/* Fix Class Code to PCI_CLASS_BRIDGE_PCI_NORMAL for pre-3.0 controller */
> +		if (in_be32(&pci->block_rev1) < PCIE_IP_REV_3_0) {
> +			early_read_config_dword(hose, 0, 0, PCIE_FSL_CSR_CLASSCODE, &class_code);
> +			class_code &= 0xff;
> +			class_code |= PCI_CLASS_BRIDGE_PCI_NORMAL << 8;
> +			early_write_config_dword(hose, 0, 0, PCIE_FSL_CSR_CLASSCODE, class_code);
> +		}
>  	} else {
>  		/*
>  		 * Set PBFR(PCI Bus Function Register)[10] = 1 to
> diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
> index cdbde2e0c96e..093a875d7d1e 100644
> --- a/arch/powerpc/sysdev/fsl_pci.h
> +++ b/arch/powerpc/sysdev/fsl_pci.h
> @@ -18,6 +18,7 @@ struct platform_device;
>  
>  #define PCIE_LTSSM	0x0404		/* PCIE Link Training and Status */
>  #define PCIE_LTSSM_L0	0x16		/* L0 state */
> +#define PCIE_FSL_CSR_CLASSCODE	0x474	/* FSL GPEX CSR */
>  #define PCIE_IP_REV_2_2		0x02080202 /* PCIE IP block version Rev2.2 */
>  #define PCIE_IP_REV_3_0		0x02080300 /* PCIE IP block version Rev3.0 */
>  #define PIWAR_EN		0x80000000	/* Enable */
> -- 
> 2.20.1
> 
