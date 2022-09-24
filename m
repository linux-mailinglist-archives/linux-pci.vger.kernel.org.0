Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7B35E8AB7
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 11:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiIXJYW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 05:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiIXJYV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 05:24:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE7D13943C;
        Sat, 24 Sep 2022 02:24:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CDDF60B6A;
        Sat, 24 Sep 2022 09:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0A9C43470;
        Sat, 24 Sep 2022 09:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664011459;
        bh=DVEFPqU3wBfERUZGu5+AFcIyKGtbL9TKbE9pFcNWQMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zeo10YzhHgfRlvW8OOFKZ0mQ63AdfWV2/FIvJ2XjfQCW6bL/ZIsuNU9p0hYyJsP9R
         1bpIMO2F0TvgDU8Syq+gvI45BW73JKRqxWHCegiVChijWtrz4pQ0JhRI2VVn3BddAW
         RmKoHDs8DfR+P+yuYPoMHrbXYzycoBC6ox9jwRBamRnHUkoOUtMqZhfKu9y9sBopIo
         Fno1RJJCpiaG+zoE+0FIagGPDPzr5jt6hfa7wgpjpmAv9cBtpeUww/oak66/7KXdez
         5Khog4/8leAWSpeiw6gmveEhlQwyhTF0X0tZM9QpduNHnuDdo/FOROi3Wxd2qDUVsT
         Qy/Wcq/FjoQaw==
Received: by pali.im (Postfix)
        id D0D4A1113; Sat, 24 Sep 2022 11:24:16 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/3] PCI: Add standard PCI Config Address macros
Date:   Sat, 24 Sep 2022 11:24:02 +0200
Message-Id: <20220924092404.31776-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220924092404.31776-1-pali@kernel.org>
References: <20220924092404.31776-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lot of PCI and PCIe controllers are using standard Config Address for PCI
Configuration Mechanism #1 (as defined in PCI Local Bus Specification) or
its extended version.

So introduce new macros PCI_CONF1_ADDRESS() and PCI_CONF1_EXT_ADDRESS() in
include file drivers/pci/pci.h which can be suitable for PCI and PCIe
controllers which uses this type of access to PCI config space.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/pci.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 785f31086313..88bd77107103 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -774,4 +774,49 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 }
 #endif
 
+/*
+ * Config Address for PCI Configuration Mechanism #1
+ *
+ * See PCI Local Bus Specification, Revision 3.0,
+ * Section 3.2.2.3.2, Figure 3-2, p. 50.
+ */
+
+#define PCI_CONF1_BUS_SHIFT	16 /* Bus number */
+#define PCI_CONF1_DEV_SHIFT	11 /* Device number */
+#define PCI_CONF1_FUNC_SHIFT	8  /* Function number */
+
+#define PCI_CONF1_BUS_MASK	0xff
+#define PCI_CONF1_DEV_MASK	0x1f
+#define PCI_CONF1_FUNC_MASK	0x7
+#define PCI_CONF1_REG_MASK	0xfc /* Limit aligned offset to a maximum of 256B */
+
+#define PCI_CONF1_ENABLE	BIT(31)
+#define PCI_CONF1_BUS(x)	(((x) & PCI_CONF1_BUS_MASK) << PCI_CONF1_BUS_SHIFT)
+#define PCI_CONF1_DEV(x)	(((x) & PCI_CONF1_DEV_MASK) << PCI_CONF1_DEV_SHIFT)
+#define PCI_CONF1_FUNC(x)	(((x) & PCI_CONF1_FUNC_MASK) << PCI_CONF1_FUNC_SHIFT)
+#define PCI_CONF1_REG(x)	((x) & PCI_CONF1_REG_MASK)
+
+#define PCI_CONF1_ADDRESS(bus, dev, func, reg) \
+	(PCI_CONF1_ENABLE | \
+	 PCI_CONF1_BUS(bus) | \
+	 PCI_CONF1_DEV(dev) | \
+	 PCI_CONF1_FUNC(func) | \
+	 PCI_CONF1_REG(reg))
+
+/*
+ * Extension of PCI Config Address for accessing extended PCIe registers
+ *
+ * No standardized specification, but used on lot of non-ECAM-compliant ARM SoCs
+ * or on AMD Barcelona and new CPUs. Reserved bits [27:24] of PCI Config Address
+ * are used for specifying additional 4 high bits of PCI Express register.
+ */
+
+#define PCI_CONF1_EXT_REG_SHIFT	16
+#define PCI_CONF1_EXT_REG_MASK	0xf00
+#define PCI_CONF1_EXT_REG(x)	(((x) & PCI_CONF1_EXT_REG_MASK) << PCI_CONF1_EXT_REG_SHIFT)
+
+#define PCI_CONF1_EXT_ADDRESS(bus, dev, func, reg) \
+	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
+	 PCI_CONF1_EXT_REG(reg))
+
 #endif /* DRIVERS_PCI_H */
-- 
2.20.1

