Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D51721BCAB
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 20:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbfEMSIV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 14:08:21 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13488 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbfEMSIT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 14:08:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9b28e0000>; Mon, 13 May 2019 11:08:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 11:08:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 11:08:18 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:08:14 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 18:08:10 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 04/29] PCI: tegra: Mask AFI_INTR in runtime suspend
Date:   Mon, 13 May 2019 23:37:19 +0530
Message-ID: <20190513180744.16493-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513180744.16493-1-mmaddireddy@nvidia.com>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557770894; bh=IRRs6fyoP57ouHG7qWgXOeOuYZVnMG1AsTdNf1pg0Jo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=SytnjacdYrpGYdmur/79P7CdfQzhnCYy/1jDZXTg5FwDDs9jWZ25OLA0PngQ9GEKX
         7QgypqqgYua1FMnenqsU0DcBla3DtSyyPW0YotxwNjEjgtGa5Dqe1WyJyvKeL3L3m5
         VNw1X89jr3j8nV1mOXU4wcoz7h+SltQzye1KgUj0drDFeOlobPGWhBVlcqNpOJ4ONu
         oiu62iNvrBmKtG9xJh24/gc7NKA3Z8U1msfk9ggpijWrRKShHRP6dV9B9RcSeRD7by
         RffOeNBVbkUkrZAD6WKTCGJpPXVHotzdXcJjeEbVeyzpoD1yB2nqzAEOuIx5hJXwqd
         1m7i5lmVlIwag==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

AFI_INTR is unmasked in tegra_pcie_enable_controller(), mask it to avoid
unwanted interrupts raised by AFI after pex_rst is asserted.

Following sequence triggers such scenario,
 - tegra_pcie_remove() triggers runtime suspend
 - pex_rst is asserted in runtime suspend
 - PRSNT_MAP bit field in RP_PRIV_MISC register changes from EP_PRSNT to
   EP_ABSNT
 - This is sensed by AFI and triggers "Slot present pin change" interrupt
 - tegra_pcie_isr() function accesses AFI register when runtime suspend
   is going through power off sequence

rmmod pci-tegra
 pci_generic_config_write32: 108 callbacks suppressed
 pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x4c may corrupt adjacent RW1C bits
 pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x9c may corrupt adjacent RW1C bits
 pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x88 may corrupt adjacent RW1C bits
 pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x90 may corrupt adjacent RW1C bits
 pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x4 may corrupt adjacent RW1C bits
 igb 0002:04:00.1: removed PHC on enP2p4s0f1
 igb 0002:04:00.0: removed PHC on enP2p4s0f0
 pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x4c may corrupt adjacent RW1C bits
 pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x9c may corrupt adjacent RW1C bits
 pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x88 may corrupt adjacent RW1C bits
 pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x90 may corrupt adjacent RW1C bits
 pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x4 may corrupt adjacent RW1C bits
 rcu: INFO: rcu_preempt self-detected stall on CPU
 SError Interrupt on CPU0, code 0xbf000002 -- SError
 CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.1.0-rc3-next-20190405-00027-gcd8110499e6f-dirty #42
 Hardware name: NVIDIA Jetson TX1 Developer Kit (DT)
 pstate: 20000085 (nzCv daIf -PAN -UAO)
 pc : tegra_pcie_isr+0x58/0x178 [pci_tegra]
 lr : tegra_pcie_isr+0x40/0x178 [pci_tegra]
 sp : ffff000010003da0
 x29: ffff000010003da0 x28: 0000000000000000
 x27: ffff8000f9e61000 x26: ffff000010fbf420
 x25: ffff000011427f93 x24: ffff8000fa600410
 x23: ffff00001129d000 x22: ffff00001129d000
 x21: ffff8000f18bf3c0 x20: 0000000000000070
 x19: 00000000ffffffff x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000000
 x15: 0000000000000000 x14: ffff000008d40a48
 x13: ffff000008d40a30 x12: ffff000008d40a20
 x11: ffff000008d40a10 x10: ffff000008d40a00
 x9 : ffff000008d409e8 x8 : ffff000008d40ae8
 x7 : ffff000008d40ad0 x6 : ffff000010003e58
 x5 : ffff8000fac00248 x4 : 0000000000000000
 x3 : ffff000008d40b08 x2 : fffffffffffffff8
 x1 : ffff000008d3f4e8 x0 : 00000000ffffffff
 Kernel panic - not syncing: Asynchronous SError Interrupt
 CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.1.0-rc3-next-20190405-00027-gcd8110499e6f-dirty #42
 Hardware name: NVIDIA Jetson TX1 Developer Kit (DT)
 Call trace:
  dump_backtrace+0x0/0x158
  show_stack+0x14/0x20
  dump_stack+0xa8/0xcc
  panic+0x140/0x2f4
  nmi_panic+0x6c/0x70
  arm64_serror_panic+0x74/0x80
  __pte_error+0x0/0x28
  el1_error+0x84/0xf8
  tegra_pcie_isr+0x58/0x178 [pci_tegra]
  __handle_irq_event_percpu+0x70/0x198
  handle_irq_event_percpu+0x34/0x88
  handle_irq_event+0x48/0x78
  handle_fasteoi_irq+0xb4/0x190
  generic_handle_irq+0x24/0x38
  __handle_domain_irq+0x5c/0xb8
  gic_handle_irq+0x58/0xa8
  el1_irq+0xb8/0x180
  cpuidle_enter_state+0x138/0x358
  cpuidle_enter+0x18/0x20
  call_cpuidle+0x1c/0x48
  do_idle+0x230/0x2d0
  cpu_startup_entry+0x20/0x28
  rest_init+0xd4/0xe0
  arch_call_rest_init+0xc/0x14
  start_kernel+0x444/0x470

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V3:
* Update the commit log and comment to reflect why this fix is required
* MSI interrupt is not disabled

V2: This is new patch in V2

 drivers/pci/controller/pci-tegra.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index bb3c0af9c830..d0e517f084a1 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1622,6 +1622,15 @@ static int tegra_pcie_disable_msi(struct tegra_pcie *pcie)
 	return 0;
 }
 
+static void tegra_pcie_disable_interrupts(struct tegra_pcie *pcie)
+{
+	u32 value;
+
+	value = afi_readl(pcie, AFI_INTR_MASK);
+	value &= ~AFI_INTR_MASK_INT_MASK;
+	afi_writel(pcie, value, AFI_INTR_MASK);
+}
+
 static int tegra_pcie_get_xbar_config(struct tegra_pcie *pcie, u32 lanes,
 				      u32 *xbar)
 {
@@ -2466,6 +2475,11 @@ static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
 		tegra_pcie_pme_turnoff(port);
 
 	tegra_pcie_disable_ports(pcie);
+	/*
+	 * AFI_INTR is unmasked in tegra_pcie_enable_controller(), mask it to
+	 * avoid unwanted interrupts raised by AFI after pex_rst is asserted.
+	 */
+	tegra_pcie_disable_interrupts(pcie);
 
 	if (pcie->soc->program_uphy) {
 		err = tegra_pcie_phy_power_off(pcie);
-- 
2.17.1

