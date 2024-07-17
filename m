Return-Path: <linux-pci+bounces-10436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D90D933DBC
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 15:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07381F211D4
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C127180A7C;
	Wed, 17 Jul 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeOFN14i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421FE180A77;
	Wed, 17 Jul 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223539; cv=none; b=bMYKnYidZ1TuQYT5sJsxYJgdlPJcrNc7y1atKwEFL/wfN/gAxJS/VuJdgPX1P1h7AKJGbpZnbYfpXbGKRr+61D8ZGQRLc9hISBd8kxmaeFQZ9VRNKdIBrPqihqh3uoJS8Psz5Ap7J53eN3nD+oW4xvuiXehkylKmIeWr8Ua0kr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223539; c=relaxed/simple;
	bh=GgXZJx36NMEVwEidr83rK9F0HIQ6XeJqBWgBWJ+wIFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS5da/e6WWlOd4yJU2O4kRqF6coulYK2U7YvGDu1v4KB7TpMpzsjSFNf+MQhfjLRj3UFWEzbSFjaeJmZW/lWzqYj22vt8pymcAleD9y5QIf3V494GPfavFekyHctrWY7TjZulT0Ovjt49Vn/K9P9BporaC+2RvF7Px/A0tyfDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeOFN14i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723EFC4AF09;
	Wed, 17 Jul 2024 13:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721223538;
	bh=GgXZJx36NMEVwEidr83rK9F0HIQ6XeJqBWgBWJ+wIFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UeOFN14iFzrzhjpgKbFpgYfHd5oO3XpV1WHspl2c0/BFD3quIqNcfG2VKXgFCtHtb
	 R4e20SQ7hJMcD8aHFVfddEOrb9s2JHhnWBy4+Rn9CMrDtC8sM/h7Ig/btZTkv0bROQ
	 KfPCyIAtcYa+NauNcQrg+H/bsZv8N6XA+LfY1leFpDyZwRwdFqfyF1DItc6WNJv+F1
	 xQgmKu/b48usdtC1C3O/vtQS8UE4dy+YZbu2EqRvhH6BKAE1xPPwBayfWavo0c+oul
	 OrSCTb5VpFVLsXP1rdUscowUGpgTuNh6eFr0WM0aKPIjwwhqZQjPl/YJYaL1EZ5s20
	 AbkFeW/lxMifA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sU4rz-000000002QG-12Bs;
	Wed, 17 Jul 2024 15:38:59 +0200
Date: Wed, 17 Jul 2024 15:38:59 +0200
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
Message-ID: <ZpfJc80IInRLbRs5@hovoldconsulting.com>
References: <20240623142137.448898081@linutronix.de>
 <ZpUFl4uMCT8YwkUE@hovoldconsulting.com>
 <878qy26cd6.wl-maz@kernel.org>
 <ZpUtuS65AQTJ0kPO@hovoldconsulting.com>
 <86r0bt39zm.wl-maz@kernel.org>
 <ZpaJaM1G721FdLFn@hovoldconsulting.com>
 <86plrd2o5o.wl-maz@kernel.org>
 <Zpdxe4ce-XwDEods@hovoldconsulting.com>
 <86msmg2n73.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86msmg2n73.wl-maz@kernel.org>

On Wed, Jul 17, 2024 at 01:54:40PM +0100, Marc Zyngier wrote:
> On Wed, 17 Jul 2024 08:23:39 +0100,
> Johan Hovold <johan@kernel.org> wrote:

> > I believe there is a kernel parameter for this (e.g.
> > module.async_probe), but I just disable async probing for the Qualcomm
> > PCIe driver I'm using:
> 
> I had tried this module parameter, but it didn't change anything on my
> end.

> I'll have a look whether the TX1 PCIe driver uses this. It's
> positively ancient, so I wouldn't bet that it has been touched
> significantly in the past 5 years.

Perhaps async probing just changes the symptoms, the NVMe and wifi
doesn't work in either case.

> > [    8.692011] Reusing ITT for devID 0
> > [    8.693668] Reusing ITT for devID 0
> 
> This is really odd. It indicates that you have several devices sharing
> the same DeviceID, which I seriously doubt it is the case in a
> laptop. Do you have any non-transparent bridge here? lspci would help.

Yeah, and these messages do not show up without the series (see log
below). They are there in the previous synchronous log however.

