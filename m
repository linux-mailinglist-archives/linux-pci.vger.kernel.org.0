Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B684734CEB2
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 13:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhC2LSf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 07:18:35 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:52364 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232514AbhC2LSE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 07:18:04 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B170BC00E5;
        Mon, 29 Mar 2021 11:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617016682; bh=UPhDqPJc04hZvg9p3DifXdydjic8Klb257Kr3LfwRaI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=V+YLLAtjiXK81Gk6zvhSAs4YmlwaaL/9LAjIJKg7Gg0bkNXkDJhukoQkFGg6vKywT
         06XnRORAPkD/ocCspYVCLtDbKhw1GAklLXk1ASPlNbzDZfogTCWkv1DxhqT8+pE+A9
         Hflf9PYVW+Qh+lWqwp0M0ILTr2/HROfO+IV1q+ti6+BM+fheZwbB2oAyCiT8S5oJTQ
         paq2i07c4gFBbU0t1wsiRgfXSSq94fuVOAj5dSSCcvUADR4GCu11Fp3WQOkrd4M3+M
         Ma9tRNceiiETWiXvNtP65eC/J4c5huZAA+oWUeo+QIlvitg6oGPPhYue9fgE8sBJdw
         rWL23DLJm/SMw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4D224A022F;
        Mon, 29 Mar 2021 11:18:00 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v10 2/4] Documentation: misc-devices: Add Documentation for dw-xdata-pcie driver
Date:   Mon, 29 Mar 2021 13:17:46 +0200
Message-Id: <764b9bf744d7fe20c7a216019eef8ddf482c1bd7.1617016509.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1617016509.git.gustavo.pimentel@synopsys.com>
References: <cover.1617016509.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1617016509.git.gustavo.pimentel@synopsys.com>
References: <cover.1617016509.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Documentation for dw-xdata-pcie driver.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/misc-devices/dw-xdata-pcie.rst | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/misc-devices/dw-xdata-pcie.rst

diff --git a/Documentation/misc-devices/dw-xdata-pcie.rst b/Documentation/misc-devices/dw-xdata-pcie.rst
new file mode 100644
index 00000000..fd75c93
--- /dev/null
+++ b/Documentation/misc-devices/dw-xdata-pcie.rst
@@ -0,0 +1,40 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================================================
+Driver for Synopsys DesignWare PCIe traffic generator (also known as xData)
+===========================================================================
+
+This driver should be used as a host-side (Root Complex) driver and Synopsys
+DesignWare prototype that includes this IP.
+
+The "dw-xdata-pcie" driver can be used to enable/disable PCIe traffic
+generator in either direction (mutual exclusion) besides allowing the
+PCIe link performance analysis.
+
+The interaction with this driver is done through the module parameter and
+can be changed in runtime. The driver outputs the requested command state
+information to /var/log/kern.log or dmesg.
+
+Request write TLPs traffic generation - Root Complex to Endpoint direction
+- Command:
+	echo 1 > /sys/class/misc/dw-xdata-pcie/write
+
+Get write TLPs traffic link throughput in MB/s
+- Command:
+        cat /sys/class/misc/dw-xdata-pcie/write
+- Output example:
+	204
+
+Request read TLPs traffic generation - Endpoint to Root Complex direction:
+- Command:
+	echo 1 > /sys/class/misc/dw-xdata-pcie/read
+
+Get read TLPs traffic link throughput in MB/s
+- Command:
+        cat /sys/class/misc/dw-xdata-pcie/read
+- Output example:
+	199
+
+Request to stop any current TLP transfer:
+- Command:
+	echo 1 > /sys/class/misc/dw-xdata-pcie/stop
-- 
2.7.4

