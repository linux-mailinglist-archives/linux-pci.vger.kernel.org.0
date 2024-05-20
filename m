Return-Path: <linux-pci+bounces-7661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DF28C9F10
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 16:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 837C1B20D7F
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 14:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DF0136E30;
	Mon, 20 May 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OO5YMqBI"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FD21369BE
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216861; cv=none; b=Zqo0Kw6eyTf15V2yYW/l9ALxkYlyaNGt1cRpGOkXHOzXkfii6bcdA9lEHEiEBFi1ly1wxb0Xc65nDLpBRJeCgQNEjGuhXK0vNVSMcLqkzN7ZAxh2uZMno4tcjv+Q6Tcz7zgdohLlSC5BY4Zdu1FaL4DsMdmNAgWXrnqX2Un0RyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216861; c=relaxed/simple;
	bh=jpJD3Ut/eKZ4vL397+AxVQqI1CgT5ITqcuH0Fk7f2Os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=entqLJpftAR1WnEzRJkoRjcCXutQ7uhNQmA7ExK12DniTGDJqB50V99OBnJm0U8zhpL8Tvq1apx+nkyEzUWuf//vGqqRNCnYSfuUE0NM8n4dgvgYK6h+DC9HJESjPvQemArVNr916BnyKt8XorYunTdO+fLQrIWWEkOV6tdArS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OO5YMqBI; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lpieralisi@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716216856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/t1FSYP+bGcYTDKpcE/G5Hl/ZwYo8lrjuzlYxLI6Fm8=;
	b=OO5YMqBIX0rj+TStl103p1v/ghce9G/17JW08A4sY1ddfg2Asm3i155oq3JolauPJrUV5D
	2HtoIA7KTiqXlf2oHn+GJuHBoPYAiBQ86I+Uksmybn0+gka2h3zeSIP0sZIHF9suGgI6xo
	L6fOZ37Bj/PiNZ8ixyC8vEx4RHsMpyY=
X-Envelope-To: kw@linux.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: thippeswamy.havalige@amd.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sean.anderson@linux.dev
X-Envelope-To: stable@vger.kernel.org
X-Envelope-To: bharatku@xilinx.com
X-Envelope-To: helgaas@kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	stable@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v3 2/7] PCI: xilinx-nwl: Fix off-by-one in IRQ handler
Date: Mon, 20 May 2024 10:53:57 -0400
Message-Id: <20240520145402.2526481-3-sean.anderson@linux.dev>
In-Reply-To: <20240520145402.2526481-1-sean.anderson@linux.dev>
References: <20240520145402.2526481-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

MSGF_LEG_MASK is laid out with INTA in bit 0, INTB in bit 1, INTC in bit
2, and INTD in bit 3. Hardware IRQ numbers start at 0, and we register
PCI_NUM_INTX irqs. So to enable INTA (aka hwirq 0) we should set bit 0.
Remove the subtraction of one. This fixes the following UBSAN error:

