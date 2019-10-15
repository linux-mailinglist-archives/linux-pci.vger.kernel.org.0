Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE01D6D67
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 04:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfJOC61 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 22:58:27 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:25635 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfJOC61 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Oct 2019 22:58:27 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191015025824epoutp013acfdc6a2b4ec1115959f7cbba7c8722~Nsq3JB81b1124311243epoutp01G
        for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2019 02:58:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191015025824epoutp013acfdc6a2b4ec1115959f7cbba7c8722~Nsq3JB81b1124311243epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571108304;
        bh=i+peJ+7fEMYh82B4B0NomMqnEheNBzB/007WYVJmYZg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=tsEVTTeDx26if3SIM1kHW/QAdEzE+bxsXMEsG0ehWVZD80sVJG4jJiJo/kWfNHtQf
         lmovWQCRgUNSMfYkhQ+6Qt8wZBKi+nk1qfaJP2PbwPz523s1tsH7qFQ9AklpJElIPC
         tBZ5eb4w5KT78sPEVBHIwK5cmBO5Wgr+I4wyiAvA=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20191015025823epcas5p46985ac7eaba4daf9e2a2cbb54708c139~Nsq2ZG69-0186501865epcas5p4z;
        Tue, 15 Oct 2019 02:58:23 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.0C.04480.FC535AD5; Tue, 15 Oct 2019 11:58:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20191015025822epcas5p3e076ffcca43610c3869db30ddda3263e~Nsq1vOWSJ0596905969epcas5p3E;
        Tue, 15 Oct 2019 02:58:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191015025822epsmtrp1bfd166b53b4b45dc64607ae5bc0ceeaa~Nsq1uTQTi1548415484epsmtrp1z;
        Tue, 15 Oct 2019 02:58:22 +0000 (GMT)
