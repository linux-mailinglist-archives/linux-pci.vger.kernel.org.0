Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3FE5B4E53
	for <lists+linux-pci@lfdr.de>; Sun, 11 Sep 2022 13:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiIKLXX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 07:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiIKLXH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 07:23:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68C4BE15;
        Sun, 11 Sep 2022 04:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B93CB80B30;
        Sun, 11 Sep 2022 11:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BEEC43470;
        Sun, 11 Sep 2022 11:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662895313;
        bh=er6PPpsGMjDSr5/Bjluh+kJYhP3QEsmx3zX624mZfrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxAgF5KRpvyEOmdsPFSxAbqxhAje7fAm/vL/S1J1eG7vpsUfY/3vs4xRasKEDLKMo
         kgWSMVOyj3HMYIbTJPXQb9DgLZ+4uL7aW/l6WeZXkoPUTIvucLJARCbpbVL5kBaJVM
         wXvdS3navMSIariSS1SwkzrBPiMbTicnEOEL+N2Dy9MTe9EUflRWiqdijTHF9ekoBx
         J0zu7o5Xaf3L9GVfSlHj8L7x267n1g8LwHqr+GiVB9Dt7R6oC8gb8/UuM26FfRbuxq
         dWVNLBdZZgj6bhO7tMpZILv9ujeozzJDX3EWTq4wssaWjQKDWA+tEOzdvQsYq8eE78
         cSQDqBi0eLuKQ==
Received: by pali.im (Postfix)
        id CCC83AB8; Sun, 11 Sep 2022 13:21:50 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH 1/3] PCI: Add standard PCI Config Address macros
Date:   Sun, 11 Sep 2022 13:20:22 +0200
Message-Id: <20220911112024.14304-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220911112024.14304-1-pali@kernel.org>
References: <20220911112024.14304-1-pali@kernel.org>
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

Lot of PCI and PCIe controllers are using standard Config Address for PCI
Configuration Mechanism #1 (as defined inPCI Local Bus Specification) or
its extended version.

So introduce new macros PCI_CONF1_ADDRESS() and PCI_CONF1_EXT_ADDRESS() in
new include file linux/pci-conf1.h which can be suitable for PCI and PCIe
controllers which uses this type of access to PCI config space.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 include/linux/pci-conf1.h | 51 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 include/linux/pci-conf1.h

diff --git a/include/linux/pci-conf1.h b/include/linux/pci-conf1.h
new file mode 100644
index 000000000000..12d2c581a67f
--- /dev/null
+++ b/include/linux/pci-conf1.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright 2022 Pali Rohár <pali@kernel.org> */
+#ifndef PCI_CONF1_H
+#define PCI_CONF1_H
+
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
+#endif
-- 
2.20.1

