Return-Path: <linux-pci+bounces-34212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BD9B2AF2B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 19:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5721899960
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 17:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E288C0B;
	Mon, 18 Aug 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZO+tUVGW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AC21E25EB
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537517; cv=none; b=Yy/q9opyzM2LAJLVR0ew5imPjHcGwPdFXILzlxCcAHd9is/17UGlblOSJGpuCxrkOU8YZAla1NVIdEoRTojRMZjYxwnnJZHT6di7Zyb/W4M0pK/HasHgFg70b04Ia/HGtwEmtBwXa6N5Du9ZqSqhRVu7oXcsKhbabej3nIG1eYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537517; c=relaxed/simple;
	bh=9JMXztg+Q8fI+L1JfmE621uB0vrUu2BhnBt+O8mpx+U=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Ixt1EzZkzm6HHI7+i9gzXlx3b0ZT22xDNDdzVMIOkGwFn2UmGl3g8cK1nm3qeMfjkF091fB+tt6F/n6nR54uumcY2JvV06fpylKhE+qflSA2olQZp4uws4DcesCycO5xu26ZRLi78vwhNB5jhfynOylWWyDhui0/5lcindAlE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZO+tUVGW; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250818171833epoutp0118c37c0495edd08e7563afeb1185978d~c7BE6LsmY1353113531epoutp01X
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 17:18:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250818171833epoutp0118c37c0495edd08e7563afeb1185978d~c7BE6LsmY1353113531epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755537513;
	bh=JmSGRyHuxg4sFJyN1+ZDBr/4xtXj34dMzItnfLdMcyY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=ZO+tUVGW9j76Gf6QNoG7EvuYBG0IN+U8H9BPj0zJnedSfLSj3GdVWqiZvli1wXQLw
	 ZtQrILgZa8nIdVn5n70Qo/fmF6dRM/1FHqtrtz8e7N0GGRNkciMmIdRwJW5C7M5OdE
	 axSFLqrFF8eZN9gdkQRDQel8pmBiLh/xdcjjWOf4=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250818171832epcas5p1538558efb743b5c6f4ca5021cfafef2c~c7BDlpN2R1081410814epcas5p1g;
	Mon, 18 Aug 2025 17:18:32 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.92]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4c5KDl11mXz3hhT3; Mon, 18 Aug
	2025 17:18:31 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250818084620epcas5p3ddf1f9039fde76922af543c84d2a37c8~c0B2MjXJr3103431034epcas5p3u;
	Mon, 18 Aug 2025 08:46:20 +0000 (GMT)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250818084617epsmtip1877f5f85d903a96326fc66b5943907e0~c0BzfnJte3004130041epsmtip1g;
	Mon, 18 Aug 2025 08:46:17 +0000 (GMT)
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
In-Reply-To: <9e065582-9349-4f39-88b5-048d333ab8d7@kernel.org>
Subject: RE: [PATCH v3 07/12] dt-bindings: PCI: Add support for Tesla FSD
 SoC
Date: Mon, 18 Aug 2025 14:16:16 +0530
Message-ID: <000901dc101c$917bf160$b473d420$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHWPHKmIG2WTsjb/5pkHKJ2GfeRPwFcVLShAs+fyqkBgLjEDbRGWWvg
Content-Language: en-in
X-CMS-MailID: 20250818084620epcas5p3ddf1f9039fde76922af543c84d2a37c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250811154725epcas5p428fa3370a32bc2b664a4fd8260078097
References: <20250811154638.95732-1-shradha.t@samsung.com>
	<CGME20250811154725epcas5p428fa3370a32bc2b664a4fd8260078097@epcas5p4.samsung.com>
	<20250811154638.95732-8-shradha.t@samsung.com>
	<9e065582-9349-4f39-88b5-048d333ab8d7@kernel.org>

> > +
> > +  phys:
> > +    maxItems: 1
> > +
> > +  samsung,syscon-pcie:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: phandle for system control registers, used to
> > +                 control signals at system level
> 
> What is "system level"? and what are these "signals" being controlled?
> 

I will add a more detailed description for why the syscon is being used

> 
> > +title: Tesla FSD SoC series PCIe Host Controller
> > +
> > +maintainers:
> > +  - Shradha Todi <shradha.t@samsung.com>
> > +
> > +description:
> > +  Tesla FSD SoCs PCIe host controller inherits all the common
> > +  properties defined in samsung,exynos-pcie.yaml
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/samsung,exynos-pcie.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: tesla,fsd-pcie
> > +
> > +  clocks:
> > +    maxItems: 4
> > +
> > +  clock-names:
> > +    items:
> > +      - const: aux
> > +      - const: dbi
> > +      - const: mstr
> > +      - const: slv
> > +
> > +  num-lanes:
> > +    maximum: 4
> > +
> > +  samsung,syscon-pcie:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: phandle for system control registers, used to
> > +                 control signals at system level
> > +
> > +required:
> > +  - samsung,syscon-pcie
> 
> clocks are required, compatible as well.
> 

Since this was inheriting the common exynos yaml file and that had these properties
under required, I did not mention again. Will take care in next version.

> Missing supplies, both as properties and required. PCI devices do not
> work without power.
> 

According to the HW design of FSD SoC, the control to manage PCIe power is given to
a separate CPU where custom firmware runs. Therefore, the Linux side does not control
the PCIe power supplies directly and are hence not included in the device tree.

> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/fsd-clk.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        pcierc1: pcie@16b00000 {
> > +            compatible = "tesla,fsd-pcie";
> > +            reg = <0x0 0x16b00000 0x0 0x2000>,
> > +                  <0x0 0x168c0000 0x0 0x1000>,
> > +                  <0x0 0x18000000 0x0 0x1000>;
> > +            reg-names = "dbi", "elbi", "config";
> > +            ranges =  <0x82000000 0x0 0x18001000 0x0 0x18001000 0x0 0xffefff>;
> 
> Misaligned. Follow closely DTS coding style.
> 

Will take care.



