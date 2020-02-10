Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D19D157135
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 09:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgBJIxA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 03:53:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59939 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgBJIxA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2020 03:53:00 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j14oK-0006s0-CM; Mon, 10 Feb 2020 08:52:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/ACPI: make array pcie_to_hpx3_type static const, makes object smaller
Date:   Mon, 10 Feb 2020 08:52:56 +0000
Message-Id: <20200210085256.319424-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array pcie_to_hpx3_type on the stack but instead
make it static const. Makes the object code smaller by 6 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  19247	   3048	     64	  22359	   5757	drivers/pci/pci-acpi.o

After:
   text	   data	    bss	    dec	    hex	filename
  19177	   3112	     64	  22353	   5751	drivers/pci/pci-acpi.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/pci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 0c02d500158f..d914f8bc31ea 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -439,7 +439,7 @@ enum hpx_type3_dev_type {
 static u16 hpx3_device_type(struct pci_dev *dev)
 {
 	u16 pcie_type = pci_pcie_type(dev);
-	const int pcie_to_hpx3_type[] = {
+	static const int pcie_to_hpx3_type[] = {
 		[PCI_EXP_TYPE_ENDPOINT]    = HPX_TYPE_ENDPOINT,
 		[PCI_EXP_TYPE_LEG_END]     = HPX_TYPE_LEG_END,
 		[PCI_EXP_TYPE_RC_END]      = HPX_TYPE_RC_END,
-- 
2.25.0