[    5.037483] ================================================================================
[    5.046260] UBSAN: shift-out-of-bounds in ../drivers/pci/controller/pcie-xilinx-nwl.c:389:11
[    5.054983] shift exponent 18446744073709551615 is too large for 32-bit type 'int'
[    5.062813] CPU: 1 PID: 61 Comm: kworker/u10:1 Not tainted 6.6.20+ #268
[    5.070008] Hardware name: xlnx,zynqmp (DT)
[    5.074348] Workqueue: events_unbound deferred_probe_work_func
[    5.080410] Call trace:
[    5.082958] dump_backtrace (arch/arm64/kernel/stacktrace.c:235)
[    5.086850] show_stack (arch/arm64/kernel/stacktrace.c:242)
[    5.090292] dump_stack_lvl (lib/dump_stack.c:107)
[    5.094095] dump_stack (lib/dump_stack.c:114)
[    5.097540] __ubsan_handle_shift_out_of_bounds (lib/ubsan.c:218 lib/ubsan.c:387)
[    5.103227] nwl_unmask_leg_irq (drivers/pci/controller/pcie-xilinx-nwl.c:389 (discriminator 1))
[    5.107386] irq_enable (kernel/irq/internals.h:234 kernel/irq/chip.c:170 kernel/irq/chip.c:439 kernel/irq/chip.c:432 kernel/irq/chip.c:345)
[    5.110838] __irq_startup (kernel/irq/internals.h:239 kernel/irq/chip.c:180 kernel/irq/chip.c:250)
[    5.114552] irq_startup (kernel/irq/chip.c:270)
[    5.118266] __setup_irq (kernel/irq/manage.c:1800)
[    5.121982] request_threaded_irq (kernel/irq/manage.c:2206)
[    5.126412] pcie_pme_probe (include/linux/interrupt.h:168 drivers/pci/pcie/pme.c:348)
[    5.130303] pcie_port_probe_service (drivers/pci/pcie/portdrv.c:528)
[    5.134915] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658)
[    5.138720] __driver_probe_device (drivers/base/dd.c:800)
[    5.143236] driver_probe_device (drivers/base/dd.c:830)
[    5.147571] __device_attach_driver (drivers/base/dd.c:959)
[    5.152179] bus_for_each_drv (drivers/base/bus.c:457)
[    5.156163] __device_attach (drivers/base/dd.c:1032)
[    5.160147] device_initial_probe (drivers/base/dd.c:1080)
[    5.164488] bus_probe_device (drivers/base/bus.c:532)
[    5.168471] device_add (drivers/base/core.c:3638)
[    5.172098] device_register (drivers/base/core.c:3714)
[    5.175994] pcie_portdrv_probe (drivers/pci/pcie/portdrv.c:309 drivers/pci/pcie/portdrv.c:363 drivers/pci/pcie/portdrv.c:695)
[    5.180338] pci_device_probe (drivers/pci/pci-driver.c:324 drivers/pci/pci-driver.c:392 drivers/pci/pci-driver.c:417 drivers/pci/pci-driver.c:460)
[    5.184410] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658)
[    5.188213] __driver_probe_device (drivers/base/dd.c:800)
[    5.192729] driver_probe_device (drivers/base/dd.c:830)
[    5.197064] __device_attach_driver (drivers/base/dd.c:959)
[    5.201672] bus_for_each_drv (drivers/base/bus.c:457)
[    5.205657] __device_attach (drivers/base/dd.c:1032)
[    5.209641] device_attach (drivers/base/dd.c:1074)
[    5.213357] pci_bus_add_device (drivers/pci/bus.c:352)
[    5.217518] pci_bus_add_devices (drivers/pci/bus.c:371 (discriminator 2))
[    5.221774] pci_host_probe (drivers/pci/probe.c:3099)
[    5.225581] nwl_pcie_probe (drivers/pci/controller/pcie-xilinx-nwl.c:938)
[    5.229562] platform_probe (drivers/base/platform.c:1404)
[    5.233367] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658)
[    5.237169] __driver_probe_device (drivers/base/dd.c:800)
[    5.241685] driver_probe_device (drivers/base/dd.c:830)
[    5.246020] __device_attach_driver (drivers/base/dd.c:959)
[    5.250628] bus_for_each_drv (drivers/base/bus.c:457)
[    5.254612] __device_attach (drivers/base/dd.c:1032)
[    5.258596] device_initial_probe (drivers/base/dd.c:1080)
[    5.262938] bus_probe_device (drivers/base/bus.c:532)
[    5.266920] deferred_probe_work_func (drivers/base/dd.c:124)
[    5.271619] process_one_work (arch/arm64/include/asm/jump_label.h:21 include/linux/jump_label.h:207 include/trace/events/workqueue.h:108 kernel/workqueue.c:2632)
[    5.275788] worker_thread (kernel/workqueue.c:2694 (discriminator 2) kernel/workqueue.c:2781 (discriminator 2))
[    5.279686] kthread (kernel/kthread.c:388)
[    5.283048] ret_from_fork (arch/arm64/kernel/entry.S:862)
[    5.286765] ================================================================================

Fixes: 9a181e1093af ("PCI: xilinx-nwl: Modify IRQ chip for legacy interrupts")
Cc: <stable@vger.kernel.org>
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v3:
- Expand commit message

 drivers/pci/controller/pcie-xilinx-nwl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 0408f4d612b5..437927e3bcca 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -371,7 +371,7 @@ static void nwl_mask_intx_irq(struct irq_data *data)
 	u32 mask;
 	u32 val;
 
-	mask = 1 << (data->hwirq - 1);
+	mask = 1 << data->hwirq;
 	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
 	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
 	nwl_bridge_writel(pcie, (val & (~mask)), MSGF_LEG_MASK);
@@ -385,7 +385,7 @@ static void nwl_unmask_intx_irq(struct irq_data *data)
 	u32 mask;
 	u32 val;
 
-	mask = 1 << (data->hwirq - 1);
+	mask = 1 << data->hwirq;
 	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
 	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
 	nwl_bridge_writel(pcie, (val | mask), MSGF_LEG_MASK);
-- 
2.35.1.1320.gc452695387.dirty


