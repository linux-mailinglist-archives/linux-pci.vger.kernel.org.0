Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9ECD49118F
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jan 2022 23:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbiAQWER (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 17:04:17 -0500
Received: from phobos.denx.de ([85.214.62.61]:47624 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233580AbiAQWER (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jan 2022 17:04:17 -0500
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4F64F832DB;
        Mon, 17 Jan 2022 23:04:15 +0100 (CET)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: rcar: Return all Fs from read which triggered an exception
Date:   Mon, 17 Jan 2022 23:03:55 +0100
Message-Id: <20220117220355.92575-2-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117220355.92575-1-marek.vasut@gmail.com>
References: <20220117220355.92575-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

In case the controller is transitioning to L1 in rcar_pcie_config_access(),
any read/write access to PCIECDR triggers asynchronous external abort. This
is because the transition to L1 link state must be manually finished by the
driver. The PCIe IP can transition back from L1 state to L0 on its own.

The current asynchronous external abort hook implementation restarts
the instruction which finally triggered the fault, which can be a
different instruction than the read/write instruction which started
the faulting access. Usually the instruction which finally triggers
the fault is one which has some data dependency on the result of the
read/write. In case of read, the read value after fixup is undefined,
while a read value of faulting read should be all Fs.

It is possible to enforce the fault using 'isb' instruction placed
right after the read/write instruction which started the faulting
access. Add custom register accessors which perform the read/write
followed immediately by 'isb'.

This way, the fault always happens on the 'isb' and in case of read,
which is located one instruction before the 'isb', it is now possible
to fix up the return value of the read in the asynchronous external
abort hook and make that read return all Fs.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Wilczyński <kw@linux.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Rebase on 1/2
---
 drivers/pci/controller/pcie-rcar-host.c | 67 ++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index f0a0d560fefc..875dd5d417ee 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -107,6 +107,35 @@ static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
 	return val >> shift;
 }
 
+void rcar_pci_write_reg_workaround(struct rcar_pcie *pcie, u32 val, unsigned int reg)
+{
+#ifdef CONFIG_ARM
+	asm volatile(
+		"	str %0, [%1]\n"
+		"	isb\n"
+	::"r"(val), "r"(pcie->base + reg):"memory");
+#else
+	rcar_pci_write_reg(pcie, val, reg);
+#endif
+}
+
+u32 rcar_pci_read_reg_workaround(struct rcar_pcie *pcie, unsigned int reg)
+{
+#ifdef CONFIG_ARM
+	u32 val;
+
+	asm volatile(
+		"rcar_pci_read_reg_workaround_start:\n"
+		"1:	ldr %0, [%1]\n"
+		"	isb\n"
+	: "=r"(val):"r"(pcie->base + reg):"memory");
+
+	return val;
+#else
+	return rcar_pci_read_reg(pcie, reg);
+#endif
+}
+
 /* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
 static int rcar_pcie_config_access(struct rcar_pcie_host *host,
 		unsigned char access_type, struct pci_bus *bus,
@@ -179,9 +208,9 @@ static int rcar_pcie_config_access(struct rcar_pcie_host *host,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (access_type == RCAR_PCI_ACCESS_READ)
-		*data = rcar_pci_read_reg(pcie, PCIECDR);
+		*data = rcar_pci_read_reg_workaround(pcie, PCIECDR);
 	else
-		rcar_pci_write_reg(pcie, *data, PCIECDR);
+		rcar_pci_write_reg_workaround(pcie, *data, PCIECDR);
 
 	/* Disable the configuration access */
 	rcar_pci_write_reg(pcie, 0, PCIECCTLR);
@@ -1091,7 +1120,11 @@ static struct platform_driver rcar_pcie_driver = {
 static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
 		unsigned int fsr, struct pt_regs *regs)
 {
+	extern u32 *rcar_pci_read_reg_workaround_start;
+	unsigned long pc = instruction_pointer(regs);
+	unsigned long instr = *(unsigned long *)pc;
 	unsigned long flags;
+	u32 reg, val;
 	int ret = 0;
 
 	spin_lock_irqsave(&pmsr_lock, flags);
@@ -1101,6 +1134,36 @@ static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
 	if (ret)
 		goto unlock_exit;
 
+	/*
+	 * Test whether the faulting instruction is 'isb' and if
+	 * so, test whether it is the 'isb' instruction within
+	 * rcar_pci_read_reg_workaround() asm volatile()
+	 * implementation of read access. If it is, fix it up.
+	 */
+	instr &= ~0xf;
+	if ((instr == 0xf57ff060 || instr == 0xf3bf8f60) &&
+	    (pc == (u32)&rcar_pci_read_reg_workaround_start + 4)) {
+		/*
+		 * If the instruction being executed was a read,
+		 * make it look like it read all-ones.
+		 */
+		instr = *(unsigned long *)(pc - 4);
+		reg = (instr >> 12) & 15;
+
+		if ((instr & 0x0c100000) == 0x04100000) {
+			if (instr & 0x00400000)
+				val = 255;
+			else
+				val = -1;
+
+			regs->uregs[reg] = val;
+			regs->ARM_pc += 4;
+		} else if ((instr & 0x0e100090) == 0x00100090) {
+			regs->uregs[reg] = -1;
+			regs->ARM_pc += 4;
+		}
+	}
+
 unlock_exit:
 	spin_unlock_irqrestore(&pmsr_lock, flags);
 	return ret;
-- 
2.34.1

