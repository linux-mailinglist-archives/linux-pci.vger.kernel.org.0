Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D88D6C81FD
	for <lists+linux-pci@lfdr.de>; Fri, 24 Mar 2023 16:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjCXP7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Mar 2023 11:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCXP7Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Mar 2023 11:59:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E245D21949;
        Fri, 24 Mar 2023 08:59:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60D73B82553;
        Fri, 24 Mar 2023 15:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C7FC433D2;
        Fri, 24 Mar 2023 15:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679673560;
        bh=xGwOQJYL9ATXTak64Tua1D7KgP2UjQI73su8vDafpLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMHOivHkEdT/D1yzlfAOMcRvKQH9e5BYp8+MRJTSKkLOiFYLAyyDHCSfVOn7VQ6TQ
         x+2urpKwkGfLTyJJsGNe29Qgp5/FWs/QFeCsOqqv+zcncTuqoG3li8TsDBmXmCU1Vn
         KdvP3O8KVFQym1+m1syW+yChuCD0nDgmUTty4aboSkcL2oehMUsOmmU0nGj0ElcU9f
         zSO0Vv+P2NNa1SF18Nu0BIDxBtJV8W5297IbSI69/J/2vz4lC8DDwcQ739WIrDYnXY
         lu7+Swgjn9b8N1jTnIGfrnHsQxSgeCGJqxHrETX5ZF2DU0TTviPViT000mxsq2XFNy
         M6WqafZgh9JdQ==
Date:   Fri, 24 Mar 2023 16:59:14 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v2] PCI: imx6: Save and restore MSI control of RC in
 suspend and resume
