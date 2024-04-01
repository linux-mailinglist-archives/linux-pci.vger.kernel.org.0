Return-Path: <linux-pci+bounces-5506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3D28947CA
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 01:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7EBE1C21FFC
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 23:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19B556B7F;
	Mon,  1 Apr 2024 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI1ECswy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63DF2E822;
	Mon,  1 Apr 2024 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014611; cv=none; b=lsotWodds4syCToTH2PyjXShz9PVJomN9QEvMnu/r8gNjXdN0wJjESIarWnvAMVutwZeMh6bf6hiDuSwGbT5u2R5yuTAJJ/z8TGMra0NALz0cXh+R/kKlILsLWNTfj7hmLmX4AL09uzf32E89R2EhHxCny6KjzL1XzOoxy16M1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014611; c=relaxed/simple;
	bh=8wQEbHsfIcXr4dr2XxcWj3nO0LM8qgHsZ3uOarKVfQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHRVzzYvRJPb34ps628wpBoIjV6SSxMcNzHUASmrV2QgPzMIcMnR+NQ92oNHAoDDSsOmagVwNDtHJ88Yy+0GGM2mXYzOJsKCellWV3kybrqsqur+dQN3/ige21SjhCGAwd5Z0EilZ66JZUB2EgrYIwY6sfpW7tuGSiFPCXDmGNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI1ECswy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1324CC433F1;
	Mon,  1 Apr 2024 23:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712014611;
	bh=8wQEbHsfIcXr4dr2XxcWj3nO0LM8qgHsZ3uOarKVfQ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OI1ECswy95ztWR1qMgjtRvTP+YtC/H3AmmZiGQn2J+eI8zEOG1rPCP7A37qpNwBLE
	 et5TTtnKjWCoiVC75z+lA94ahzdQ2s4Xrhezz8feT00f6X61oHBT9acQ4pXOBqCoBZ
	 rnh49TrrW2yhX9kjwStf9gQGEz7FpSBbZCz1pUUojkwL/xVwPCJGcdW3S9q4P2jIpG
	 rjs2GACJ/gKERLUohzcvvGo8N7otb7TN2YtxiVdtRjqawmjaIMePq76Nt1DeQdCzZ9
	 9YqEk1ICTdeu3AHyzLkn337YjnDgQiapEy41C3z7dkdhXhkULVeo+Vjd20RDzw0k5l
	 bIOJT/gVmGVng==
Message-ID: <49ecab2e-8f36-47be-a1b0-1bb0089dab0f@kernel.org>
Date: Tue, 2 Apr 2024 08:36:47 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/18] dt-bindings: pci: rockchip,rk3399-pcie-ep: Add
 ep-gpios property
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Niklas Cassel <cassel@kernel.org>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
 <20240330041928.1555578-18-dlemoal@kernel.org>
 <b020b74e-8ae1-448a-9d47-6c9bb13735f9@linaro.org>
 <c75cb54a-61c7-4bc3-978e-8a28dde93b08@kernel.org>
 <518f04ea-7ff6-4568-be76-60276d18b209@linaro.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <518f04ea-7ff6-4568-be76-60276d18b209@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/24 18:57, Krzysztof Kozlowski wrote:
> On 01/04/2024 01:06, Damien Le Moal wrote:
>> On 3/30/24 18:16, Krzysztof Kozlowski wrote:
>>> On 30/03/2024 05:19, Damien Le Moal wrote:
>>>> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>>>>
>>>> Describe the `ep-gpios` property which is used to map the PERST# input
>>>> signal for endpoint mode.
>>>>
>>>> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>>> ---
>>>>  .../devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml       | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
>>>> index 6b62f6f58efe..9331d44d6963 100644
>>>> --- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
>>>> @@ -30,6 +30,9 @@ properties:
>>>>      maximum: 32
>>>>      default: 32
>>>>  
>>>> +  ep-gpios:
>>>> +    description: Input GPIO configured for the PERST# signal.
>>>
>>> Missing maxItems. But more important: why existing property perst-gpios,
>>> which you already have there in common schema, is not correct for this case?
>>
>> I am confused... Where do you find perst-gpios defined for the rk3399 ?
>> Under Documentation/devicetree/bindings/pci/, the only schema I see using
>> perst-gpios property are for the qcom (Qualcomm) controllers.
> 
> You are right, it's so far only in Qualcomm.
> 
>> The RC bindings for the rockchip rk3399 PCIe controller
>> (pci/rockchip,rk3399-pcie.yaml) already define the ep-gpios property. So if
> 
> Any reason why this cannot be named like GPIO? Is there already a user
> of this in Linux kernel? Commit msg says nothing about this, so that's
> why I would expect name matching the signal.

The RC-mode PCIe controller node of the rk3399 DTS already defines the ep-gpios
property for RC side PERST# signal handling. So we simply reused the exact same
name to be consistent between RC and EP. I personnally have no preferences. If
there is an effort to rename such signal with some preferred pattern, I will
follow. For the EP node, there was no PERST signal handling in the driver and
no property defined for it, so any name is fine. "perst-gpios" would indeed be
a better name, but again, given that the RC controller node has ep-gpios, we
reused that. What is your recommendation here ?

> 
> Best regards,
> Krzysztof
> 

-- 
Damien Le Moal
Western Digital Research


