Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1BD307F4
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 07:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfEaFAz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 01:00:55 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8866 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfEaFAx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2019 01:00:53 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf0b5030000>; Thu, 30 May 2019 22:00:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 30 May 2019 22:00:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 30 May 2019 22:00:52 -0700
Received: from localhost.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 May
 2019 05:00:50 +0000
From:   Abhishek Sahu <abhsahu@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>
Subject: [PATCH 2/2] PCI: Create device link for NVIDIA GPU
Date:   Fri, 31 May 2019 10:31:09 +0530
Message-ID: <20190531050109.16211-3-abhsahu@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531050109.16211-1-abhsahu@nvidia.com>
References: <20190531050109.16211-1-abhsahu@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559278852; bh=X9Kjg+2IaxMtapTnBZhXu4pRG7RuEQMor0d4RRehUic=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         X-Originating-IP:X-ClientProxiedBy:Content-Type;
        b=IJ77GkHSy4VdQXAZeFLwUarWDrzuu1tdnTUw/Ji9VMVhm8qclmOjJUjZmi9H50s8K
         HbGanXpJdCP/33gIfJvNmBMgBFlBkpJgMStV1TdVzZrtePScJfeYTOg45BzaBZPjk9
         eRLCpfVtfgDH3xBD6D1TXVcoo4xRWDmmtdDjd6+fy8Dk7NwfcuOPgShOKh1SxLwAi+
         1GrG9MHmngXdqnfmYA/FxLmK2WjLKHVa7hLrY4dHZQOFZiIpBegA+mZ/PcgipB7GZz
         CzlG5mcwFuNWFDwhmS6YBzaJRbdjcrrrpKKmrL89e9Wsy8UbaZSYCurFYPjun6cwAe
         5hBiYoVeKGYHg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

NVIDIA Turing GPUs include hardware support for USB Type-C and
VirtualLink. It helps in delivering the power, display, and data
required to power VR headsets through a single USB Type-C connector.
The Turing GPU is a multi-function PCI device has the following
four functions:

	- VGA display controller (Function 0)
	- Audio controller (Function 1)
	- USB xHCI Host controller (Function 2)
	- USB Type-C USCI controller (Function 3)

The function 0 is tightly coupled with other functions in the
hardware. When function 0 goes in runtime suspended state,
then it will do power gating for most of the hardware blocks.
Some of these hardware blocks are used by other functions which
leads to functional failure. So if any of these functions (1/2/3)
are active, then function 0 should also be in active state.
'commit 07f4f97d7b4b ("vga_switcheroo: Use device link for
HDA controller")' creates the device link from function 1 to
function 0. A similar kind of device link needs to be created
between function 0 and functions 2 and 3 for NVIDIA Turing GPU.

This patch does the same and create the required device links. It
will make function 0 to be runtime PM active if other functions
are still active.

Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
---
 drivers/pci/quirks.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a20f7771a323..afdbc199efc5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4967,6 +4967,29 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
 
+/* Create device link for NVIDIA GPU with integrated USB controller to VGA. */
+static void quirk_gpu_usb(struct pci_dev *usb)
+{
+	pci_create_device_link_with_vga(usb, 2);
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+			      PCI_CLASS_SERIAL_USB, 8, quirk_gpu_usb);
+
+/*
+ * Create device link for NVIDIA GPU with integrated Type-C UCSI controller
+ * to VGA. Currently there is no class code defined for UCSI device over PCI
+ * so using UNKNOWN class for now and it will be updated when UCSI
+ * over PCI gets a class code.
+ */
+#define PCI_CLASS_SERIAL_UNKNOWN	0x0c80
+static void quirk_gpu_usb_typec_ucsi(struct pci_dev *ucsi)
+{
+	pci_create_device_link_with_vga(ucsi, 3);
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+			      PCI_CLASS_SERIAL_UNKNOWN, 8,
+			      quirk_gpu_usb_typec_ucsi);
+
 /*
  * Some IDT switches incorrectly flag an ACS Source Validation error on
  * completions for config read requests even though PCIe r4.0, sec
-- 
2.17.1

