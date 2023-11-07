Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098137E43F5
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 16:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbjKGPtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 10:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbjKGPs2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 10:48:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3135E19B7;
        Tue,  7 Nov 2023 07:47:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AA9C433C9;
        Tue,  7 Nov 2023 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372076;
        bh=+1VRTjbXJTkLkGN9z9w6zO37HUeSkHcAOFg1EbIg6ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GO6NGzLdto/OdSZ90d3QmX6ODxhxWxB3KGY2WiECuwzHv5Ze/keaVoavRmvRLYIiI
         fWIR2d4V21v3veyOZ27TcyKPAaxGVbsKTURTOWwX2sI2h5WLQRdrFnZC/2UjQ8fR+k
         hheKNV33F2isGMvZMSAKob0GqOfI3NxDiBPlmccGHxMFR8j3uaQrB0FPgVz/UBVrJ9
         rzT5atgwiCh3jPRLr49cwrx0yjl4F8C/KmrHLj2vlZe1mfKcrCu/HDRyYsgW3ueCqo
         zYEAt/6rdzlvloHH3ZleT6CFW9GfESl1S2849khvmmuOuQC+rMuFoy3qBIxGqODF0I
         QSN75isY3MfWg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 27/36] PCI: Disable ATS for specific Intel IPU E2000 devices
Date:   Tue,  7 Nov 2023 10:46:09 -0500
Message-ID: <20231107154654.3765336-27-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154654.3765336-1-sashal@kernel.org>
References: <20231107154654.3765336-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bartosz Pawlowski <bartosz.pawlowski@intel.com>

[ Upstream commit a18615b1cfc04f00548c60eb9a77e0ce56e848fd ]

Due to a hardware issue in A and B steppings of Intel IPU E2000, it expects
wrong endianness in ATS invalidation message body. This problem can lead to
outdated translations being returned as valid and finally cause system
instability.

To prevent such issues, add quirk_intel_e2000_no_ats() to disable ATS for
vulnerable IPU E2000 devices.

Link: https://lore.kernel.org/r/20230908143606.685930-3-bartosz.pawlowski@intel.com
Signed-off-by: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 81b3805c6d392..96fd0e6048ee2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5552,6 +5552,25 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7347, quirk_amd_harvest_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x734f, quirk_amd_harvest_no_ats);
 /* AMD Raven platform iGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
+
+/*
+ * Intel IPU E2000 revisions before C0 implement incorrect endianness
+ * in ATS Invalidate Request message body. Disable ATS for those devices.
+ */
+static void quirk_intel_e2000_no_ats(struct pci_dev *pdev)
+{
+	if (pdev->revision < 0x20)
+		quirk_no_ats(pdev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1451, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1452, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1453, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1454, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1455, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
-- 
2.42.0

