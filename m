Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CFB34B3E9
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 04:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhC0DHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 23:07:41 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:50530 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhC0DHK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 23:07:10 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BC90140460;
        Sat, 27 Mar 2021 03:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616814429; bh=UPhDqPJc04hZvg9p3DifXdydjic8Klb257Kr3LfwRaI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Fb6TMnvrYjyKG4YPMw/cxJUNk9sqLDGHzGU4nBgjIwqb8Pd/j/r9Vg7B0nvU4uHA/
         Hw9oPjVgOt2bj25YzvMq8rs0wkcUzm7wgVsjvKIosda3B3fzsBclFnF4rBvszOJcL5
         tb7fopgcJMaEfdO3yz5bptMfwtBA6SUzlP7IsYIYkzS3AopD8YQbnXk/g/zLzSclEa
         YOY6d3lfDZltkjVs642DgjxXO0shG5rDrx5oF3qC4yM03KMMPNdI3q1nJY7t7uS+qv
         vPubgaUHxVqjR5mpxjzk1pk4kXYoYlKso/aXBV3krf4ZuSe0kC/sEqWR8vUYRdbSWv
         BZaPWCe8PGIhA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 81590A022E;
        Sat, 27 Mar 2021 03:07:08 +0000 (UTC)
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
Subject: [PATCH v7 3/5] Documentation: misc-devices: Add Documentation for dw-xdata-pcie driver
Date:   Sat, 27 Mar 2021 04:06:53 +0100
Message-Id: <b33004edd3f41d3f1c8b9696e3af91719c8b4e69.1616814273.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
References: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
References: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
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

