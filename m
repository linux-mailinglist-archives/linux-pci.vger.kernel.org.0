Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B779AE3989
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439952AbfJXRM5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:12:57 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48986 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436814AbfJXRM4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:12:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id B70E9437F3;
        Thu, 24 Oct 2019 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937174; x=1573751575; bh=tAJ6LG7xv03hfVfcclMX90rnUJKCJ1G3FmF
        9HhqNFeI=; b=FaxfcdELYvncaar7/BGagEloRrYHIq4UGgeM9O42eEmTFzNtR6W
        8HBjbTt1qiI0rJeChAKYUk8Hu9/IaTRAaNahHDiGY78zyDvP65Cg0uD3W3sGtzUO
        +g6qrxUGzKJ9PY/n/me0EMZDwMFF1dMMjGXlkDCbtc4LqWHBEe5mRHE8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WA_aE2_I2WcZ; Thu, 24 Oct 2019 20:12:54 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 6B2F5437F6;
        Thu, 24 Oct 2019 20:12:44 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:12:44 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 25/30] PNP: Don't reserve BARs for PCI when enabled movable BARs
Date:   Thu, 24 Oct 2019 20:12:23 +0300
Message-ID: <20191024171228.877974-26-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024171228.877974-1-s.miroshnichenko@yadro.com>
References: <20191024171228.877974-1-s.miroshnichenko@yadro.com>
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
Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pnp/system.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pnp/system.c b/drivers/pnp/system.c
index 6950503741eb..5977bd11f4d4 100644
--- a/drivers/pnp/system.c
+++ b/drivers/pnp/system.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 
@@ -58,6 +59,9 @@ static void reserve_resources_of_dev(struct pnp_dev *dev)
 	struct resource *res;
 	int i;
 
+	if (pci_can_move_bars)
+		return;
+
 	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IO, i)); i++) {
 		if (res->flags & IORESOURCE_DISABLED)
 			continue;
-- 
2.23.0

