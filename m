Return-Path: <linux-pci+bounces-28393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78833AC35AA
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 18:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3700B16FA40
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 16:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD7B13B284;
	Sun, 25 May 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LMl9xoOK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="L0h/0n+z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931C3FD4;
	Sun, 25 May 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748189245; cv=none; b=IAzqQA3X9KUuBIWCeSUEubAopyCVv0cCHHsxN985G/zujKHjXJLFITujwZt2+Q22JsWaLBnSzeGnC0F3NHObKJyUqQufJPKcMttdj6zckq6H2oEBGcMTNGj1Ug47jdkVCRUbEIg3/TgrtsxQynVn/NG3IyUhfMa5jE/hHLW6wCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748189245; c=relaxed/simple;
	bh=KZQ40oOS6DwwPvTfaWDOd0kE7VusIOBcIRg05+qw5vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pci3bMDywhhZjaKwvroCOwbubxQDtk12UY4bZGMAS6aHcJKCCawHORMVvJmVtx9RfikL4/F+P30EHQR3zST2q3GuDuHJmVnOTeDgsoh4DQt5xUUc6tYQfvyz1GOrEXSi+1VcVZQ7Fg2GnCqjU88zGKxjNpNp9Y+NV1pcd/bGUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LMl9xoOK; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=L0h/0n+z; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4b53gs3Gq5z9t0p;
	Sun, 25 May 2025 18:07:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748189241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ge+Qb/J48yhxSaNKIMUsB1dyJ9dP97tIunM4dMdF9Q8=;
	b=LMl9xoOK8qJZ0Hort6KN20Qm+Zk1irqjt9p3XD+85pQNYzoki/LKQVZ592GgsT7Zo+LNvV
	YlrsBLPuzAPVZvSZllkLJsF3kGwzifwQ9HPxKzsqeJDKULQ8JgupYcv+FxGvP9whyUbrRx
	YhJOl4g9OD5OtPsZTvpAwiHArgCO+UDNt5cTOT2f/H4JFpnC++vgiPiPKikHRObwsyfnUe
	9KFsYDGG5s5WChJBSK0Hw6l1xh6ybdi4avqpUayyb8WxFOcQKbbTTwVbFE2KvA4QCW+h3R
	Y9JWPshmrS+i6ZwCPsxhSxnm3IkY1T3YJ/e7UKGsrMxXc6Zn5B9jsoja6/pruQ==
Message-ID: <cba4d5e0-b330-4af8-a96a-b501d523c6bb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748189239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ge+Qb/J48yhxSaNKIMUsB1dyJ9dP97tIunM4dMdF9Q8=;
	b=L0h/0n+zQgE4ChgBIXOoQfkfgHoTosE9YXEwXesvgwbkact2WCUQTHTTJYMLHw6TMIzGxe
	tpnsdwjFQnhwYcfuPo72eoWe9wz9rgDVtVBw1+0UaVX8J9lAw0lHlPR1l/fkp5X3Gw0Y/f
	iSv31hUaAPjoIgRzmtHB/ygZWK61I7Tjh6Yjwx6Ulvw0y08aD+iy4EE+FJ/vVWq+RvtTYf
	9bXlZTjzc48PBh+l+Hn+q7eNJ1IVhJI5E/KPDytBBsHUoXenDOXDKFcWK3bfGL9EIO2144
	p+GNgNaxnXu23Xitj4f4OPBDy8qFAS66fqv1/HJTy5J0E2E6zu96WJQzpOKzhw==
Date: Sun, 25 May 2025 18:07:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: rcar-gen4-pci-host: Document
 optional aux clock
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>,
 Kever Yang <kever.yang@rock-chips.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250406144822.21784-1-marek.vasut+renesas@mailbox.org>
 <20250406144822.21784-2-marek.vasut+renesas@mailbox.org>
 <2ny7jhcp2g5ixo75donutncxnjdawzev3mw7cytvhbk6szl3ue@vixax5lwpycw>
 <84cc6341-a2c1-4e3c-8c9e-2bc6589c52a6@mailbox.org>
 <ne4injlr4nwvufjdg7uuisxwipqfwd5voohktnbjjvod5om3p3@eriso5cw77ov>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ne4injlr4nwvufjdg7uuisxwipqfwd5voohktnbjjvod5om3p3@eriso5cw77ov>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: oiqd5n1xyzdecnbzqfywr8eedrmc9mzg
X-MBO-RS-ID: eacf1afced01bac336f

On 5/15/25 1:57 PM, Manivannan Sadhasivam wrote:
> On Mon, May 12, 2025 at 10:42:20PM +0200, Marek Vasut wrote:
>> On 5/9/25 9:37 PM, Manivannan Sadhasivam wrote:
>>> On Sun, Apr 06, 2025 at 04:45:21PM +0200, Marek Vasut wrote:
>>>> Document 'aux' clock which are used to supply the PCIe bus. This
>>>> is useful in case of a hardware setup, where the PCIe controller
>>>> input clock and the PCIe bus clock are supplied from the same
>>>> clock synthesiser, but from different differential clock outputs:
>>>
>>> How different is this clock from the 'reference clock'? I'm not sure what you
>>> mean by 'PCIe bus clock' here. AFAIK, endpoint only takes the reference clock
>>> and the binding already has 'ref' clock for that purpose. So I don't understand
>>> how this new clock is connected to the endpoint device.
>>
>> See the ASCII art below , CLK_DIF0 is 'ref' clock that feeds the controller
>> side, CLK_DIF1 is the bus (or 'aux') clock which feeds the bus (or endpoint)
>> side. Both clock come from the same clock synthesizer, but from two separate
>> clock outputs of the synthesizer.
>>
> 
> Okay. So separate refclks are suppplied to the host and endpoint here and no,
> you should not call the other one as 'aux' clock, it is still the refclk. In
> this case, you should describe the endpoint refclk in the PCIe bridge node:
> 
> 		pcie@... {
> 			clock = <refclk_host>;
> 			...
> 
> 			pcie@0 {
> 				device_type = "pci";
> 				reg = <0x0 0x0 0x0 0x0 0x0>;
> 				bus-range = <0x01 0xff>;
> 				clock = <refclk_ep>;
> 				...
> 			};
> 		};
> 
> 
> and use the pwrctrl driver PCI_PWRCTRL_SLOT to enable it. Right now, the slot
> pwrctrl driver is not handling the refclk, but I can submit a patch for that.
I posted a new series now, you are on CC, see

[PATCH 1/2] PCI/pwrctrl: Add optional slot clock to pwrctrl driver for 
PCI slots

Thanks

