Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08815355A53
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 19:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346957AbhDFR1N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 13:27:13 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:33622 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346942AbhDFR1M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 13:27:12 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 41E9140133;
        Tue,  6 Apr 2021 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617730024; bh=iSxtzBdDE2cJnjE+FKkXJyxRBdv7BWhqnOaNUTMnKw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=NJdRJvLYo9ozC8UTf1Qw7tMHdvwCP4/aoLXUun3NlTLvOyVWZflwrpe1zb7TtSvKr
         VmGRVgNZu/5Z2BA1Wj0NiqtjUd6Ta6m9SPBCzypxRaUHZwnW9VPozyzm9tSIUkR0sE
         o3sYeQpIWhJWACoTRgl5diV7rSbmhH3/eNucJLGZutnW7V/1eJ/ZEmlAeYbSLfjJtQ
         KKFAzwsLAnV6rDY892/D1I+LKHeGx+sr5OStMoQGGexPt9Lz1WL8OkhYHgB8DeO1li
         U2h5V2aTvLkDNDs/OIffTC296jBVkl6rDz//Ut++QxIxCFHbew4CQENVoI34Oj1gMe
         xPEw2n9dAtPbA==
Received: from de02dwvm009.internal.synopsys.com (de02dwvm009.internal.synopsys.com [10.225.17.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1ABFDA0237;
        Tue,  6 Apr 2021 17:27:03 +0000 (UTC)
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
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v11 4/4] docs: ABI: Add sysfs documentation interface of dw-xdata-pcie driver
Date:   Tue,  6 Apr 2021 19:26:49 +0200
Message-Id: <38dcaa99313ad7b42d492ddd3576a33c4029fa6b.1617729785.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1617729785.git.gustavo.pimentel@synopsys.com>
References: <cover.1617729785.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1617729785.git.gustavo.pimentel@synopsys.com>
References: <cover.1617729785.git.gustavo.pimentel@synopsys.com>
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

