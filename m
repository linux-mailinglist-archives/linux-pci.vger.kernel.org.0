Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C9F35AE94
	for <lists+linux-pci@lfdr.de>; Sat, 10 Apr 2021 16:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhDJOxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Apr 2021 10:53:25 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:54144 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234821AbhDJOxY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Apr 2021 10:53:24 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 141B040473;
        Sat, 10 Apr 2021 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618066389; bh=FuCe6OfwyzCRHgde9lvKpsWM5qscJ9aMWtKpkEXQcXI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=IEHJeHaeGBUYjuTYi2Tit/MOcuCrMey+Yv6UuFEd1rDe32Od55iDeWXbiOdg95M5v
         cX/DgnZMZ5FV/3/dKsneSBxuCkobz0c7HO+DVWHWCTUYHsmmYKArKQAB8HNH/1pC+2
         XVesph6ayyAJ8syvOS7QZnRUke+rWkTFjyEdYDS1Rk4cBRcHeqm7EiUpKWI+/7tZVX
         Fq+osNxfyeFHEpoK43mLG/xuNPDCY/stuLHCbDHUkfs/j9eqLx7imnlUzatlx3Xzvo
         bXZi/H2lk2TmHmzCkqp4L8kL7xADO8h90wI/mHcs0zKyWhK5l3N6+WE/Xz0VS51bZm
         NyXa4q6+1BB5Q==
Received: from de02dwvm009.internal.synopsys.com (de02dwvm009.internal.synopsys.com [10.225.17.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id 72C40A0232;
        Sat, 10 Apr 2021 14:53:06 +0000 (UTC)
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
Subject: [PATCH v4 2/2] dw-xdata-pcie: Update outdated info and improve text format
Date:   Sat, 10 Apr 2021 16:52:59 +0200
Message-Id: <4e72f931474a784d478e5a67961ecf116911997a.1618066164.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1618066164.git.gustavo.pimentel@synopsys.com>
References: <cover.1618066164.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1618066164.git.gustavo.pimentel@synopsys.com>
References: <cover.1618066164.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Removes old information related to the stop file interface in sysfs left
by mistake during patch revision.

Improves the document text format to be more user-friendly and adds
basic driver related information, such as support, datasheet, and author.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/misc-devices/dw-xdata-pcie.rst | 76 ++++++++++++++++++----------
 1 file changed, 50 insertions(+), 26 deletions(-)

diff --git a/Documentation/misc-devices/dw-xdata-pcie.rst b/Documentation/misc-devices/dw-xdata-pcie.rst
index cbc9f69..781c679 100644
--- a/Documentation/misc-devices/dw-xdata-pcie.rst
+++ b/Documentation/misc-devices/dw-xdata-pcie.rst
@@ -4,37 +4,61 @@
 Driver for Synopsys DesignWare PCIe traffic generator (also known as xData)
 ===========================================================================
 
+Supported chips:
+Synopsys DesignWare PCIe prototype solution
+
+Datasheet:
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
-
-Request write TLPs traffic generation - Root Complex to Endpoint direction
-- Command:
-echo 1 > /sys/class/misc/dw-xdata-pcie/write
-
-Get write TLPs traffic link throughput in MB/s
-- Command:
-cat /sys/class/misc/dw-xdata-pcie/write
-- Output example:
-204
-
-Request read TLPs traffic generation - Endpoint to Root Complex direction:
-- Command:
-echo 1 > /sys/class/misc/dw-xdata-pcie/read
-
-Get read TLPs traffic link throughput in MB/s
-- Command:
-cat /sys/class/misc/dw-xdata-pcie/read
-- Output example:
-199
-
-Request to stop any current TLP transfer:
-- Command:
-echo 1 > /sys/class/misc/dw-xdata-pcie/stop
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
+ # echo 1 > /sys/class/misc/dw-xdata-pcie.0/write
+
+Get link throughput in MB/s::
+
+ # cat /sys/class/misc/dw-xdata-pcie.0/write
+ 204
+
+Stop traffic in any direction::
+
+ # echo 0 > /sys/class/misc/dw-xdata-pcie.0/write
+
+Read TLPs traffic generation - Endpoint to Root Complex direction
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Generate traffic::
+
+ # echo 1 > /sys/class/misc/dw-xdata-pcie.0/read
+
+Get link throughput in MB/s::
+
+ # cat /sys/class/misc/dw-xdata-pcie.0/read
+ 199
+
+Stop traffic in any direction::
+
+ # echo 0 > /sys/class/misc/dw-xdata-pcie.0/read
+
-- 
2.7.4

