Return-Path: <linux-pci+bounces-2452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4268385AF
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 03:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF0DB2931D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 02:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A863D53800;
	Tue, 23 Jan 2024 02:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBOcd2O6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B3753E00
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705977471; cv=none; b=C0GBf0T1D8NkaYEA6uyxCyQkUb7qvh6/KuyV+bQStr0nrkOs+GTfE7rKycozngFgehP4OrSBE+K1aJKbQtvyqQz79yw9n4Y1Tpe9lKCvrcwzE39wECJOkA5a+6tPQ7f+tdu+CbfrYghqRwIpEBqZ/wqyvDYOMvPMqqpkq6IhoG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705977471; c=relaxed/simple;
	bh=7+3PuV0r3DFaD65sulvgf1QBxLtlOihJRgVetyC2oyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIYBbpJJOduPgADUVpBwEltuv6clgOZDvjtNRvbclaUYc0+TfbSoYR1CZe2z6fBun1xa8DBMls6pmNscfhQgHnbSFxCD4RbR2FeltloIrXFPWk0oBSTUp2w5jVLkHvDu/Wf48iuhfjVK+LAO94ALz+4O8BtXXutcl6t/NDDpwBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBOcd2O6; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705977470; x=1737513470;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7+3PuV0r3DFaD65sulvgf1QBxLtlOihJRgVetyC2oyY=;
  b=UBOcd2O6ZFsS1//4CR8CVQTVgc3UwJiclP/1qZxvXUhazhrLAmWLSK/0
   XvGfLnUrSfm33LbqhDYZ7wSsU6s0BBtOhSyvxLx23uxIGclr9ADOLELIR
   T1c51C0IQ+LdsK71gKEDfkZmFkz1cjRKKw0dTL8g6jlC8mSamsFpW1muV
   8AltiAKvdIVjaNblIxkqy6t5nTduGISLGpmF+m7RgHrxYjTPqutd7a9qw
   bTsf/rITAeEy8stxxlr77osm6iHT2ZrafS+vKn4qNhIVFPrbFq932Xzl8
   pNjgb06W/ThLKVT2xHp3EVWc38fBvwkhhNVEsoc0KbXQuacxWq7jecMlb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="391817922"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="391817922"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 18:37:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="735402433"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="735402433"
Received: from sjbowden-mobl1.amr.corp.intel.com (HELO [10.209.73.34]) ([10.209.73.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 18:37:49 -0800
Message-ID: <f97e2a24-80b3-4f0f-ab46-65f20cc811d8@linux.intel.com>
Date: Mon, 22 Jan 2024 18:37:48 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER
 natively.
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>,
 Matthew W Carlis <mattc@purestorage.com>
Cc: bhelgaas@google.com, kbusch@kernel.org, linux-pci@vger.kernel.org,
 lukas@wunner.de, mika.westerberg@linux.intel.com
References: <20240122193247.GA278696@bhelgaas>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240122193247.GA278696@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/22/24 11:32 AM, Bjorn Helgaas wrote:
> On Mon, Jan 08, 2024 at 05:15:08PM -0700, Matthew W Carlis wrote:
>> A small part is probably historical; we've been using DPC on PCIe
>> switches since before there was any EDR support in the kernel. It
>> looks like there was a PCIe DPC ECN as early as Feb 2012, but this
>> EDR/DPC fw ECN didn't come in till Jan 2019 & kernel support for ECN
>> was even later. Its not immediately clear I would want to use EDR in
>> my newer architecures & then there are also the older architecures
>> still requiring support. When I submitted this patch I came at it
>> with the approach of trying to keep the old behavior & still support
>> the newer EDR behavior. Bjorns patch from Dec 28 2023 would seem to
>> change the behavior for both root ports & switch ports, requiring
>> them to set _OSC Control Field bit 7 (DPC) and _OSC Support Field
>> bit 7 (EDR) or a kernel command line value. I think no matter what,
>> we want to ensure that PCIe Root Ports and PCIe switches arrive at
>> the same policy here.
> Is there an approved DPC ECN to the PCI Firmware spec that adds DPC
> control negotiation, but does *not* add the EDR requirement?
>
> I'm looking at
> https://members.pcisig.com/wg/PCI-SIG/document/previewpdf/12888, which
> seems to be the final "Downstream Port Containment Related
> Enhancements" ECN, which is dated 1/28/2019 and applies to the PCI
> Firmware spec r3.2.
>
> It adds bit 7, "PCI Express Downstream Port Containment Configuration
> control", to the passed-in _OSC Control field, which indicates that
> the OS supports both "native OS control and firmware ownership models
> (i.e. Error Disconnect Recover notification) of Downstream Port
> Containment."
>
> It also adds the dependency that "If the OS sets bit 7 of the Control
> field, it must set bit 7 of the Support field, indicating support for
> the Error Disconnect Recover event."
>
> So I'm trying to figure out if the "support DPC but not EDR" situation
> was ever a valid place to be.  Maybe it's a mistake to have separate
> CONFIG_PCIE_DPC and CONFIG_PCIE_EDR options.

My understanding is also similar. I have raised the same point in
https://lore.kernel.org/all/3c02a6d6-917e-486c-ad41-bdf176639ff2@linux.intel.com/

IMO, we don't need a separate config for EDR. I don't think user can gain anything
with disabling EDR and enabling DPC. As long as firmware does not user EDR
support, just compiling the code should be harmless.

So we can either remove it, or select it by default if user selects DPC config.

>
> CONFIG_PCIE_EDR depends on CONFIG_ACPI, so the situation is a little
> bit murky on non-ACPI systems that support DPC.

If we are going to remove the EDR config, it might need #ifdef CONFIG_ACPI changes
in edr.c to not compile ACPI specific code. Alternative choice is to compile edr.c
with CONFIG_ACPI.

>
> Bjorn
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