Message-ID: <ZB3I0gpds8OH2+gx@lpieralisi>
References: <AS8PR04MB8676EC48C27C8A0DF8B35B648CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20230317222436.GA1978818@bhelgaas>
 <AS8PR04MB86765E47FE7AAECC121838188C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB86765E47FE7AAECC121838188C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 20, 2023 at 07:02:35AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2023年3月18日 6:25
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>; l.stach@pengutronix.de;
> > bhelgaas@google.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH v2] PCI: imx6: Save and restore MSI control of RC in suspend
> > and resume
> > 
> > On Fri, Mar 17, 2023 at 07:38:02AM +0000, Hongxing Zhu wrote:
> > > > -----Original Message-----
> > > > From: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > > Sent: 2023年3月16日 16:11
> > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > > Cc: Bjorn Helgaas <helgaas@kernel.org>; l.stach@pengutronix.de;
> > > > bhelgaas@google.com; linux-pci@vger.kernel.org;
> > > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > > kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> > > > Subject: Re: [PATCH v2] PCI: imx6: Save and restore MSI control of
> > > > RC in suspend and resume
> > > >
> > > > On Thu, Mar 16, 2023 at 07:37:41AM +0000, Hongxing Zhu wrote:
> > > >
> > > > [...]
> > > >
> > > > > > > > > It's not a separate register.
> > > > > > > > >
> > > > > > > > > The bit I manipulated is the MSI Enable bit of the Message
> > > > > > > > > Control Register for MSI (Offset 02h) contained in the
> > > > > > > > > MSI-capability of Root Complex.
> > > > > > > > >
> > > > > > > > > In addition, on i.MX6, the MSI Enable bit controls
> > > > > > > > > delivery of MSI interrupts from components below the Root Port.
> > > > > > > > >
> > > > > > > > > So, set MSI Enable in imx6q-pcie to let the MSI from
> > > > > > > > > downstream components works.
> > > > > > > >
> > > > > > > > My confusion is about this "MSI Capability" found by
> > > > > > > > "dw_pcie_find_capability(pci, PCI_CAP_ID_MSI)" in your patch.
> > > > > > > >
> > > > > > > > The i.MX6 manual might refer to that as an "MSI Capability"
> > > > > > > > but as far as I know, the PCIe base spec doesn't document a
> > > > > > > > Root Complex MSI
> > > > > > Capability.
> > > > > > > >
> > > > > > > > I don't think it's the same as the one documented in PCIe
> > > > > > > > r6.0, sec 7.7.2.  I think it's different because:
> > > > > > > >
> > > > > > > >   (1) I *think* "pci" here refers to the RC, not to a Root Port.
> > > > > > > >
> > > > > > > >   (2) The semantics are different.  The MSI-X Enable bit in 7.7.2 only
> > > > > > > >   determines whether the Function itself is permitted to use MSI-X.
> > > > > > > >   It has nothing to do with devices *below* a Root Port can
> > > > > > > > use
> > > > MSI-X.
> > > > > > > >   It also has nothing to do with whether a Root Port can forward MSI
> > > > > > > >   transactions from those downstream devices.
> > > > > > > >
> > > > > > > > This part of my confusion could be easily resolved via a comment.
> > > > > > > >
> > > > > > > > I do have a follow-on question, though: the patch seems to
> > > > > > > > enable MSI-related functionality using a register in the
> > > > > > > > DesignWare IP, not something in the i.MX6-specific IP.  If
> > > > > > > > that's true, why don't other DesignWare-based drivers need
> > > > > > > > something
> > > > similar?
> > > > > > > Hi Bjorn:
> > > > > > > Thanks a lot for you reply.
> > > > > > > This behavior is specific for i.MX PCIe.
> > > > > >
> > > > > > Which behaviour ? It can't be the root port MSI capability, that
> > > > > > would be a HW bug (ie disabling root port MSIs would imply
> > > > > > disabling MSIs for all downstream components).
> > > > > >
> > > > >
> > > > > i.MX PCIe designer use this MSI_EN bit to control the MSI trigger
> > > > > when integrate  Design Ware PCIe IP.
> > > > > Without the MSI_EN bit assertion (1b'1), the devices below this RC
> > > > > can't trigger  the MSI successfully.
> > > > > Yes, you're right. It should not be the root port MSI capability.
> > > >
> > > > The question is, it is or it is not the root port MSI capability ?
> > > >
> > > > If it is, that's a HW bug.
> > > >
> > > > If it is not there is nothing to do and this patch can be merged.
> > > Hi Lorenzo:
> > > Thanks for your reply.
> > > I think it is not the root port MSI capability actually.
> > > Refer to my understands, designer just use the msi_en bit to control
> > > the  delivery of MSI interrupts from components below the Root Port.
> > > >
> > > > > > > i.MX PCIe designer use this MSI_EN bit to control the MSI
> > > > > > > trigger when integrate Design Ware PCIe IP.
> > > > > >
> > > > > > Fair enough but that can't be the MSI Enable bit in the Root
> > > > > > Port MSI capability "Message Control" field I am afraid.
> > > > > >
> > > > > > It is what Bjorn mentioned quite clearly, a root complex
> > > > > > configuration register dressed as an MSI capability, the root
> > > > > > complex is not a PCI device; either that or that's an HW bug.
> > > > > Yes, it is. I agree with you. Had report this situation to the design team.
> > > > > Hope to correct this bug in HW design if it's possible.
> > > >
> > > > I don't understand if it is a HW bug or not, see above. I think it
> > > > is legitimate to have MMIO register space that *looks* like an MSI
> > > > capability for the root complex to control delivery of MSI
> > > > interrupts, as long as it is not the actual root port MSI
> > > > capability, in the root port PCI config space in which case this would be a HW
> > bug from what you are reporting.
> > > I just provide the following suggestions.
> > > - Root complex shouldn't have the MSI capability refer to the PCIe Spec
> > >   7.7.1 chapter.
> > > - Root port MSIs should not imply disabling MSIs for all downstream
> > components.
> > 
> > I think this is all a lot of confusion, mostly on my part, sorry about that.
> > 
> > Root Complex configuration and behavior is not specified by the PCIe spec, so
> > that's completely up to the i.MX designer.  It's fine for the Root Complex to have
> > an MSI Capability, and it's fine for that capability to enable/disable the RC fielding
> > of MSI MemWr transactions from downstream devices and triggering MSI
> > interrupts.
> > 
> > It's also fine for the RC MSI Capability to be identified with a Capability ID of 0x5,
> > although it is slightly confusing to use PCI_CAP_ID_MSI to find it.  It's also
> > slightly confusing to use the PCI_MSI_FLAGS offset into the RC MSI Capability.
> > 
> > Using the PCI_CAP_ID_MSI, PCI_MSI_FLAGS, and PCI_MSI_FLAGS_ENABLE
> > macros suggests to the reader that this RC MSI capability is the same as the the
> > MSI Capability defined by PCIe r6.0, sec 7.7.1.  Obviously it is *not* the same,
> > because we're talking about a *Root Complex* capability, while the sec 7.7.1
> > capability can only appear on PCIe functions (Root Ports, Endpoints, Switch Ports,
> > etc).
> > 
> > I suggest a comment to the effect that this is a Root Complex MSI Capability, not
> > the MSI Capability defined by PCIe r6.0, sec 7.7.1.
> > 
> > Possibly even add new #defines in pci-imx6.c with different names, even though
> > the values happen to be the same as the PCI_MSI_* #defines.  That would be a
> > convenient place to put a comment about what they are.
> Hi Bjorn:
> Thanks a lot for your dispelling doubts.
> How about to add the following comments in the new add function to clarify it?
> 
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1036,6 +1036,18 @@ static void pci_imx_set_msi_en(struct dw_pcie *pci)
>         u8 offset;
>         u16 val;
> 
> +       /*
> +        * When i.MX DM PCIe controller is configured as RC mode, it has one
> +        * MSI Capability Structure, although PCIe r6.0, sec 7.7.1 doesn't
> +        * specify the MSI Capability Structures for Root Complex.

That's because a PCI root complex is not a PCI device (and this is not
an MSI capability, which lives in PCI config space).

I will reword it (and the commit log with it) and merge it in the coming
weeks for v6.4

Thanks,
Lorenzo

> +        *
> +        * The MSI_EN bit of MSI control register contained in this MSI-CAP
> +        * is used control the MSI delivery of MSI interrupts from components
> +        * below the Root Port.
> +        *
> +        * Find it by PCI_CAP_ID_MSI here, and assert the MSI_EN bit to allow
> +        * the MSI delivery below the Root Port, if the PCI MSI is enabled.
> +        */
>         if (pci_msi_enabled()) {
>                 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
>                 dw_pcie_dbi_ro_wr_en(pci);
> Best Regards
> Richard Zhu
> > 
> > Bjorn
