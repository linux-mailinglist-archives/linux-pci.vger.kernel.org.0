Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2537E3094
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 00:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjKFXGd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 18:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjKFXGc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 18:06:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28BBD77;
        Mon,  6 Nov 2023 15:06:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8147C433C8;
        Mon,  6 Nov 2023 23:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699311989;
        bh=tS2zKrKvHvG0lRZaa++gBljibvEozY3c59EsLxFV1yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZTUT2iXjPcv9HuucESa7d4Em7/eYl8zJ12faGVQKTTs9OYDLRmXxk0LTtu6NxeP0
         Jx3A3LAUAQLasVs9PiI7C/o1HosFtS9Hk95MRZx+ueBJ72dLjlv+/1LK4s5m3Bq/yz
         hhUYppl9ePSZNYH3Jp7G5bCkd9w+7FDI4FtBwtAh5hXdPD9ReN5/n5eon78fFgMaUU
         RmT19qLWeWWDX/QuM8P1fGga/ZG3tLXSfikTd771xPkl1LZyDk0NSO31LMRLMLiAsl
         5SwnckTsadRLCcYVWP8yH6M8mumHEWj1Bso0bdssbuTsby/xd6Hurq7vshzAApeZg1
         6AbOu5CBBjfhw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Muralidhara M K <muralidhara.mk@amd.com>,
        Suma Hegde <suma.hegde@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, yazen.ghannam@amd.com, Avadhut.Naik@amd.com,
        mario.limonciello@amd.com, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 2/5] x86/amd_nb: Add AMD Family MI300 PCI IDs
Date:   Mon,  6 Nov 2023 18:06:08 -0500
Message-ID: <20231106230622.3734225-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106230622.3734225-1-sashal@kernel.org>
References: <20231106230622.3734225-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

[ Upstream commit 24775700eaa93ff83b2a0f1e005879cdf186cdd9 ]

Add new Root, Device 18h Function 3, and Function 4 PCI IDS
for AMD F19h Model 90h-9fh (MI300A).

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Suma Hegde <suma.hegde@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20230926051932.193239-1-suma.hegde@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/amd_nb.c | 5 +++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 356de955e78dd..10c2a3c9114ea 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -27,6 +27,7 @@
 #define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
 #define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
 #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
+#define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
 
 #define PCI_DEVICE_ID_AMD_17H_DF_F4		0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4	0x15ec
@@ -43,6 +44,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
 #define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
+#define PCI_DEVICE_ID_AMD_MI300_DF_F4		0x152c
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -62,6 +64,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_ROOT) },
 	{}
 };
 
@@ -93,6 +96,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
 	{}
 };
 
@@ -115,6 +119,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F4) },
 	{}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5fb3d4c393a9e..91b457de262ed 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -579,6 +579,7 @@
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
 #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
+#define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
-- 
2.42.0

