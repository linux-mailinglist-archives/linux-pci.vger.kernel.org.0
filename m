Return-Path: <linux-pci+bounces-42752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFE8CACFDF
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 12:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BC33300C296
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 11:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB0B288C96;
	Mon,  8 Dec 2025 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="eYu7jvbJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F402E7BAD;
	Mon,  8 Dec 2025 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765193154; cv=none; b=rsFEZvOe52iUldwW3kd19HfNnnpJchb5WyLVITA+oYlJYs8qXwxMaD3aVy8qe6amBz8RResRIkcPc1YSM0FOajl4LApnyh4yxfQvVE25KaMsnoc/QU72/HYU5sT3/FgQhN+lJ4+ZVn9/LK7V9CoYFn8qZjnH6+aMr65WBeiOdbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765193154; c=relaxed/simple;
	bh=DI8qZzuUSOdjLaLVXCGX/uS5aAgFMSDRnm16ZSY/j8Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaCwXgiprd4RKEicnXen+3bfCV7OmHEklWt5DhX0Q2Jcm0afXbzy3RoU1rZYnLkTjvDeJrQJEgY+vPhnF5lJRmG+um/0BkrUp8nsI7mZ3NRjzpxc1lijt26OxdUF7DJ4Fy9NNwiazh9A1JQ2TELRNirK66YtbUXP/RtJJ/2U+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=eYu7jvbJ; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1765193152; x=1796729152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yY/+q4jL+fBrDO9LBa1ME+SOU9sZ1Zd90D3EKAt7wNw=;
  b=eYu7jvbJ46S+Y5La9q4LNQelXDpC69npY16IglZwClZw2PWSRw1I5DGd
   T2F5zj4HAwrQ8c2Oxj/3tzLW1AqXpPQ05nxeWrggUmlddP4CT4jZybMoR
   wgZcX6o90geim94sPA7QQi6dGxT8uFoEya7QJTjvP8F8dDi2bmYhV+mG0
   SwNfAosgTVpNbic7vkWPUifK2kI4BgWIwxcYc97msSgdcUpitffr76Qqa
   DEiZSbVcaqtNlCkacTl1fmU5wCb2N5rr7VFVfVrw4Ujva31jv7zK/dg2W
   FV0HBPL+3vNU1V1iAzUNexwaPxwP/CBzmJnkABYehqO/wLmWtj/Tti3om
   Q==;
X-CSE-ConnectionGUID: Cok2AnuESk+hLIx9HDxLqw==
X-CSE-MsgGUID: Rp0Z0VsdQ7GF7LC9mBnNnA==
X-IronPort-AV: E=Sophos;i="6.20,258,1758585600"; 
   d="scan'208";a="8433698"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 11:25:49 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:8199]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.104:2525] with esmtp (Farcaster)
 id 5f4200bb-089a-4fa6-a38b-304468f38ee6; Mon, 8 Dec 2025 11:25:49 +0000 (UTC)
X-Farcaster-Flow-ID: 5f4200bb-089a-4fa6-a38b-304468f38ee6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 8 Dec 2025 11:25:49 +0000
Received: from dev-dsk-darnshah-1c-a4c7d5e9.eu-west-1.amazon.com (172.19.90.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 8 Dec 2025 11:25:47 +0000
From: Darshit Shah <darnshah@amazon.de>
To: <lukas@wunner.de>
CC: <Jonthan.Cameron@huawei.com>, <bhelgaas@google.com>, <darnir@gnu.org>,
	<darnshah@amazon.de>, <feng.tang@linux.alibaba.com>,
	<kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nh-open-source@amazon.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v2 0/1] Re: [PATCH] drivers/pci: Allow attaching AER to non-RP devices that support MSI
Date: Mon, 8 Dec 2025 11:25:44 +0000
Message-ID: <20251208112545.21315-1-darnshah@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aSnWyePbCKPvjpKq@wunner.de>
References: <aSnWyePbCKPvjpKq@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 28.11.25 18:07, Lukas Wunner wrote:
> On Fri, Nov 28, 2025 at 12:20:53PM +0000, Darshit Shah wrote:
>> Previously portdrv tried to prevent non-Root Port (RP) and non-Root
>> Complex Event Collector (RCEC) devices from enabling AER capability.
>> This was done because some switches enable AER but do not support MSI.
> 
> The AER driver only binds to RPs and RCECs, see aer_probe():
> 
> 	if ((pci_pcie_type(port) != PCI_EXP_TYPE_RC_EC) &&
> 	    (pci_pcie_type(port) != PCI_EXP_TYPE_ROOT_PORT))
> 		return -ENODEV;
> 
> So there's no point in adding PCIE_PORT_SERVICE_AER to "services"
> for other port types (as your patch does).

I agree that adding PCIE_PORT_SERVICE_AER to "services" for switches is
not useful.

> 
>> However, it is possible to have switches upstream of an endpoint that
>> support MSI and AER. Without AER capability being enabled on such
>> a switch, portdrv will refuse to enable the DPC capability as well,
>> preventing a PCIe error on an endpoint from being handled by the switch.
> 
> I assume you're referring to this clause in get_port_device_capability():
> 
> 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> 	    pci_aer_available() &&
> 	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
> 		services |= PCIE_PORT_SERVICE_DPC;
> 
> Presumably on your system, BIOS doesn't grant AER handling to the OS
> upon _OSC negotiation?  Is there a BIOS knob to change that?

On my system, BIOS does grant AER handling to the OS with _OSC negotiation.

2025-12-06 23:15:40.172000 kern INFO [    0.590601] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
2025-12-06 23:15:40.172000 kern INFO [    0.590607] acpi PNP0A08:00: _OSC: platform does not support [LTR]
2025-12-06 23:15:40.172000 kern INFO [    0.590610] acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability]

> Alternatively, does passing "pcie_ports=dpc-native" fix the issue?
> If it does, why do you need the patch instead of using the command line
> option?

Given that my firmware correctly negotiates and hands over control of AER
to Linux, we should not need to use a quirk to enable DPC support.

What seems to be happening instead is that portdrv has misinterpreted the
Implementation Note in PCIe r5.0 6.2.10 that states:
  "It is recommended that platform firmware and operating systems always link
  the control of DPC to the control of Advanced Error Reporting"

This does not mean that AER is working on each PCIe device that wants to enable
DPC. Rather that the OS is considered to have control over DPC, if it also has
control over AER for the host bridge upstream of the device.

Thus, I claim that the following checks are incorrect:

	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
	    pci_aer_available() &&
	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
		services |= PCIE_PORT_SERVICE_DPC;

PCIE_PORT_SERVICE_AER will only ever be enabled on RP and RCEC devices.
However, PCIE_PORT_SERVICE_DPC should be allowed on non-RP devices. In fact,
that is exactly where it is needed, since the switch upstream of an endpoint
device is required to generate the DPC signal. A fixed version of this check
would instead look like:

	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
	    pci_aer_available() &&
	    (pcie_ports_dpc_native || host->native_aer)
		services |= PCIE_PORT_SERVICE_DPC;

That is, we should allow binding PCIE_PORT_SERVICE_DPC to a device, if:

* The device advertises the DPC capability
* AER has not been disabled for Linux through the command line
* Linux has control of AER (and DPC) for the host bridge above the device
  * _OR_ `pcie_ports=dpc-native` was used on the command line

Coming next is an updated patch based on this.

-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


