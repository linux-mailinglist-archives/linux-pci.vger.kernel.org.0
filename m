Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8375C6B4C9F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 17:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjCJQTY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 11:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjCJQSm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 11:18:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA4A11D09A;
        Fri, 10 Mar 2023 08:14:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC98B61A55;
        Fri, 10 Mar 2023 16:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365B5C433D2;
        Fri, 10 Mar 2023 16:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678464841;
        bh=SdJT48pgc55q+97r4QIUR5Ti78tRUtjjYX4LSxKMjw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j34HYphsqG7xv3mGnAdN/TcMjnD/3nh6wolAOf+Xp+8jhuP2lqzIU0hXn6bd/w0l6
         +CEprugPD1ouuUNV6XGn+5vWv3MkuVdrnhp2hqa9WKO3u8UqXWo8g9Qr80og/3PFGA
         qbnva7T1Qvk0jr3FE8mhYUCYj0LCk7QdOt8Tt9xowWBadeXnGnKwEjzHIfxruTr/ky
         b7DJ8cna3IqDMT/rfdz6iraDqFvgK1R2UWA8UDYbwWJz2iDPr48TwteIAD2MHJdq4q
         TAslpG3DVzCW+cUr7kilKN6BHQva1zLTSCcPNWqOfzomICgXxaOxvlS/6vs9Nsiq5r
         QgH/gU9mHdQ2Q==
Date:   Fri, 10 Mar 2023 17:13:56 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v2] PCI: imx6: Save and restore MSI control of RC in
 suspend and resume
Message-ID: <ZAtXRNuTenBAUZEd@lpieralisi>
References: <1670479534-22154-1-git-send-email-hongxing.zhu@nxp.com>
 <Y67+cH15frjqK2vA@lpieralisi>
 <AS8PR04MB8676F92A932B86E5A2A777798CFE9@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676F92A932B86E5A2A777798CFE9@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 09, 2023 at 02:08:06AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Sent: 2022年12月30日 23:06
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; l.stach@pengutronix.de;
> > bhelgaas@google.com
> > Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v2] PCI: imx6: Save and restore MSI control of RC in
> > suspend and resume
> > 
> > On Thu, Dec 08, 2022 at 02:05:34PM +0800, Richard Zhu wrote:
> > > The MSI Enable bit controls delivery of MSI interrupts from components
> > > below the Root Port. This bit might lost during the suspend, should be
> > > re-stored during resume.
> > >
> > > Save the MSI control during suspend, and restore it in resume.
> > 
> > I believe that what Lucas and Bjorn asked on v1 is still not answered.
> > 
> > The root port is a PCI device, why do we need to save and restore the MSI cap
> > on top of what PCI core already does ? The RP should be enumerated as a PCI
> > device and therefore I expect the MSI cap to be saved/restored in the
> > suspend/resume execution.
> > 
> > I don't think there is anything iMX6 specific in this.
> Hi Lorenzo:
> Thanks for your comments.
> Sorry to reply late, since I got a high fever in the past days.
> 
> Based on i.MX6QP SABRESD board and XHCI PCIe2USB3.0 device, the MSI cap
>  save/restore of PCI core is not executed(dev->msi_enabled is zero)
>  during my suspend/resume tests.

I still do not understand. The register you are saving/restoring in the
RC is not the root port Message control field in the root port MSI 
capability, it is a separate register that controls the root complex
MSI forwarding, is that correct ?

The root port MSI capability does not control the root complex
forwarding of MSIs TLPs.

So the bits you are saving and restoring IIUC should be MMIO space in
the root complex, dressed as an MSI capability, that has nothing to
do with the root port MSI capability.

Is that correct ?

