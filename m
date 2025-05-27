Return-Path: <linux-pci+bounces-28486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D617AC60E0
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 06:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3859E6850
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 04:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5311DC997;
	Wed, 28 May 2025 04:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lt9e8aJE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DBE1DF254
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748407966; cv=none; b=Fb2c7sctH+/bxkByBss5z/ckQyRqgpX2gIGCQy0Pshv6m+XwhzhffE0kYLO8zaRYpUpv1YIfcnnwxGL/fpjQkL+gGazGjB4KJj48iaJwGa8BUn8G5qqdvhq6+ql7n0uYhoHFfJkDXM4gdfJFRpw05tatJueNh4RNwZocOglTHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748407966; c=relaxed/simple;
	bh=GvPX9+riKStrNBb2iuV4rPo+B+4dj9pQGWJg/FWE7AQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=DzKZcfj5OdPlfPo4xnJieMnZDDr58mZNG0PBI+xQAKz/Wz/43w075bOZvjwb9p3T+E7alCjfQkoeUdMBYInOII+5wFSsOLpLhSIy/v/fDmsVMFulT/HkmrzJ568DgI5YOo3/nLGnz0zYSji5GwcVEGRg3sPLgJ+AWTzAzNJjQsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lt9e8aJE; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250528045242epoutp011d19bfb0f86832314507f29ff6e7419d~Dl8dV2mdP3041030410epoutp01P
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:52:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250528045242epoutp011d19bfb0f86832314507f29ff6e7419d~Dl8dV2mdP3041030410epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748407962;
	bh=CpJi0DSdc8dIsYa+b64OvkXko3fy1foTQb/+TMkf3OA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=lt9e8aJE8HsX82p9RbW1nuIMveca7gKS+/Ox3cwpUxVUj5jEHj6Cr9H8N7aCHRHch
	 A1MYskp+2LQS3hDcttVejbmiDug0FSHJaK66qHq+M2jWrxM3qPeRbdk8AJMWjD/AOK
	 4wzGPpRGB66j7rwWTNQkTzvZvf+HTuPt1gBGBmZ0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250528045241epcas5p3b7f062602d38eacf4ce8c19257c74051~Dl8cnOR-q1435314353epcas5p3o;
	Wed, 28 May 2025 04:52:41 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.175]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4b6cZ03Yjlz6B9mF; Wed, 28 May
	2025 04:52:40 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250527104254epcas5p11947ea65ca36866e7363957073d27818~DXE7lv0F60375303753epcas5p18;
	Tue, 27 May 2025 10:42:54 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250527104254epsmtrp2b405d43162c971dde8bdfc6c73906f39~DXE7k1nCp2958329583epsmtrp2g;
	Tue, 27 May 2025 10:42:54 +0000 (GMT)
X-AuditID: b6c32a28-460ee70000001e8a-ad-6835972ee911
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3E.56.07818.E2795386; Tue, 27 May 2025 19:42:54 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250527104251epsmtip2d2313c036b88ac81a5ecae899abbf461~DXE4otpEE3030930309epsmtip2S;
	Tue, 27 May 2025 10:42:50 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.or>,
	<linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alim.akhtar@samsung.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <jh80.chung@samsung.com>, "'Hrishikesh Dileep'"
	<hrishikesh.d@samsung.com>
In-Reply-To: <20250521-mysterious-mole-of-priority-8a5f4d@kuoka>
Subject: RE: [PATCH 03/10] PCI: exynos: Reorder MACROs to maintain
 consistency
Date: Tue, 27 May 2025 16:12:46 +0530
Message-ID: <0e2201dbcef4$1a0f8b50$4e2ea1f0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKa2HaEso6x90WQFKmaYw3pYxuT6gLOqAk9AnIkbNUB3kJT77Iu0NZA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsWy7bCSvK7edNMMg3VfOC0ezNvGZvF30jF2
	iyVNGRZr9p5jsph/5Byrxc2zu9ktbvxqY7VY8WUmu8XR1v/MFi9n3WOzOH9+A7tFQ89vVotN
	j6+xWlzeNYfN4uy842wWE1Z9Y7E4+30Bk0XLnxYWi7VH7rJb3G3pZLX4v2cHu8XOOyeYHcQ8
	fv+axOixc9Zddo8Fm0o9Nq3qZPO4c20Pm8eTK9OZPDYvqffo27KK0ePI1+ksHp83yQVwRXHZ
	pKTmZJalFunbJXBlbN/nXHBBrKL99HT2BsYpwl2MnBwSAiYSi+csZOli5OIQEtjNKHFy7llW
	iISkxOeL65ggbGGJlf+es0MUPWOU+H56LliCTUBH4smVP8wgtoiArsTmG8vBipgFXrNIPDtz
	nxmi4z2jxJM3+9hBqjgFHCRanj8B2sfBISzgJzF1qgaIySKgKtFwFGwmr4ClxMEp+xghbEGJ
	kzNBqjmBZmpL9D5sZYSw5SW2v53DDHGcgsTPp8tYIW5wk1jR/QOqXlzi6M8e5gmMwrOQjJqF
	ZNQsJKNmIWlZwMiyilEytaA4Nz032bDAMC+1XK84Mbe4NC9dLzk/dxMjOB1oaexgfPetSf8Q
	IxMH4yFGCQ5mJRHebRNMMoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzrjSMSBcSSE8sSc1OTS1I
	LYLJMnFwSjUwqfuVBV/hZZbX2NK9R6FEIfeQwdnc5VEb4jZvS3+xO/DA+v5DyfHNm1KWzdjz
	WntP4SGRgpzfOzcwfZ2kWbuo+epP30M/bvQ+ingTqSF85YGXpduVn9OVEuZqrf6ykT0/2mqS
	5lTbfh8W1pJnL1X9jHecOZ5f5H/81LXrcsue3wt89cHJtnxTbb6TyfSpG6wvCMY5syb6/7x2
	jSFyteVCI6+XQae0D7Lk1RwJvZ8x5eybc4t/SZh+WX6l7f6rOZEHGKUWX95XMNvgEY9T3TEV
	CVEFuesT2Cs/nl36S+RteD+PwLWGBDmenYfv7ljy2zb7qMJ7hxb9/c85DZxc1dReP/PbcLjO
	OopH13lztYydsBJLcUaioRZzUXEiABRYaWt2AwAA
