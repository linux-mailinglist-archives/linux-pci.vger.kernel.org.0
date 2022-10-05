Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5098F5F4DF8
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 04:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJEC6b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Oct 2022 22:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJEC62 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2022 22:58:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC4566A42;
        Tue,  4 Oct 2022 19:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E67CAB81C82;
        Wed,  5 Oct 2022 02:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56335C433C1;
        Wed,  5 Oct 2022 02:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664938702;
        bh=nhuFmYnUCX7jGJj/igSj3CBNeD2gxo/OyINL/iZYw0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z6FtTcPBhKTiSZSffH3UtpW32C7jS8vHajBjEoeQkKPqbZSsZd7QwXJvXfagcUEes
         37SB3Vl5nVRgwuz1p2zkDUmIsG+oKoO+hI3L6x4DwSHKGWPhQTU1w1CUWJdDarTIT6
         lu+UaWl1toEsxifP5fsrZZ4re3A+LLm0cm+W9fG+MXzVJympMVgOcnC7Rymi3OyBBO
         YeNvsIVZ6IKaWCKZXi+o+kfnGqH2hl5Gd4ruNG0yF0j2zkpipEHI/dSuy3MziKMs6X
         j6M/Jc/D8CuHXV0C4K4Aatss/PYmFgGe7bhGhfonTtT1GrwWwURqzTHBBJC9JLmfXA
         AlsY3mPb+ncNQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        "Saheed O . Bolarinwa" <refactormyself@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, sagupta@nvidia.com,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/3] PCI/ASPM: Correct LTR_L1.2_THRESHOLD computation
Date:   Tue,  4 Oct 2022 21:58:09 -0500
Message-Id: <20221005025809.2247547-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005025809.2247547-1-helgaas@kernel.org>
References: <20221005025809.2247547-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

80d7d7a904fa ("PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device
characteristics") replaced a fixed value (163840ns) with one computed from
T_POWER_OFF, Common_Mode_Restore_Time, etc., but it encoded the
LTR_L1.2_THRESHOLD value incorrectly.

This is especially a problem for small thresholds, e.g., 63ns fell into the
"threshold_ns < 1024" case and was encoded as 32ns:

  LTR_L1.2_THRESHOLD_Scale = 1 (multiplier is 32ns)
  LTR_L1.2_THRESHOLD_Value = 63 >> 5 = 1
  LTR_L1.2_THRESHOLD       = multiplier * value = 32ns * 1 = 32ns

Correct the algorithm to encode all times of 1023ns (0x3ff) or smaller
exactly and larger times conservatively (the encoded threshold is never
smaller than was requested).  This reduces the chance of entering L1.2
when the device can't tolerate the exit latency.

Fixes: 80d7d7a904fa ("PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristics")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 49 +++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index f12d117f44e0..53a1fa306e1e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
@@ -350,29 +351,43 @@ static u32 calc_l1ss_pwron(struct pci_dev *pdev, u32 scale, u32 val)
 	return 0;
 }
 
+/*
+ * Encode an LTR_L1.2_THRESHOLD value for the L1 PM Substates Control 1
+ * register.  Ports enter L1.2 when the most recent LTR value is greater
+ * than or equal to LTR_L1.2_THRESHOLD, so we round up to make sure we
+ * don't enter L1.2 too aggressively.
+ *
+ * See PCIe r6.0, sec 5.5.1, 6.18, 7.8.3.3.
+ */
 static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 {
-	u32 threshold_ns = threshold_us * 1000;
+	u64 threshold_ns = (u64) threshold_us * 1000;
 
-	/* See PCIe r3.1, sec 7.33.3 and sec 6.18 */
-	if (threshold_ns < 32) {
-		*scale = 0;
+	/*
+	 * LTR_L1.2_THRESHOLD_Value ("value") is a 10-bit field with max
+	 * value of 0x3ff.
+	 */
+	if (threshold_ns <= 0x3ff * 1) {
+		*scale = 0;		/* Value times 1ns */
 		*value = threshold_ns;
-	} else if (threshold_ns < 1024) {
-		*scale = 1;
-		*value = threshold_ns >> 5;
-	} else if (threshold_ns < 32768) {
-		*scale = 2;
-		*value = threshold_ns >> 10;
-	} else if (threshold_ns < 1048576) {
-		*scale = 3;
-		*value = threshold_ns >> 15;
-	} else if (threshold_ns < 33554432) {
-		*scale = 4;
-		*value = threshold_ns >> 20;
+	} else if (threshold_ns <= 0x3ff * 32) {
+		*scale = 1;		/* Value times 32ns */
+		*value = roundup(threshold_ns, 32) / 32;
+	} else if (threshold_ns <= 0x3ff * 1024) {
+		*scale = 2;		/* Value times 1024ns */
+		*value = roundup(threshold_ns, 1024) / 1024;
+	} else if (threshold_ns <= 0x3ff * 32768) {
+		*scale = 3;		/* Value times 32768ns */
+		*value = roundup(threshold_ns, 32768) / 32768;
+	} else if (threshold_ns <= 0x3ff * 1048576) {
+		*scale = 4;		/* Value times 1048576ns */
+		*value = roundup(threshold_ns, 1048576) / 1048576;
+	} else if (threshold_ns <= 0x3ff * (u64) 33554432) {
+		*scale = 5;		/* Value times 33554432ns */
+		*value = roundup(threshold_ns, 33554432) / 33554432;
 	} else {
 		*scale = 5;
-		*value = threshold_ns >> 25;
+		*value = 0x3ff;		/* Max representable value */
 	}
 }
 
-- 
2.25.1

