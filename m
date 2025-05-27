Return-Path: <linux-pci+bounces-28491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CADF2AC60F2
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 06:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9C91BA766E
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 04:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563461F4184;
	Wed, 28 May 2025 04:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BOTopS4M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1121FCD1F
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748408006; cv=none; b=L18kL5IY0j7q/R7JrekoJwK+30FAk71owQmIt+XC3LYyODa8CDXjDT4d7EkaWGUtNR+OZmRY50ZAExzMALGtQaGq3Wbs4vKe5SA4b8YApTa5hUngBLO+EWRZOhe9NhRWRyAnCJpfc0sCj0Ft7saFwvTjI6n9cuJwdAr/HOhdQq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748408006; c=relaxed/simple;
	bh=c/sxX05VgTpQwoTq0JFwL7QdS62E2YCa3nCRYWbBdrc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=sFxnMO0cmNBndJldH5WSDvWXnnCrEapgwmdt//gkVX8AQbVs7JuWwK5xP1F3gvPYkwbyQbPf2unetHpd4KGd70dTB35rBPJwhAXhyuw7hepT4YAseacpWYrhKX5ylbAZprf1GfjT9CNVpm18+fO3mXqJ+/iN74JkRoiWfV3ZpN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BOTopS4M; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250528045322epoutp02ce1daba3454dd93d02537500c3cb2c2d~Dl9CeSEBv2400924009epoutp02B
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:53:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250528045322epoutp02ce1daba3454dd93d02537500c3cb2c2d~Dl9CeSEBv2400924009epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748408002;
	bh=0DlBYAgEzt9uc9jY7f+q2m1ViLi1AyD0CUt4F5l7nEs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=BOTopS4MlYz1jKjJKA7WE7HcNW8sgjWl1pwLDKmumuWizIJw/CpDSBQlOKTtz6Tg9
	 iZF4NRLsYXp34PZCqNljlUgQWxjK61PmoE/qLlldcAY8WT15JvELP3rfRgbPes8xEh
	 AS5lzMyLbwUWkagJUd/7UoLzSPHaieglw6cbaAvU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250528045322epcas5p207f0f54638956dd28eb310e57bc0dde2~Dl9CA7nGT3262532625epcas5p2t;
	Wed, 28 May 2025 04:53:22 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.178]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4b6cZm4qCNz2SSKs; Wed, 28 May
	2025 04:53:20 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250527104517epcas5p2714a19318a97aae43e8a5c70e83d4ce2~DXHA6Jtmy1647516475epcas5p2q;
	Tue, 27 May 2025 10:45:17 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250527104517epsmtrp2588b808e7facbaffcd6f3c90a8cc520e~DXHA5WQdg3063930639epsmtrp2U;
	Tue, 27 May 2025 10:45:17 +0000 (GMT)
X-AuditID: b6c32a52-41dfa70000004c16-e4-683597bd760b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	01.28.19478.DB795386; Tue, 27 May 2025 19:45:17 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250527104514epsmtip15b038718e08c7388a725cd551e415f1e~DXG_F3TSl0476404764epsmtip10;
	Tue, 27 May 2025 10:45:14 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.or>,
	<linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alim.akhtar@samsung.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <jh80.chung@samsung.com>
