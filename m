Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C3C31A39C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Feb 2021 18:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhBLR3Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Feb 2021 12:29:25 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42770 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231131AbhBLR3S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Feb 2021 12:29:18 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1631BC0448;
        Fri, 12 Feb 2021 17:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613150898; bh=RiCZ/aIb+ohi4u6232sCNdL5GCcyH0Wu9wGtiKnfNzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=OdL7A8joiblzjWmFQE0PGkAWE/hDMCy6fBslZEj/cEcYxFmO1fdjQSHnBTQu6Wn9d
         WEzYwTZhsOZdxNO8p008+dlIReh/Weqc+SUItaXSZSEk83lYDD6BX2YSP2lyf+RKp5
         iEw7blMSs+HiIX00ztNeyq6/6lObcTTciGpzHGt4ecRlylsVU84MCqvkwPczg9etnt
         gVMAMxpvdJpRL6JQcmH85GsWtDt6SrVX1zKRqqw05E37P3CAFtlKpFQL22DxqWJFOa
         wR5JQi88hStX+cdHsnfAMtjoGg01olBgMqHkkBU1Swl/nyHx6rDA6sDEDCGM1ljLnF
         hTP9RODYaNfXQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id D0B05A005D;
        Fri, 12 Feb 2021 17:28:16 +0000 (UTC)
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
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v6 5/5] docs: ABI: Add sysfs documentation interface of dw-xdata-pcie driver
Date:   Fri, 12 Feb 2021 18:28:07 +0100
Message-Id: <bf25bd2b8977d678adb13fea02d4cebf22f583bf.1613150798.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
References: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
References: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
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
index 00000000..09d38e1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-xdata
@@ -0,0 +1,46 @@
+What:		/sys/bus/pci/drivers/dw-xdata-pcie/.../write
+Date:		February 2021
+KernelVersion:	5.12
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to enable the PCIe traffic generator which
+		will create write TLPs frames - from the Root Complex to the
+		Endpoint direction.
+		Usage e.g.
+		 echo 1 > /sys/bus/pci/drivers/dw-xdata-pcie/.../write
+
+		The user can read the current PCIe link throughput generated
+		through this generator in MB/s.
+		Usage e.g.
+		 cat /sys/bus/pci/drivers/dw-xdata-pcie/.../write
+		 204
+
+		The file is read and write.
+
+What:		/sys/bus/pci/drivers/dw-xdata-pcie/.../read
+Date:		February 2021
+KernelVersion:	5.12
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to enable the PCIe traffic generator which
+		will create read TLPs frames - from the Endpoint to the Root
+		Complex direction.
+		Usage e.g.
+		 echo 1 > /sys/bus/pci/drivers/dw-xdata-pcie/.../read
+
+		The user can read the current PCIe link throughput generated
+		through this generator in MB/s.
+		Usage e.g.
+		 cat /sys/bus/pci/drivers/dw-xdata-pcie/.../read
+		 199
+
+		The file is read and write.
+
+What:		/sys/bus/pci/drivers/dw-xdata-pcie/.../stop
+Date:		February 2021
+KernelVersion:	5.12
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to disable the PCIe traffic generator in all
+		directions.
+		Usage e.g.
+		 echo 1 > /sys/bus/pci/drivers/dw-xdata-pcie/.../stop
+
+		The file is write only.
-- 
2.7.4

