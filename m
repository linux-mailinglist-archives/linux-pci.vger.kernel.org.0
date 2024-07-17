Return-Path: <linux-pci+bounces-10424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2469337D1
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 09:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F19D1C22387
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 07:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93A814267;
	Wed, 17 Jul 2024 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+O3espN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90499E57E;
	Wed, 17 Jul 2024 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201020; cv=none; b=ulZ4O0lcNzGQg5UKFanwtfhX/GH/HxZZcke3g9FkD2A8jDQSP2nyoF+/0tiAX0gFQar8Gd9SL3HSonxDMWgeVt0VYXJGntsiRLyDOzYF32/VXwJ7WOCKqb9hJf/oudEXnFPdZ5j9AMebn/KeOBaoqS6Hy2D4J1n/kOj3qF1sUUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201020; c=relaxed/simple;
	bh=y0Mt2jzwkcyEal66Bo9e3kykvixgYYMx/FqRNf2Z2uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxPPTQxsBZxGsejzlzv+SSjzFhiiUlpLEhTVpYTNQdNh7C2GDe/FYsJPjOuxufZXCO2b3hKxYvRj6gU7vPFKqjf0OLT8Mz2vaeaoVnlAxE6t+s7vJ8ts9tve7GBp37UQgrynbOQI/vlfuIzrz8FyzpVP3fmjVCPH9DtZ3kbcHnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+O3espN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8FEC32782;
	Wed, 17 Jul 2024 07:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721201020;
	bh=y0Mt2jzwkcyEal66Bo9e3kykvixgYYMx/FqRNf2Z2uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+O3espNZ2uV4iPYnz2A6caLnd/VLn32/pOovt5ukmmC7VncXJ2qPEhU1HPYn3ZNO
	 lfURJGToqJ2kDeXUQYvt5whapY4KMpwuvzr3EJP7F0oeM5KAHj3yxEmOjCktqO1fqZ
	 t+VvBniIGLgmxLOC3QayuFjovGqoM/BeL4DyBVP+7kYQ2w+4tol2M+IFXFfDv9ByvO
	 HmGu18PczxBnGJWqeoLnCcWO0vp2I5Hgh2AFHp8T0WQLO466Bl88Cz8pVlqwjw29Xa
	 I4g2FiU5LhNJ2b4ocApw2sPBvQdihIyp43NVDjtS+8mbU6u0y+vztzNB6J5q1GAjXt
	 RYv50UY05Pwmw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sTz0l-000000007zI-3W4w;
	Wed, 17 Jul 2024 09:23:40 +0200
Date: Wed, 17 Jul 2024 09:23:39 +0200
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
	shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com
Subject: Re: [patch V4 00/21] genirq, irqchip: Convert ARM MSI handling to
 per device MSI domains
Message-ID: <Zpdxe4ce-XwDEods@hovoldconsulting.com>
References: <20240623142137.448898081@linutronix.de>
 <ZpUFl4uMCT8YwkUE@hovoldconsulting.com>
 <878qy26cd6.wl-maz@kernel.org>
 <ZpUtuS65AQTJ0kPO@hovoldconsulting.com>
 <86r0bt39zm.wl-maz@kernel.org>
 <ZpaJaM1G721FdLFn@hovoldconsulting.com>
 <86plrd2o5o.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86plrd2o5o.wl-maz@kernel.org>

On Tue, Jul 16, 2024 at 07:21:39PM +0100, Marc Zyngier wrote:
> On Tue, 16 Jul 2024 15:53:28 +0100,
> Johan Hovold <johan@kernel.org> wrote:
> > On Tue, Jul 16, 2024 at 11:30:05AM +0100, Marc Zyngier wrote:
> > > On Mon, 15 Jul 2024 15:10:01 +0100,
> > > Johan Hovold <johan@kernel.org> wrote:
> > > > On Mon, Jul 15, 2024 at 01:58:13PM +0100, Marc Zyngier wrote:
> > > > > On Mon, 15 Jul 2024 12:18:47 +0100,
> > > > > Johan Hovold <johan@kernel.org> wrote:

