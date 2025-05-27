Return-Path: <linux-pci+bounces-28485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB44AC60DF
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 06:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC241BA657E
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 04:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F47E15E97;
	Wed, 28 May 2025 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kh9vimOH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F01F1537
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748407963; cv=none; b=kck7aAjuYSNeU7gL9HfeZZqKYQJq7z1rZKqyObsTaheUqlZsyfT2Qp0JG5vWOGyTYZfIIvNQf3hMmGU2z3HC32FrINRTlAVTPyilbgbysIfF1BeQ619O26Ll3MrYa6IWopaE8gkk/KSmaiQoL5GBL6xzVULl3V+460nS9FrOfHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748407963; c=relaxed/simple;
	bh=1he+ECXkMifDmz+0SeATcBB9PNeHm0QazgQ8Uqsca/c=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=fTHb8z2OWoHVB2FdcdQUkapaFi5ECH6pzDbG2k2xJhsbduWpsp4fXfT5ijOTyFI1y7SjQNzOKb567iBDHkYxcQ0doxjGd7Btg725Vr92k0tIbF74oW4HFKImv/CO0rJMzIaQX3J+uUBtTRvrVqlTK9XFoozHArWndE9WdWYdizo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kh9vimOH; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250528045234epoutp01ea93dfde5bef9a0a9319ca6e594ae706~Dl8VYal_F3110731107epoutp01a
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:52:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250528045234epoutp01ea93dfde5bef9a0a9319ca6e594ae706~Dl8VYal_F3110731107epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748407954;
	bh=Yt1i5zz1+H1yH/+R8rQhFBytNoiQxwZ3UA1Upazmv3M=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=kh9vimOH6e8qXlvc+XcBupKByKInN6Btpxd6vLjEm+bGG1SHpYrXqbbSsjr2+Fp7u
	 liIMMbR75bRZPLG7A1ecOCQAT4+kPTibK6lkBXbr1opNHoVGkUihDw9u5hc8DjPSs8
	 UIhCdbib9KuMIYHaHfT8gzc9DmV72sRR77385vHQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250528045233epcas5p428e45730e03f22506dfecb146be0ded5~Dl8U1b_0y2587125871epcas5p4o;
	Wed, 28 May 2025 04:52:33 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.177]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4b6cYr1BdCz6B9mF; Wed, 28 May
	2025 04:52:32 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250527104241epcas5p2428e5f78dc4e19a2d753785c79fe5062~DXEvXsNnk2402124021epcas5p2M;
	Tue, 27 May 2025 10:42:41 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250527104241epsmtrp2c6f0950056d42e94b76450b81048663a~DXEvWsWx42958229582epsmtrp2H;
	Tue, 27 May 2025 10:42:41 +0000 (GMT)
X-AuditID: b6c32a28-460ee70000001e8a-7d-68359720b70b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D7.56.07818.02795386; Tue, 27 May 2025 19:42:40 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250527104237epsmtip12aa6194a2d7b488cdc0bf41890ae0ad2~DXEsaJYJK0228602286epsmtip1h;
	Tue, 27 May 2025 10:42:37 +0000 (GMT)
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
In-Reply-To: <20250521-succinct-roadrunner-from-avalon-f1fa4c@kuoka>
Subject: RE: [PATCH 02/10] PCI: exynos: Remove unused MACROs in exynos PCI
 file
