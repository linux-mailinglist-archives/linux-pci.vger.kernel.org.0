Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F47355A54
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 19:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346967AbhDFR1P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 13:27:15 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:51788 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346954AbhDFR1O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 13:27:14 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EBDC6C0097;
        Tue,  6 Apr 2021 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617730025; bh=FTRqpxHdC8+uO17r8aFORyzwRYRfU4k0CF29Bnq6omQ=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=GGjKjjGZwnO91/hg3gNKzJcwJ1NqdrXHL7iNTLSn8q2CyE/VrydR6cBIKFszo8enX
         LwVfv0zmI3DJEHFpvSASe0yM2S1Sq1iYzlYzGkeA+kHNq2/O3Ai7xAPGbl9dkAYY1M
         zNTEz9oAfdFFO2wXZEg4eGOPstDWdHWz9Lr66tJXhg0hfvPtQivUHsotyGJMrsSzuh
         HYZESOGLSbx3LWDTVmx4fohYiWDavLN6bKRdxf6Sd8b1fg61mM1JTydZDHEmpI03Dx
         eVzRSLswhX6lW6m6wKhhwfwXKxmXiPUn0qU0AETFPEcSQ0jH33PY+vswnt3wh7GQoa
         lpC7cz91e6zfw==
Received: from de02dwvm009.internal.synopsys.com (de02dwvm009.internal.synopsys.com [10.225.17.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id 386F2A0233;
        Tue,  6 Apr 2021 17:27:02 +0000 (UTC)
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
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v11 2/4] Documentation: misc-devices: Add Documentation for dw-xdata-pcie driver
Date:   Tue,  6 Apr 2021 19:26:47 +0200
Message-Id: <61eb643d12ba3fa50308268b0cc7fb111374724d.1617729785.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1617729785.git.gustavo.pimentel@synopsys.com>
References: <cover.1617729785.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1617729785.git.gustavo.pimentel@synopsys.com>
References: <cover.1617729785.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Documentation for dw-xdata-pcie driver.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/misc-devices/dw-xdata-pcie.rst | 64 ++++++++++++++++++++++++++++
 Documentation/misc-devices/index.rst         |  1 +
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/misc-devices/dw-xdata-pcie.rst

diff --git a/Documentation/misc-devices/dw-xdata-pcie.rst b/Documentation/misc-devices/dw-xdata-pcie.rst
new file mode 100644
index 00000000..a956e1a
--- /dev/null
+++ b/Documentation/misc-devices/dw-xdata-pcie.rst
@@ -0,0 +1,64 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================================================
+Driver for Synopsys DesignWare PCIe traffic generator (also known as xData)
+===========================================================================
+
+Supported chips:
+Synopsys DesignWare PCIe prototype solution
+
+Data sheet:
+Not freely available
+
+Author:
+Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+
+Description
+-----------
+
+This driver should be used as a host-side (Root Complex) driver and Synopsys
+DesignWare prototype that includes this IP.
+
+The dw-xdata-pcie driver can be used to enable/disable PCIe traffic
+generator in either direction (mutual exclusion) besides allowing the
+PCIe link performance analysis.
+
+The interaction with this driver is done through the module parameter and
+can be changed in runtime. The driver outputs the requested command state
+information to ``/var/log/kern.log`` or dmesg.
+
+Example
+-------
+
+Write TLPs traffic generation - Root Complex to Endpoint direction
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Generate traffic::
+
+        # echo 1 > /sys/class/misc/dw-xdata-pcie.0/write
+
+Get link throughput in MB/s::
+
+        # cat /sys/class/misc/dw-xdata-pcie.0/write
+	204
+
+Stop traffic in any direction::
+
+        # echo 0 > /sys/class/misc/dw-xdata-pcie.0/write
+
+Read TLPs traffic generation - Endpoint to Root Complex direction
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Generate traffic::
+
+        # echo 1 > /sys/class/misc/dw-xdata-pcie.0/read
+
+Get link throughput in MB/s::
+
+        # cat /sys/class/misc/dw-xdata-pcie.0/read
+	199
+
+Stop traffic in any direction::
+
+        # echo 0 > /sys/class/misc/dw-xdata-pcie.0/read
+
diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 64420b331..30ac58f 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -19,6 +19,7 @@ fit into other categories.
    bh1770glc
    eeprom
    c2port
+   dw-xdata-pcie
    ibmvmc
    ics932s401
    isl29003
-- 
2.7.4

