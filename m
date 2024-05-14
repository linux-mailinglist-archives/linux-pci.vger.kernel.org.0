Return-Path: <linux-pci+bounces-7465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9604D8C5B11
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 20:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B3A1C214E3
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 18:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1A9180A74;
	Tue, 14 May 2024 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SV9z2pUp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C972AF11;
	Tue, 14 May 2024 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711417; cv=none; b=RhWRgly0Z1pgQCAuIVPcrPBOd0LxZS2J3pIMcK3zgH/HYgrmqcXampd6oWg5FDaIqHxfy+tz5W4Kp1+kqSc4+uGS8f96IVSvYIXLRs9iifMf1tFpV0iiLRssapq3IUmSTeZ6yLCXxR603XupkK4xiIiQZyGS/p+Hiw38B0F9SOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711417; c=relaxed/simple;
	bh=oIPCvErlbG4PiJ+F31OfFvDRug4mHXqm6elP/jtGkQ8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gtaVjUhYG1ogF8B8C0COg/u9rm4NB3xluvhnj6wp/vtIYWkycLSrh0QtTHjzoJJ+mH7EwCl2rSV4B9Ldmo/wlLqA3aQ5xpRStJ50FwUDiWa29JBfGlZxqGRRgX5z38FTFgVY3TOHuZC9cSquH1XZC45GKNK5q9U2+Kk4UT0usX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SV9z2pUp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715711416; x=1747247416;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oIPCvErlbG4PiJ+F31OfFvDRug4mHXqm6elP/jtGkQ8=;
  b=SV9z2pUpRgz4wnyGT0Xgc+3/bcMqWWihZmkCR61vSqZ9vFlVIipBrfAm
   HnPt3ad3W71XUqCGif8Tj9XCgDG7+b3Vm69dDY9jBzElqTao5+gNvUcJF
   t2nVQl73HSLzhPLifdE+oq+9y/37E2d5omH65Gkbs7cL4GzKv9W8RVEn6
   uacXdb17CuqHX7XuCKjOHWvbs8i7+eZSXafVqB9SGBWOKECkLzazakTeS
   sqeWqOYXIWzhiuo+gO61DfELiogFi1iv3PGlVgwApPRUhMP4FYhcRtplV
   bFT7sVvKdF2P6NoDExQ0co/pht0UVVuy9OB0pqVe0MCvvJ2eeTdTC8JrC
   Q==;
X-CSE-ConnectionGUID: y6RqiJlxRUajb1fXTBESRA==
X-CSE-MsgGUID: nELnoDIrTXi9zUczZ18C2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11658534"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11658534"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 11:30:15 -0700
X-CSE-ConnectionGUID: etXidxclQsS+E0rJebZIUQ==
X-CSE-MsgGUID: e8WmZbHDRaiwL+xQF0Pixg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30713754"
Received: from sj-4150-psse-sw-opae-dev2.sj.intel.com ([10.233.115.162])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 11:30:15 -0700
Date: Tue, 14 May 2024 11:30:05 -0700 (PDT)
From: matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@sj-4150-psse-sw-opae-dev2
To: Rob Herring <robh@kernel.org>
cc: linux-kernel@vger.kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org, 
    krzysztof.kozlowski+dt@linaro.org, kw@linux.com, bhelgaas@google.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: PCI: altera: Convert to YAML
In-Reply-To: <20240514131750.GA1214311-robh@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2405141044470.540832@sj-4150-psse-sw-opae-dev2>
References: <20240513205913.313592-1-matthew.gerlach@linux.intel.com> <171563836233.3319279.14962600621083837198.robh@kernel.org> <20240514131750.GA1214311-robh@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Tue, 14 May 2024, Rob Herring wrote:

>>>
>>
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/altr,pcie-root-port.example.dtb: pcie@c00000000: interrupt-map: [[0, 0, 0, 1, 2, 1, 0, 0, 0], [2, 2, 2, 0, 0, 0, 3, 2, 3], [0, 0, 0, 4, 2, 4]] is too short
>> 	from schema $id: http://devicetree.org/schemas/altr,pcie-root-port.yaml#
>
> You need 3 address cells after the phandles since the interrupt parent
> has 3 address cells.

Thanks for the extra explanation. Adding 3 address cells of 0 made the 
warning go away.

>
> What does your actual DT contain and do interrupts work because
> interrupts never would have worked I think? Making the PCI host the
> interrupt parent didn't even work in the kernel until somewhat recently
> (maybe a few years now). That's why a bunch of PCI hosts have an
> interrupt-controller child node.

The following DT snippet comes from 
https://www.rocketboards.org/foswiki/Projects/Stratix10PCIeRootPortWithMSI

The Linux kernel version is 4.14.130-ltsi. Would the use of the msi-parent 
node make everything work?

pcie_1_pcie_a10_hip_avmm: pcie@0x010000000 {
 	compatible = "altr,pcie-root-port-1.0";
 	reg = <0xd0000000 0x10000000>,
 	      <0xff210000 0x00004000>;
 	reg-names = "Txs", "Cra";
 	interrupt-parent = <&arria10_hps_0_arm_gic_0>;
 	interrupts = <0 24 4>;
 	interrupt-controller;
 	#interrupt-cells = <1>;
 	device_type = "pci";
 	msi-parent = <&pcie_0_msi_to_gic_gen_0>;
 	bus-range = <0x00000000 0x000000ff>;
 	#address-cells = <3>;
 	#size-cells = <2>;
 	ranges = <0x82000000 0x00000000 0x00000000 0xd0000000 0x00000000 
0x10000000>;
 	interrupt-map-mask = <0 0 0 7>;
 	interrupt-map = <0 0 0 1 &pcie_0_pcie_a10_hip_avmm 1>,
 			<0 0 0 2 &pcie_0_pcie_a10_hip_avmm 2>,
 			<0 0 0 3 &pcie_0_pcie_a10_hip_avmm 3>,
 			<0 0 0 4 &pcie_0_pcie_a10_hip_avmm 4>;
};
pcie_0_msi_to_gic_gen_0: msi@0x100014080 {
 	compatible = "altr,msi-1.0", "altr,msi-1.0";
 	reg = <0x00000001 0x00014080 0x00000010>,
 	      <0x00000001 0x00014000 0x00000080>;
 	reg-names = "csr", "vector_slave";
 	interrupt-parent = <&arria10_hps_0_arm_gic_0>;
 	interrupts = <0 22 4>;
 	clocks = <&pcie_0_clk_100>;
 	msi-controller = <1>;
 	num-vectors = <32>;
};

I am doing something similar with newer HIP with the 6.1.68-lts, and it 
seems to work. I had experimented with an interrupt-controller child 
node, but I wanted to maintain the existing binding definition and 
compatibility with the accepted driver code.

Matthew Gerlach



>
> Rob
>


