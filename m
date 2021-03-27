Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664AE34B3EE
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 04:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhC0DHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 23:07:41 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:50566 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230315AbhC0DHM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 23:07:12 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C556E40396;
        Sat, 27 Mar 2021 03:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616814431; bh=V5qHWnwSaNxwxOHPPHy+Dl81e9RP31O5dcErxcCRBHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=L8ISqDqmTAA5T7xzMMD/c25IbwWfPFeOeOXkfqWY7eGdm9f0Z5BwBPHjLO9s30zIi
         S0lc8e40yL21pXlNkR/rXpnYSVbAYK/R5JLwAKjsS9k2HGOIJ/5KTZi/89CCkkxYCU
         Kh4LT1oCIN65/HgODxPpG6bSwRygg2Jmyah/F8lPedXcfUyPCCc6a/qlArUHjjoWdm
         nkOKp5CEqj+g39yFNwGiZ/R0CbWk47BVPr2AgLyPi0HMNIrhMNOHwVmeX/+R3zPw7k
         GRapaiNCVkwkO2UvLIMwzWk8aA9mHBjKQ9zdi3t7/tOhvuCvlWtLBlgTq50zSDM5Im
         6Kbg9t+fBSAUw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8BABDA022E;
        Sat, 27 Mar 2021 03:07:10 +0000 (UTC)
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
Subject: [PATCH v7 5/5] docs: ABI: Add sysfs documentation interface of dw-xdata-pcie driver
Date:   Sat, 27 Mar 2021 04:06:55 +0100
Message-Id: <83d6573cf8bd03a0b3c3497ded6dce3f0b2e2ebd.1616814273.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
References: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
References: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
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
index 00000000..cb3ab7e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-xdata
@@ -0,0 +1,46 @@
+What:		/sys/class/misc/drivers/dw-xdata-pcie/write
+Date:		April 2021
+KernelVersion:	5.12
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to enable the PCIe traffic generator which
+		will create write TLPs frames - from the Root Complex to the
+		Endpoint direction.
+		Usage e.g.
+		 echo 1 > /sys/class/misc/dw-xdata-pcie/write
+
+		The user can read the current PCIe link throughput generated
+		through this generator in MB/s.
+		Usage e.g.
+		 cat /sys/class/misc/dw-xdata-pcie/write
+		 204
+
+		The file is read and write.
+
+What:		/sys/class/misc/dw-xdata-pcie/read
+Date:		April 2021
+KernelVersion:	5.12
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to enable the PCIe traffic generator which
+		will create read TLPs frames - from the Endpoint to the Root
+		Complex direction.
+		Usage e.g.
+		 echo 1 > /sys/class/misc/dw-xdata-pcie/read
+
+		The user can read the current PCIe link throughput generated
+		through this generator in MB/s.
+		Usage e.g.
+		 cat /sys/class/misc/dw-xdata-pcie/read
+		 199
+
+		The file is read and write.
+
+What:		/sys/class/misc/dw-xdata-pcie/stop
+Date:		April 2021
+KernelVersion:	5.12
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to disable the PCIe traffic generator in all
+		directions.
+		Usage e.g.
+		 echo 1 > /sys/class/misc/dw-xdata-pcie/stop
+
+		The file is write only.
-- 
2.7.4

