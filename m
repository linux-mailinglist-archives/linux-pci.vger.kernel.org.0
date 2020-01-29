Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A5C14CD6A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgA2PaG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:06 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55810 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbgA2PaF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:05 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id B997F47615;
        Wed, 29 Jan 2020 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311803; x=1582126204; bh=KIR0MC8rCtR1zPZojKGWoiMuTlUAufIezN8
        /SU4Jg5Q=; b=Wl5fEsm3fMTOSCoZfQa4kn6YpNUakWRTG9okSYRfwGJ9uJz72Z5
        xk7hC1LAYvhqHj2yWVgKj7bATi3v1dGzAb/ItBCCH7T6LEwbxcJ6PoH9kbXsKokj
        vz4Wq72HQatsMYCamaB/vMfztBPkJi+m44OojS46CjOeCLx6XtDxqBLA=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 93xQ11qWup73; Wed, 29 Jan 2020 18:30:03 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A21EA47619;
        Wed, 29 Jan 2020 18:29:54 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:54 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v7 20/26] PNP: Don't reserve BARs for PCI when enabled movable BARs
Date:   Wed, 29 Jan 2020 18:29:31 +0300
Message-ID: <20200129152937.311162-21-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
References: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the Movable BARs feature is supported, the PCI subsystem is able to
distribute existing BARs and allocate the new ones itself, without need to
reserve gaps by BIOS.

CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pnp/system.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pnp/system.c b/drivers/pnp/system.c
index 6950503741eb..16cd260a609d 100644
--- a/drivers/pnp/system.c
+++ b/drivers/pnp/system.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 
@@ -58,6 +59,11 @@ static void reserve_resources_of_dev(struct pnp_dev *dev)
 	struct resource *res;
 	int i;
 
+#ifdef CONFIG_PCI
+	if (pci_can_move_bars)
+		return;
+#endif
+
 	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IO, i)); i++) {
 		if (res->flags & IORESOURCE_DISABLED)
 			continue;
-- 
2.24.1

