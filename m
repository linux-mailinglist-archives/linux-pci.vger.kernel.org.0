Return-Path: <linux-pci+bounces-6540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160B08AD5FD
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 22:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383371C20B01
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 20:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D56E1BDE6;
	Mon, 22 Apr 2024 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/a8o4xX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73961B27D;
	Mon, 22 Apr 2024 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818412; cv=none; b=LaRHG6W1+fNuwfPaNBndyelQ1LqxICVedFyaPYphE3a5IF/cU/TymelMTbDB5S/T4u5TRPecHbFUF8F6EDK1zz2qNe2nEOPqHiLb7DoWQijK0XH1DrEW3pVNg3UDCpjhByHP9eTQiGZBR2d2klbST1WdvPAfUdrD/U9C5jHGY40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818412; c=relaxed/simple;
	bh=B7l0/65vO7+DjY80lOHywR958KdsAp0VxS0wq8JSYD8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VXaK/ao9nDALEh1OcXEywBpuBrtnwlLDrd1CubxDqlIy7T/SlMjUJVATYVBT6L5APuWy7hGVW0QLILszHB3u3FsRyF1D30GeWuHd85KOLCcn5b0//uQGRqt2+bF9C/NQzJk4OGxjgwP0lFcZtJNwr+3YSlhUcuLjmp4R/RkeI0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/a8o4xX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713818411; x=1745354411;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=B7l0/65vO7+DjY80lOHywR958KdsAp0VxS0wq8JSYD8=;
  b=Q/a8o4xXZBx6Y/WfbgeO4C9MZioeEKqNzF/umbT9FxRATrF++KFY00VH
   KVUz3c8hsenyp9fI8e+YBhSr+ADat+cef8Qj6lMb9zXWN48hhXYwC72Kl
   QhrL2BuUAYT5KXkHw+EjraF9Ysz1sUYUugbwLfmwm6EDqtJL1kgjbUn12
   4LvshE22gxoIGbfc05jvvUfWy1NFy1pzv4ovgTponj1T9o+drbRl29iv0
   cMDfFwZs/igD3WQ3kik2iNTq094pc9v+rVLGRlsRV6DU+HP9zlJkW6czW
   5+tmFfm9u48F8BynEnmcduaxQF2ZEqY5ax43NLUzO8nl1qtendWlzEa3N
   g==;
X-CSE-ConnectionGUID: aYke8BjJRGePVDAxTygung==
X-CSE-MsgGUID: nZuVrdMYR5iZ9fYo+hHMmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9548813"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9548813"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 13:40:10 -0700
X-CSE-ConnectionGUID: 9bgKImlkQS+/6twUl2Iprg==
X-CSE-MsgGUID: bGG3c9YUR261z1tgCG1Uhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="28804520"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 13:40:09 -0700
Date: Mon, 22 Apr 2024 13:40:00 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Rob Herring <robh@kernel.org>
cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
    krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: PCI: altera: Convert to YAML
In-Reply-To: <20240422145855.GA1242711-robh@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2404221320270.442026@sj-4150-psse-sw-opae-dev2>
References: <20240420145342.118643-1-matthew.gerlach@linux.intel.com> <20240422145855.GA1242711-robh@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Mon, 22 Apr 2024, Rob Herring wrote:

