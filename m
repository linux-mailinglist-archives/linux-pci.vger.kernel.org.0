Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 814C6105EAA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 03:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKVCfe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 21:35:34 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:51529 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfKVCfe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 21:35:34 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191122023529epoutp02aa385e031f861182937955dc55ac3bad~ZW3tDSMYu0460404604epoutp02B
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 02:35:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191122023529epoutp02aa385e031f861182937955dc55ac3bad~ZW3tDSMYu0460404604epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574390129;
        bh=tHRJjMBTQKQJAHt3WUrqgcQ8vEqoveSa1k+dp1SwBbc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=meHKQL5iZIDq4aPudogDtJTnWzGnlwKhmQaFU6plL6045AuNwXdz4dw+dckopD+U4
         04Trix0Z8hPhbCh8Eif83Fd+BTiAkOxP41T8fHwBe4hSKXpGgEjk7wW0SZOvtxmEqE
         1ojSUshQ459o+50GbxA8wOjyRb2A7h/IFZsZLUJQ=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20191122023528epcas5p31255afb402417cd2a8993089245a86d4~ZW3sXaRdK1176411764epcas5p3w;
        Fri, 22 Nov 2019 02:35:28 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.69.04403.07947DD5; Fri, 22 Nov 2019 11:35:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20191122023528epcas5p2f890e915e4b1ed5198b840d9992e9ba4~ZW3r7k1Ln1917619176epcas5p2K;
        Fri, 22 Nov 2019 02:35:28 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191122023528epsmtrp1338ef5e134a8a6377f4485b199947888~ZW3r6xRwI0958709587epsmtrp1x;
        Fri, 22 Nov 2019 02:35:28 +0000 (GMT)
