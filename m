Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EFA2F25DE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 02:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbhALBxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 20:53:07 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:36589 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbhALBxG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2021 20:53:06 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210112015223epoutp0232fd8efe509a02fb23ab1a1f468ed2a7~ZWSHWQ0To0635206352epoutp02U
        for <linux-pci@vger.kernel.org>; Tue, 12 Jan 2021 01:52:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210112015223epoutp0232fd8efe509a02fb23ab1a1f468ed2a7~ZWSHWQ0To0635206352epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610416343;
        bh=X8jLKRgKwbuEvV0M3rowV4XcEyS/RHz/ZInOqPgjtN4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Zwqgdj7FY9fZ2Fv0rHCe/z+qJZSqX60yNh4H7jtKEFjXNEzvzycKDNc0XFQ86c/CM
         phuQc5nujYNbOlNDOQeEVP0xES/SL/QUNO15KfqDW+BzHXrPYPz1aa2+LQ+kQ8N5JO
         +Rjcx/rM3/TeLGfH4KhophlqwDksUfJooLY+cg6M=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210112015221epcas5p3adcf682767f171f5ae00bb62704dfd3f~ZWSFxlPPN2883428834epcas5p3T;
        Tue, 12 Jan 2021 01:52:21 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.B4.50652.5D00DFF5; Tue, 12 Jan 2021 10:52:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210112015220epcas5p16e8c760078ee6b2a11ffca974fab5244~ZWSEqxLVQ0433904339epcas5p1n;
        Tue, 12 Jan 2021 01:52:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210112015220epsmtrp19e18c6434d87bf0c1ed13130a73ea59c~ZWSEpbswV2601726017epsmtrp1k;
        Tue, 12 Jan 2021 01:52:20 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-e8-5ffd00d5b098
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.F3.13470.4D00DFF5; Tue, 12 Jan 2021 10:52:20 +0900 (KST)
Received: from pankajdubey02 (unknown [107.122.12.6]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210112015218epsmtip2b796bbbcaa5c30ff3f106aad7903df2c~ZWSCXAErw2865428654epsmtip21;
        Tue, 12 Jan 2021 01:52:18 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Bjorn Helgaas'" <helgaas@kernel.org>,
        "'Shradha Todi'" <shradha.t@samsung.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <sriram.dash@samsung.com>,
        <niyas.ahmed@samsung.com>, <p.rajanbabu@samsung.com>,
        <l.mehra@samsung.com>, <hari.tv@samsung.com>,
        "'Anvesh Salveru'" <anvesh.salveru@gmail.com>,
        "'Jingoo Han'" <jingoohan1@gmail.com>,
        "'Gustavo Pimentel'" <gustavo.pimentel@synopsys.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Rob Herring'" <robh@kernel.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>
In-Reply-To: <20210107184406.GA1372915@bjorn-Precision-5520>
Subject: RE: [PATCH v7 2/5] PCI: dwc: add support to handle ZRX-DC Compliant
 PHYs
Date:   Tue, 12 Jan 2021 07:22:17 +0530
Message-ID: <00b801d6e885$906179d0$b1246d70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFH82WjKnnvSnIAADTcEDBMffMU0QGPcjCeqzSl8HA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7bCmuu5Vhr/xBjeXGVj8WD2B2WJJU4bF
        rrsd7BYfp61ksnh1Zi2bxYovM9kt7jy/wWhxedccNouz846zWXR+mcVm8eb3C3aLJ1MesVoc
        3Rhs8X/PDnaL3sO1FjfWszsIeKyZt4bRY+esu+weCzaVemxa1cnm0bdlFaPHlv2fGT0+b5IL
        YI/isklJzcksSy3St0vgyrjYe5i94KdBxfQ3f9kbGCeqdzFyckgImEgcnP2TrYuRi0NIYDej
        xKMFu9khnE+MEtev3GAFqRIS+MYocfk5P0zHoV17oIr2Mko8uTkPqv0Vo8TWtY1MIFVsAvoS
        537MA+sWEQiTOLDwCVgHs8A3ZolbR+6xdDFycHAK2EisPwBWLywQLPHl5ktmEJtFQFXi9ZJn
        jCA2r4ClxNELu6FsQYmTM5+wgNjMAvIS29/OYYa4SEHi59NlULusJFZ0HWeGqBGXeHn0CNhe
        CYEHHBL3er8yQjS4SBxpWQ/VLCzx6vgWdghbSuJlfxuUnS/xY/EkZojmFkaJycfnskIk7CUO
        XJkD9gCzgKbE+l36EMv4JHp/P2ECCUsI8Ep0tAlBVKtJfH9+BmqVjMTD5qVQJR4SP6YZTWBU
        nIXks1lIPpuF5INZCLsWMLKsYpRMLSjOTU8tNi0wykst1ytOzC0uzUvXS87P3cQITnVaXjsY
        Hz74oHeIkYmD8RCjBAezkgiv14Y/8UK8KYmVValF+fFFpTmpxYcYpTlYlMR5dxg8iBcSSE8s
        Sc1OTS1ILYLJMnFwSjUwRR13W3Da8g6fm7GTwy/mF/oM/5OcZZ9Mj90V22l4yS48VivPcsq6
        uRbnHt8Pfc+9p1x/tjF3ybVAls8NP98kBcw5tHKq1+LI3VtFzVQKH7YGKj57fC6Jb+GvM9HH
        cic9Oplqn3H9Z5RH3KtDLw9xTmcrfvIzc82VuVdYLB+n7Bc9W/ST2abAtaHFQnpza5Oc8+n8
        qSEd73LtFi2XklmRzmT90PfOhrqGFUdMs3f6nj+vqy8zJ12+jvWMf/Zq9bpaHc5XTO+8NVb3
        z3jat6a5/6ar//P+wP2Lt65T1Lp4bJ54gtTz5o5PU07nT/6zZPO2T3c2rni79PHTA3smS+72
        tG1c8CR20wWBU3kuXzXbVJVYijMSDbWYi4oTAbaf/zTkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCSvO4Vhr/xBhtXK1r8WD2B2WJJU4bF
        rrsd7BYfp61ksnh1Zi2bxYovM9kt7jy/wWhxedccNouz846zWXR+mcVm8eb3C3aLJ1MesVoc
        3Rhs8X/PDnaL3sO1FjfWszsIeKyZt4bRY+esu+weCzaVemxa1cnm0bdlFaPHlv2fGT0+b5IL
        YI/isklJzcksSy3St0vgyrjYe5i94KdBxfQ3f9kbGCeqdzFyckgImEgc2rWHHcQWEtjNKLHh
        oDdEXEZi8uoVrBC2sMTKf8+BariAal4wSrzfsoEJJMEmoC9x7sc8sCIRgTCJt0sms4AUMQs0
        sUjcOLQWqqOXUWLWk9dsXYwcHJwCNhLrDzCBmMICgRI3rkiA9LIIqEq8XvKMEcTmFbCUOHph
        N5QtKHFy5hMWkHJmAT2Jto1gYWYBeYntb+cwQ9ymIPHz6TKoE6wkVnQdZ4aoEZd4efQI+wRG
        4VlIJs1CmDQLyaRZSDoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjlYtzR2M
        21d90DvEyMTBeIhRgoNZSYTXa8OfeCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeW
        pGanphakFsFkmTg4pRqY9vrdWRVkNNWZtZVHw/BV+bqUf/3XWaueBe9dejVHxyhNKdfmbtIW
        ya2fa24q5T8saZN9er37TFLk74jnuc/rDy38F/BU/1P80vYVD9UX6i477eD90WEPn25raa/o
        hztdYbbJ/h7Bs1u6pkXPanR0sfixxju3KPRtwtb5rOJTDJzLj4lc5t5x4Wrtae/9vPePTM4p
        mxP/4NHiGAXeuGNrT3Tb63+0Xq2TeXvRvY6nCuJea+/VRz96w5WbLHDwwOJdPydonNr33y1y
        hcgjBcaodddmikbzVgfeay+Vu1Er9TVCrlVg/bNb7ZdFNqTGX6uqC3nOvnOO/Or37fOPqrzx
        3PRIL/Wg76m4GLMv+SVGSizFGYmGWsxFxYkAMqWEXEUDAAA=
X-CMS-MailID: 20210112015220epcas5p16e8c760078ee6b2a11ffca974fab5244
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20210107184413epcas5p35526b4c5a8e6767a69fae6a14fa8f7c5
References: <CGME20210107184413epcas5p35526b4c5a8e6767a69fae6a14fa8f7c5@epcas5p3.samsung.com>
        <20210107184406.GA1372915@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
<snip>
> Subject: Re: [PATCH v7 2/5] PCI: dwc: add support to handle ZRX-DC
> Compliant PHYs
> 
> Capitalize subject to match the rest of the series.
> 
> "Add support to handle .." is redundant; "Add support for ..." would be
> equivalent and shorter.

OK 

> 
> But this patch actually doesn't add anything at all by itself, since it
checks pci-
> >phy_zrxdc_compliant but never sets it.

OK, we will reword the commit message as  "configure controller to handle
ZRX-DC compliant PHYs"

> 
> On Thu, Jan 07, 2021 at 08:58:40PM +0530, Shradha Todi wrote:
> > From: Pankaj Dubey <pankaj.dubey@samsung.com>
> >
> > Many platforms use DesignWare controller but the PHY can be different
> > in different platforms. If the PHY is compliant is to ZRX-DC
> > specification it helps in low power consumption during power states.
> 
> s/is to/to/

OK

> 
> Even with that, this sentence doesn't quite parse correctly.  Do you mean
> something like this?
> 
>   If the PHY is compliant to the ZRX-DC specification, it reduces
>   power consumption in low power Link states.
> 
> (I assume this is related to Link power states (L0, L1, etc), not device
power
> states (D0, D3hot, etc)).
> 

Yes, we are talking about Link power states. We rephrase the commit
description to make it more clear.

> > If current data rate is 8.0 GT/s or higher and PHY is not compliant to
> > ZRX-DC specification, then after every 100ms link should transition to
> > recovery state during the low power states.
> 
> Not sure this makes sense.  If the Link is in a low power state for 10
seconds,
> it must transition to the Recovery state every 100ms during that 10
seconds,
> i.e., 100 times?
> 

According to SNPS DesignWare data-book, the link will transition into
recovery state every 100ms, which means that yes, 100 times in 10 seconds.
But what we are trying to say here is that if the PHY is ZRX-DC compliant,
then the controller does not need to do this and we can thus save power
consumption.

As per the DesignWare data-book, the controller keeps this bit set to '1' by
default ("This bit enables a 100ms timer which can trigger exit from L1.")
and we are trying to reset this bit to '0' in order to not perform the
constant recovery and hence save power.

> > DesignWare controller provides GEN3_ZRXDC_NONCOMPL field in
> > GEN3_RELATED_OFF to specify about ZRX-DC compliant PHY.
> >
> > Platforms with ZRX-DC compliant PHY can set phy_zrxdc_compliant
> > variable to specify this property to the controller.
> 
> If this is a DesignWare-generic register and the "phy-zrxdc-compliant"
> property can be used by any DesignWare-based driver, why isn't the code to
> look for it in the DesignWare-generic part?
> 

Do you mean why this property is part of PHY node instead of DesignWare
controller?

> Is there a link to the ZRX-DC specification you can mention somewhere in
this
> series?
> 

I don't know if there is any separate ZRX-DC specification exists which can
be pointed out here, but we have implementation note in PCIe specification
Rev 4.0 which says as:
"Ports that meet the ZRX-DC specification for 2.5 GT/s while in the L1.Idle
state and are therefore not required to implement the 100 ms timeout and
transition to Recovery should avoid implementing it, since it will reduce
the power savings expected from the L1 state." 

We have captured same in cover-letter of this patch series.

> > Signed-off-by: Anvesh Salveru <anvesh.salveru@gmail.com>
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 6 ++++++
> > drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > b/drivers/pci/controller/dwc/pcie-designware.c
> > index 645fa18..74590c7 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -722,4 +722,10 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >  		       PCIE_PL_CHK_REG_CHK_REG_START;
> >  		dw_pcie_writel_dbi(pci,
> PCIE_PL_CHK_REG_CONTROL_STATUS, val);
> >  	}
> > +
> > +	if (pci->phy_zrxdc_compliant) {
> > +		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> > +		val &= ~PORT_LOGIC_GEN3_ZRXDC_NONCOMPL;
> > +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> > +	}
> >  }
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > b/drivers/pci/controller/dwc/pcie-designware.h
> > index 0207840..8b905a2 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -74,6 +74,9 @@
> >  #define PCIE_MSI_INTR0_MASK		0x82C
> >  #define PCIE_MSI_INTR0_STATUS		0x830
> >
> > +#define PCIE_PORT_GEN3_RELATED		0x890
> > +#define PORT_LOGIC_GEN3_ZRXDC_NONCOMPL	BIT(0)
> > +
> >  #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
> >  #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
> >
> > @@ -273,6 +276,7 @@ struct dw_pcie {
> >  	u8			n_fts[2];
> >  	bool			iatu_unroll_enabled: 1;
> >  	bool			io_cfg_atu_shared: 1;
> > +	bool			phy_zrxdc_compliant;
> 
> I raise my eyebrows a little at "bool xx : 1".  I think it's probably
*correct*, but
> "unsigned int xx : 1" is the overwhelming favorite and I doubt bool gives
any
> advantage.
> 
>   $ git grep -E "int\s+\S+\s*:\s*1" | egrep "^\S*\.[ch]" | wc -l
>   3129
>   $ git grep -E "bool\s+\S+\s*:\s*1" | egrep "^\S*\.[ch]" | wc -l
>   637
> 
> pcie-designware.h is the only user in drivers/pci.  But you're following
the
> existing style in the file, which is good.

No, we didn't follow existing style, we will update this in next version.

Thanks for review.

Pankaj Dubey
> 
> >  };
> >
> >  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie,
> > pp)
> > --
> > 2.7.4
> >

