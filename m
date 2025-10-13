Return-Path: <linux-pci+bounces-37982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDB8BD6511
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 23:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7D5D4EA62B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 21:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360F61D88A4;
	Mon, 13 Oct 2025 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5cLszBM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0970BEADC;
	Mon, 13 Oct 2025 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389278; cv=none; b=Ni2jDlAUcENO51HEM8z5NmWalxFqALnJW/lsPuHhhSzMohgzVZ1eNpJIHW2Je8TARy5i4l4YOhSLHp4lG2glsi+cx6nvah+Xddyz4GDa7MHYlvE6Ea+IHGTko8dmQhiQK4dgD2BZCWoNxl0KCFDZ1QZOMoQzXwUVJR9hTqqbWKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389278; c=relaxed/simple;
	bh=TGVwh+FVew/+FpJJ2EdB6m/QyvlMzl0yen5xz3HGn/g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GXRLvNuq2Pl3nNj7WdhpgA4JiEahMnDtcUuQgVDlX1nfE0SExnFnek5Pnwt9DPndYPphmnGBAr9Z/HuApkP60ya6atXFuLMM67YC2sp2HhZlrYsQQWRlwoBhvqPVFHyqg3mrr5RXFYfUw7IAl38sFsS6UfCMapMO17HYTlLfPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5cLszBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AF4C4CEE7;
	Mon, 13 Oct 2025 21:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760389277;
	bh=TGVwh+FVew/+FpJJ2EdB6m/QyvlMzl0yen5xz3HGn/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=D5cLszBMrTo8qExi1Oir6bZ5++fJauged/epDqNgQGFI/AOnOHahvbR+jE2QibKCV
	 ve56Ib86lxveshkzKUrZJ5slksjFqlc+dprFuZF/7sIdfC3LC/75B57u+lNldAA310
	 DuckZCENOFyVWSCo0BzinI6+voDqGXrjdlSqjUnS0X/u8HAWrGbvHKwbVW1bgIydLm
	 jcHkzaNO7Q5gnZmV11ktagitcxZsrWB2JclKTbTLxBmqPuCfrl5oMzqG7tliKaCazd
	 OMgVT3Z3FdMkJhSS2xfyxwBNjfD2CyDL9gc8f67Tb/8Bm7JtzQqwbF/32gpT0Q+4xS
	 Csn3VHRUIxl+A==
Date: Mon, 13 Oct 2025 16:01:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Guenter Roeck <linux@roeck-us.net>, regressions@lists.linux.dev
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
Message-ID: <20251013210116.GA864145@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <017ff8df-511c-4da8-b3cf-edf2cb7f1a67@packett.cool>

[+cc Guenter, regressions]

