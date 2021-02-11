Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85A03186D4
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 10:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhBKJQz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 04:16:55 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:34052 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230050AbhBKJKr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 04:10:47 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2AA23400E6;
        Thu, 11 Feb 2021 09:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613034552; bh=jSQ7gPD0eg5i7tdOXR7I0dbZcd3MOQ43M0ZUh6bw2F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=axmNSDqnwpI/ta3MHVe9xGArkhzKXPWzVTF749twbQszkead0wZx+CVqMWF1crcYu
         W6mA/sZp5QgSNTUbAYARk4HYFqxDtKs0kYHA6PO88JCeiVdfd5pjzQnMiwdolrJdwr
         YggBesk+SH0t2e8cvb8IjvRiWjESJKO98ca7kajTRmmk9gHyIMr/x8G8JTEM15SIfF
         zI6Vl5mHagX6olNWllwsaOKYNQS2h6hMA7VpuefzXlw5PCidiEzk3MQHuQdAvDRX4e
         uANizhu6xHVK9vFK4uWx84aPqk2yEjGuRvdoGEr/4PNUMdA3i1DtPPHMRsHBJJjQil
         1MUSgzF2GIJ8Q==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7A3BFA005D;
        Thu, 11 Feb 2021 09:09:09 +0000 (UTC)
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
Subject: [PATCH v5 2/6] misc: Add Synopsys DesignWare xData IP driver to Makefile
Date:   Thu, 11 Feb 2021 10:08:39 +0100
Message-Id: <04060811848603958d9d3c1f2b577169c9021ce4.1613034397.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys DesignWare xData IP driver to Makefile.

This driver enables/disables the PCIe traffic generator module
pertain to the Synopsys DesignWare prototype.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d23231e..bf22021 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_CXL_BASE)		+= cxl/
+obj-$(CONFIG_DW_XDATA_PCIE)	+= dw-xdata-pcie.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
-- 
2.7.4