In-Reply-To: <20250521-certain-quoll-from-vega-11885b@kuoka>
Subject: RE: [PATCH 08/10] phy: exynos: Add PCIe PHY support for FSD SoC
Date: Tue, 27 May 2025 16:15:13 +0530
Message-ID: <0e2701dbcef4$6f5f24d0$4e1d6e70$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKa2HaEso6x90WQFKmaYw3pYxuT6gHscA4TApjo2xABu7x/m7I2Furw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7bCSnO7e6aYZBs9eCFo8mLeNzeLvpGPs
	FkuaMizW7D3HZDH/yDlWixu/2lgtVnyZyW5xtPU/s8XLWffYLM6f38Bu0dDzm9Vi0+NrrBaX
	d81hszg77zibxYRV31gszn5fwGTR8qeFxWLtkbvsFndbOlkt/u/ZwW6x884JZgdRj9+/JjF6
	7Jx1l91jwaZSj02rOtk87lzbw+bx5Mp0Jo/NS+o9+rasYvQ48nU6i8fnTXIBXFFcNimpOZll
	qUX6dglcGZM/vWYq+Bpb0bD6NFsD40G/LkZODgkBE4lVUyazdDFycQgJbGeUuHB0MSNEQlLi
	88V1TBC2sMTKf8/ZIYqeMUrs7O1kAUmwCehIPLnyhxnEFhHQldh8YzlYEbPAdhaJM0sfMkJ0
	vGaUWPi4H2wsp4CNxIyGY2BjhQU8JLY1LACLswioSnw+cZQVxOYVsJT4d3EBlC0ocXLmE7Bt
	zALaEr0PWxlh7GULXzNDnKcg8fPpMlaIK9wkph+5wQpRIy5x9GcP8wRG4VlIRs1CMmoWklGz
	kLQsYGRZxSiaWlCcm56bXGCoV5yYW1yal66XnJ+7iRGcArSCdjAuW/9X7xAjEwfjIUYJDmYl
	Ed5tE0wyhHhTEiurUovy44tKc1KLDzFKc7AoifMq53SmCAmkJ5akZqemFqQWwWSZODilGpgW
	3NjwvUr6U3yfzcvPWdPsV0b5BL9Tb9fa5N/ZXnKU+9T+hP99a+3k1891eqOpKOXJ1LBfQWXn
	sRtPjif7m54/kPJEwn3p9g+X9cPrv1vGxO1hlp83RyF9A9ukdt47WW9SA1c2X6m6/6ZkTn3G
	A/WFtx+f3Wz84J9I7LcCy79Hdli+jzE9P3e3dal6/b0jjPFONbV6Nc2n88+wxRw5rbG4O2Oi
	Y+wkbdsj8+dJSLi8fSBYU9RcOFHzuanGH0P/hfkrDRKN5KoLY6ffmiOTI947Y+PhqZ/4ttis
	XT9txVOPr/yXm2S/1cseYz9+TDq1YPMRTX/5DW5Cb5xu90itDuFVfpjZpmKW/a6jvKtJqEyJ
	pTgj0VCLuag4EQC/ATkXcAMAAA==
