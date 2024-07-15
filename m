Return-Path: <linux-pci+bounces-10270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83563931664
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 16:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780241C20D4B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6D4433B3;
	Mon, 15 Jul 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7FyWfrR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163072AD18;
	Mon, 15 Jul 2024 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052605; cv=none; b=W04wqkoapac+bfrlwleHzP01Af2M7gQVp3DptOjJQw0s13xPt0ih8WFBHk6VMnhaLvOXkHTuQHkL1CH4Mxk6fIIgmPfMYfaQ6C8PAGkFZvxSyxt/93WJ28ZcE5kevqBX15quuWVsIwITH4KlT4G0lXjE9Z6FzmdRlN5Dtp/VV4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052605; c=relaxed/simple;
	bh=Pk57MI3jO4xSkQSW4nKl0SGTDju4WXj/DgLsoV/xxLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/bxh9GbGN19+qwBLm1J53vigrljfI1R99GYh+QVm3/o8IpwFIuPRNQsYR4ULVrd7p+gOFGxR1cs5t0VUU9sv4XOiU8417RlkIedjAC7CObAB3+e5lJPNPo4cfoYVA2AoR8wZHFCR8Bfj5oxdgZnytPC9uwhnMt8MYahOFXNygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7FyWfrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B08C32782;
	Mon, 15 Jul 2024 14:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721052604;
	bh=Pk57MI3jO4xSkQSW4nKl0SGTDju4WXj/DgLsoV/xxLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7FyWfrRhDhl4DFutpfyHL6+1J4TPwh9ni4iJdOdko32R4inVB7hEr0+iFNvTK6nI
	 DYqrelA+s8hCshp3QqueSh0I/9LEvh0kk/VnV0N/k2zvl7yZLOf1mok9uF8D7/8slM
	 h04xm2MhFnHik3NEL8smEGGScubS7IMBV42WMAZZofUIdMkOVHRltzRRmCFJms2Nvd
	 O3EWE4loQ6SX+EcvnnhFlp1PW09r7oepU5WwGV5TYT5+CWoTawLuYzP3waKxaDk3CL
	 2EMGMd2wCrT6fqEai9EwmnRszi4c/TPp2YXTKkvl7qYvC+5BpYQNb4lFCPa8pc6S5E
	 9RqlvTX+e19AA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sTMOv-000000007zU-1GHx;
	Mon, 15 Jul 2024 16:10:01 +0200
Date: Mon, 15 Jul 2024 16:10:01 +0200
From: Johan Hovold <johan@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	anna-maria@linutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
	rdunlap@infradead.org, vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com,
	kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
	rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
	lorenzo.pieralisi@arm.com, jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org, robin.murphy@arm.com,
	lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org,
	vkoul@kernel.org, okaya@kernel.org, agross@kernel.org,
	andersson@kernel.org, mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com,
	shivamurthy.shastri@linutronix.de
Subject: Re: [patch V4 00/21] genirq, irqchip: Convert ARM MSI handling to
 per device MSI domains
Message-ID: <ZpUtuS65AQTJ0kPO@hovoldconsulting.com>
References: <20240623142137.448898081@linutronix.de>
 <ZpUFl4uMCT8YwkUE@hovoldconsulting.com>
 <878qy26cd6.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qy26cd6.wl-maz@kernel.org>

On Mon, Jul 15, 2024 at 01:58:13PM +0100, Marc Zyngier wrote:
> On Mon, 15 Jul 2024 12:18:47 +0100,
> Johan Hovold <johan@kernel.org> wrote:
> > On Sun, Jun 23, 2024 at 05:18:31PM +0200, Thomas Gleixner wrote:
> > > This is version 4 of the series to convert ARM MSI handling over to
> > > per device MSI domains.

