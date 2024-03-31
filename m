Return-Path: <linux-pci+bounces-5461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EB989365D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 01:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBE21F21C9F
	for <lists+linux-pci@lfdr.de>; Sun, 31 Mar 2024 23:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E715B148306;
	Sun, 31 Mar 2024 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gw6sdMmc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFEB26AEA;
	Sun, 31 Mar 2024 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711926381; cv=none; b=dWrqfaA3rxXTQCo7QZfOFQltNNatHVcrmT6JT+da9fn3vp7WirgzOu38qLE8bWqPZU9Zn3opghPzFtlTZKh+IypsFr9OIHjbeLt1Yu8QtQragn6J11KwIFMEuTFRskYRcnBqyrEnCfaVaj5XRP8Y/fi8uPDNLX17RhxPki6knsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711926381; c=relaxed/simple;
	bh=14qIqX8MDo3yXNFpqBzy/00s9TGjAWt6G7ERHC7x30A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEkZQOIZvVYdz9iqlRPM3VGgfye3jvHfwBgzsdFOGg/PyJRR/e/bLAgHw4O4aPttCazfRkhwUJ2YE06aqbB5v2+Rl0Ijpvvm68lpuGIzyBKTXi4jA3ImIalEBN449a6QAblw+KJhRFmCUZ5IyPxi9De09bTWwQHMDiptzo9rERw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gw6sdMmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC358C433F1;
	Sun, 31 Mar 2024 23:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711926381;
	bh=14qIqX8MDo3yXNFpqBzy/00s9TGjAWt6G7ERHC7x30A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gw6sdMmccfg6fv2rsBdDfRpSG7EMGTTmkv9GV0mfGfq78EG0Qa3zFW+rJUZzSqm/1
	 9rw6aVYZcX3zsaWf+T8zHt+KIJdjHHYF+3GyTxnvmPCDqh8zutCL1T5XgVQX8sf8Ub
	 XCLjmRv0WFLzmR5UfSYpKO6zco0y/AHJCjO71mC+f9PpTO5gqM/B2OmeCNYooRVxo9
	 2mKSG0zoKqfErDvmrGPb305oT3IpOq+xTMdWPERY6pzWuFMWaE5sXg9Bo7xIRiphe7
	 ddcRd9uXmkpF6sUoIMIgiNFlwRzX4TbqA6IWQNgGTC8Bl/Jgmi+8lfUjtYJAAmr2Et
	 fItqbas/oQN0g==
Message-ID: <c75cb54a-61c7-4bc3-978e-8a28dde93b08@kernel.org>
Date: Mon, 1 Apr 2024 08:06:17 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <b020b74e-8ae1-448a-9d47-6c9bb13735f9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/30/24 18:16, Krzysztof Kozlowski wrote:
> On 30/03/2024 05:19, Damien Le Moal wrote:
>> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>>
>> Describe the `ep-gpios` property which is used to map the PERST# input
>> signal for endpoint mode.
>>
>> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  .../devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml       | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
>> index 6b62f6f58efe..9331d44d6963 100644
>> --- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
>> +++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
>> @@ -30,6 +30,9 @@ properties:
>>      maximum: 32
>>      default: 32
>>  
>> +  ep-gpios:
>> +    description: Input GPIO configured for the PERST# signal.
> 
> Missing maxItems. But more important: why existing property perst-gpios,
> which you already have there in common schema, is not correct for this case?

I am confused... Where do you find perst-gpios defined for the rk3399 ?
Under Documentation/devicetree/bindings/pci/, the only schema I see using
perst-gpios property are for the qcom (Qualcomm) controllers.
The RC bindings for the rockchip rk3399 PCIe controller
(pci/rockchip,rk3399-pcie.yaml) already define the ep-gpios property. So if
anything, this patch should be probably be modified to move this property to the
common schema in pci/rockchip,rk3399-pcie-common.yaml.
No ?

> 
> Best regards,
> Krzysztof
> 

-- 
Damien Le Moal
Western Digital Research


