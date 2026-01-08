Return-Path: <linux-pci+bounces-44274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1FDD02D05
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 14:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 695E733E37D5
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 12:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08DC3EF0C2;
	Thu,  8 Jan 2026 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZO3LpUT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DF443CEE3
	for <linux-pci@vger.kernel.org>; Thu,  8 Jan 2026 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868457; cv=none; b=EACPTqMy419OMpXT1IRE0zkSTgvXuW7ntTfHd4s2mtugHiOX10aGbg5ZnRwTLE1+dNCTXYkZUEgg08TOOp3/udiB3ho71IRgxekC4Jj1qGMB/DgMKkSWsUi5FDQ4pdmHKwz3RUJ8hLiK6e1PQ/femg/mAkO+Kn/AMmSngDztZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868457; c=relaxed/simple;
	bh=U5nPp3+cFm1W/s+K3tenL4kVGeUDXVoblLL996mXuNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMWi2oNE/hYmamd5pXgFvXYwuYhF2IWrsxV8a3H6NCyBkc8AlmpYGZMMdZfLp6tra1LaMdueC2IRNkfHo+Ysmp06V/tmKTXka04PLkY0VgiLas9uoDzTWonwChovLsAc4qIUl2xZbiMizzplJaUHWFeZxFv9mcn01u8J6m2J2Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZO3LpUT; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c1e7cdf0905so1404458a12.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 02:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767868448; x=1768473248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SchtY8It9mr1HUo0oIkx5e99zWrF/tN41rh1aJndtgI=;
        b=AZO3LpUTF1dQg8IBCOUXUIf2gw++W02QgMtHiWlGk6YAcccy5J7ECVNqMalFIjcBFD
         X9ZVHGquKd1ACJ9Re7a49T9Okwx+rQ1t8PCRQ1OOEgy5TSAl+Ayb+wNjJZdZctHR93s2
         TnqsoXERehCzxAYC89m/38wZh6faYuO7wNJSni6th01aj84lj2kTx67DPnTnRnRhOhjq
         K264iuAAtB1Pg9CnTKFEeZLi5IFYpozh1Nm0NNA13zS8lUfoPzw3xwXmUYnSrVuU16oa
         iYcA8hSFIukO6JUAnkA78Co+1nwKl+ksGOg5k9MIjlT+CD/Flrcdey3MKiZX80ncCxC2
         yVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868448; x=1768473248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SchtY8It9mr1HUo0oIkx5e99zWrF/tN41rh1aJndtgI=;
        b=uiYbt6IOpTAGdMXSZQkLsxT8Zkg90oCASUs7ZLU9e3oFdMamcUnZCXkaMHaQpzFk7E
         Tme5mck/OssxCw1CJc+joOib64jdUuy86DmsxASP2JEqsVdIrlLIGKypvJBQnf8PGYn6
         /ZCW9Ou8ufIhxZkPzxmn7gL3Y5H+f0oQ195WVH0l+pvr0x0Tv2ZjfDkH6SacZeqEU1Rj
         ec4XPXOMekoxc3fJeVF0wOwFJ0igsnCZxmkZIlujEuYoA4cayGkNoZVpP2phCixVBgBD
         Yx6kluvk11Z7LzfZTN9Neh+TFzGEunsH7lb0Y5woSO35g4+19eHxFttbeix84z1MOITb
         9SPw==
X-Forwarded-Encrypted: i=1; AJvYcCVtnfitjiZ3uIG1nLcK6g4Y8630qd1M3kD1opE6uhTfWjQIUelMrSd+zqZ3SB0VB6PmNxvosMrLzkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwixgucZPoaeeH3CmslQ/eJLt/qjiIWnJTkbWG2eSKXgV3Y14SC
	9JkIgvXsnB5F3FGURyCVJviGuDBouYXGU1f5Zs7CpiccNMDzKm5zVExQrIc+
