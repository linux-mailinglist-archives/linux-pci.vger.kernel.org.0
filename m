Return-Path: <linux-pci+bounces-6656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0CD8B1702
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 01:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDDB1C22FEE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 23:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED73416F0C6;
	Wed, 24 Apr 2024 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hY+KEJZY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D41E86F;
	Wed, 24 Apr 2024 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001010; cv=none; b=h+GIX4vU1PGE3ErRmLrUYRg4ZcsaS4O76EvD59eVUbpWRAcxvI9l+08JG+ZaKXnP49rnBDITndhl5mvitpNhAZi9aodOBDzaKgTDqF2gjFAzul0CjzdQlqPa5z3zlgZrafFmt08fyj7kmt9/8nt7hIBREM1n7Xl82DbfCeZdqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001010; c=relaxed/simple;
	bh=Tfe7E/OL0o5X1m4giF50CoXrdaoQSl5P6RAaBXpnEY0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eAzAELFFfOhwNcWZdRlXgdQl8zWJYpgZGd+2oLz0GFXt47UhyRFjRJ1arxWtwPnCstYGtko1//untigZnEufxwk0zjBZ+gr/icYNS7YG3QcUBknPXI08srUom9JtssE2Vs+turR00IHpd9a8Ekz8j7EGE7FfwoY1Qsrtm7jDljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hY+KEJZY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714001009; x=1745537009;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Tfe7E/OL0o5X1m4giF50CoXrdaoQSl5P6RAaBXpnEY0=;
  b=hY+KEJZY/p8x7Z8SqbjOVkvtDsgyp+z4kwfMGnnEfiVHshF2VBCDHHLG
   3v9V6u1CuuNCkW6F9/qB3FklyAnMrm0bjGlqm2ppr5iLhsbg0415cUDJP
   GMzSBVB9WzxVLVrsTnxh7JDf+5tWOiq7pASVEDYWY12hXVPDixEuhcyQ5
   UvQufeUqYNyP5yGv3yLvM6ORsU65v4zg/gA9BO0iAQ//nnkwPj03+hK6F
   nhDNxXtEJ7h6adDjyZzjOFqhN1DhCzeyhRdq+0sHtQQ1mvrY7wyvl8DIK
   Lq1aeCtBzElyEFedcDKKkRmoPC46HDdgJjvvK9Zd2r4lbHJdc2KUNu+4R
   g==;
X-CSE-ConnectionGUID: uAonbqTzR4K3nHknAvFykA==
X-CSE-MsgGUID: lEeQuQJWR5+iHZuW4QiEew==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="13495009"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="13495009"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 16:23:29 -0700
X-CSE-ConnectionGUID: I2PD/RaiTSaqi1BadRUg0w==
X-CSE-MsgGUID: wJ6x11gNS62krN0KKFzgaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="55813148"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 16:23:28 -0700
Date: Wed, 24 Apr 2024 16:23:19 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Rob Herring <robh@kernel.org>
cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
    krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: PCI: altera: Convert to YAML
In-Reply-To: <alpine.DEB.2.22.394.2404221320270.442026@sj-4150-psse-sw-opae-dev2>
Message-ID: <alpine.DEB.2.22.394.2404241542390.476918@sj-4150-psse-sw-opae-dev2>
References: <20240420145342.118643-1-matthew.gerlach@linux.intel.com> <20240422145855.GA1242711-robh@kernel.org> <alpine.DEB.2.22.394.2404221320270.442026@sj-4150-psse-sw-opae-dev2>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Mon, 22 Apr 2024, matthew.gerlach@linux.intel.com wrote:

