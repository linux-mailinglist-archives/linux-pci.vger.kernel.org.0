Return-Path: <linux-pci+bounces-20638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A847A24F8D
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 20:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0214C3A2D7C
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 19:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E6A15A858;
	Sun,  2 Feb 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPfPSLH/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A04635;
	Sun,  2 Feb 2025 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738522948; cv=none; b=gF1eD5iz4bE88T9zNY1EpUtSu5wK5VIEmaaN/EKNz+dPntm9XrMHBEGBNVjpWO4UT+SZ/VXudlUIlUvIe7xjynCHVX7FL7gPD/YfvwqTqwhQJPoT9zzVQpBXS6366CF4WYmusXMt+VRWndUg3vnVVdUGTWhykbN345v+qgMEFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738522948; c=relaxed/simple;
	bh=YSAFNcRDi+wZFFtd8Cqu1m/C4oqcauI+SeTe6IUvmNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iY+KncLO9qY2TBpZgo+T2q5qvCSXuCQd8EYMAQ1c/RKQFxqKWWcsIOb4OyJslpZauwiO/LmyAvyX1+mHGU7XTA3ktuPtRlzAqxSMrTklfiytQC+eXO1RzLTSb4vJmIqTwJ6jCXwtPKL94kzdeoRntC09HtFYOSvflOSC2vbIgXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPfPSLH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774C1C4CED1;
	Sun,  2 Feb 2025 19:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738522947;
	bh=YSAFNcRDi+wZFFtd8Cqu1m/C4oqcauI+SeTe6IUvmNA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RPfPSLH/sABgHXOT3CEHcEFlVlHOBGitB4MmOxF0hR8yOhlc+zKA9MfmXmLwiw5jO
	 E+OVo1uSvEWhHiRIXqRui6IabtL4ajSb9Kfg2eiHI/ZBon00PalqWBdw7CMhxsV36S
	 +B32Gl3bEKk2HthPyNgdhsLz8jtsPjkY7K0JJ3fvo8J5/XNdGpu1tmx+mIKJq9ZBRj
	 HAR9l1tg4kbv9W3iVWROUXbY/wpWPnSZJTWvueYSBNBTpGUgdOW3A/P2x/xLRF/okd
	 dkArWkwVBVqjPt1lwX20DtD6wpWa4UTjjkUHmfy+mDIWfCX74NK2YcMSyX4+w4rHZe
	 G/RQaEYc+ZmIQ==
Message-ID: <2323e446-14fd-462e-9fd2-d707f7d3802d@kernel.org>
Date: Sun, 2 Feb 2025 20:02:19 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] arm64: dts: agilex: add dtsi for PCIe Root Port
To: matthew.gerlach@linux.intel.com
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, matthew.gerlach@altera.com,
 peter.colberg@altera.com
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com>
 <20250127173550.1222427-4-matthew.gerlach@linux.intel.com>
 <ea614dc5-ad24-4795-b9ba-fa682eda428f@kernel.org>
 <22cb714e-db76-b07-8572-2f70f6848369@linux.intel.com>
 <40a3dced-defe-412d-b5b2-efcc9619d172@kernel.org>
 <7c802294-97f6-3e9-4028-686484a525c5@linux.intel.com>
 <dd51fdae-0e00-44a9-a5a0-e536ba60fd8c@kernel.org>
 <56486d91-5ca-d85-eca1-1ce2df25238@linux.intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <56486d91-5ca-d85-eca1-1ce2df25238@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2025 19:49, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Sun, 2 Feb 2025, Krzysztof Kozlowski wrote:
> 
>> On 01/02/2025 20:12, matthew.gerlach@linux.intel.com wrote:
>>>>
>>>>> they are also referenced in the following:
>>>>>      Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
>>>>>      arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
>>>>> I am not exactly sure where the right place is to define them, maybe
>>>>> Documentation/devicetree/bindings/arm/intel,socfpga.yaml. On the other
>>>>> hand, no code references these names; so it might make sense to just
>>>>> remove them.
>>>>
>>>> In general: nowhere, because simple bus does not have such properties.
>>>> It's not about reg-names only - you cannot have reg. You just did not
>>>> define here simple-bus.
>>>
>>> I understand. I will remove reg and reg-names.
>>
>> If you have there IO address space, then removal does not sound right,
>> either. You just need to come with the bindings for this dedicated
>> device, whatever this is. There is no description here, not much in
>> commit msg, so I don't know what is the device you are adding. PCI has
>> several bindings, so is this just host bridge?
> 
> The device associated with two address ranges may be best described as a 
> simple-bus. It is a bus between the CPU and the directly connected FPGA in 
> the same package as the SOC. The design programmed into the FPGA 
> determines the device(s) connected to the bus. The hardware implementing 

So it is part of FPGA?

> this bus does have reset lines which allow for safely reprogramming the 

Then it is not simple-bus. Simple-bus is our construct for simple
devices. You cannot have something a bit more complex and call it
simple-bus.

> FPGA while the SOC is running, which implies appropriate bindings as you 
> suggest. Something like the following might make sense:
> 
>  	aglx_hps_bridges: fpga-bus@80000000 {
>  		compatible = "altr,agilex-hps-fpga-bridge", "simple-bus";

FPGA bridge maybe, but not simple-bus. It does not look like a simple
bus if you have here some resources.

>  		reg = <0x80000000 0x20200000>,
>  		      <0xf9000000 0x00100000>;
>  		reg-names = "axi_h2f", "axi_h2f_lw";
>  		#address-cells = <0x2>;
>  		#size-cells = <0x1>;
>  		ranges = <0x00000000 0x00000000 0x80000000 0x00040000>,
>  			 <0x00000000 0x10000000 0x90100000 0x0ff00000>,
>  			 <0x00000000 0x20000000 0xa0000000 0x00200000>,
>  			 <0x00000001 0x00010000 0xf9010000 0x00008000>,
>  			 <0x00000001 0x00018000 0xf9018000 0x00000080>,
>  			 <0x00000001 0x00018080 0xf9018080 0x00000010>;
>  		reset = <&rst SOC2FPGA_RESET>, <&rst LWHPS2FPGA_RESET>;
Best regards,
Krzysztof

