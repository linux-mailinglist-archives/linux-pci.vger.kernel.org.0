Return-Path: <linux-pci+bounces-20569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D09EA2292C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 08:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99D316435D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 07:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A8C18872A;
	Thu, 30 Jan 2025 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzFR7T3x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFCC2FB;
	Thu, 30 Jan 2025 07:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738222320; cv=none; b=hEgmvCl3Ca07EmW/Vp794fWdIar0smmI8fIlNZafKfUvH1VzSO9KvTdAIuMXLE6IxknTUaXYIPC8pMlStsL8cpRleKHECii/7Geu4Df9N8Toe/427zBcVIl3FbS/52rjmt0zTJy8dEqhdAGcmdLS+71tDCjyCEi4kRGdbxBmPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738222320; c=relaxed/simple;
	bh=ZQjfUu1RLma4aRZgLxvQlnu8j8CI09Go6mEs8lxQdNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9AK2P0ivSsCKytZI7HrEaOAp6BCfwLL7TXABQeKK83+slFhnfXvbYSv69MVZ2lF7VaGvim0RrE/drceAVIU6BqvphKtz7fahtbZTPfmaRyqzPiwDjj+OO+lTBTLLkPVIyNiu0UUuxT4kgHKRR91TVqIF7o4YqIdqThKiuPfzjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzFR7T3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2061BC4CED2;
	Thu, 30 Jan 2025 07:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738222319;
	bh=ZQjfUu1RLma4aRZgLxvQlnu8j8CI09Go6mEs8lxQdNw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gzFR7T3xQnx669U4rvYyVFCn6SqAgLVRDvJVDuiBkLVKxDcbn6/Q+49HGMEBsqkEa
	 XOjMMg12PDLZIyLL5jUtJUPY+niXfPq/hhKE6rMj8XEvf/fQxWfBazCon2L+z/a0oN
	 5DmikTGZ8n7HHP8QTmkyMvdRcEIJT1rH0cgQgsEkVjTQz/2RtJe5BfNsbv1FmZ3mhi
	 B8xikN5yrCuLTFgduG5wAHW6qf4OLRD3caye5eNjBFNRSBBbS6RbrarWfQeNG2zJBu
	 MbjqgScjo8xACDiM6FgteTQxH8zQnTN++roXnNexvMn5P2GK8gLMvZocP/+cdb0HXY
	 RBo8MizgrNXKA==
Message-ID: <eb77eec0-7d51-46a0-b5c6-83c68316ef32@kernel.org>
Date: Thu, 30 Jan 2025 08:31:54 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] arm64: dts: agilex: add dts enabling PCIe Root
 Port
To: matthew.gerlach@linux.intel.com
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, matthew.gerlach@altera.com,
 peter.colberg@altera.com
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com>
 <20250127173550.1222427-5-matthew.gerlach@linux.intel.com>
 <58f7925c-dbed-4a5e-8e7d-095bef197931@kernel.org>
 <319e9f53-6910-a144-8752-4bcc47b7cba@linux.intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <319e9f53-6910-a144-8752-4bcc47b7cba@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2025 23:54, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Wed, 29 Jan 2025, Krzysztof Kozlowski wrote:
