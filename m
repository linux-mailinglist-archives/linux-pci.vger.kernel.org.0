Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2882DE87D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgLRRnP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:43:15 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:38590 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727981AbgLRRnP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:43:15 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 5BDBD412EC;
        Fri, 18 Dec 2020 17:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313282; x=1610127683; bh=0bEjkx9ssfVEMvJrSYLU+CqcgBfmVLRsI4V
        2h/RC0J0=; b=th44KhD3NR4x8+fNrTD8KtS6p5Hz9HNlZGeOhcPyJmllnuRDfEy
        5BeZEYh932ch6LIeHNMDv/ce9riA8oJ4VCkGK40UkpCIprxIMVcox5sxN6KyuJC9
        vTZGCxvAmVL+JyEla7ggeekv6+eGpF+6DkwteT8XAHCfPm+bB9qTqMlY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1k_t8HD_hBOL; Fri, 18 Dec 2020 20:41:22 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 55341413CB;
        Fri, 18 Dec 2020 20:41:09 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 18
 Dec 2020 20:41:09 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v9 17/26] PCI: hotplug: Don't disable the released bridge windows immediately
Date:   Fri, 18 Dec 2020 20:40:02 +0300
Message-ID: <20201218174011.340514-18-s.miroshnichenko@yadro.com>
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

On a hotplug event with enabled BAR movement, calculating new BAR layout
and bridge windows takes some time. During this procedure, the structures
representing these windows are released: marked for a recalculation.

When the new bridge window values are ready, they are written to the bridge
registers via pci_setup_bridges().

Currently, bridge's registers are updated immediately after releasing a
window to disable it. But if a driver doesn't yet support movable BARs, it
doesn't stop MEM transactions during the hotplug, so disabled bridge
windows will break them.

Let the bridge windows remain operating after releasing, as they will be
updated to the new values in the end of a hotplug event.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ab58b999ac6d..f98772474421 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1649,7 +1649,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		/* Avoiding touch the one without PREF */
 		if (type & IORESOURCE_PREFETCH)
 			type = IORESOURCE_PREFETCH;
-		__pci_setup_bridge(bus, type);
+		if (!pci_can_move_bars)
+			__pci_setup_bridge(bus, type);
 		/* For next child res under same bridge */
 		r->flags = old_flags;
 	}
-- 
2.24.1