X-AuditID: b6c32a4a-3cbff70000001133-02-5dd74970a5ac
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.88.03814.07947DD5; Fri, 22 Nov 2019 11:35:28 +0900 (KST)
Received: from pankajdubey02 (unknown [107.111.85.21]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191122023526epsmtip2b51b50e830452a5d2c14a76b4d78a58d~ZW3qVqFk60866008660epsmtip2h;
        Fri, 22 Nov 2019 02:35:26 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Gustavo Pimentel'" <Gustavo.Pimentel@synopsys.com>,
        "'Anvesh Salveru'" <anvesh.s@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Cc:     <jingoohan1@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>, <kishon@ti.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
In-Reply-To: <DM6PR12MB40102536205C74F4E41EBD69DA4E0@DM6PR12MB4010.namprd12.prod.outlook.com>
Subject: RE: [PATCH v4 2/2] PCI: dwc: add support to handle ZRX-DC Compliant
 PHYs
Date:   Fri, 22 Nov 2019 08:05:25 +0530
Message-ID: <025601d5a0dd$80a214a0$81e63de0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE1rVtOHv1BqgLHLDW+5IttHzLvfAIdtnviAzgxAgcBnpO1nKieu6gg
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0gTYRjmu9t2N2t5TmNvS6IGRhprJRUXhYaVXBEWGf0RTbvympb7wc4f
        LShES1TU0op01VIykzUJxsyaRWHZKtpStBRMQlDStAQVM2aW2y3yv+d9n+d5n++Bj8TlH8RK
        MsuQw5kNbLZKEiZ69DI2Vm3a26vdWFK1lS760yqmve56Md1QmEm7B0oIumm6lqA7h8sldLf7
        loT22jwSetw/QtD3ersw+tKzV8TOJYzD5kDME+sAwdQ5cxmnvVTCVLrsiHE9n0KMp68VY6ac
        qw6SR8N2ZHDZWXmcWZNwPCxzzlYqMvmjzzZPrStAfkUZkpJAbYbSF15RGQoj5VQbgoF345gw
        TCK46fgiEYYZBG39I6J/ljttnSHLMwRvKqtDwxiCmu6qoEpCacA3axMHcBTVgMDxQxMQ4ZQd
        QcdcS5CQUlqwzXvxAI6kUqFq4AYKYBEVA9N9TcFDMmob+AeHxAKOgLe1Q8E9Tq2HxvoxXHjS
        avg13BgKSwZHd1lIo4DRjldEIBgoGwHXf18LddgNhbffhsyR8M3jIgSshNHLxSFshNm71bhg
        vojgque2WCAS4UXPrYVD5EJCLDx0a4SwZVDhH8ICa6BkUFIsF9Rr4efX96GoaBgsuocJmIF5
        Vw1+Ba2xLqpmXVTNuqiC9X9YHRLZ0QrOxOt1HL/FFG/g8jfwrJ7PNeg2nDTqnSj4zeL2PUaN
        vv3tiCKRaqnsSv4nrVzM5vEWfTsCEldFyZ729mjlsgzWco4zG9PNudkc345WkiKVQlYt/nhM
        TunYHO4Mx5k48z8WI6XKAhT+Oq3GYpxPUkx8Vz94etwyRfS0nDtrj1GZo1JjktcmqFsOSTln
        7yThPp8P+gPlPs+JLqxhuTcv/RrW2tPfp8S61J/jSUNB2uAF9n5zxdJTp0tMRZd9iSlpnbhu
        LoWfCK+QziTNJkdEd92xNO5IPLxrj+/IdnZZvJdO2tiRohLxmeymONzMs38BkLMDz2IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSvG6B5/VYgwdnJC2a/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2CzOzjvOZvHm9wt2i6XXLzJZtO49wu7A7bFm3hpG
        j52z7rJ7LNhU6rFpVSebR9+WVYweW/Z/ZvQ4fmM7k8fnTXIBHFFcNimpOZllqUX6dglcGX3X
        5rAXrJSp+DqtpoFxqXgXIyeHhICJxPzdF1i6GLk4hAR2M0p8eT2PDSIhIzF59QpWCFtYYuW/
        5+wQRS8ZJVq+/mEESbAJ6Euc+zGPFSQhIrCMUeLD3e3MIA6zwCZGibeLn7JBtMxjkjjyfCnY
        XE6BWIl5/84yg9jCAoESh/dvYQGxWQRUJb7cWAFm8wpYSvx++IQVwhaUODnzCVicWUBbovdh
        KyOMvWzha2aI+xQkfj5dBlYvIuAmseZyF1S9uMTLo0fYJzAKz0IyahaSUbOQjJqFpGUBI8sq
        RsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgqNTS2sF44kT8IUYBDkYlHt4J5ddihVgT
        y4orcw8xSnAwK4nw7rl+JVaINyWxsiq1KD++qDQntfgQozQHi5I4r3z+sUghgfTEktTs1NSC
        1CKYLBMHp1QDY/8mvir7p7UBPYImL9LNLvnYai1/zdN+e9ZemTOqp978fMV5vPjzSZ1FWT3m
        u0sX1VzZF3IsfAtPuL/VYUfBNw/2ZU89NW1zoopIx+4nq/a86U6e4dCwp+yG3SNnYauUozpi
        8y2Ui8QZFzBLS8dan26foO4oPOe45brtJ+/9Ojufy8fkhfhdHyWW4oxEQy3mouJEAD8RexHG
        AgAA
X-CMS-MailID: 20191122023528epcas5p2f890e915e4b1ed5198b840d9992e9ba4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191121032041epcas5p433066ebc6a07b73a1949da26e55e9b2f
References: <1574306408-4360-1-git-send-email-anvesh.s@samsung.com>
        <CGME20191121032041epcas5p433066ebc6a07b73a1949da26e55e9b2f@epcas5p4.samsung.com>
        <1574306408-4360-3-git-send-email-anvesh.s@samsung.com>
        <DM6PR12MB40102536205C74F4E41EBD69DA4E0@DM6PR12MB4010.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Gustavo Pimentel <Gustavo.Pimentel=40synopsys.com>
> Sent: Thursday, November 21, 2019 7:25 PM
> To: Anvesh Salveru <anvesh.s=40samsung.com>; linux-kernel=40vger.kernel.o=
rg;
> linux-pci=40vger.kernel.org
> Cc: jingoohan1=40gmail.com; pankaj.dubey=40samsung.com;
> lorenzo.pieralisi=40arm.com; andrew.murray=40arm.com; bhelgaas=40google.c=
om;
> kishon=40ti.com; robh+dt=40kernel.org; mark.rutland=40arm.com
> Subject: RE: =5BPATCH v4 2/2=5D PCI: dwc: add support to handle ZRX-DC Co=
mpliant
> PHYs
>=20
> On Thu, Nov 21, 2019 at 3:20:8, Anvesh Salveru <anvesh.s=40samsung.com>
> wrote:
>=20
> > Many platforms use DesignWare controller but the PHY can be different
> > in different platforms. If the PHY is compliant is to ZRX-DC
> > specification it helps in low power consumption during power states.
> >
> > If current data rate is 8.0 GT/s or higher and PHY is not compliant to
> > ZRX-DC specification, then after every 100ms link should transition to
> > recovery state during the low power states.
> >
> > DesignWare controller provides GEN3_ZRXDC_NONCOMPL field in
> > GEN3_RELATED_OFF to specify about ZRX-DC compliant PHY.
> >
> > Platforms with ZRX-DC compliant PHY can set phy_zrxdc_compliant
> > variable to specify this property to the controller.
> >
> > Signed-off-by: Anvesh Salveru <anvesh.s=40samsung.com>
> > Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c =7C 6 ++++++
> > drivers/pci/controller/dwc/pcie-designware.h =7C 4 ++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > b/drivers/pci/controller/dwc/pcie-designware.c
> > index 820488d..36a01b7 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > =40=40 -556,4 +556,10 =40=40 void dw_pcie_setup(struct dw_pcie *pci)
> >  		       PCIE_PL_CHK_REG_CHK_REG_START;
> >  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS,
> val);
> >  	=7D
> > +
> > +	if (pci->phy_zrxdc_compliant) =7B
> > +		val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> > +		val &=3D =7EPORT_LOGIC_GEN3_ZRXDC_NONCOMPL;
> > +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> > +	=7D
> >  =7D
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > b/drivers/pci/controller/dwc/pcie-designware.h
> > index 5a18e94..f43f986 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > =40=40 -60,6 +60,9 =40=40
> >  =23define PCIE_MSI_INTR0_MASK		0x82C
> >  =23define PCIE_MSI_INTR0_STATUS		0x830
> >
> > +=23define PCIE_PORT_GEN3_RELATED		0x890
> > +=23define PORT_LOGIC_GEN3_ZRXDC_NONCOMPL	BIT(0)
> > +
> >  =23define PCIE_ATU_VIEWPORT		0x900
> >  =23define PCIE_ATU_REGION_INBOUND		BIT(31)
> >  =23define PCIE_ATU_REGION_OUTBOUND	0
> > =40=40 -249,6 +252,7 =40=40 struct dw_pcie =7B
> >  	void __iomem		*atu_base;
> >  	u32			num_viewport;
> >  	u8			iatu_unroll_enabled;
> > +	bool			phy_zrxdc_compliant;
>=20
> Typically is used u8 instead of bool, due to platform compatibility.
> I'd guess that checkpatch script should have reported this. Did you use i=
t?

Checkpatch didn't report any error/warning.=20
We used bool here as phy_zrxdc_compliant will store the value returned by o=
f_property_read_bool API.=20
I can see many places in drivers/pci/ where this API is used the value is s=
tored in bool itself.

>=20
> >  	struct pcie_port	pp;
> >  	struct dw_pcie_ep	ep;
> >  	const struct dw_pcie_ops *ops;
> > --
> > 2.7.4
>=20


