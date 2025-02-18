Return-Path: <linux-pci+bounces-21690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D67A393C0
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 08:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B973B05EE
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 07:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F261B4151;
	Tue, 18 Feb 2025 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/CXD+L1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629DC7E1;
	Tue, 18 Feb 2025 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739863546; cv=none; b=n4Ag9R90ckylsMTZ79alMoUzdjCDWgPppL610veNi9B5PbBocwmIoSr0KR7tAmUv6YchYqAQ1hlwqm0PPvppIcVIw0M9StxxF4orVCVwPMyL4Hoh4xfq8LAYv7WgOSwkjrsFGe/uOjPsQEy3npU+CyvH0idsVRvWSVuYiF/6aVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739863546; c=relaxed/simple;
	bh=yOL7FIUj2oVcnJPlnqIOoSXXXQizQbYGMygBf7Dy4PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Er/YaK/ZFgFr6MF2NYqLfKjJ9M0LaOCAMVSi5hIu7MOBgUqvnS+H34LjWE5wqzjSjdoUGHmJHeNVnsW60o2ZP4QDi5oHM96AuQpendr7jULZLMAcCIAyezNWNEPuWkHv9RgIuG7VxdJxZLzjqKyDZpJ+6fRPOLXNvZe3FdXVO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/CXD+L1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BE2C4CEE2;
	Tue, 18 Feb 2025 07:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739863545;
	bh=yOL7FIUj2oVcnJPlnqIOoSXXXQizQbYGMygBf7Dy4PE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N/CXD+L1P8EVGCWR2+ASZdvPub5e+H4gjqbXqX93QOAq9hQiJomNYvyaBKcoQu1T2
	 GZY9Rz6Pq2d+RAXVw4wahTdcXeT1A0W2R57iVJnlanIySriDPmVe7/QkDQ3/vrBlCc
	 Wt37fFLcM45mc54vl0K2tdog/j8ee6x3AJS04mfIMS1QzjMklfEEGJOTQGckMHCVep
	 N0WTA6N5S9NMNqBRGkIyueXeytZVNeHKZ7ibCfkSE5lOAgg+CEx0GWMy56DgUTXoFu
	 gTC6trxV4EMdg3U0XMSP9itbvpR6UYclvdUWxcG/RHzMq7bpCfIJc+iR3xTsJw6lQK
	 Vm1Oy4yQdK0Tw==
Message-ID: <3894efe9-fb8a-4a6f-bc50-ed54b6f7614d@kernel.org>
Date: Tue, 18 Feb 2025 08:25:39 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] dt-bindings: intel: document Agilex PCIe Root Port
To: matthew.gerlach@linux.intel.com
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, matthew.gerlach@altera.com,
 peter.colberg@altera.com
References: <20250215155359.321513-1-matthew.gerlach@linux.intel.com>
 <20250215155359.321513-3-matthew.gerlach@linux.intel.com>
 <20250216-ubiquitous-agile-spoonbill-cf12ab@krzk-bin>
 <dcd28035-6ba8-5d67-daa3-26812c4fc99d@linux.intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <dcd28035-6ba8-5d67-daa3-26812c4fc99d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2025 16:47, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Sun, 16 Feb 2025, Krzysztof Kozlowski wrote:
> 
>> On Sat, Feb 15, 2025 at 09:53:54AM -0600, Matthew Gerlach wrote:
>>> The Agilex7f devkit can support PCIe End Points with the appropriate
>>> daughter card.
>>>
>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> ---
>>> v7:
>>>  - New patch to series.
>>> ---
>>>  Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>>> index 2ee0c740eb56..0da5810c9510 100644
>>> --- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>>> @@ -20,6 +20,7 @@ properties:
>>>                - intel,n5x-socdk
>>>                - intel,socfpga-agilex-n6000
>>>                - intel,socfpga-agilex-socdk
>>> +              - intel,socfpga-agilex7f-socdk-pcie-root-port
>>
>> Compatible should represent the board, so what is here exactly the
>> board? 7f? Agilex7f? socdk? Or is it standard agilex-socdk but with some
>> things attached?
> 
> The board is the Agilex 7 FPGA F-Series Transceiver-Soc Development Kit:
> https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/si-agf014.html

Isn't Agilex7 a SoC? I don't see it in the list of compatibles.

> 
> There is not a single, standard agilex-socdk board. There are currently 
> three variants. In addition to the F-Series socdk, there are I-Series and 
> M-Series devkits:
> https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/si-agi027.html
> https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/agm039.html

Pages above show distinctive names for the boards, so I am confused why
they are not used.



Best regards,
Krzysztof

