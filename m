Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BE97C41C9
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 22:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343973AbjJJUpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343997AbjJJUoz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 16:44:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0A8B9;
        Tue, 10 Oct 2023 13:44:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C72BC43397;
        Tue, 10 Oct 2023 20:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696970691;
        bh=WdPz6d8tv1u5/JHFuBigckTTNr5z1gq7AjsRKY5KDp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQ9Mws9B8+8AJ5quBuIe1U6uRRvbJPuvXTTez7/YqK5f9W0I6JttEkuukAKteW2zK
         Ob9J2/9KNJKm4XwNSxq1eOQD8AGZ1iuTQhX0xLRSGzqVDHMGgtrNnXL1EJPD5xt30G
         b2qN7NTWFno3uMTBta8k5GUNzRk8ITfQeLXGS43mqIBOrCfmfszK0MRUbBjFdDSYpj
         tvm/GUVN7kZNbrSJmujEeAsRgqFIPpKfuATI7lB9+OKc1WNgYDMSjVFqzD2xiT5zZ3
         dJsKXg/jJbbbINxyBwd5zZ7WOhzjkF/0IJgEBiSCVunO/7KWKU6nzNOKR7hrkQxenP
         DnK4YT0uxwyyw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 04/10] PCI/ATS: Show PASID Capability register width in bitmasks
Date:   Tue, 10 Oct 2023 15:44:30 -0500
Message-Id: <20231010204436.1000644-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010204436.1000644-1-helgaas@kernel.org>
References: <20231010204436.1000644-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The PASID Capability and Control registers are both 16 bits wide.  Use
16-bit wide constants in field names to match the register width.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/uapi/linux/pci_regs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 34bf037993f3..6af1f8d53e97 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -930,12 +930,12 @@
 
 /* Process Address Space ID */
 #define PCI_PASID_CAP		0x04    /* PASID feature register */
-#define  PCI_PASID_CAP_EXEC	0x02	/* Exec permissions Supported */
-#define  PCI_PASID_CAP_PRIV	0x04	/* Privilege Mode Supported */
+#define  PCI_PASID_CAP_EXEC	0x0002	/* Exec permissions Supported */
+#define  PCI_PASID_CAP_PRIV	0x0004	/* Privilege Mode Supported */
 #define PCI_PASID_CTRL		0x06    /* PASID control register */
-#define  PCI_PASID_CTRL_ENABLE	0x01	/* Enable bit */
-#define  PCI_PASID_CTRL_EXEC	0x02	/* Exec permissions Enable */
-#define  PCI_PASID_CTRL_PRIV	0x04	/* Privilege Mode Enable */
+#define  PCI_PASID_CTRL_ENABLE	0x0001	/* Enable bit */
+#define  PCI_PASID_CTRL_EXEC	0x0002	/* Exec permissions Enable */
+#define  PCI_PASID_CTRL_PRIV	0x0004	/* Privilege Mode Enable */
 #define PCI_EXT_CAP_PASID_SIZEOF	8
 
 /* Single Root I/O Virtualization */
-- 
2.34.1