> > This series only showed up in linux-next last Friday and broke interrupt
> > handling on Qualcomm platforms like sc8280xp (e.g. Lenovo ThinkPad X13s)
> > and x1e80100 that use the GIC ITS for PCIe MSIs.
> > 
> > I've applied the series (21 commits from linux-next) on top of 6.10 and
> > can confirm that the breakage is caused by commits:
> > 
> > 	3d1c927c08fc ("irqchip/gic-v3-its: Switch platform MSI to MSI parent")
> > 	233db05bc37f ("irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]")
> > 
> > Applying the series up until the change before 3d1c927c08fc unbreaks the
> > wifi on one machine:
> > 
> > 	ath11k_pci 0006:01:00.0: failed to enable msi: -22
> > 	ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -22
> >
> > and backing up until the commit before 233db05bc37f makes the NVMe come
> > up again during boot on another.
> > 
> > I have not tried to debug this further.
> 
> I need a few things from you though, because you're not giving much to
> help you (and I'm travelling, which doesn't help).

Yeah, this was just an early heads up.

> Can you at least investigate what in ath11k_pci_alloc_msi() causes the
> wifi driver to be upset? Does it normally use a single MSI vector or
> MSI-X? How about your nVME device?

It uses multiple vectors, but now it falls back to trying to allocate a
single one and even that fails with -ENOSPC:

	ath11k_pci 0006:01:00.0: ath11k_pci_alloc_msi - requesting one vector failed: -28

Similar for the NVMe, it uses multiple vectors normally, but now only
the AER interrupts appears to be allocated for each controller and there
is a GICv3 interrupt for the NVMe:

208:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0006:00:00.0   0 Edge      PCIe PME, aerdrv
212:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0004:00:00.0   0 Edge      PCIe PME, aerdrv
214:        161          0          0          0          0          0          0          0     GICv3 562 Level     nvme0q0, nvme0q1
215:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0002:00:00.0   0 Edge      PCIe PME, aerdrv

Next boot, after disabling PCIe controller async probing, it's an MSI-X?!:

201:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0006:00:00.0   0 Edge      PCIe PME, aerdrv
203:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0004:00:00.0   0 Edge      PCIe PME, aerdrv
205:          0          0          0          0          0          0          0          0  ITS-PCI-MSI-0002:00:00.0   0 Edge      PCIe PME, aerdrv
206:          0          0          0          0          0          0          0          0  ITS-PCI-MSIX-0002:01:00.0   0 Edge      nvme0q0

This time ath11k vector allocation succeeded, but the driver times out
eventually:

[    8.984619] ath11k_pci 0006:01:00.0: MSI vectors: 32
[   29.690841] ath11k_pci 0006:01:00.0: failed to power up mhi: -110
[   29.697136] ath11k_pci 0006:01:00.0: failed to start mhi: -110
[   29.703153] ath11k_pci 0006:01:00.0: failed to power up :-110
[   29.732144] ath11k_pci 0006:01:00.0: failed to create soc core: -110
[   29.738694] ath11k_pci 0006:01:00.0: failed to init core: -110
[   32.841758] ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -110

> It would also help if you could define the DEBUG symbol at the very
> top of irq-gic-v3-its.c and report the debug information that the ITS
> driver dumps.

See below (with synchronous probing of the pcie controllers).

Johan

