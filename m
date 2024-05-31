Return-Path: <linux-pci+bounces-8125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F0A8D667A
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 18:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB326B21A62
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D957415B12C;
	Fri, 31 May 2024 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w2FIGB0I"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B49172793
	for <linux-pci@vger.kernel.org>; Fri, 31 May 2024 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172035; cv=none; b=OtAEkHF2NhC3L1hY1nVktAQjK40GNLuDwVx4MvK1S+2oudlTX6SN2GoKCWPF7RbjRxg+kc/Xovh8X+qR+LsdJUCg5ijVdevI3v4Yt5AiahaEiRODywA3sORiKB4L6oRzBC6NU1s4NzDa5IKj4sBqRHyT5FAnO3UpPc7mTuiEuhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172035; c=relaxed/simple;
	bh=XYS6GElq0yArJgxoxvyHPMS3W4BDecfj/Oq019zf3Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XI3YFij5/Pq0Espc3zKELNalRsLdtKBb0b92uo3M8buJUX8xTvKkUW8nzPxQVqrwztY8Hx1u6AoIuK8zPdz8oT9suvIJSfko/k/qnzb/Q+xInYEOiDhQhlavmObhAvxJMLTx560bYK3Xy/5iM9PV766AzO8pJGhkcQwf+qpCCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w2FIGB0I; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lpieralisi@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717172032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qaf7wlJcbuaI5XLr7jlnJohIFPCzjuNsqqKvlQY7mnY=;
	b=w2FIGB0INIhu6VVvsFM5KwIGw4z7lIFwD8CKxzGHIC739QzQmk2STRcVji1Ca84PW+sl91
	0zp2Uiw5YUmH0jFB5Hf4777v2LPsoFbDiYlQJbIEr0B+3F2pr+gOPfQ+usbw2psr2x9opw
	uMROgDK+ucm0Dla8+Dj4+FOVc5xZXvQ=
X-Envelope-To: kw@linux.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: thippeswamy.havalige@amd.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: markus.elfring@web.de
X-Envelope-To: dan.carpenter@linaro.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: michal.simek@amd.com
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
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	stable@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v4 2/7] PCI: xilinx-nwl: Fix off-by-one in IRQ handler
Date: Fri, 31 May 2024 12:13:32 -0400
Message-Id: <20240531161337.864994-3-sean.anderson@linux.dev>
In-Reply-To: <20240531161337.864994-1-sean.anderson@linux.dev>
References: <20240531161337.864994-1-sean.anderson@linux.dev>
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
Remove the subtraction of one.

This bug would cause legacy interrupts not to be delivered, as enabling
INTB would actually enable INTA, and enabling INTA wouldn't enable
anything at all. It is likely that this got overlooked for so long since
most PCIe hardware uses MSIs. This fixes the following UBSAN error:

UBSAN: shift-out-of-bounds in ../drivers/pci/controller/pcie-xilinx-nwl.c:389:11
shift exponent 18446744073709551615 is too large for 32-bit type 'int'
CPU: 1 PID: 61 Comm: kworker/u10:1 Not tainted 6.6.20+ #268
Hardware name: xlnx,zynqmp (DT)
Workqueue: events_unbound deferred_probe_work_func
Call trace:
dump_backtrace (arch/arm64/kernel/stacktrace.c:235)
show_stack (arch/arm64/kernel/stacktrace.c:242)
dump_stack_lvl (lib/dump_stack.c:107)
dump_stack (lib/dump_stack.c:114)
__ubsan_handle_shift_out_of_bounds (lib/ubsan.c:218 lib/ubsan.c:387)
nwl_unmask_leg_irq (drivers/pci/controller/pcie-xilinx-nwl.c:389 (discriminator 1))
irq_enable (kernel/irq/internals.h:234 kernel/irq/chip.c:170 kernel/irq/chip.c:439 kernel/irq/chip.c:432 kernel/irq/chip.c:345)
__irq_startup (kernel/irq/internals.h:239 kernel/irq/chip.c:180 kernel/irq/chip.c:250)
irq_startup (kernel/irq/chip.c:270)
__setup_irq (kernel/irq/manage.c:1800)
request_threaded_irq (kernel/irq/manage.c:2206)
pcie_pme_probe (include/linux/interrupt.h:168 drivers/pci/pcie/pme.c:348)
<snip>

Fixes: 9a181e1093af ("PCI: xilinx-nwl: Modify IRQ chip for legacy interrupts")
Cc: <stable@vger.kernel.org>
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v4:
- Explain likely effects of the off-by-one error
- Trim down UBSAN backtrace

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


