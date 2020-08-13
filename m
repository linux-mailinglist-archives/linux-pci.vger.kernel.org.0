Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE17243B04
	for <lists+linux-pci@lfdr.de>; Thu, 13 Aug 2020 15:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgHMNwI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Aug 2020 09:52:08 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:45758 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbgHMNwI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Aug 2020 09:52:08 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AB3EB407CE;
        Thu, 13 Aug 2020 13:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1597326727; bh=o/KRBkqrw6FXXtjNMDXpM3P8oaIL+jD04jvdUYD2W80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=gZQkbIc9biMPok4Fhwu/8gchG9EbrmlhJY5jthtn08oJV2Rk0Hy01zdQu5psJr1n1
         xzujCg77Gg3KfhPA6tUn2+HLjtsIRiqJ05elsTL3dm54D6lq1To8E3gwMEKcyHLgPl
         I7njzc6s3b5R3uTkzMtZ+ii67UIa5Q1gegUipDstL8DzlEGHu8tr01o+BkCTwJ0w/b
         vRRm9d3DpHqtCpgFC8S0zxGgsh1xdqFchL/P6njCCs3zyyd/tHubdy5yLSh13L/irJ
         PbvAC7TXGLD02RhoVkaDAhNJgXny75IQ0g9nvdfvg9cpxcFc784Xo6f3PvAqkLCd7u
         6PV6NXrEp9+Cw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 717DDA005A;
        Thu, 13 Aug 2020 13:52:06 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH 3/3] PCI: Remove unnecessary header include (asm/setup.h)
Date:   Thu, 13 Aug 2020 15:51:53 +0200
Message-Id: <715821dc855add2565505ff8dcb9970e87996c5c.1597325845.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1597325845.git.gustavo.pimentel@synopsys.com>
References: <cover.1597325845.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1597325845.git.gustavo.pimentel@synopsys.com>
References: <cover.1597325845.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary header include (asm/setup.h) since it doesn't provide
any needed symbols.

Detected by CoverityScan CID 16444 ("Unnecessary header file (HFA)")

Cc: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af68e79..39d808a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -29,7 +29,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/pci_hotplug.h>
 #include <linux/vmalloc.h>
-#include <asm/setup.h>
 #include <asm/dma.h>
 #include <linux/aer.h>
 #include "pci.h"
-- 
2.7.4

