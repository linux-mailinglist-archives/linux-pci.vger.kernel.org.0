Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D18E3974
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410019AbfJXRMq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:12:46 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48808 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408021AbfJXRMq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:12:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 0DEE943E13;
        Thu, 24 Oct 2019 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937164; x=1573751565; bh=LpiNdNTxKihswl145tIG+dMOoQ28OjVfwW9
        SBN7HOII=; b=dLZ8gyDAxMpxJfT7Rw5wvwqevcTB998nvQPXdWqhv2y3gIvm5fD
        2Qzfhkq1AHS97bJRyiC0shAMIHLbvvBNdp7w7karyB+N/zRmVFlQ7WZI6j2uEuFb
        nGRnHaoXi0w2QcrSOb6FDqlCACgqjh0U+rPH6nY9xvRDK0IAeXVYLebA=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O4Uc7COed1Sb; Thu, 24 Oct 2019 20:12:44 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 22BF9437F8;
        Thu, 24 Oct 2019 20:12:41 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:12:40 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v6 07/30] PCI: hotplug: movable BARs: Don't disable the released bridge windows
Date:   Thu, 24 Oct 2019 20:12:05 +0300
Message-ID: <20191024171228.877974-8-s.miroshnichenko@yadro.com>
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

On a hotplug event with enabled BAR movement, calculating the new bridge
windows takes some time. During this procedure, the structures that
represent these windows are released - marked for recalculation.

When new bridge windows are ready, they are written to the registers of
every bridge via pci_setup_bridges().

Currently, bridge's registers are updated immediately after releasing a
window to disable it. But if a driver doesn't yet support movable BARs, it
doesn't stop MEM transactions during the hotplug, so disabled bridge
windows will break them.

Let the bridge windows remain operating after releasing, as they will be
updated to the new values in the end of a hotplug event.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 075e8185b936..381ce964cb20 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1588,7 +1588,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
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
2.23.0

