Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5561BAC7E
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 20:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgD0SY1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 14:24:27 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53048 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbgD0SY1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 7B3884C867;
        Mon, 27 Apr 2020 18:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011863; x=1589826264; bh=bLYazg1sv1Yf5L9nAqAHsxzIv0PFIhlEuNP
        aBze48OU=; b=XmaCNS0N+i5pu4xyHVVw7plGrbwNf8QCFjJWGI0X3FODFxo2Czz
        4ItzA0UVSKUB5KOG6vNL5dLIejm8YO+rWpTxxTC6iAMY7MmEow6lZFg0WRBSlMT3
        z7HlQe0mv/5y1IiAQtR34Ic2yXdnMrtA/AkS+UfyjJPSGjpPEgQpwr7A=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yNVOxIz5Eabc; Mon, 27 Apr 2020 21:24:23 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 9B31D4C84A;
        Mon, 27 Apr 2020 21:24:12 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 Apr 2020 21:24:13 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v8 18/24] PCI: hotplug: Don't disable the released bridge windows immediately
Date:   Mon, 27 Apr 2020 21:23:52 +0300
Message-ID: <20200427182358.2067702-19-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
References: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
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

On a hotplug event with enabled BAR movement, calculating new BAR layout
and bridge windows takes some time. During this procedure, the structures
representing these windows are released - marked for recalculation.

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
index 4cadfa1f9519..3081f2d2a48a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1635,7 +1635,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
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

