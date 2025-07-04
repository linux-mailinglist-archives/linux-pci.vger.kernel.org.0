Return-Path: <linux-pci+bounces-31530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A61AF93B8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 15:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B35958553A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 13:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A772F9494;
	Fri,  4 Jul 2025 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tGy7O1TW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92FF2F7D1A
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634564; cv=none; b=KLp+ZdWRYBdaz9KPveVnaQx/KIWd+CyNDVkU8yqUZN6F8j+CYFmdn7yf21+5lj/8RAVjv0M1U+PcIUJdBvf2sKzL8YvV3QxmGl6ffJ39bf8MI1A61e/FsKXwd041lTkZeWOO1Xlc2+PQ9n8GmvuSCdIatwUYO/Iqss3LVaM2UBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634564; c=relaxed/simple;
	bh=7ZXkeb6eFkBOPADQFZ6Ugr+b8t74NHRMQP7v0mRURjs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=ZGSLu6K+RQtSjF15TgB84YAzCWtSMW+q5nWVZtddHwW0nRTDHj4ixT35sXvpLdKvRUkoR8+T53fcvksWSdNDYuomcJzWp2PZjn6Zb5VrQwRZ1DzQxm5sadU/Wnw9OUQ8wEEqz9SEJuoYmXJpbfNbPqpCHdNR/h2TVVGKK2S2Iq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tGy7O1TW; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250704130920epoutp0123b58c8fd2d7b9739cfe39be26966ffd~PDlo70Fu12413724137epoutp01V
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 13:09:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250704130920epoutp0123b58c8fd2d7b9739cfe39be26966ffd~PDlo70Fu12413724137epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751634560;
	bh=7ZXkeb6eFkBOPADQFZ6Ugr+b8t74NHRMQP7v0mRURjs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=tGy7O1TWZRAGFzE9c5zCBfJ0EWJB9ZW168DlwGplfHmJMdkgUweVwdg8Ma0qOU969
	 owlFoU46WtVhNOXjrual6QCRz/QaeuITxMMQwP4EEnKVB6rxrE9Z3bslWmSbEaCWxw
	 FgEOg93qp+uo6zw0nVsaku9VYF6FtZbxTtgieNXE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250704130919epcas5p19ebf1ad617b18e718d49ca531405bd15~PDlna0mq20316103161epcas5p13;
	Fri,  4 Jul 2025 13:09:19 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.182]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bYYqx3J2Dz2SSKX; Fri,  4 Jul
	2025 13:09:17 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250704130916epcas5p2ccff0f947268712a35e5e80977bf5806~PDllQx00_1901719017epcas5p21;
	Fri,  4 Jul 2025 13:09:16 +0000 (GMT)
