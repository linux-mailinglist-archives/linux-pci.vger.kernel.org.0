Return-Path: <linux-pci+bounces-28490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C764AC60ED
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 06:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26F21BA7C6B
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 04:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528381FC7E7;
	Wed, 28 May 2025 04:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vT+z2/09"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A21FAC59
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748408002; cv=none; b=BerDlhA0lVB3vaF/ZPok2uOy2J2yI2qias70YP+0B0PeyAgdpRsWQ1EDWd5AzaCRB3zYnciiwW079UUi36uJOolauVPlrG9zo2Nv+LjCQF5d/AwcXSzyFy2gdJnr8ok4RjZKRbNuCGDS1K/hFIsBXHD1eV8tFUhAtW6wKmEKCGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748408002; c=relaxed/simple;
	bh=ilFObzrRzcuIWyVpYbM1OOdelz4vGq5DSgh6SR3N6SU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=N99ehx81CDiDSyiF/YSwk+LyxiPgBYMq/NX4+TziOdbxTaKcB3RlrwM3osKILqIcT1bxzbUSL4uScX4LWGo0cojpQ8Us6zibpBy2nx6uiV0xrmM54O5TTLCRy0rS5zA7wrDq6BgJ2koWYrKAAI9zd7aoqFF2Uqt5nFv7WRzcRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vT+z2/09; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250528045318epoutp0399414d4acad85bd0d5e5d7f1e2df9aec~Dl8_r3Pmd1180511805epoutp03R
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:53:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250528045318epoutp0399414d4acad85bd0d5e5d7f1e2df9aec~Dl8_r3Pmd1180511805epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748407998;
	bh=oI/3Kv7rqiURNi/gqpByHgIefsR+vmV8gDPLpOar4lE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=vT+z2/09TSgsPVFN5z8cbmp2FygjLGRoiUPVygrHOziKHAwkGtonnx8C86PziPfK/
	 tRGbQBvICeR9/DIGug+NIizGuhzLM+jQNLQHcv3xg0YO5l29P4AUBKDDvXi0PfqbRY
	 12ZvqPe8axgqnueUW1SK6w627gYguRFPQTwkN2HY=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250528045317epcas5p1c42fddd3db36a3282fb6749408482541~Dl893bHeW0861408614epcas5p1v;
	Wed, 28 May 2025 04:53:17 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.180]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4b6cZg6QT7z6B9m4; Wed, 28 May
	2025 04:53:15 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250527104438epcas5p1e0a184c9f61fdf0682ef2c8297d7e29f~DXGcVBx_F0160301603epcas5p1B;
	Tue, 27 May 2025 10:44:38 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250527104438epsmtrp2988aa4c8e59dcd5addbc301fc78dfc8d~DXGcPHpLB3064030640epsmtrp2N;
	Tue, 27 May 2025 10:44:38 +0000 (GMT)
X-AuditID: b6c32a52-41dfa70000004c16-4c-68359795bcba
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	4F.08.19478.59795386; Tue, 27 May 2025 19:44:37 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250527104435epsmtip142267e44fbd8d2dd40f2921c75798631~DXGZbE85o0412004120epsmtip1O;
	Tue, 27 May 2025 10:44:34 +0000 (GMT)
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
In-Reply-To: <20250521-quirky-tanuki-of-tact-a79b86@kuoka>
Subject: RE: [PATCH 07/10] dt-bindings: phy: Add PHY bindings support for
 FSD SoC
