Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2B34451E7
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 12:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhKDLD3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 07:03:29 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:40686 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230148AbhKDLD3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Nov 2021 07:03:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Uv1XgE-_1636023647;
Received: from localhost.localdomain(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0Uv1XgE-_1636023647)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Nov 2021 19:00:48 +0800
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
To:     helgaas@kernel.org
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, ying.huang@intel.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xuesong.chen@linux.alibaba.com
Subject: [PATCH v5 4/4] PCI: MCFG: Add the MCFG entry parse log message
Date:   Thu,  4 Nov 2021 19:00:40 +0800
Message-Id: <20211104110040.47815-1-xuesong.chen@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211104105715.47396-1-xuesong.chen@linux.alibaba.com>
References: <20211104105715.47396-1-xuesong.chen@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To make it to be consistent with x86's MMCONFIG and ease the
disection of PCI MCFG entry parse process.

Signed-off-by: Xuesong Chen <xuesong.chen@linux.alibaba.com>
---
 drivers/acpi/pci_mcfg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index b5ab866..99c9bf5 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -290,6 +290,9 @@ static __init int pci_mcfg_parse(struct acpi_table_header *header)
 		e->res.end = e->address + PCI_MMCFG_BUS_OFFSET(e->end_bus + 1) - 1;
 		e->res.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 		list_add(&e->list, &pci_mmcfg_list);
+		pr_info("MCFG entry for domain %04x [bus %02x-%02x] at %pR "
+			"(base %#lx)\n", e->segment, e->start_bus,
+			e->end_bus, &e->res, (unsigned long)e->address);
 	}
 
 #ifdef CONFIG_PCI_QUIRKS
-- 
2.9.5