[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: 960 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000017a60000
[    0.000000] ITS [mem 0x17a40000-0x17a5ffff]
[    0.000000] ITS@0x0000000017a40000: allocated 8192 Devices @100100000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x0000000017a40000: allocated 32768 Interrupt Collections @100110000 (flat, esz 2, psz 64K, shr 1)
[    0.000000] GICv3: using LPI property table @0x0000000100120000
[    0.000000] ITS: Allocator initialized for 57344 LPIs
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000100130000

[    0.010428] GICv3: CPU1: found redistributor 100 region 0:0x0000000017a80000
[    0.010438] GICv3: CPU1: using allocated LPI pending table @0x0000000100140000
[    0.010477] CPU1: Booted secondary processor 0x0000000100 [0x410fd4b0]
[    0.011496] Detected PIPT I-cache on CPU2
[    0.011535] GICv3: CPU2: found redistributor 200 region 0:0x0000000017aa0000
[    0.011545] GICv3: CPU2: using allocated LPI pending table @0x0000000100150000
[    0.011576] CPU2: Booted secondary processor 0x0000000200 [0x410fd4b0]
[    0.012593] Detected PIPT I-cache on CPU3
[    0.012631] GICv3: CPU3: found redistributor 300 region 0:0x0000000017ac0000
[    0.012641] GICv3: CPU3: using allocated LPI pending table @0x0000000100160000
[    0.012671] CPU3: Booted secondary processor 0x0000000300 [0x410fd4b0]
[    0.015590] Detected PIPT I-cache on CPU4
[    0.015637] GICv3: CPU4: found redistributor 400 region 0:0x0000000017ae0000
[    0.015647] GICv3: CPU4: using allocated LPI pending table @0x0000000100170000
[    0.015675] CPU4: Booted secondary processor 0x0000000400 [0x410fd4c0]
[    0.016698] Detected PIPT I-cache on CPU5
[    0.016733] GICv3: CPU5: found redistributor 500 region 0:0x0000000017b00000
[    0.016742] GICv3: CPU5: using allocated LPI pending table @0x0000000100180000
[    0.016772] CPU5: Booted secondary processor 0x0000000500 [0x410fd4c0]
[    0.020807] Detected PIPT I-cache on CPU6
[    0.020841] GICv3: CPU6: found redistributor 600 region 0:0x0000000017b20000
[    0.020851] GICv3: CPU6: using allocated LPI pending table @0x0000000100190000
[    0.020879] CPU6: Booted secondary processor 0x0000000600 [0x410fd4c0]
[    0.021878] Detected PIPT I-cache on CPU7
[    0.021914] GICv3: CPU7: found redistributor 700 region 0:0x0000000017b40000
[    0.021922] GICv3: CPU7: using allocated LPI pending table @0x00000001001a0000
[    0.021952] CPU7: Booted secondary processor 0x0000000700 [0x410fd4c0]

[    8.358586] qcom-pcie 1c00000.pcie: host bridge /soc@0/pcie@1c00000 ranges:
[    8.365787] qcom-pcie 1c00000.pcie:       IO 0x0030200000..0x00302fffff -> 0x0000000000
[    8.381670] qcom-pcie 1c00000.pcie:      MEM 0x0030300000..0x0031ffffff -> 0x0030300000
[    8.507519] qcom-pcie 1c00000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 1024G
[    8.603797] qcom-pcie 1c00000.pcie: PCIe Gen.2 x1 link up
[    8.610023] qcom-pcie 1c00000.pcie: PCI host bridge to bus 0006:00
[    8.616805] pci_bus 0006:00: root bus resource [bus 00-ff]
[    8.622872] pci_bus 0006:00: root bus resource [io  0x0000-0xfffff]
[    8.629844] pci_bus 0006:00: root bus resource [mem 0x30300000-0x31ffffff]
[    8.636981] pci 0006:00:00.0: [17cb:010e] type 01 class 0x060400 PCIe Root Port
[    8.655493] pci 0006:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
[    8.672909] pci 0006:00:00.0: PCI bridge to [bus 01-ff]
[    8.688721] pci 0006:00:00.0:   bridge window [io  0x0000-0x0fff]
[    8.703805] pci 0006:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    8.719789] pci 0006:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    8.736680] pci 0006:00:00.0: PME# supported from D0 D3hot D3cold
[    8.745548] pci 0006:01:00.0: [17cb:1103] type 00 class 0x028000 PCIe Endpoint
[    8.745646] pci 0006:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
[    8.746274] pci 0006:01:00.0: PME# supported from D0 D3hot D3cold
[    8.746442] pci 0006:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 0006:00:00.0 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
[    8.836195] pci 0006:00:00.0: bridge window [mem 0x30400000-0x305fffff]: assigned
[    8.853287] pci 0006:00:00.0: BAR 0 [mem 0x30300000-0x30300fff]: assigned
[    8.870163] pci 0006:01:00.0: BAR 0 [mem 0x30400000-0x305fffff 64bit]: assigned
[    8.887617] pci 0006:00:00.0: PCI bridge to [bus 01-ff]
[    8.902850] pci 0006:00:00.0:   bridge window [mem 0x30400000-0x305fffff]
[    8.933586] ITS: alloc 8192:32
[    8.933599] ITT 32 entries, 5 bits
[    8.951573] ID:0 pID:8192 vID:201
[    8.951585] ID:1 pID:8193 vID:202
[    8.951591] ID:2 pID:8194 vID:203
[    8.951597] ID:3 pID:8195 vID:204
[    8.951603] ID:4 pID:8196 vID:205
[    8.951609] ID:5 pID:8197 vID:206
[    8.951615] ID:6 pID:8198 vID:207
[    8.951621] ID:7 pID:8199 vID:208
[    8.951627] ID:8 pID:8200 vID:209
[    8.951633] ID:9 pID:8201 vID:210
[    8.951639] ID:10 pID:8202 vID:211
[    8.951645] ID:11 pID:8203 vID:212
[    8.951650] ID:12 pID:8204 vID:213
[    8.951656] ID:13 pID:8205 vID:214
[    8.951662] ID:14 pID:8206 vID:215
[    8.951667] ID:15 pID:8207 vID:216
[    8.951673] ID:16 pID:8208 vID:217
[    8.951679] ID:17 pID:8209 vID:218
[    8.951685] ID:18 pID:8210 vID:219
[    8.951691] ID:19 pID:8211 vID:220
[    8.951696] ID:20 pID:8212 vID:221
[    8.951702] ID:21 pID:8213 vID:222
[    8.951708] ID:22 pID:8214 vID:223
[    8.951714] ID:23 pID:8215 vID:224
[    8.951720] ID:24 pID:8216 vID:225
[    8.951725] ID:25 pID:8217 vID:226
[    8.951772] ID:26 pID:8218 vID:227
[    8.951778] ID:27 pID:8219 vID:228
[    8.951784] ID:28 pID:8220 vID:229
[    8.951790] ID:29 pID:8221 vID:230
[    8.951796] ID:30 pID:8222 vID:231
[    8.951802] ID:31 pID:8223 vID:232
[    8.951919] IRQ201 -> 0-7 CPU0
[    8.951940] IRQ202 -> 0-7 CPU1
[    8.951952] IRQ203 -> 0-7 CPU2
[    8.951963] IRQ204 -> 0-7 CPU3
[    8.951975] IRQ205 -> 0-7 CPU4
[    8.951987] IRQ206 -> 0-7 CPU5
[    8.951998] IRQ207 -> 0-7 CPU6
[    8.952010] IRQ208 -> 0-7 CPU7
[    8.952022] IRQ209 -> 0-7 CPU0
[    8.952033] IRQ210 -> 0-7 CPU1
[    8.952045] IRQ211 -> 0-7 CPU2
[    8.952056] IRQ212 -> 0-7 CPU3
[    8.952068] IRQ213 -> 0-7 CPU4
[    8.952079] IRQ214 -> 0-7 CPU5
[    8.952091] IRQ215 -> 0-7 CPU6
[    8.952103] IRQ216 -> 0-7 CPU7
[    8.952115] IRQ217 -> 0-7 CPU0
[    8.952126] IRQ218 -> 0-7 CPU1
[    8.952138] IRQ219 -> 0-7 CPU2
[    8.952150] IRQ220 -> 0-7 CPU3
[    8.952162] IRQ221 -> 0-7 CPU4
[    8.952174] IRQ222 -> 0-7 CPU5
[    8.952185] IRQ223 -> 0-7 CPU6
[    8.952197] IRQ224 -> 0-7 CPU7
[    8.952209] IRQ225 -> 0-7 CPU0
[    8.952220] IRQ226 -> 0-7 CPU1
[    8.952232] IRQ227 -> 0-7 CPU2
[    8.952244] IRQ228 -> 0-7 CPU3
[    8.952255] IRQ229 -> 0-7 CPU4
[    8.952267] IRQ230 -> 0-7 CPU5
[    8.952278] IRQ231 -> 0-7 CPU6
[    8.952290] IRQ232 -> 0-7 CPU7
[    8.954072] ITS: alloc 8192:32
[    8.954081] ITT 32 entries, 5 bits
[    8.954128] ID:0 pID:8192 vID:201
[    8.954137] IRQ201 -> 0-7 CPU0
[    8.954328] IRQ201 -> 0-7 CPU0
[    8.954357] pcieport 0006:00:00.0: PME: Signaling with IRQ 201
[    8.960980] pcieport 0006:00:00.0: AER: enabled with IRQ 201
[    8.967607] ath11k_pci 0006:01:00.0: BAR 0 [mem 0x30400000-0x305fffff 64bit]: assigned
[    8.976146] ath11k_pci 0006:01:00.0: enabling device (0000 -> 0002)
[    8.983071] ITS: alloc 8224:32
[    8.983080] ITT 32 entries, 5 bits
[    8.983842] ID:0 pID:8224 vID:202
[    8.983849] ID:1 pID:8225 vID:203
[    8.983855] ID:2 pID:8226 vID:204
[    8.983861] ID:3 pID:8227 vID:205
[    8.983867] ID:4 pID:8228 vID:206
[    8.983873] ID:5 pID:8229 vID:207
[    8.983878] ID:6 pID:8230 vID:208
[    8.983884] ID:7 pID:8231 vID:209
[    8.983890] ID:8 pID:8232 vID:210
[    8.983895] ID:9 pID:8233 vID:211
[    8.983901] ID:10 pID:8234 vID:212
[    8.983907] ID:11 pID:8235 vID:213
[    8.983913] ID:12 pID:8236 vID:214
[    8.983919] ID:13 pID:8237 vID:215
[    8.983925] ID:14 pID:8238 vID:216
[    8.983931] ID:15 pID:8239 vID:217
[    8.983937] ID:16 pID:8240 vID:218
[    8.983942] ID:17 pID:8241 vID:219
[    8.983948] ID:18 pID:8242 vID:220
[    8.983954] ID:19 pID:8243 vID:221
[    8.983960] ID:20 pID:8244 vID:222
[    8.983965] ID:21 pID:8245 vID:223
[    8.983971] ID:22 pID:8246 vID:224
[    8.983977] ID:23 pID:8247 vID:225
[    8.983983] ID:24 pID:8248 vID:226
[    8.983989] ID:25 pID:8249 vID:227
[    8.983995] ID:26 pID:8250 vID:228
[    8.984000] ID:27 pID:8251 vID:229
[    8.984006] ID:28 pID:8252 vID:230
[    8.984012] ID:29 pID:8253 vID:231
[    8.984018] ID:30 pID:8254 vID:232
[    8.984024] ID:31 pID:8255 vID:233
[    8.984102] IRQ202 -> 0-7 CPU1
[    8.984148] IRQ203 -> 0-7 CPU2
[    8.984160] IRQ204 -> 0-7 CPU3
[    8.984172] IRQ205 -> 0-7 CPU4
[    8.984184] IRQ206 -> 0-7 CPU5
[    8.984196] IRQ207 -> 0-7 CPU6
[    8.984208] IRQ208 -> 0-7 CPU7
[    8.984220] IRQ209 -> 0-7 CPU0
[    8.984231] IRQ210 -> 0-7 CPU1
[    8.984243] IRQ211 -> 0-7 CPU2
[    8.984255] IRQ212 -> 0-7 CPU3
[    8.984267] IRQ213 -> 0-7 CPU4
[    8.984279] IRQ214 -> 0-7 CPU5
[    8.984291] IRQ215 -> 0-7 CPU6
[    8.984303] IRQ216 -> 0-7 CPU7
[    8.984315] IRQ217 -> 0-7 CPU0
[    8.984326] IRQ218 -> 0-7 CPU1
[    8.984338] IRQ219 -> 0-7 CPU2
[    8.984350] IRQ220 -> 0-7 CPU3
[    8.984362] IRQ221 -> 0-7 CPU4
[    8.984373] IRQ222 -> 0-7 CPU5
[    8.984385] IRQ223 -> 0-7 CPU6
[    8.984398] IRQ224 -> 0-7 CPU7
[    8.984409] IRQ225 -> 0-7 CPU0
[    8.984422] IRQ226 -> 0-7 CPU1
[    8.984434] IRQ227 -> 0-7 CPU2
[    8.984445] IRQ228 -> 0-7 CPU3
[    8.984457] IRQ229 -> 0-7 CPU4
[    8.984469] IRQ230 -> 0-7 CPU5
[    8.984481] IRQ231 -> 0-7 CPU6
[    8.984492] IRQ232 -> 0-7 CPU7
[    8.984504] IRQ233 -> 0-7 CPU0
[    8.984619] ath11k_pci 0006:01:00.0: MSI vectors: 32
[    8.990070] ath11k_pci 0006:01:00.0: wcn6855 hw2.0
[    8.998289] IRQ202 -> 0-7 CPU1
[    8.998348] IRQ203 -> 0-7 CPU2
[    8.998376] IRQ204 -> 0-7 CPU3
[    9.001890] IRQ205 -> 0-7 CPU4
[    9.001923] IRQ206 -> 0-7 CPU5
[    9.001953] IRQ207 -> 0-7 CPU6
[    9.001977] IRQ208 -> 0-7 CPU7
[    9.002003] IRQ209 -> 0-7 CPU0
[    9.002031] IRQ210 -> 0-7 CPU1
[    9.002055] IRQ211 -> 0-7 CPU2
[    9.002117] IRQ216 -> 0-7 CPU7
[    9.002168] IRQ217 -> 0-7 CPU0
[    9.002210] IRQ218 -> 0-7 CPU1
[    9.002257] IRQ220 -> 0-7 CPU3
[    9.002296] IRQ221 -> 0-7 CPU4
[    9.002337] IRQ222 -> 0-7 CPU5
[    9.002381] IRQ223 -> 0-7 CPU6
[    9.002421] IRQ224 -> 0-7 CPU7
[    9.002460] IRQ225 -> 0-7 CPU0
[    9.002499] IRQ226 -> 0-7 CPU1
[    9.162382] mhi mhi0: Requested to power ON
[    9.167114] mhi mhi0: Power on setup success

