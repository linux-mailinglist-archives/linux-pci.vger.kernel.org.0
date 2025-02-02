Return-Path: <linux-pci+bounces-20637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842A0A24F85
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 19:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45C216355D
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 18:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948C018A6AE;
	Sun,  2 Feb 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+kyDozn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D435966;
	Sun,  2 Feb 2025 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738522195; cv=none; b=fPFLNVmvi5NuQ3zQu83jG7JbMrcBCfH+C8Ry2LD9dVGd71yKY/qf2eovBudfR7dgEGgGBHiUe+C2SjL6eJxb4KArxr5tuWeKzluRKy1oJB1xxTX5rst4I6gIvxdDoRqK8IvCAkR1aadKGccYbIXCPp/h9du7QjOvzmYbsRj7VzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738522195; c=relaxed/simple;
	bh=D03A+CoIWZFnvc8Hp6vQ9pm+8DMtUD7yaOC2/CdTX8Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NQ91AgdEAxDpjUkLzkdoVqLzzqrpQ/UaXpjrKnjTBR6di96HrwUraQV2sc2QmnN9xloM11Gmm+N1ZgCvXYSCbKauv7Geq9doMKMRGEpBcxzy1LTR8zP6ITk6JnmGCHU00xsSq4lyZBmibl+ZBL5wsjOBWZSnwwCgBBTsN6vrxv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+kyDozn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738522194; x=1770058194;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=D03A+CoIWZFnvc8Hp6vQ9pm+8DMtUD7yaOC2/CdTX8Y=;
  b=L+kyDoznoMxURnjzvZ+7Dcwu1OICQITVRnIi29tZxo/po+T6a+M/CWRj
   nsmTi3UNFk3lQTGUVWr6IQBZZU6HjqHvR4s0qE8nq30BCDzAu9OhuUeZg
   DkZ/VxJnmHLkIiYGt+Bu2/YnJiWd4NAtujTJLW31RKv9phNxPVpd/iYq5
   0j7Xt0nJMU4zgWCI/CtU5FtPqucv1zIuorzOhbTSigpILyGUk5Xn4M8Mt
   DZVDTHcFg3iKijo5D6WvQ2HQLaPcGQ2b3FF/Bavj9f4GefLAy4VCH3kgh
   0lnBsDacWS2kM9WvibweDpgsDYCbjSoFg68LXf8niCvl90Z/yCWNzaaNb
   A==;
X-CSE-ConnectionGUID: aKyj8BHwSWy1J2Qn7aGDEQ==
X-CSE-MsgGUID: YiK6aTG7SeWGJmizx8sRNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="42772404"
X-IronPort-AV: E=Sophos;i="6.13,254,1732608000"; 
   d="scan'208";a="42772404"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2025 10:49:53 -0800
X-CSE-ConnectionGUID: 6bTL8Z3tSQiqsyHm26MA/A==
X-CSE-MsgGUID: 7dAhIhjyT/S/n4TOc3Qu1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110970549"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2025 10:49:52 -0800
Date: Sun, 2 Feb 2025 10:49:52 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    peter.colberg@altera.com
Subject: Re: [PATCH v5 3/5] arm64: dts: agilex: add dtsi for PCIe Root Port
In-Reply-To: <dd51fdae-0e00-44a9-a5a0-e536ba60fd8c@kernel.org>
Message-ID: <56486d91-5ca-d85-eca1-1ce2df25238@linux.intel.com>
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com> <20250127173550.1222427-4-matthew.gerlach@linux.intel.com> <ea614dc5-ad24-4795-b9ba-fa682eda428f@kernel.org> <22cb714e-db76-b07-8572-2f70f6848369@linux.intel.com>
 <40a3dced-defe-412d-b5b2-efcc9619d172@kernel.org> <7c802294-97f6-3e9-4028-686484a525c5@linux.intel.com> <dd51fdae-0e00-44a9-a5a0-e536ba60fd8c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Sun, 2 Feb 2025, Krzysztof Kozlowski wrote:

> On 01/02/2025 20:12, matthew.gerlach@linux.intel.com wrote:
>>>
>>>> they are also referenced in the following:
>>>>      Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
>>>>      arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
>>>> I am not exactly sure where the right place is to define them, maybe
>>>> Documentation/devicetree/bindings/arm/intel,socfpga.yaml. On the other
>>>> hand, no code references these names; so it might make sense to just
>>>> remove them.
>>>
>>> In general: nowhere, because simple bus does not have such properties.
>>> It's not about reg-names only - you cannot have reg. You just did not
>>> define here simple-bus.
>>
>> I understand. I will remove reg and reg-names.
>
> If you have there IO address space, then removal does not sound right,
> either. You just need to come with the bindings for this dedicated
> device, whatever this is. There is no description here, not much in
> commit msg, so I don't know what is the device you are adding. PCI has
> several bindings, so is this just host bridge?

The device associated with two address ranges may be best described as a 
simple-bus. It is a bus between the CPU and the directly connected FPGA in 
the same package as the SOC. The design programmed into the FPGA 
determines the device(s) connected to the bus. The hardware implementing 
this bus does have reset lines which allow for safely reprogramming the 
FPGA while the SOC is running, which implies appropriate bindings as you 
suggest. Something like the following might make sense:

 	aglx_hps_bridges: fpga-bus@80000000 {
 		compatible = "altr,agilex-hps-fpga-bridge", "simple-bus";
 		reg = <0x80000000 0x20200000>,
 		      <0xf9000000 0x00100000>;
 		reg-names = "axi_h2f", "axi_h2f_lw";
 		#address-cells = <0x2>;
 		#size-cells = <0x1>;
 		ranges = <0x00000000 0x00000000 0x80000000 0x00040000>,
 			 <0x00000000 0x10000000 0x90100000 0x0ff00000>,
 			 <0x00000000 0x20000000 0xa0000000 0x00200000>,
 			 <0x00000001 0x00010000 0xf9010000 0x00008000>,
 			 <0x00000001 0x00018000 0xf9018000 0x00000080>,
 			 <0x00000001 0x00018080 0xf9018080 0x00000010>;
 		reset = <&rst SOC2FPGA_RESET>, <&rst LWHPS2FPGA_RESET>;
 		reset-names = "soc2fpga", "lwhps2fpga";
 		...
 	};

>
> Best regards,
> Krzysztof
>
Thank you for the feedback,
Matthew Gerlach