0002:00:00.0 PCI bridge: Qualcomm Technologies, Inc SC8280XP PCI Express Root Port
0002:01:00.0 Non-Volatile memory controller: KIOXIA Corporation NVMe SSD Controller BG4 (DRAM-less)
0004:00:00.0 PCI bridge: Qualcomm Technologies, Inc SC8280XP PCI Express Root Port
0004:01:00.0 Unassigned class [ff00]: Qualcomm Technologies, Inc SDX55 [Snapdragon X55 5G]
0006:00:00.0 PCI bridge: Qualcomm Technologies, Inc SC8280XP PCI Express Root Port
0006:01:00.0 Network controller: Qualcomm Technologies, Inc QCNFA765 Wireless Network Adapter (rev 01)

> I'm starting to suspect that the new code doesn't carry all the
> required bits for the DevID, and that we end-up trying to allocated
> interrupts from the pool allocated to another device, which can never
> be a good thing, and would explain why everything dies a painful
> death.
> 
> Can you run the same trace with the whole thing reverted? I think
> we're on something here.

See below, using normal asynchronous probing like the previous log.

Johan


[    8.129424] qcom-pcie 1c10000.pcie: host bridge /soc@0/pcie@1c10000 ranges:
[    8.136886] qcom-pcie 1c10000.pcie:       IO 0x0034200000..0x00342fffff -> 0x0000000000
[    8.145351] qcom-pcie 1c00000.pcie: host bridge /soc@0/pcie@1c00000 ranges:
[    8.145372] qcom-pcie 1c10000.pcie:      MEM 0x0034300000..0x0035ffffff -> 0x0034300000
[    8.146042] qcom-pcie 1c20000.pcie: host bridge /soc@0/pcie@1c20000 ranges:
[    8.146063] qcom-pcie 1c20000.pcie:       IO 0x003c200000..0x003c2fffff -> 0x0000000000
[    8.146073] qcom-pcie 1c20000.pcie:      MEM 0x003c300000..0x003dffffff -> 0x003c300000
[    8.152546] qcom-pcie 1c00000.pcie:       IO 0x0030200000..0x00302fffff -> 0x0000000000
[    8.176372] qcom-pcie 1c00000.pcie:      MEM 0x0030300000..0x0031ffffff -> 0x0030300000
[    8.266560] qcom-pcie 1c20000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 1024G
[    8.298587] qcom-pcie 1c10000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 1024G
[    8.318753] qcom-pcie 1c00000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 1024G
[    8.377720] qcom-pcie 1c20000.pcie: PCIe Gen.3 x4 link up
[    8.384650] qcom-pcie 1c20000.pcie: PCI host bridge to bus 0002:00
[    8.392099] pci_bus 0002:00: root bus resource [bus 00-ff]
[    8.398766] pci_bus 0002:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x0000-0xfffff])
[    8.405033] qcom-pcie 1c10000.pcie: PCIe Gen.3 x2 link up
[    8.408250] pci_bus 0002:00: root bus resource [mem 0x3c300000-0x3dffffff]
[    8.413899] qcom-pcie 1c10000.pcie: PCI host bridge to bus 0004:00
[    8.420959] pci 0002:00:00.0: [17cb:010e] type 01 class 0x060400 PCIe Root Port
[    8.427201] pci_bus 0004:00: root bus resource [bus 00-ff]
[    8.427204] pci_bus 0004:00: root bus resource [io  0x0000-0xfffff]
[    8.427206] pci_bus 0004:00: root bus resource [mem 0x34300000-0x35ffffff]
[    8.427219] pci 0004:00:00.0: [17cb:010e] type 01 class 0x060400 PCIe Root Port
[    8.430158] qcom-pcie 1c00000.pcie: PCIe Gen.2 x1 link up
[    8.430263] qcom-pcie 1c00000.pcie: PCI host bridge to bus 0006:00
[    8.430266] pci_bus 0006:00: root bus resource [bus 00-ff]
[    8.430269] pci_bus 0006:00: root bus resource [io  0x200000-0x2fffff] (bus address [0x0000-0xfffff])
[    8.430271] pci_bus 0006:00: root bus resource [mem 0x30300000-0x31ffffff]
[    8.430285] pci 0006:00:00.0: [17cb:010e] type 01 class 0x060400 PCIe Root Port
[    8.430297] pci 0006:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
[    8.430307] pci 0006:00:00.0: PCI bridge to [bus 01-ff]
[    8.430313] pci 0006:00:00.0:   bridge window [io  0x200000-0x200fff]
[    8.430317] pci 0006:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    8.430324] pci 0006:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    8.430414] pci 0006:00:00.0: PME# supported from D0 D3hot D3cold
[    8.431430] pci 0006:01:00.0: [17cb:1103] type 00 class 0x028000 PCIe Endpoint
[    8.431526] pci 0006:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
[    8.432154] pci 0006:01:00.0: PME# supported from D0 D3hot D3cold
[    8.432320] pci 0006:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 0006:00:00.0 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
[    8.434723] pci 0002:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
[    8.440358] pci 0004:00:00.0: BAR 0 [mem 0x00000000-0x00000fff]
[    8.445157] pci 0006:00:00.0: bridge window [mem 0x30400000-0x305fffff]: assigned
[    8.445160] pci 0006:00:00.0: BAR 0 [mem 0x30300000-0x30300fff]: assigned
[    8.445163] pci 0006:01:00.0: BAR 0 [mem 0x30400000-0x305fffff 64bit]: assigned
[    8.445211] pci 0006:00:00.0: PCI bridge to [bus 01-ff]
[    8.445214] pci 0006:00:00.0:   bridge window [mem 0x30400000-0x305fffff]
[    8.445526] ITS: alloc 8192:32
[    8.445537] ITT 32 entries, 5 bits
[    8.446675] ID:0 pID:8192 vID:196
[    8.446697] ID:1 pID:8193 vID:197
[    8.446702] ID:2 pID:8194 vID:198
[    8.446707] ID:3 pID:8195 vID:199
[    8.446712] ID:4 pID:8196 vID:200
[    8.446718] ID:5 pID:8197 vID:201
[    8.446722] ID:6 pID:8198 vID:202
[    8.446727] ID:7 pID:8199 vID:203
[    8.446732] ID:8 pID:8200 vID:204
[    8.446738] ID:9 pID:8201 vID:205
[    8.446743] ID:10 pID:8202 vID:206
[    8.446748] ID:11 pID:8203 vID:207
[    8.446753] ID:12 pID:8204 vID:208
[    8.446758] ID:13 pID:8205 vID:209
[    8.446763] ID:14 pID:8206 vID:210
[    8.446768] ID:15 pID:8207 vID:211
[    8.446773] ID:16 pID:8208 vID:212
[    8.446777] ID:17 pID:8209 vID:213
[    8.446783] ID:18 pID:8210 vID:214
[    8.446788] ID:19 pID:8211 vID:215
[    8.446805] pci 0002:00:00.0: PCI bridge to [bus 01-ff]
[    8.446812] pci 0002:00:00.0:   bridge window [io  0x100000-0x100fff]
[    8.446817] pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    8.446827] pci 0002:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    8.446899] pci 0002:00:00.0: PME# supported from D0 D3hot D3cold
[    8.448399] pci 0002:01:00.0: [1e0f:0001] type 00 class 0x010802 PCIe Endpoint
[    8.448489] pci 0002:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    8.449076] pci 0002:01:00.0: PME# supported from D0 D3hot
[    8.453855] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[    8.453860] pci 0004:00:00.0:   bridge window [io  0x0000-0x0fff]
[    8.461133] pci 0002:00:00.0: bridge window [mem 0x3c300000-0x3c3fffff]: assigned
[    8.461137] pci 0002:00:00.0: BAR 0 [mem 0x3c400000-0x3c400fff]: assigned
[    8.461141] pci 0002:01:00.0: BAR 0 [mem 0x3c300000-0x3c303fff 64bit]: assigned
[    8.461182] pci 0002:00:00.0: PCI bridge to [bus 01-ff]
[    8.461185] pci 0002:00:00.0:   bridge window [mem 0x3c300000-0x3c3fffff]
[    8.461378] ID:20 pID:8212 vID:216
[    8.466916] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    8.473265] ID:21 pID:8213 vID:217
[    8.478893] pci 0004:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    8.488351] ID:22 pID:8214 vID:218
[    8.495446] pci 0004:00:00.0: PME# supported from D0 D3hot D3cold
[    8.502905] ID:23 pID:8215 vID:219
[    8.509868] pci 0004:01:00.0: [17cb:0306] type 00 class 0xff0000 PCIe Endpoint
[    8.514345] ID:24 pID:8216 vID:220
[    8.521029] pci 0004:01:00.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    8.527916] ID:25 pID:8217 vID:221
[    8.535900] pci 0004:01:00.0: BAR 2 [mem 0x00000000-0x00000fff 64bit]
[    8.542116] ID:26 pID:8218 vID:222
[    8.550074] pci 0004:01:00.0: PME# supported from D0 D3hot D3cold
[    8.556138] ID:27 pID:8219 vID:223
[    8.562538] pci 0004:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0004:00:00.0 (capable of 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
[    8.577637] ID:28 pID:8220 vID:224
[    8.597112] pci 0004:00:00.0: bridge window [mem 0x34300000-0x343fffff]: assigned
[    8.597753] ID:29 pID:8221 vID:225
[    8.604711] pci 0004:00:00.0: BAR 0 [mem 0x34400000-0x34400fff]: assigned
[    8.612214] ID:30 pID:8222 vID:226
[    8.617572] pci 0004:01:00.0: BAR 0 [mem 0x34300000-0x34300fff 64bit]: assigned
[    8.624536] ID:31 pID:8223 vID:227
[    8.624836] pci 0004:01:00.0: BAR 2 [mem 0x34301000-0x34301fff 64bit]: assigned
[    8.625174] IRQ196 -> 0-7 CPU0
[    8.625221] ITS: alloc 8224:32
[    8.625230] ITT 32 entries, 5 bits
[    8.625370] pci 0004:00:00.0: PCI bridge to [bus 01-ff]
[    8.625633] IRQ197 -> 0-7 CPU1
[    8.625888] pci 0004:00:00.0:   bridge window [mem 0x34300000-0x343fffff]
[    8.626014] ID:0 pID:8224 vID:229
[    8.626020] ID:1 pID:8225 vID:230
[    8.626025] ID:2 pID:8226 vID:231
[    8.626031] ID:3 pID:8227 vID:232
[    8.626036] ID:4 pID:8228 vID:233
[    8.626041] ID:5 pID:8229 vID:234
[    8.626046] ID:6 pID:8230 vID:235
[    8.626051] ID:7 pID:8231 vID:236
[    8.626056] ID:8 pID:8232 vID:237
[    8.626061] ID:9 pID:8233 vID:238
[    8.626066] ID:10 pID:8234 vID:239
[    8.626071] ID:11 pID:8235 vID:240
[    8.626076] ID:12 pID:8236 vID:241
[    8.626081] ID:13 pID:8237 vID:242
[    8.626086] ID:14 pID:8238 vID:243
[    8.626092] ID:15 pID:8239 vID:244
[    8.626097] ID:16 pID:8240 vID:245
[    8.626102] ID:17 pID:8241 vID:246
[    8.626107] ID:18 pID:8242 vID:247
[    8.626112] ID:19 pID:8243 vID:248
[    8.626117] ID:20 pID:8244 vID:249
[    8.626122] ID:21 pID:8245 vID:250
[    8.626127] ID:22 pID:8246 vID:251
[    8.626132] ID:23 pID:8247 vID:252
[    8.626137] ID:24 pID:8248 vID:253
[    8.626143] ID:25 pID:8249 vID:254
[    8.626148] ID:26 pID:8250 vID:255
[    8.626153] ID:27 pID:8251 vID:256
[    8.626158] ID:28 pID:8252 vID:257
[    8.626166] IRQ198 -> 0-7 CPU2
[    8.626177] IRQ199 -> 0-7 CPU3
[    8.626188] IRQ200 -> 0-7 CPU4
[    8.626199] IRQ201 -> 0-7 CPU5
[    8.626210] IRQ202 -> 0-7 CPU6
[    8.626221] IRQ203 -> 0-7 CPU7
[    8.626232] IRQ204 -> 0-7 CPU0
[    8.626243] IRQ205 -> 0-7 CPU1
[    8.626254] IRQ206 -> 0-7 CPU2
[    8.626264] IRQ207 -> 0-7 CPU3
[    8.626275] IRQ208 -> 0-7 CPU4
[    8.626286] IRQ209 -> 0-7 CPU5
[    8.626297] IRQ210 -> 0-7 CPU6
[    8.626308] IRQ211 -> 0-7 CPU7
[    8.626319] IRQ212 -> 0-7 CPU0
[    8.626330] IRQ213 -> 0-7 CPU1
[    8.626341] IRQ214 -> 0-7 CPU2
[    8.626352] IRQ215 -> 0-7 CPU3
[    8.626363] IRQ216 -> 0-7 CPU4
[    8.626374] IRQ217 -> 0-7 CPU5
[    8.626385] IRQ218 -> 0-7 CPU6
[    8.626396] IRQ219 -> 0-7 CPU7
[    8.626407] IRQ220 -> 0-7 CPU0
[    8.626418] IRQ221 -> 0-7 CPU1
[    8.626429] IRQ222 -> 0-7 CPU2
[    8.626704] ID:29 pID:8253 vID:258
[    8.626965] IRQ223 -> 0-7 CPU3
[    8.627214] ID:30 pID:8254 vID:259
[    8.627467] IRQ224 -> 0-7 CPU4
[    8.627722] ID:31 pID:8255 vID:260
[    8.627977] IRQ225 -> 0-7 CPU5
[    8.628312] IRQ229 -> 0-7 CPU5
[    8.628372] ITS: alloc 8256:32
[    8.628380] ITT 32 entries, 5 bits
[    8.628479] IRQ226 -> 0-7 CPU6
[    8.628723] IRQ230 -> 0-7 CPU6
[    8.628957] IRQ227 -> 0-7 CPU7
[    8.629094] ID:0 pID:8256 vID:262
[    8.629099] ID:1 pID:8257 vID:263
[    8.629104] ID:2 pID:8258 vID:264
[    8.629109] ID:3 pID:8259 vID:265
[    8.629114] ID:4 pID:8260 vID:266
[    8.629119] ID:5 pID:8261 vID:267
[    8.629124] ID:6 pID:8262 vID:268
[    8.629129] ID:7 pID:8263 vID:269
[    8.629134] ID:8 pID:8264 vID:270
[    8.629139] ID:9 pID:8265 vID:271
[    8.629144] ID:10 pID:8266 vID:272
[    8.629149] ID:11 pID:8267 vID:273
[    8.629153] ID:12 pID:8268 vID:274
[    8.629158] ID:13 pID:8269 vID:275
[    8.629163] ID:14 pID:8270 vID:276
[    8.629168] ID:15 pID:8271 vID:277
[    8.629173] ID:16 pID:8272 vID:278
[    8.629178] ID:17 pID:8273 vID:279
[    8.629183] ID:18 pID:8274 vID:280
[    8.629188] ID:19 pID:8275 vID:281
[    8.629200] IRQ231 -> 0-7 CPU7
[    8.629211] IRQ232 -> 0-7 CPU0
[    8.629222] IRQ233 -> 0-7 CPU1
[    8.629233] IRQ234 -> 0-7 CPU2
[    8.629244] IRQ235 -> 0-7 CPU3
[    8.629255] IRQ236 -> 0-7 CPU4
[    8.629266] IRQ237 -> 0-7 CPU7
[    8.629277] IRQ238 -> 0-7 CPU0
[    8.629287] IRQ239 -> 0-7 CPU1
[    8.629298] IRQ240 -> 0-7 CPU2
[    8.629309] IRQ241 -> 0-7 CPU3
[    8.629319] IRQ242 -> 0-7 CPU4
[    8.629336] IRQ243 -> 0-7 CPU5
[    8.629346] IRQ244 -> 0-7 CPU6
[    8.629357] IRQ245 -> 0-7 CPU7
[    8.629368] IRQ246 -> 0-7 CPU0
[    8.629379] IRQ247 -> 0-7 CPU1
[    8.629390] IRQ248 -> 0-7 CPU2
[    8.629401] IRQ249 -> 0-7 CPU3
[    8.629411] IRQ250 -> 0-7 CPU4
[    8.629422] IRQ251 -> 0-7 CPU5
[    8.629433] IRQ252 -> 0-7 CPU6
[    8.629670] ID:20 pID:8276 vID:282
[    8.629908] IRQ253 -> 0-7 CPU0
[    8.630134] ID:21 pID:8277 vID:283
[    8.635511] IRQ254 -> 0-7 CPU1
[    8.642115] ID:22 pID:8278 vID:284
[    8.649085] IRQ255 -> 0-7 CPU2
[    8.657029] ID:23 pID:8279 vID:285
[    8.663285] IRQ256 -> 0-7 CPU3
[    8.670689] ID:24 pID:8280 vID:286
[    8.677302] IRQ257 -> 0-7 CPU4
[    8.682925] ID:25 pID:8281 vID:287
[    8.688293] IRQ258 -> 0-7 CPU5
[    8.694547] ID:26 pID:8282 vID:288
[    8.702234] IRQ259 -> 0-7 CPU6
[    8.709197] ID:27 pID:8283 vID:289
[    8.709204] ID:28 pID:8284 vID:290
[    8.716722] IRQ260 -> 0-7 CPU7
[    8.722081] ID:29 pID:8285 vID:291
[    8.842813] ID:30 pID:8286 vID:292
[    8.842818] ID:31 pID:8287 vID:293
[    8.842966] IRQ262 -> 0-7 CPU0
[    8.842982] IRQ263 -> 0-7 CPU1
[    8.842993] IRQ264 -> 0-7 CPU2
[    8.843004] IRQ265 -> 0-7 CPU3
[    8.843016] IRQ266 -> 0-7 CPU4
[    8.843028] IRQ267 -> 0-7 CPU5
[    8.843040] IRQ268 -> 0-7 CPU6
[    8.843051] IRQ269 -> 0-7 CPU7
[    8.843063] IRQ270 -> 0-7 CPU0
[    8.843075] IRQ271 -> 0-7 CPU1
[    8.843087] IRQ272 -> 0-7 CPU2
[    8.843098] IRQ273 -> 0-7 CPU3
[    8.843110] IRQ274 -> 0-7 CPU4
[    8.843122] IRQ275 -> 0-7 CPU5
[    8.843133] IRQ276 -> 0-7 CPU6
[    8.843145] IRQ277 -> 0-7 CPU7
[    8.843157] IRQ278 -> 0-7 CPU0
[    8.843168] IRQ279 -> 0-7 CPU1
[    8.843180] IRQ280 -> 0-7 CPU2
[    8.843192] IRQ281 -> 0-7 CPU3
[    8.843203] IRQ282 -> 0-7 CPU4
[    8.843215] IRQ283 -> 0-7 CPU5
[    8.843227] IRQ284 -> 0-7 CPU6
[    8.843238] IRQ285 -> 0-7 CPU7
[    8.843250] IRQ286 -> 0-7 CPU0
[    8.843262] IRQ287 -> 0-7 CPU1
[    8.843273] IRQ288 -> 0-7 CPU2
[    8.843284] IRQ289 -> 0-7 CPU3
[    8.843296] IRQ290 -> 0-7 CPU4
[    8.843308] IRQ291 -> 0-7 CPU5
[    8.843319] IRQ292 -> 0-7 CPU6
[    8.843331] IRQ293 -> 0-7 CPU7
[    8.844444] ITS: alloc 8192:1
[    8.844455] ITT 1 entries, 0 bits
[    8.845389] ID:0 pID:8192 vID:196
[    8.845395] ITS: alloc 8193:1
[    8.845403] IRQ196 -> 0-7 CPU0
[    8.845405] ITT 1 entries, 0 bits
[    8.845604] IRQ196 -> 0-7 CPU0
[    8.845631] pcieport 0006:00:00.0: PME: Signaling with IRQ 196
[    8.846380] ID:0 pID:8193 vID:197
[    8.846414] ITS: alloc 8194:1
[    8.846423] ITT 1 entries, 0 bits
[    8.857408] IRQ197 -> 0-7 CPU1
[    8.857440] ID:0 pID:8194 vID:198
[    8.857450] IRQ198 -> 0-7 CPU2
[    8.857499] IRQ197 -> 0-7 CPU1
[    8.857515] pcieport 0002:00:00.0: PME: Signaling with IRQ 197
[    8.857529] IRQ198 -> 0-7 CPU2
[    8.858291] pcieport 0006:00:00.0: AER: enabled with IRQ 196
[    8.866563] pcieport 0002:00:00.0: AER: enabled with IRQ 197
[    8.872342] pcieport 0004:00:00.0: PME: Signaling with IRQ 198
[    8.885618] pcieport 0004:00:00.0: AER: enabled with IRQ 198
[    8.909946] mhi-pci-generic 0004:01:00.0: MHI PCI device found: foxconn-sdx55
[    8.914659] nvme nvme0: pci function 0002:01:00.0
[    8.917541] mhi-pci-generic 0004:01:00.0: BAR 0 [mem 0x34300000-0x34300fff 64bit]: assigned
[    8.922185] nvme 0002:01:00.0: enabling device (0000 -> 0002)
[    8.930939] mhi-pci-generic 0004:01:00.0: enabling device (0000 -> 0002)
[    8.937318] ITS: alloc 8195:1
[    8.944985] ITT 1 entries, 0 bits
[    8.945289] ITS: alloc 8196:8
[    8.945303] ITT 8 entries, 3 bits
[    8.947818] ID:0 pID:8195 vID:201
[    8.947910] IRQ201 -> 0-7 CPU3
[    8.948702] ID:0 pID:8196 vID:202
[    8.948720] ID:1 pID:8197 vID:203
[    8.950480] IRQ201 -> 0-7 CPU3
[    8.965330] ID:2 pID:8198 vID:204
[    8.974909] ID:3 pID:8199 vID:205
[    8.987215] ID:4 pID:8200 vID:206
[    9.001562] IRQ202 -> 0-7 CPU4
[    9.001759] IRQ203 -> 0-7 CPU5
[    9.001771] IRQ204 -> 0-7 CPU6
[    9.001849] IRQ205 -> 0-7 CPU7
[    9.001862] IRQ206 -> 0-7 CPU0
[    9.003223] IRQ202 -> 0-7 CPU4
[    9.003449] IRQ203 -> 0-7 CPU5
[    9.003638] IRQ204 -> 0-7 CPU6
[    9.003836] IRQ205 -> 0-7 CPU7
[    9.004007] IRQ206 -> 0-7 CPU0
[    9.005127] mhi mhi0: Requested to power ON
[    9.009901] mhi mhi0: Power on setup success
[    9.015403] nvme nvme0: allocated 61 MiB host memory buffer.
[    9.169296] ITS: alloc 8204:16
[    9.169319] ITT 16 entries, 4 bits
[    9.169492] ID:0 pID:8204 vID:201
[    9.169516] IRQ201 -> 0-7 CPU3
[    9.169620] ID:1 pID:8205 vID:211
[    9.169633] IRQ211 -> 0-7 CPU0
[    9.169702] ID:2 pID:8206 vID:212
[    9.169713] IRQ212 -> 0-7 CPU1
[    9.169904] ID:3 pID:8207 vID:213
[    9.169917] IRQ213 -> 0-7 CPU2
[    9.169982] ID:4 pID:8208 vID:214
[    9.169993] IRQ214 -> 0-7 CPU3
[    9.170070] ID:5 pID:8209 vID:215
[    9.170082] IRQ215 -> 0-7 CPU4
[    9.170143] ID:6 pID:8210 vID:216
[    9.170155] IRQ216 -> 0-7 CPU5
[    9.170221] ID:7 pID:8211 vID:217
[    9.170232] IRQ217 -> 0-7 CPU6
[    9.170294] ID:8 pID:8212 vID:218
[    9.170319] IRQ218 -> 0-7 CPU7
[    9.170460] IRQ201 -> 0-7 CPU3
[    9.179969] IRQ211 -> 0 CPU0
[    9.180329] IRQ212 -> 1 CPU1
[    9.180663] IRQ213 -> 2 CPU2
[    9.181001] IRQ214 -> 3 CPU3
[    9.181355] IRQ215 -> 4 CPU4
[    9.181702] IRQ216 -> 5 CPU5
[    9.188542] IRQ217 -> 6 CPU6
[    9.196576] IRQ218 -> 7 CPU7
[    9.196623] nvme nvme0: 8/0/0 default/read/poll queues
[    9.206751]  nvme0n1: p1
[    9.278797] ath11k_pci 0006:01:00.0: BAR 0 [mem 0x30400000-0x305fffff 64bit]: assigned
[    9.294555] ath11k_pci 0006:01:00.0: enabling device (0000 -> 0002)
[    9.295634] wwan wwan0: port wwan0qcdm0 attached
[    9.296105] wwan wwan0: port wwan0mbim0 attached
[    9.296789] wwan wwan0: port wwan0at0 attached
[    9.304915] ITS: alloc 8220:32
[    9.314316] ITT 32 entries, 5 bits
[    9.324270] ID:0 pID:8220 vID:262
[    9.338759] ID:1 pID:8221 vID:263
[    9.338765] ID:2 pID:8222 vID:264
[    9.338770] ID:3 pID:8223 vID:265
[    9.338775] ID:4 pID:8224 vID:266
[    9.338779] ID:5 pID:8225 vID:267
[    9.338784] ID:6 pID:8226 vID:268
[    9.338789] ID:7 pID:8227 vID:269
[    9.338794] ID:8 pID:8228 vID:270
[    9.338798] ID:9 pID:8229 vID:271
[    9.338803] ID:10 pID:8230 vID:272
[    9.338808] ID:11 pID:8231 vID:273
[    9.338812] ID:12 pID:8232 vID:274
[    9.338817] ID:13 pID:8233 vID:275
[    9.338821] ID:14 pID:8234 vID:276
[    9.338826] ID:15 pID:8235 vID:277
[    9.338831] ID:16 pID:8236 vID:278
[    9.338836] ID:17 pID:8237 vID:279
[    9.338841] ID:18 pID:8238 vID:280
[    9.338845] ID:19 pID:8239 vID:281
[    9.338850] ID:20 pID:8240 vID:282
[    9.338855] ID:21 pID:8241 vID:283
[    9.338859] ID:22 pID:8242 vID:284
[    9.338864] ID:23 pID:8243 vID:285
[    9.338868] ID:24 pID:8244 vID:286
[    9.338873] ID:25 pID:8245 vID:287
[    9.338877] ID:26 pID:8246 vID:288
[    9.338882] ID:27 pID:8247 vID:289
[    9.338887] ID:28 pID:8248 vID:290
[    9.338891] ID:29 pID:8249 vID:291
[    9.338896] ID:30 pID:8250 vID:292
[    9.338900] ID:31 pID:8251 vID:293
[    9.338980] IRQ262 -> 0-7 CPU1
[    9.362613] IRQ263 -> 0-7 CPU2
[    9.370142] IRQ264 -> 0-7 CPU3
[    9.377656] IRQ265 -> 0-7 CPU4
[    9.400274] IRQ266 -> 0-7 CPU5
[    9.409009] IRQ267 -> 0-7 CPU6
[    9.409021] IRQ268 -> 0-7 CPU7
[    9.409033] IRQ269 -> 0-7 CPU0
[    9.409044] IRQ270 -> 0-7 CPU1
[    9.409056] IRQ271 -> 0-7 CPU2
[    9.409067] IRQ272 -> 0-7 CPU3
[    9.409078] IRQ273 -> 0-7 CPU4
[    9.409089] IRQ274 -> 0-7 CPU5
[    9.409100] IRQ275 -> 0-7 CPU6
[    9.409111] IRQ276 -> 0-7 CPU7
[    9.409123] IRQ277 -> 0-7 CPU0
[    9.409134] IRQ278 -> 0-7 CPU1
[    9.409145] IRQ279 -> 0-7 CPU2
[    9.409157] IRQ280 -> 0-7 CPU3
[    9.409168] IRQ281 -> 0-7 CPU4
[    9.409179] IRQ282 -> 0-7 CPU5
[    9.409190] IRQ283 -> 0-7 CPU6
[    9.409201] IRQ284 -> 0-7 CPU7
[    9.409213] IRQ285 -> 0-7 CPU0
[    9.409224] IRQ286 -> 0-7 CPU1
[    9.409235] IRQ287 -> 0-7 CPU2
[    9.409247] IRQ288 -> 0-7 CPU3
[    9.409258] IRQ289 -> 0-7 CPU4
[    9.409270] IRQ290 -> 0-7 CPU5
[    9.409281] IRQ291 -> 0-7 CPU6
[    9.409292] IRQ292 -> 0-7 CPU7
[    9.409303] IRQ293 -> 0-7 CPU0
[    9.409438] ath11k_pci 0006:01:00.0: MSI vectors: 32
[    9.426507] ath11k_pci 0006:01:00.0: wcn6855 hw2.0
[    9.456885] IRQ262 -> 0-7 CPU1
[    9.467067] IRQ263 -> 0-7 CPU2
[    9.481466] IRQ264 -> 0-7 CPU3
[    9.630594] IRQ265 -> 0-7 CPU4
[    9.630629] IRQ266 -> 0-7 CPU5
[    9.630655] IRQ267 -> 0-7 CPU6
[    9.630682] IRQ268 -> 0-7 CPU7
[    9.630709] IRQ269 -> 0-7 CPU0
[    9.630735] IRQ270 -> 0-7 CPU1
[    9.630764] IRQ271 -> 0-7 CPU2
[    9.640971] IRQ276 -> 0-7 CPU7
[    9.641039] IRQ277 -> 0-7 CPU0
[    9.641088] IRQ278 -> 0-7 CPU1
[    9.641138] IRQ280 -> 0-7 CPU3
[    9.641182] IRQ281 -> 0-7 CPU4
[    9.641227] IRQ282 -> 0-7 CPU5
[    9.651400] IRQ283 -> 0-7 CPU6
[    9.651442] IRQ284 -> 0-7 CPU7
[    9.651490] IRQ285 -> 0-7 CPU0
[    9.651534] IRQ286 -> 0-7 CPU1
[    9.813900] mhi mhi1: Requested to power ON
[    9.818607] mhi mhi1: Power on setup success
[   10.017482] mhi mhi1: Wait for device to enter SBL or Mission mode
[   10.862765] ath11k_pci 0006:01:00.0: chip_id 0x2 chip_family 0xb board_id 0x8c soc_id 0x400c0200
[   10.872101] ath11k_pci 0006:01:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

