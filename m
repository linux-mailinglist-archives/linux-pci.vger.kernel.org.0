Return-Path: <linux-pci+bounces-31161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4E4AEF6CC
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 13:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE185446BB3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 11:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A107F273D98;
	Tue,  1 Jul 2025 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KY7JO1Is"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4490F2737F0
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370028; cv=none; b=FQyq+2Hyk2UXAiw62d2a4RyegOApPUUeymXn2DyT7kqjULwhP57NX5z+SneRxKMlMfInKmNVv0lr6UEYQQ9dp+jW/m6Prn7LAVX3dFghikarkKndQttWAAbw9uT7SQdeYLqshUBl1epW2JWAoBBPSRRZZmUqVkhu33V5cwlOa6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370028; c=relaxed/simple;
	bh=OZ49jYUUZOmMK6H9Nv/dyyRZN30Ctk78bX0kjHtFUtE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=S77BF7vwdHan9WGGD1D9/uVkhmxKVw8Ur/L5pADZHJgQEKxlkmZMJusoQV7BhnAkkoICiOlQkUom5yCpGSVoegQr/3rvpXlTzr+7JVBV98TzPgZvHkxxMN2gcqUbyaPKcTUZUg4DtopqDTlJFZYS4V+zuet84OUhE7GxN8X40CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KY7JO1Is; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250701114024epoutp04cfccb6f99db85e8238f9f17e6c1f449d~OHcIXR68I0990309903epoutp04E
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 11:40:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250701114024epoutp04cfccb6f99db85e8238f9f17e6c1f449d~OHcIXR68I0990309903epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751370024;
	bh=2Nli5jAMu0NC9zLKjZfj4lZI1r3k1lL6PZil61CiwoQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=KY7JO1IsHlfA9MJX/INx8OUB847GygezOpPrB/oKVBqWR2MCcGbK12Jt072bSnoBJ
	 zI0/WThqCBwwTO3oKM9pVqvvpST/SigLVMAIRRB0OV3jRQh9C0Kiti219ZeHzcOB/N
	 89AT5YOTsEUDcOR3qPlJQMDXwMWgDHnNnCFAxM9Y=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250701114023epcas5p33dd4f6f24af1c80abcf7c49a1993ea12~OHcHvVz-72271022710epcas5p3o;
	Tue,  1 Jul 2025 11:40:23 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.180]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bWh0j3BTSz6B9m7; Tue,  1 Jul
	2025 11:40:21 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250701113336epcas5p1cfa1a369fad337b9a2211c7588cd7561~OHWMK6rHg2219722197epcas5p1d;
	Tue,  1 Jul 2025 11:33:36 +0000 (GMT)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250701113333epsmtip106136eafe25d00b19c1917b7fa970e20~OHWJXty0k3251632516epsmtip1u;
	Tue,  1 Jul 2025 11:33:33 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Bjorn Helgaas'" <helgaas@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-fsd@tesla.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
	<jingoohan1@gmail.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<alim.akhtar@samsung.com>, <vkoul@kernel.org>, <kishon@kernel.org>,
	<arnd@arndb.de>, <m.szyprowski@samsung.com>, <jh80.chung@samsung.com>,
	<pankaj.dubey@samsung.com>
In-Reply-To: <20250627162943.GA1672296@bhelgaas>
Subject: RE: [PATCH v2 06/10] dt-bindings: PCI: Add bindings support for
 Tesla FSD SoC
Date: Tue, 1 Jul 2025 17:03:31 +0530
Message-ID: <02b201dbea7b$fbaf5390$f30dfab0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLemVNzYEMOy/tIwP8yQfjCLghe+gHQOY9Ysgk/TyA=
Content-Language: en-in
X-CMS-MailID: 20250701113336epcas5p1cfa1a369fad337b9a2211c7588cd7561
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250627162949epcas5p1fc5eebd0036116ce2913cdcbabdab1fd
References: <CGME20250627162949epcas5p1fc5eebd0036116ce2913cdcbabdab1fd@epcas5p1.samsung.com>
	<20250627162943.GA1672296@bhelgaas>



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: 27 June 2025 22:00
> To: Shradha Todi <shradha.t@samsung.com>
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
linux-
> samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org; linux-
> fsd@tesla.com; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org; kw@linux.com;
> robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; krzk+dt@kernel.org;
> conor+dt@kernel.org; alim.akhtar@samsung.com; vkoul@kernel.org; kishon@kernel.org;
> arnd@arndb.de; m.szyprowski@samsung.com; jh80.chung@samsung.com; pankaj.dubey@samsung.com
> Subject: Re: [PATCH v2 06/10] dt-bindings: PCI: Add bindings support for Tesla FSD SoC
> 
> On Wed, Jun 25, 2025 at 10:22:25PM +0530, Shradha Todi wrote:
> > Document the PCIe controller device tree bindings for Tesla FSD
> > SoC for both RC and EP.
> 
> > +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> 
> > -  clocks:
> > -    items:
> > -      - description: PCIe bridge clock
> > -      - description: PCIe bus clock
> 
> > -  vdd10-supply:
> > -    description:
> > -      Phandle to a regulator that provides 1.0V power to the PCIe block.
> > -
> > -  vdd18-supply:
> > -    description:
> > -      Phandle to a regulator that provides 1.8V power to the PCIe block.
> 
> > +            - description: pcie bridge clock
> > +            - description: pcie bus clock
> 
> Gratuitous "PCIe" capitalization changes here and in supplies below.
> This is just plain English text so we can use English conventions.
> 
> > +        vdd10-supply:
> > +          description:
> > +            phandle to a regulator that provides 1.0v power to the pcie block.
> > +
> > +        vdd18-supply:
> > +          description:
> > +            phandle to a regulator that provides 1.8v power to the pcie block.
> 
> I *would* be OK if you dropped the periods at the end of these, which
> would make them match the other descriptions in this binding.
> 
> > +++ b/Documentation/devicetree/bindings/pci/tesla,fsd-pcie-ep.yaml
> 
> I'm not sure about the "tesla,fsd-pcie-ep.yaml" filename.  I see that
> it currently only describes a tesla endpoint, but it seems like maybe
> this should be parallel to the "samsung,exynos-pcie.yaml" host
> controller binding.
> 
> Bjorn

Actually there is no support for Exynos5433 in EP mode. Initially I named
the binding file "samsung,exynos-pcie-ep.yaml" to make it parallel to the host
controller bindings. But I received a comment that file names should match
the compatible strings which makes sense so I changed it to this.



