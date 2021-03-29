Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D5134CEB1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 13:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhC2LSe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 07:18:34 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:46732 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232208AbhC2LSD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 07:18:03 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8714C405C4;
        Mon, 29 Mar 2021 11:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617016683; bh=iSxtzBdDE2cJnjE+FKkXJyxRBdv7BWhqnOaNUTMnKw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=MnleN+marL8tlDKG4oFA9Ec6DYnbs2I4LGW2YLQ4dFBxr64tLtSQOBYOdjl+vgrSv
         1ppTkZS2ylh463eR28qs3/ykZLV9D9lS8P1axZXoLiTbsgnMjL4yHa0P/nrcmIB0lL
         0M9Z0jRQ7Zp8JAzXstnVD5um6kpEcIs17H0tFLv2hMkADjiKkTNZUSfGI1PxDmhAHE
         1FGf2Z9/3cLnetvbiPy3xylm5Rn2zfmKQcFJ5XdbsPgDaUqSz48L5eWmw6FXuyGlsA
         Bair0CdR+WnTip2UaGAEoEetT8DzzYf4OCRBsm9uczPg7ZVfwE6gmcDcv76veTgwP9
         vclu1ob9qiZsA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4D74EA022E;
        Mon, 29 Mar 2021 11:18:02 +0000 (UTC)
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
Subject: [PATCH v10 4/4] docs: ABI: Add sysfs documentation interface of dw-xdata-pcie driver
Date:   Mon, 29 Mar 2021 13:17:48 +0200
Message-Id: <438c4ca9f6cc9e1cb29a65c0d2cca9a3d3f181b1.1617016509.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1617016509.git.gustavo.pimentel@synopsys.com>
References: <cover.1617016509.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1617016509.git.gustavo.pimentel@synopsys.com>
References: <cover.1617016509.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch describes the sysfs interface implemented on the dw-xdata-pcie
driver.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/ABI/testing/sysfs-driver-xdata | 49 ++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xdata

diff --git a/Documentation/ABI/testing/sysfs-driver-xdata b/Documentation/ABI/testing/sysfs-driver-xdata
new file mode 100644
index 00000000..f574e8e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-xdata
@@ -0,0 +1,49 @@
+What:		/sys/class/misc/drivers/dw-xdata-pcie.<device>/write
+Date:		April 2021
+KernelVersion:	5.13
+Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+Description:	Allows the user to enable the PCIe traffic generator which
+		will create write TLPs frames - from the Root Complex to the
+		Endpoint direction or to disable the PCIe traffic generator
+		in all directions.
+
+		Write y/1/on to enable, n/0/off to disable
+
+		Usage e.g.
+		 echo 1 > /sys/class/misc/dw-xdata-pcie.<device>/write
+		or
+		 echo 0 > /sys/class/misc/dw-xdata-pcie.<device>/write
+
+		The user can read the current PCIe link throughput generated
+		through this generator in MB/s.
+
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
+		Complex direction or to disable the PCIe traffic generator
+                in all directions.
+
+		Write y/1/on to enable, n/0/off to disable
+
+		Usage e.g.
+		 echo 1 > /sys/class/misc/dw-xdata-pcie.<device>/read
+		or
+		 echo 0 > /sys/class/misc/dw-xdata-pcie.<device>/read
+
+		The user can read the current PCIe link throughput generated
+		through this generator in MB/s.
+
+		Usage e.g.
+		 cat /sys/class/misc/dw-xdata-pcie.<device>/read
+		 199
+
+		The file is read and write.
-- 
2.7.4

