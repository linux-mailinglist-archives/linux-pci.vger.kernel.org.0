Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94AF8B3902
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 13:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfIPLGm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 07:06:42 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:20064 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfIPLGm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 07:06:42 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190916110639epoutp0315cf7d2f2a586d7e4ff207bcc826e001~E5n4GebRr1067010670epoutp03e
        for <linux-pci@vger.kernel.org>; Mon, 16 Sep 2019 11:06:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190916110639epoutp0315cf7d2f2a586d7e4ff207bcc826e001~E5n4GebRr1067010670epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568631999;
        bh=ZciVwi37U0FPCkBGrbDNdEqvRo2qw0lrU0W+7y9BBBE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=fgFVjnLAtNGtJMjdDZkgr+MgH6z3K89Q3ZaGpXmMvDdfAbfGvXpE/vKCPZ0G1NaKO
         Q1jJAqw8N0bqvLpQjAehz1IdC67VhheLMRLoDb05avaO6yUgbIZlEpR4BSupuvGndj
         tWPLmeCmO5ysDZGQ83DlaAU+nAToSDp0EaFfZWwQ=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20190916110638epcas5p22621a65598e3bfc56749549ec5528c95~E5n3djSXZ0421604216epcas5p2Q;
        Mon, 16 Sep 2019 11:06:38 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.05.04150.EBC6F7D5; Mon, 16 Sep 2019 20:06:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20190916110637epcas5p11dca7ab78a5e4e2ea7fd7991a02e2f0b~E5n24YdyZ1462814628epcas5p1B;
        Mon, 16 Sep 2019 11:06:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190916110637epsmtrp2365ea07737790645abfe851bc7b44d08~E5n22oJFt0248802488epsmtrp2j;
        Mon, 16 Sep 2019 11:06:37 +0000 (GMT)
