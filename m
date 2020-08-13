Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13302243B03
	for <lists+linux-pci@lfdr.de>; Thu, 13 Aug 2020 15:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHMNwI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Aug 2020 09:52:08 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:35716 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgHMNwH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Aug 2020 09:52:07 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A0D0CC0780;
        Thu, 13 Aug 2020 13:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1597326726; bh=vL0KT1sXzpjpv+6oaLJzeXMTmB7aAZE0t9J0aO0DfDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=KSuIGS4K+HVozC1khf+QKvZvelhkweh1FHsHH64gsG5YEztdUhrq/amZhgjMf2A3X
         TnZ+hB31tSjKSjB7dgFSDqGO8zHkPERXZnxALv7z4Za7OkYNTnw8L7N+aXkn+0HMcX
         48V9sgbURK2Uyk9mTwxYicHc9tO8ICHO7dWmxP9TD4SNQHyjUZkdoJbFMPnCJupEDP
         KlNR1Pf2mLBbgivNj887B30b+E+X9Fj5seukQqMSXWpL5QnMs9sebPGtE1qLsCaGwj
         JVd9V9uOogH7DMVzhc+OFKk7j185WU6YzA6fTKUrPozHyCYmhY8+vC91S+Hf2iX1/+
         7Dxj766Jq2s7w==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 62C48A0083;
        Thu, 13 Aug 2020 13:52:05 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH 2/3] PCI: Remove unnecessary header include (linux/pci-ats.h)
Date:   Thu, 13 Aug 2020 15:51:52 +0200
Message-Id: <72ade1f5af35b994a7a8216ea5dc32c27cf134cd.1597325845.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1597325845.git.gustavo.pimentel@synopsys.com>
References: <cover.1597325845.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1597325845.git.gustavo.pimentel@synopsys.com>
References: <cover.1597325845.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary header include (linux/pci-ats.h) since it doesn't provide
any needed symbols.

Detected by CoverityScan CID 16443 ("Unnecessary header file (HFA)")

Cc: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e88a169..af68e79 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -29,7 +29,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/pci_hotplug.h>
 #include <linux/vmalloc.h>
-#include <linux/pci-ats.h>
 #include <asm/setup.h>
 #include <asm/dma.h>
 #include <linux/aer.h>
-- 
2.7.4

