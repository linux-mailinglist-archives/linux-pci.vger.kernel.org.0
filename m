Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F8C1EC0EE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 19:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgFBR2Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 13:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgFBR2Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 13:28:24 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C49D2068D;
        Tue,  2 Jun 2020 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591118903;
        bh=yGkdrYOWLWdmzVsGczOoFywq0agQlbTTQsSxiiUAia0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uLGAssqQ3lodfFxvZFDZNFc3KCcKe/w1tJzGNm7CQoykFcyI6qtognbpDGFQToFOM
         vTiEjTih17YYcsf3bCbYdxYGBeJzvduB6AnTe+cRcx0BWh4xE1qKk9Nbd6q3pwjIUH
         HWrw204xfcs7dQuSN+/4/RhRtz/F1KpZu1EWO49o=
Date:   Tue, 2 Jun 2020 12:28:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ansuelsmth@gmail.com
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Sham Muthayyan' <smuthayy@codeaurora.org>,
        'Rob Herring' <robh@kernel.org>,
        'Andy Gross' <agross@kernel.org>,
        'Bjorn Andersson' <bjorn.andersson@linaro.org>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Mark Rutland' <mark.rutland@arm.com>,
        'Stanimir Varbanov' <svarbanov@mm-sol.com>,
        'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        'Andrew Murray' <amurray@thegoodpenguin.co.uk>,
        'Philipp Zabel' <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <varada@codeaurora.org>
Subject: Re: R: [PATCH v5 11/11] PCI: qcom: Add Force GEN1 support
Message-ID: <20200602172821.GA829015@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001101d63900$4c7aae60$e5700b20$@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Varada]

On Tue, Jun 02, 2020 at 07:07:27PM +0200, ansuelsmth@gmail.com wrote:
> > On Tue, Jun 02, 2020 at 01:53:52PM +0200, Ansuel Smith wrote:
> > > From: Sham Muthayyan <smuthayy@codeaurora.org>
> > >
> > > Add Force GEN1 support needed in some ipq8064 board that needs to
> > limit
> > > some PCIe line to gen1 for some hardware limitation. This is set by the
> > > max-link-speed binding and needed by some soc based on ipq8064. (for
> > > example Netgear R7800 router)
> > >
> > > Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> > b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 259b627bf890..0ce15d53c46e 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -27,6 +27,7 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/types.h>
> > >
> > > +#include "../../pci.h"
> > >  #include "pcie-designware.h"
> > >
> > >  #define PCIE20_PARF_SYS_CTRL			0x00
> > > @@ -99,6 +100,8 @@
> > >  #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
> > >  #define SLV_ADDR_SPACE_SZ			0x10000000
> > >
> > > +#define PCIE20_LNK_CONTROL2_LINK_STATUS2	0xa0
> > > +
> > >  #define DEVICE_TYPE_RC				0x4
> > >
> > >  #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
> > > @@ -195,6 +198,7 @@ struct qcom_pcie {
> > >  	struct phy *phy;
> > >  	struct gpio_desc *reset;
> > >  	const struct qcom_pcie_ops *ops;
> > > +	int gen;
> > >  };
> > >
> > >  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> > > @@ -395,6 +399,11 @@ static int qcom_pcie_init_2_1_0(struct
> > qcom_pcie *pcie)
> > >  	/* wait for clock acquisition */
> > >  	usleep_range(1000, 1500);
> > >
> > > +	if (pcie->gen == 1) {
> > > +		val = readl(pci->dbi_base +
> > PCIE20_LNK_CONTROL2_LINK_STATUS2);
> > > +		val |= 1;
> > 
> > Is this the same bit that's visible in config space as
> > PCI_EXP_LNKSTA_CLS_2_5GB?  Why not use that #define?
> > 
> > There are a bunch of other #defines in this file that look like
> > redefinitions of standard things:
> > 
> >   #define PCIE20_COMMAND_STATUS                   0x04
> >     Looks like PCI_COMMAND
> > 
> >   #define CMD_BME_VAL                             0x4
> >     Looks like PCI_COMMAND_MASTER
> > 
> >   #define PCIE20_DEVICE_CONTROL2_STATUS2          0x98
> >     Looks like (PCIE20_CAP + PCI_EXP_DEVCTL2)
> > 
> >   #define PCIE_CAP_CPL_TIMEOUT_DISABLE            0x10
> >     Looks like PCI_EXP_DEVCTL2_COMP_TMOUT_DIS
> > 
> >   #define PCIE20_CAP                              0x70
> >     This one is obviously device-specific
> > 
> >   #define PCIE20_CAP_LINK_CAPABILITIES            (PCIE20_CAP + 0xC)
> >     Looks like (PCIE20_CAP + PCI_EXP_LNKCAP)
> > 
> >   #define PCIE20_CAP_ACTIVE_STATE_LINK_PM_SUPPORT (BIT(10) |
> > BIT(11))
> >     Looks like PCI_EXP_LNKCAP_ASPMS
> > 
> >   #define PCIE20_CAP_LINK_1                       (PCIE20_CAP + 0x14)
> >   #define PCIE_CAP_LINK1_VAL                      0x2FD7F
> >     This looks like PCIE20_CAP_LINK_1 should be (PCIE20_CAP +
> >     PCI_EXP_SLTCAP), but "CAP_LINK_1" doesn't sound like the Slot
> >     Capabilities register, and I don't know what PCIE_CAP_LINK1_VAL
> >     means.
> 
> The define are used by ipq8074 and I really can't test the changes.
> Anyway it shouldn't make a difference use the define instead of the
> custom value so a patch should not harm anything... Problem is the
> last 2 define that we really don't know what they are about... How
> should I proceed? Change only the value related to
> PCI_EXP_LNKSTA_CLS_2_5GB or change all the other except the last 2?

I personally would change all the ones I mentioned above (in a
separate patch from the one that adds "max-link-speed" support).
Testing isn't a big deal because changing the #defines shouldn't
change the generated code at all.

PCIE20_CAP_LINK_1 / PCIE_CAP_LINK1_VAL looks like a potential bug or
at least a very misleading name.  I wouldn't touch it unless we can
figure out what's going on.

Looks like most of this was added by 5d76117f070d ("PCI: qcom: Add
support for IPQ8074 PCIe controller").  Shame on me for not asking
these questions at the time.

Sham, Varada, can you shed any light on PCIE20_CAP_LINK_1 and
PCIE_CAP_LINK1_VAL?

> > > +		writel(val, pci->dbi_base +
> > PCIE20_LNK_CONTROL2_LINK_STATUS2);
> > > +	}
> > >
> > >  	/* Set the Max TLP size to 2K, instead of using default of 4K */
> > >  	writel(CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K,
> > > @@ -1397,6 +1406,10 @@ static int qcom_pcie_probe(struct
> > platform_device *pdev)
> > >  		goto err_pm_runtime_put;
> > >  	}
> > >
> > > +	pcie->gen = of_pci_get_max_link_speed(pdev->dev.of_node);
> > > +	if (pcie->gen < 0)
> > > +		pcie->gen = 2;
> > > +
> > >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > "parf");
> > >  	pcie->parf = devm_ioremap_resource(dev, res);
> > >  	if (IS_ERR(pcie->parf)) {
> > > --
> > > 2.25.1
> > >
> 
