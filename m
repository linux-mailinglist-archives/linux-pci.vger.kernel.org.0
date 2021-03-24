Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD53C3476E1
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 12:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhCXLNc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 07:13:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39601 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhCXLN0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Mar 2021 07:13:26 -0400
Received: from 1-171-92-165.dynamic-ip.hinet.net ([1.171.92.165] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lP1Ry-0007U3-7w; Wed, 24 Mar 2021 11:13:22 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: Disable D3cold support on Intel XMM7360
Date:   Wed, 24 Mar 2021 19:13:16 +0800
Message-Id: <20210324111316.250576-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On some platforms, the root port for Intel XMM7360 WWAN supports D3cold.
When the root port is put to D3cold by system suspend or runtime
suspend, attempt to systems resume or runtime resume will freeze the
laptop for a while, then it automatically shuts down.

The root cause is unclear for now, as the Intel XMM7360 doesn't have a
driver yet.

So disable D3cold for XMM7360 as a workaround, until proper device
driver is in place.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212419
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..8ca8153e4a19 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5612,3 +5612,10 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
+
+static void pci_fixup_no_d3cold(struct pci_dev *pdev)
+{
+	pci_info(pdev, "disable D3cold\n");
+	pci_d3cold_disable(pdev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7360, pci_fixup_no_d3cold);
-- 
2.30.2

