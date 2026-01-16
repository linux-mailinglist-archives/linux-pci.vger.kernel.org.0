Return-Path: <linux-pci+bounces-45057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D42CD3303C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 16:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F93231AA5C9
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 14:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4553B23D2B2;
	Fri, 16 Jan 2026 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hHHjCJ+M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m21471.qiye.163.com (mail-m21471.qiye.163.com [117.135.214.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FC22FFDF8;
	Fri, 16 Jan 2026 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575217; cv=none; b=sW26riHlhp5RszXH/IQnEckELOSGT2eEV4GjaXMFsU9PuSQRbWSWVP5xRLHf2DJAFMaxiweZ464NjTPm0PoA8vqq8ZC8/rRMY3cHYyzfDWL+irbUBwXekBA7n8ghdibbU6DKVk0BKo1KxOpks8M/lZIz7+XmuP8BgPnV3P5wows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575217; c=relaxed/simple;
	bh=3rGPNZW1O4ysdszwdgsirm5Xfu5YLMd4ZfYEpEyrBMY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KGlBfERP7C9Xj/+1cHKvs7MeKDEq17bkbISCgd3bjxCo711xsnzuEyT6SLykahIiaTL+it3YnZYPJhnRr7KMD2GtxN5oP3bcQyaTN/FoWITz3FHKZrS1dM9ENK+ZyZ//yre/NgGVD/TEGRxdidoftBkVSDzGpuHksYFL/j8CLC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hHHjCJ+M; arc=none smtp.client-ip=117.135.214.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30efd4248;
	Fri, 16 Jan 2026 22:48:14 +0800 (GMT+08:00)
Message-ID: <72e23e5a-6fdb-42c1-8d09-70a4d0890307@rock-chips.com>
Date: Fri, 16 Jan 2026 22:48:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Sean Anderson <sean.anderson@seco.com>,
 manivannan.sadhasivam@oss.qualcomm.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@kernel.org>, Brian Norris <briannorris@chromium.org>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Alex Elder <elder@riscstar.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Chen-Yu Tsai <wenst@chromium.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 0/8] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
To: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
 <0da0295a-4acb-430e-ae1a-e144f07418d0@seco.com>
 <6iqn3pmk7jb7j6cvmuv6ggs6xkd6ouz6klzhzdekrlzpbgxcua@ebskaj25jukl>
 <ef5d5fdc-be08-4859-a625-cdd1ae0c46c2@seco.com>
 <55cqkglbgji7tz34hk7aishyq3wal3oba5hy2yfvdbnkugadyg@56yh35kcgtwf>
 <aWo_kP170j7r4q1a@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aWo_kP170j7r4q1a@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc747414b09cckunm1909f32d739c49
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk5DH1YZQ0IZThgaQk8fHRpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hHHjCJ+MWKnpj/DfzGn37vGEGCq1LLjBG5L3w8k1K3H7geU9RFz8ctogv0crCb/Lp9PmtS30jX50/yaRBUTLse8/cb2XeYQniulyX2iIpmZxAznCBXrjOo1h5m5ng8t9LMeVnCEFSv+Q24XTdTu3oJgn6X8vVRHV6D1etvvqBxA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=7JHT5Ei0LrosWcfSDUb+lhrU7jo5qecDT7sHr4EJCMM=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/16 星期五 21:40, Niklas Cassel 写道:
> On Fri, Jan 16, 2026 at 11:54:26AM +0530, Manivannan Sadhasivam wrote:
>> On Thu, Jan 15, 2026 at 02:26:32PM -0500, Sean Anderson wrote:
>>>>
>>>> Not at all. We cannot model PERST# as a GPIO in all the cases. Some drivers
>>>> implement PERST# as a set of MMIO operations in the Root Complex MMIO space and
>>>> that space belongs to the controller driver.
>>>
>>> That's what I mean. Implement a GPIO driver with one GPIO and perform
>>> the MMIO operations as requested.
>>>
>>> Or we can invert things and add a reset op to pci_ops. If present then
>>> call it, and if absent use the PERST GPIO on the bridge.
>>>
>>
>> Having a callback for controlling the PERST# will work for the addressing the
>> PERST# issue, but it won't solve the PCIe switch issue we were talking above.
>> And this API design will fix both the problems.
>>
>> But even in this callback design, you need to have modifications in the existing
>> controller drivers to integrate pwrctrl. So how that is different from calling
>> just two (or one unified API for create/power_on)?
> 
> FWIW, I do think that it is a good idea to create a reset op to pci_ops
> that will implement PERST# assertion/deassertion.
> 

That's exactly what I had in mind when looking at different PCIe host
drivers that why individual drivers should implement their own powering
up sequence, regarding to the face that bringing devices up should
always follow the timing defined PCI Express Card Electromechanical
Specification R6.0.1, section 2.2.1 "Initial Power Up(G3 to S0)"


> Right now, it is a mess, with various drivers doing this at various
> different places.
> 
> Having a specific callback, the driver implement it however they want
> GPIO, MMIO, whatever, and it could even be called by (in case of DWC,
> the host_init, by pwrctrl, or potentially by the PCI core itself before
> enumerating the bus.
> 
> If we don't do something about it now, the problem will just get worse
> with time. Yes, it will take time before all drivers have migrated and
> been tested to have a dedicated PERST# reset op, but for the long term
> maintainability, I think it is something that we should do.

Ack. That will also consolidate more timing relate improvements
together. For instance, almost all drivers holds PERST# for 100ms
Tpvperl before release it, but 100ms is the minimal value defined by
spec. I have to say it's broken for several EP cards I have debugged in 
practice these years. With holding all powering up timing together into
pwrctrl design could really helpful in the future.


> 
> I also know that some drivers have some loops with retry logic, where
> they might go down in link speed, but right now I don't see why those
> drivers shouldn't be able to keep that retry logic just because we
> add a dedicated PERST# callback.
> 
> 
> All that said, that would be a separate endeavor and can be implemented
> later.
> 
> 
> Kind regards,
> Niklas
> 
> 


