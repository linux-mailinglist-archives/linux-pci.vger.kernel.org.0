Return-Path: <linux-pci+bounces-21639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C099A3894B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 17:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312261883F5C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533A222540C;
	Mon, 17 Feb 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNWrqvUj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D482253BB;
	Mon, 17 Feb 2025 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810244; cv=none; b=PHlJedzwrzjvQB5ROnBi/+5N+gLvCZj1LlWRLEndrljaxh97xOi8gS5jSm66CzMg8T2qLIKGWhRBtjabw9lGLFfu9yEkzW7SmwdOK9K/5Wzh6n5ExfQrxM2SaCw011O1IWs5cuGZ1HsBlLjcvExdzFE+2EpIzQ4eKBnmI6nLX5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810244; c=relaxed/simple;
	bh=GG0kGpRIKt7R/dR+Zx4rNrL1ZPXiID8tq41Iz9zzsng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YkcKEPwjIwQfjQLDGTi6L0t2gCAV3sHgMzyS+CuGO6AgU0Cam0GxzMTQ29KyYDAkiSE+yJs4UAR2jw0PR0kP+T4NbQhvo7U+2M6qzEHYYIjwyNovNxwrfMBodzLQ1lwr3eJZTK6Ydt9Zx8LEZG7ugII6oPaBRmae490WWrY2eWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNWrqvUj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so30359165e9.3;
        Mon, 17 Feb 2025 08:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739810240; x=1740415040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yiZt2i6xSOw8eOJOYff501csDZIGzCac6UOW2wl3hpw=;
        b=TNWrqvUjk+xmn9Srqh9DOTZ+mC3CfvlrX3Av4ZLRahxk1OZ/+8EJplmwPhC1SyUZtG
         2wR6gz0W2n/Tw0lBUUijicgHsgj+PnIimcsIAelR5QlE6P4fuHNgBqqkXr4C1igfdIKG
         HtKLyFtzlklIIwEaQbxK0CNeEbay9pZ45RJprxo0F5nj7RPPOF2tixxG/X+jqXA9KvSy
         f3y1ppQjm2O8fjKPyMqJN4mp4RXB0PJ1CNs/5lhJsXAM0+7NsL7C+5OGkgEt3t/ArpBB
         qkBexWkhvzVUZqKmu8PeHFJVb7KBoN6Jry+qWmi+shJmQMcA0W4J0r/tdrVVQ9IK34HC
         IvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810240; x=1740415040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiZt2i6xSOw8eOJOYff501csDZIGzCac6UOW2wl3hpw=;
        b=mi4z/hUyXcGQ63Mw/xnFeV1ma0XraD9zTBhMycLMaGpTkb+ONym0ufCtMUHY4kOM3z
         qsdTyCgEpjCV1B0Rfuy/vJADZLJlltiqk5qj0dI2cQs2z1WUfbBekk2kBzXPVDv1r9C1
         ukgo7K3itdNTgCzTsMBKTAWqWAZenV/dtNXWGZfj+wgpQOoO4QtbFlSeDFZ4G6oauzWF
         d7izc9VCU2e21YXnjdGbeZ222c2A20y0NhaGJjlchsLpNMQQe8T4bqimutVH6l/PT3IU
         yw42jJtE1bqJwZ2a43hlHp2FjuBvpmxVHUlzKhMFtlmiFTDR26q22VqfYB/BXzxkxtGD
         /dwg==
X-Forwarded-Encrypted: i=1; AJvYcCUql0SGSHjXKImswp5Vmq7eTfhhEw4hKpuyglB65oEf/vOUoGTDVCn7VJ4AoNCIcNkm2ipD34lbti6N4rNV@vger.kernel.org, AJvYcCV4qyRLU+6YNUf+mgviCCYl1AD5qao8Y1K5KYXNlc/B0c5x54dKws6XG04RrWviSQ6Bf9hVbzS/JS8d@vger.kernel.org, AJvYcCVTYnL7VMgmZztQNq8YVCHvGFMcyYL/y4ei0VKv/Uy797X0TwoPv6tZFm3kfJUdMiDbXZLFMmjPFcM0@vger.kernel.org, AJvYcCWxl3V+MQbNCPRiwyPkc8V8aF+4t4VIno4uygPDMR2tyoZWX/Cw3s9XI+ECfELfN97CmM9BadkYkAmdvA==@vger.kernel.org, AJvYcCXsbDDqUh5mHGZbUW+W1CwSHNNvnNXfAcYVxpJUX1WhZynFk6QHbokIq75LRM6UgXJTPfKoADwYi8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEH83FBE+5Q4TH7PE6/4r66Jfa9dNbCuGea0ra1irflLUtUk8r
	gLQBhXobuCyM9NH9NrfNQDGQzYWc+L029FSpg+zMDL3mwmTzK4lc
