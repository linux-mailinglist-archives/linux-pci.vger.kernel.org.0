Return-Path: <linux-pci+bounces-17174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 894739D5100
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 17:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A13C1F25516
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D541C4A24;
	Thu, 21 Nov 2024 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYo2BJuZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B31AF0A1;
	Thu, 21 Nov 2024 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207937; cv=none; b=Gp8DWXf6BDjGHXxFg2/RZhamgs41a9qOwfHOfe4/zNs3/aOgW42vPJgGKoU2aFzEehPe2JHO9ganmEAKiTpX8qpiUGOsHmYWDjra/9IjUJAOCpGrLCtQG2v+1lmD5GV1v0KZd4Xi3f99z5ij/vD7pVxvnyN/3chUvnRwrNEQOa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207937; c=relaxed/simple;
	bh=Y1mdkaWrTYBIUMxo9h4PUiMiMSW1f7efHaVFCg8rH+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=L6juSyJOZ9y6fR5y7wVctLw/vxHGE+tMzc8IORGMz3mIjha1S6Ui91rZYwVfTUIWNk5UX7t9f3E7meGyI3bgyhxfX6wqeYu1uaJGyGm11IPaGfOtW+dZE9+uFmHB9XTZgeIxt4+R79S+y51mD+jrE+uIdhKuUE1BIK36FktD/Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYo2BJuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700DCC4CECD;
	Thu, 21 Nov 2024 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732207937;
	bh=Y1mdkaWrTYBIUMxo9h4PUiMiMSW1f7efHaVFCg8rH+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PYo2BJuZiGgGaGHKxMuoPyEkgU9X6/+IiLSg6tzkmfOcpyiJ4i0KZD0BHxqHyjA6F
	 Mn3ln0UQl26TsQRjrnXkInQ5QY7ehMxAJ7ABgPWWoB5QR8MBzko9SqUGyD4AfbHeRQ
	 46/ZWcq9NyMJ0vd3geu4IWg2lY0DDQtgeaeh2Pox3ykLSG5ubjQyZaRXvMz3uA1chp
	 kdDBJXWejAMxmX1G+n2YBco2aT3L4hM2BYloZU+DaGXrZWa7HLOhzG4XVUxMWalAQy
	 rgl6IKcDEQhiclOeA4Q+H47l7zBUby097H3Yi0olwltj1lEdNAUQnB6MAAibYqBOUC
	 up7dS2LYAMc5A==
Date: Thu, 21 Nov 2024 10:52:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: PCI <linux-pci@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: next-20241121: arm64: of_pci_supply_present
 (drivers/pci/of.c:746) - Unable to handle kernel NULL pointer dereference at
 virtual address 0000000000000058
Message-ID: <20241121165216.GA2388449@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYurbY3B6ahZ+k+Syp5bZ3a+YQdeX8DRb6Twi4BDEFbUsw@mail.gmail.com>

[+cc Krzysztof]

On Thu, Nov 21, 2024 at 08:21:38PM +0530, Naresh Kamboju wrote:
> The juno-r2, qemu-arm64 and qemu-armv7 boot failed on the Linux-next tree.
> Please find the crash log below.

Thanks for the very detailed problem report!

I think this should be fixed by
https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=278dd091e95d,
which added back the "if (!np)" check in of_pci_supply_present().