X-CMS-MailID: 20250527104517epcas5p2714a19318a97aae43e8a5c70e83d4ce2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193256epcas5p442e9549fd8fd810522f960df74c22e34
References: <20250518193152.63476-1-shradha.t@samsung.com>
	<CGME20250518193256epcas5p442e9549fd8fd810522f960df74c22e34@epcas5p4.samsung.com>
	<20250518193152.63476-9-shradha.t@samsung.com>
	<20250521-certain-quoll-from-vega-11885b@kuoka>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 21 May 2025 15:11
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: linux-pci=40vger.kernel.org; devicetree=40vger.kernel.org; linux-arm-=
kernel=40lists.infradead.org; linux-samsung-soc=40vger.kernel.or;
> linux-kernel=40vger.kernel.org; linux-phy=40lists.infradead.org; manivann=
an.sadhasivam=40linaro.org; lpieralisi=40kernel.org;
> kw=40linux.com; robh=40kernel.org; bhelgaas=40google.com; jingoohan1=40gm=
ail.com; krzk+dt=40kernel.org; conor+dt=40kernel.org;
> alim.akhtar=40samsung.com; vkoul=40kernel.org; kishon=40kernel.org; arnd=
=40arndb.de; m.szyprowski=40samsung.com;
> jh80.chung=40samsung.com
> Subject: Re: =5BPATCH 08/10=5D phy: exynos: Add PCIe PHY support for FSD =
SoC
>=20
> On Mon, May 19, 2025 at 01:01:50AM GMT, Shradha Todi wrote:
> > Add PCIe PHY support for Tesla FSD SoC.
> >
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > ---
> >  drivers/phy/samsung/phy-exynos-pcie.c =7C 357
> > +++++++++++++++++++++++++-
> >  1 file changed, 356 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/phy/samsung/phy-exynos-pcie.c
> > b/drivers/phy/samsung/phy-exynos-pcie.c
> > index 53c9230c2907..0e4c00c1121e 100644
> > --- a/drivers/phy/samsung/phy-exynos-pcie.c
> > +++ b/drivers/phy/samsung/phy-exynos-pcie.c
> > =40=40 -34,11 +34,121 =40=40
> >  /* PMU PCIE PHY isolation control */
> >  =23define EXYNOS5433_PMU_PCIE_PHY_OFFSET		0x730
> >
> > +/* FSD: PCIe PHY common registers */
> > +=23define FSD_PCIE_PHY_TRSV_CMN_REG03	0x000c
> > +=23define FSD_PCIE_PHY_TRSV_CMN_REG01E	0x0078
> > +=23define FSD_PCIE_PHY_TRSV_CMN_REG02D	0x00b4
> > +=23define FSD_PCIE_PHY_TRSV_CMN_REG031	0x00c4
> > +=23define FSD_PCIE_PHY_TRSV_CMN_REG036	0x00d8
> > +=23define FSD_PCIE_PHY_TRSV_CMN_REG05F	0x017c
> > +=23define FSD_PCIE_PHY_TRSV_CMN_REG060	0x0180
> > +=23define FSD_PCIE_PHY_TRSV_CMN_REG062	0x0188
> > +=23define FSD_PCIE_PHY_TRSV_CMN_REG061	0x0184
> > +=23define FSD_PCIE_PHY_AGG_BIF_RESET	0x0200
> > +=23define FSD_PCIE_PHY_AGG_BIF_CLOCK	0x0208
> > +=23define FSD_PCIE_PHY_CMN_RESET		0x0228
> > +
> > +/* FSD: PCIe PHY lane registers */
> > +=23define FSD_PCIE_PHY_LANE_OFFSET	0x400
> > +=23define FSD_PCIE_PHY_TRSV_REG001_LN_N	0x404
> > +=23define FSD_PCIE_PHY_TRSV_REG002_LN_N	0x408
> > +=23define FSD_PCIE_PHY_TRSV_REG005_LN_N	0x414
> > +=23define FSD_PCIE_PHY_TRSV_REG006_LN_N	0x418
> > +=23define FSD_PCIE_PHY_TRSV_REG007_LN_N	0x41c
> > +=23define FSD_PCIE_PHY_TRSV_REG009_LN_N	0x424
> > +=23define FSD_PCIE_PHY_TRSV_REG00A_LN_N	0x428
> > +=23define FSD_PCIE_PHY_TRSV_REG00C_LN_N	0x430
> > +=23define FSD_PCIE_PHY_TRSV_REG012_LN_N	0x448
> > +=23define FSD_PCIE_PHY_TRSV_REG013_LN_N	0x44c
> > +=23define FSD_PCIE_PHY_TRSV_REG014_LN_N	0x450
> > +=23define FSD_PCIE_PHY_TRSV_REG015_LN_N	0x454
> > +=23define FSD_PCIE_PHY_TRSV_REG016_LN_N	0x458
> > +=23define FSD_PCIE_PHY_TRSV_REG018_LN_N	0x460
> > +=23define FSD_PCIE_PHY_TRSV_REG020_LN_N	0x480
> > +=23define FSD_PCIE_PHY_TRSV_REG026_LN_N	0x498
> > +=23define FSD_PCIE_PHY_TRSV_REG029_LN_N	0x4a4
> > +=23define FSD_PCIE_PHY_TRSV_REG031_LN_N	0x4c4
> > +=23define FSD_PCIE_PHY_TRSV_REG036_LN_N	0x4d8
> > +=23define FSD_PCIE_PHY_TRSV_REG039_LN_N	0x4e4
> > +=23define FSD_PCIE_PHY_TRSV_REG03B_LN_N	0x4ec
> > +=23define FSD_PCIE_PHY_TRSV_REG03C_LN_N	0x4f0
> > +=23define FSD_PCIE_PHY_TRSV_REG03E_LN_N	0x4f8
> > +=23define FSD_PCIE_PHY_TRSV_REG03F_LN_N	0x4fc
> > +=23define FSD_PCIE_PHY_TRSV_REG043_LN_N	0x50c
> > +=23define FSD_PCIE_PHY_TRSV_REG044_LN_N	0x510
> > +=23define FSD_PCIE_PHY_TRSV_REG046_LN_N	0x518
> > +=23define FSD_PCIE_PHY_TRSV_REG048_LN_N	0x520
> > +=23define FSD_PCIE_PHY_TRSV_REG049_LN_N	0x524
> > +=23define FSD_PCIE_PHY_TRSV_REG04E_LN_N	0x538
> > +=23define FSD_PCIE_PHY_TRSV_REG052_LN_N	0x548
> > +=23define FSD_PCIE_PHY_TRSV_REG068_LN_N	0x5a0
> > +=23define FSD_PCIE_PHY_TRSV_REG069_LN_N	0x5a4
> > +=23define FSD_PCIE_PHY_TRSV_REG06A_LN_N	0x5a8
> > +=23define FSD_PCIE_PHY_TRSV_REG06B_LN_N	0x5ac
> > +=23define FSD_PCIE_PHY_TRSV_REG07B_LN_N	0x5ec
> > +=23define FSD_PCIE_PHY_TRSV_REG083_LN_N	0x60c
> > +=23define FSD_PCIE_PHY_TRSV_REG084_LN_N	0x610
> > +=23define FSD_PCIE_PHY_TRSV_REG086_LN_N	0x618
> > +=23define FSD_PCIE_PHY_TRSV_REG087_LN_N	0x61c
> > +=23define FSD_PCIE_PHY_TRSV_REG08B_LN_N	0x62c
> > +=23define FSD_PCIE_PHY_TRSV_REG09C_LN_N	0x670
> > +=23define FSD_PCIE_PHY_TRSV_REG09D_LN_N	0x674
> > +=23define FSD_PCIE_PHY_TRSV_REG09E_LN_N	0x678
> > +=23define FSD_PCIE_PHY_TRSV_REG09F_LN_N	0x67c
> > +=23define FSD_PCIE_PHY_TRSV_REG0A2_LN_N	0x688
> > +=23define FSD_PCIE_PHY_TRSV_REG0A4_LN_N	0x690
> > +=23define FSD_PCIE_PHY_TRSV_REG0CE_LN_N	0x738
> > +=23define FSD_PCIE_PHY_TRSV_REG0FC_LN_N	0x7f0
> > +=23define FSD_PCIE_PHY_TRSV_REG0FD_LN_N	0x7f4
> > +=23define FSD_PCIE_PHY_TRSV_REG0FE_LN_N	0x7f8
> > +=23define FSD_PCIE_PHY_TRSV_REG0CE_LN_1	0xb38
> > +=23define FSD_PCIE_PHY_TRSV_REG0CE_LN_2	0xf38
> > +=23define FSD_PCIE_PHY_TRSV_REG0CE_LN_3	0x1338
> > +
> > +/* FSD: PCIe PCS registers */
> > +=23define FSD_PCIE_PCS_BRF_0		0x0004
> > +=23define FSD_PCIE_PCS_BRF_1		0x0804
> > +=23define FSD_PCIE_PCS_CLK		0x0180
> > +
> > +/* FSD: PCIe SYSREG registers */
> > +=23define FSD_PCIE_SYSREG_PHY_0_CON_MASK			0x3ff
> > +=23define FSD_PCIE_SYSREG_PHY_0_CON			0x042C
> > +=23define FSD_PCIE_SYSREG_PHY_0_REF_SEL_MASK		0x3
> > +=23define FSD_PCIE_SYSREG_PHY_0_REF_SEL			(0x2 << 0)
> > +=23define FSD_PCIE_SYSREG_PHY_0_SSC_EN_MASK		0x8
> > +=23define FSD_PCIE_SYSREG_PHY_0_SSC_EN			BIT(3)
> > +=23define FSD_PCIE_SYSREG_PHY_0_AUX_EN_MASK		0x10
> > +=23define FSD_PCIE_SYSREG_PHY_0_AUX_EN			BIT(4)
> > +=23define FSD_PCIE_SYSREG_PHY_0_CMN_RSTN_MASK		0x100
> > +=23define FSD_PCIE_SYSREG_PHY_0_CMN_RSTN			BIT(8)
> > +=23define FSD_PCIE_SYSREG_PHY_0_INIT_RSTN_MASK		0x200
> > +=23define FSD_PCIE_SYSREG_PHY_0_INIT_RSTN			BIT(9)
> > +
> > +=23define FSD_PCIE_SYSREG_PHY_1_CON_MASK			0x1ff
> > +=23define FSD_PCIE_SYSREG_PHY_1_CON			0x0500
> > +=23define FSD_PCIE_SYSREG_PHY_1_REF_SEL_MASK		0x30
> > +=23define FSD_PCIE_SYSREG_PHY_1_REF_SEL			(0x2 << 4)
> > +=23define FSD_PCIE_SYSREG_PHY_1_SSC_EN_MASK		0x80
> > +=23define FSD_PCIE_SYSREG_PHY_1_SSC_EN			BIT(7)
> > +=23define FSD_PCIE_SYSREG_PHY_1_AUX_EN_MASK		0x1
> > +=23define FSD_PCIE_SYSREG_PHY_1_AUX_EN			BIT(0)
> > +=23define FSD_PCIE_SYSREG_PHY_1_CMN_RSTN_MASK		0x2
> > +=23define FSD_PCIE_SYSREG_PHY_1_CMN_RSTN			BIT(1)
> > +=23define FSD_PCIE_SYSREG_PHY_1_INIT_RSTN_MASK		0x8
> > +=23define FSD_PCIE_SYSREG_PHY_1_INIT_RSTN			BIT(3)
> > +
> >  /* For Exynos pcie phy */
> >  struct exynos_pcie_phy =7B
> >  	void __iomem *base;
> > +	void __iomem *pcs_base;
> >  	struct regmap *pmureg;
> >  	struct regmap *fsysreg;
> > +	int phy_id;
> > +	const struct samsung_drv_data *drv_data; =7D;
> > +
> > +struct samsung_drv_data =7B
> > +	const struct phy_ops *phy_ops;
> >  =7D;
> >
> >  static void exynos_pcie_phy_writel(void __iomem *base, u32 val, u32
> > offset) =40=40 -133,9 +243,244 =40=40 static const struct phy_ops exyno=
s5433_phy_ops =3D =7B
> >  	.owner		=3D THIS_MODULE,
> >  =7D;
> >
> > +struct fsd_pcie_phy_pdata =7B
> > +	u32 phy_con_mask;
> > +	u32 phy_con;
> > +	u32 phy_ref_sel_mask;
> > +	u32 phy_ref_sel;
> > +	u32 phy_ssc_en_mask;
> > +	u32 phy_ssc_en;
> > +	u32 phy_aux_en_mask;
> > +	u32 phy_aux_en;
> > +	u32 phy_cmn_rstn_mask;
> > +	u32 phy_cmn_rstn;
> > +	u32 phy_init_rstn_mask;
> > +	u32 phy_init_rstn;
> > +	u32 num_lanes;
> > +	u32 lane_offset;
> > +=7D;
> > +
> > +struct fsd_pcie_phy_pdata fsd_phy_con=5B=5D =3D =7B
> > +	=7B
>=20
> Why this is global and RW?
>=20
> > +	.phy_con		=3D FSD_PCIE_SYSREG_PHY_0_CON,
> > +	.phy_con_mask		=3D FSD_PCIE_SYSREG_PHY_0_CON_MASK,
> > +	.phy_ref_sel_mask	=3D FSD_PCIE_SYSREG_PHY_0_REF_SEL_MASK,
> > +	.phy_ref_sel		=3D FSD_PCIE_SYSREG_PHY_0_REF_SEL,
> > +	.phy_ssc_en_mask	=3D FSD_PCIE_SYSREG_PHY_0_SSC_EN_MASK,
> > +	.phy_ssc_en		=3D FSD_PCIE_SYSREG_PHY_0_SSC_EN,
> > +	.phy_aux_en_mask	=3D FSD_PCIE_SYSREG_PHY_0_AUX_EN_MASK,
> > +	.phy_aux_en		=3D FSD_PCIE_SYSREG_PHY_0_AUX_EN,
> > +	.phy_cmn_rstn_mask	=3D FSD_PCIE_SYSREG_PHY_0_CMN_RSTN_MASK,
> > +	.phy_cmn_rstn		=3D FSD_PCIE_SYSREG_PHY_0_CMN_RSTN,
> > +	.phy_init_rstn_mask	=3D FSD_PCIE_SYSREG_PHY_0_INIT_RSTN_MASK,
> > +	.phy_init_rstn		=3D FSD_PCIE_SYSREG_PHY_0_INIT_RSTN,
> > +	.num_lanes		=3D 0x4,
> > +	.lane_offset		=3D FSD_PCIE_PHY_LANE_OFFSET,
> > +	=7D,
> > +	=7B
> > +	.phy_con		=3D FSD_PCIE_SYSREG_PHY_1_CON,
> > +	.phy_con_mask		=3D FSD_PCIE_SYSREG_PHY_1_CON_MASK,
> > +	.phy_ref_sel_mask	=3D FSD_PCIE_SYSREG_PHY_1_REF_SEL_MASK,
> > +	.phy_ref_sel		=3D FSD_PCIE_SYSREG_PHY_1_REF_SEL,
> > +	.phy_ssc_en_mask	=3D FSD_PCIE_SYSREG_PHY_1_SSC_EN_MASK,
> > +	.phy_ssc_en		=3D FSD_PCIE_SYSREG_PHY_1_SSC_EN,
> > +	.phy_aux_en_mask	=3D FSD_PCIE_SYSREG_PHY_1_AUX_EN_MASK,
> > +	.phy_aux_en		=3D FSD_PCIE_SYSREG_PHY_1_AUX_EN,
> > +	.phy_cmn_rstn_mask	=3D FSD_PCIE_SYSREG_PHY_1_CMN_RSTN_MASK,
> > +	.phy_cmn_rstn		=3D FSD_PCIE_SYSREG_PHY_1_CMN_RSTN,
> > +	.phy_init_rstn_mask	=3D FSD_PCIE_SYSREG_PHY_1_INIT_RSTN_MASK,
> > +	.phy_init_rstn		=3D FSD_PCIE_SYSREG_PHY_1_INIT_RSTN,
> > +	.num_lanes		=3D 0x4,
> > +	.lane_offset		=3D FSD_PCIE_PHY_LANE_OFFSET,
> > +	=7D,
> > +	=7B =7D,
> > +=7D;
> > +
> > +struct fsd_pcie_phy_setting =7B
> > +	u32 addr;
> > +	u32 val;
> > +	bool is_cmn_reg;
> > +=7D;
> > +
> > +struct fsd_pcie_phy_setting fsd_pcie_phy0_setting=5B=5D =3D =7B
>=20
> No. This is poor coding, please do first extensive internal reviews.
>=20
> Please run standard kernel tools for static analysis, like coccinelle, sm=
atch and sparse, and fix reported warnings. Also please check for
> warnings when building with W=3D1 for gcc and clang. Most of these comman=
ds (checks or W=3D1 build) can build specific targets, like
> some directory, to narrow the scope to only your code. The code here look=
s like it needs a fix. Feel free to get in touch if the warning
> is not clear.
>=20

