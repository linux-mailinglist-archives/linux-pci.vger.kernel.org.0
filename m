Return-Path: <linux-pci+bounces-40618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEA9C42BB3
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 12:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1CF3B3497
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 11:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB69301010;
	Sat,  8 Nov 2025 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="cDWq5EZN"
X-Original-To: linux-pci@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78743002C2;
	Sat,  8 Nov 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762600142; cv=none; b=LqMQ7BbMzFeaYudoOSSnbXsqfssPE6KiXWQG81vz0w3xwmnjlobQY/no+oviePI3w0TAEU6mJ9uf1ArFhqZ1vS8e9d4LAhGrgbbW4hyasuPpbZCcMwjJKU3NuWCzeDagpzaKJcp6hGQH62XpjVaEo7jadqAoMC6Kty+CDeBbC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762600142; c=relaxed/simple;
	bh=7haCvCWUOfsjYGqaHIzuphWqNU06gFWPaAWkAIWCbSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBk1WKIB0jMrkutsZFOsqEbcscnrhVxBSCmE3IN4s9rinsVKyI+RSSo9N9BHX9vcRaJKVWJxhOlS0Yb8BttZw8DikGS76DcY4aqw/FZsMS7aGJomddJSd25WtIc+/6ePH8rxUCEczynpuhQCs/BG/PDi3bVRM7OOsZoZ9UO27iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=cDWq5EZN; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=to2ffKjQT3P3MwBgednnfOCK140+zX9tIALsoHeMAbU=; b=cDWq5EZN2304uIsRG15seKn7jc
	8c4eO24JcZwAXyXW8HjrkgnDBqCvoME1flCK/uvSskYOXrEk9WEFizKXgzPI4ZxGLWnTSzkCFtVh+
	ha6+874xT6F7dbERZeye47Yy70N4dvhaVxzgF2PZNJYDBIhVPIlwPnHMV0UZ7tJ81wQl40RcFPv1B
	hJTknGJ/gAh9jFtRJsEhuGUUzoBbAQgVK94mtxGTqdbppsLSEC1E0a1lJmogvdKF+tlGy93qTAUuD
	yiUGyNCul62N3ePUAKm3omphE9n1bC4HBS7Sjgyeq/p/VYCPmIecnDKelrKw/XDjXj/PzftruGgIM
	DzZ0Os9g==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1vHgnx-0000000DxOH-1KAZ;
	Sat, 08 Nov 2025 12:08:25 +0100
Date: Sat, 8 Nov 2025 12:08:24 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Alex Elder <elder@riscstar.com>
Cc: dlan@gentoo.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, ziyao@disroot.org, johannes@erdfelt.com,
	mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
	shradha.t@samsung.com, inochiama@gmail.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, christian.bruel@foss.st.com,
	thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com,
	guodong@riscstar.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/7] Introduce SpacemiT K1 PCIe phy and host controller
Message-ID: <aQ8kqIljwGZfkF8M@aurel32.net>
Mail-Followup-To: Alex Elder <elder@riscstar.com>, dlan@gentoo.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	ziyao@disroot.org, johannes@erdfelt.com,
	mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
	shradha.t@samsung.com, inochiama@gmail.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, christian.bruel@foss.st.com,
	thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com,
	guodong@riscstar.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
References: <20251107191557.1827677-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107191557.1827677-1-elder@riscstar.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi Alex,

Thanks for this new version.

On 2025-11-07 13:15, Alex Elder wrote:
> This series introduces a PHY driver and a PCIe driver to support PCIe
> on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
> Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
> PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
> one PCIe lane, and the other two ports each have two lanes.  All PCIe
> ports operate at 5 GT/second.
> 
> The PCIe PHYs must be configured using a value that can only be
> determined using the combo PHY, operating in PCIe mode.  To allow
> that PHY to be used for USB, the needed calibration step is performed
> by the PHY driver automatically at probe time.  Once this step is done,
> the PHY can be used for either PCIe or USB.
> 
> This initial version of the driver supports 32 MSIs, and does not
> support PCI INTx interrupts.  The hardware does not support MSI-X.
> 
> Version 5 of this series incorporates suggestions made during the
> review of version 4.  Specific highlights are detailed below.
> 
> Note:
> Aurelien Jarno and Johannes Erdfelt have reported seeing ASPM errors
> accessing NVMe drives when using earlier versions of this series.
> The Kconfig files they used were very different from the RISC-V
> default configuration.
> 
> Aurelien has since reported the errors do not occur when using
> defconfig.  Johannes has not reported back about this.

