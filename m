Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63D330E5DF
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 23:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhBCWOB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 17:14:01 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:32840 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232720AbhBCWN7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 17:13:59 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8ABCC40490;
        Wed,  3 Feb 2021 22:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612390378; bh=im9YPeIOIOX6v4VKPr6LIGB+a/nLiNTjVu6zUPMNTcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=k1qhr8y91jhHcGN/0CdZzJalsL7UXUwn0Q3e8sEcKFtuwGIJJknsJzq82yosvACGf
         Jk/h3Ky7V6mkt1ikgqfN57cATia4ntjnvIDhSWPlRTMFxJgTqesQqZSlblXWyTnpew
         ci8oIcAUiU9XnR4ROXaTCFnnbE5pmIFHJCB+YN+Hxx4aKTihA0yEvUHkxGXZ0gH3cP
         trjUwfFmowPNbJnTQXtpPBHrnisL/Cx+WeuvdaNB5imlP4qLNNa14Tpkm2AcypeYsq
         Qv8dnrubInhMDcsuNMtkJYHTEfIXBxyHVv1CwdxlPVT9OlQSad3Otpo/3XuHkSRnHO
         VggzKd1kkX8Kw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5E12EA0249;
        Wed,  3 Feb 2021 22:12:57 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [RESEND v4 6/6] docs: ABI: Add sysfs documentation interface of dw-xdata-pcie driver
Date:   Wed,  3 Feb 2021 23:12:51 +0100
Message-Id: <45f0701b523cda52b4b7f42351b63d5a0b6040b6.1612390291.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
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

