Return-Path: <linux-pci+bounces-22297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44048A43851
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 09:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07DD188A901
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 08:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B568262D11;
	Tue, 25 Feb 2025 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="WwmsGDcz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49215.qiye.163.com (mail-m49215.qiye.163.com [45.254.49.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E2D262D05;
	Tue, 25 Feb 2025 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473666; cv=none; b=o4NL169eaUqYotwZliX1wG9GBZn+nVpo2S3TLP34K6oyPR+bqLgLLYj8qZfkhVMC35K8NO+m2utufPbhT1iAyq0KLCHO6zOK5Avq5AeApeTxq3ZL9jXVdZSuqdcItM8BIcaiHDhFmbZ7815y/4phm7GbbXd1kBzdGw1iQDg2HpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473666; c=relaxed/simple;
	bh=rxlDCNHlsFY5Fl/DxdROcp97mxpJR6HH6M5R8AMv1wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCSmklidbvpnllERpoLULXBph8qa0prgL5S3vL70wAxeMGA9umQf/p9I3DYfYsEFQPp2XgOiy7dkBLJz/BHNa4xc1cOgLrXyVqv08acRUaGowlBQrrU2hfpq24JPa2RwHpQMM93V4eTPcAeeLC5rbg5TZM18E8dsFItEx6EI5ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=WwmsGDcz; arc=none smtp.client-ip=45.254.49.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c1f11c0c;
	Tue, 25 Feb 2025 16:38:54 +0800 (GMT+08:00)
Message-ID: <478b8972-07b9-483b-a3ef-bdea10c4e4cc@rock-chips.com>
Date: Tue, 25 Feb 2025 16:38:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: PCI: dw: rockchip: Add rk3576 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Xue <xxm@rock-chips.com>, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
References: <20250224074928.2005744-1-kever.yang@rock-chips.com>
 <20250224-gifted-piculet-of-amplitude-a91ecd@krzk-bin>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250224-gifted-piculet-of-amplitude-a91ecd@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx0ZTVYZH0NJHRoYHR1ISkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a953c4253a003afkunmc1f11c0c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTI6ERw5EDIOHRYjHB9MLRUU
	EB8aCRlVSlVKTE9LT0xJTEhNQ0pOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIT0xPNwY+
DKIM-Signature:a=rsa-sha256;
	b=WwmsGDczbRBij3SrocnQVsTJaDABZZZ39b0m72Yb797JBiACL+JGw6Mh3E8ANIgWQy+mGdZx1HvDwxj7H+dVw9Oxh3vYiqupcihCxfuvIPmmjPRctB0IS4h3HQCttRJXe8NCQF9KVRQCS4Hotu39VTGVMsIUYNwyZoGzqFwsO40=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=ltPMBWdpitIAr/1lqIvGJ/KYikU2UivViANg4djpIMI=;
	h=date:mime-version:subject:message-id:from;

Hi Krzysztof,

     Thanks for your review.

On 2025/2/24 17:28, Krzysztof Kozlowski wrote:
> On Mon, Feb 24, 2025 at 03:49:27PM +0800, Kever Yang wrote:
>> rk3576 is using DWC PCIe controller, with msi interrupt directly to GIC
>> instead of using GIC ITS, so
>> - no ITS support is required and the 'msi-map' is not required,
>> - a new 'msi' interrupt is needed.
>>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>> ---
>>
>> Changes in v6:
>> - Fix make dt_binding_check and make CHECK_DTBS=y
>>
>> Changes in v5:
>> - Add constraints per device for interrupt-names due to the interrupt is
>> different from rk3588.
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
>>   .../bindings/pci/rockchip-dw-pcie-common.yaml | 41 ++++++++++++++++++-
>>   .../bindings/pci/rockchip-dw-pcie.yaml        | 19 ++++++---
>>   2 files changed, 52 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
>> index cc9adfc7611c..e1ca8e2f35fe 100644
>> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
>> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
>> @@ -65,7 +65,11 @@ properties:
>>             tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
>>             nf_err_rx, f_err_rx, radm_qoverflow
>>         - description:
>> -          eDMA write channel 0 interrupt
>> +          If the matching interrupt name is "msi", then this is the combinded
>> +          MSI line interrupt, which is to support MSI interrupts output to GIC
>> +          controller via GIC SPI interrupt instead of GIC its interrupt.
>> +          If the matching interrupt name is "dma0", then this is the eDMA write
>> +          channel 0 interrupt.
>>         - description:
>>             eDMA write channel 1 interrupt
>>         - description:
>> @@ -81,7 +85,9 @@ properties:
>>         - const: msg
>>         - const: legacy
>>         - const: err
>> -      - const: dma0
>> +      - enum:
>> +          - msi
>> +          - dma0
>>         - const: dma1
>>         - const: dma2
>>         - const: dma3
>> @@ -123,4 +129,35 @@ required:
>>   
>>   additionalProperties: true
>>   
>> +anyOf:
> There is never syntax like that. Where did you find it (so we can fix
> it)?
>
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: rockchip,rk3576-pcie
> This does not belong to common schema, but to device specific. I don't
> see this compatible in this common schema at all.

The common schema covers rockchip-dw-pcie.yaml and rockchip-dw-pcie-ep.yaml,

so I though I should add the if condition here.


>
>> +    then:
>> +      properties:
> interrupts:
>    minItems: 6
>    maxItems: 6
Will add this back.

Thanks,
- Kever
>> +        interrupt-names:
>> +          items:
>> +            - const: sys
>> +            - const: pmc
>> +            - const: msg
>> +            - const: legacy
>> +            - const: err
> Best regards,
> Krzysztof
>
>

