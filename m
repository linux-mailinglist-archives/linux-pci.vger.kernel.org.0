Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0AE36FC1
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 11:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfFFJXD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 05:23:03 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2731 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfFFJXA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 05:23:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf8db720000>; Thu, 06 Jun 2019 02:22:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 02:22:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Jun 2019 02:22:59 -0700
Received: from localhost.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Jun
 2019 09:22:56 +0000
From:   Abhishek Sahu <abhsahu@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lukas@wunner.de>, Abhishek Sahu <abhsahu@nvidia.com>
Subject: [PATCH v2 2/2] PCI: Create device link for NVIDIA GPU
Date:   Thu, 6 Jun 2019 14:52:25 +0530
Message-ID: <20190606092225.17960-3-abhsahu@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606092225.17960-1-abhsahu@nvidia.com>
References: <20190606092225.17960-1-abhsahu@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559812978; bh=nVd2P0ATmq+CVftqZEL7Xt9ORioWEGscgVthbBvMCSU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         X-Originating-IP:X-ClientProxiedBy:Content-Type;
        b=Vmnlq/zhvunelvhHKeTWlNCLH9Rgr3raiPJfAux+ibhOlgJDe/HtpQE1wRx+B+5dp
         5O+0+fzA8DpPXSHxmIgl82OlrsRwuTlILlkAuuKcvACG8/i422OYRFHtSl3NFhb0ez
         qr5YwmykKyFP6QsCajxu6ljmUmM+nUVEHEFs5th+JBklqvHOjz/K+8xEyPRNj29oMz
         UiZoeBxu6jMN5XL7AlalVXr2anOLJN23e0s3MTc5pxAjmn09CQ7BiJ5XDcQHuXui0y
         0YVLbkIsaT+uggUYWy0Y7HyHa1v2NpXankKXDJLIGPtvIfK5lDVt2b3MKxW/m9XDpt
         n1LXy+Te2PdNw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

NVIDIA Turing GPUs include hardware support for USB Type-C and
VirtualLink. It helps in delivering the power, display, and data
required to power VR headsets through a single USB Type-C connector.
The Turing GPU is a multi-function PCI device. It has the following
four functions:

	- VGA display controller (Function 0)
	- Audio controller (Function 1)
	- USB xHCI Host controller (Function 2)
	- USB Type-C USCI controller (Function 3)

The function 0 is tightly coupled with other functions in the
hardware. When function 0 goes in D3 state, then it will do
power gating for most of the hardware blocks. Some of these
hardware blocks are being used by other functions which
leads to functional failure. So if any of these functions (1/2/3)
are in D0 state, then function 0 should also be in D0 state.

'commit 07f4f97d7b4b ("vga_switcheroo: Use device link for
HDA controller")' creates the device link from function 1 to
function 0. A similar kind of device link needs to be created
between function 0 and functions 2 and 3 for NVIDIA Turing GPU.

This patch does the same and creates the required device links. It
will make function 0 to be D0 state if any other function is in D0
state.

Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
---
* Changes from v1:

  1. Minor changes in commit log
  2. used pci_create_device_link() helper function

 drivers/pci/quirks.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 379cd7fbcb12..b9182c4e5e42 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4966,6 +4966,32 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
 
+/*
+ * Create device link for NVIDIA GPU with integrated USB xHCI Host
+ * controller to VGA.
+ */
+static void quirk_gpu_usb(struct pci_dev *usb)
+{
+	pci_create_device_link(usb, 2, 0, PCI_BASE_CLASS_DISPLAY, 16);
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
+	pci_create_device_link(ucsi, 3, 0, PCI_BASE_CLASS_DISPLAY, 16);
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