> On Sat, Apr 20, 2024 at 09:53:42AM -0500, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Convert the device tree bindings for the Altera Root Port PCIe controller
>> from text to YAML.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v4:
>>  - reorder reg-names to match original binding
>>  - move reg and reg-names to top level with limits.
>>
>> v3:
>>  - Added years to copyright
>>  - Correct order in file of allOf and unevaluatedProperties
>>  - remove items: in compatible field
>>  - fix reg and reg-names constraints
>>  - replace deprecated pci-bus.yaml with pci-host-bridge.yaml
>>  - fix entries in ranges property
>>  - remove device_type from required
>>
>> v2:
>>  - Move allOf: to bottom of file, just like example-schema is showing
>>  - add constraint for reg and reg-names
>>  - remove unneeded device_type
>>  - drop #address-cells and #size-cells
>>  - change minItems to maxItems for interrupts:
>>  - change msi-parent to just "msi-parent: true"
>>  - cleaned up required:
>>  - make subject consistent with other commits coverting to YAML
>>  - s/overt/onvert/g
>> ---
>>  .../devicetree/bindings/pci/altera-pcie.txt   | 50 -----------
>>  .../bindings/pci/altr,pcie-root-port.yaml     | 88 +++++++++++++++++++
>>  2 files changed, 88 insertions(+), 50 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
>>  create mode 100644 Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
>> deleted file mode 100644
>> index 816b244a221e..000000000000
>> --- a/Documentation/devicetree/bindings/pci/altera-pcie.txt
>> +++ /dev/null
>> @@ -1,50 +0,0 @@
>> -* Altera PCIe controller
>> -
>> -Required properties:
>> -- compatible :	should contain "altr,pcie-root-port-1.0" or "altr,pcie-root-port-2.0"
>> -- reg:		a list of physical base address and length for TXS and CRA.
>> -		For "altr,pcie-root-port-2.0", additional HIP base address and length.
>> -- reg-names:	must include the following entries:
>> -		"Txs": TX slave port region
>> -		"Cra": Control register access region
>> -		"Hip": Hard IP region (if "altr,pcie-root-port-2.0")
>> -- interrupts:	specifies the interrupt source of the parent interrupt
>> -		controller.  The format of the interrupt specifier depends
>> -		on the parent interrupt controller.
>> -- device_type:	must be "pci"
>> -- #address-cells:	set to <3>
>> -- #size-cells:		set to <2>
>> -- #interrupt-cells:	set to <1>
>> -- ranges:	describes the translation of addresses for root ports and
>> -		standard PCI regions.
>> -- interrupt-map-mask and interrupt-map: standard PCI properties to define the
>> -		mapping of the PCIe interface to interrupt numbers.
>> -
>> -Optional properties:
>> -- msi-parent:	Link to the hardware entity that serves as the MSI controller
>> -		for this PCIe controller.
>> -- bus-range:	PCI bus numbers covered
>> -
>> -Example
>> -	pcie_0: pcie@c00000000 {
>> -		compatible = "altr,pcie-root-port-1.0";
>> -		reg = <0xc0000000 0x20000000>,
>> -			<0xff220000 0x00004000>;
>> -		reg-names = "Txs", "Cra";
>> -		interrupt-parent = <&hps_0_arm_gic_0>;
>> -		interrupts = <0 40 4>;
>> -		interrupt-controller;
>
> What happened to this? It is clearly needed since the interrupt-map
> below points back to this node. Note that that didn't work at one point
> in time, but I think we fixed it.

I think the DTs I was using test were created during the point in time 
when this did not work. The interrupt-controller boolean and 
#interrupt-cells property were in a sub node, and the interrupt-map 
pointed to the sub-node. Keeping everything in the base node maintains 
compatiblity. I will fix this for v5.

>
> It doesn't seem you are testing the binding against an actual DT.
> Please do that.

I need to fix the DTs I'm using for test :)

Thanks for the feedback,

Matthew Gerlach

>
> Rob
>
>> -		#interrupt-cells = <1>;
>> -		bus-range = <0x0 0xFF>;
>> -		device_type = "pci";
>> -		msi-parent = <&msi_to_gic_gen_0>;
>> -		#address-cells = <3>;
>> -		#size-cells = <2>;
>> -		interrupt-map-mask = <0 0 0 7>;
>> -		interrupt-map = <0 0 0 1 &pcie_0 1>,
>> -			            <0 0 0 2 &pcie_0 2>,
>> -			            <0 0 0 3 &pcie_0 3>,
>> -			            <0 0 0 4 &pcie_0 4>;
>> -		ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
>> -			  0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
>> -	};
>

