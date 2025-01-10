Return-Path: <linux-pci+bounces-19612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EDFA08923
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 08:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6503A6E73
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 07:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076EA207666;
	Fri, 10 Jan 2025 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="cUCg55WI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m127206.xmail.ntesmail.com (mail-m127206.xmail.ntesmail.com [115.236.127.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FCB207656;
	Fri, 10 Jan 2025 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494745; cv=none; b=c4VBG5W0RZ27KJZYdA9AVtxbba/1NTePJMAgbS1FZejR8zrFZPulXQKXR/6OxPIMraaZgqJkmx+uoK48sjbvcVCYxebP8+fgEjklJg9FsedGTIyUy4ZOqTF8rBPa7hJzQRPAtH9rSZCg1R/zg72aw7++H3Acc450yXKnW5RHKvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494745; c=relaxed/simple;
	bh=qZYG4Qfz84oaePgwKuQ+EMUlJvfwgjR748WmO28agoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2ggFxEzi4pdoDLVZFEfrftj6qJu/gOlo+5tFSce3IUbOJPk521VZcuvzqWrxm8CTbnsdtVsIRmQE4PZpoSi56BsYQUeuoZjIWdHkXTaUNDrQ5yi1HauHcntzECSaDgouJFozRib/JOt6ITXWFxP12Rvf+RHuy/5EXmZXvfu0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=cUCg55WI; arc=none smtp.client-ip=115.236.127.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 8511728f;
	Fri, 10 Jan 2025 15:33:49 +0800 (GMT+08:00)
Message-ID: <5025409d-5021-41b4-99ef-94ebde6f9828@rock-chips.com>
Date: Fri, 10 Jan 2025 15:33:49 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] dt-bindings: PCI: dw: rockchip: Add rk3576 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
 Simon Xue <xxm@rock-chips.com>, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
References: <20250107074911.550057-1-kever.yang@rock-chips.com>
 <20250107074911.550057-3-kever.yang@rock-chips.com>
 <tsxho4vhadrl6tsb2k5e2vxaeuun3k5pdkojzwjruqkof54dyd@gs3wsuxzwu4a>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <tsxho4vhadrl6tsb2k5e2vxaeuun3k5pdkojzwjruqkof54dyd@gs3wsuxzwu4a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NCHVZNSEhOSh5OGUtDHh1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a944f22372003afkunm8511728f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K0k6HRw5TTIPTA8jFiMXPzIs
	AxIaFBhVSlVKTEhNT0JPT0hKTUJLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS0xPNwY+
DKIM-Signature:a=rsa-sha256;
	b=cUCg55WIgxh7Krkfj5w+j2tmu5+OrqTz198q9yBn6KHGeWg4DqxM0S6ixBBrvTZlZThXX+QKAfbbYtXiZwoJVDrTYlZaFbNtNpWcybdvlQCOGmN7aIjPj4YT37Y9zkC7vhcUdAbJsavbzJHWRLuLsPev/ZlwcdV9gywUhcaRSHw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=TOxPOUhClqqhDKpCo7Jmi3oX0GLglQHl4yT+VgEP/lI=;
	h=date:mime-version:subject:message-id:from;

Hi Krzysztof,

On 2025/1/8 16:16, Krzysztof Kozlowski wrote:
> On Tue, Jan 07, 2025 at 03:49:06PM +0800, Kever Yang wrote:
>> rk3576 is using dwc controller, with msi interrupt directly to gic instead
>> of to gic its, so
>> - no its support is required and the 'msi-map' is not need anymore,
>> - a new 'msi' interrupt is needed.
>>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>
>> Changes in v4:
>> - Fix wrong indentation in dt_binding_check report by Rob
>>
>> Changes in v3:
>> - Fix dtb check broken on rk3588
>> - Update commit message
>>
>> Changes in v2:
>> - remove required 'msi-map'
>> - add interrupt name 'msi'
>>
>>   .../devicetree/bindings/pci/rockchip-dw-pcie-common.yaml      | 4 +++-
>>   Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml   | 4 +---
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
>> index cc9adfc7611c..e4fcc2dff413 100644
>> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
>> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
>> @@ -81,7 +81,9 @@ properties:
>>         - const: msg
>>         - const: legacy
>>         - const: err
>> -      - const: dma0
>> +      - enum:
>> +          - msi
>> +          - dma0
> Commit msg said new interrupt, but this basically replaces existing DMA0
> interrupt. Maybe that's the problem with this common binding and you
> just miss constraining in each device binding. If so: fix also them.
rk3588 has 9 interrupt, and the 6th-9th is dma0-3;
rk3568 only has 5 interrupts, no dma0-3;
rk3576 add one more "msi" interrupt which is the 6th interrupt;
The upcomming rk3562 is the same as rk3576.
I'm sorry I'm not so good at this yaml grammar, how should I take care 
of this case?


Thanks,
- Kever
>
> Also: your interrupts property does not match this anymore.
>
> Best regards,
> Krzysztof
>
>

