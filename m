Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE9E768061
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jul 2023 17:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjG2PcG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jul 2023 11:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjG2PcG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jul 2023 11:32:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6762D71;
        Sat, 29 Jul 2023 08:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AB7D60C74;
        Sat, 29 Jul 2023 15:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B561C433C8;
        Sat, 29 Jul 2023 15:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690644723;
        bh=arfJjyoj6bnNUk+Ht4kjfA6xcBR5noSAdP8ZO3gscJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Us2BtoP8txnTyyPyHwIip329r1qowNU9zbHkrYzoOpNyMK3BtCffb1gOO6sSEU4CB
         9eJzSQxy+kSEm65Yw2gicWP2pvmqTHcaXvIdh8HMTEeAzc1Y6lF0VbcwK7DHkMigSJ
         ZqWJGFWPdpKIqx7DFdvsrbf+vndkded0ZMXLHMTAq1pSLeLLmnvZIL8FrvlSNuhKQX
         IseoWyrplGS3dTjUT/XdB+MKFpHmy3vTXF4y9j7NF1UFfCfR/dTxhj2WV9DQK06QjO
         J++k5bZs8Om6iAw8Bxb7YRJ9iLiw6j/u8UPZsn0Ju9kbyrciqZhnIOQNi61FsC10n6
         b5dGfVpTFZeFA==
Date:   Sat, 29 Jul 2023 10:32:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v18 02/20] PCI: Rename PCI_EPC_IRQ_LEGACY to
 PCI_EPC_IRQ_INTX
Message-ID: <20230729153201.GA852521@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dea62385-7f3a-9396-dcec-4a743bda0fca@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 29, 2023 at 10:58:46AM +0900, Damien Le Moal wrote:
> On 7/29/23 10:55, Damien Le Moal wrote:
> > On 7/29/23 10:35, Serge Semin wrote:
> >> On Mon, Jul 24, 2023 at 01:02:11PM +0530, Manivannan Sadhasivam wrote:
> >>> On Fri, Jul 21, 2023 at 05:10:27PM +0900, Damien Le Moal wrote:
> >>>> On 7/21/23 16:44, Yoshihiro Shimoda wrote:
> >>>>> Using "INTx" instead of "legacy" is more specific. So, rename
> >>>>> PCI_EPC_IRQ_LEGACY to PCI_EPC_IRQ_INTX.
> >>>>>
> >>>>> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> >>>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >>>>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> >>>>> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com> # ARTPEC
> >>>>> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> >>>>
> >>
> >>>> I would rather drop completely the PCI_EPC_IRQ_XXX enum and simply use the
> >>>> PCI_IRQ_XXX macros used everywhere. Less definitions :)
> >>>>
> >>>> See attached patch that I have in my queue (about to send that).
> >>>>
> >>>
> >>> It looks better! This patch should be dropped.
> >>
> >> Back then Bjorn specifically asked to change the names suffix in a
> >> preparation patch before adding the INTx support to the DW PCIe core
> >> driver (see the Sb tag in the patch log). Damien, seeing you cleanup
> >> the names anyway what about fixing the macro suffix too: INTx instead
> >> of LEGACY)?
> > 
> > Sure, I can do that. That is going to be a gigantic patch though given that
> > PCI_IRQ_LEGACY is used well beyond the ep/pcie controller drivers.
> > While I agree it would be nice to do, not sure it is worth such code churn.
> > 
> >> Mani, Damien, what do you suggest to Yoshihiro to do with the
> >> LEGACY/INTx names in the following up patches of this series?
> > 
> > If everyone is OK with the patch I proposed (the PCI_IRQ_LEGACY -> PCI_IRQ_INTx
> > change can go on top), then I can rebase it and send it next week (the remaining
> > of my EP cleanup series needs some more testing & rebasing). Yoshihiro can
> > either include it in his series or rebase on it if the patch is added to
> > pci-next quickly.
> 
> Note that we could start by simply defining an alias:
> 
> #define PCI_IRQ_INTx	PCI_IRQ_LEGACY
> 
> and gradually convert all drivers using it until we can get rid of PCI_IRQ_LEGACY.

I try to catch additions of "legacy," e.g., in new drivers, but I
agree this patch looks like it might be more churn than it's worth.

But I like your idea of an alias, Damien.  Maybe something like the
below to make it more obvious that the preferred usage is the "INTX"
form.

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 5cb694031072..6c0bb4c5d12e 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -21,11 +21,13 @@ enum pci_epc_interface_type {
 
 enum pci_epc_irq_type {
 	PCI_EPC_IRQ_UNKNOWN,
-	PCI_EPC_IRQ_LEGACY,
+	PCI_EPC_IRQ_INTX,
 	PCI_EPC_IRQ_MSI,
 	PCI_EPC_IRQ_MSIX,
 };
 
+#define PCI_EPC_IRQ_LEGACY	PCI_EPC_IRQ_INTX
+
 static inline const char *
 pci_epc_interface_string(enum pci_epc_interface_type type)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c69a2cc1f412..6638e0cd487f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1048,11 +1048,13 @@ enum {
 	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
 };
 
-#define PCI_IRQ_LEGACY		(1 << 0) /* Allow legacy interrupts */
+#define PCI_IRQ_INTX		(1 << 0) /* Allow INTx interrupts */
 #define PCI_IRQ_MSI		(1 << 1) /* Allow MSI interrupts */
 #define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
 #define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
 
+#define PCI_IRQ_LEGACY 		PCI_IRQ_INTX	/* prefer PCI_IRQ_INTX */
+
 /* These external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