X-Gm-Gg: ASbGnctf4nibycROtn8BQvCI55tuIMLvz53kszhOfb3k+MusVUeQ+HoHHZnF8aquTt/
	aRYmk0SZ64GOfQkQtGG0UaeKAqyHTDogvUE6Jo/KxAn3tF3i2NSZGEnCFTMibc6gAeZTXrl9h3V
	YppVO/OV/Ykvt7ydV+PnfI0rg+bq4fmZxr5isRzhHXTrWlhSnrsEDhYJfI3ffm21OyoATszxFAf
	1hjeitnbnNso7xGcB+DtOTLYfci6fvkQaKIB9QCNYot8VdZZ4kbCGR0w37M2bSp1a7Dxiztx2ya
	5NerQftHmG+LPJk7QIHSBT/OUrJ8Kb9juO8CFLFi199Qb2F20427lyUJsvjpPC0/0k8mO2IMpyR
	nkQv/ynk=
X-Google-Smtp-Source: AGHT+IFZaRz1DpftXgns+QX0TjkeJRpqUCBrHv7Z6/192+MAz8sD7WUt6O+3frJRvsZQb4k9gj7a7g==
X-Received: by 2002:a05:600c:4f56:b0:439:3c71:16be with SMTP id 5b1f17b1804b1-4396e6f66a1mr101592005e9.13.1739810240075;
        Mon, 17 Feb 2025 08:37:20 -0800 (PST)
Received: from localhost (p200300e41f22a600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f22:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439880fbd6fsm24614705e9.18.2025.02.17.08.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:37:18 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] syscore: Pass context data to callbacks
Date: Mon, 17 Feb 2025 17:37:06 +0100
Message-ID: <20250217163713.211949-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Hi,

Something that's been bugging me over the years is how some drivers have
had to adopt file-scoped variables to pass data into something like the
syscore operations. This is often harmless, but usually leads to drivers
not being able to deal with multiple instances, or additional frameworks
or data structures needing to be created to handle multiple instances.

This series proposes to "objectify" struct syscore_ops by passing a
pointer to struct syscore_ops to the syscore callbacks. Implementations
of these callbacks can then make use of container_of() to get access to
contextual data that struct syscore_ops was embedded in. This elegantly
avoids the need for file-scoped, singleton variables, by tying syscore
to individual instances.

Patch 1 contains the bulk of these changes. It's fairly intrusive
because it does the conversion of the function signature all in one
patch. An alternative would've been to introduce new callbacks such that
these changes could be staged in. However, the amount of changes here
are not quite numerous enough to justify that, in my opinion, and
syscore isn't very frequently used, so the risk of another user getting
added while this is merged is rather small. All in all I think merging
this in one go is the simplest way.

Patches 2-7 are conversions of some existing drivers to take advantage
of this new parameter and tie the code to per-instance data.

