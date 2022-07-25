Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C625802DE
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 18:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbiGYQjU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 12:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbiGYQjQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 12:39:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90D251D0D7;
        Mon, 25 Jul 2022 09:39:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1666139F;
        Mon, 25 Jul 2022 09:39:13 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2424C3F73D;
        Mon, 25 Jul 2022 09:39:13 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     will@kernel.org, bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
        kw@linux.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 2/4] arm64: PCI: Enable SMC conduit
Date:   Mon, 25 Jul 2022 11:39:03 -0500
Message-Id: <20220725163905.2024437-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220725163905.2024437-1-jeremy.linton@arm.com>
References: <20220725163905.2024437-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Given that most arm64 platforms' PCI implementations need quirks
to deal with problematic config accesses, this is a good place
to apply a firmware abstraction. The ARM PCI Configuration Space
Access Firmware Interface specification details a standard SMC
conduit designed to provide a simple PCI config accessor. This
specification enhances the existing ACPI/PCI abstraction and
expects power, config, etc., is handled by the platform. It also
is very explicit that the resulting config space registers must
behave as is specified by the PCI specification.

Hook the ACPI/PCI config path, and when missing MCFG data is
detected, attempt to probe the SMC conduit. If the conduit
exists and responds to the requested segment,  provided by the
ACPI namespace, attach a custom pci_ecam_ops which redirects
all config read/write requests to the firmware.

The Arm PCI Configuration Space Access Firmware Interface:
https://developer.arm.com/documentation/den0115/latest

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/pci.c | 109 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 2276689b5411..beb4289a7471 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/arm-smccc.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -122,6 +123,112 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 	return status;
 }
 
+int pcie_has_fw_conduit(void)
+{
+	struct arm_smccc_res res;
+
+	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE)
+		return -EOPNOTSUPP;
+
+	arm_smccc_1_1_invoke(SMCCC_PCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
+	if ((int)res.a0 < 0)
+		return -EOPNOTSUPP;
+
+	arm_smccc_1_1_invoke(SMCCC_PCI_FEATURES,
+			     SMCCC_PCI_WRITE, 0, 0, 0, 0, 0, 0, &res);
+	if ((int)res.a0 < 0)
+		return -EOPNOTSUPP;
+
+	arm_smccc_1_1_invoke(SMCCC_PCI_FEATURES,
+			     SMCCC_PCI_READ, 0, 0, 0, 0, 0, 0, &res);
+	if ((int)res.a0 < 0)
+		return -EOPNOTSUPP;
+
+	arm_smccc_1_1_invoke(SMCCC_PCI_FEATURES,
+			     SMCCC_PCI_SEG_INFO, 0, 0, 0, 0, 0, 0, &res);
+	if ((int)res.a0 < 0)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int smccc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
+				  int where, int size, u32 *val)
+{
+	struct arm_smccc_res res;
+
+	devfn |= bus->number << 8;
+	devfn |= bus->domain_nr << 16;
+
+	arm_smccc_1_1_invoke(SMCCC_PCI_READ, devfn, where, size,
+			     0, 0, 0, 0, &res);
+	if (res.a0) {
+		*val = ~0;
+		return -PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	*val = res.a1;
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int smccc_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 val)
+{
+	struct arm_smccc_res res;
+
+	devfn |= bus->number << 8;
+	devfn |= bus->domain_nr << 16;
+
+	arm_smccc_1_1_invoke(SMCCC_PCI_WRITE, devfn, where, size, val,
+			     0, 0, 0, &res);
+	if (res.a0)
+		return -PCIBIOS_BAD_REGISTER_NUMBER;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static const struct pci_ecam_ops smccc_pcie_ops = {
+	.pci_ops	= {
+		.read		= smccc_pcie_config_read,
+		.write		= smccc_pcie_config_write,
+	}
+};
+
+
+struct pci_config_window *
+pci_setup_fw_mapping(struct device *dev, u16 seg, struct resource *bus_res)
+{
+	struct arm_smccc_res res;
+	struct pci_config_window *cfg;
+
+	arm_smccc_1_1_invoke(SMCCC_PCI_SEG_INFO, seg, 0, 0, 0, 0, 0, 0, &res);
+	if ((int)res.a0 < 0) {
+		pr_warn("PCI: SMC segment %d doesn't exist\n", seg);
+		return NULL;
+	}
+
+	if (FIELD_GET(SMCCC_PCI_SEG_INFO_START_BUS, res.a1) != bus_res->start ||
+	    FIELD_GET(SMCCC_PCI_SEG_INFO_END_BUS, res.a1) != bus_res->end) {
+		pr_warn("PCI: SMC segment %d doesn't match ACPI description\n", seg);
+		return NULL;
+	}
+
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return NULL;
+
+	cfg->parent = dev;
+	cfg->ops = &smccc_pcie_ops;
+	cfg->busr.start = FIELD_GET(SMCCC_PCI_SEG_INFO_START_BUS, res.a1);
+	cfg->busr.end = FIELD_GET(SMCCC_PCI_SEG_INFO_END_BUS, res.a1);
+	cfg->busr.flags = IORESOURCE_BUS;
+	cfg->res.name = "PCI SMCCC";
+
+	pr_info("PCI: SMC conduit attached to segment %d\n", seg);
+
+	return cfg;
+}
+
 /*
  * Lookup the bus range for the domain in MCFG, and set up config space
  * mapping.
@@ -140,6 +247,8 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
 
 	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
 	if (ret) {
+		if (!pcie_has_fw_conduit())
+			return pci_setup_fw_mapping(dev, seg, bus_res);
 		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
 		return NULL;
 	}
-- 
2.37.1

