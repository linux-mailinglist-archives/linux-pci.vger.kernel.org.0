Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E0734CD80
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 12:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhC2KAJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 06:00:09 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:44344 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232212AbhC2J74 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 05:59:56 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2966F404A3;
        Mon, 29 Mar 2021 09:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617011996; bh=ibm9LI5RyhTCMlptQpsEQYzjlRSznG+C+yJmcT2sc/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=G/reX+MbJBwjWB7+pnXF8ZTBuiFVd/sOpcs2YiWvtjhpjPtrLJgml5+1pavGIw/jz
         2NLGfYfYBonMKr0ylghodUsLCmuDrubNiTOai05H1SxFr2gMqz3PiL7cwRLN8u4tEC
         qzIiWtvBckIzJr8WzwZM8EQrVWWVd0LMJWlT5c5uHBmPSktCKy3BKBYMWynAcu+Ed5
         KI2FpzrwMI6Kyc+8Q7RmL5HSiT2h450pn5HpMWbv0s1ntERDNObEHaVVnh2eygzieL
         sxRNzolWq0fUhAhnEFMnzGTGUTUXFAsKcs6OKObuR6XXyd2d7KqONZId7x0zmePXgf
         Kd8WLgMMnVedw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id F3109A022E;
        Mon, 29 Mar 2021 09:59:54 +0000 (UTC)
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
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v9 4/4] docs: ABI: Add sysfs documentation interface of dw-xdata-pcie driver
Date:   Mon, 29 Mar 2021 11:59:40 +0200
Message-Id: <5840637a206dd1287caf142a0dbedf0dac9ccd48.1617011831.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
References: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
References: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch describes the sysfs interface implemented on the dw-xdata-pcie
driver.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/ABI/testing/sysfs-driver-xdata | 46 ++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xdata

diff --git a/Documentation/ABI/testing/sysfs-driver-xdata b/Documentation/ABI/testing/sysfs-driver-xdata
new file mode 100644
index 00000000..66af19a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-xdata
@@ -0,0 +1,46 @@
+What:		/sys/class/misc/drivers/dw-xdata-pcie.<device>/write
+Date:		April 2021
+KernelVersion:	5.13
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to enable the PCIe traffic generator which
+		will create write TLPs frames - from the Root Complex to the
+		Endpoint direction.
+		Usage e.g.
+		 echo 1 > /sys/class/misc/dw-xdata-pcie.<device>/write
+
+		The user can read the current PCIe link throughput generated
+		through this generator in MB/s.
+		Usage e.g.
+		 cat /sys/class/misc/dw-xdata-pcie.<device>/write
+		 204
+
+		The file is read and write.
+
+What:		/sys/class/misc/dw-xdata-pcie.<device>/read
+Date:		April 2021
+KernelVersion:	5.13
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to enable the PCIe traffic generator which
+		will create read TLPs frames - from the Endpoint to the Root
+		Complex direction.
+		Usage e.g.
+		 echo 1 > /sys/class/misc/dw-xdata-pcie.<device>/read
+
+		The user can read the current PCIe link throughput generated
+		through this generator in MB/s.
+		Usage e.g.
+		 cat /sys/class/misc/dw-xdata-pcie.<device>/read
+		 199
+
+		The file is read and write.
+
+What:		/sys/class/misc/dw-xdata-pcie.<device>/stop
+Date:		April 2021
+KernelVersion:	5.13
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to disable the PCIe traffic generator in all
+		directions.
+		Usage e.g.
+		 echo 1 > /sys/class/misc/dw-xdata-pcie.<device>/stop
+
+		The file is write only.
-- 
2.7.4

