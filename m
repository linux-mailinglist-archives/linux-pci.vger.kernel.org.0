Return-Path: <linux-pci+bounces-20707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2D9A2781A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 18:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FB91624EE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 17:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4091B2144AD;
	Tue,  4 Feb 2025 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KsgkX9ml"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CFD1547D8;
	Tue,  4 Feb 2025 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689338; cv=none; b=b5dsS0qrlVFQrdW0yF5b+HA4a+wlq6SH/GfLWFoqRyXTDf4xDMYAbtxrouPrzt3Muc1j7+s2QN1Rdlj3hC4O4dMedSuV4mND4g7Lq/IuhAyGjmC/5FqhG/2YiCBTM4QF39kM+PksgWH2TtMQ4mb+ftxrCf0GBF1dyRpwPxL0XLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689338; c=relaxed/simple;
	bh=D4dDCeCtCvK0b+cHySHXx6/Bt2dV9Y0VXU7kJjskQHM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ulpSmvwSXL0rAebZQ3yciDxtbqpnw/DrYSZCWSsDB4qR9Po88KnMbFzdoDgt4s03VMWlmbCjyhMpDpohMA4+bQcYTURdwd0rpzW1zGYauxYxsPkZyOoo6BYJa7meE+vQzSHUQs07C1MNceS/ER1F3CO6+AGnyLb1KxY35RplQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KsgkX9ml; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738689336; x=1770225336;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=D4dDCeCtCvK0b+cHySHXx6/Bt2dV9Y0VXU7kJjskQHM=;
  b=KsgkX9mlk0/lO6bHA+AcATpRS3pnsti2kE6LvY70vfAlME5GXu0wZ6y4
   CGTb+BOmQ5LJqj6lDFEvfF8IIfls16Y9W8Ys+caLLl2FFA70oIrD3wQSh
   Vo4AhezdGhzR0ItJCD86+L/ANRvHPz44lCIaxML8YVFK0DvpyJges+3tS
   XLRhdF1FI/I4Tgg6KGiGqPYXbU4LyQD2XGp8chJwKoSWL77mRWWaNdb4h
   6Uh9kuD59rsgjYds4Vrf8PCinPjEwStaxyog5CcA4a+ZK7XNf+XPUPQkt
   pJZ9Ov5w3Oz5XD+EZ2vgHIv4N+5FVaTYuid4BJ9eYkj8OzvF+7CKZ3UDO
   g==;
X-CSE-ConnectionGUID: erkThfHLTnCZA2d2SgLzSQ==
X-CSE-MsgGUID: VC2DI/wQSDqLRTQYOwLbEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42067063"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="42067063"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:15:35 -0800
X-CSE-ConnectionGUID: VSrj3jrtQ+SRS7EtX16cDg==
X-CSE-MsgGUID: xKCo2uCySw6hDVyux856ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="111235463"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:15:34 -0800
Date: Tue, 4 Feb 2025 09:15:34 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    peter.colberg@altera.com
Subject: Re: [PATCH v5 3/5] arm64: dts: agilex: add dtsi for PCIe Root Port
In-Reply-To: <2323e446-14fd-462e-9fd2-d707f7d3802d@kernel.org>
Message-ID: <1f8885db-1346-ed9e-dc3a-3938def7f472@linux.intel.com>
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com> <20250127173550.1222427-4-matthew.gerlach@linux.intel.com> <ea614dc5-ad24-4795-b9ba-fa682eda428f@kernel.org> <22cb714e-db76-b07-8572-2f70f6848369@linux.intel.com>
 <40a3dced-defe-412d-b5b2-efcc9619d172@kernel.org> <7c802294-97f6-3e9-4028-686484a525c5@linux.intel.com> <dd51fdae-0e00-44a9-a5a0-e536ba60fd8c@kernel.org> <56486d91-5ca-d85-eca1-1ce2df25238@linux.intel.com> <2323e446-14fd-462e-9fd2-d707f7d3802d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Sun, 2 Feb 2025, Krzysztof Kozlowski wrote:

> On 02/02/2025 19:49, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Sun, 2 Feb 2025, Krzysztof Kozlowski wrote:
>>
>>> On 01/02/2025 20:12, matthew.gerlach@linux.intel.com wrote:
>>>>>
>>>>>> they are also referenced in the following:
>>>>>>      Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
>>>>>>      arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
>>>>>> I am not exactly sure where the right place is to define them, maybe
>>>>>> Documentation/devicetree/bindings/arm/intel,socfpga.yaml. On the other
>>>>>> hand, no code references these names; so it might make sense to just
>>>>>> remove them.
>>>>>
>>>>> In general: nowhere, because simple bus does not have such properties.
>>>>> It's not about reg-names only - you cannot have reg. You just did not
>>>>> define here simple-bus.
>>>>
>>>> I understand. I will remove reg and reg-names.
>>>
>>> If you have there IO address space, then removal does not sound right,
>>> either. You just need to come with the bindings for this dedicated
>>> device, whatever this is. There is no description here, not much in
>>> commit msg, so I don't know what is the device you are adding. PCI has
>>> several bindings, so is this just host bridge?
>>
>> The device associated with two address ranges may be best described as a
>> simple-bus. It is a bus between the CPU and the directly connected FPGA in
>> the same package as the SOC. The design programmed into the FPGA
>> determines the device(s) connected to the bus. The hardware implementing
>
> So it is part of FPGA?

Technically, the PCIe Tiles are hard IP, but they are connected to the 
processor through the FPGA.

>
>> this bus does have reset lines which allow for safely reprogramming the
>
> Then it is not simple-bus. Simple-bus is our construct for simple
> devices. You cannot have something a bit more complex and call it
> simple-bus.
>
>> FPGA while the SOC is running, which implies appropriate bindings as you
>> suggest. Something like the following might make sense:
>>
>>  	aglx_hps_bridges: fpga-bus@80000000 {
>>  		compatible = "altr,agilex-hps-fpga-bridge", "simple-bus";
>
> FPGA bridge maybe, but not simple-bus. It does not look like a simple
> bus if you have here some resources.

FPGA bridge is a more accurate description of the actual hardware than 
simple-bus. This bridge does have two address ranges to access the FPGA. 
One address range is considered "light-weight" intended for register 
accesses in the FPGA, while the other a full featured AXI interface 
suitable DMA.

>
>>  		reg = <0x80000000 0x20200000>,
>>  		      <0xf9000000 0x00100000>;
>>  		reg-names = "axi_h2f", "axi_h2f_lw";
>>  		#address-cells = <0x2>;
>>  		#size-cells = <0x1>;
>>  		ranges = <0x00000000 0x00000000 0x80000000 0x00040000>,
>>  			 <0x00000000 0x10000000 0x90100000 0x0ff00000>,
>>  			 <0x00000000 0x20000000 0xa0000000 0x00200000>,
>>  			 <0x00000001 0x00010000 0xf9010000 0x00008000>,
>>  			 <0x00000001 0x00018000 0xf9018000 0x00000080>,
>>  			 <0x00000001 0x00018080 0xf9018080 0x00000010>;
>>  		reset = <&rst SOC2FPGA_RESET>, <&rst LWHPS2FPGA_RESET>;
> Best regards,
> Krzysztof
>
Thanks for the feedback,
Matthew Gerlach

