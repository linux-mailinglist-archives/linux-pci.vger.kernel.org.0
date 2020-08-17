Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B32247814
	for <lists+linux-pci@lfdr.de>; Mon, 17 Aug 2020 22:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgHQU1l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Aug 2020 16:27:41 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:54866 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727027AbgHQU1k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Aug 2020 16:27:40 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5A76540109;
        Mon, 17 Aug 2020 20:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1597696059; bh=/mZU8NdljqVw1Ap4a+xsODDUDF/FxqC6WRBQ/h6joSI=;
        h=From:To:Cc:Subject:Date:From;
        b=iAf+bx+S2X5tBh8bFYmCTcuQr+hVUnQWHffUeB+uRvrtDlRM2Nrzlr4D4XlFmiTr8
         Wa1EIWxoYVh+D/t8QvjQva8R4KULIFAzofNQn3oGe0T0ebak+oZXWNcaOfODDK395v
         jjBEMmAg6osE5TnVKH+v93unLi7eVGBHHiVCHuNJbTewkm0t2WYSR4xGdYs4yZQx7R
         MUg6iDug9Mp1fxIfliw/wvsfLy1uQB6X/pLYfr/uXExMBx9l2INmmRT270gEiN5r25
         DbTQfkosjkMoaqCFU6ZVZikbpy9gJMo2Qs50jfYw6p5D5u+Ywtd4IqFglqcc+G0IcI
         DCdkC1wlo1wdA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id B861FA005A;
        Mon, 17 Aug 2020 20:27:37 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2] MAINTAINERS: Add missing documentation references to PCI Endpoint Subsystem
Date:   Mon, 17 Aug 2020 22:27:34 +0200
Message-Id: <4fa78c7a24e8f8ec3206e1e8960dc18f505c9e29.1597695880.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adds documentation reference created by Kishon Abraham to the
MAINTAINERS list relative with the PCI endpoint subsystem section.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Changes V2:
	Replace file extestion from txt to rst

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e2698c..f264dc7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13192,6 +13192,8 @@ M:	Kishon Vijay Abraham I <kishon@ti.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
+F:	Documentation/PCI/endpoint/*
+F:	Documentation/misc-devices/pci-endpoint-test.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git
 F:	drivers/misc/pci_endpoint_test.c
 F:	drivers/pci/endpoint/
-- 
2.7.4

