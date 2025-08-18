Return-Path: <linux-pci+bounces-34213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 470F6B2AF2D
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 19:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB6D1893A26
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C807239567;
	Mon, 18 Aug 2025 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dMybO5Lo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6111E25EB
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537527; cv=none; b=emTIPYh1v5nXKghyFFLV9ZkPvn3HLwr7PxLq795Gu1XRKbtIhbEHkmbuzkbbi+J6GpKG9LZrNDxEnY+0WHne0yCG32TcwLB518OnL5m0ahQudRIcA0L3bQ5fMowTZgAxobJwxC3vIcb8oqv8tX4SoHjdZuD7gwIlnf7WN1d/d78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537527; c=relaxed/simple;
	bh=6OcDvLVx7ZKerMd+/2uswYan9YURramDttO59ACGzkc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=kXCYxFZPJM9KQ3Qh9TOm4N/ig4WLxLbJa19Nn0J/iRTnVBcJTn+sF4a9PAQ9SM5vBQAD/5iz9SriIWzPiqOCiET95/B2M43fEPc6+M6or0zJUyIWl942vNwbsHB71H01t+3HrGSWPjRBAZAFfdjoZs2pckDEiGPraKjcw4L+fKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dMybO5Lo; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250818171844epoutp02a5dbc9b8939c8a8e9eae3c183d75b55c~c7BOtYTKb3217532175epoutp02a
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 17:18:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250818171844epoutp02a5dbc9b8939c8a8e9eae3c183d75b55c~c7BOtYTKb3217532175epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755537524;
	bh=DXam3b+H7XikahUHcOfNq3UHS4W6/E59lS1R/vF9/E8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=dMybO5Losdo7EzoPf/DdbDVxAmkUMI6mYho6XlYk23uKcDAirY4W0lWPXB6DLkx3m
	 65FlxZtyjHGtrRCzWXsvKV681jKJihMJqm5BL7aV6bdTTSefZZjYEbzutuzbNiHdR5
	 yd2Aa8S1Vzv93GPFl6LSbMpWLcgxpLEDULqyLoDs=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250818171842epcas5p4009ecff833c293e3066ff39d03bc290a~c7BNgSI6N0869708697epcas5p4R;
	Mon, 18 Aug 2025 17:18:42 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.87]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4c5KDx5WGSz6B9m5; Mon, 18 Aug
	2025 17:18:41 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250818085434epcas5p23546464f6d2642c74d42db7b134d8aec~c0JCsYmhE2142121421epcas5p2S;
	Mon, 18 Aug 2025 08:54:34 +0000 (GMT)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250818085431epsmtip2b7a1352fc6b7055557af8d1d093782bf~c0I--9NYD2484224842epsmtip2X;
	Mon, 18 Aug 2025 08:54:31 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>
Cc: <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alim.akhtar@samsung.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <jh80.chung@samsung.com>,
	<pankaj.dubey@samsung.com>
In-Reply-To: <b22f9381-1835-463a-8daa-97835b159f78@kernel.org>
Subject: RE: [PATCH v3 12/12] arm64: dts: fsd: Add PCIe support for Tesla
 FSD SoC
Date: Mon, 18 Aug 2025 14:24:30 +0530
Message-ID: <000b01dc101d$b834db40$289e91c0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHWPHKmIG2WTsjb/5pkHKJ2GfeRPwIotln8AZEe0jECYiuDgLRC4i+g
Content-Language: en-in
X-CMS-MailID: 20250818085434epcas5p23546464f6d2642c74d42db7b134d8aec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250811154746epcas5p261ba0c811f9dd8748f8f241b76be6525
References: <20250811154638.95732-1-shradha.t@samsung.com>
	<CGME20250811154746epcas5p261ba0c811f9dd8748f8f241b76be6525@epcas5p2.samsung.com>
	<20250811154638.95732-13-shradha.t@samsung.com>
	<b22f9381-1835-463a-8daa-97835b159f78@kernel.org>

> > +&pcieep2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pcie1_clkreq>, <&pcie1_wake>, <&pcie1_preset>,
> > +			<&pcie0_slot1>;
> > +};
> > +
> > +&pcierc0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake0>, <&pcie0_preset0>,
> > +			 <&pcie0_slot0>;
> > +};
> > +
> > +&pcieep0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake0>, <&pcie0_preset0>,
> > +			 <&pcie0_slot0>;
> > +};
> > +
> > +&pcierc1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake1>, <&pcie0_preset0>;
> > +};
> > +
> > +&pcieep1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake1>, <&pcie0_preset0>;
> 
> 
> All these are pointless, because the node is disabled. The board level
> should be complete, so also supplies and enabling the device.
> 

I will enable required nodes. Had enabled while testing but missed to
add in patch. Though all nodes will not be enabled as it is a dual-mode
controller and cannot run as both RC and EP at the same time.

> Best regards,
> Krzysztof


