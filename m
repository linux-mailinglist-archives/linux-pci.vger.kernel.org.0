Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8885B7683C4
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jul 2023 06:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjG3E6r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Jul 2023 00:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3E6q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jul 2023 00:58:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8EF19A5;
        Sat, 29 Jul 2023 21:58:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E95360B3F;
        Sun, 30 Jul 2023 04:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081D1C433C7;
        Sun, 30 Jul 2023 04:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690693123;
        bh=/9Vkfs2EdzwYMbbblvQSvnNQ17Onc4iF0/Npucm3JXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ic3cXX5tPc0ChQdbGnh3a6oHYM8gscwM8gqwf0caR5BUqdsEsEklb6KRagF0DdPI0
         mCMCtxe58Q5gNypWX5PLgqF2B0HXqO2lyEzkJzBBIg4DPcV425nJXvt0jbdW9ofedJ
         DAFiefxjYvNhmdozXbMpXuN12lxgFZA+EXCLee2PiYZFC7a4QR0fslurbQGK0f9+pL
         EtWY8ooWd66RbkrvLZPC1DAuz3oKTyix4SqVl7AWNj/nc0lEa5q+RpKk1NkAJerfwH
         WuA+ZxCNuvLCRMvVBsf5rkUs63ZtX/HOP3uP2SK0G7rYbb+ZND6hObsWpZVVcgp00Y
         rnfj3YFY6nEIA==
Date:   Sun, 30 Jul 2023 10:28:28 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
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
Message-ID: <20230730045828.GA20264@thinkpad>
References: <dea62385-7f3a-9396-dcec-4a743bda0fca@kernel.org>
 <20230729153201.GA852521@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230729153201.GA852521@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 29, 2023 at 10:32:01AM -0500, Bjorn Helgaas wrote:
> On Sat, Jul 29, 2023 at 10:58:46AM +0900, Damien Le Moal wrote:
> > On 7/29/23 10:55, Damien Le Moal wrote:
> > > On 7/29/23 10:35, Serge Semin wrote:
> > >> On Mon, Jul 24, 2023 at 01:02:11PM +0530, Manivannan Sadhasivam wrote:
> > >>> On Fri, Jul 21, 2023 at 05:10:27PM +0900, Damien Le Moal wrote:
> > >>>> On 7/21/23 16:44, Yoshihiro Shimoda wrote:
> > >>>>> Using "INTx" instead of "legacy" is more specific. So, rename
> > >>>>> PCI_EPC_IRQ_LEGACY to PCI_EPC_IRQ_INTX.
> > >>>>>
> > >>>>> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > >>>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > >>>>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > >>>>> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com> # ARTPEC
> > >>>>> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > >>>>
> > >>
> > >>>> I would rather drop completely the PCI_EPC_IRQ_XXX enum and simply use the
> > >>>> PCI_IRQ_XXX macros used everywhere. Less definitions :)
> > >>>>
> > >>>> See attached patch that I have in my queue (about to send that).
> > >>>>
> > >>>
> > >>> It looks better! This patch should be dropped.
> > >>
> > >> Back then Bjorn specifically asked to change the names suffix in a
> > >> preparation patch before adding the INTx support to the DW PCIe core
> > >> driver (see the Sb tag in the patch log). Damien, seeing you cleanup
> > >> the names anyway what about fixing the macro suffix too: INTx instead
> > >> of LEGACY)?
> > > 
> > > Sure, I can do that. That is going to be a gigantic patch though given that
> > > PCI_IRQ_LEGACY is used well beyond the ep/pcie controller drivers.
> > > While I agree it would be nice to do, not sure it is worth such code churn.
> > > 
> > >> Mani, Damien, what do you suggest to Yoshihiro to do with the
> > >> LEGACY/INTx names in the following up patches of this series?
> > > 
> > > If everyone is OK with the patch I proposed (the PCI_IRQ_LEGACY -> PCI_IRQ_INTx
> > > change can go on top), then I can rebase it and send it next week (the remaining
> > > of my EP cleanup series needs some more testing & rebasing). Yoshihiro can
> > > either include it in his series or rebase on it if the patch is added to
> > > pci-next quickly.
> > 
> > Note that we could start by simply defining an alias:
> > 
> > #define PCI_IRQ_INTx	PCI_IRQ_LEGACY
> > 
> > and gradually convert all drivers using it until we can get rid of PCI_IRQ_LEGACY.
> 
> I try to catch additions of "legacy," e.g., in new drivers, but I
> agree this patch looks like it might be more churn than it's worth.
> 
> But I like your idea of an alias, Damien.  Maybe something like the
> below to make it more obvious that the preferred usage is the "INTX"
> form.

Looks good to me. I'd prefer to merge these (Damien's) patches first and let
Yoshihiro rebase on top of pci-next instead of clubbing everything in a single
series.

- Mani

> 
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 5cb694031072..6c0bb4c5d12e 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -21,11 +21,13 @@ enum pci_epc_interface_type {
>  
>  enum pci_epc_irq_type {
>  	PCI_EPC_IRQ_UNKNOWN,
> -	PCI_EPC_IRQ_LEGACY,
> +	PCI_EPC_IRQ_INTX,
>  	PCI_EPC_IRQ_MSI,
>  	PCI_EPC_IRQ_MSIX,
>  };
>  
> +#define PCI_EPC_IRQ_LEGACY	PCI_EPC_IRQ_INTX
> +
>  static inline const char *
>  pci_epc_interface_string(enum pci_epc_interface_type type)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c69a2cc1f412..6638e0cd487f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1048,11 +1048,13 @@ enum {
>  	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
>  };
>  
> -#define PCI_IRQ_LEGACY		(1 << 0) /* Allow legacy interrupts */
> +#define PCI_IRQ_INTX		(1 << 0) /* Allow INTx interrupts */
>  #define PCI_IRQ_MSI		(1 << 1) /* Allow MSI interrupts */
>  #define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
>  #define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
>  
> +#define PCI_IRQ_LEGACY 		PCI_IRQ_INTX	/* prefer PCI_IRQ_INTX */
> +
>  /* These external functions are only available when PCI support is enabled */
>  #ifdef CONFIG_PCI
>  

-- 
மணிவண்ணன் சதாசிவம்