On Mon, Oct 06, 2025 at 05:00:25AM -0300, Val Packett wrote:
> On 9/24/25 10:42 AM, Ilpo Järvinen wrote:
> > Bridge windows are read twice from PCI Config Space, the first read is
> > made from pci_read_bridge_windows() which does not setup the device's
> > resources. It causes problems down the road as child resources of the
> > bridge cannot check whether they reside within the bridge window or
> > not.
> > 
> > Setup the bridge windows already in pci_read_bridge_windows().
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Looks like this change has broken the WiFi (but not NVMe) on my Snapdragon
> X1E laptop (Latitude 7455):
> 
> qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00
> pci_bus 0004:00: root bus resource [bus 00-ff]
> pci_bus 0004:00: root bus resource [io  0x100000-0x1fffff] (bus address
> [0x0000-0xfffff])
> pci_bus 0004:00: root bus resource [mem 0x7c300000-0x7dffffff]
> pci 0004:00:00.0: [17cb:0111] type 01 class 0x060400 PCIe Root Port
> pci 0004:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
> pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> pci 0004:00:00.0:   bridge window [io  0x100000-0x100fff]
> pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> pci 0004:00:00.0: PME# supported from D0 D3hot D3cold
> pci 0004:00:00.0: bridge window [mem 0x7c300000-0x7c3fffff]: assigned
> pci 0004:00:00.0: bridge window [mem 0x7c400000-0x7c4fffff 64bit pref]:
> assigned
> pci 0004:00:00.0: BAR 0 [mem 0x7c500000-0x7c500fff]: assigned
> pci 0004:00:00.0: bridge window [io  0x100000-0x100fff]: assigned
> pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> pci 0004:00:00.0:   bridge window [io  0x100000-0x100fff]
> pci 0004:00:00.0:   bridge window [mem 0x7c300000-0x7c3fffff]
> pci 0004:00:00.0:   bridge window [mem 0x7c400000-0x7c4fffff 64bit pref]
> pci_bus 0004:00: resource 4 [io  0x100000-0x1fffff]
> pci_bus 0004:00: resource 5 [mem 0x7c300000-0x7dffffff]
> pci_bus 0004:01: resource 0 [io  0x100000-0x100fff]
> pci_bus 0004:01: resource 1 [mem 0x7c300000-0x7c3fffff]
> pci_bus 0004:01: resource 2 [mem 0x7c400000-0x7c4fffff 64bit pref]
> pcieport 0004:00:00.0: PME: Signaling with IRQ 186
> pcieport 0004:00:00.0: AER: enabled with IRQ 186
> pci 0004:01:00.0: [17cb:1107] type 00 class 0x028000 PCIe Endpoint
> pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
> pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
> pci 0004:01:00.0: BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
> pci 0004:01:00.0: BAR 0 [mem size 0x00200000 64bit]: failed to assign
> pci 0004:01:00.0: BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
> pci 0004:01:00.0: BAR 0 [mem size 0x00200000 64bit]: failed to assign
> ath12k_pci 0004:01:00.0: BAR 0 [??? 0x00000000 flags 0x20000000]: can't
> assign; bogus alignment
> ath12k_pci 0004:01:00.0: failed to assign pci resource: -22
> ath12k_pci 0004:01:00.0: failed to claim device: -22
> ath12k_pci 0004:01:00.0: probe with driver ath12k_pci failed with error -22
> 
> 
> For comparison, with this change reverted it works again:
> 
> qcom-pcie 1c08000.pci: PCI host bridge to bus 0004:00
> pci_bus 0004:00: root bus resource [bus 00-ff]
> pci_bus 0004:00: root bus resource [io  0x0000-0xfffff]
> pci_bus 0004:00: root bus resource [mem 0x7c300000-0x7dffffff]
> pci 0004:00:00.0: [17cb:0111] type 01 class 0x060400 PCIe Root Port
> pci 0004:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
> pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> pci 0004:00:00.0:   bridge window [io  0x0000-0x0fff]
> pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> pci 0004:00:00.0: PME# supported from D0 D3hot D3cold
> pci 0004:00:00.0: BAR 0 [mem 0x7c300000-0x7c300fff]: assigned
> pci 0004:00:00.0: PCI bridge to [bus 01-ff]
> pci_bus 0004:00: resource 4 [io  0x0000-0xfffff]
> pci_bus 0004:00: resource 5 [mem 0x7c300000-0x7dffffff]
> pcieport 0004:00:00.0: PME: Signaling with IRQ 195
> pcieport 0004:00:00.0: AER: enabled with IRQ 195
> pci 0004:01:00.0: [17cb:1107] type 00 class 0x028000 PCIe Endpoint
> pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
> pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
> pci 0004:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1
> ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
> pci 0004:01:00.0: ASPM: DT platform, enabling ClockPM
> pcieport 0004:00:00.0: bridge window [mem 0x7c400000-0x7c5fffff]: assigned
> pci 0004:01:00.0: BAR 0 [mem 0x7c400000-0x7c5fffff 64bit]: assigned
> ath12k_pci 0004:01:00.0: BAR 0 [mem 0x7c400000-0x7c5fffff 64bit]: assigned
> ath12k_pci 0004:01:00.0: enabling device (0000 -> 0002)
> ath12k_pci 0004:01:00.0: MSI vectors: 16
> ath12k_pci 0004:01:00.0: Hardware name: wcn7850 hw2.0

#regzbot introduced: a43ac325c7cb ("PCI: Set up bridge resources earlier")

