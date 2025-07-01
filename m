Return-Path: <linux-pci+bounces-31183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D118AEFFE3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 18:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D7A3A5C6F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2545827E05E;
	Tue,  1 Jul 2025 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oT3g7+5y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FB927E052
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387477; cv=none; b=Xd7gOK2lJ+MupSidbGeDVAgysn6DFPrY3gGzxquQEFhEvEbstzkF8ryuvCmv67QwwkER9jSmwS3ic/jFJP+eiNtrl80zjUI/oJ3Mn7/W0oj7dJK8XCdLCznBzJJCM3RjM+gNy1Sb49kB/jfEuuIol490IcWbSJwrwutsPMpboII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387477; c=relaxed/simple;
	bh=28omV3/O3aHzL6uKDlQ2PANINxBfKNKjkJr4kIo7X54=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=tmnIAQQIQMtByYNtxUdJAj3oJgGh+5m48jA7gYGWme4637ZiyeDRli1PqPcYVeNUMH5ZUUs1qtgh5YWHfZ+daSmp7KGhQW3Zg8YrnT0dExsV2gpFSi7CYAO2F3h8igl3K7/phBEusZhyivpN0QszMuzPMHiDV3hYlXJVAADpqeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oT3g7+5y; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250701163112epoutp02ba124cdafee69f4c0f8896160a63a802~OLaCQk1F_0647806478epoutp02S
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 16:31:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250701163112epoutp02ba124cdafee69f4c0f8896160a63a802~OLaCQk1F_0647806478epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751387472;
	bh=CYCieZx7RGc4LBogHf+a8UqHutLdl5VHK4F8STwbvPM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=oT3g7+5ykWliopi8mIAdsTlCpWF4z7LPDgU/YHY2nVhTIVLVp/iNxC6sMHGpCscf6
	 xXqM5Vf8YsWk3RvOJ8/byHzgAuVETzDxQ3lqsd3/X5++BIaDvsp8+hk9g/aj6uzSwF
	 qpm6UMUNgJgIvc3JXmvsYi33AP+FsPag3DbUfyZY=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250701163111epcas5p2709c45ba4dad180fe68d0ca67be7a784~OLaBi-Gsx2740427404epcas5p2f;
	Tue,  1 Jul 2025 16:31:11 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.174]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bWpSF6RFTz6B9m5; Tue,  1 Jul
	2025 16:31:09 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250701133810epcas5p3e1acdfe3bfcf5276e6c70f12755fdf57~OJC9HjeEd0290902909epcas5p3y;
	Tue,  1 Jul 2025 13:38:10 +0000 (GMT)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250701133807epsmtip15aa5b5f8243b909f80b036d6b7b3ca61~OJC6dIU3K0912509125epsmtip18;
	Tue,  1 Jul 2025 13:38:07 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Rob Herring'" <robh@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-fsd@tesla.com>, <manivannan.sadhasivam@linaro.org>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
	<jingoohan1@gmail.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<alim.akhtar@samsung.com>, <vkoul@kernel.org>, <kishon@kernel.org>,
	<arnd@arndb.de>, <m.szyprowski@samsung.com>, <jh80.chung@samsung.com>,
	<pankaj.dubey@samsung.com>
In-Reply-To: <20250627211236.GA147018-robh@kernel.org>
Subject: RE: [PATCH v2 06/10] dt-bindings: PCI: Add bindings support for
 Tesla FSD SoC
Date: Tue, 1 Jul 2025 19:08:06 +0530
Message-ID: <02c001dbea8d$62b21d50$281657f0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFUClgbainc6hQuKSBO0V8ttZVgkwK41mGpAfhwG8gB/KC3xLT3likQ
Content-Language: en-in
X-CMS-MailID: 20250701133810epcas5p3e1acdfe3bfcf5276e6c70f12755fdf57
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250625165315epcas5p19f081c8a0e2e7dc87698577cc2d460ca
References: <20250625165229.3458-1-shradha.t@samsung.com>
	<CGME20250625165315epcas5p19f081c8a0e2e7dc87698577cc2d460ca@epcas5p1.samsung.com>
	<20250625165229.3458-7-shradha.t@samsung.com>
	<20250627211236.GA147018-robh@kernel.org>



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 28 June 2025 02:43
> To: Shradha Todi <shradha.t@samsung.com>
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
linux-
> samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org; linux-
> fsd@tesla.com; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org; kw@linux.com;
> bhelgaas@google.com; jingoohan1@gmail.com; krzk+dt@kernel.org; conor+dt@kernel.org;
> alim.akhtar@samsung.com; vkoul@kernel.org; kishon@kernel.org; arnd@arndb.de;
> m.szyprowski@samsung.com; jh80.chung@samsung.com; pankaj.dubey@samsung.com
> Subject: Re: [PATCH v2 06/10] dt-bindings: PCI: Add bindings support for Tesla FSD SoC
> 
> On Wed, Jun 25, 2025 at 10:22:25PM +0530, Shradha Todi wrote:
> > Document the PCIe controller device tree bindings for Tesla FSD
> > SoC for both RC and EP.
> 
> Drop 'bindings support for ' in the subject.
> 
> >
> > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > ---
> >  .../bindings/pci/samsung,exynos-pcie.yaml     | 121 ++++++++++++------
> 
> I think this should be its own schema file. There's not much shared.
> 

Resending my reply after trimming.

Will make 2 new bindings - samsung,exynos-pcie-common.yaml and
tesla,fsd-pcie.yaml
Does that sound okay?


