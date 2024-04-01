Return-Path: <linux-pci+bounces-5496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC099894450
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 19:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772361F2160C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B18C4C3C3;
	Mon,  1 Apr 2024 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mlxW8Xic"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D048CDD
	for <linux-pci@vger.kernel.org>; Mon,  1 Apr 2024 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992501; cv=none; b=qQApDmpLy7M5mk66DyXqF9G0pLktT1YSHmpVjJUOS94rAaQdW4TU8rcveXtuhsZ0tihCr/5+aYsZTZN8obXvFIKQW9BEy4sTwODmS8XEyTMtq1GNUBxduVm0zJ2xSw6XI4H4+SjxTSCyihJPHyqfmkx6Z9BjUnpxmUT4iwWQm0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992501; c=relaxed/simple;
	bh=X+pQ6qg09dZvwCFQeVEOA5bwu4q0gg9n6Hx+6Z9DH6A=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KJA6wGe360pYD8sfiLLn4BlJUhxI4+MulugNwWqD7hSCNlXuPGoftcljD1Lk7YDWJU2Zc8dcdddmyVcRiabbMhCC9nB3/JFNISsTfKkn065b3SUThI9vTHadIhnVAQyS2lhT+kIr9dq0VefXOLmEuQz+tnM1S/YOuYmH9fTLHrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mlxW8Xic; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711992495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GcyQB2SpBRzc7F7Fs2OGW1YzrGJMJNel6cPq11Q+YyE=;
	b=mlxW8XicAIS9SwXJRhdu9Dv6QzWSW5GARhQYWa6kbRXGk/Pm87W2h9tXDlKP5e8IKiyaor
	LCobLS1JM7HOG+vHchRqBrraG5hYexy+RUVq6+HO7aiXp8wC/3+rG5vRXipR1AK3j/brYX
	qdq7UwyFBP38BOlSIXR7IxGmEN3ZjwZCGmJYWl3y8Wvc/THEvMsJUOQyg6mlYBFdKRuiA7
	5RG+/T0/q8n5RvQZdaqDvey56wI/nvUDcrnUF5HUxGp06TCkbibHZJn7QBlmmdP9Pwh9RU
	LZSrOjq3MGMJUw33m09BW96YVOur/gD5qN9GqgSlEptgZIiZqP2gV17KoC9Fuw==
Date: Mon, 01 Apr 2024 19:28:15 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: rockchip-host: Fix rockchip_pcie_host_init_port()
 PERST# handling
In-Reply-To: <89eb3414-38ba-4397-9ed7-aebebbdadd07@kernel.org>
References: <20240330035043.1546087-1-dlemoal@kernel.org>
 <d1ed4a0bf702d9927d4e9279f19bcf7b@manjaro.org>
 <89eb3414-38ba-4397-9ed7-aebebbdadd07@kernel.org>
Message-ID: <19d7def23f537b0a5a0aa09dd0638ac5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-01 08:59, Damien Le Moal wrote:
> On 4/1/24 04:34, Dragan Simic wrote:
>> Please see my comments below.
>> 
>> On 2024-03-30 04:50, Damien Le Moal wrote:
>>> The PCIe specifications (PCI Express Electromechanical Specification
>>> rev
>>> 2.0, section 2.6.2) mandate that the PERST# signal must remain 
>>> asserted
>>> for at least 100 usec (Tperst-clk) after the PCIe reference clock
>>> becomes stable (if a reference clock is supplied), for at least 100
>>> msec
>>> after the power is stable (Tpvperl).
>>> 
>>> In addition, the PCI Express Base SPecification Rev 2.0, section 
>>> 6.6.1
>>> state that the host should wait for at least 100 msec from the end of 
>>> a
>>> conventional reset (PERST# is de-asserted) before accessing the
>>> configuration space of the attached device.
>>> 
>>> Modify rockchip_pcie_host_init_port() by adding two 100ms sleep, one
>>> before and after bringing back PESRT signal to high using the ep_gpio
>>> GPIO. Comments are also added to clarify this behavior.
>>> 
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>> ---
>>> 
>>> Changes from v1:
>>>  - Add more specification details to the commit message.
>>>  - Add missing msleep(100) after PERST# is deasserted.
>>> 
>>>  drivers/pci/controller/pcie-rockchip-host.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>> 
>>> diff --git a/drivers/pci/controller/pcie-rockchip-host.c
>>> b/drivers/pci/controller/pcie-rockchip-host.c
>>> index 300b9dc85ecc..ff2fa27bd883 100644
>>> --- a/drivers/pci/controller/pcie-rockchip-host.c
>>> +++ b/drivers/pci/controller/pcie-rockchip-host.c
>>> @@ -294,6 +294,7 @@ static int rockchip_pcie_host_init_port(struct
>>> rockchip_pcie *rockchip)
>>>  	int err, i = MAX_LANE_NUM;
>>>  	u32 status;
>>> 
>>> +	/* Assert PERST */
>>>  	gpiod_set_value_cansleep(rockchip->ep_gpio, 0);
>>> 
>>>  	err = rockchip_pcie_init_port(rockchip);
>>> @@ -322,8 +323,19 @@ static int rockchip_pcie_host_init_port(struct
>>> rockchip_pcie *rockchip)
>>>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>>>  			    PCIE_CLIENT_CONFIG);
>>> 
>>> +	/*
>>> +	 * PCIe CME specifications mandate that PERST be asserted for at
>>> +	 * least 100ms after power is stable.
>>> +	 */
>>> +	msleep(100);
>> 
>> Perhaps it would be slightly better to use usleep_range()
>> instead of msleep().
> 
> I can do that, but I fail to see the advantage. Why do you say that
> it may be better ?

Actually, I was wrong.  When sleeping for 100 msec, msleep()
is actually the preferred variant. [1]

[1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt

>>>  	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
>>> 
>>> +	/*
>>> +	 * PCIe base specifications rev 2.0 mandate that the host wait for
>>> +	 * 100ms after completion of a conventional reset.
>>> +	 */
>>> +	msleep(100);
>> 
>> Obviously, the same comment as above applies here.
>> 
>>> +
>>>  	/* 500ms timeout value should be enough for Gen1/2 training */
>>>  	err = readl_poll_timeout(rockchip->apb_base +
>>> PCIE_CLIENT_BASIC_STATUS1,
>>>  				 status, PCIE_LINK_UP(status), 20,