> 
>> On 27/01/2025 18:35, Matthew Gerlach wrote:
>>> Add a device tree enabling PCIe Root Port support on
>>> an Agilex F-series Development Kit which has the
>>> P-tile variant PCIe IP.
>>
>> Please wrap commit message according to Linux coding style / submission
>> process (neither too early nor over the limit):
>> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
>>
> Thank you for the pointer. I will fix the commit message accordingly.
> 
>>>
>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> ---
>>> v3:
>>>  - Remove accepted patches from patch set.
>>> ---
>>>  arch/arm64/boot/dts/intel/Makefile               |  1 +
>>>  .../socfpga_agilex7f_socdk_pcie_root_port.dts    | 16 ++++++++++++++++
>>>  2 files changed, 17 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
>>> index d39cfb723f5b..737e81c3c3f7 100644
>>> --- a/arch/arm64/boot/dts/intel/Makefile
>>> +++ b/arch/arm64/boot/dts/intel/Makefile
>>> @@ -2,6 +2,7 @@
>>>  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
>>>  				socfpga_agilex_socdk.dtb \
>>>  				socfpga_agilex_socdk_nand.dtb \
>>> +				socfpga_agilex7f_socdk_pcie_root_port.dtb \
>>>  				socfpga_agilex5_socdk.dtb \
>>>  				socfpga_n5x_socdk.dtb
>>>  dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
>>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts b/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
>>> new file mode 100644
>>> index 000000000000..76a989ba6a44
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dts
>>> @@ -0,0 +1,16 @@
>>> +// SPDX-License-Identifier:     GPL-2.0
>>> +/*
>>> + * Copyright (C) 2024, Intel Corporation
>>> + */
>>> +
>>> +#include "socfpga_agilex_socdk.dts"


Nope, you cannot include a board in other board.

>>> +#include "socfpga_agilex_pcie_root_port.dtsi"
>>> +
>>
>> Missing board compatible, missing bindings.
> 
> The model and compatible bindings are inherited from socfpga_agilex_socdk.dts.

Then this is the same board, so entire DTS should be removed and instead
merged into parent DTS. There is no such thing as "inherit" of an
compatible.

> 
>>
>>> +&pcie_0_pcie_aglx {
>>> +	status = "okay";
>>> +	compatible = "altr,pcie-root-port-3.0-p-tile";
>>
>> Why do you define the compatible here, not in DTSI? This is highly
>> unusual and confusing. Also, compatible is never the last property, but
>> opposite.
> 
> The current DTSI supports all three variants of the PCI hardware in the 
> Agilex family, referred to as P-Tile, F-Tile, and R-Tile. This particular 
> board has an Agilex chip with the P-Tile variant of the PCI hardware.

And devices are not compatible? If they have common part in the DTSI, I
would expect that. This is really unusual stuff and needs proper
justifications, not just "DTSI support something". DTSI represents SoC
and SoC either has p-tile or something else. It does not have a "wildcard".

It's the same with that earlier simple-bus. You wrote DTS which does not
represent real hardware.

> 
> I will move the compatible property to be the first property.
> 
>>
>> Plus:
>>
>> Please run scripts/checkpatch.pl and fix reported warnings. After that,
>> run also `scripts/checkpatch.pl --strict` and (probably) fix more
>> warnings. Some warnings can be ignored, especially from --strict run,
>> but the code here looks like it needs a fix. Feel free to get in touch
>> if the warning is not clear.
> 
> The only warning I see from scripts/checkpatch.pl --strict is "added, 
> moved or deleted file(s), does MAINTAINERS need updating?". The directory, 
> arch/arm64/boot/dts/intel/, is already mentioned in the MAINTAINERS file. 
> Do I need to do anything to resolve this?

My mistake, I missed the first patch and assumed checkpatch will
complain about this compatible.

> 
>>
>> It does not look like you tested the DTS against bindings. Please run
>> `make dtbs_check W=1` (see
>> Documentation/devicetree/bindings/writing-schema.rst or
>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>> for instructions).
>> Maybe you need to update your dtschema and yamllint. Don't rely on
>> distro packages for dtschema and be sure you are using the latest
>> released dtschema.
> 
> The dtschema check failures are inherited from socfpga_agilex_socdk.dts.

New errors are not inherited from DTS/DTSI. Anyway, you cannot include
other DTS. DTS is final board. You do not include C files in C code in
Linux kernel.

> Rob Herring's bot indicates that "Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not." Is this 
> applicable here? Is the correct way to fix the existing dtschema check 
> warnings is with their own patches, rather than adding to this PCIe Root 
> Port patchset?

Any new warning is on you and for example with that simple-bus, you
brought new ones.

Best regards,
Krzysztof

