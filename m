Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058F630E5DD
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 23:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhBCWOA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 17:14:00 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:53092 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232462AbhBCWN6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 17:13:58 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4D5E7C0117;
        Wed,  3 Feb 2021 22:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612390377; bh=xjFl0ry1f4kLV7eWV2SxeXcHKekFmdWi7FGEn+fooAU=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=SIwXnq5/2CBgH+y1FpPEN0slnm3mV9v12QurVd1lrqJThBkgfZUjC1E8XyuhF0JAd
         13UbjwCEL1StEjf2+qKi52UjQIErY9PIySjwyUIubg1qX1HTmgFWxj7YTErL94rO61
         M3qUZA5IkFg2CLCGFYLiyp5OZTdHfPFBQuNR1bQ/s1naLWPPlQTNw6XcnaYYUgnrds
         nGs86CukOR9I9NR8zahahZiW8psrLyDHj+AArxI2nzx1r6SXCLRq7D4EuTVArh1rO5
         cdc3dbDnRqZOpYJMU48GBwySjcAsfm2iDauMAUGs81JrdGD/EmAW19Qu1oWxlzyHuq
         xZmlrqTacXHEA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1E430A024B;
        Wed,  3 Feb 2021 22:12:56 +0000 (UTC)
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
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [RESEND v4 4/6] Documentation: misc-devices: Add Documentation for dw-xdata-pcie driver
Date:   Wed,  3 Feb 2021 23:12:49 +0100
Message-Id: <2cc3a3a324d299a096f1d3e682b2039d3537b013.1612390291.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
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

