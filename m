Return-Path: <linux-pci+bounces-34279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACD3B2C0B3
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D13E5243F2
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2D832BF27;
	Tue, 19 Aug 2025 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZVvYutnR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79898326D45
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603585; cv=none; b=kJLWUnqshR7rQzfueeQrdY4cULP+Neqel/hWc3uH4BTq4atlcppbyKMDH+nf6CSkkDutr1ToJM4fWyO2LioiIN97uTOcX2CYmxjNiqLPSiPj5NUt6rzGqe1IwL/fp5eyvW/O54HvlhUkFHwHWGtKUbl0daSV0mjUB4FZEeYe87A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603585; c=relaxed/simple;
	bh=SBFzXTu/TE3Y27yTuml5s/ls/Z8dlIb7BbI3Fl++GYo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=dQpcUV1SodiJPl0YX/0kFShwA09O2EZVwhvQStI15jQIP3VdghKGWc3voe0icQbngoxaxrtdJKKl6qb5f9B8PwhMS28ox5dJupgzzQ1yGWJ+OSh9jZPUt2DprquDGAeKrWKH45+o/56EvzixQJw7XMMNaQQYN5YDjzCNzK4Eif8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZVvYutnR; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250819113941epoutp024cded2df148773a0374cc19d704cd7c8~dKCfpn8gI0365703657epoutp02O
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 11:39:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250819113941epoutp024cded2df148773a0374cc19d704cd7c8~dKCfpn8gI0365703657epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755603581;
	bh=1P2Rps+nWLL6vuu8v5AZ6QLluRY8gS5KDMDYoN14d3E=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=ZVvYutnRrj1vsaoIzlGc1d/RjPE60V5uAz1QTRDCZxI81j7cue1sfgSA7oaKZO8YW
	 2qVnzb45IaXeEFXrgbk+ARvR9GiIrmLx90CgXtFOidCb4d1xvFEEGV8mqz30CiOzoN
	 ZcxgykS5DuOVlEM5wzk/ytKYpW7LZdaE9Lb5rgp8=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250819113940epcas5p44becd1ec50dff43ea959114a166fe0dd~dKCeeitQH2997129971epcas5p49;
	Tue, 19 Aug 2025 11:39:40 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.87]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4c5ngH2cfwz3hhT3; Tue, 19 Aug
	2025 11:39:39 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250819113938epcas5p3cac2467171b234b921448bf9b537cce2~dKCdAIEYh2225622256epcas5p3a;
	Tue, 19 Aug 2025 11:39:38 +0000 (GMT)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250819113935epsmtip16d1c515c409672f87d62e0dbcafa0d4d~dKCaJwZgR0293302933epsmtip1n;
	Tue, 19 Aug 2025 11:39:35 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Bjorn Helgaas'" <helgaas@kernel.org>, "'Krzysztof Kozlowski'"
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
In-Reply-To: <20250818182544.GA534647@bhelgaas>
Subject: RE: [PATCH v3 11/12] PCI: exynos: Add support for Tesla FSD SoC
Date: Tue, 19 Aug 2025 17:09:34 +0530
Message-ID: <00b501dc10fd$f1fecc10$d5fc6430$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFRpmM4OvQHoLmp1/7yOMMM/WjwMQMTDUGCtWYRPHA=
Content-Language: en-in
X-CMS-MailID: 20250819113938epcas5p3cac2467171b234b921448bf9b537cce2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250818182551epcas5p33fbe099df79778031b489f0902cceed3
References: <CGME20250818182551epcas5p33fbe099df79778031b489f0902cceed3@epcas5p3.samsung.com>
	<20250818182544.GA534647@bhelgaas>

> > > > +static irqreturn_t fsd_pcie_irq_handler(int irq, void *arg)
> > > > +{
> > > > +	u32 val;
> > > > +	struct exynos_pcie *ep = arg;
> > > > +	struct dw_pcie *pci = &ep->pci;
> > > > +	struct dw_pcie_rp *pp = &pci->pp;
> > > > +
> > > > +	val = readl(ep->elbi_base + FSD_IRQ2_STS);
> > > > +	if ((val & FSD_IRQ_MSI_ENABLE) == FSD_IRQ_MSI_ENABLE) {
> > > > +		val &= FSD_IRQ_MSI_ENABLE;
> > > > +		writel(val, ep->elbi_base + FSD_IRQ2_STS);
> > >
> > > This looks weird because FSD_IRQ_MSI_ENABLE sounds like an *enable*
> > > bit, but here you're treating it as a *status* bit.
> > >
> > > As far as I can tell, you set FSD_IRQ_MSI_ENABLE once at probe-time in
> > > fsd_pcie_msi_init(), then you clear it here in an IRQ handler, and it
> > > will never be set again.  That seems wrong; am I missing something?
> >
> > Actually the status IRQ and enable IRQ registers are different offsets
> > but the bit position for MSI remains same in both cases so I just reused
> > the macro.
> 
> Ah, that's what I missed, thanks!  At probe-time, fsd_pcie_msi_init()
> enables it in FSD_IRQ2_EN.  Here you clear it in FSD_IRQ2_STS.
> 
> > But I understand that it's confusing so I will add another
> > macro for FSD_IRQ_MSI_STATUS or just rename the macro to
> > FSD_IRQ_MSI to re-use.
> 
> Using the same name just because a similar bit happens to be at the
> same position in two different registers is definitely confusing.  I
> think it will be better to have two macros, one for FSD_IRQ2_STS and
> another for FSD_IRQ2_EN, e.g.,
> 
>   #define FSD_IRQ2_STS                         0x008
>   #define   FSD_IRQ2_STS_MSI                   BIT(17)
>   #define FSD_IRQ2_EN                          0x018
>   #define   FSD_IRQ2_EN_MSI                    BIT(17)
> 
> Another question about the test:
> 
>   if ((val & FSD_IRQ_MSI_ENABLE) == FSD_IRQ_MSI_ENABLE) {
> 
> This assumes there are no other bits in FSD_IRQ2_STS that could be
> set.  I would have expected a test like this:
> 
>   if (val & FSD_IRQ_MSI_ENABLE) {
> 

Thanks for pointing this out. FSD_IRQ_MSI_ENABLE is a single-bit, so there
is no functional difference in the two statements. I didn't have a specific
reason for using "== FSD_IRQ_MSI_ENABLE".
But I see that "val & FSD_IRQ_MSI_ENABLE" would have been the more
standard way to write this. I will update this for clarity.

> Is there a reason to restrict it to the case when *only*
> FSD_IRQ_MSI_ENABLE is set?
> 
> Bjorn