X-CMS-MailID: 20250527104254epcas5p11947ea65ca36866e7363957073d27818
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193235epcas5p4f0bcf581b583a3acf493a20191ad2b00
References: <20250518193152.63476-1-shradha.t@samsung.com>
	<CGME20250518193235epcas5p4f0bcf581b583a3acf493a20191ad2b00@epcas5p4.samsung.com>
	<20250518193152.63476-4-shradha.t@samsung.com>
	<20250521-mysterious-mole-of-priority-8a5f4d@kuoka>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 21 May 2025 15:16
> To: Shradha Todi <shradha.t@samsung.com>
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.or;
> linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org;
> kw@linux.com; robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; krzk+dt@kernel.org; conor+dt@kernel.org;
> alim.akhtar@samsung.com; vkoul@kernel.org; kishon@kernel.org; arnd@arndb.de; m.szyprowski@samsung.com;
> jh80.chung@samsung.com; Hrishikesh Dileep <hrishikesh.d@samsung.com>
> Subject: Re: [PATCH 03/10] PCI: exynos: Reorder MACROs to maintain consistency
> 
> On Mon, May 19, 2025 at 01:01:45AM GMT, Shradha Todi wrote:
> > Exynos PCI file follows MACRO definition order where register offset
> > is defined in ascending order and each bit field within the offset is
> > defined right after offset definition. Some MACROs are out of order
> > and so reorder those MACROs to maintain consistency.
> >
> > Suggested-by: Hrishikesh Dileep <hrishikesh.d@samsung.com>
> > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > ---
> >  drivers/pci/controller/dwc/pci-exynos.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-exynos.c
> > b/drivers/pci/controller/dwc/pci-exynos.c
> > index 990aaa16b132..286f4987d56f 100644
> > --- a/drivers/pci/controller/dwc/pci-exynos.c
> > +++ b/drivers/pci/controller/dwc/pci-exynos.c
> > @@ -27,11 +27,11 @@
> >
> >  /* PCIe ELBI registers */
> >  #define EXYNOS_PCIE_IRQ_PULSE			0x000
> > +#define EXYNOS_PCIE_IRQ_EN_PULSE		0x00c
> >  #define EXYNOS_IRQ_INTA_ASSERT			BIT(0)
> >  #define EXYNOS_IRQ_INTB_ASSERT			BIT(2)
> >  #define EXYNOS_IRQ_INTC_ASSERT			BIT(4)
> >  #define EXYNOS_IRQ_INTD_ASSERT			BIT(6)
> > -#define EXYNOS_PCIE_IRQ_EN_PULSE		0x00c
> >  #define EXYNOS_PCIE_IRQ_EN_LEVEL		0x010
> >  #define EXYNOS_PCIE_IRQ_EN_SPECIAL		0x014
> >  #define EXYNOS_PCIE_SW_WAKE			0x018
> > @@ -42,12 +42,12 @@
> >  #define EXYNOS_PCIE_NONSTICKY_RESET		0x024
> >  #define EXYNOS_PCIE_APP_INIT_RESET		0x028
> >  #define EXYNOS_PCIE_APP_LTSSM_ENABLE		0x02c
> > +#define EXYNOS_PCIE_ELBI_LTSSM_ENABLE		0x1
> >  #define EXYNOS_PCIE_ELBI_RDLH_LINKUP		0x074
> >  #define EXYNOS_PCIE_ELBI_XMLH_LINKUP		BIT(4)
> > -#define EXYNOS_PCIE_ELBI_LTSSM_ENABLE		0x1
> >  #define EXYNOS_PCIE_ELBI_SLV_AWMISC		0x11c
> >  #define EXYNOS_PCIE_ELBI_SLV_ARMISC		0x120
> > -#define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
> > +#define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE		BIT(21)
> 
> What changed here? Why you cannot fix indentation while renaming?
> 

Will squash the indentation change along with rename

> Best regards,
> Krzysztof