> First seen on the next-20241121 tag.
> Good: next-20241120
> Bad:  next-20241121
> 
> Juno-r2, qemu-arm64:
> * boot/gcc-13-lkftconfig
> * boot/clang-nightly-lkftconfig
> * boot/gcc-13-lkftconfig-perf
> 
> qemu-armv7:
> * boot/gcc-13-lkftconfig
> * boot/clang-19-lkftconfig
> 
> 
> Boot crash log on arm64:
> -----------
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> [    0.000000] Linux version 6.12.0-next-20241121 (tuxmake@tuxmake)
> (aarch64-linux-gnu-gcc (Debian 13.3.0-5) 13.3.0, GNU ld (GNU Binutils
> for Debian) 2.43.1) #1 SMP PREEMPT @1732169734
> ...
> [    2.118104] pci_bus 0000:08: resource 0 [io  0x2000-0x2fff]
> [    2.123710] pci_bus 0000:08: resource 1 [mem 0x50100000-0x501fffff]
> [    2.130054] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000058
> [    2.138868] Mem abort info:
> [    2.141672]   ESR = 0x0000000096000004
> [    2.145435]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    2.150765]   SET = 0, FnV = 0
> [    2.153832]   EA = 0, S1PTW = 0
> [    2.156994]   FSC = 0x04: level 0 translation fault
> [    2.161888] Data abort info:
> [    2.164781]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    2.170283]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    2.175351]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    2.180680] [0000000000000058] user address but active_mm is swapper
> [    2.187055] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    2.193333] Modules linked in:
> [    2.196393] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.12.0-next-20241121 #1
> [    2.204151] Hardware name: ARM Juno development board (r2) (DT)
> [    2.210078] pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    2.217053] pc : of_pci_supply_present (drivers/pci/of.c:746)
> [    2.221685] lr : pci_bus_add_device (drivers/pci/bus.c:408 (discriminator 1))
> [    2.226135] sp : ffff800082f5ba70
> [    2.229450] x29: ffff800082f5ba70 x28: ffff8000827ce000 x27: ffff8000823e0118
> [    2.236607] x26: ffff8000822f65c8 x25: ffff8000823be4f0 x24: ffff00082111a428
> [    2.243762] x23: ffff0008218a8800 x22: 0000000000000000 x21: ffff000800a230c8
> [    2.250916] x20: ffff000800a8a400 x19: ffff000800a23000 x18: ffffffffffffffff
> [    2.258069] x17: 00000000f3b41269 x16: 000000006984274c x15: ffff800082f5b8c0
> [    2.265224] x14: ffff800102f5ba47 x13: ffff800082f5ba4b x12: ffff800080b5dee0
> [    2.272378] x11: ffff8000800171b0 x10: 000000000000002e x9 : ffff80008084b910
> [    2.279532] x8 : ffff800082f5b8e8 x7 : 0000000000000000 x6 : 0000000000000001
> [    2.286685] x5 : ffff000800a3a850 x4 : 0000000000000000 x3 : 0000000000000198
> [    2.293839] x2 : 0000000000000000 x1 : ffff000800a8a400 x0 : 0000000000000000
> [    2.300992] Call trace:
> [    2.303438] of_pci_supply_present+0x18/0x78 P
> [    2.308065] pci_bus_add_device+0x90/0x208 L
> [    2.312515] pci_bus_add_device (drivers/pci/bus.c:408 (discriminator 1))
> [    2.316616] pci_bus_add_devices (drivers/pci/bus.c:435 (discriminator 2))
> [    2.320718] pci_host_probe (drivers/pci/probe.c:3362
> drivers/pci/probe.c:3132)
> [    2.324472] pci_host_common_probe
> (drivers/pci/controller/pci-host-common.c:80)
> [    2.328924] platform_probe (drivers/base/platform.c:1404)
> [    2.332595] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658)
> [    2.336176] __driver_probe_device (drivers/base/dd.c:800)
> [    2.340540] driver_probe_device (drivers/base/dd.c:830)
> [    2.344730] __driver_attach (drivers/base/dd.c:1217)
> [    2.348572] bus_for_each_dev (drivers/base/bus.c:370)
> [    2.352413] driver_attach (drivers/base/dd.c:1235)
> [    2.355994] bus_add_driver (drivers/base/bus.c:675)
> [    2.359835] driver_register (drivers/base/driver.c:246)
> [    2.363677] __platform_driver_register (drivers/base/platform.c:868)
> [    2.368391] gen_pci_driver_init
> (drivers/pci/controller/pci-host-generic.c:87)
> [    2.372495] do_one_initcall (init/main.c:1266)
> [    2.376338] kernel_init_freeable (init/main.c:1327 (discriminator
> 1) init/main.c:1344 (discriminator 1) init/main.c:1363 (discriminator
> 1) init/main.c:1577 (discriminator 1))
> [    2.380705] kernel_init (init/main.c:1470)
> [    2.384200] ret_from_fork (arch/arm64/kernel/entry.S:863)
> [ 2.387784] Code: d503233f a9be7bfd 910003fd a90153f3 (f9402c13)
> All code
> ========
>    0: d503233f paciasp
>    4: a9be7bfd stp x29, x30, [sp, #-32]!
>    8: 910003fd mov x29, sp
>    c: a90153f3 stp x19, x20, [sp, #16]
>   10:* f9402c13 ldr x19, [x0, #88] <-- trapping instruction
> 
> Code starting with the faulting instruction
> ===========================================
>    0: f9402c13 ldr x19, [x0, #88]
> [    2.393886] ---[ end trace 0000000000000000 ]---
> [    2.398565] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    2.406234] SMP: stopping secondary CPUs
> [    2.410169] Kernel Offset: disabled
> [    2.413658] CPU features: 0x080,00020c3c,00800000,0200421b
> [    2.419150] Memory Limit: none
> [    2.422207] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x0000000b ]---
> 
> 
> Links:
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241121/testrun/25983314/suite/boot/test/gcc-13-lkftconfig-rcutorture/log
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241121/testrun/25978784/suite/boot/test/gcc-13-lkftconfig/log
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241121/testrun/25978784/suite/boot/test/gcc-13-lkftconfig/details/
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241121/testrun/25978784/suite/boot/test/gcc-13-lkftconfig/history/
> 
> 
> Build image:
> -----------
> - https://storage.tuxsuite.com/public/linaro/lkft/builds/2p9DUGD8S9fakSvceaAXMeGBRs7/
> 
> Steps to reproduce:
> ------------
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2p9DVXtRiqTj7VZO9wnFlkwmU8g/reproducer
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2p9DVXtRiqTj7VZO9wnFlkwmU8g/tux_plan
> 
> metadata:
> ----
> Linux version: 6.12.0-next-20241121
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git
> git sha: decc701f41d07481893fdea942c0ac6b226e84cd
> kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2p9DUGD8S9fakSvceaAXMeGBRs7/config
> build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2p9DUGD8S9fakSvceaAXMeGBRs7/
> toolchain: gcc-13 and clang-19
> config: gcc-13-lkftconfig
> arch: arm64 and armv7
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