Will run all these tools and fix where required

> ...
>=20
> > =40=40 -146,11 +491,18 =40=40 static int exynos_pcie_phy_probe(struct p=
latform_device *pdev)
> >  	struct exynos_pcie_phy *exynos_phy;
> >  	struct phy *generic_phy;
> >  	struct phy_provider *phy_provider;
> > +	const struct samsung_drv_data *drv_data;
> > +
> > +	drv_data =3D of_device_get_match_data(dev);
> > +	if (=21drv_data)
> > +		return -ENODEV;
> >
> >  	exynos_phy =3D devm_kzalloc(dev, sizeof(*exynos_phy), GFP_KERNEL);
> >  	if (=21exynos_phy)
> >  		return -ENOMEM;
> >
> > +	exynos_phy->drv_data =3D drv_data;
> > +
> >  	exynos_phy->base =3D devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(exynos_phy->base))
> >  		return PTR_ERR(exynos_phy->base);
> > =40=40 -169,12 +521,15 =40=40 static int exynos_pcie_phy_probe(struct p=
latform_device *pdev)
> >  		return PTR_ERR(exynos_phy->fsysreg);
> >  	=7D
> >
> > -	generic_phy =3D devm_phy_create(dev, dev->of_node, &exynos5433_phy_op=
s);
> > +	generic_phy =3D devm_phy_create(dev, dev->of_node, drv_data->phy_ops)=
;
> >  	if (IS_ERR(generic_phy)) =7B
> >  		dev_err(dev, =22failed to create PHY=5Cn=22);
> >  		return PTR_ERR(generic_phy);
> >  	=7D
> >
> > +	exynos_phy->pcs_base =3D devm_platform_ioremap_resource(pdev, 1);
> > +	exynos_phy->phy_id =3D of_alias_get_id(dev->of_node, =22pciephy=22);
>=20
> Where did you document aliases?
>=20

Will add it to dt bindings.

> Anyway, all this looks because you have completely buggy way of handling =
MMIO via syscon. That's a no-go. Use proper address
> ranges assigned to ddevices. If you ever need to use syscon, you should p=
ass the offset as argument - just like other devices are
> doing.
>=20

Alias is used for 2 reasons.
1. Each of the 2 PHYs in FSD have different initializing sequence due to ch=
annel length, etc. We need the alias to select the init sequence accordingl=
y
2. The syscon offset can be passed via DT but the bit field also varies acc=
ording to instance. (common reset is bit 8 in PHY0 and bit 1 in PHY1).

I could read the sysreg offset from DT and based on the offset value, decid=
e which instance it is. Would that be okay?

> Best regards,
> Krzysztof



