Return-Path: <linux-pci+bounces-40909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8087C4E1B8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 14:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B41F3ADA21
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E8533ADB0;
	Tue, 11 Nov 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="PsPV9syg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731102.qiye.163.com (mail-m19731102.qiye.163.com [220.197.31.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C873D328277;
	Tue, 11 Nov 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867704; cv=none; b=pEc4cvkpVzhpo+58gqPYgQQxRGOFqvMYJLCgZsqlIfUy3Fql12UC2ukwu1inYPfJet+RAXwFWnGVH/vjBJBXPfLVkEiHBaReiUePWDARymB4sV3/4Jj9mVjRkxop3ZaxFf7yKSPcxJY9UtaQjd2vTU0PHhj/yoBYBK5jojce3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867704; c=relaxed/simple;
	bh=qasncx5kM7I4waFsVrmupWo20+ww0qPodJcJnInnrmE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OtyZadVfKYHhrpbXwSxIUNs5JZTrxvnqFNzDX2O1TqbzCd6GDtRkaVD024yt9NH9yNHKwHaDHMSgWYdTzgub8EDgW4cdUuAe9t+c1k5FBR0T/u2JNO372tRmyiRJev0Q5AV8ZP3Ey9xygbUdCvre16j4iuCFzRDxTp6ru0z3iv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=PsPV9syg; arc=none smtp.client-ip=220.197.31.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [192.168.61.151] (unknown [110.83.51.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29341817e;
	Tue, 11 Nov 2025 21:28:10 +0800 (GMT+08:00)
Message-ID: <6a2bef88-1fe8-4477-a179-e97e1e0b7178@rock-chips.com>
Date: Tue, 11 Nov 2025 21:28:08 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
 Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Diederik de Haas <diederik@cknow-tech.com>, stable@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Prevent advertising L1 Substates
 support
To: Niklas Cassel <cassel@kernel.org>
References: <20251017163252.598812-2-cassel@kernel.org>
 <176101411705.9573.17573145190800888773.b4-ty@kernel.org>
 <aRM1VOodnSpaob3P@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aRM1VOodnSpaob3P@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a731a3b6809cckunm78c1b6a21c673
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQhlLVkoeQh5LGkwZTh1NSVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
	JLS1kG
DKIM-Signature: a=rsa-sha256;
	b=PsPV9sygri8khXx7L0KPcrb4K3lnqIauAzyiSn44IFWT66tYJF8tOt8M8HTkNJYXomdo3DjUu1agtzuyIgN8fNm+66ysjTgdhT1k61W8OrhpBpRjLx0R1BGito43W+sxzWEL8IMTlvryifTLmXWvVTHhSn/2DAymXNfo16aYY0A=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=/u83YnPFnggQ2E/YqF7yyEYzCXsQAILKrvqFHKQdRqo=;
	h=date:mime-version:subject:message-id:from;


在 2025/11/11 星期二 21:08, Niklas Cassel 写道:
> Hello Mani,
> 
> On Tue, Oct 21, 2025 at 08:05:17AM +0530, Manivannan Sadhasivam wrote:
>>
>> On Fri, 17 Oct 2025 18:32:53 +0200, Niklas Cassel wrote:
>>> The L1 substates support requires additional steps to work, namely:
>>> -Proper handling of the CLKREQ# sideband signal. (It is mostly handled by
>>>   hardware, but software still needs to set the clkreq fields in the
>>>   PCIE_CLIENT_POWER_CON register to match the hardware implementation.)
>>> -Program the frequency of the aux clock into the
>>>   DSP_PCIE_PL_AUX_CLK_FREQ_OFF register. (During L1 substates the core_clk
>>>   is turned off and the aux_clk is used instead.)
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] PCI: dw-rockchip: Prevent advertising L1 Substates support
>>        commit: 40331c63e7901a2cc75ce6b5d24d50601efb833d
> 
> Last update in this thread was "Applied, thanks!"
> 
> and the patch was applied to pci/controller/dw-rockchip
> 
> since then it seems to have been demoted to pci/controller/dw-rockchip-pend
> 
> I'm simply curious, what is the plan for this patch?
> 
> I know that Shawn was working on a series that adds support for L1ss for
> this driver, but it seems to have stagnated, so it seems far from certain

Yes, that's because Bjorn prefers to disable it in dwc core intially and
sent a patch which we discussed but didn't come to a conclusion. So I 
still be waiting..:）

> that it will be ready in time to make it for the v6.19 merge window.
> 
> Right now, pci/next branch seems to merge pci/controller/dw-rockchip rather
> than pci/controller/dw-rockchip-pend.
> 
> If the L1ss does not make it in time, then this patch will not have had any
> time in linux-next, which might not make Linus happy.
> 
> 
> Kind regards,
> Niklas
> 


