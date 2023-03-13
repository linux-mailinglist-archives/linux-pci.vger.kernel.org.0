Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AF26B7FAF
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 18:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCMRtn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 13:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCMRtm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 13:49:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF1574319;
        Mon, 13 Mar 2023 10:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87603B811C1;
        Mon, 13 Mar 2023 17:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA70CC433EF;
        Mon, 13 Mar 2023 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678729771;
        bh=uZ944fvebVBRrhxHL1/hPWSo1vutOGaEdvPMMuzH59Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tKH+V1p6egqOdq3cqVXjnRXAJQ4Dh2zmtrYwYUQQrInVHr0MRJ7CTKcsc69haLhxj
         3DPw4AwN1hA4qg3T3YagR/ZixyemL4kf6CS1gMg/f188kdZXHo2GA+OPTVjkeRpDVm
         IdCjGekLWKDrxRTjbVSA6bxZX60BRtYIcJTVxCl2SShCOZn+KqiqfjeXRoDoIXHCeU
         ipouluNKPJHS47jeAgC++ITIZ9rTh4rczCI+Iv4NPooTwvNkGp7sfquIq2GCHt3KVr
         ObNHwgVy8KD5IG6CiDI/X6ZHWXFXPibebpUerpPAHWBjMjei7gHHkd3BS0C6NmDNIS
         A1ddKxwi7fUNA==
Date:   Mon, 13 Mar 2023 12:49:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Message-ID: <20230313174929.GA1509198@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB86763F096229D90DCBF6C0D08CB99@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 13, 2023 at 02:50:31AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Sent: 2023年3月11日 0:14
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v2] PCI: imx6: Save and restore MSI control of RC in
> > suspend and resume
> > 
> > On Mon, Jan 09, 2023 at 02:08:06AM +0000, Hongxing Zhu wrote:
> > > > -----Original Message-----
> > > > From: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > > Sent: 2022年12月30日 23:06
> > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>; l.stach@pengutronix.de;
> > > > bhelgaas@google.com
> > > > Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > > > <linux-imx@nxp.com>
> > > > Subject: Re: [PATCH v2] PCI: imx6: Save and restore MSI control of
> > > > RC in suspend and resume
> > > >
> > > > On Thu, Dec 08, 2022 at 02:05:34PM +0800, Richard Zhu wrote:
> > > > > The MSI Enable bit controls delivery of MSI interrupts from
> > > > > components below the Root Port. This bit might lost during the
> > > > > suspend, should be re-stored during resume.
> > > > >
> > > > > Save the MSI control during suspend, and restore it in resume.
> > > >
> > > > I believe that what Lucas and Bjorn asked on v1 is still not answered.
> > > >
> > > > The root port is a PCI device, why do we need to save and restore
> > > > the MSI cap on top of what PCI core already does ? The RP should be
> > > > enumerated as a PCI device and therefore I expect the MSI cap to be
> > > > saved/restored in the suspend/resume execution.
> > > >
> > > > I don't think there is anything iMX6 specific in this.
> > > Hi Lorenzo:
> > > Thanks for your comments.
> > > Sorry to reply late, since I got a high fever in the past days.
> > >
> > > Based on i.MX6QP SABRESD board and XHCI PCIe2USB3.0 device, the MSI
> > > cap  save/restore of PCI core is not executed(dev->msi_enabled is
> > > zero)  during my suspend/resume tests.
> > 
> > I still do not understand. The register you are saving/restoring in the RC is not
> > the root port Message control field in the root port MSI capability, it is a
> > separate register that controls the root complex MSI forwarding, is that
> > correct ?
> > 
> > The root port MSI capability does not control the root complex forwarding of
> > MSIs TLPs.
> > 
> > So the bits you are saving and restoring IIUC should be MMIO space in the
> > root complex, dressed as an MSI capability, that has nothing to do with the
> > root port MSI capability.
> > 
> > Is that correct ?
>
> It's not a separate register.
>
> The bit I manipulated is the MSI Enable bit of the Message Control
> Register for MSI (Offset 02h) contained in the MSI-capability of
> Root Complex.
>
> In addition, on i.MX6, the MSI Enable bit controls delivery of MSI
> interrupts from components below the Root Port.
>
> So, set MSI Enable in imx6q-pcie to let the MSI from downstream
> components works.

My confusion is about this "MSI Capability" found by
"dw_pcie_find_capability(pci, PCI_CAP_ID_MSI)" in your patch.

The i.MX6 manual might refer to that as an "MSI Capability" but as far
as I know, the PCIe base spec doesn't document a Root Complex MSI
Capability.

I don't think it's the same as the one documented in PCIe r6.0, sec
7.7.2.  I think it's different because:

  (1) I *think* "pci" here refers to the RC, not to a Root Port.

  (2) The semantics are different.  The MSI-X Enable bit in 7.7.2 only
  determines whether the Function itself is permitted to use MSI-X.
  It has nothing to do with devices *below* a Root Port can use MSI-X.
  It also has nothing to do with whether a Root Port can forward MSI
  transactions from those downstream devices.

This part of my confusion could be easily resolved via a comment.

I do have a follow-on question, though: the patch seems to enable
MSI-related functionality using a register in the DesignWare IP, not
something in the i.MX6-specific IP.  If that's true, why don't other
DesignWare-based drivers need something similar?