Given that the recipient list for this is huge, I'm limiting this to
Greg (because it's at the core a... core change) and a set of larger
lists for architectures and subsystems that are impacted.

Thanks,
Thierry

Thierry Reding (7):
  syscore: Pass context data to callbacks
  MIPS: Embed syscore_ops in PCI context
  bus: mvebu-mbus: Embed syscore_ops in mbus context
  clk: ingenic: tcu: Embed syscore_ops in TCU context
  clk: mvebu: Embed syscore_ops in clock context
  irqchip/irq-imx-gpcv2: Embed syscore_ops in chip context
  soc/tegra: pmc: Derive PMC context from syscore ops

 arch/arm/mach-exynos/mcpm-exynos.c        |  4 +-
 arch/arm/mach-exynos/suspend.c            | 14 +++---
 arch/arm/mach-pxa/irq.c                   |  4 +-
 arch/arm/mach-pxa/mfp-pxa2xx.c            |  4 +-
 arch/arm/mach-pxa/mfp-pxa3xx.c            |  4 +-
 arch/arm/mach-pxa/smemc.c                 |  4 +-
 arch/arm/mach-s3c/irq-pm-s3c64xx.c        |  4 +-
 arch/arm/mach-s5pv210/pm.c                |  2 +-
 arch/arm/mach-versatile/integrator_ap.c   |  4 +-
 arch/arm/mm/cache-b15-rac.c               |  4 +-
 arch/loongarch/kernel/smp.c               |  4 +-
 arch/mips/alchemy/common/dbdma.c          |  4 +-
 arch/mips/alchemy/common/irq.c            |  8 ++--
 arch/mips/alchemy/common/usb.c            |  4 +-
 arch/mips/pci/pci-alchemy.c               | 28 ++++++------
 arch/powerpc/platforms/cell/spu_base.c    |  2 +-
 arch/powerpc/platforms/powermac/pic.c     |  4 +-
 arch/powerpc/sysdev/fsl_lbc.c             |  4 +-
 arch/powerpc/sysdev/fsl_pci.c             |  4 +-
 arch/powerpc/sysdev/ipic.c                |  4 +-
 arch/powerpc/sysdev/mpic.c                |  4 +-
 arch/powerpc/sysdev/mpic_timer.c          |  2 +-
 arch/sh/mm/pmb.c                          |  2 +-
 arch/x86/events/amd/ibs.c                 |  4 +-
 arch/x86/hyperv/hv_init.c                 |  4 +-
 arch/x86/kernel/amd_gart_64.c             |  2 +-
 arch/x86/kernel/apic/apic.c               |  4 +-
 arch/x86/kernel/apic/io_apic.c            |  9 +++-
 arch/x86/kernel/cpu/aperfmperf.c          |  6 +--
 arch/x86/kernel/cpu/intel_epb.c           |  8 ++--
 arch/x86/kernel/cpu/mce/core.c            |  6 +--
 arch/x86/kernel/cpu/microcode/core.c      |  7 ++-
 arch/x86/kernel/cpu/mtrr/legacy.c         |  4 +-
 arch/x86/kernel/cpu/umwait.c              |  2 +-
 arch/x86/kernel/i8237.c                   |  2 +-
 arch/x86/kernel/i8259.c                   |  6 +--
 arch/x86/kernel/kvm.c                     |  4 +-
 drivers/acpi/pci_link.c                   |  2 +-
 drivers/acpi/sleep.c                      |  4 +-
 drivers/base/firmware_loader/main.c       |  2 +-
 drivers/base/syscore.c                    |  8 ++--
 drivers/bus/mvebu-mbus.c                  | 24 +++++-----
 drivers/clk/at91/pmc.c                    |  4 +-
 drivers/clk/imx/clk-vf610.c               |  4 +-
 drivers/clk/ingenic/pm.c                  |  4 +-
 drivers/clk/ingenic/tcu.c                 | 54 +++++++++++------------
 drivers/clk/mvebu/common.c                | 25 +++++++----
 drivers/clk/rockchip/clk-rk3288.c         |  4 +-
 drivers/clk/samsung/clk-s5pv210-audss.c   |  4 +-
 drivers/clk/samsung/clk.c                 |  4 +-
 drivers/clk/tegra/clk-tegra210.c          |  4 +-
 drivers/clocksource/timer-armada-370-xp.c |  4 +-
 drivers/cpuidle/cpuidle-psci.c            |  4 +-
 drivers/gpio/gpio-mxc.c                   |  4 +-
 drivers/gpio/gpio-pxa.c                   |  4 +-
 drivers/hv/vmbus_drv.c                    |  4 +-
 drivers/iommu/amd/init.c                  |  4 +-
 drivers/iommu/intel/iommu.c               |  4 +-
 drivers/irqchip/exynos-combiner.c         |  6 ++-
 drivers/irqchip/irq-armada-370-xp.c       |  4 +-
 drivers/irqchip/irq-bcm7038-l1.c          |  4 +-
 drivers/irqchip/irq-gic-v3-its.c          |  4 +-
 drivers/irqchip/irq-i8259.c               |  4 +-
 drivers/irqchip/irq-imx-gpcv2.c           | 33 ++++++--------
 drivers/irqchip/irq-loongson-eiointc.c    |  4 +-
 drivers/irqchip/irq-loongson-htpic.c      |  2 +-
 drivers/irqchip/irq-loongson-htvec.c      |  4 +-
 drivers/irqchip/irq-loongson-pch-lpc.c    |  4 +-
 drivers/irqchip/irq-loongson-pch-pic.c    |  4 +-
 drivers/irqchip/irq-mchp-eic.c            |  4 +-
 drivers/irqchip/irq-mst-intc.c            |  4 +-
 drivers/irqchip/irq-mtk-cirq.c            |  4 +-
 drivers/irqchip/irq-renesas-rzg2l.c       |  4 +-
 drivers/irqchip/irq-sa11x0.c              |  4 +-
 drivers/irqchip/irq-sifive-plic.c         |  4 +-
 drivers/irqchip/irq-sun6i-r.c             | 10 ++---
 drivers/irqchip/irq-tegra.c               |  4 +-
 drivers/irqchip/irq-vic.c                 |  4 +-
 drivers/leds/trigger/ledtrig-cpu.c        |  6 +--
 drivers/macintosh/via-pmu.c               |  4 +-
 drivers/power/reset/sc27xx-poweroff.c     |  2 +-
 drivers/sh/clk/core.c                     |  2 +-
 drivers/sh/intc/core.c                    |  4 +-
 drivers/soc/bcm/brcmstb/biuctrl.c         |  4 +-
 drivers/soc/tegra/pmc.c                   |  7 ++-
 drivers/thermal/intel/intel_hfi.c         |  4 +-
 drivers/xen/xen-acpi-processor.c          |  2 +-
 include/linux/syscore_ops.h               |  6 +--
 kernel/cpu_pm.c                           |  4 +-
 kernel/irq/generic-chip.c                 |  6 +--
 kernel/irq/pm.c                           |  2 +-
 kernel/printk/printk.c                    |  2 +-
 kernel/time/sched_clock.c                 | 14 +++++-
 kernel/time/timekeeping.c                 | 14 +++++-
 virt/kvm/kvm_main.c                       |  6 +--
 95 files changed, 302 insertions(+), 267 deletions(-)

-- 
2.48.1


