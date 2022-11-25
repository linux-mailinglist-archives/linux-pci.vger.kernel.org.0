Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53204638738
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 11:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKYKT2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Nov 2022 05:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKYKT1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2022 05:19:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A05D21887
        for <linux-pci@vger.kernel.org>; Fri, 25 Nov 2022 02:19:26 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oyVnn-0004RC-Ta; Fri, 25 Nov 2022 11:19:24 +0100
Message-ID: <9ea3b053cf20d0f3564ccd6152b258ddf0cc8d1e.camel@pengutronix.de>
Subject: Re: [PATCH v1] PCI: imx6: Set MSI enable bit of RC in resume
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Date:   Fri, 25 Nov 2022 11:19:22 +0100
In-Reply-To: <AS8PR04MB8676A61A8C554EB0F0162C998C0E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1667289595-12440-1-git-send-email-hongxing.zhu@nxp.com>
         <AS8PR04MB8676A61A8C554EB0F0162C998C0E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Freitag, dem 25.11.2022 um 02:07 +0000 schrieb Hongxing Zhu:
> Friendly ping.
> Anymore comments are very appreciated.
> 
> BTW, I had verified on i.MX7D/i.MX6QP platforms that MSI wouldn’t be functional
>  after resume without this patch.

Instead of playing whack-a-mole and restoring individual config setting
after resume, shouldn't we just do a pci_save_state() on suspend and
then restore the complete config by calling pci_restore_state() on
resume?

Regards,
Lucas

> 
> Best Regards
> Richard Zhu
> 
> > -----Original Message-----
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> > Sent: 2022年11月1日 16:00
> > To: l.stach@pengutronix.de; bhelgaas@google.com;
> > lorenzo.pieralisi@arm.com
> > Cc: Hongxing Zhu <hongxing.zhu@nxp.com>; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> > Subject: [PATCH v1] PCI: imx6: Set MSI enable bit of RC in resume
> > 
> > The MSI Enable bit controls delivery of MSI interrupts from components below
> > the Root Port. This bit might lost during the suspend, should be re-configured
> > during resume.
> > 
> > Encapsulate the MSI enable set into a standalone function, and invoke it in
> > both probe and resume.
> > 
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 2616585ca5f8..dba15546075f 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1041,6 +1041,21 @@ static void imx6_pcie_pm_turnoff(struct
> > imx6_pcie *imx6_pcie)
> >  	usleep_range(1000, 10000);
> >  }
> > 
> > +static void pci_imx_set_msi_en(struct dw_pcie *pci) {
> > +	u8 offset;
> > +	u16 val;
> > +
> > +	if (pci_msi_enabled()) {
> > +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> > +		dw_pcie_dbi_ro_wr_en(pci);
> > +		val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> > +		val |= PCI_MSI_FLAGS_ENABLE;
> > +		dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
> > +		dw_pcie_dbi_ro_wr_dis(pci);
> > +	}
> > +}
> > +
> >  static int imx6_pcie_suspend_noirq(struct device *dev)  {
> >  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev); @@ -1073,6
> > +1088,7 @@ static int imx6_pcie_resume_noirq(struct device *dev)
> >  	if (imx6_pcie->link_is_up)
> >  		imx6_pcie_start_link(imx6_pcie->pci);
> > 
> > +	pci_imx_set_msi_en(imx6_pcie->pci);
> >  	return 0;
> >  }
> > 
> > @@ -1090,7 +1106,6 @@ static int imx6_pcie_probe(struct platform_device
> > *pdev)
> >  	struct resource *dbi_base;
> >  	struct device_node *node = dev->of_node;
> >  	int ret;
> > -	u16 val;
> > 
> >  	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
> >  	if (!imx6_pcie)
> > @@ -1282,12 +1297,7 @@ static int imx6_pcie_probe(struct platform_device
> > *pdev)
> >  	if (ret < 0)
> >  		return ret;
> > 
> > -	if (pci_msi_enabled()) {
> > -		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> > -		val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> > -		val |= PCI_MSI_FLAGS_ENABLE;
> > -		dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
> > -	}
> > +	pci_imx_set_msi_en(pci);
> > 
> >  	return 0;
> >  }
> > --
> > 2.25.1
> 