Date: Tue, 27 May 2025 16:12:31 +0530
Message-ID: <0e2101dbcef4$1235cf20$36a16d60$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKa2HaEso6x90WQFKmaYw3pYxuT6gLfine5ANOZyXwCswaLjrI0l9ug
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+87dkXFyUp8WSxaBmc0Wqz7LSiPskER2vxDo0NNW6bJNuxFl
	YVGySqVQx7AVkrlKZIvpyUXlnF3I7GJml62bszJKc14qdcZcgf/94HmeH+8fL4OHdBDhzA5N
	Nq/VKDOklIiwOaSS2RHF89Rzepxx6H2ZjULDRY00Kj+mRtduPcbQhYbHJHrVVEejtj8nSHSl
	t5RGzuMjOPpqcFOoubmaRrn6QRJZPrWS6PlNI4Wayu5RqMDcT6CmAROG8obyCHS9wUUjV94p
	Eo3Ya2kkvL2Px0/iBv8UAU4wuGjOZMnhLOZTFPe21U5x7S3FGGctP8KduWEGXENfMcF5LZJk
	0VZRXDqfsWMvr41ZkipSP/C1YlnGCftrh9qwXFA4Ph8EMZBVwMHvTjwfiJgQtg7Ac/VePBCE
	Qe/TKizAYljp+0wHSh0A3u0SKH9AsdGwvWVodBDKzobWtorREs5+I2DHo3f/tF4AC4w/R1tB
	7HJo6/1C+1nMrobPBoaBnwl2Bqy1NpJ+DmZjYXfnbSrAE+GD0nbCzzg7C57+cBwEeBqs+W78
	d2oE/O25TAauSIR230c60JkMnb/1eAEQG8aoDGNUhjEqw5iJCRBmEMZn6TJVmWnyLLmG3yfT
	KTN1ORqVLG13pgWMvkJUZC340X8sph5gDKgHkMGlocG2AoU6JDhdeeAgr92dos3J4HX1YApD
	SCcHV8o3q0JYlTKb38XzWbz2f4oxQeG5mOzryElfdjW3stQiudaTukoVGp06vMGR/Llq1cbX
	w4xsEjKFKQyS94OLN5wobHuxqJu0Oba/BpeqKlNUwtxog/WXPP0FpBQDrrlXez/YEw+5vnU5
	Uj7VFRk3NScLkefPRnTNTFzj4QVnvCmUVS2fX0XvdMsWeqKStulT9eM0FfTFBW8SGt95XC3C
	Om2p0u2Jf35n7dE+97zthb354le5ZjbMYlw6R1wXfR/erpFGbllSMzSividAFBMbXrNwj68s
	Kei0PUVh9W15Ut0zHdydelJPekuMrQ8721c4Eq5ISpS38hv2pxElfWWPDi86en1ZjvBy68sE
	t76pe71rvZTQqZXyKFyrU/4Fa6hrWHkDAAA=
X-CMS-MailID: 20250527104241epcas5p2428e5f78dc4e19a2d753785c79fe5062
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193230epcas5p3dfb178a6528556c55e9b694ca8f8ad6c
References: <20250518193152.63476-1-shradha.t@samsung.com>
	<CGME20250518193230epcas5p3dfb178a6528556c55e9b694ca8f8ad6c@epcas5p3.samsung.com>
	<20250518193152.63476-3-shradha.t@samsung.com>
	<20250521-succinct-roadrunner-from-avalon-f1fa4c@kuoka>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 21 May 2025 15:11
> To: Shradha Todi <shradha.t@samsung.com>
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.or;
> linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org;
> kw@linux.com; robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; krzk+dt@kernel.org; conor+dt@kernel.org;
> alim.akhtar@samsung.com; vkoul@kernel.org; kishon@kernel.org; arnd@arndb.de; m.szyprowski@samsung.com;
> jh80.chung@samsung.com; Hrishikesh Dileep <hrishikesh.d@samsung.com>
> Subject: Re: [PATCH 02/10] PCI: exynos: Remove unused MACROs in exynos PCI file
> 
> On Mon, May 19, 2025 at 01:01:44AM GMT, Shradha Todi wrote:
> > Some MACROs are defined in the exynos PCI file but are not used
> > anywhere within the file. Remove such unused MACROs.
> >
> > Suggested-by: Hrishikesh Dileep <hrishikesh.d@samsung.com>
> > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > ---
> >  drivers/pci/controller/dwc/pci-exynos.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-exynos.c
> > b/drivers/pci/controller/dwc/pci-exynos.c
> > index 1c70b036376d..990aaa16b132 100644
> > --- a/drivers/pci/controller/dwc/pci-exynos.c
> > +++ b/drivers/pci/controller/dwc/pci-exynos.c
> > @@ -31,8 +31,6 @@
> >  #define EXYNOS_IRQ_INTB_ASSERT			BIT(2)
> >  #define EXYNOS_IRQ_INTC_ASSERT			BIT(4)
> >  #define EXYNOS_IRQ_INTD_ASSERT			BIT(6)
> > -#define EXYNOS_PCIE_IRQ_LEVEL			0x004
> 
> Fix order of patches. Why renaming something just to remove it? No point.
> 

This makes sense. Will change it

> Best regards,
> Krzysztof



