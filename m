Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFC1243B02
	for <lists+linux-pci@lfdr.de>; Thu, 13 Aug 2020 15:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHMNwH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Aug 2020 09:52:07 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:35710 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbgHMNwG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Aug 2020 09:52:06 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 98B9BC064C;
        Thu, 13 Aug 2020 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1597326726; bh=yzB8/Z7iaUWDfNdmRjG5SrX9EVRt6A6h6N9NxCXx7Hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=CGRO4STE8E2VIelc/xJbK7NUTHE4cMbCefRhC2/T6WR2HnhT02m4PIJSGSx4uydKf
         A8ykZ5YyPt6VS9RXRpqfAkrtnyu2xEwuVWuk9Vzz21a+w91BvQOnnlLkKX9oZ3aDD9
         UM+DfVDj3SRT/XTHkpdJzgWvyyQ92TWYKDxHQUcu7hwbjLpv8J4BXhLsqKU85v95bG
         nOxio731XsmonXQeiL85hqRoypwjicLBpJeQ5V4Peu79m+VPwQP32XrOwU3q1J1DyI
         Ko0MTtJ3CtwlD+Qxy4/Nx9YZeM84JqS64XPpGXIerV6k8rmlsUR+FG1Hh3vs9W+xFJ
         Jg1Ss1OG5wLLw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 53CAEA005A;
        Thu, 13 Aug 2020 13:52:04 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH 1/3] PCI: Remove unnecessary header include (linux/of_pci.h)
Date:   Thu, 13 Aug 2020 15:51:51 +0200
Message-Id: <eba4c0f2b35b1442773a722f1cf73f7240f818e3.1597325845.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1597325845.git.gustavo.pimentel@synopsys.com>
References: <cover.1597325845.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1597325845.git.gustavo.pimentel@synopsys.com>
References: <cover.1597325845.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary header include (linux/of_pci.h) since it doesn't provide
any needed symbols.

Detected by CoverityScan CID 16442 ("Unnecessary header file (HFA)")

Cc: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c9338f9..e88a169 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/msi.h>
 #include <linux/of.h>
-#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
-- 
2.7.4