X-AuditID: b6c32a49-a5bff70000001036-a0-5d7f6cbeeed0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.B5.03706.DBC6F7D5; Mon, 16 Sep 2019 20:06:37 +0900 (KST)
Received: from pankajdubey02 (unknown [107.111.85.21]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190916110635epsmtip15dd93c93ac28f3bf6aaa84936c3923d9~E5n0pDFPg1706017060epsmtip1F;
        Mon, 16 Sep 2019 11:06:35 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Andrew Murray'" <andrew.murray@arm.com>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        "'Anvesh Salveru'" <anvesh.s@samsung.com>
In-Reply-To: <20190916101543.GM9720@e119886-lin.cambridge.arm.com>
Subject: RE: [PATCH v2] PCI: dwc: Add support to add GEN3 related
 equalization quirks
Date:   Mon, 16 Sep 2019 16:36:33 +0530
Message-ID: <00a401d56c7e$cf3abd30$6db03790$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKZmfmIjaX5BaBnMA3N+7vtT2Qq7gGeUxCAAtEE+g+lgk5rEA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7bCmpu6+nPpYg70fpS2a/29ntTi7ayGr
        xZKmDItddzvYLVZ8mclucXnXHDaLs/OOs1m8+f2C3YHDY828NYweO2fdZfdYsKnUo2/LKkaP
        Lfs/M3p83iQXwBbFZZOSmpNZllqkb5fAldH06i5zwSrlir5PR5kbGN/JdDFyckgImEis37mJ
        pYuRi0NIYDejxIbTR9kgnE+MEoeO7WSEcL4xSvxr+cgI09Ky/hsTRGIvo8TC08+gql4zStx+
        MJEZpIpNQF/i3I95rCC2iICuxNdVz8HmMgvcBRo16xkLSIJTwEli/+mnYLawQLjEiW17wJpZ
        BFQldv1YC9bMK2Ap8evyVRYIW1Di5MwnYDazgLzE9rdzmCFOUpD4+XQZUD0H0DIniWXfRCFK
        xCVeHj3CDrJXQuA3m8SO20fZIepdJJqvTWaCsIUlXh3fAhWXkvj8bi8bhJ0v8WPxJGaI5hZG
        icnH57JCJOwlDlyZwwKyjFlAU2L9Ln2IZXwSvb+fMIGEJQR4JTrahCCq1SS+Pz8DdaaMxMPm
        pVBrPSSmbHzIOoFRcRaSz2Yh+WwWkhdmISxbwMiyilEytaA4Nz212LTAMC+1XK84Mbe4NC9d
        Lzk/dxMjODVpee5gnHXO5xCjAAejEg9vQ2tdrBBrYllxZe4hRgkOZiUR3vCO6lgh3pTEyqrU
        ovz4otKc1OJDjNIcLErivJNYr8YICaQnlqRmp6YWpBbBZJk4OKUaGCXuvc9zK1sqnMb2JnfO
        8x/26m/2Kne+CjQ6czT5zvQFR/b/yJSyeiXVp2MSHznlVLSs1gmFmPwL9xsaeUp/sb7hMtRa
        I6fXotNuJVAfYLFGW25emp76rJmH9z/UOr4o/2HkUq7AhYdur79yc9UUi9LtrhtLDm26kxT8
        WHk2d693e1b2tKgYLyWW4oxEQy3mouJEAHr0DP9JAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSnO7enPpYgxfXdC2a/29ntTi7ayGr
        xZKmDItddzvYLVZ8mclucXnXHDaLs/OOs1m8+f2C3YHDY828NYweO2fdZfdYsKnUo2/LKkaP
        Lfs/M3p83iQXwBbFZZOSmpNZllqkb5fAldH06i5zwSrlir5PR5kbGN/JdDFyckgImEi0rP/G
        1MXIxSEksJtR4uzreWwQCRmJyatXsELYwhIr/z1nhyh6ySgx+co1RpAEm4C+xLkf88CKRAR0
        Jb6ues4GUsQs8JhRom0fSAKk4wKjxKdLK8A6OAWcJPaffsoCYgsLhEr8//WGGcRmEVCV2PVj
        LdgkXgFLiV+Xr7JA2IISJ2c+AbI5gKbqSbRtBBvDLCAvsf3tHGaI6xQkfj5dxgpSIgI0ftk3
        UYgScYmXR4+wT2AUnoVk0CyEQbOQDJqFpGMBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS9
        5PzcTYzg6NLS3MF4eUn8IUYBDkYlHt4b7XWxQqyJZcWVuYcYJTiYlUR4wzuqY4V4UxIrq1KL
        8uOLSnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpgZGOWC/t94VfBuilnLwYH
        +XVGR616YWt03iH1Z1fwMY4rP+UqPzY2b1B0mt7fr8lQoOXXuHx6Re3hq1vfGU8rennjzIfS
        hHtl63VcblvxeHOsYIud9XtNslfMV7FnXYzJQXLKrgUvd8RyCN/ZuCP8jPNL/SqxqffeenJ5
        Z9/cyPN1raW3tMI7JZbijERDLeai4kQAofZPcqoCAAA=
X-CMS-MailID: 20190916110637epcas5p11dca7ab78a5e4e2ea7fd7991a02e2f0b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190913104018epcas5p3d93265a6786dc2b7b8a7d3231bfe9c14
References: <CGME20190913104018epcas5p3d93265a6786dc2b7b8a7d3231bfe9c14@epcas5p3.samsung.com>
        <1568371190-14590-1-git-send-email-pankaj.dubey@samsung.com>
        <20190916101543.GM9720@e119886-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Andrew Murray <andrew.murray@arm.com>
> Sent: Monday, September 16, 2019 3:46 PM
> To: Pankaj Dubey <pankaj.dubey@samsung.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> jingoohan1@gmail.com; gustavo.pimentel@synopsys.com;
> lorenzo.pieralisi@arm.com; bhelgaas@google.com; Anvesh Salveru
> <anvesh.s@samsung.com>
> Subject: Re: [PATCH v2] PCI: dwc: Add support to add GEN3 related
equalization
> quirks
> 
> On Fri, Sep 13, 2019 at 04:09:50PM +0530, Pankaj Dubey wrote:
> > From: Anvesh Salveru <anvesh.s@samsung.com>
> >
> > In some platforms, PCIe PHY may have issues which will prevent linkup
> > to happen in GEN3 or higher speed. In case equalization fails, link
> > will fallback to GEN1.
> >
> > DesignWare controller gives flexibility to disable GEN3 equalization
> > completely or only phase 2 and 3 of equalization.
> >
> > This patch enables the DesignWare driver to disable the PCIe GEN3
> > equalization by enabling one of the following quirks:
> >  - DWC_EQUALIZATION_DISABLE: To disable GEN3 equalization all phases
> >  - DWC_EQ_PHASE_2_3_DISABLE: To disable GEN3 equalization phase 2 & 3
> >
> > Platform drivers can set these quirks via "quirk" variable of "dw_pcie"
> > struct.
> >
> > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > ---
> > Patchset v1 can be found at:
> >  - 1/2: https://lkml.org/lkml/2019/9/10/443
> >  - 2/2: https://lkml.org/lkml/2019/9/10/444
> >
> > Changes w.r.t v1:
> >  - Squashed two patches from v1 into one as suggested by Gustavo
> >  - Addressed review comments from Andrew
> >
> >  drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++++
> > drivers/pci/controller/dwc/pcie-designware.h |  9 +++++++++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > b/drivers/pci/controller/dwc/pcie-designware.c
> > index 7d25102..97fb18d 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -466,4 +466,16 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >  		break;
> >  	}
> >  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > +
> > +	if (pci->quirk & DWC_EQUALIZATION_DISABLE) {
> > +		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> > +		val |= PORT_LOGIC_GEN3_EQ_DISABLE;
> > +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> > +	}
> > +
> > +	if (pci->quirk & DWC_EQ_PHASE_2_3_DISABLE) {
> > +		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> > +		val |= PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE;
> > +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> > +	}
> >  }
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > b/drivers/pci/controller/dwc/pcie-designware.h
> > index ffed084..e428b62 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -29,6 +29,10 @@
> >  #define LINK_WAIT_MAX_IATU_RETRIES	5
> >  #define LINK_WAIT_IATU			9
> >
> > +/* Parameters for GEN3 related quirks */
> > +#define DWC_EQUALIZATION_DISABLE	BIT(1)
> > +#define DWC_EQ_PHASE_2_3_DISABLE	BIT(2)
> > +
> >  /* Synopsys-specific PCIe configuration registers */
> >  #define PCIE_PORT_LINK_CONTROL		0x710
> >  #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
> > @@ -60,6 +64,10 @@
> >  #define PCIE_MSI_INTR0_MASK		0x82C
> >  #define PCIE_MSI_INTR0_STATUS		0x830
> >
> > +#define PCIE_PORT_GEN3_RELATED		0x890
> 
> I hadn't noticed this in the previous version - what is the proper name
for this
> register? Does it end in _RELATED?

As per SNPS databook the name of the register is "GEN3_RELATED_OFF". It is
port logic register so, to keep similarity with other port logic registers
in this file we named it as "PCIE_PORT_GEN3_RELATED". 

> 
> Thanks,
> 
> Andrew Murray
> 
> > +#define PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE	BIT(9)
> > +#define PORT_LOGIC_GEN3_EQ_DISABLE		BIT(16)
> > +
> >  #define PCIE_ATU_VIEWPORT		0x900
> >  #define PCIE_ATU_REGION_INBOUND		BIT(31)
> >  #define PCIE_ATU_REGION_OUTBOUND	0
> > @@ -244,6 +252,7 @@ struct dw_pcie {
> >  	struct dw_pcie_ep	ep;
> >  	const struct dw_pcie_ops *ops;
> >  	unsigned int		version;
> > +	unsigned int		quirk;
> >  };
> >
> >  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie,
> > pp)
> > --
> > 2.7.4
> >