> > > It seems that some device might shutdown msi when do the suspend
> > operations.
> > > >
> > > > Would you mind investigating it please ?
> > > Sure, I did further investigation on i.MX6QP platform.
> > > The MSI_EN bit of RC MSI capability would be cleared to zero, when
> > >  PCIE_RESET(BIT29 of IOMUXC_GPR1) is toggled (assertion 1b'1,  then
> > > de-assertion 1b'0).
> > >
> > > Verification steps:
> > > MSI_EN of RC is set to 1b'1 when system is boot up.
> > >  ./memtool 1ffc050 1
> > > 0x01FFC050:  01017005
> > >
> > > Toggle PCIe reset of i.MX6QP.
> > > root@imx6qpdlsolox:~# ./memtool 20e0004=68691005 Writing 32-bit value
> > > 0x68691005 to address 0x020E0004 root@imx6qpdlsolox:~# ./memtool
> > > 20e0004=48691005 Writing 32-bit value 0x48691005 to address
> > 0x020E0004
> > >
> > > The MSI_EN bit of RC had been cleared to 1b'0.
> > > ./memtool 1ffc050 1
> > > 0x01FFC050:  01807005
> > >
> > > This is why I used to reply to Bjorn the MSI_EN of RC is cleared when
> > > RESETs are toggled during the imx6_pcie_host_init() in
> > >  imx6_pcie_resume_noirq() callback.
> > >
> > > Best Regards
> > > Richard Zhu
> > > >
> > > > Lorenzo
> > > >
> > > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > ---
> > > > > Changes v1-->v2:
> > > > > New create one save/restore function, used save the setting in
> > > > > suspend and restore the configuration in resume.
> > > > > v1
> > > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > > >
> > patc%2F&data=05%7C01%7Chongxing.zhu%40nxp.com%7C24971d8de9b54b
> > 0b10
> > > > >
> > ad08db2182774d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> > 38140
> > > > >
> > 616456052078%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> > QIjoiV
> > > > >
> > 2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=vE
> > tRxL
> > > > > BVi5lYmpwTNZfafMms3263LZXodneLChjEaOM%3D&reserved=0
> > > > >
> > > >
> > hwork.kernel.org%2Fproject%2Flinux-pci%2Fpatch%2F1667289595-12440-1-
> > > > g
> > > > i
> > > > >
> > > >
> > t-send-email-hongxing.zhu%40nxp.com%2F&data=05%7C01%7Chongxing.zhu
> > > > %40n
> > > > >
> > > >
> > xp.com%7C3aeb1d128f854dad1a5608daea77706d%7C686ea1d3bc2b4c6fa9
> > 2
> > > > cd99c5c
> > > > >
> > > >
> > 301635%7C0%7C0%7C638080095954881374%7CUnknown%7CTWFpbGZsb3
> > > > d8eyJWIjoiMC
> > > > >
> > > >
> > 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> > %
> > > > 7C%7C%
> > > > >
> > > >
> > 7C&sdata=V8yVvvpTKGoR1UyQP5HD2IdlSjJdznBeD12bdI67dEI%3D&reserved
> > =
> > > > 0
> > > > >
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pci-imx6.c | 23
> > > > > +++++++++++++++++++++++
> > > > >  1 file changed, 23 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > index 1dde5c579edc..aa3096890c3b 100644
> > > > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > @@ -76,6 +76,7 @@ struct imx6_pcie {
> > > > >  	struct clk		*pcie;
> > > > >  	struct clk		*pcie_aux;
> > > > >  	struct regmap		*iomuxc_gpr;
> > > > > +	u16			msi_ctrl;
> > > > >  	u32			controller_id;
> > > > >  	struct reset_control	*pciephy_reset;
> > > > >  	struct reset_control	*apps_reset;
> > > > > @@ -1042,6 +1043,26 @@ static void imx6_pcie_pm_turnoff(struct
> > > > imx6_pcie *imx6_pcie)
> > > > >  	usleep_range(1000, 10000);
> > > > >  }
> > > > >
> > > > > +static void imx6_pcie_msi_save_restore(struct imx6_pcie
> > > > > +*imx6_pcie, bool save) {
> > > > > +	u8 offset;
> > > > > +	u16 val;
> > > > > +	struct dw_pcie *pci = imx6_pcie->pci;
> > > > > +
> > > > > +	if (pci_msi_enabled()) {
> > > > > +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> > > > > +		if (save) {
> > > > > +			val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> > > > > +			imx6_pcie->msi_ctrl = val;
> > > > > +		} else {
> > > > > +			dw_pcie_dbi_ro_wr_en(pci);
> > > > > +			val = imx6_pcie->msi_ctrl;
> > > > > +			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
> > > > > +			dw_pcie_dbi_ro_wr_dis(pci);
> > > > > +		}
> > > > > +	}
> > > > > +}
> > > > > +
> > > > >  static int imx6_pcie_suspend_noirq(struct device *dev)  {
> > > > >  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev); @@ -1050,6
> > > > > +1071,7 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
> > > > >  	if (!(imx6_pcie->drvdata->flags &
> > > > IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
> > > > >  		return 0;
> > > > >
> > > > > +	imx6_pcie_msi_save_restore(imx6_pcie, true);
> > > > >  	imx6_pcie_pm_turnoff(imx6_pcie);
> > > > >  	imx6_pcie_stop_link(imx6_pcie->pci);
> > > > >  	imx6_pcie_host_exit(pp);
> > > > > @@ -1069,6 +1091,7 @@ static int imx6_pcie_resume_noirq(struct
> > > > > device
> > > > *dev)
> > > > >  	ret = imx6_pcie_host_init(pp);
> > > > >  	if (ret)
> > > > >  		return ret;
> > > > > +	imx6_pcie_msi_save_restore(imx6_pcie, false);
> > > > >  	dw_pcie_setup_rc(pp);
> > > > >
> > > > >  	if (imx6_pcie->link_is_up)
> > > > > --
> > > > > 2.25.1
