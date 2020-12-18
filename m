Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AE52DE87B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgLRRnO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:43:14 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:38592 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728115AbgLRRnO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:43:14 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id D46A9413C3;
        Fri, 18 Dec 2020 17:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313289; x=1610127690; bh=YT0S6jRZmFKntF1RfxOxE05+Oc1ixfUdEj+
        FCmojLYA=; b=V6DapAPv9clT4CnH3nPC8xJ8wfUdTBCe1XQ9mwnv5b4NUsjOvT+
        8nzCazdquPMJEEWi9scXkVOYW6UCQwhiWrc4K0WNyxfZkoGGtIJUFpc+tH+VqeKL
        r/ts/n6DsKstuw5Gqqk/b581SOi5Bz8HOhcEP3wrBfaVMSFeWyhc/bY4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mzM7ohzCnT47; Fri, 18 Dec 2020 20:41:29 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 3CD44413DD;
        Fri, 18 Dec 2020 20:41:10 +0300 (MSK)
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
Subject: [PATCH v9 21/26] PCI: Rescan the bus to resize a BAR
Date:   Fri, 18 Dec 2020 20:40:06 +0300
Message-ID: <20201218174011.340514-22-s.miroshnichenko@yadro.com>
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

BAR resizing can be blocked by another BAR, so trigger a bus rescan to be
able to move BARs, increasing the probability of finding a good layout.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-res.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 28ec3d8c79c8..83a491f6a2c2 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -480,6 +480,9 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	u32 sizes;
 	u16 cmd;
 
+	if (pci_dev_bar_fixed(dev, res))
+		return -EOPNOTSUPP;
+
 	/* Make sure the resource isn't assigned before resizing it. */
 	if (!(res->flags & IORESOURCE_UNSET))
 		return -EBUSY;
@@ -506,7 +509,15 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
 
 	/* Check if the new config works by trying to assign everything. */
-	if (dev->bus->self) {
+	if (pci_can_move_bars) {
+		pci_rescan_bus(dev->bus);
+
+		if (!res->flags || (res->flags & IORESOURCE_UNSET) || !res->parent) {
+			pci_err(dev, "BAR %d resize failed\n", resno);
+			ret = -1;
+			goto error_resize;
+		}
+	} else if (dev->bus->self) {
 		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
 		if (ret)
 			goto error_resize;
@@ -516,6 +527,8 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 error_resize:
 	pci_rebar_set_size(dev, resno, old);
 	res->end = res->start + pci_rebar_size_to_bytes(old) - 1;
+	if (pci_can_move_bars)
+		pci_rescan_bus(dev->bus);
 	return ret;
 }
 EXPORT_SYMBOL(pci_resize_resource);
-- 
2.24.1

