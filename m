Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20911F4130
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbgFIQlD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 12:41:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731047AbgFIQlC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 12:41:02 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB9620737;
        Tue,  9 Jun 2020 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591720862;
        bh=3qetwtCZbV2rwtSX6HR1C8veFiMVvNuMnN2Up2WK8IE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Gnv7iLW4r7aiutnfo5dX3y36vm4H9l0xBI/1GwNCCANyOEHLf/II0DhwSfPVU18xm
         yBfN9P9uI3NczfOFDswMj/i9Ag3CZflc+9IgF+SuFvSu/G1WEhVlbzurUpP2yP0M71
         /dkMZGf2bBOAUKqSrYo/3wRWWLy2hmdNK0+B57Gw=
Date:   Tue, 9 Jun 2020 11:41:00 -0500
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
        'Varadarajan Narayanan' <varada@codeaurora.org>
Subject: Re: R: R: [PATCH v5 11/11] PCI: qcom: Add Force GEN1 support
Message-ID: <20200609164100.GA1451761@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <021501d63e6d$18a82b40$49f881c0$@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 09, 2020 at 04:48:51PM +0200, ansuelsmth@gmail.com wrote:
> > -----Messaggio originale-----
> > Da: Bjorn Helgaas <helgaas@kernel.org>
> > Inviato: martedì 2 giugno 2020 19:28
> > A: ansuelsmth@gmail.com
> > Cc: 'Rob Herring' <robh+dt@kernel.org>; 'Sham Muthayyan'
> > <smuthayy@codeaurora.org>; 'Rob Herring' <robh@kernel.org>; 'Andy
> > Gross' <agross@kernel.org>; 'Bjorn Andersson'
> > <bjorn.andersson@linaro.org>; 'Bjorn Helgaas' <bhelgaas@google.com>;
> > 'Mark Rutland' <mark.rutland@arm.com>; 'Stanimir Varbanov'
> > <svarbanov@mm-sol.com>; 'Lorenzo Pieralisi'
> > <lorenzo.pieralisi@arm.com>; 'Andrew Murray'
> > <amurray@thegoodpenguin.co.uk>; 'Philipp Zabel'
> > <p.zabel@pengutronix.de>; linux-arm-msm@vger.kernel.org; linux-
> > pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Varadarajan Narayanan <varada@codeaurora.org>
> > Oggetto: Re: R: [PATCH v5 11/11] PCI: qcom: Add Force GEN1 support
> > 
> > [+cc Varada]
> > 
> > On Tue, Jun 02, 2020 at 07:07:27PM +0200, ansuelsmth@gmail.com
> > wrote:
> > > > On Tue, Jun 02, 2020 at 01:53:52PM +0200, Ansuel Smith wrote:
> > > > > From: Sham Muthayyan <smuthayy@codeaurora.org>
> > > > >
> > > > > Add Force GEN1 support needed in some ipq8064 board that needs to
> > > > limit
> > > > > some PCIe line to gen1 for some hardware limitation. This is set by
> the
> > > > > max-link-speed binding and needed by some soc based on ipq8064.
> > (for
> > > > > example Netgear R7800 router)
> > > > >
> > > > > Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> > > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
> > > > >  1 file changed, 13 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > index 259b627bf890..0ce15d53c46e 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > @@ -27,6 +27,7 @@
> > > > >  #include <linux/slab.h>
> > > > >  #include <linux/types.h>
> > > > >
> > > > > +#include "../../pci.h"
> > > > >  #include "pcie-designware.h"
> > > > >
> > > > >  #define PCIE20_PARF_SYS_CTRL			0x00
> > > > > @@ -99,6 +100,8 @@
> > > > >  #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
> > > > >  #define SLV_ADDR_SPACE_SZ			0x10000000
> > > > >
> > > > > +#define PCIE20_LNK_CONTROL2_LINK_STATUS2	0xa0
> > > > > +
> > > > >  #define DEVICE_TYPE_RC				0x4
> > > > >
> > > > >  #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
> > > > > @@ -195,6 +198,7 @@ struct qcom_pcie {
> > > > >  	struct phy *phy;
> > > > >  	struct gpio_desc *reset;
> > > > >  	const struct qcom_pcie_ops *ops;
> > > > > +	int gen;
> > > > >  };
> > > > >
> > > > >  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> > > > > @@ -395,6 +399,11 @@ static int qcom_pcie_init_2_1_0(struct
> > > > qcom_pcie *pcie)
> > > > >  	/* wait for clock acquisition */
> > > > >  	usleep_range(1000, 1500);
> > > > >
> > > > > +	if (pcie->gen == 1) {
> > > > > +		val = readl(pci->dbi_base +
> > > > PCIE20_LNK_CONTROL2_LINK_STATUS2);
> > > > > +		val |= 1;
> > > >
> > > > Is this the same bit that's visible in config space as
> > > > PCI_EXP_LNKSTA_CLS_2_5GB?  Why not use that #define?
> > > >
> > > > There are a bunch of other #defines in this file that look like
> > > > redefinitions of standard things:
> > > >
> > > >   #define PCIE20_COMMAND_STATUS                   0x04
> > > >     Looks like PCI_COMMAND
> > > >
> > > >   #define CMD_BME_VAL                             0x4
> > > >     Looks like PCI_COMMAND_MASTER
> > > >
> > > >   #define PCIE20_DEVICE_CONTROL2_STATUS2          0x98
> > > >     Looks like (PCIE20_CAP + PCI_EXP_DEVCTL2)
> > > >
> > > >   #define PCIE_CAP_CPL_TIMEOUT_DISABLE            0x10
> > > >     Looks like PCI_EXP_DEVCTL2_COMP_TMOUT_DIS
> > > >
> > > >   #define PCIE20_CAP                              0x70
> > > >     This one is obviously device-specific
> > > >
> > > >   #define PCIE20_CAP_LINK_CAPABILITIES            (PCIE20_CAP + 0xC)
> > > >     Looks like (PCIE20_CAP + PCI_EXP_LNKCAP)
> > > >
> > > >   #define PCIE20_CAP_ACTIVE_STATE_LINK_PM_SUPPORT (BIT(10) |
> > > > BIT(11))
> > > >     Looks like PCI_EXP_LNKCAP_ASPMS
> > > >
> > > >   #define PCIE20_CAP_LINK_1                       (PCIE20_CAP + 0x14)
> > > >   #define PCIE_CAP_LINK1_VAL                      0x2FD7F
> > > >     This looks like PCIE20_CAP_LINK_1 should be (PCIE20_CAP +
> > > >     PCI_EXP_SLTCAP), but "CAP_LINK_1" doesn't sound like the Slot
> > > >     Capabilities register, and I don't know what PCIE_CAP_LINK1_VAL
> > > >     means.
> > >
> > > The define are used by ipq8074 and I really can't test the changes.
> > > Anyway it shouldn't make a difference use the define instead of the
> > > custom value so a patch should not harm anything... Problem is the
> > > last 2 define that we really don't know what they are about... How
> > > should I proceed? Change only the value related to
> > > PCI_EXP_LNKSTA_CLS_2_5GB or change all the other except the last 2?
> > 
> > I personally would change all the ones I mentioned above (in a
> > separate patch from the one that adds "max-link-speed" support).
> > Testing isn't a big deal because changing the #defines shouldn't
> > change the generated code at all.
> > 
> > PCIE20_CAP_LINK_1 / PCIE_CAP_LINK1_VAL looks like a potential bug or
> > at least a very misleading name.  I wouldn't touch it unless we can
> > figure out what's going on.
> > 
> > Looks like most of this was added by 5d76117f070d ("PCI: qcom: Add
> > support for IPQ8074 PCIe controller").  Shame on me for not asking
> > these questions at the time.
> > 
> > Sham, Varada, can you shed any light on PCIE20_CAP_LINK_1 and
> > PCIE_CAP_LINK1_VAL?
> > 
> 
> Still no response. Should I push a v6 with this fix and leave the
> unknown params as they are?

Yep, that sounds good to me.