Thanks,
Lorenzo
> 
> It seems that some device might shutdown msi when do the suspend operations.
> > 
> > Would you mind investigating it please ?
> Sure, I did further investigation on i.MX6QP platform.
> The MSI_EN bit of RC MSI capability would be cleared to zero, when
>  PCIE_RESET(BIT29 of IOMUXC_GPR1) is toggled (assertion 1b'1,
>  then de-assertion 1b'0).
> 
> Verification steps:
> MSI_EN of RC is set to 1b'1 when system is boot up.
>  ./memtool 1ffc050 1
> 0x01FFC050:  01017005
> 
> Toggle PCIe reset of i.MX6QP.
> root@imx6qpdlsolox:~# ./memtool 20e0004=68691005
> Writing 32-bit value 0x68691005 to address 0x020E0004
> root@imx6qpdlsolox:~# ./memtool 20e0004=48691005
> Writing 32-bit value 0x48691005 to address 0x020E0004
> 
> The MSI_EN bit of RC had been cleared to 1b'0.
> ./memtool 1ffc050 1
> 0x01FFC050:  01807005
> 
> This is why I used to reply to Bjorn the MSI_EN of RC is cleared when
>  RESETs are toggled during the imx6_pcie_host_init() in
>  imx6_pcie_resume_noirq() callback.
> 
> Best Regards
> Richard Zhu
> > 
> > Lorenzo
> > 
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > > Changes v1-->v2:
> > > New create one save/restore function, used save the setting in suspend
> > > and restore the configuration in resume.
> > > v1
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
> > >
> > hwork.kernel.org%2Fproject%2Flinux-pci%2Fpatch%2F1667289595-12440-1-g
> > i
> > >
> > t-send-email-hongxing.zhu%40nxp.com%2F&data=05%7C01%7Chongxing.zhu
> > %40n
> > >
> > xp.com%7C3aeb1d128f854dad1a5608daea77706d%7C686ea1d3bc2b4c6fa92
> > cd99c5c
> > >
> > 301635%7C0%7C0%7C638080095954881374%7CUnknown%7CTWFpbGZsb3
> > d8eyJWIjoiMC
> > >
> > 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%
> > 7C%7C%
> > >
> > 7C&sdata=V8yVvvpTKGoR1UyQP5HD2IdlSjJdznBeD12bdI67dEI%3D&reserved=
> > 0
> > >
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 1dde5c579edc..aa3096890c3b 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -76,6 +76,7 @@ struct imx6_pcie {
> > >  	struct clk		*pcie;
> > >  	struct clk		*pcie_aux;
> > >  	struct regmap		*iomuxc_gpr;
> > > +	u16			msi_ctrl;
> > >  	u32			controller_id;
> > >  	struct reset_control	*pciephy_reset;
> > >  	struct reset_control	*apps_reset;
> > > @@ -1042,6 +1043,26 @@ static void imx6_pcie_pm_turnoff(struct
> > imx6_pcie *imx6_pcie)
> > >  	usleep_range(1000, 10000);
> > >  }
> > >
> > > +static void imx6_pcie_msi_save_restore(struct imx6_pcie *imx6_pcie,
> > > +bool save) {
> > > +	u8 offset;
> > > +	u16 val;
> > > +	struct dw_pcie *pci = imx6_pcie->pci;
> > > +
> > > +	if (pci_msi_enabled()) {
> > > +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> > > +		if (save) {
> > > +			val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> > > +			imx6_pcie->msi_ctrl = val;
> > > +		} else {
> > > +			dw_pcie_dbi_ro_wr_en(pci);
> > > +			val = imx6_pcie->msi_ctrl;
> > > +			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
> > > +			dw_pcie_dbi_ro_wr_dis(pci);
> > > +		}
> > > +	}
> > > +}
> > > +
> > >  static int imx6_pcie_suspend_noirq(struct device *dev)  {
> > >  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev); @@ -1050,6
> > > +1071,7 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
> > >  	if (!(imx6_pcie->drvdata->flags &
> > IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
> > >  		return 0;
> > >
> > > +	imx6_pcie_msi_save_restore(imx6_pcie, true);
> > >  	imx6_pcie_pm_turnoff(imx6_pcie);
> > >  	imx6_pcie_stop_link(imx6_pcie->pci);
> > >  	imx6_pcie_host_exit(pp);
> > > @@ -1069,6 +1091,7 @@ static int imx6_pcie_resume_noirq(struct device
> > *dev)
> > >  	ret = imx6_pcie_host_init(pp);
> > >  	if (ret)
> > >  		return ret;
> > > +	imx6_pcie_msi_save_restore(imx6_pcie, false);
> > >  	dw_pcie_setup_rc(pp);
> > >
> > >  	if (imx6_pcie->link_is_up)
> > > --
> > > 2.25.1
> > >
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
