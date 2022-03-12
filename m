Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CF44D7105
	for <lists+linux-pci@lfdr.de>; Sat, 12 Mar 2022 22:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiCLVZa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Mar 2022 16:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiCLVZ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Mar 2022 16:25:29 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E333C2B26F;
        Sat, 12 Mar 2022 13:24:22 -0800 (PST)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7E8B4820A0;
        Sat, 12 Mar 2022 22:24:20 +0100 (CET)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v6 2/2] PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read which triggered an exception
Date:   Sat, 12 Mar 2022 22:23:49 +0100
Message-Id: <20220312212349.781799-2-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220312212349.781799-1-marek.vasut@gmail.com>
References: <20220312212349.781799-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
while a read value of faulting read should be PCI_ERROR_RESPONSE.

It is possible to enforce the fault using 'isb' instruction placed
right after the read/write instruction which started the faulting
access. Add custom register accessors which perform the read/write
followed immediately by 'isb'.

This way, the fault always happens on the 'isb' and in case of read,
which is located one instruction before the 'isb', it is now possible
to fix up the return value of the read in the asynchronous external
abort hook and make that read return PCI_ERROR_RESPONSE.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
V3: - Add .text.fixup on all three ldr/str/isb instructions and call
      fixup_exception() in the abort handler to trigger the fixup.
    - Propagate return value from read/write accessors, in case the
      access fails, return PCIBIOS_SET_FAILED, else PCIBIOS_SUCCESSFUL.
V4: - Cover both ldr/str and isb with the fixup
    - Add RB from Arnd
    - Use PCI_SET_ERROR_RESPONSE instead of val = 0xffffffff
    - Update commit message
V5: - Replace all Fs with PCI_ERROR_RESPONSE in commit message
    - Make rcar_pci_{read,write}_reg_workaround() static
V6: - Add RB/TB from Geert
    - Add .arch armv7-a to __rcar_pci_rw_reg_workaround() to fix clang
      build as suggested by Arnd
---
 drivers/pci/controller/pcie-rcar-host.c | 56 +++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 0966cf63d9b3..997c4df6a1e7 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -114,6 +114,54 @@ static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
 	return val >> shift;
 }
 
+#ifdef CONFIG_ARM
+#define __rcar_pci_rw_reg_workaround(instr)				\
+		"	.arch armv7-a\n"				\
+		"1:	" instr " %1, [%2]\n"				\
+		"2:	isb\n"						\
+		"3:	.pushsection .text.fixup,\"ax\"\n"		\
+		"	.align	2\n"					\
+		"4:	mov	%0, #" __stringify(PCIBIOS_SET_FAILED) "\n" \
+		"	b	3b\n"					\
+		"	.popsection\n"					\
+		"	.pushsection __ex_table,\"a\"\n"		\
+		"	.align	3\n"					\
+		"	.long	1b, 4b\n"				\
+		"	.long	2b, 4b\n"				\
+		"	.popsection\n"
+#endif
+
+static int rcar_pci_write_reg_workaround(struct rcar_pcie *pcie, u32 val,
+					 unsigned int reg)
+{
+	int error = PCIBIOS_SUCCESSFUL;
+#ifdef CONFIG_ARM
+	asm volatile(
+		__rcar_pci_rw_reg_workaround("str")
+	: "+r"(error):"r"(val), "r"(pcie->base + reg) : "memory");
+#else
+	rcar_pci_write_reg(pcie, val, reg);
+#endif
+	return error;
+}
+
+static int rcar_pci_read_reg_workaround(struct rcar_pcie *pcie, u32 *val,
+					unsigned int reg)
+{
+	int error = PCIBIOS_SUCCESSFUL;
+#ifdef CONFIG_ARM
+	asm volatile(
+		__rcar_pci_rw_reg_workaround("ldr")
+	: "+r"(error), "=r"(*val) : "r"(pcie->base + reg) : "memory");
+
+	if (error != PCIBIOS_SUCCESSFUL)
+		PCI_SET_ERROR_RESPONSE(val);
+#else
+	*val = rcar_pci_read_reg(pcie, reg);
+#endif
+	return error;
+}
+
 /* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
 static int rcar_pcie_config_access(struct rcar_pcie_host *host,
 		unsigned char access_type, struct pci_bus *bus,
@@ -185,14 +233,14 @@ static int rcar_pcie_config_access(struct rcar_pcie_host *host,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (access_type == RCAR_PCI_ACCESS_READ)
-		*data = rcar_pci_read_reg(pcie, PCIECDR);
+		ret = rcar_pci_read_reg_workaround(pcie, data, PCIECDR);
 	else
-		rcar_pci_write_reg(pcie, *data, PCIECDR);
+		ret = rcar_pci_write_reg_workaround(pcie, *data, PCIECDR);
 
 	/* Disable the configuration access */
 	rcar_pci_write_reg(pcie, 0, PCIECCTLR);
 
-	return PCIBIOS_SUCCESSFUL;
+	return ret;
 }
 
 static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
@@ -1097,7 +1145,7 @@ static struct platform_driver rcar_pcie_driver = {
 static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
 		unsigned int fsr, struct pt_regs *regs)
 {
-	return !!rcar_pcie_wakeup(pcie_dev, pcie_base);
+	return !fixup_exception(regs);
 }
 
 static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst = {
-- 
2.35.1

