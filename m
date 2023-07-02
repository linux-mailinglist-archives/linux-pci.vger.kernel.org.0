Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E47450F7
	for <lists+linux-pci@lfdr.de>; Sun,  2 Jul 2023 21:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjGBTns (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Jul 2023 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjGBTnD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Jul 2023 15:43:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28516E69;
        Sun,  2 Jul 2023 12:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D23A860CF6;
        Sun,  2 Jul 2023 19:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BA8C433C7;
        Sun,  2 Jul 2023 19:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326861;
        bh=uaWp8a1zwVsgrZZAqBBqvVXx6+HOy4XjWCEKR+CBq58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g40JoErJHvPfTUnGwIBnRJZ1x5xUqZqXoKCeCpGUA0tuII6aTPYHLHi6nGgwL7rH7
         r8tniHVR1vu/lK+mQ0H1PAgvDFNoOZHH9E7b/UDwmugw090HPLftShyGoR2XiI7g9n
         usk3LyRmt6nbw5rlgFHJkmQmlPnNkTIsY6erlLNVvOUoel+D2WdTuxR+B4eLtRPOp7
         YslcmQYmGAC7sIMFs56vCZLJqzWnoEM6SHfpmOelGtiTCHJudcLayTeWRnE7iV18g1
         xHY/T97DkaXN1vAKqvhAaeAr8DyynT8wtXYRBW+3wHxVFGRBfABhvM2GJWPy5/z6wA
         7W0y8hECOfVZA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Sasha Levin <sashal@kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        bhelgaas@google.com, linux@roeck-us.net, mario.limonciello@amd.com,
        linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 03/14] x86/amd_nb: Add MI200 PCI IDs
Date:   Sun,  2 Jul 2023 15:40:42 -0400
Message-Id: <20230702194053.1777356-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194053.1777356-1-sashal@kernel.org>
References: <20230702194053.1777356-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit e15885689cf4bc92356e52ea6ef38379a749819a ]

The AMD MI200 series accelerators are data center GPUs. They include
unified memory controllers and a data fabric similar to those used in
AMD x86 CPU products. The memory controllers report errors using MCA,
though these errors are generally handled through GPU drivers that
directly manage the accelerator device.

In some configurations, memory errors from these devices will be
reported through MCA and managed by x86 CPUs. The OS is expected to
handle these errors in similar fashion to MCA errors originating from
memory controllers on the CPUs. In Linux, this flow includes passing MCA
errors to a notifier chain with handlers in the EDAC subsystem.

The AMD64 EDAC module requires information from the memory controllers
and data fabric in order to provide detailed decoding of memory errors.
The information is read from hardware registers accessed through
interfaces in the data fabric.

The accelerator data fabrics are visible to the host x86 CPUs as PCI
devices just like x86 CPU data fabrics are already. However, the
accelerator fabrics have new and unique PCI IDs.

Add PCI IDs for the MI200 series of accelerator devices in order to
enable EDAC support. The data fabrics of the accelerator devices will be
enumerated as any other fabric already supported.  System-specific
implementation details will be handled within the AMD64 EDAC module.

  [ bp: Scrub off marketing speak. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Co-developed-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230515113537.1052146-2-muralimk@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/amd_nb.c | 5 +++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 7e331e8f36929..8fd955414b089 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -23,6 +23,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
 #define PCI_DEVICE_ID_AMD_19H_M60H_ROOT	0x14d8
 #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT	0x14e8
+#define PCI_DEVICE_ID_AMD_MI200_ROOT	0x14bb
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
@@ -37,6 +38,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4 0x12fc
+#define PCI_DEVICE_ID_AMD_MI200_DF_F4	0x14d4
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -53,6 +55,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
 	{}
 };
 
@@ -81,6 +84,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
 	{}
 };
 
@@ -101,6 +105,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
 	{}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 95f33dadb2be2..a99b1fcfc6174 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -568,6 +568,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
+#define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
-- 
2.39.2

