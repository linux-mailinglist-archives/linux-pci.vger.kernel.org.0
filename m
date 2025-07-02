Return-Path: <linux-pci+bounces-31311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B70AF6341
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 22:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DF03BB3C5
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 20:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA412DE71D;
	Wed,  2 Jul 2025 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+HnANWX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE832DE718;
	Wed,  2 Jul 2025 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487802; cv=none; b=b1xCwUyJRBzoPifTaVJaeu+icmhCVoDOuP+yRKWTC1kE2v+PUDoZiNlvBDEMw2xT8z7AphK8E8BSJtdgCLZVeKofbe8ptOnqRPNaILNs/TR2VkfXV4UFBNrWd6eM/v9JftqwwnGwPHg8jPzjvkDVY9zmMQgxGTldasCezaKRpdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487802; c=relaxed/simple;
	bh=37+L+KXB/fqqD8NlLzAobvFG0gsJ0NX6A2DY+kfh0vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpVeApMIfKEV4Z4fs4vzMINa+Y20Co0s5+5KGfUTtEmk7qxow82abAUqVvLEh/cAHj2mcW/aRq7CnUr3FOobRNZ0dKenyeKne3FbX3qfDozQAs63faoIO9tdMgc7R6lgRsdVE6L8nYIM/6B1ZNHmoIeKpWW3dKA6lr/na6v0L9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+HnANWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29168C4CEE7;
	Wed,  2 Jul 2025 20:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751487801;
	bh=37+L+KXB/fqqD8NlLzAobvFG0gsJ0NX6A2DY+kfh0vU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F+HnANWXELHIN8Jf57EERHNANcyNRQbyonqP5ibIqlnuh5SqNeIZ4LIn3AfThT77j
	 lQPdGen3yCHdlZSmczMKqY8tC4bIAj3RFPt5c1qpwZBaNa5WPJ0rBxfX0J2bxHaT87
	 TboWXho81+cPm/2WhximyGPzWShcsHyFX1xuMzGEtuh6NnHV1BPlkj9D259aSVSkc/
	 ugLWGFjglMkfgrfiV5hIRzf+xwzIsIVTlH3vMwFzTmn8Zj7YGxgEhyTw9ML+wbK87V
	 Y0gH0QQ3cuKdMakHBaDuetiYPE9EQ5RuCpPu6FvPRGiSwQTeMjb84f5o76Ge8CUbvV
	 tPl3QzWRjcEcg==
Message-ID: <a7aac65e-848b-4bb3-bd52-963766410698@kernel.org>
Date: Wed, 2 Jul 2025 22:23:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/14] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex
 bindings
To: Hans Zhang <hans.zhang@cixtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-11-hans.zhang@cixtech.com>
 <20250630-graceful-horse-of-science-eecc53@krzk-bin>
 <bb4889ca-ec99-4677-9ddc-28905b6fcc14@cixtech.com>
 <5b182268-d64c-424c-9ada-0c3f120d2817@kernel.org>
 <2b608302-c4a6-404d-9cc5-d1ab9a6712bd@cixtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <2b608302-c4a6-404d-9cc5-d1ab9a6712bd@cixtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/06/2025 17:30, Hans Zhang wrote:
> 
> 
> On 2025/6/30 19:14, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL
>>
>> On 30/06/2025 10:29, Hans Zhang wrote:
>>>>> +
>>>>> +  num-lanes:
>>>>> +    maximum: 8
>>>>> +
>>>>> +  ranges:
>>>>> +    maxItems: 3
>>>>> +
>>>>> +  msi-map:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  vendor-id:
>>>>> +    const: 0x1f6c
>>>>
>>>> Why? This is implied by compatible.
>>>
>>> Because when we designed the SOC RTL, it was not set to the vendor id
>>> and device id of our company. We are members of PCI-SIG. So we need to
>>> set the vendor id and device id in the Root Port driver. Otherwise, the
>>> output of lspci will be displayed incorrectly.
>>
>> Please read carefully. Previous discussions were also pointlessly
>> ping-ponging on irrelevant arguments. Did I suggest you do not have to
>> set it in root port driver? No. If this is const here, this is implied
>> by compatible and completely redundant, because your driver knows this
>> value already. It already has all the information to deduce this value
>> from the compatible.
>>
>>
> Dear Krzysztof,
> 
> Thank you very much for your reply.
> 
> These two attributes are also in the following document. Is this place 
> out of date?
> Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml

I would need to spend time to investigate that and I choose to do other
things instead. I am recently very grumpy on arguments "I found this
somewhere else". I found bugs somewhere else, so am I okay to introduce
them?

> 
> 
> We initially used the logic of Cadence common driver as follows:
> drivers/pci/controller/cadence/pcie-cadence-host.c
> of_property_read_u32(np, "vendor-id", &rc->vendor_id);
> 
> of_property_read_u32(np, "device-id", &rc->device_id);
> 
> So, can the code in Cadence be deleted?

Don't know. If this is ABI, then not.


Best regards,
Krzysztof

