Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F49048014C
	for <lists+linux-pci@lfdr.de>; Mon, 27 Dec 2021 16:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbhL0P63 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Dec 2021 10:58:29 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:47787 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240890AbhL0P5q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Dec 2021 10:57:46 -0500
Received: from handsomejack.molgen.mpg.de (handsomejack.molgen.mpg.de [141.14.17.248])
        by mx.molgen.mpg.de (Postfix) with ESMTP id DD8F761EA1922;
        Mon, 27 Dec 2021 16:57:43 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI: Add device code for AMD FCH SATA Controller in AHCI mode
Date:   Mon, 27 Dec 2021 16:57:33 +0100
Message-Id: <20211227155735.10519-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ASUS F2A85-M PRO with the fusion controller hub (FCH) AMD A85
(Hudson D4) has the SATA controller below.

    $ lspci -s 00:11.0
    00:11.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7801] (rev 40)

Add the ID for it, when in AHCI mode.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 011f2f1ea5bb..fe944b44858a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -602,6 +602,7 @@
 #define PCI_DEVICE_ID_AMD_LX_VIDEO  0x2081
 #define PCI_DEVICE_ID_AMD_LX_AES    0x2082
 #define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE	0x7800
+#define PCI_DEVICE_ID_AMD_HUDSON2_SATA_AHCI	0x7801
 #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
 #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
 #define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
-- 
2.30.2

