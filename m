Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F154D355DC0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 23:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343582AbhDFVSa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 17:18:30 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:34776 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243160AbhDFVS0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 17:18:26 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 881AAC008F;
        Tue,  6 Apr 2021 21:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617743897; bh=FB+JhMtea6fMtjtS2zo40n5VWb9mh8PGx6vJ3vEeZxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Iy4B1r/IrPPIrR9ioTzBLATtDdAT0OszO7hLB6adyzbTBiJLYBI7HkwpY60oerNz6
         aOX7cTR2D+974pTQk6qExSVwby76sTUETzw59wvaZjx6YXehKhfoQYoOv5EG97zwmL
         sgMGXI3ieN7gPn0oriz+kGr/dfqP51+3Ghb5+ISCKfJqfXLBYFeTm2q7EFhbR31J5D
         Eew5pBK0ODmJqyOZ3el9MpWK5Byo4hZnSpxrRfTFNSgQD3R1VpEdiiHzpnUKfMwsFF
         KfFapJgDdtiev0Djm6ONBVYf2mOaIZJEDA8Lr0wHAwkrqzqhdtr4bcMeOxcZfj8iMn
         Me16NXQODQb7g==
Received: from de02dwvm009.internal.synopsys.com (de02dwvm009.internal.synopsys.com [10.225.17.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id 50C23A0230;
        Tue,  6 Apr 2021 21:18:15 +0000 (UTC)
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
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v2 1/2] Documentation: misc-devices: Fix indentation, formatting, and update outdated info
Date:   Tue,  6 Apr 2021 23:17:48 +0200
Message-Id: <95bef5f98380bc91b4d321c2638d08da61ef6d6e.1617743702.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1617743702.git.gustavo.pimentel@synopsys.com>
References: <cover.1617743702.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1617743702.git.gustavo.pimentel@synopsys.com>
References: <cover.1617743702.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes indentation issues reported by doing *make htmldocs* as well some
text formatting.

Besides these fixes, there was some outdated information related to stop
file interface in sysfs.

Fixes: e1181b5bbc3c ("Documentation: misc-devices: Add Documentation for dw-xdata-pcie driver")
Link: https://lore.kernel.org/linux-next/20210406214615.40cf3493@canb.auug.org.au/
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/misc-devices/dw-xdata-pcie.rst | 62 +++++++++++++++++++---------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/Documentation/misc-devices/dw-xdata-pcie.rst b/Documentation/misc-devices/dw-xdata-pcie.rst
index fd75c93..a956e1a 100644
--- a/Documentation/misc-devices/dw-xdata-pcie.rst
+++ b/Documentation/misc-devices/dw-xdata-pcie.rst
@@ -4,37 +4,61 @@
 Driver for Synopsys DesignWare PCIe traffic generator (also known as xData)
 ===========================================================================
 
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
 This driver should be used as a host-side (Root Complex) driver and Synopsys
 DesignWare prototype that includes this IP.
 
-The "dw-xdata-pcie" driver can be used to enable/disable PCIe traffic
+The dw-xdata-pcie driver can be used to enable/disable PCIe traffic
 generator in either direction (mutual exclusion) besides allowing the
 PCIe link performance analysis.
 
 The interaction with this driver is done through the module parameter and
 can be changed in runtime. The driver outputs the requested command state
-information to /var/log/kern.log or dmesg.
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
 
-Request write TLPs traffic generation - Root Complex to Endpoint direction
-- Command:
-	echo 1 > /sys/class/misc/dw-xdata-pcie/write
+Get link throughput in MB/s::
 
-Get write TLPs traffic link throughput in MB/s
-- Command:
-        cat /sys/class/misc/dw-xdata-pcie/write
-- Output example:
+        # cat /sys/class/misc/dw-xdata-pcie.0/write
 	204
 
-Request read TLPs traffic generation - Endpoint to Root Complex direction:
-- Command:
-	echo 1 > /sys/class/misc/dw-xdata-pcie/read
+Stop traffic in any direction::
 
-Get read TLPs traffic link throughput in MB/s
-- Command:
-        cat /sys/class/misc/dw-xdata-pcie/read
-- Output example:
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
 	199
 
-Request to stop any current TLP transfer:
-- Command:
-	echo 1 > /sys/class/misc/dw-xdata-pcie/stop
+Stop traffic in any direction::
+
+        # echo 0 > /sys/class/misc/dw-xdata-pcie.0/read
+
-- 
2.7.4

