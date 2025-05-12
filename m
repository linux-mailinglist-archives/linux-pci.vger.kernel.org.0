Return-Path: <linux-pci+bounces-27601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AD5AB4593
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 22:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE7697B2304
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 20:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0EB29713D;
	Mon, 12 May 2025 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RFQZ02rB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jwQwBf28"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF32517BE;
	Mon, 12 May 2025 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747082558; cv=none; b=nxO3g8ZwhX9N1qKwr0zoW5FfMSll2AroAWVoteamllQVRfzAhspQl6RU+gyDxzqZWMHMuuBzcia3CyLeURwsNM71Yriv6LMW4EO7/tE6t5GYnqqO/QxxgylzmWSb+3ycHS+H6CBT+bxlaOP6pDEB7lmUy8GYZw1JDKwFSAhYzfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747082558; c=relaxed/simple;
	bh=Qhq3A+I3T/dhIKwOPy/tKP8hXlbgx08lP5ODo0zafgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXs30jA3iCX8IDImMcdVpsLLnLckw3HUvKa8U8hWINM0YK9cz50lFYLKhJFw1EwpQZPbig5LXK+HVnrTevqzGQSkPLYuzEOTMqJoVS/En/nEmWrt1CaO25SbiSs+3khg7gxrB/mfrhK/kyARbEQFKrJf/ku2izJcEMvO15q71bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RFQZ02rB; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jwQwBf28; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZxBPJ0fRnz9t0N;
	Mon, 12 May 2025 22:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1747082548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWLL8SXxaDrHsmjoDkrhtKmQby8WHNCD8s1a74YU7+8=;
	b=RFQZ02rBHjUQCIZLYQEaMZn38oPSVM1/LuHrmeQlJffCxoISGZ/KZihlMGeuvbo5RQgfzj
	bqZPnC8AjlZxZ99NAk9cDcX1e9ajfPzBCDg/mWT5JEriDylCQmtRDmJuVppLFPCGIFkB4O
	cO8mOV4eQrWx5l1GMFbPrvZplUS3cykWjoqI+OwnHemmGepBoy6hugM15Oh+krT3woDj3N
	1A5o3aQ727yR2ZZpB95qeqeg3IaroRYFkwNXsWpowWYn+1+Lh0pDWGGmS2n87BQocflIKe
	DcdE3NFmxRiEYwAmDExAH7FPht2ybOWPudu8w5tXaZuIrfMUWYgeWTMVLI6VhA==
Message-ID: <84cc6341-a2c1-4e3c-8c9e-2bc6589c52a6@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1747082545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWLL8SXxaDrHsmjoDkrhtKmQby8WHNCD8s1a74YU7+8=;
	b=jwQwBf28noG1EfxvsMWTvb8VBv6jfgaoj3Z2EzGnVRAZe4uPzWVo1ot8ZAzoxLgPV3QfsO
	xI1oymiEb6QlZwcZGx295e+uM6GlsVvUyxRlcF11nQGo3ALXUyLS7DlLBYL7BOlpct8BCm
	z+t6wcUpHy/m8qeOv6PhtZTzLrmR1eYrlQxp+2JRKh4i2XIGM9WOkcnT39qeDbalGSXovL
	3ZnMMiic0RrOMxKTPe2NI0TUGQOsQc/W152jwmGseOZX71eAgzEQme6/QpU9RiuWWg03h1
	wN97+CQGpg2ri3oWCIG+oiLjSrNRSBZV3mJtdrJ9y1bEljAUhX/v8UmKcNk79A==
Date: Mon, 12 May 2025 22:42:20 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: rcar-gen4-pci-host: Document
 optional aux clock
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org,
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <2ny7jhcp2g5ixo75donutncxnjdawzev3mw7cytvhbk6szl3ue@vixax5lwpycw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 39ed119621876b7bcad
X-MBO-RS-META: 18mqeswom1weurmm9iatqr45af155u75

On 5/9/25 9:37 PM, Manivannan Sadhasivam wrote:
> On Sun, Apr 06, 2025 at 04:45:21PM +0200, Marek Vasut wrote:
>> Document 'aux' clock which are used to supply the PCIe bus. This
>> is useful in case of a hardware setup, where the PCIe controller
>> input clock and the PCIe bus clock are supplied from the same
>> clock synthesiser, but from different differential clock outputs:
> 
> How different is this clock from the 'reference clock'? I'm not sure what you
> mean by 'PCIe bus clock' here. AFAIK, endpoint only takes the reference clock
> and the binding already has 'ref' clock for that purpose. So I don't understand
> how this new clock is connected to the endpoint device.

See the ASCII art below , CLK_DIF0 is 'ref' clock that feeds the 
controller side, CLK_DIF1 is the bus (or 'aux') clock which feeds the 
bus (or endpoint) side. Both clock come from the same clock synthesizer, 
but from two separate clock outputs of the synthesizer.

>>   ____________                    _____________
>> | R-Car PCIe |                  | PCIe device |
>> |            |                  |             |
>> |    PCIe RX<|==================|>PCIe TX     |
>> |    PCIe TX<|==================|>PCIe RX     |
>> |            |                  |             |
>> |   PCIe CLK<|======..  ..======|>PCIe CLK    |
>> '------------'      ||  ||      '-------------'
>>                      ||  ||
>>   ____________       ||  ||
>> |  9FGV0441  |      ||  ||
>> |            |      ||  ||
>> |   CLK DIF0<|======''  ||
>> |   CLK DIF1<|==========''
>> |   CLK DIF2<|
>> |   CLK DIF3<|
>> '------------'

