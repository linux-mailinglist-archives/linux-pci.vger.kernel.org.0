Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D4934CD5E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 11:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhC2JwI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 05:52:08 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:49374 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232134AbhC2Jv6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 05:51:58 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2AFAEC04CE;
        Mon, 29 Mar 2021 09:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617011518; bh=ibm9LI5RyhTCMlptQpsEQYzjlRSznG+C+yJmcT2sc/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=fzMqtKKhEiuTD3ejwNu64vdzhjxK/W/anHPALp474mDzaWUN/IYX/6tT5aq9IHVfJ
         sVMq491O1LNix2e/Y/A4FBqmMUX2NXaHGbFvG2lki/uOFoEaZzA0taL5Q8MRPJOuhR
         0HyZbGH1iF/r55Ul/FW7V2G2ne8g1ZVHAajbHfX+IInump8TmNFwzDWKBTdsr/uk5J
         mj9glbkGMEnG8nWTviBV0dyrPCJw9li61Cz6GP5feU+Sg3Pe5j4/P3NHcUWZ+6dKIF
         HaxFJvHrfIP6YwE09qOiNdrUIy9lH0gxQ1o0oC4/tJD/YSKW4dIOgAjNTtEyFlky3H
         j71hdkGPHMf4Q==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id E02D0A0231;
        Mon, 29 Mar 2021 09:51:56 +0000 (UTC)
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
Subject: [PATCH v8 4/5] docs: ABI: Add sysfs documentation interface of dw-xdata-pcie driver
Date:   Mon, 29 Mar 2021 11:51:37 +0200
Message-Id: <50111a6565c1a7f7ab3130d4a5519aabdebef51f.1617011282.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1617011282.git.gustavo.pimentel@synopsys.com>
References: <cover.1617011282.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1617011282.git.gustavo.pimentel@synopsys.com>
References: <cover.1617011282.git.gustavo.pimentel@synopsys.com>
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