> > > > > > This series only showed up in linux-next last Friday and broke interrupt
> > > > > > handling on Qualcomm platforms like sc8280xp (e.g. Lenovo ThinkPad X13s)
> > > > > > and x1e80100 that use the GIC ITS for PCIe MSIs.
> > > > > > 
> > > > > > I've applied the series (21 commits from linux-next) on top of 6.10 and
> > > > > > can confirm that the breakage is caused by commits:
> > > > > > 
> > > > > > 	3d1c927c08fc ("irqchip/gic-v3-its: Switch platform MSI to MSI parent")
> > > > > > 	233db05bc37f ("irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]")
> > > > > > 
> > > > > > Applying the series up until the change before 3d1c927c08fc unbreaks the
> > > > > > wifi on one machine:
> > > > > > 
> > > > > > 	ath11k_pci 0006:01:00.0: failed to enable msi: -22
> > > > > > 	ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -22
> > 
> > Correction, this doesn't fix the wifi, but I'm not seeing these errors
> > with the commit before cc23d1dfc959 as the ath11k driver doesn't get

[ This was supposed to say 3d1c927c08fc, which is the mainline hash,
sorry. ]

> > this far (or doesn't probe at all).
> 
> I think we need to track one thing at a time. The wifi and nvme
> problems seem subtly different... Which is the exact commit that
> breaks nvme on your machine?

Yeah, forget about 3d1c927c08fc for now, which may have been a red
herring since we're also appear to be dealing with some sort of race and
(some) symptoms keep changing from boot to boot. The only thing that for
certain is that the series breaks MSI and that the NVMe breaks with
commit 233db05bc37f ("irqchip/gic-v3-its: Provide MSI parent for
PCI/MSI[-X]").

> > > So is this issue actually tied to the async probing? Does it always
> > > work if you disable it?
> > 
> > There seem to multiple issues here.
> > 
> > With the full series applied and normal async (i.e. parallel) probing of
> > the PCIe controllers I sometimes see allocation failing with -ENOSPC
> > (e.g. the above ath11k errors). This seems to indicate broken locking
> > somewhere.
> 
> Your log doesn't support this theory. At least not from an ITS
> perspective, as it keeps dishing out INTIDs (and it is very hard to
> run out of IRQs with the ITS).

The log I shared was with synchronous probing which takes parallel
allocation out of the equation (and gives more readable logs) so that is
expected. See below for a log with normal async probing that may give
some more insight into the race as well (i.e. when ath11k allocation
fails with -ENOSPC.)

> > With synchronous probing, allocation always seems to succeed but the
> > ath11k (and modem) drivers time out as no interrupts are received.
> > 
> > The NVMe driver sometimes falls back to INTx signalling and can access
> > the drive, but often end up with an MSIX (?!) allocation and then fails
> > to probe:
> > 
> > 	[  132.084740] nvme nvme0: I/O tag 17 (1011) QID 0 timeout, completion polled
> 
> So one of my test boxes (ThunderX) fails this exact way, while another
> (Synquacer) is pretty happy. Still trying to understand the difference
> in behaviour.
> 
> How do you enforce synchronous probing?

I believe there is a kernel parameter for this (e.g.
module.async_probe), but I just disable async probing for the Qualcomm
PCIe driver I'm using:

--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1684,7 +1684,7 @@ static struct platform_driver qcom_pcie_driver = {
                .name = "qcom-pcie",
                .of_match_table = qcom_pcie_match,
                .pm = &qcom_pcie_pm_ops,
-               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
+               //.probe_type = PROBE_PREFER_ASYNCHRONOUS,
        },
 };

Johan


[    8.323957] qcom-pcie 1c00000.pcie: host bridge /soc@0/pcie@1c00000 ranges:
[    8.334800] qcom-pcie 1c00000.pcie:       IO 0x0030200000..0x00302fffff -> 0x0000000000
[    8.348124] qcom-pcie 1c00000.pcie:      MEM 0x0030300000..0x0031ffffff -> 0x0030300000
[    8.378334] qcom-pcie 1c10000.pcie: host bridge /soc@0/pcie@1c10000 ranges:
[    8.378632] qcom-pcie 1c20000.pcie: host bridge /soc@0/pcie@1c20000 ranges:
[    8.378654] qcom-pcie 1c20000.pcie:       IO 0x003c200000..0x003c2fffff -> 0x0000000000
[    8.378666] qcom-pcie 1c20000.pcie:      MEM 0x003c300000..0x003dffffff -> 0x003c300000
[    8.391084] qcom-pcie 1c10000.pcie:       IO 0x0034200000..0x00342fffff -> 0x0000000000
[    8.419252] qcom-pcie 1c10000.pcie:      MEM 0x0034300000..0x0035ffffff -> 0x0034300000
[    8.477255] qcom-pcie 1c00000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 1024G
[    8.497259] qcom-pcie 1c20000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 1024G
[    8.537258] qcom-pcie 1c10000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 1024G
[    8.583746] qcom-pcie 1c00000.pcie: PCIe Gen.2 x1 link up
[    8.590079] qcom-pcie 1c00000.pcie: PCI host bridge to bus 0006:00
[    8.596838] pci_bus 0006:00: root bus resource [bus 00-ff]
[    8.602874] pci_bus 0006:00: root bus resource [io  0x0000-0xfffff]
[    8.603809] qcom-pcie 1c20000.pcie: PCIe Gen.3 x4 link up
[    8.609322] pci_bus 0006:00: root bus resource [mem 0x30300000-0x31ffffff]
[    8.609393] pci 0006:00:00.0: [17cb:010e] type 01 class 0x060400 PCIe Root Port
[    8.615040] qcom-pcie 1c20000.pcie: PCI host bridge to bus 0002:00
[    8.621951] pci 0006:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
[    8.629452] pci_bus 0002:00: root bus resource [bus 00-ff]
[    8.629706] pci_bus 0002:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x0000-0xfffff])
[    8.635822] pci 0006:00:00.0: PCI bridge to [bus 01-ff]
[    8.641903] pci_bus 0002:00: root bus resource [mem 0x3c300000-0x3dffffff]
[    8.643728] qcom-pcie 1c10000.pcie: PCIe Gen.3 x2 link up
[    8.643851] qcom-pcie 1c10000.pcie: PCI host bridge to bus 0004:00
[    8.643854] pci_bus 0004:00: root bus resource [bus 00-ff]
[    8.643857] pci_bus 0004:00: root bus resource [io  0x200000-0x2fffff] (bus address [0x0000-0xfffff])
[    8.643859] pci_bus 0004:00: root bus resource [mem 0x34300000-0x35ffffff]
[    8.643873] pci 0004:00:00.0: [17cb:010e] type 01 class 0x060400 PCIe Root Port
[    8.643881] pci 0004:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
[    8.643890] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[    8.643894] pci 0004:00:00.0:   bridge window [io  0x200000-0x200fff]
[    8.643897] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    8.643903] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    8.643982] pci 0004:00:00.0: PME# supported from D0 D3hot D3cold
[    8.644933] pci 0004:01:00.0: [17cb:0306] type 00 class 0xff0000 PCIe Endpoint
[    8.645012] pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    8.645063] pci 0004:01:00.0: BAR 2 [mem 0x00000000-0x00000fff 64bit]
[    8.645614] pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
[    8.645768] pci 0004:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0004:00:00.0 (capable of 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
[    8.647523] pci 0006:00:00.0:   bridge window [io  0x0000-0x0fff]
[    8.659851] pci 0004:00:00.0: bridge window [mem 0x34300000-0x343fffff]: assigned
[    8.659862] pci 0002:00:00.0: [17cb:010e] type 01 class 0x060400 PCIe Root Port
[    8.659873] pci 0002:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
[    8.659883] pci 0002:00:00.0: PCI bridge to [bus 01-ff]
[    8.659889] pci 0002:00:00.0:   bridge window [io  0x100000-0x100fff]
[    8.659893] pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    8.659900] pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    8.659962] pci 0002:00:00.0: PME# supported from D0 D3hot D3cold
[    8.661170] pci 0002:01:00.0: [1e0f:0001] type 00 class 0x010802 PCIe Endpoint
[    8.661259] pci 0002:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    8.661825] pci 0002:01:00.0: PME# supported from D0 D3hot
[    8.662365] pci 0006:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    8.669410] pci 0004:00:00.0: BAR 0 [mem 0x34400000-0x34400fff]: assigned
[    8.671873] pci 0002:00:00.0: bridge window [mem 0x3c300000-0x3c3fffff]: assigned
[    8.671879] pci 0002:00:00.0: BAR 0 [mem 0x3c400000-0x3c400fff]: assigned
[    8.671887] pci 0002:01:00.0: BAR 0 [mem 0x3c300000-0x3c303fff 64bit]: assigned
[    8.671931] pci 0002:00:00.0: PCI bridge to [bus 01-ff]
[    8.671936] pci 0002:00:00.0:   bridge window [mem 0x3c300000-0x3c3fffff]
[    8.672719] ITS: alloc 8192:32
[    8.672737] ITT 32 entries, 5 bits
[    8.674420] ID:0 pID:8192 vID:196
[    8.674436] ID:1 pID:8193 vID:197
[    8.674444] ID:2 pID:8194 vID:198
[    8.674452] ID:3 pID:8195 vID:199
[    8.674461] ID:4 pID:8196 vID:200
[    8.674469] ID:5 pID:8197 vID:201
[    8.674476] ID:6 pID:8198 vID:202
[    8.674485] ID:7 pID:8199 vID:203
[    8.674493] ID:8 pID:8200 vID:204
[    8.674501] ID:9 pID:8201 vID:205
[    8.674508] ID:10 pID:8202 vID:206
[    8.674517] ID:11 pID:8203 vID:207
[    8.674525] ID:12 pID:8204 vID:208
[    8.674532] ID:13 pID:8205 vID:209
[    8.674540] ID:14 pID:8206 vID:210
[    8.674548] ID:15 pID:8207 vID:211
[    8.674556] ID:16 pID:8208 vID:212
[    8.674564] ID:17 pID:8209 vID:213
[    8.674572] ID:18 pID:8210 vID:214
[    8.674580] ID:19 pID:8211 vID:215
[    8.674588] ID:20 pID:8212 vID:216
[    8.674596] ID:21 pID:8213 vID:217
[    8.674604] ID:22 pID:8214 vID:218
[    8.674612] ID:23 pID:8215 vID:219
[    8.674620] ID:24 pID:8216 vID:220
[    8.674628] ID:25 pID:8217 vID:221
[    8.674636] ID:26 pID:8218 vID:222
[    8.674643] ID:27 pID:8219 vID:223
[    8.674651] ID:28 pID:8220 vID:224
[    8.674659] ID:29 pID:8221 vID:225
[    8.674667] ID:30 pID:8222 vID:226
[    8.674675] ID:31 pID:8223 vID:227
[    8.674824] IRQ196 -> 0-7 CPU0
[    8.674850] IRQ197 -> 0-7 CPU1
[    8.674864] IRQ198 -> 0-7 CPU2
[    8.674878] IRQ199 -> 0-7 CPU3
[    8.674891] IRQ200 -> 0-7 CPU4
[    8.674905] IRQ201 -> 0-7 CPU5
[    8.674918] IRQ202 -> 0-7 CPU6
[    8.674932] IRQ203 -> 0-7 CPU7
[    8.674945] IRQ204 -> 0-7 CPU0
[    8.674951] pci 0006:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    8.675005] pci 0006:00:00.0: PME# supported from D0 D3hot D3cold
[    8.675887] pci 0006:01:00.0: [17cb:1103] type 00 class 0x028000 PCIe Endpoint
[    8.675983] pci 0006:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
[    8.676613] pci 0006:01:00.0: PME# supported from D0 D3hot D3cold
[    8.676779] pci 0006:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 0006:00:00.0 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
[    8.681292] pci 0004:01:00.0: BAR 0 [mem 0x34300000-0x34300fff 64bit]: assigned
[    8.681332] pci 0004:01:00.0: BAR 2 [mem 0x34301000-0x34301fff 64bit]: assigned
[    8.686968] IRQ205 -> 0-7 CPU1
[    8.691823] pci 0006:00:00.0: bridge window [mem 0x30400000-0x305fffff]: assigned
[    8.691825] pci 0006:00:00.0: BAR 0 [mem 0x30300000-0x30300fff]: assigned
[    8.691829] pci 0006:01:00.0: BAR 0 [mem 0x30400000-0x305fffff 64bit]: assigned
[    8.691877] pci 0006:00:00.0: PCI bridge to [bus 01-ff]
[    8.691880] pci 0006:00:00.0:   bridge window [mem 0x30400000-0x305fffff]
[    8.692011] Reusing ITT for devID 0
[    8.693668] Reusing ITT for devID 0
[    8.693871] pcieport 0006:00:00.0: PME: Signaling with IRQ 228
[    8.694116] pcieport 0006:00:00.0: AER: enabled with IRQ 228
[    8.696453] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[    8.703760] IRQ206 -> 0-7 CPU2
[    8.710986] pci 0004:00:00.0:   bridge window [mem 0x34300000-0x343fffff]
[    8.711136] Reusing ITT for devID 0
[    8.717093] IRQ207 -> 0-7 CPU3
[    8.723889] Reusing ITT for devID 0
[    8.729600] IRQ208 -> 0-7 CPU4
[    8.736507] pcieport 0004:00:00.0: PME: Signaling with IRQ 229
[    8.744261] IRQ209 -> 0-7 CPU5
[    8.750757] pcieport 0004:00:00.0: AER: enabled with IRQ 229
[    8.758038] IRQ210 -> 0-7 CPU6
[    9.071793] IRQ211 -> 0-7 CPU7
[    9.071807] IRQ212 -> 0-7 CPU0
[    9.071819] IRQ213 -> 0-7 CPU1
[    9.071831] IRQ214 -> 0-7 CPU2
[    9.071842] IRQ215 -> 0-7 CPU3
[    9.071852] IRQ216 -> 0-7 CPU4
[    9.071863] IRQ217 -> 0-7 CPU5
[    9.071875] IRQ218 -> 0-7 CPU6
[    9.071886] IRQ219 -> 0-7 CPU7
[    9.071897] IRQ220 -> 0-7 CPU0
[    9.071907] IRQ221 -> 0-7 CPU1
[    9.071920] IRQ222 -> 0-7 CPU2
[    9.071930] IRQ223 -> 0-7 CPU3
[    9.071941] IRQ224 -> 0-7 CPU4
[    9.071952] IRQ225 -> 0-7 CPU5
[    9.071962] IRQ226 -> 0-7 CPU6
[    9.071973] IRQ227 -> 0-7 CPU7
[    9.073568] Reusing ITT for devID 0
[    9.073607] ID:0 pID:8192 vID:196
[    9.073618] IRQ196 -> 0-7 CPU0
[    9.073717] IRQ196 -> 0-7 CPU0
[    9.073737] pcieport 0002:00:00.0: PME: Signaling with IRQ 196
[    9.086532] pcieport 0002:00:00.0: AER: enabled with IRQ 196
[    9.102057] mhi-pci-generic 0004:01:00.0: MHI PCI device found: foxconn-sdx55
[    9.109830] mhi-pci-generic 0004:01:00.0: BAR 0 [mem 0x34300000-0x34300fff 64bit]: assigned
[    9.119027] mhi-pci-generic 0004:01:00.0: enabling device (0000 -> 0002)
[    9.127271] ITS: alloc 8224:8
[    9.141500] ITT 8 entries, 3 bits
[    9.144502] ID:0 pID:8224 vID:198
[    9.144597] ID:1 pID:8225 vID:199
[    9.144605] ID:2 pID:8226 vID:200
[    9.144612] ID:3 pID:8227 vID:201
[    9.144619] ID:4 pID:8228 vID:202
[    9.144689] IRQ198 -> 0-7 CPU1
[    9.144888] IRQ199 -> 0-7 CPU2
[    9.144901] IRQ200 -> 0-7 CPU3
[    9.144914] IRQ201 -> 0-7 CPU4
[    9.144927] IRQ202 -> 0-7 CPU5
[    9.151264] IRQ198 -> 0-7 CPU1
[    9.151479] IRQ199 -> 0-7 CPU2
[    9.151673] IRQ200 -> 0-7 CPU3
[    9.151849] IRQ201 -> 0-7 CPU4
[    9.152056] IRQ202 -> 0-7 CPU5
[    9.159972] mhi mhi0: Requested to power ON
[    9.165275] mhi mhi0: Power on setup success
[    9.279951] ath11k_pci 0006:01:00.0: BAR 0 [mem 0x30400000-0x305fffff 64bit]: assigned
[    9.288208] ath11k_pci 0006:01:00.0: enabling device (0000 -> 0002)
[    9.301708] nvme nvme0: pci function 0002:01:00.0
[    9.307052] Reusing ITT for devID 100
[    9.315457] nvme 0002:01:00.0: enabling device (0000 -> 0002)
[    9.326554] Reusing ITT for devID 100
[    9.336332] ath11k_pci 0006:01:00.0: ath11k_pci_alloc_msi - requesting one vector failed: -28
[    9.344362] Reusing ITT for devID 100
[    9.351639] ath11k_pci 0006:01:00.0: failed to enable msi: -22
[    9.351866] ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -22
[    9.360327] Reusing ITT for devID 100
[    9.654429] nvme nvme0: allocated 61 MiB host memory buffer.
[    9.814664] Reusing ITT for devID 100
[    9.815000] Reusing ITT for devID 100
[    9.815553] Reusing ITT for devID 100
[    9.843417] nvme nvme0: 1/0/0 default/read/poll queues
[    9.875782]  nvme0n1: p1

[   29.666877] mhi-pci-generic 0004:01:00.0: failed to power up MHI controller
[   29.681492] mhi-pci-generic 0004:01:00.0: probe with driver mhi-pci-generic failed with error -110

