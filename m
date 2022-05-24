Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654B2532B50
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 15:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbiEXN2k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 May 2022 09:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbiEXN2h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2022 09:28:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683979968A
        for <linux-pci@vger.kernel.org>; Tue, 24 May 2022 06:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AF40B818B7
        for <linux-pci@vger.kernel.org>; Tue, 24 May 2022 13:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA515C34115;
        Tue, 24 May 2022 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653398912;
        bh=TlGaA7hI88kQo15q3YO5BXzaB73KRgiVSkeusjnPXTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TtgUihCJP+lMcAL7FariDYkmagO47UeMuHOaUD4mMEwLpKpI3zr0gWCTJ6RVGI17x
         DXlR3jnnt0mrDeXffW6bkjvF/5I5lBTmxBBzaYYRbUilLgaoZE4MiTe8NocmKNw8ra
         BmO6TwCk6hEXBM1YRu6BPjQxHFxxR7x+wrSOhkOuVcMbtKsIZfTnYY1h+aR/o7L1eW
         Z2HctR69WmAovKmPlzZbl2g7yOOy2IuQrsIJ6AXnAsm7BwcCuAAWHb/E9EvXkLw/SW
         qvvNin8cLY49AdFTxdpDYoOlVZwEYx+KbejeggSDgaNfk43jq/MxQkCd3o0iVqZljc
         WZlUYmgYuZOGw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 1/2] PCI: aardvark: Add support for AER registers on emulated bridge
Date:   Tue, 24 May 2022 15:28:26 +0200
Message-Id: <20220524132827.8837-2-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524132827.8837-1-kabel@kernel.org>
References: <20220524132827.8837-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/controller/pci-aardvark.c | 77 +++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index ffec82c8a523..d71c9bc95934 100644
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
@@ -944,11 +945,87 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
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
2.35.1