Received: from INBRO001561 (unknown [107.122.12.6]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250704130913epsmtip1efc9beeb49ba18d5c56da5d5c629e5c4~PDligOFVO0201502015epsmtip1b;
	Fri,  4 Jul 2025 13:09:13 +0000 (GMT)
From: "Pankaj Dubey" <pankaj.dubey@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, "'Shradha Todi'"
	<shradha.t@samsung.com>, "'Rob Herring'" <robh@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-fsd@tesla.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kw@linux.com>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alim.akhtar@samsung.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <jh80.chung@samsung.com>
In-Reply-To: <5ea33054-8a08-4bb3-81e7-d832c53979dc@kernel.org>
Subject: RE: [PATCH v2 07/10] dt-bindings: phy: Add PHY bindings support for
 FSD SoC
Date: Fri, 4 Jul 2025 18:39:12 +0530
Message-ID: <000101dbece4$d8694d80$893be880$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFUClgbainc6hQuKSBO0V8ttZVgkwGg1JXJAfs/ltABn1f9rAD4JQ8bAeFf3fQB1zUu0wGsyVLstNTsxXA=
Content-Language: en-us
X-CMS-MailID: 20250704130916epcas5p2ccff0f947268712a35e5e80977bf5806
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250625165319epcas5p3721c19f6e6b482438c62dd1ef784de03
References: <20250625165229.3458-1-shradha.t@samsung.com>
	<CGME20250625165319epcas5p3721c19f6e6b482438c62dd1ef784de03@epcas5p3.samsung.com>
	<20250625165229.3458-8-shradha.t@samsung.com>
	<20250627211721.GA153863-robh@kernel.org>
	<02af01dbea78$24f01310$6ed03930$@samsung.com>
	<f877b3d7-d770-4424-9813-da748775f456@kernel.org>
	<02bf01dbea8c$fc835cb0$f58a1610$@samsung.com>
	<5ea33054-8a08-4bb3-81e7-d832c53979dc@kernel.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: Thursday, July 3, 2025 1:48 AM
> To: Shradha Todi <shradha.t=40samsung.com>; 'Rob Herring'
> <robh=40kernel.org>
> Cc: linux-pci=40vger.kernel.org; devicetree=40vger.kernel.org; linux-arm-
> kernel=40lists.infradead.org; linux-samsung-soc=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; linux-phy=40lists.infradead.org; linux-fsd=40te=
sla.com;
> mani=40kernel.org; lpieralisi=40kernel.org; kw=40linux.com;
> bhelgaas=40google.com; jingoohan1=40gmail.com; krzk+dt=40kernel.org;
> conor+dt=40kernel.org; alim.akhtar=40samsung.com; vkoul=40kernel.org;
> kishon=40kernel.org; arnd=40arndb.de; m.szyprowski=40samsung.com;
> jh80.chung=40samsung.com; pankaj.dubey=40samsung.com
> Subject: Re: =5BPATCH v2 07/10=5D dt-bindings: phy: Add PHY bindings supp=
ort for
> FSD SoC
>=20
> On 01/07/2025 15:35, Shradha Todi wrote:
> >>> does not support auto adaptation so we need to tune the PHYs
> >>> according to the use case (considering channel loss, etc). This is
> >>> why we
> >>
> >> So not same? Decide. Either it is same or not, cannot be both.
> >>
> >> If you mean that some wiring is different on the board, then how does
> >> it differ in soc thus how it is per-soc property? If these are
> >> use-cases, then how is even suitable for DT?
> >>
> >> I use your Tesla FSD differently and then I exchange DTSI and compatib=
les?
> >>
> >> You are no describing real problem and both binding and your
> >> explanations are vague and imprecise. Binding tells nothing about it,
> >> so it is example of skipping important decisions.
> >>
> >>> have 2 different SW PHY initialization sequence depending on the
> >>> instance number. Do you think having different compatible (something
> >>> like
> >>> tesla,fsd-pcie-phy0 and tesla,fsd-pcie-phy1) and having phy ID as
> >>> platform data is okay in this case? I actually took reference from fi=
les like:
> >>
> >> And in different use case on same soc you are going to reverse
> >> compatibles or instance IDs?
> >>
> >
> > Even though both the PHYs are exactly identical in terms of hardware,
> > they need to be programmed/initialized/configured differently.
> >
> > Sorry for my misuse of the word =22use-case=22. To clarify, these
> > configurations will always remain the same for FSD SoC even if you use =
it
> differently.
> >
> > I will use different compatibles for them as I understand that it is
> > the best option.
>=20
> I still do not see the difference in hardware explained.
>=20

Hi Krzysztof=20

Let me add more details and see if that makes sense to understand the inten=
tion
behind the current design of the PHY driver.

In FSD SoC, the two PHY instances, although having identical hardware desig=
n and
register maps, are placed in different locations (Placement and routing) in=
side the
SoC and have distinct PHY-to-Controller topologies.=20

One instance is connected to two PCIe controllers, while the other is conne=
cted to
only one. As a result, they experience different analog environments, inclu=
ding
varying channel losses and noise profiles.

Since these PHYs lack internal adaptation mechanisms and f/w based tuning,
manual register programming is required for analog tuning, such as equaliza=
tion,
de-emphasis, and gain. To ensure optimal signal integrity, it is essential =
to use different
register values for each PHY instance, despite their identical hardware des=
ign.
This is because the same register values may not be suitable for both insta=
nces due to
their differing environments and topologies.

Do let us know if this explains the intention behind separate programming s=
equence
for both instance of the PHY?

Thanks,
Pankaj Dubey
> Best regards,
> Krzysztof


