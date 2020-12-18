Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7674F2DE880
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgLRRnS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:43:18 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:38598 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727967AbgLRRnS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:43:18 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 20805413D6;
        Fri, 18 Dec 2020 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313293; x=1610127694; bh=6+JB6ailJ7ODm11KjGiL514scFTPER5Q1H2
        hndZUQfI=; b=iQlj6ZsUib11ooJwdmi6JN5wyEpC/wJR6tuFeZrHsAOU99eyz+4
        c2bN9IuhhwM2zqu4DsZzKmit2U/h09oF8nGAQzJn5iw1sFCfmxqSRAeNJ1hoNlEc
        o+L4sVtGd7LKztZmIh85G58sYKvxuY0aLHl3O+XAsL4igc7cMR1foRgg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id scIF4c0UVia7; Fri, 18 Dec 2020 20:41:33 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 3586741396;
        Fri, 18 Dec 2020 20:41:11 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 18
 Dec 2020 20:41:10 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v9 25/26] PCI: Add a message for updating BARs
Date:   Fri, 18 Dec 2020 20:40:10 +0300
Message-ID: <20201218174011.340514-26-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new debug message for changing a BAR value of a device:

[    1.851161] pci 0003:0a:00.1: BAR 0 updated: 0x60200c2000000 -> 0x6020142000000

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-res.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 83a491f6a2c2..5fed21aed9b8 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -27,7 +27,8 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 	struct pci_bus_region region;
 	bool disable;
 	u16 cmd;
-	u32 new, check, mask;
+	u32 new, check, mask, old;
+	u64 old_start;
 	int reg;
 	struct resource *res = dev->resource + resno;
 
@@ -96,6 +97,9 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 				      cmd & ~PCI_COMMAND_MEMORY);
 	}
 
+	pci_read_config_dword(dev, reg, &old);
+	old_start = old & mask;
+
 	pci_write_config_dword(dev, reg, new);
 	pci_read_config_dword(dev, reg, &check);
 
@@ -105,6 +109,9 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 	}
 
 	if (res->flags & IORESOURCE_MEM_64) {
+		pci_read_config_dword(dev, reg + 4, &old);
+		old_start |= (u64)old << 32;
+
 		new = region.start >> 16 >> 16;
 		pci_write_config_dword(dev, reg + 4, new);
 		pci_read_config_dword(dev, reg + 4, &check);
@@ -116,6 +123,11 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 
 	if (disable)
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
+
+	if (old_start != region.start)
+		pci_info(dev, "BAR %d updated: %#llx -> %#llx\n", resno,
+			 (unsigned long long)old_start,
+			 (unsigned long long)region.start);
 }
 
 void pci_update_resource(struct pci_dev *dev, int resno)
-- 
2.24.1

