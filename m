Return-Path: <linux-pci+bounces-37603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E19BBD4B1
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 10:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1490734970A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 08:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4AA253939;
	Mon,  6 Oct 2025 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="GSxlFAB2"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A720311
	for <linux-pci@vger.kernel.org>; Mon,  6 Oct 2025 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759737642; cv=none; b=LVW0rkS3yxfBrivBys5bal1AQqLtJXfbHzoVjzRU6xizt0ZOEgetns1wYZu9RIjyty1iVPfmB7kT061zjfUHXINko4nz9qSpu5hHbvDhqAYCeov5hLV9f899UiTqN87dYfX7Gux+qKBG879Wgn9dIhDJgZ16jSz+pMEBlffWb9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759737642; c=relaxed/simple;
	bh=2TRhewersXLQSe/faV+uP8FY2DQ0QQvMuw4x6eI2VMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0k+CdXCwdZBAvVPsrk6DK8BuRPMxyfYdXJr56alOVJ2+wHKHR0YE3LluVAMuek/A/wTWl10McGHTFsvcSq0SWY4mRMgE+2DdTZkZImY9d7Cf2Qg3KC1K0GA90qUsGg+/InubYKL/Ld6th6bZ2cRFEEBNWgFLQieRSNS8elJjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=GSxlFAB2; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <017ff8df-511c-4da8-b3cf-edf2cb7f1a67@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1759737637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7dps9P76y2H58QBWu1IadoGY1ktF9fh7Xpe5B4p8lQ=;
	b=GSxlFAB2fPvHLfTS3TqVVtRq7t0hYvtzYAvc0jy9NKhLH/+xb3wwVtZD4THRJESE2TE36G
	yZi5hRot19A/C/5sUkDYKWLmgpm7nIBLVliTWrIUrkG6pfSazQ7GKxZ9juKHwHD1c7qZMd
	WbnmOn9J785OQyWIfaDV8vXukBFB1tKES8o/JnU8N8fIMji/eOz2CFhZOSp0vNvEEfFAru
	e5IvitysTkFh6xsQUSSeIw3IECLsrCqWwJAXk3bp5sVgd+hsR9dmlXLGKvtcp1h3jlArpS
	2BNmiv/pgi3YW76KLlQz67X2MHXtX6ztXtAgmU1dgtBzGfj+3nz2npl7ocy4fA==
Date: Mon, 6 Oct 2025 05:00:25 -0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
 <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 9/24/25 10:42 AM, Ilpo Järvinen wrote:
> Bridge windows are read twice from PCI Config Space, the first read is
> made from pci_read_bridge_windows() which does not setup the device's
> resources. It causes problems down the road as child resources of the
> bridge cannot check whether they reside within the bridge window or
> not.
>
> Setup the bridge windows already in pci_read_bridge_windows().
>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Looks like this change has broken the WiFi (but not NVMe) on my 
Snapdragon X1E laptop (Latitude 7455):

qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00
pci_bus 0004:00: root bus resource [bus 00-ff]
pci_bus 0004:00: root bus resource [io  0x100000-0x1fffff] (bus address 
[0x0000-0xfffff])
pci_bus 0004:00: root bus resource [mem 0x7c300000-0x7dffffff]
pci 0004:00:00.0: [17cb:0111] type 01 class 0x060400 PCIe Root Port
pci 0004:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
pci 0004:00:00.0: PCI bridge to [bus 01-ff]
pci 0004:00:00.0:   bridge window [io  0x100000-0x100fff]
pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci 0004:00:00.0: PME# supported from D0 D3hot D3cold
pci 0004:00:00.0: bridge window [mem 0x7c300000-0x7c3fffff]: assigned
pci 0004:00:00.0: bridge window [mem 0x7c400000-0x7c4fffff 64bit pref]: 
assigned
pci 0004:00:00.0: BAR 0 [mem 0x7c500000-0x7c500fff]: assigned
pci 0004:00:00.0: bridge window [io  0x100000-0x100fff]: assigned
pci 0004:00:00.0: PCI bridge to [bus 01-ff]
pci 0004:00:00.0:   bridge window [io  0x100000-0x100fff]
pci 0004:00:00.0:   bridge window [mem 0x7c300000-0x7c3fffff]
pci 0004:00:00.0:   bridge window [mem 0x7c400000-0x7c4fffff 64bit pref]
pci_bus 0004:00: resource 4 [io  0x100000-0x1fffff]
pci_bus 0004:00: resource 5 [mem 0x7c300000-0x7dffffff]
pci_bus 0004:01: resource 0 [io  0x100000-0x100fff]
pci_bus 0004:01: resource 1 [mem 0x7c300000-0x7c3fffff]
pci_bus 0004:01: resource 2 [mem 0x7c400000-0x7c4fffff 64bit pref]
pcieport 0004:00:00.0: PME: Signaling with IRQ 186
pcieport 0004:00:00.0: AER: enabled with IRQ 186
pci 0004:01:00.0: [17cb:1107] type 00 class 0x028000 PCIe Endpoint
pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
pci 0004:01:00.0: BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
pci 0004:01:00.0: BAR 0 [mem size 0x00200000 64bit]: failed to assign
pci 0004:01:00.0: BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
pci 0004:01:00.0: BAR 0 [mem size 0x00200000 64bit]: failed to assign
ath12k_pci 0004:01:00.0: BAR 0 [??? 0x00000000 flags 0x20000000]: can't 
assign; bogus alignment
ath12k_pci 0004:01:00.0: failed to assign pci resource: -22
ath12k_pci 0004:01:00.0: failed to claim device: -22
ath12k_pci 0004:01:00.0: probe with driver ath12k_pci failed with error -22


For comparison, with this change reverted it works again:

qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00
pci_bus 0004:00: root bus resource [bus 00-ff]
pci_bus 0004:00: root bus resource [io  0x0000-0xfffff]
pci_bus 0004:00: root bus resource [mem 0x7c300000-0x7dffffff]
pci 0004:00:00.0: [17cb:0111] type 01 class 0x060400 PCIe Root Port
pci 0004:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
pci 0004:00:00.0: PCI bridge to [bus 01-ff]
pci 0004:00:00.0:   bridge window [io  0x0000-0x0fff]
pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci 0004:00:00.0: PME# supported from D0 D3hot D3cold
pci 0004:00:00.0: BAR 0 [mem 0x7c300000-0x7c300fff]: assigned
pci 0004:00:00.0: PCI bridge to [bus 01-ff]
pci_bus 0004:00: resource 4 [io  0x0000-0xfffff]
pci_bus 0004:00: resource 5 [mem 0x7c300000-0x7dffffff]
pcieport 0004:00:00.0: PME: Signaling with IRQ 195
pcieport 0004:00:00.0: AER: enabled with IRQ 195
pci 0004:01:00.0: [17cb:1107] type 00 class 0x028000 PCIe Endpoint
pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
pci 0004:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 
ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
pci 0004:01:00.0: ASPM: DT platform, enabling ClockPM
pcieport 0004:00:00.0: bridge window [mem 0x7c400000-0x7c5fffff]: assigned
pci 0004:01:00.0: BAR 0 [mem 0x7c400000-0x7c5fffff 64bit]: assigned
ath12k_pci 0004:01:00.0: BAR 0 [mem 0x7c400000-0x7c5fffff 64bit]: assigned
ath12k_pci 0004:01:00.0: enabling device (0000 -> 0002)
ath12k_pci 0004:01:00.0: MSI vectors: 16
ath12k_pci 0004:01:00.0: Hardware name: wcn7850 hw2.0

Not quite sure what's going on with these windows..

~val


