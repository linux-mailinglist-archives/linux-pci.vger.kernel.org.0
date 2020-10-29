Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834DB29F4A3
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 20:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJ2TOE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 15:14:04 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45726 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725966AbgJ2TOB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 15:14:01 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E4BFEC00A7;
        Thu, 29 Oct 2020 19:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603998841; bh=RO/8M1ouuGZ/BKWm6mH9mNZrmilurSWh3/7c5LQp898=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=YE3YxNgWpjbsd6DPPOk8lpRdb+O7t1s4k0Nc+/dowIgvIPez0clOaqyt26bjAaTxJ
         humUSu6qp/9p2sThN4mZj1rivZwDtQ0CszH7vvVyfCBgRX3OfUEVspfFchFYoFECIM
         6QN5JgShgPLpR00hTJemUxSi3bnNNe0ACXX0JZmg93FCUFBdv2+xoI+1fdET2+hl1T
         LkSNSuJuCKZKX/GcC/aMHwy3krp3M+X/7w3Xh2JdleiGD93zP1Yfrrf0/aOVLRuLUU
         FKz+fIl8fcUiAvpeuXbhQMEdFXxhnOIJpTgsQa+dlXn7SdWhNxnojkY6KRBEFe1HKO
         774zVaerCQBgw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8C85DA01F0;
        Thu, 29 Oct 2020 19:13:59 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] MAINTAINERS: Add Synopsys xData IP driver maintainer
Date:   Thu, 29 Oct 2020 20:13:40 +0100
Message-Id: <f8e5bba9f878e176668fe7e4fb2e790d9df8bc71.1603998630.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
References: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
References: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys xData IP driver maintainer.

This driver aims to support Synopsys xData IP and is normally distributed
along with Synopsys PCIe EndPoint IP as a PCIe traffic generator (depends
of the use and licensing agreement).

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/misc-devices/dw-xdata-pcie.rst | 4 ++--
 MAINTAINERS                                  | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/misc-devices/dw-xdata-pcie.rst b/Documentation/misc-devices/dw-xdata-pcie.rst
index 4d4616e..3d2981d 100644
--- a/Documentation/misc-devices/dw-xdata-pcie.rst
+++ b/Documentation/misc-devices/dw-xdata-pcie.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-===========================================================================w
+===========================================================================
 Driver for Synopsys DesignWare PCIe traffic generator (also known as xData)
 ===========================================================================
 
@@ -40,4 +40,4 @@ Request PCIe link performance analysis:
 	echo p > /sys/module/dw_xdata_pcie/parameters/command
    - Output example:
 	dw-xdata-pcie 0000:01.0: xData: requested performance analysis
-	dw-xdata-pcie 0000:01.0: xData: time=112000000us, read=0 MB/s, write=0 MB/s
+	dw-xdata-pcie 0000:01.0: xData: time=100000000 us, write=0 MB/s, read=0 MB/s
diff --git a/MAINTAINERS b/MAINTAINERS
index 8671573..8856f6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4983,6 +4983,13 @@ S:	Maintained
 F:	drivers/dma/dw-edma/
 F:	include/linux/dma/edma.h
 
+DESIGNWARE XDATA IP DRIVER
+M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/misc-devices/dw-xdata-pcie.rst
+F:	drivers/misc/dw-xdata-pcie.c
+
 DESIGNWARE USB2 DRD IP DRIVER
 M:	Minas Harutyunyan <hminas@synopsys.com>
 L:	linux-usb@vger.kernel.org
-- 
2.7.4