>
>
> On Mon, 22 Apr 2024, Rob Herring wrote:
>
>> On Sat, Apr 20, 2024 at 09:53:42AM -0500, matthew.gerlach@linux.intel.com 
>> wrote:
>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> 
>>> Convert the device tree bindings for the Altera Root Port PCIe controller
>>> from text to YAML.
>>> 
>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> ---
>>> v4:
>>>  - reorder reg-names to match original binding
>>>  - move reg and reg-names to top level with limits.
>>> 
>>> v3:
>>>  - Added years to copyright
>>>  - Correct order in file of allOf and unevaluatedProperties
>>>  - remove items: in compatible field
>>>  - fix reg and reg-names constraints
>>>  - replace deprecated pci-bus.yaml with pci-host-bridge.yaml
>>>  - fix entries in ranges property
>>>  - remove device_type from required
>>> 
>>> v2:
>>>  - Move allOf: to bottom of file, just like example-schema is showing
>>>  - add constraint for reg and reg-names
>>>  - remove unneeded device_type
>>>  - drop #address-cells and #size-cells
>>>  - change minItems to maxItems for interrupts:
>>>  - change msi-parent to just "msi-parent: true"
>>>  - cleaned up required:
>>>  - make subject consistent with other commits coverting to YAML
>>>  - s/overt/onvert/g
>>> ---
>>>  .../devicetree/bindings/pci/altera-pcie.txt   | 50 -----------
>>>  .../bindings/pci/altr,pcie-root-port.yaml     | 88 +++++++++++++++++++
>>>  2 files changed, 88 insertions(+), 50 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
>>>  create mode 100644 
>>> Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>>> 
>>> diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt 
>>> b/Documentation/devicetree/bindings/pci/altera-pcie.txt
>>> deleted file mode 100644
>>> index 816b244a221e..000000000000
>>> --- a/Documentation/devicetree/bindings/pci/altera-pcie.txt
>>> +++ /dev/null
>>> @@ -1,50 +0,0 @@
>>> -* Altera PCIe controller
>>> -
>>> -Required properties:
>>> -- compatible :	should contain "altr,pcie-root-port-1.0" or 
>>> "altr,pcie-root-port-2.0"
>>> -- reg:		a list of physical base address and length for TXS 
>>> and CRA.
>>> -		For "altr,pcie-root-port-2.0", additional HIP base address 
>>> and length.
>>> -- reg-names:	must include the following entries:
>>> -		"Txs": TX slave port region
>>> -		"Cra": Control register access region
>>> -		"Hip": Hard IP region (if "altr,pcie-root-port-2.0")
>>> -- interrupts:	specifies the interrupt source of the parent 
>>> interrupt
>>> -		controller.  The format of the interrupt specifier depends
>>> -		on the parent interrupt controller.
>>> -- device_type:	must be "pci"
>>> -- #address-cells:	set to <3>
>>> -- #size-cells:		set to <2>
>>> -- #interrupt-cells:	set to <1>
>>> -- ranges:	describes the translation of addresses for root ports and
>>> -		standard PCI regions.
>>> -- interrupt-map-mask and interrupt-map: standard PCI properties to 
>>> define the
>>> -		mapping of the PCIe interface to interrupt numbers.
>>> -
>>> -Optional properties:
>>> -- msi-parent:	Link to the hardware entity that serves as the MSI 
>>> controller
>>> -		for this PCIe controller.
>>> -- bus-range:	PCI bus numbers covered
>>> -
>>> -Example
>>> -	pcie_0: pcie@c00000000 {
>>> -		compatible = "altr,pcie-root-port-1.0";
>>> -		reg = <0xc0000000 0x20000000>,
>>> -			<0xff220000 0x00004000>;
>>> -		reg-names = "Txs", "Cra";
>>> -		interrupt-parent = <&hps_0_arm_gic_0>;
>>> -		interrupts = <0 40 4>;
>>> -		interrupt-controller;
>> 
>> What happened to this? It is clearly needed since the interrupt-map
>> below points back to this node. Note that that didn't work at one point
>> in time, but I think we fixed it.
>
> I think the DTs I was using test were created during the point in time when 
> this did not work. The interrupt-controller boolean and #interrupt-cells 
> property were in a sub node, and the interrupt-map pointed to the sub-node. 
> Keeping everything in the base node maintains compatiblity. I will fix this 
> for v5.

When I added the interrupt-controller boolean back to the base node, 
pcie_0, and fixed the interrupt-map in the yaml example to point to 
pcie_0, I get what appears to be the warning below from the 
dt_binding_check below. The exit code is still 0:

make dt_binding_check DT_SCHEMA_FILES=altr,pcie-root-port.yaml
   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
   CHKDT   Documentation/devicetree/bindings
   LINT    Documentation/devicetree/bindings
   DTEX 
Documentation/devicetree/bindings/pci/altr,pcie-root-port.example.dts
   DTC_CHK 
Documentation/devicetree/bindings/pci/altr,pcie-root-port.example.dtb
/home/mgerlach/git/linux-next/Documentation/devicetree/bindings/pci/altr,pcie-root-port.example.dtb: 
pcie@c00000000: interrupt-map: [[0, 0, 0, 1, 2, 1, 0, 0, 0], [2, 2, 2, 0, 
0, 0, 3, 2, 3], [0, 0, 0, 4, 2, 4]] is too short

The warning from checking a DTS with the binding provides a little more 
information, but the warning puzzles me because of the 9 entry lists:

make CHECK_DTBS=y DT_SCHEMA_FILES=altr,pcie-root-port.yaml 
intel/socfpga_agilex7f_socdk_pcie_root_port.dtb
   DTC_CHK 
arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb
arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi:36.4-39.46: 
Warning (interrupt_map): 
/soc@0/bridge@80000000/pcie@200000000:interrupt-map: Cell 13 is not a 
phandle(0)
/home/mgerlach/git/linux-next/arch/arm64/boot/dts/intel/socfpga_agilex7f_socdk_pcie_root_port.dtb: 
pcie@200000000: interrupt-map: [[0, 0, 0, 1, 21, 1, 0, 0, 0], [2, 21, 2, 
0, 0, 0, 3, 21, 3], [0, 0, 0, 4, 21, 4]] is too short

The resulting device tree and driver code work as expected, but the 
warning is concerning. I can make the warning go away by putting 
interrupt-controller and #interrupt-cells in a subnode and make 
interrupt-map point to the subnode, but this requires changing the 
accepted driver code.

Any suggestions on how to proceed? I think changing the existing driver 
seems wrong.

Thanks,
Matthew Gerlach


>
>> 
>> It doesn't seem you are testing the binding against an actual DT.
>> Please do that.
>
> I need to fix the DTs I'm using for test :)
>
> Thanks for the feedback,
>
> Matthew Gerlach
>
>> 
>> Rob
>> 
>>> -		#interrupt-cells = <1>;
>>> -		bus-range = <0x0 0xFF>;
>>> -		device_type = "pci";
>>> -		msi-parent = <&msi_to_gic_gen_0>;
>>> -		#address-cells = <3>;
>>> -		#size-cells = <2>;
>>> -		interrupt-map-mask = <0 0 0 7>;
>>> -		interrupt-map = <0 0 0 1 &pcie_0 1>,
>>> -			            <0 0 0 2 &pcie_0 2>,
>>> -			            <0 0 0 3 &pcie_0 3>,
>>> -			            <0 0 0 4 &pcie_0 4>;
>>> -		ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 
>>> 0x00000000 0x10000000
>>> -			  0x82000000 0x00000000 0x10000000 0xd0000000 
>>> 0x00000000 0x10000000>;
>>> -	};
>> 
>

