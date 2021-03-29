Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FBA34CD77
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 12:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhC2KAH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 06:00:07 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:49718 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232085AbhC2J7y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 05:59:54 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 60A09C044B;
        Mon, 29 Mar 2021 09:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617011994; bh=UPhDqPJc04hZvg9p3DifXdydjic8Klb257Kr3LfwRaI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=AocSsxj2Uu6txeyz3RD/Rih0JBxrS19MXcuMdJFgBx65PMhWQQa5SGQHGwvN27VJe
         SRfGXkWstnOdPdu3ImPIFoSXJ1705eYutLy6mix5f3xTFAIPwoN2i07vrg5TlQJ3lI
         vcBsJzuPL6CmSUx+6VPokQn5Jf6/Fu0u5NTErxHhSncD+q8OJ8K4no/xPzpPLF9y3k
         y6V16ytFTXGR2wVMZAaaXSgw/mzBi+7zgEw1+XSBsiQ43Ji6gvvhNKxCOF8YaMEQNL
         WTYrGj4UzCPrkxVRLIdGDN8H49OZRMstvAYzX8tOOVxegLZQTKPY8gwBiitQuW61gq
         psEYrWn4FFFyw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1DFB7A022E;
        Mon, 29 Mar 2021 09:59:53 +0000 (UTC)
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
Subject: [PATCH v9 2/4] Documentation: misc-devices: Add Documentation for dw-xdata-pcie driver
Date:   Mon, 29 Mar 2021 11:59:38 +0200
Message-Id: <52a0b455c3a5e69f107b64a894c23e424c16306c.1617011831.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
References: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
References: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
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

