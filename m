Return-Path: <linux-pci+bounces-31068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA85AED73C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 10:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274AC188BB36
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 08:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0DB238C0A;
	Mon, 30 Jun 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6DWQF+T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED31E2858;
	Mon, 30 Jun 2025 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751271955; cv=none; b=j4qSwkOcRt9pvCXSKA3aRgMIxhAheghegth9OJqyP7nf1P22/WKqxEYZVHaS8K/40B2KfQYA9T9hw5RPNU2f30AuQmJjVMjGqr0AX0IafI+Wpi1Wyx2uSCKWdVt+mVNOrBvki2yH6Q1HxM7qxauEYHuj1X/v2V+SkFUQUuz8/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751271955; c=relaxed/simple;
	bh=z0myKlXPfbFRymUmSLOvc/7wdeydzOpDX+kckyTt+DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtrfumqPj62HV9tA6fv/Iss7BCuHyLYA3EBVKu30i9rqf+xbQfixa6jMxwCpV6sCWW8Uf6USHXUyAwx45JEDEowjxVbRLgzZg8LyROLraxuZxb9ff6vRRfKTuFVrQ/IPrrQjqDr8IflpgPXXy6XudQbnhWr7D/akLDaNsNSmTd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6DWQF+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA29C4CEE3;
	Mon, 30 Jun 2025 08:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751271954;
	bh=z0myKlXPfbFRymUmSLOvc/7wdeydzOpDX+kckyTt+DU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H6DWQF+TK/2PdqRJ0ssZolMe6dG9ZvpfffQngfJfx8Gf1b62TytLTPAzXSyYRVAFV
	 4jGSfJ158J/K35wRR3J2J//j0zU8G7H0zxVPMA2iZ6qk/++nm6hHhEh7LsaWLg3To4
	 Di9y5uLOdsQ3JEfP2M9bFSc4yBUjmKvWhvX1oKg+S/iQtU1lS/Y9eEEi2Y/3Lky9/w
	 KfiFIPry17J35amVx4bj/G2ym5EGLN5eRH+5/2Sq2DtW7pqkjpPRm7Vnu0UeHUXTwj
	 CyX0Yr8tCzvjRPEDaL8NJaCm5io3d1PIGNE14Gl2C+tspLHvglRlS6PW9Ho1mOGooz
	 5ZHp6OzQnzaJg==
Message-ID: <98b00dd1-3b83-4beb-ad06-f3e0442df8c7@kernel.org>
Date: Mon, 30 Jun 2025 10:25:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: dwc: Add one more reference
 clock
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250626073804.3113757-1-hongxing.zhu@nxp.com>
 <20250626073804.3113757-2-hongxing.zhu@nxp.com>
 <20250627-sensible-pigeon-of-reading-b021a3@krzk-bin>
 <aF76jeV+8us82APv@lizhi-Precision-Tower-5810>
 <20250628-vigorous-benevolent-crayfish-bcbae5@krzk-bin>
 <aGALNS0yyBR27tz4@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <aGALNS0yyBR27tz4@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2025 17:33, Frank Li wrote:
> On Sat, Jun 28, 2025 at 02:34:12PM +0200, Krzysztof Kozlowski wrote:
>> On Fri, Jun 27, 2025 at 04:09:49PM -0400, Frank Li wrote:
>>> On Fri, Jun 27, 2025 at 08:54:46AM +0200, Krzysztof Kozlowski wrote:
>>>> On Thu, Jun 26, 2025 at 03:38:02PM +0800, Richard Zhu wrote:
>>>>> Add one more reference clock "extref" to be onhalf the reference clock
>>>>> that comes from external crystal oscillator.
>>>>>
>>>>> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>>>>> ---
>>>>>  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
>>>>>  1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
>>>>> index 34594972d8db..ee09e0d3bbab 100644
>>>>> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
>>>>> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
>>>>> @@ -105,6 +105,12 @@ properties:
>>>>>              define it with this name (for instance pipe, core and aux can
>>>>>              be connected to a single source of the periodic signal).
>>>>>            const: ref
>>>>> +        - description:
>>>>> +            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
>>>>> +            inputs, one from internal PLL, the other from off chip crystal
>>>>> +            oscillator. Use extref clock name to be onhalf of the reference
>>>>> +            clock comes form external crystal oscillator.
>>>>
>>>> How internal PLL can be represented as 'ref' clock? Internal means it is
>>>> not outside, so impossible to represent.
>>>
>>> Internal means in side SoC, but outside PCIe controller.
>>
>> So external... It does not matter for PCIe controller whether clock is
>> coming from SoC or from some crystal.  It is still input pin. Same input
>> pin.
> 
> It is NOT the same pin. It is TWO pins, there are mux inside in PCI
> controller.
> 
> There are similar cases in s32 rtc, there are 4 input source[0,1,2,3]
> https://lore.kernel.org/imx/20241127144322.GA3454134-robh@kernel.org/
> Only one provide.
> 
>>
>>>
>>>>
>>>> Where is the DTS so we can look at big picture?
>>>
>>> imx94 pci's upstream is still on going, which quite similar with imx95.
>>> Just board design choose external crystal.
>>>
>>> pcie_ref_clk: clock-pcie-ref {
>>>                 compatible = "gpio-gate-clock";
>>>                 clocks = <&xtal25m>;
>>>                 #clock-cells = <0>;
>>>                 enable-gpios = <&pca9670_i2c3 7 GPIO_ACTIVE_LOW>;
>>> };
>>>
>>> &pcie0 {
>>>         pinctrl-0 = <&pinctrl_pcie0>;
>>>         pinctrl-names = "default";
>>>         clocks = <&scmi_clk IMX94_CLK_HSIO>,
>>>                  <&scmi_clk IMX94_CLK_HSIOPLL>,
>>>                  <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
>>>                  <&scmi_clk IMX94_CLK_HSIOPCIEAUX>,
>>>                  <&pcie_ref_clk>;
>>>         clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ext-ref";
>>
>> So this is totally faked hardware property.
>>
>> No, it is the same clock signal, not different. You write bindings from
>> this device point of view, not for your board.
> 
> No the same clock signal. There are two sources, "ext-ref" or "ref".
> PCI controller need know which one provide clocks.

OK, this should be clearly expressed not some vague play of the words
what is internal and external...

> 
> There are mux inside PCI controller, DT need provide information which on
> provide.
> 
> Maybe my example dts miss-lead you. Altherate descript is
>   clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref", "ext-ref";
> 
>   But we thinks if ext-ref provide, "ref" is not neccesary need be turn on.
>   So remove it from the list.

If the ref clock is actually wired it should be there. You describe here
hardware, not what is necessary.

Best regards,
Krzysztof

