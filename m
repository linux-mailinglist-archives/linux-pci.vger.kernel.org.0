Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0D8366D8B
	for <lists+linux-pci@lfdr.de>; Wed, 21 Apr 2021 16:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbhDUOFQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Apr 2021 10:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235783AbhDUOFQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Apr 2021 10:05:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69E2761139;
        Wed, 21 Apr 2021 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619013883;
        bh=5OGO+AtIx6WC8ePcztw83ciGI9Z5SbHrkm/X3Q/Y7f0=;
        h=From:To:Cc:Subject:Date:From;
        b=eB67MTjq1psoXvHTQBleOqpux5gfW5UyclZRw2tiFBrku45n7JUn1WoU3mHeg7vB3
         4qrUEMSNojag57boD66K1yeBc+9zJJvpdnraUSrlLp9sA3F2wr4THlCvQrlB/S+wF5
         ND2NR/oKya4a6Buc+wDjwm9uB6B6aBFqVYQWKKGOCHjBhA2Iha55H33J0oGRp0vxRe
         LueLFx5FNR9neosH0M34nXESLRwKpCdIP6vRQT1pxMiyMdvN3iensgnl2SpC5EvCTY
         w1OGu8uTX8j7WHG2Ju36+zDFbYIZLn+LsEghKFDPFgDcyDKMHB9Fm6BNRN93gZiTEu
         zhWrql+5sQBaw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Prike Liang <Prike.Liang@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: fix unused variable warning
Date:   Wed, 21 Apr 2021 16:04:20 +0200
Message-Id: <20210421140436.3882411-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The function was introduced with a variable that is never referenced:

drivers/pci/quirks.c: In function 'quirk_amd_nvme_fixup':
drivers/pci/quirks.c:312:25: warning: unused variable 'rdev' [-Wunused-variable]

Fixes: 9597624ef606 ("nvme: put some AMD PCIE downstream NVME device to simple suspend/resume path")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/quirks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2e24dced699a..c86ede081534 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -309,8 +309,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopci
 
 static void quirk_amd_nvme_fixup(struct pci_dev *dev)
 {
-	struct pci_dev *rdev;
-
 	dev->dev_flags |= PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND;
 	pci_info(dev, "AMD simple suspend opt enabled\n");
 
-- 
2.29.2

