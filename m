Return-Path: <linux-pci+bounces-12941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5BA971039
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 09:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EC41F22C45
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 07:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28FE1B0128;
	Mon,  9 Sep 2024 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6G35EI4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B83176237;
	Mon,  9 Sep 2024 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868170; cv=none; b=aym+sJeBrQTfcfuq3R65YAeJKgdQZsTxKUk4o0nx0CIHQBuoiapVPpQP5SaQJ8HA3Hb12TPF4ntT78NHLv1X25pjcgSaf9X5mkIPI63/Y11seJYmddz5CFgckW5BK/dmwtfIcmBOaZ1Mn7p8z5P9CykAsCcQKtvs5/WbfomILZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868170; c=relaxed/simple;
	bh=FTuoSXELtLCOh5BnCjC8lJ3uQ2EFiM4zfdhfD7OGYyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1B61nTy15gabvjXa5hD6yMH2xy6ImZ1mwRtOlG3kPy/SXTQiUG+ncrs9pZSlq2IIKp/esibxkh3QFaBfGhyGP61mwz4i7WEF3EU4pHGEyb65U616ooFW9wgVSF9IL5lCiCTccLByu3Gq/wIpl5MTd/sZNRL3/klOf9JHR6wul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6G35EI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A87C4CEC5;
	Mon,  9 Sep 2024 07:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725868170;
	bh=FTuoSXELtLCOh5BnCjC8lJ3uQ2EFiM4zfdhfD7OGYyk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P6G35EI4u9pRe1w/qM1qhBsFQ5L+4nUO5mxTSi7q8deEABj0BreLIGiRUxCek6yOB
	 16DLDRpng9/uy7Rc+PlJv+WRJz/bbtzEFMn0FXxubt6I9W++6UM0DBQTttM9c0vXtC
	 O7V0tmKDmqYvEfS4mt068NW/MxmHVQcifhs/ClyW3+J5KSCDPTZ41WYPyj9EgNrU45
	 fbtPv1AR/pjFcECOVOkhaz7ufTSehpmE/+IArHLP6TgEKWOWcjfLWWoFuFy8A0GdAF
	 nE88UgpmQq+qwUzRxfja5RjO+Ej/+Zvx4BfebMol8dc11A6SstD7M6TwI9+F3NVU7e
	 eCTgVaudPHhvA==
Message-ID: <91f9c0fc-c9bc-43ac-917c-b1aa86f53f97@kernel.org>
Date: Mon, 9 Sep 2024 09:49:22 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <cover.1725816753.git.jan.kiszka@siemens.com>
 <33d08f61fe9bd692da0eceab91209832bf16e804.1725816753.git.jan.kiszka@siemens.com>
 <n5l36lo6at3yfbexqc5wcxgxop5wwfzldhhm43rwr6qy2epf7a@jq7l6wiyvydc>
 <0f2c79b5-2aa8-4d4c-b568-e74876fd6ecd@siemens.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <0f2c79b5-2aa8-4d4c-b568-e74876fd6ecd@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/09/2024 08:48, Jan Kiszka wrote:
> On 09.09.24 08:22, Krzysztof Kozlowski wrote:
>> On Sun, Sep 08, 2024 at 07:32:28PM +0200, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices
>>> to specific regions of host memory. Add the optional property
>>> "memory-regions" to point to such regions of memory when PVU is used.
>>>
>>> Since the PVU deals with system physical addresses, utilizing the PVU
>>> with PCIe devices also requires setting up the VMAP registers to map the
>>> Requester ID of the PCIe device to the CBA Virtual ID, which in turn is
>>> mapped to the system physical address. Hence, describe the VMAP
>>> registers which are optional unless the PVU shall be used for PCIe.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
>>> CC: "Krzysztof Wilczyński" <kw@linux.com>
>>> CC: Bjorn Helgaas <bhelgaas@google.com>
>>> CC: linux-pci@vger.kernel.org
>>> ---
>>>  .../bindings/pci/ti,am65-pci-host.yaml        | 29 +++++++++++++++++--
>>>  1 file changed, 26 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>> index 0a9d10532cc8..0c297d12173c 100644
>>> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>> @@ -20,14 +20,18 @@ properties:
>>>        - ti,keystone-pcie
>>>  
>>>    reg:
>>> -    maxItems: 4
>>> +    minItems: 4
>>> +    maxItems: 6
>>>  
>>>    reg-names:
>>> +    minItems: 4
>>>      items:
>>>        - const: app
>>>        - const: dbics
>>>        - const: config
>>>        - const: atu
>>> +      - const: vmap_lp
>>> +      - const: vmap_hp
>>>  
>>>    interrupts:
>>>      maxItems: 1
>>> @@ -83,13 +87,30 @@ if:
>>>      compatible:
>>>        enum:
>>>          - ti,am654-pcie-rc
>>> +
>>>  then:
>>> +  properties:
>>> +    memory-region:
>>
>> I think I said it two times already. You must define properties in
>> top-level. That's how we expect, that's how dtschema works (even if it
>> works fine otherwise, it's not always that case), that's how almost all
>> bindings are written.
> 
> Look, if you have such rules, also enhance the checker, or people like
> me will continue to work intuitively. Add reasoning along that as well,

That would be ideal, but I also asked to do this twice. It does not
matter if dtschema  or me tells you this, if you do not implement it.

> would help further to reduce your review effort. The current situation
> with rather fuzzy results from the checker and strange mechanisms inside
> (see my maxItems finding) is not very helpful IMHO.
> 
> I this concrete case, I would add this item top-level, just to set
> maxItems to 0 for ti,keystone-pcie? Not a pattern I'm finding anywhere.
> Or do we have to allow memory-regions for all compatibles now?

Is it really not suitable for all the compatibles? Maybe these are quite
different devices in such case?

But if it is not really suitable, then you can disallow it for other
variants with :false. This is also explicitly documented in example-schema:
https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/example-schema.yaml#L212

> 
> Sorry for all these iterations, but you should see from my questions and
> actions where the problems in the concepts are.

Best regards,
Krzysztof


