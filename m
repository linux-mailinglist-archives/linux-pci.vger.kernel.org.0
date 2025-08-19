Return-Path: <linux-pci+bounces-34278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0047B2C016
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7A31BC45E8
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624E432A3DB;
	Tue, 19 Aug 2025 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KxtDgwym"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3B326D6D
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602350; cv=none; b=CnxQ1wTGFPhJrw+LTgivB8SFYhmFOQyKTxWbuidOsUqjjMVrqoagmawhXpcRO8U3I64tgo0ganO0JN2vVlsTmCBr1hAhAiyhBx5hRbZu1vJP4BV6/RS8RtkpYfukJgw6foIVaeJnQ645uwu4vxS8OJTCqPs/4FkNK2yc6OGOmIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602350; c=relaxed/simple;
	bh=MgK+rLkI/+TCi8M5AFavEkLcyu2sg1ISmDECM+mPkA4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Gxe93a1cxHwaJSpHxgcqzvuO5uggUJCQwioqDzy0YoDQn1Jg6fIDjAsukRoVgdPNdfgJ85cI6/IWz4fZCB0Kxyo+DITOGCfyvgClDs4LrEGV3iqJaGoaxmbx0/kAKnJNfeDhEJsL6BrGJBHEoJQDaUgsLeZv/EeS3yueXKZyTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KxtDgwym; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250819111905epoutp01fe793d2b2eb5ef7d911acd1897a06a2e~dJwg2hhn20707007070epoutp01h
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 11:19:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250819111905epoutp01fe793d2b2eb5ef7d911acd1897a06a2e~dJwg2hhn20707007070epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755602346;
	bh=0x7d8H6xz06YdYxBNLbU6UcbRVQToFcahkQJVNXKeqY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=KxtDgwymgetZooMIItRSMOMoJAGCRf6OlLO6241+rnXgjrwVHZPU/+8dC2NneLTG0
	 2YlDlOO9XHgV7OEt5jBLO74L6xYyhzW7S5Y6rbWyqe8999yxKb0bwMCeIdtRlf/RN3
	 nrtJxRmVH7t9aEecevRBvXSD7Q4cOAtSs134GMac=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250819111905epcas5p29e792b412afad62d2b1010071fe37c5e~dJwgKcvVD1153211532epcas5p2r;
	Tue, 19 Aug 2025 11:19:05 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4c5nCX0vk7z3hhTD; Tue, 19 Aug
	2025 11:19:04 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250819111903epcas5p415026199e9a0ed1375118cb29bc45e32~dJweljSOS3266032660epcas5p4K;
	Tue, 19 Aug 2025 11:19:03 +0000 (GMT)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250819111900epsmtip260850d7ecf79765666ebe8b2011e9d64~dJwboEOGA1429714297epsmtip2f;
	Tue, 19 Aug 2025 11:19:00 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, "'Bjorn Helgaas'"
	<helgaas@kernel.org>, "'Krzysztof Kozlowski'"
	<krzysztof.kozlowski@linaro.org>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alim.akhtar@samsung.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <jh80.chung@samsung.com>,
	<pankaj.dubey@samsung.com>
In-Reply-To: <29287880-9436-4acd-b3f9-b4d9eb726896@kernel.org>
Subject: RE: [PATCH v3 11/12] PCI: exynos: Add support for Tesla FSD SoC
Date: Tue, 19 Aug 2025 16:48:59 +0530
Message-ID: <00b401dc10fb$11bb1020$35313060$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMTDUGC4sYT5EPbicD3neTazEuiywIHCRg2AsFZ7fKx1ZhD8A==
Content-Language: en-in
X-CMS-MailID: 20250819111903epcas5p415026199e9a0ed1375118cb29bc45e32
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250819063415epcas5p3e0bebab838b913e90bd07adf23c410f1
References: <20250818182544.GA534647@bhelgaas>
	<CGME20250819063415epcas5p3e0bebab838b913e90bd07adf23c410f1@epcas5p3.samsung.com>
	<29287880-9436-4acd-b3f9-b4d9eb726896@kernel.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 19 August 2025 12:04
> To: Bjorn Helgaas <helgaas@kernel.org>; Shradha Todi <shradha.t@samsung.com>; Krzysztof
> Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org;
> mani@kernel.org; lpieralisi@kernel.org; kwilczynski@kernel.org; robh@kernel.org;
> bhelgaas@google.com; jingoohan1@gmail.com; krzk+dt@kernel.org; conor+dt@kernel.org;
> alim.akhtar@samsung.com; vkoul@kernel.org; kishon@kernel.org; arnd@arndb.de;
> m.szyprowski@samsung.com; jh80.chung@samsung.com; pankaj.dubey@samsung.com
> Subject: Re: [PATCH v3 11/12] PCI: exynos: Add support for Tesla FSD SoC
> 
> On 18/08/2025 20:25, Bjorn Helgaas wrote:
> > [+to Krzysztof]
> >
> > On Mon, Aug 18, 2025 at 03:00:00PM +0530, Shradha Todi wrote:
> >>> On Mon, Aug 11, 2025 at 09:16:37PM +0530, Shradha Todi wrote:
> >>>> Add host and endpoint controller driver support for FSD SoC.
> >
> >>> It's kind of unfortunate that the driver uses "ep" everywhere for
> >>> struct exynos_pcie pointers.  It's going to be confusing because "ep"
> >>> is also commonly used for endpoint-related things, e.g., struct
> >>> dw_pcie_ep pointers.  Maybe it's not worth changing; I dunno.
> >>
> >> I did try to rename the structure and the pointers
> >> (https://lore.kernel.org/all/20230214121333.1837-9-shradha.t@samsung.com/)
> >> But the intention was different back then and so the idea was rejected.
> >> I could add a patch to only rename the pointers to something less
> >> confusing like "exy_pci"
> >
> > The patch you mention did several renames:
> >
> >   s/to_exynos_pcie/to_samsung_pcie/
> >   s/struct exynos_pcie/struct samsung_pcie/
> >   s/struct exynos_pcie *ep/struct samsung_pcie *sp/
> >
> > I'm only concerned about the confusion of "ep" being used both for
> > "struct exynos_pcie *" and for "struct dw_pcie_ep *".
> >
> > It would still be sort of an annoying patch to do something like this:
> >
> >   s/struct exynos_pcie *ep/struct exynos_pcie *pcie/
> >
> > But 'git grep "struct .*_pcie \*.*=" drivers/pci/controller/' says
> > using "pcie" in this way is quite common, so maybe it would be worth
> > doing.
> >
> > What do you think, Krzysztof?
> 
> I think you want other Krzysztof, but nevertheless, the reasoning there
> "Changing it to samsung_pcie for making it
> generic."
> is wrong. The naming of these structures do not matter, they are not
> less generic. This is rather churn, which will affect backporting for
> ZERO readability increase. Why zero? Because calling all this "exynos"
> is the same as calling all this "samsung". It just does not matter.
> 
> However s/ep/pcie/ in variable name makes sense if that's more common.
> 

I will add a patch in the series to do that.

> 
> Best regards,
> Krzysztof