X-Gm-Gg: AY/fxX7KU3U0yyXo5UIGUM2j8vfcJLgjTZScybkCw/vznHQ6NfDQEpflKZCYcXN0MWE
	FKBKgNysajAdJ+w+pvTkl2K9genptd0FfBfBkHfhSL9iNEppy67/s2isK/zzKjcjtas81e4MKw8
	Ua0XeuV7BB6W9z09bglm8+MqelaOzkTubmduWf5Fd2u35nfwtvej4eL0Jc0awg18RXZe5pd7GjU
	otvONbut9Jq4GyPtpcwZFltD4vEhd01zGFqJ/o3L1MTdLBXxDXL7UHYDgJ1MVi5fhOdkqidmZuU
	wbNK5r3KGBPxx9Q6fBkL992O75/nXUXrQ9j5kXNp5E6+bcuRtpIsdPz+Vs9HSP0vklG0aDAq5dH
	Xmnub4UgNysr/6gymUh40BnUPHTJQezlccs4sj9Jg7y9+yEjgvLJsAKKdmNp+g+0zBDItXLAVNH
	DxfGAnCfboBXGWkj0=
X-Google-Smtp-Source: AGHT+IGSd4pqyzRTa9kCebAhz5z7/YLz8YNjS9INTF2rptBIEH3dNgoen2GPtqhNVW/zSj9Hgy2ZTQ==
X-Received: by 2002:a17:90b:5708:b0:34c:4c6d:ad0f with SMTP id 98e67ed59e1d1-34f68cc29a4mr5712763a91.37.1767868447636;
        Thu, 08 Jan 2026 02:34:07 -0800 (PST)