Date: Tue, 27 May 2025 16:14:34 +0530
Message-ID: <0e2601dbcef4$57ebe0e0$07c3a2a0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKa2HaEso6x90WQFKmaYw3pYxuT6gG1RTy+AkknIl0Ba3wP+rI853gA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTYRjG+845OzsORl9T80u7zgRbaRkan12kIvJ0b/VPBlFLD87adJ05
	sRtp6EhZtWqmLqvhLHXYbZazKInlZVreSMxALctlQgVl2sXsso3A/x5+7/M8PPAypKSHCmZS
	UtM5PlWhktIiquaJdHZEQWGMconTGotfX6mh8cT5RiEuO6nEVY/aCHy1vk2Ae37qBbjia7EQ
	N+T+IfGwuZ/G7e23hTjLMC7A9rfdAvz8QQmNW6800dhoG6Nw6zcLgXN+5VD4Rn2fEPfl5Anw
	n4e1Qny/10WuDmTHf54H7H1zn5C12HWs3ZZHs73dD2l2sKuQYKvLTrBn7toAWz9aSLEj9tnb
	RbtFK5M4VUoGxy+O2ydStjY+pzVGmNlwGmYBizgf+DEIRqMXn05RHi2BDoCs7TIfn4FGOm8S
	Pu2PKn8PCfOB6J/nHUDfLedIz4GGi9Bg1y+vDoARqLqn3GsioYNCz64NAF9iGKAS/Suvyw8u
	R6WvHvyrZRh/KEf9jhUeTMEw1GQdJT1YDGOR3hDuwWI4DTUXD3rHkXAhOj2QC3x6DnJ8LCF9
	4+aiH+7rAk80AK5HLhPhswShhh8G0gj8zZOazJOazJOazJMiFkDZQCCn0aqT1YmaqEitQq3V
	pSZHJqap7cD7fNmOWnD91kSkExAMcALEkNIAcY0xWikRJykOH+H4tL28TsVpnSCEoaRB4lBV
	XpIEJivSuYMcp+H4/1eC8QvOIoIex0x7/z4hZwUvK4ivXBR6KWwcx08Xf/qt1m1449bdu2g0
	zhiTN11yBhZ1L9gTvbqGVGUnZt5eppJI5LBoy6G7tmXay6JjxuCzEcZR06kXWpklvC53JNPW
	supobou+JaaM33S0qG4/kHyor513x+TufKnUZD8baq6aur2vDV2O7Egnmpyu0uy9cH7jgquH
	3BMJJpdm3bz8kK0unfVDPLtx3etNX3e+zPtyc/OsxgOx2/QGdsh6XDc9w/S4Sz7FjXatjWvr
	n3nu85S4fklZ6HzmQngGV2k4u0ZuLh/o6BoL4fVLSzsnUhxZIwU7bIeDK6qqyMGQ5uGn5XWL
	5xRmDkkprVIRJSN5reIvsEti+WsDAAA=
X-CMS-MailID: 20250527104438epcas5p1e0a184c9f61fdf0682ef2c8297d7e29f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193252epcas5p3e4d1d329f1e5616e842801ceb26728b6
References: <20250518193152.63476-1-shradha.t@samsung.com>
	<CGME20250518193252epcas5p3e4d1d329f1e5616e842801ceb26728b6@epcas5p3.samsung.com>
	<20250518193152.63476-8-shradha.t@samsung.com>
	<20250521-quirky-tanuki-of-tact-a79b86@kuoka>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 21 May 2025 15:03
> To: Shradha Todi <shradha.t@samsung.com>
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.or;
> linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org;
> kw@linux.com; robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; krzk+dt@kernel.org; conor+dt@kernel.org;
> alim.akhtar@samsung.com; vkoul@kernel.org; kishon@kernel.org; arnd@arndb.de; m.szyprowski@samsung.com;
> jh80.chung@samsung.com
> Subject: Re: [PATCH 07/10] dt-bindings: phy: Add PHY bindings support for FSD SoC
> 
> On Mon, May 19, 2025 at 01:01:49AM GMT, Shradha Todi wrote:
> > Document PHY device tree bindings for Tesla FSD SoCs.
> >
> > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > ---
> >  .../devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml  | 8
> > ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> > b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> > index 41df8bb08ff7..3a5bff0fb82d 100644
> > ---
> > a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.ya
> > +++ ml
> > @@ -15,10 +15,14 @@ properties:
> >      const: 0
> >
> >    compatible:
> > -    const: samsung,exynos5433-pcie-phy
> > +    oneOf:
> 
> Drop, that's just enumm unless you already add here more?
> 
> > +      - enum:
> > +          - samsung,exynos5433-pcie-phy
> > +          - tesla,fsd-pcie-phy
> >
> >    reg:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> 
> You need to list the items and constrain existing variants. I do not get why exynos5433 gets now two MMIO ranges.
> 

Will constraint both variants with if - else

> Best regards,
> Krzysztof



