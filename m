Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 895ABDEF73
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 16:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbfJUO1C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 10:27:02 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:59865 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfJUO1C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 10:27:02 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191021142659epoutp04a0b12430d766d7980f4c53d68de22258~Pr7yE5EB50437904379epoutp044
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2019 14:26:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191021142659epoutp04a0b12430d766d7980f4c53d68de22258~Pr7yE5EB50437904379epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571668019;
        bh=lxfujEuLFlBpgvOq3FP32/2a0SQln4xWqqIgM/Agm1w=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=pCP8GckMtaCexjUQMvvG0FlgeKQY+MVTabrGVbE7m3Zu9rbFDhPSBKCJIhG+3r8Pi
         7xYh8KYBpG+vjMhPhR7UkUR+j0nDObZQLP8W6B8KcTgwsijkSPAEO/E0xYnUlzd2PP
         mk6q4JlxaCtj9dJ0scjHEoWPqs3rABChMbUlJZ4k=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20191021142658epcas5p3f2ca0bf2e9e5e4817447831389d50136~Pr7xWDG842456824568epcas5p3m;
        Mon, 21 Oct 2019 14:26:58 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.88.04480.230CDAD5; Mon, 21 Oct 2019 23:26:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20191021142657epcas5p39a644e7b61770a46e3ee8d1aec785b9a~Pr7wj-dV11763717637epcas5p39;
        Mon, 21 Oct 2019 14:26:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191021142657epsmtrp10447734fa0bffe73af5a9ddf9320a010~Pr7wjIdUW0212302123epsmtrp1u;
        Mon, 21 Oct 2019 14:26:57 +0000 (GMT)
