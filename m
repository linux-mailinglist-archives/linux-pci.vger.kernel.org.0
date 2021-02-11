Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3FA3186D8
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 10:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhBKJRJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 04:17:09 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56634 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230051AbhBKJKs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 04:10:48 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8598FC00C1;
        Thu, 11 Feb 2021 09:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613034552; bh=xjFl0ry1f4kLV7eWV2SxeXcHKekFmdWi7FGEn+fooAU=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=c9oa8/JoSw7uSH9p6L4Ib+NqMZwFbIFN25ltKb0zXddqcxTf6q8lJC3R4UCZYzHx+
         MMBjrnZtUEjuDl8OGGcPBU7BjTXN1EBRIymoLXpl0DJgss3OgP6AHIegvrV6Kn+Ymh
         PziBW+HVMDa3YYBScHub/TVmVcnCbf9BOqlnCANwbs0ffJ/crMGLxLRF0y3MdEUbRc
         5MScTwJHe7uC5hpWGNloqevPohQygy87OcGgAZPtwbgUh+oJ2cFMLK4aHDYTsC59A1
         e5R5+emiwh8cNylEd+4KtNVBVR+XuYV/vYujqQxgGzvX+9m/hxMWWdWKVq9eUDIzoY
         eTJVhvmctLqrQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4AB11A005F;
        Thu, 11 Feb 2021 09:09:11 +0000 (UTC)
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
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v5 4/6] Documentation: misc-devices: Add Documentation for dw-xdata-pcie driver
Date:   Thu, 11 Feb 2021 10:08:41 +0100
Message-Id: <e069196ea112d06ef7f4fa98d89bc26f70195206.1613034397.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
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
index 00000000..3af9fad
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
+	echo 1 > /sys/kernel/dw-xdata-pcie/write
+
+Get write TLPs traffic link throughput
+- Command:
+        cat /sys/kernel/dw-xdata-pcie/write
+- Output example:
+	204 MB/s
+
+Request read TLPs traffic generation - Endpoint to Root Complex direction:
+- Command:
+	echo 1 > /sys/kernel/dw-xdata-pcie/read
+
+Get read TLPs traffic link throughput
+- Command:
+        cat /sys/kernel/dw-xdata-pcie/read
+- Output example:
+	199 MB/s
+
+Request to stop any current TLP transfer:
+- Command:
+	echo 1 > /sys/kernel/dw-xdata-pcie/stop
-- 
2.7.4