Unfortunately, while it is true with v4, this is not the case with v5 
anymore :(

Fundamentally in the generic designware driver, post_init (which is used 
to disable L1 support on the controller side) is called after starting 
the link. The comparison of the capabilities is done in 
pcie_aspm_cap_init when the link is up, which happens a tiny bit after 
starting it.

In practice with v4, the link is started, ASPM L1 is disabled and the 
link becomes up. With v5, the move of the code getting and enabling the 
regulator changed the timing, and ASPM L1 is now disabled on the 
controller 2-3 ms after the link is up, which is too late.

I have added a call to pci_info to display the moment where ASPM is 
disabled. This is without the regulator change:

[    0.386730] spacemit-k1-pcie ca400000.pcie: host bridge /soc/pcie-bus/pcie@ca400000 ranges:
[    0.386970] spacemit-k1-pcie ca800000.pcie: host bridge /soc/pcie-bus/pcie@ca800000 ranges:
[    0.387017] spacemit-k1-pcie ca800000.pcie:       IO 0x00b7002000..0x00b7101fff -> 0x0000000000
[    0.387047] spacemit-k1-pcie ca800000.pcie:      MEM 0x00a0000000..0x00afffffff -> 0x00a0000000
[    0.387062] spacemit-k1-pcie ca800000.pcie:      MEM 0x00b0000000..0x00b6ffffff -> 0x00b0000000
[    0.400109] spacemit-k1-pcie ca400000.pcie:       IO 0x009f002000..0x009f101fff -> 0x0000000000
[    0.490101] spacemit-k1-pcie ca800000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4G
[    0.494195] spacemit-k1-pcie ca400000.pcie:      MEM 0x0090000000..0x009effffff -> 0x0090000000
[    0.850344] spacemit-k1-pcie ca400000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4G
[    0.950133] spacemit-k1-pcie ca400000.pcie: PCIe Gen.1 x2 link up
[    1.129988] spacemit-k1-pcie ca400000.pcie: PCI host bridge to bus 0000:00
[    1.335482] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.340946] pci_bus 0000:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x0000-0xfffff])
[    1.350181] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9effffff]
[    1.358734] pci_bus 0000:00: resource 4 [io  0x100000-0x1fffff]
[    1.362033] pci_bus 0000:00: resource 5 [mem 0x90000000-0x9effffff]
[    1.368289] spacemit-k1-pcie ca400000.pcie: pcie_aspm_override_default_link_state
[    1.375967] pci 0000:00:00.0: [1e5d:3003] type 01 class 0x060400 PCIe Root Port
[    1.383043] pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x000fffff]
[    1.388927] pci 0000:00:00.0: BAR 1 [mem 0x00000000-0x000fffff]
[    1.394826] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    1.400061] pci 0000:00:00.0:   bridge window [io  0x100000-0x100fff]
[    1.406460] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    1.413245] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    1.421012] pci 0000:00:00.0: supports D1
[    1.424948] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    1.432718] pci 0000:01:00.0: [1987:5015] type 00 class 0x010802 PCIe Endpoint
[    1.438698] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    1.445426] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x2 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    1.464897] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01

And this is with the regulator change:

[    0.410796] spacemit-k1-pcie ca400000.pcie: host bridge /soc/pcie-bus/pcie@ca400000 ranges:
[    0.410836] spacemit-k1-pcie ca800000.pcie: host bridge /soc/pcie-bus/pcie@ca800000 ranges:
[    0.410889] spacemit-k1-pcie ca800000.pcie:       IO 0x00b7002000..0x00b7101fff -> 0x0000000000
[    0.410917] spacemit-k1-pcie ca800000.pcie:      MEM 0x00a0000000..0x00afffffff -> 0x00a0000000
[    0.410932] spacemit-k1-pcie ca800000.pcie:      MEM 0x00b0000000..0x00b6ffffff -> 0x00b0000000
[    0.424651] spacemit-k1-pcie ca400000.pcie:       IO 0x009f002000..0x009f101fff -> 0x0000000000
[    0.436446] spacemit-k1-pcie ca400000.pcie:      MEM 0x0090000000..0x009effffff -> 0x0090000000
[    0.513897] spacemit-k1-pcie ca800000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4G
[    0.559595] spacemit-k1-pcie ca400000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4G
[    0.839412] spacemit-k1-pcie ca400000.pcie: PCIe Gen.1 x2 link up
[    0.847078] spacemit-k1-pcie ca400000.pcie: PCI host bridge to bus 0000:00
[    0.857600] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.868702] pci_bus 0000:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x0000-0xfffff])
[    1.146409] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9effffff]
[    1.373742] pci 0000:00:00.0: [1e5d:3003] type 01 class 0x060400 PCIe Root Port
[    1.380963] pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x000fffff]
[    1.386883] pci 0000:00:00.0: BAR 1 [mem 0x00000000-0x000fffff]
[    1.392808] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    1.395394] pci 0000:00:00.0:   bridge window [io  0x100000-0x100fff]
[    1.401811] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    1.408583] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    1.416354] pci 0000:00:00.0: supports D1
[    1.420294] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    1.428220] pci 0000:01:00.0: [1987:5015] type 00 class 0x010802 PCIe Endpoint
[    1.434034] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    1.440772] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x2 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    1.463390] pci 0000:01:00.0: pcie_aspm_override_default_link_state
[    1.467000] pci 0000:01:00.0: ASPM: default states L1
[    1.472093] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01

Note how the line pcie_aspm_override_default_link_state arrives too 
late.

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