X-AuditID: b6c32a4b-ca3ff70000001180-ff-5dadc0326a4e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.63.04081.130CDAD5; Mon, 21 Oct 2019 23:26:57 +0900 (KST)
Received: from pankajdubey02 (unknown [107.111.85.21]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191021142656epsmtip2957dd2df531ef4e52350e6b1dac620af~Pr7vWB4ZI1037310373epsmtip24;
        Mon, 21 Oct 2019 14:26:56 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Andrew Murray'" <andrew.murray@arm.com>
Cc:     "'Anvesh Salveru'" <anvesh.s@samsung.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>, <gustavo.pimentel@synopsys.com>,
        <jingoohan1@gmail.com>, <lorenzo.pieralisi@arm.com>
In-Reply-To: <20191021141714.GT47056@e119886-lin.cambridge.arm.com>
Subject: RE: [PATCH 2/2] PCI: dwc: Add support to handle ZRX-DC Compliant
 PHYs
Date:   Mon, 21 Oct 2019 19:56:55 +0530
Message-ID: <05b801d5881b$981b2cf0$c85186d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHofyUpkW9F4esSgqZqrNFszEeXZwD9REAhAfezFTkBwPFz1gH+I80IpwmXddA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7bCmuq7RgbWxBtNXiFo0/9/OanF210JW
        iyVNGRa77nawW6z4MpPd4vKuOWwWZ+cdZ7N48/sFuwOHx5p5axg9ds66y+6xYFOpR9+WVYwe
        W/Z/ZvT4vEkugC2KyyYlNSezLLVI3y6BK2PP5ofMBbdUKloOdbM2ME6R7WLk5JAQMJGY2PSL
        vYuRi0NIYDejxO4nzxghnE+MEn/fnmSFcL4xSuw6dokVpuXrtoNgtpDAXkaJts32EEWvGSXm
        tu9lAkmwCehLnPsxD6xIREBX4uuq52wgRcwCdxkl1v+8ywiS4BRwlvj67gSYLSwQILF9+hoW
        EJtFQFXi+IG7zCA2r4ClxIK+7+wQtqDEyZlPwGqYBeQltr+dwwxxkYLEz6fLgJZxAC3zk+h6
        rwRRIi7x8ugRsN8kBH6zSez83M0GUe8icenmfChbWOLV8S3sELaUxMv+Nig7X+LH4knMEM0t
        jBKTj8+Fet9e4sCVOSwgy5gFNCXW79KHWMYn0fv7CRNIWEKAV6KjTQiiWk3i+/MzUGfKSDxs
        XsoEYXtIfNnRyTiBUXEWks9mIflsFpIXZiEsW8DIsopRMrWgODc9tdi0wDgvtVyvODG3uDQv
        XS85P3cTIzgxaXnvYNx0zucQowAHoxIP74kla2OFWBPLiitzDzFKcDArifDeMQAK8aYkVlal
        FuXHF5XmpBYfYpTmYFES553EejVGSCA9sSQ1OzW1ILUIJsvEwSnVwNh05Pk/9s8cmvY6HqyK
        l21Xa9/1uPHS8nzo+tbzbmtPMrYWMOfambLemZZxSnuq8K90+QDme3O77iRkWvWmte7evD8i
        YMvfwpuz3t3f8cuuX/m1pt3fdP+7P6zMwwN7HtydfUn2qSlf3XfXgieyp9t/31t00OOe/IrD
        uybL1plmfS2NVjK5v0KJpTgj0VCLuag4EQABrfS6SAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSvK7hgbWxBkeXyVk0/9/OanF210JW
        iyVNGRa77nawW6z4MpPd4vKuOWwWZ+cdZ7N48/sFuwOHx5p5axg9ds66y+6xYFOpR9+WVYwe
        W/Z/ZvT4vEkugC2KyyYlNSezLLVI3y6BK2PP5ofMBbdUKloOdbM2ME6R7WLk5JAQMJH4uu0g
        axcjF4eQwG5GibdtF1kgEjISk1evYIWwhSVW/nvODlH0klHi0sndjCAJNgF9iXM/5oEViQjo
        Snxd9ZwNpIhZ4DGjxKy7e5khOjYxSdzvvQI2llPAWeLruxNg3cICfhIPr15hA7FZBFQljh+4
        ywxi8wpYSizo+84OYQtKnJz5BKiXA2iqnkTbRrBWZgF5ie1v5zBDXKcg8fPpMlaQEhGgkV3v
        lSBKxCVeHj3CPoFReBaSQbMQBs1CMmgWko4FjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1
        kvNzNzGCo0tLcwfj5SXxhxgFOBiVeHhPLFkbK8SaWFZcmXuIUYKDWUmE944BUIg3JbGyKrUo
        P76oNCe1+BCjNAeLkjjv07xjkUIC6YklqdmpqQWpRTBZJg5OqQbGpc3vPxg8SA2QZ/T9NX+Z
        VkZQ2G3JBRzrwx9mrpE6ufPfw62uLvN/lcRlPFZj6unXuffE98Gs7be5ObbuExHL5fBjln7O
        XMTyJ8yCu2lj1YYKtktsF95Fv/Z7tHFuqkHJTzH39XrPD1tdX11uy8MtoJOgM8Os6vjsv7GN
        jq/St++Y7bnwk62aEktxRqKhFnNRcSIA6wEG5aoCAAA=
X-CMS-MailID: 20191021142657epcas5p39a644e7b61770a46e3ee8d1aec785b9a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191021123016epcas5p3ab7100162a8d6d803b117976240f20b4
References: <CGME20191021123016epcas5p3ab7100162a8d6d803b117976240f20b4@epcas5p3.samsung.com>
        <1571660993-30329-1-git-send-email-anvesh.s@samsung.com>
        <20191021140424.GR47056@e119886-lin.cambridge.arm.com>
        <05b301d58819$d962fa00$8c28ee00$@samsung.com>
        <20191021141714.GT47056@e119886-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Andrew Murray <andrew.murray@arm.com>
> Sent: Monday, October 21, 2019 7:47 PM
> To: Pankaj Dubey <pankaj.dubey@samsung.com>
> Cc: 'Anvesh Salveru' <anvesh.s@samsung.com>; linux-pci@vger.kernel.org;
> linux-kernel@vger.kernel.org; bhelgaas@google.com;
> gustavo.pimentel@synopsys.com; jingoohan1@gmail.com;
> lorenzo.pieralisi@arm.com
> Subject: Re: [PATCH 2/2] PCI: dwc: Add support to handle ZRX-DC Compliant
> PHYs
> 
> On Mon, Oct 21, 2019 at 07:44:25PM +0530, Pankaj Dubey wrote:
> >
> >
> > > -----Original Message-----
> > > From: Andrew Murray <andrew.murray@arm.com>
> > > Sent: Monday, October 21, 2019 7:34 PM
> > > To: Anvesh Salveru <anvesh.s@samsung.com>
> > > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > bhelgaas@google.com; gustavo.pimentel@synopsys.com;
> > > jingoohan1@gmail.com; lorenzo.pieralisi@arm.com; Pankaj Dubey
> > > <pankaj.dubey@samsung.com>
> > > Subject: Re: [PATCH 2/2] PCI: dwc: Add support to handle ZRX-DC
> > > Compliant PHYs
> > >
> > > On Mon, Oct 21, 2019 at 05:59:53PM +0530, Anvesh Salveru wrote:
> > > > Many platforms use DesignWare controller but the PHY can be
> > > > different in different platforms. If the PHY is compliant is to
> > > > ZRX-DC specification
> > >
> > > s/is to/to the/
> >
> > OK
> >
> > >
> > > > it helps in low power consumption during power states.
> > >
> > > s/in low/lower/
> > >
> > OK
> > > >
> > > > If current data rate is 8.0 GT/s or higher and PHY is not
> > > > compliant to ZRX-DC specification, then after every 100ms link
> > > > should transition to recovery state during the low power states.
> > > >
> > > > DesignWare controller provides GEN3_ZRXDC_NONCOMPL field in
> > > > GEN3_RELATED_OFF to specify about ZRX-DC compliant PHY.
> > > >
> > > > Platforms with ZRX-DC compliant PHY can set
"snps,phy-zrxdc-compliant"
> > > > property in controller DT node to specify this property to the
> > controller.
> > > >
> > > > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> > > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
> > > > drivers/pci/controller/dwc/pcie-designware.h | 3 +++
> > > >  2 files changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 820488dfeaed..6560d9f765d7 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -556,4 +556,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > > >  		       PCIE_PL_CHK_REG_CHK_REG_START;
> > > >  		dw_pcie_writel_dbi(pci,
PCIE_PL_CHK_REG_CONTROL_STATUS,
> > > val);
> > > >  	}
> > > > +
> > > > +	if (of_property_read_bool(np, "snps,phy-zrxdc-compliant")) {
> > > > +		val = dw_pcie_readl_dbi(pci,
PCIE_PORT_GEN3_RELATED);
> > > > +		val &= ~PORT_LOGIC_GEN3_ZRXDC_NONCOMPL;
> > > > +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED,
val);
> > > > +	}
> > > > +
> > >
> > > Given that this duplicates tegra_pcie_prepare_host in
> > > pcie-tegra194.c, can
> > we
> > > update that driver to adopt this new binding?
> > >
> >
> > Yes, Thanks for highlighting this. Otherwise I was worried that we
> > have one more patch without real user :)
> 
> Indeed :|
> 
> Though besides Tegra, is there any other reason you are adding this?
> 

Yes. We have one internal PCIe RC driver (which we can't disclose/upstream
right now) has this issue and currently we are handling it using this DT
binding. So we would like to upstream common code, so other platform's
driver can use this.

> > We will update pcie-tegra194.c driver and post the patch to adopt this
> > binding.
> 
> It's much appreciated.
> 
> Andrew Murray
> 
> >
> > > Thanks,
> > >
> > > Andrew Murray
> > >
> > > >  }
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > > > b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index 5a18e94e52c8..427a55ec43c6 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -60,6 +60,9 @@
> > > >  #define PCIE_MSI_INTR0_MASK		0x82C
> > > >  #define PCIE_MSI_INTR0_STATUS		0x830
> > > >
> > > > +#define PCIE_PORT_GEN3_RELATED		0x890
> > > > +#define PORT_LOGIC_GEN3_ZRXDC_NONCOMPL		BIT(0)
> > > > +
> > > >  #define PCIE_ATU_VIEWPORT		0x900
> > > >  #define PCIE_ATU_REGION_INBOUND		BIT(31)
> > > >  #define PCIE_ATU_REGION_OUTBOUND	0
> > > > --
> > > > 2.17.1
> > > >
> >