[   29.680356] mhi mhi0: Device link is not accessible
[   29.685437] mhi mhi0: MHI did not enter READY state
[   29.690841] ath11k_pci 0006:01:00.0: failed to power up mhi: -110
[   29.697136] ath11k_pci 0006:01:00.0: failed to start mhi: -110
[   29.703153] ath11k_pci 0006:01:00.0: failed to power up :-110
[   29.732144] ath11k_pci 0006:01:00.0: failed to create soc core: -110
[   29.738694] ath11k_pci 0006:01:00.0: failed to init core: -110
[   32.841758] ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -110
[   32.852799] qcom-pcie 1c10000.pcie: supply vdda not found, using dummy regulator
[   32.860924] qcom-pcie 1c10000.pcie: host bridge /soc@0/pcie@1c10000 ranges:
[   32.868157] qcom-pcie 1c10000.pcie:       IO 0x0034200000..0x00342fffff -> 0x0000000000
[   32.876428] qcom-pcie 1c10000.pcie:      MEM 0x0034300000..0x0035ffffff -> 0x0034300000
[   33.001705] qcom-pcie 1c10000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 1024G
[   33.111456] qcom-pcie 1c10000.pcie: PCIe Gen.3 x2 link up
[   33.117554] qcom-pcie 1c10000.pcie: PCI host bridge to bus 0004:00
[   33.124000] pci_bus 0004:00: root bus resource [bus 00-ff]
[   33.129745] pci_bus 0004:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x0000-0xfffff])
[   33.139324] pci_bus 0004:00: root bus resource [mem 0x34300000-0x35ffffff]
[   33.146525] pci 0004:00:00.0: [17cb:010e] type 01 class 0x060400 PCIe Root Port
[   33.154167] pci 0004:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
[   33.160373] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[   33.165804] pci 0004:00:00.0:   bridge window [io  0x100000-0x100fff]
[   33.172482] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   33.179515] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   33.187622] pci 0004:00:00.0: PME# supported from D0 D3hot D3cold
[   33.195555] pci 0004:01:00.0: [17cb:0306] type 00 class 0xff0000 PCIe Endpoint
[   33.203462] pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[   33.210163] pci 0004:01:00.0: BAR 2 [mem 0x00000000-0x00000fff 64bit]
[   33.217379] pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
[   33.223825] pci 0004:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0004:00:00.0 (capable of 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
[   33.251876] pci 0004:00:00.0: bridge window [mem 0x34300000-0x343fffff]: assigned
[   33.259599] pci 0004:00:00.0: BAR 0 [mem 0x34400000-0x34400fff]: assigned
[   33.266621] pci 0004:01:00.0: BAR 0 [mem 0x34300000-0x34300fff 64bit]: assigned
[   33.274186] pci 0004:01:00.0: BAR 2 [mem 0x34301000-0x34301fff 64bit]: assigned
[   33.281748] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[   33.287133] pci 0004:00:00.0:   bridge window [mem 0x34300000-0x343fffff]
[   33.294322] Reusing ITT for devID 0
[   33.296005] Reusing ITT for devID 0
[   33.296053] ID:1 pID:8193 vID:203
[   33.296066] IRQ203 -> 0-7 CPU1
[   33.296176] IRQ203 -> 0-7 CPU1
[   33.296240] pcieport 0004:00:00.0: PME: Signaling with IRQ 203
[   33.302538] pcieport 0004:00:00.0: AER: enabled with IRQ 203
[   33.308587] mhi-pci-generic 0004:01:00.0: MHI PCI device found: foxconn-sdx55
[   33.315945] mhi-pci-generic 0004:01:00.0: BAR 0 [mem 0x34300000-0x34300fff 64bit]: assigned
[   33.324583] mhi-pci-generic 0004:01:00.0: enabling device (0000 -> 0002)
[   33.331610] ITS: alloc 8224:8
[   33.331619] ITT 8 entries, 3 bits
[   33.331750] ID:0 pID:8224 vID:204
[   33.331756] ID:1 pID:8225 vID:205
[   33.331762] ID:2 pID:8226 vID:206
[   33.331769] ID:3 pID:8227 vID:207
[   33.331774] ID:4 pID:8228 vID:208
[   33.331791] IRQ204 -> 0-7 CPU2
[   33.331837] IRQ205 -> 0-7 CPU3
[   33.331848] IRQ206 -> 0-7 CPU4
[   33.331860] IRQ207 -> 0-7 CPU5
[   33.331872] IRQ208 -> 0-7 CPU6
[   33.332711] IRQ204 -> 0-7 CPU2
[   33.333016] IRQ205 -> 0-7 CPU3
[   33.333042] IRQ206 -> 0-7 CPU4
[   33.333066] IRQ207 -> 0-7 CPU5
[   33.333090] IRQ208 -> 0-7 CPU6
[   33.335976] mhi mhi0: Requested to power ON
[   33.340327] mhi mhi0: Power on setup success
[   54.242353] mhi-pci-generic 0004:01:00.0: failed to power up MHI controller
[   54.251547] mhi-pci-generic 0004:01:00.0: probe with driver mhi-pci-generic failed with error -110
[   54.262662] qcom-pcie 1c20000.pcie: supply vdda not found, using dummy regulator
[   54.270794] qcom-pcie 1c20000.pcie: host bridge /soc@0/pcie@1c20000 ranges:
[   54.278042] qcom-pcie 1c20000.pcie:       IO 0x003c200000..0x003c2fffff -> 0x0000000000
[   54.286340] qcom-pcie 1c20000.pcie:      MEM 0x003c300000..0x003dffffff -> 0x003c300000
[   54.409356] qcom-pcie 1c20000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 1024G
[   54.519604] qcom-pcie 1c20000.pcie: PCIe Gen.3 x4 link up
[   54.525609] qcom-pcie 1c20000.pcie: PCI host bridge to bus 0002:00
[   54.532017] pci_bus 0002:00: root bus resource [bus 00-ff]
[   54.537732] pci_bus 0002:00: root bus resource [io  0x200000-0x2fffff] (bus address [0x0000-0xfffff])
[   54.547830] pci_bus 0002:00: root bus resource [mem 0x3c300000-0x3dffffff]
[   54.555523] pci 0002:00:00.0: [17cb:010e] type 01 class 0x060400 PCIe Root Port
[   54.563629] pci 0002:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
[   54.570244] pci 0002:00:00.0: PCI bridge to [bus 01-ff]
[   54.576099] pci 0002:00:00.0:   bridge window [io  0x200000-0x200fff]
[   54.583121] pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   54.590473] pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   54.598841] pci 0002:00:00.0: PME# supported from D0 D3hot D3cold
[   54.606657] pci 0002:01:00.0: [1e0f:0001] type 00 class 0x010802 PCIe Endpoint
[   54.614458] pci 0002:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[   54.621900] pci 0002:01:00.0: PME# supported from D0 D3hot
[   54.635232] sd 0:0:0:0: [sda] Starting disk
[   54.641117] pci 0002:00:00.0: bridge window [mem 0x3c300000-0x3c3fffff]: assigned
[   54.649086] pci 0002:00:00.0: BAR 0 [mem 0x3c400000-0x3c400fff]: assigned
[   54.656299] pci 0002:01:00.0: BAR 0 [mem 0x3c300000-0x3c303fff 64bit]: assigned
[   54.664083] pci 0002:00:00.0: PCI bridge to [bus 01-ff]
[   54.669688] pci 0002:00:00.0:   bridge window [mem 0x3c300000-0x3c3fffff]
[   54.677113] Reusing ITT for devID 0
[   54.678960] Reusing ITT for devID 0
[   54.678994] ID:2 pID:8194 vID:205
[   54.679005] IRQ205 -> 0-7 CPU2
[   54.679103] IRQ205 -> 0-7 CPU2
[   54.679123] pcieport 0002:00:00.0: PME: Signaling with IRQ 205
[   54.685994] pcieport 0002:00:00.0: AER: enabled with IRQ 205
[   54.693042] nvme nvme0: pci function 0002:01:00.0
[   54.698150] nvme 0002:01:00.0: enabling device (0000 -> 0002)
[   54.704457] Reusing ITT for devID 100
[   54.704500] ID:0 pID:8224 vID:206
[   54.704509] IRQ206 -> 0-7 CPU3
[   54.706919] IRQ206 -> 0-7 CPU3

[  115.695904] nvme nvme0: I/O tag 0 (1000) QID 0 timeout, completion polled
[  177.135829] nvme nvme0: I/O tag 1 (1001) QID 0 timeout, completion polled
[  238.575830] nvme nvme0: I/O tag 2 (1002) QID 0 timeout, completion polled
[  300.023834] nvme nvme0: I/O tag 3 (1003) QID 0 timeout, completion polled
[  300.055992] nvme nvme0: allocated 61 MiB host memory buffer.

