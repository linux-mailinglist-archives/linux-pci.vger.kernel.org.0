Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1412D30E5E7
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 23:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhBCWOg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 17:14:36 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:32808 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232446AbhBCWN5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 17:13:57 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9BFF140489;
        Wed,  3 Feb 2021 22:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612390376; bh=wTDtZw8zXSiDJYCQgfDlx/77INQB9/ASV35kYlcbdFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=DQm8TqRARbtNcGLNuZRyImIEKpLDuy3vAFBngfUYyYGg0I5h+YO443M/lO1XY5Rzt
         5G0O4ciZHio3qfkzL9WOXP5sBGTT2MjH/KrBQhcvsDZXaszANDMapQiyx2ZPPMZ/HT
         MrGRJBKDhhNIbMJIRuAoMobABuTY+0VKTNqlsu5Lqzf6n2UUOGGji8U79yRpzsdq3x
         TXWaT/nMA+avN0+7IJb1rD0dkMN6M69o0y8Xaoim7JCDdL3cKiTj0GiKLxL9NYJOKX
         eL+LyvnSY5c/l6YNsD/m5IImQ3zUj4xWzEXFgwKcB0GyPKqbhMDOHCvyh5SVrGKnHy
         Ary5DLkZSC9Kg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5D11BA0249;
        Wed,  3 Feb 2021 22:12:55 +0000 (UTC)
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
Subject: [RESEND v4 3/6] misc: Add Synopsys DesignWare xData IP driver to Kconfig
Date:   Wed,  3 Feb 2021 23:12:48 +0100
Message-Id: <81f95c6ff0faaf8cbb56430320abb76af772a339.1612390291.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys DesignWare xData IP driver to Kconfig.

This driver enables/disables the PCIe traffic generator module
pertain to the Synopsys DesignWare prototype.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fafa8b0..6d5783f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -423,6 +423,17 @@ config SRAM
 config SRAM_EXEC
 	bool
 
+config DW_XDATA_PCIE
+	depends on PCI
+	tristate "Synopsys DesignWare xData PCIe driver"
+	default	n
+	help
+	  This driver allows controlling Synopsys DesignWare PCIe traffic
+	  generator IP also known as xData, present in Synopsys Designware
+	  PCIe Endpoint prototype.
+
+	  If unsure, say N.
+
 config PCI_ENDPOINT_TEST
 	depends on PCI
 	select CRC32
-- 
2.7.4

