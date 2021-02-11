Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAF93186D9
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 10:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhBKJRO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 04:17:14 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56644 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230054AbhBKJKs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 04:10:48 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8EF98C00C5;
        Thu, 11 Feb 2021 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613034554; bh=im9YPeIOIOX6v4VKPr6LIGB+a/nLiNTjVu6zUPMNTcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=HNw0YtZtjRjWYZ4k0IPCCoIVTYw81Nd+HXb4SdsYHkZwfs/IiA569sJZXp1uZAgft
         1wdWCbLpRte5l109pvlqeZCDYCER87r/guTNqZk5NLFYOEUQN0yKoKaZsecdqqZlHB
         3DQDEu4COjkAVPfHwitO+MVJssHSHRnOplaZH+oBRhF+2w0hxdmYSpG7QsKian8TZz
         sjbWRgPEzZ9yVd3GM5zfsxpvtG+s8tG+f7nQDwREAtZbWI6q65BfL8I+0JbM7iPItx
         99HuW3T1+BsYnrzq3Jf5cgQuz0c+/mwJS+CidetTmTIUjbfw3+zF782hpg2/eg9ozS
         QY9NRZC6YGzrA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 549A9A005C;
        Thu, 11 Feb 2021 09:09:13 +0000 (UTC)
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
Subject: [PATCH v5 6/6] docs: ABI: Add sysfs documentation interface of dw-xdata-pcie driver
Date:   Thu, 11 Feb 2021 10:08:43 +0100
Message-Id: <dce623f03f782fe536765916a9c3be36cee1dfe2.1613034397.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
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
index 00000000..a7bb44b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-xdata
@@ -0,0 +1,46 @@
+What:		/sys/kernel/dw-xdata-pcie/write
+Date:		February 2021
+KernelVersion:	5.12
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to enable the PCIe traffic generator which
+		will create write TLPs frames - from the Root Complex to the
+		Endpoint direction.
+		Usage e.g.
+		 echo 1 > /sys/kernel/dw-xdata-pcie/write
+
+		The user can read the current PCIe link throughput generated
+		through this generator.
+		Usage e.g.
+		 cat /sys/kernel/dw-xdata-pcie/write
+		 204 MB/s
+
+		The file is read and write.
+
+What:		/sys/kernel/dw-xdata-pcie/read
+Date:		February 2021
+KernelVersion:	5.12
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to enable the PCIe traffic generator which
+		will create read TLPs frames - from the Endpoint to the Root
+		Complex direction.
+		Usage e.g.
+		 echo 1 > /sys/kernel/dw-xdata-pcie/read
+
+		The user can read the current PCIe link throughput generated
+		through this generator.
+		Usage e.g.
+		 cat /sys/kernel/dw-xdata-pcie/read
+		 199 MB/s
+
+		The file is read and write.
+
+What:		/sys/kernel/dw-xdata-pcie/stop
+Date:		February 2021
+KernelVersion:	5.12
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to disable the PCIe traffic generator in all
+		directions.
+		Usage e.g.
+		 echo 1 > /sys/kernel/dw-xdata-pcie/stop
+
+		The file is write only.
-- 
2.7.4

