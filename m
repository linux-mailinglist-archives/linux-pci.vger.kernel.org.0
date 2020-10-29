Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA7F29F49F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 20:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgJ2TOA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 15:14:00 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:53256 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725931AbgJ2TN7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 15:13:59 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EEDEA401BB;
        Thu, 29 Oct 2020 19:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603998839; bh=uxf9UiUbLpuCUBeziXn/RZtZDm4d8+F3FDqNugDYPU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=XI/BHT827xJGX6Hsg6j5zYgBuE6/eLVdMSBBUbmsWofisk1TVlzZov5dLhcrtFl6/
         nIzw1Ud/WxhhoKHoGxbuOLfM+ihLMb5Yx+jOeqPuqpzVbBCJr3fILPu5w3MjovlKPt
         vuy4osOVn3BljvsCAi25ww9gp5i8UVdBt38efiH0XXWvvTD85gMcairNHi15Bz6okJ
         z/qzsEICaTD9odxxEY2c3ileXM1ebF+n+CzNoqpUuI2HfHsTTuYMwAfdGC8FMlM9xe
         TcvP9h8Ud5jKV5V4zuCjbtWPdHFytakzapXvCMId9bB+WP5pVLRaf6NhxTvJ4srn5+
         B1dsuXWGITjtQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id C01AFA01F0;
        Thu, 29 Oct 2020 19:13:57 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Documentation: misc-devices: Add Documentation for dw-xdata-pcie driver
Date:   Thu, 29 Oct 2020 20:13:39 +0100
Message-Id: <cfd650d825cb669245e2a63f03db8fd952f28f2a.1603998630.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
References: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
References: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Documentation for dw-xdata-pcie driver.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/misc-devices/dw-xdata-pcie.rst | 43 ++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/misc-devices/dw-xdata-pcie.rst

diff --git a/Documentation/misc-devices/dw-xdata-pcie.rst b/Documentation/misc-devices/dw-xdata-pcie.rst
new file mode 100644
index 00000000..4d4616e
--- /dev/null
+++ b/Documentation/misc-devices/dw-xdata-pcie.rst
@@ -0,0 +1,43 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================================================w
+Driver for Synopsys DesignWare PCIe traffic generator (also known as xData)
+===========================================================================
+
+This driver should be used as a host-side (Root Complex) driver and Synopsys
+DesignWare prototype that includes this IP.
+
+The "dw-xdata-pcie" driver can be used to enable/disable PCIe traffic
+generator in either direction (mutual exclusion) besides allowing the
+PCIe link performance analysis.
+
+The interaction with this driver is done through the module parameter and
+can be changed in runtime. The driver outputs the requested command state
+information to /var/log/kern.log or dmesg.
+
+Request write TLPs traffic generation - Root Complex to Endpoint direction
+- Command:
+	echo w > /sys/module/dw_xdata_pcie/parameters/command
+- Output example:
+	dw-xdata-pcie 0000:01.0: xData: requested write transfer
+	dw-xdata-pcie 0000:01.0: xData: started write direction
+
+Request read TLPs traffic generation - Endpoint to Root Complex direction:
+- Command:
+	echo r > /sys/module/dw_xdata_pcie/parameters/command
+- Output example:
+	dw-xdata-pcie 0000:01.0: xData: requested read transfer
+	dw-xdata-pcie 0000:01.0: xData: started read direction
+
+Request to stop any current TLP transfer:
+- Command:
+	echo s > /sys/module/dw_xdata_pcie/parameters/command
+- Output example:
+	dw-xdata-pcie 0000:01.0: xData: requested stop any transfer
+
+Request PCIe link performance analysis:
+- Command:
+	echo p > /sys/module/dw_xdata_pcie/parameters/command
+   - Output example:
+	dw-xdata-pcie 0000:01.0: xData: requested performance analysis
+	dw-xdata-pcie 0000:01.0: xData: time=112000000us, read=0 MB/s, write=0 MB/s
-- 
2.7.4