X-AuditID: b6c32a4b-cbbff70000001180-97-5da535cf3dbf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.E2.04081.EC535AD5; Tue, 15 Oct 2019 11:58:22 +0900 (KST)
Received: from pankajdubey02 (unknown [107.111.85.21]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191015025821epsmtip12bd37455fbcc753d529f5f89216a9160~Nsq0XGsUO1373813738epsmtip1V;
        Tue, 15 Oct 2019 02:58:21 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>, <andrew.murray@arm.com>,
        <gustavo.pimentel@synopsys.com>, <jingoohan1@gmail.com>,
        <vidyas@nvidia.com>, "'Anvesh Salveru'" <anvesh.s@samsung.com>
In-Reply-To: <20191014151349.GA2928@e121166-lin.cambridge.arm.com>
Subject: RE: [PATCH v2] PCI: dwc: Add support to add GEN3 related
 equalization quirks
Date:   Tue, 15 Oct 2019 08:28:20 +0530
Message-ID: <062d01d58304$683306a0$389913e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGpt1aXoM8skySOYXB2n3mBAGb+JQKeZApdAfxzZgCnjcJR0A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7bCmhu5506WxBrMPqVs0/9/OanF210JW
        iyVNGRa77nawW6z4MpPd4vKuOWwWZ+cdZ7N48/sFu8W17bwOnB5r5q1h9Ng56y67x4JNpR69
        ze/YPPq2rGL02LL/M6PH501yAexRXDYpqTmZZalF+nYJXBltW04zF7QrV1z/84KpgfGNTBcj
        J4eEgInE4fnrmEFsIYHdjBLTv6R3MXIB2Z8YJTa+fcgG4XxjlDg9+wUjTMf+/xeYIRJ7GSUu
        zfgB5bxmlNh54jILSBWbgL7EuR/zWEFsEQFTiSOvPrKDFDELvGOU2Pv2IFgRp4CTxOalW8GW
        CwuES5zYtgfMZhFQlZgy4w7QOg4OXgFLiXvHwMK8AoISJ2c+AWtlFpCX2P52DjPERQoSP58u
        g9rlJHF1wz92iBpxiZdHj4DtlRBoZ5dY1/4DbKaEgIvExXZ5iF5hiVfHt7BD2FISL/vboOx8
        iR+LJzFD9LYwSkw+PpcVImEvceDKHBaQOcwCmhLrd+lD7OKT6P39hAliPK9ER5sQRLWaxPfn
        Z6DOlJF42LyUCcL2kHjwvZFlAqPiLCSfzULy2SwkH8xCWLaAkWUVo2RqQXFuemqxaYFxXmq5
        XnFibnFpXrpecn7uJkZwotLy3sG46ZzPIUYBDkYlHl6BliWxQqyJZcWVuYcYJTiYlUR454OE
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ805ivRojJJCeWJKanZpakFoEk2Xi4JRqYOT6ddIuf53F
        6TuTzOZYv2iNb/6WMaV16hVjvplT755ZyDcprnLB9cefpCIvnLxjvjzmk7+XfW64u/+dZrOV
        MuUmVXt9LvVqHDgbWLhHWvvG3JUiD85VlXW85Xt7ZOW1y8J6ai6fGGXY806/eHmC9ykvA/vy
        LvEknVXXzZdMcc2OejfV9O8v9z4lluKMREMt5qLiRAANC8LmUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnO4506WxBncvmVo0/9/OanF210JW
        iyVNGRa77nawW6z4MpPd4vKuOWwWZ+cdZ7N48/sFu8W17bwOnB5r5q1h9Ng56y67x4JNpR69
        ze/YPPq2rGL02LL/M6PH501yAexRXDYpqTmZZalF+nYJXBltW04zF7QrV1z/84KpgfGNTBcj
        J4eEgInE/v8XmLsYuTiEBHYzSmzZ8psNIiEjMXn1ClYIW1hi5b/n7BBFLxklLq/YzgSSYBPQ
        lzj3Yx5YkYiAqcSRVx/BipgFvjFKrHg8nQ2i4wKjxIcDexhBqjgFnCQ2L93KDGILC4RK/P/1
        BsxmEVCVmDLjDlANBwevgKXEvWNgYV4BQYmTM5+wgISZBfQk2jaCTWEWkJfY/nYOM8RxChI/
        ny6DusFJ4uqGf+wQNeISL48eYZ/AKDwLyaRZCJNmIZk0C0nHAkaWVYySqQXFuem5xYYFhnmp
        5XrFibnFpXnpesn5uZsYwfGmpbmD8fKS+EOMAhyMSjy8Ai1LYoVYE8uKK3MPMUpwMCuJ8M4H
        CfGmJFZWpRblxxeV5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1CCbLxMEp1cBo47Nw1t7k
        /zpBfa+1pe+cfGEmNffI4mm52VuK7rotu+n2NXAuu95cWYPX/3iO/VfW5jr03HAeT8K3rKz5
        XYv2cV5b9n2fV9J6zQc30wrNlohmzNdb1p9S4fLKrHvTg+XlOtvuF5fyztP25Z16vKrqsFq6
        6fq/vnXBO46vLHyZLn2qrMh2/14eJZbijERDLeai4kQAn2shurMCAAA=
X-CMS-MailID: 20191015025822epcas5p3e076ffcca43610c3869db30ddda3263e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191014071838epcas5p2901e45c978e5a9d6dfbdde2dadea6d9d
References: <CGME20191014071838epcas5p2901e45c978e5a9d6dfbdde2dadea6d9d@epcas5p2.samsung.com>
        <1571037509-20284-1-git-send-email-pankaj.dubey@samsung.com>
        <20191014151349.GA2928@e121166-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Monday, October 14, 2019 8:44 PM
> To: Pankaj Dubey <pankaj.dubey@samsung.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; andrew.murray@arm.com;
> gustavo.pimentel@synopsys.com; jingoohan1@gmail.com; vidyas@nvidia.com;
> Anvesh Salveru <anvesh.s@samsung.com>
> Subject: Re: [PATCH v2] PCI: dwc: Add support to add GEN3 related
equalization
> quirks
> 
> On Mon, Oct 14, 2019 at 12:48:29PM +0530, Pankaj Dubey wrote:
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
> > Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> > Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
> > Changes w.r.t v1:
> >  - Rebased on latest linus/master
> >  - Added Reviewed-by and Acked-by
> >
> >  drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++++
> > drivers/pci/controller/dwc/pcie-designware.h |  9 +++++++++
> >  2 files changed, 21 insertions(+)
> 
> So this is v3 not v2, right ?
> 

Yes, you are right. I missed this. 
This can be discarded, I will resend the patch with v3 tag.

> Here is v2:
> 
> https://protect2.fireeye.com/url?k=47b7cdf58f33e5e1.47b646ba-
> 8ad463719e64eba8&u=https://patchwork.ozlabs.org/patch/1161958/
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > b/drivers/pci/controller/dwc/pcie-designware.c
> > index 820488d..e247d6d 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -556,4 +556,16 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >  		       PCIE_PL_CHK_REG_CHK_REG_START;
> >  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS,
> val);
> >  	}
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
> > index 5a18e94..7d3fe6f 100644
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
> > +#define PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE	BIT(9)
> > +#define PORT_LOGIC_GEN3_EQ_DISABLE		BIT(16)
> > +
> >  #define PCIE_ATU_VIEWPORT		0x900
> >  #define PCIE_ATU_REGION_INBOUND		BIT(31)
> >  #define PCIE_ATU_REGION_OUTBOUND	0
> > @@ -253,6 +261,7 @@ struct dw_pcie {
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

