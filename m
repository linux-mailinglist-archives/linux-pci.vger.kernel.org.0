Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204144BD0FB
	for <lists+linux-pci@lfdr.de>; Sun, 20 Feb 2022 20:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiBTTeV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 14:34:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244630AbiBTTeV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 14:34:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0BB4506C
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 11:33:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E37E60EF0
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 19:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5142C340F5;
        Sun, 20 Feb 2022 19:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645385638;
        bh=PblWfxvaUhZyRQBAqC2pjjMgYbO0y3fvBMCw0i0YvI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSmprwFw3gddkoe9XO5PiY7xPhM7xzxX6Dcygm0VB7yC4vFTkUEPvtJm2Z3k7EvTI
         YtoGoxnKz1rdIBrEShpwZm6JPtYgvRgHz/38zNL4aUoPM0pJiu/FZhPFUIDfbh9Emd
         hIhPNecHtMQzCDEaKEkoOUnjIX7kw9M9ybXJnvv9nYDAJL2THnuievMvmyORqLgygv
         VMTOELX6ezchbux5JVSTRyFbWIn7vln1HNtek20Mev00cW9/5nOdykLGIdfwIdTmbv
         /Dp0izX0yjqUvs6WHN7LpaB/Mkvufqh+Dx7kueCPLLsiqWHUdOSCnO+JCUo5EvLi3j
         phHmrnzvsFGjg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 03/18] PCI: aardvark: Add support for AER registers on emulated bridge
Date:   Sun, 20 Feb 2022 20:33:31 +0100
Message-Id: <20220220193346.23789-4-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220193346.23789-1-kabel@kernel.org>
References: <20220220193346.23789-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Aardvark controller supports Advanced Error Reporting configuration
registers.

Export these registers on the emulated root bridge via the new .read_ext
and .write_ext methods.

Note that in the Advanced Error Reporting Capability header the offset
to the next Extended Capability header is set, but it is not documented
in Armada 3700 Functional Specification. Since this change adds support
only for Advanced Error Reporting, explicitly clear PCI_EXT_CAP_NEXT
bits in AER capability header.

Now the pcieport driver correctly detects AER support and allows PCIe
AER driver to start receiving ERR interrupts. Kernel log now says:

    [    4.358401] pcieport 0000:00:00.0: AER: enabled with IRQ 52

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 77 +++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 7621c9344a2b..01dd530e1b5f 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -33,6 +33,7 @@
 #define PCIE_CORE_CMD_STATUS_REG				0x4
 #define PCIE_CORE_DEV_REV_REG					0x8
 #define PCIE_CORE_PCIEXP_CAP					0xc0
+#define PCIE_CORE_PCIERR_CAP					0x100
 #define PCIE_CORE_ERR_CAPCTL_REG				0x118
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX			BIT(5)
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX_EN			BIT(6)
@@ -945,11 +946,87 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 	}
 }
 
+static pci_bridge_emul_read_status_t
+advk_pci_bridge_emul_ext_conf_read(struct pci_bridge_emul *bridge,
+				   int reg, u32 *value)
+{
+	struct advk_pcie *pcie = bridge->data;
+
+	switch (reg) {
+	case 0:
+		*value = advk_readl(pcie, PCIE_CORE_PCIERR_CAP + reg);
+		/*
+		 * PCI_EXT_CAP_NEXT bits are set to offset 0x150, but Armada
+		 * 3700 Functional Specification does not document registers
+		 * at those addresses.
+		 * Thus we clear PCI_EXT_CAP_NEXT bits to make Advanced Error
+		 * Reporting Capability header the last of Extended
+		 * Capabilities. (If we obtain documentation for those
+		 * registers in the future, this can be changed.)
+		 */
+		*value &= 0x000fffff;
+		return PCI_BRIDGE_EMUL_HANDLED;
+
+	case PCI_ERR_UNCOR_STATUS:
+	case PCI_ERR_UNCOR_MASK:
+	case PCI_ERR_UNCOR_SEVER:
+	case PCI_ERR_COR_STATUS:
+	case PCI_ERR_COR_MASK:
+	case PCI_ERR_CAP:
+	case PCI_ERR_HEADER_LOG + 0:
+	case PCI_ERR_HEADER_LOG + 4:
+	case PCI_ERR_HEADER_LOG + 8:
+	case PCI_ERR_HEADER_LOG + 12:
+	case PCI_ERR_ROOT_COMMAND:
+	case PCI_ERR_ROOT_STATUS:
+	case PCI_ERR_ROOT_ERR_SRC:
+		*value = advk_readl(pcie, PCIE_CORE_PCIERR_CAP + reg);
+		return PCI_BRIDGE_EMUL_HANDLED;
+
+	default:
+		return PCI_BRIDGE_EMUL_NOT_HANDLED;
+	}
+}
+
+static void
+advk_pci_bridge_emul_ext_conf_write(struct pci_bridge_emul *bridge,
+				    int reg, u32 old, u32 new, u32 mask)
+{
+	struct advk_pcie *pcie = bridge->data;
+
+	switch (reg) {
+	/* These are W1C registers, so clear other bits */
+	case PCI_ERR_UNCOR_STATUS:
+	case PCI_ERR_COR_STATUS:
+	case PCI_ERR_ROOT_STATUS:
+		new &= mask;
+		fallthrough;
+
+	case PCI_ERR_UNCOR_MASK:
+	case PCI_ERR_UNCOR_SEVER:
+	case PCI_ERR_COR_MASK:
+	case PCI_ERR_CAP:
+	case PCI_ERR_HEADER_LOG + 0:
+	case PCI_ERR_HEADER_LOG + 4:
+	case PCI_ERR_HEADER_LOG + 8:
+	case PCI_ERR_HEADER_LOG + 12:
+	case PCI_ERR_ROOT_COMMAND:
+	case PCI_ERR_ROOT_ERR_SRC:
+		advk_writel(pcie, new, PCIE_CORE_PCIERR_CAP + reg);
+		break;
+
+	default:
+		break;
+	}
+}
+
 static const struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
 	.read_base = advk_pci_bridge_emul_base_conf_read,
 	.write_base = advk_pci_bridge_emul_base_conf_write,
 	.read_pcie = advk_pci_bridge_emul_pcie_conf_read,
 	.write_pcie = advk_pci_bridge_emul_pcie_conf_write,
+	.read_ext = advk_pci_bridge_emul_ext_conf_read,
+	.write_ext = advk_pci_bridge_emul_ext_conf_write,
 };
 
 /*
-- 
2.34.1