Received: from at.. ([171.61.166.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f6b8a762bsm1960761a91.4.2026.01.08.02.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:34:07 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: YehezkelShB@gmail.com,
	andreas.noever@gmail.com,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	feng.tang@linux.alibaba.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mingo@redhat.com,
	oohall@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	tglx@linutronix.de,
	westeri@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Date: Thu,  8 Jan 2026 10:33:58 +0000
Message-ID: <20260108103358.3412-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108095303.GQ2275908@black.igk.intel.com>
References: <20260108095303.GQ2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am using a SD-card reader in the thunderbolt port (usb-c)

Unfoutunatly my linux install got bricked because of macOS update,
so i cant provide dmesg, but i have lspci saved on macOS:

00:00.0 Host bridge [0600]: Intel Corporation Comet Lake-S 6c Host Bridge/DRAM Controller [8086:9b53] (rev 03)
	DeviceName: SATA
	Subsystem: Intel Corporation Comet Lake-S 6c Host Bridge/DRAM Controller [8086:7270]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	IOMMU group: 0
	Capabilities: <access denied>
	Kernel driver in use: skl_uncore

00:01.0 PCI bridge [0604]: Intel Corporation 6th-10th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 03) (prog-if 00 [Normal decode])
	Subsystem: Intel Corporation 6th-10th Gen Core Processor PCIe Controller (x16) [8086:7270]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin A routed to IRQ 25
	IOMMU group: 1
	Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
	I/O behind bridge: 3000-3fff [size=4K] [16-bit]
	Memory behind bridge: 81600000-817fffff [size=2M] [32-bit]
	Prefetchable memory behind bridge: a0000000-b01fffff [size=258M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:12.0 Signal processing controller [1180]: Intel Corporation Comet Lake PCH Thermal Controller [8086:06f9]
	Subsystem: Intel Corporation Comet Lake PCH Thermal Controller [8086:7270]
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ -2147483648
	IOMMU group: 2
	Region 0: Memory at 81816000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: intel_pch_thermal
	Kernel modules: intel_pch_thermal

00:14.0 USB controller [0c03]: Intel Corporation Comet Lake USB 3.1 xHCI Host Controller [8086:06ed] (prog-if 30 [XHCI])
	Subsystem: Intel Corporation Comet Lake USB 3.1 xHCI Host Controller [8086:7270]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 33
	IOMMU group: 3
	Region 0: Memory at 81800000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <access denied>
	Kernel driver in use: xhci_hcd

00:14.2 RAM memory [0500]: Intel Corporation Comet Lake PCH Shared SRAM [8086:06ef]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	IOMMU group: 3
	Region 0: Memory at 81814000 (64-bit, non-prefetchable) [disabled] [size=8K]
	Region 2: Memory at 81817000 (64-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: <access denied>

00:16.0 Communication controller [0780]: Intel Corporation Comet Lake HECI Controller [8086:06e0]
	Subsystem: Intel Corporation Comet Lake HECI Controller [8086:7270]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 66
	IOMMU group: 4
	Region 0: Memory at 81818000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: mei_me
	Kernel modules: mei_me

00:1b.0 PCI bridge [0604]: Intel Corporation Comet Lake PCI Express Root Port #17 [8086:06c0] (rev f0) (prog-if 00 [Normal decode])
	Subsystem: Intel Corporation Comet Lake PCI Express Root Port [8086:7270]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin A routed to IRQ 26
	IOMMU group: 5
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: [disabled] [16-bit]
	Memory behind bridge: [disabled] [32-bit]
	Prefetchable memory behind bridge: b0400000-b16fffff [size=19M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:06b8] (rev f0) (prog-if 00 [Normal decode])
	Subsystem: Intel Corporation Device [8086:7270]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin A routed to IRQ 27
	IOMMU group: 6
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: [disabled] [16-bit]
	Memory behind bridge: 81000000-814fffff [size=5M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR+ <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1c.1 PCI bridge [0604]: Intel Corporation Device [8086:06b9] (rev f0) (prog-if 00 [Normal decode])
	Subsystem: Intel Corporation Device [8086:7270]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin B routed to IRQ 28
	IOMMU group: 7
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
	I/O behind bridge: [disabled] [16-bit]
	Memory behind bridge: 80000000-800fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: b1700000-b17fffff [size=1M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1c.4 PCI bridge [0604]: Intel Corporation Device [8086:06bc] (rev f0) (prog-if 00 [Normal decode])
	Subsystem: Intel Corporation Device [8086:7270]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin A routed to IRQ 29
	IOMMU group: 8
	Bus: primary=00, secondary=07, subordinate=7c, sec-latency=0
	I/O behind bridge: 5000-8fff [size=16K] [16-bit]
	Memory behind bridge: 81900000-8fafffff [size=226M] [32-bit]
	Prefetchable memory behind bridge: b1800000-bf7fffff [size=224M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:1e.0 Communication controller [0780]: Intel Corporation Comet Lake PCH Serial IO UART Host Controller #0 [8086:06a8]
	Subsystem: Intel Corporation Comet Lake PCH Serial IO UART Host Controller [8086:7270]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin A routed to IRQ 20
	IOMMU group: 9
	Region 0: Memory at 4000100000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1e.1 Communication controller [0780]: Intel Corporation Comet Lake PCH Serial IO UART Host Controller #1 [8086:06a9]
	Subsystem: Intel Corporation Comet Lake PCH Serial IO UART Host Controller [8086:7270]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin B routed to IRQ 21
	IOMMU group: 9
	Region 0: Memory at 4000101000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci

00:1f.0 ISA bridge [0601]: Intel Corporation Z490 Chipset LPC/eSPI Controller [8086:0685]
	Subsystem: Intel Corporation Z490 Chipset LPC/eSPI Controller [8086:7270]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	IOMMU group: 10

00:1f.3 Audio device [0403]: Intel Corporation Comet Lake PCH cAVS [8086:06c8]
	Subsystem: Intel Corporation Comet Lake PCH cAVS [8086:7270]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 256 bytes
	Interrupt: pin A routed to IRQ 68
	IOMMU group: 10
	Region 0: Memory at 81810000 (64-bit, non-prefetchable) [size=16K]
	Region 4: Memory at 4000000000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: <access denied>
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_soc_avs, snd_sof_pci_intel_cnl, snd_hda_intel

00:1f.4 SMBus [0c05]: Intel Corporation Comet Lake PCH SMBus Controller [8086:06a3]
	Subsystem: Intel Corporation Comet Lake PCH SMBus Controller [8086:7270]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 10
	Region 0: Memory at 8181b000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at 4040 [size=32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801

00:1f.5 Serial bus controller [0c80]: Intel Corporation Comet Lake PCH SPI Controller [8086:06a4]
	Subsystem: Intel Corporation Comet Lake PCH SPI Controller [8086:7270]
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	IOMMU group: 10
	Region 0: Memory at fe010000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: intel-spi
	Kernel modules: spi_intel_pci

01:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Upstream Port of PCI Express Switch [1002:1478] (rev 47) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 1
	Region 0: Memory at 81700000 (32-bit, non-prefetchable) [size=16K]
	Bus: primary=01, secondary=02, subordinate=03, sec-latency=0
	I/O behind bridge: 3000-3fff [size=4K] [16-bit]
	Memory behind bridge: 81600000-816fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: a0000000-b01fffff [size=258M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

02:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Downstream Port of PCI Express Switch [1002:1479] (prog-if 00 [Normal decode])
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Downstream Port of PCI Express Switch [1002:1479]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin A routed to IRQ 30
	IOMMU group: 1
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 3000-3fff [size=4K] [16-bit]
	Memory behind bridge: 81600000-816fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: a0000000-b01fffff [size=258M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

03:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 14 [Radeon RX 5500/5500M / Pro 5500M] [1002:7340] (rev 47) (prog-if 00 [VGA controller])
	Subsystem: Apple Inc. Navi 14 [Radeon RX 5500/5500M / Pro 5500M] [106b:0219]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin A routed to IRQ 255
	IOMMU group: 1
	Region 0: Memory at a0000000 (64-bit, prefetchable) [size=256M]
	Region 2: Memory at b0000000 (64-bit, prefetchable) [size=2M]
	Region 4: I/O ports at 3000 [size=256]
	Region 5: Memory at 81600000 (32-bit, non-prefetchable) [size=512K]
	Expansion ROM at 81680000 [disabled] [size=128K]
	Capabilities: <access denied>
	Kernel modules: amdgpu

03:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 HDMI Audio [1002:ab38]
	Subsystem: Apple Inc. Navi 10 HDMI Audio [106b:0219]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin B routed to IRQ 67
	IOMMU group: 1
	Region 0: Memory at 816a0000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

04:00.0 Mass storage controller [0180]: Apple Inc. ANS2 NVMe Controller [106b:2005] (rev 01) (prog-if 02)
	Subsystem: Apple Inc. ANS2 NVMe Controller [106b:1800]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin ? routed to IRQ 49
	IOMMU group: 11
	Region 0: Memory at b0400000 (64-bit, prefetchable) [size=4M]
	Region 2: Memory at b1400000 (64-bit, prefetchable) [size=512K]
	Region 4: Memory at b1600000 (64-bit, prefetchable) [size=64K]
	Capabilities: <access denied>
	Kernel driver in use: nvme
	Kernel modules: nvme

04:00.1 Non-VGA unclassified device [0000]: Apple Inc. T2 Bridge Controller [106b:1801] (rev 01)
	Subsystem: Apple Inc. T2 Bridge Controller [106b:1801]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	IOMMU group: 11
	Region 0: Memory at b0800000 (64-bit, prefetchable) [size=4M]
	Region 2: Memory at b1480000 (64-bit, prefetchable) [size=512K]
	Region 4: Memory at b1610000 (64-bit, prefetchable) [size=64K]
	Capabilities: <access denied>

04:00.2 Non-VGA unclassified device [0000]: Apple Inc. T2 Secure Enclave Processor [106b:1802] (rev 01)
	Subsystem: Apple Inc. T2 Secure Enclave Processor [106b:1802]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	IOMMU group: 11
	Region 0: Memory at b0c00000 (64-bit, prefetchable) [size=4M]
	Region 2: Memory at b1500000 (64-bit, prefetchable) [size=512K]
	Region 4: Memory at b1620000 (64-bit, prefetchable) [size=64K]
	Capabilities: <access denied>

04:00.3 Multimedia audio controller [0401]: Apple Inc. Apple Audio Device [106b:1803] (rev 01)
	Subsystem: Apple Inc. Apple Audio Device [106b:188b]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	IOMMU group: 11
	Region 0: Memory at b1000000 (64-bit, prefetchable) [disabled] [size=4M]
	Region 2: Memory at b1580000 (64-bit, prefetchable) [disabled] [size=512K]
	Region 4: Memory at b1630000 (64-bit, prefetchable) [disabled] [size=64K]
	Capabilities: <access denied>

05:00.0 Network controller [0280]: Broadcom Inc. and subsidiaries BCM4364 802.11ac Wireless Network Adapter [14e4:4464] (rev 04)
	Subsystem: Apple Inc. BCM4364 802.11ac Wireless Network Adapter [106b:07bf]
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 12
	Region 0: Memory at 81400000 (64-bit, non-prefetchable) [size=32K]
	Region 2: Memory at 81000000 (64-bit, non-prefetchable) [size=4M]
	Capabilities: <access denied>
	Kernel modules: brcmfmac

06:00.0 Ethernet controller [0200]: Broadcom Inc. and subsidiaries NetXtreme BCM57766 Gigabit Ethernet PCIe [14e4:1686] (rev 01)
	Subsystem: Broadcom Inc. and subsidiaries NetXtreme BCM57766 Gigabit Ethernet PCIe [14e4:1686]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin A routed to IRQ 17
	IOMMU group: 13
	Region 0: Memory at b1700000 (64-bit, prefetchable) [size=64K]
	Region 2: Memory at b1710000 (64-bit, prefetchable) [size=64K]
	Expansion ROM at 80000000 [disabled] [size=2K]
	Capabilities: <access denied>
	Kernel driver in use: tg3
	Kernel modules: tg3

07:00.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] [8086:15ea] (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] [8086:0000]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 14
	Bus: primary=07, secondary=08, subordinate=7c, sec-latency=0
	I/O behind bridge: 5000-8fff [size=16K] [16-bit]
	Memory behind bridge: 81900000-8fafffff [size=226M] [32-bit]
	Prefetchable memory behind bridge: b1800000-bf7fffff [size=224M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

08:00.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] [8086:15ea] (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] [8086:0000]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 15
	Bus: primary=08, secondary=09, subordinate=09, sec-latency=0
	I/O behind bridge: [disabled] [32-bit]
	Memory behind bridge: 81a00000-81afffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

08:01.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] [8086:15ea] (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] [8086:0000]
	Physical Slot: 1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 31
	IOMMU group: 16
	Bus: primary=08, secondary=0b, subordinate=43, sec-latency=0
	I/O behind bridge: 5000-6fff [size=8K] [16-bit]
	Memory behind bridge: 81b00000-88afffff [size=112M] [32-bit]
	Prefetchable memory behind bridge: b1800000-b87fffff [size=112M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

08:02.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] [8086:15ea] (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] [8086:0000]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	IOMMU group: 17
	Bus: primary=08, secondary=0a, subordinate=0a, sec-latency=0
	I/O behind bridge: [disabled] [32-bit]
	Memory behind bridge: 81900000-819fffff [size=1M] [32-bit]
	Prefetchable memory behind bridge: [disabled] [64-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

08:04.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] [8086:15ea] (rev 06) (prog-if 00 [Normal decode])
	Subsystem: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] [8086:0000]
	Physical Slot: 2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 32
	IOMMU group: 18
	Bus: primary=08, secondary=44, subordinate=7c, sec-latency=0
	I/O behind bridge: 7000-8fff [size=8K] [16-bit]
	Memory behind bridge: 88b00000-8fafffff [size=112M] [32-bit]
	Prefetchable memory behind bridge: b8800000-bf7fffff [size=112M] [32-bit]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

09:00.0 System peripheral [0880]: Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 4C 2018] [8086:15eb] (rev 06)
	Subsystem: Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 4C 2018] [8086:0000]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 19
	Region 0: Memory at 81a00000 (32-bit, non-prefetchable) [size=256K]
	Region 1: Memory at 81a40000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: thunderbolt
	Kernel modules: thunderbolt

0a:00.0 USB controller [0c03]: Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 4C 2018] [8086:15ec] (rev 06) (prog-if 30 [XHCI])
	Subsystem: Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 4C 2018] [8086:0000]
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 41
	IOMMU group: 20
	Region 0: Memory at 81900000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <access denied>
	Kernel driver in use: xhci_hcd 

