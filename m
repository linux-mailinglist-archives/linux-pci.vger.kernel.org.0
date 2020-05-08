Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FF61CA497
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 08:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEHGyA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 02:54:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58490 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgEHGyA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 02:54:00 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jWwtI-0004Yb-Ck; Fri, 08 May 2020 06:53:48 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Je Yen Tam <je.yen.tam@ni.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jay Dolan <jay.dolan@accesio.com>,
        Denis Efremov <efremov@linux.com>,
        "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Subject: [PATCH 1/2] serial: 8250_pci: Move Pericom IDs to pci_ids.h
Date:   Fri,  8 May 2020 14:53:40 +0800
Message-Id: <20200508065343.32751-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the IDs to pci_ids.h so it can be used by next patch.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/tty/serial/8250/8250_pci.c | 6 ------
 include/linux/pci_ids.h            | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 0804469ff052..1a74d511b02a 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1869,12 +1869,6 @@ pci_moxa_setup(struct serial_private *priv,
 #define PCIE_DEVICE_ID_WCH_CH384_4S	0x3470
 #define PCIE_DEVICE_ID_WCH_CH382_2S	0x3253
 
-#define PCI_VENDOR_ID_PERICOM			0x12D8
-#define PCI_DEVICE_ID_PERICOM_PI7C9X7951	0x7951
-#define PCI_DEVICE_ID_PERICOM_PI7C9X7952	0x7952
-#define PCI_DEVICE_ID_PERICOM_PI7C9X7954	0x7954
-#define PCI_DEVICE_ID_PERICOM_PI7C9X7958	0x7958
-
 #define PCI_VENDOR_ID_ACCESIO			0x494f
 #define PCI_DEVICE_ID_ACCESIO_PCIE_COM_2SDB	0x1051
 #define PCI_DEVICE_ID_ACCESIO_MPCIE_COM_2S	0x1053
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1dfc4e1dcb94..9a57e6717e5c 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1832,6 +1832,12 @@
 #define PCI_VENDOR_ID_NVIDIA_SGS	0x12d2
 #define PCI_DEVICE_ID_NVIDIA_SGS_RIVA128 0x0018
 
+#define PCI_VENDOR_ID_PERICOM			0x12D8
+#define PCI_DEVICE_ID_PERICOM_PI7C9X7951	0x7951
+#define PCI_DEVICE_ID_PERICOM_PI7C9X7952	0x7952
+#define PCI_DEVICE_ID_PERICOM_PI7C9X7954	0x7954
+#define PCI_DEVICE_ID_PERICOM_PI7C9X7958	0x7958
+
 #define PCI_SUBVENDOR_ID_CHASE_PCIFAST		0x12E0
 #define PCI_SUBDEVICE_ID_CHASE_PCIFAST4		0x0031
 #define PCI_SUBDEVICE_ID_CHASE_PCIFAST8		0x0021
-- 
2.17.1

