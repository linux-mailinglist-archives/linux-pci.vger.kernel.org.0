Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9897F14CD6D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgA2PaH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:07 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55810 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbgA2PaG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2712E4763E;
        Wed, 29 Jan 2020 15:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311805; x=1582126206; bh=riMEpjx5d73zNdTdzcKU9rJjNdZY1fOOG9n
        sS7WeBME=; b=srKso9NjyiRhKcKyDPp8NCS83gZ5XUzg39xqdjeZ0U1bkdtM+bb
        P98pLU/3+Fz24MZlUL0UFGQJi+Y5580UV958HoMTG0VraEOnGuGypup0seO1F4BM
        uH/Z/qCWEBEWkLMxZkkVDSAqAVMNYWsIYVH4v9lpQodyzBwy/MwqTXl4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZpwwAmECWCKF; Wed, 29 Jan 2020 18:30:05 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 417C547620;
        Wed, 29 Jan 2020 18:29:55 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:54 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 23/26] PCI: Don't claim immovable BARs
Date:   Wed, 29 Jan 2020 18:29:34 +0300
Message-ID: <20200129152937.311162-24-s.miroshnichenko@yadro.com>
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

Immovable BAR always has an address, but its parent bridge window can
be not yet calculated (during boot) or temporarily released for re-
calculation (during PCI rescan) when pci_claim_resource() is called.

Apart from that, immovable BARs now have separate guaranteed mechanism
of assigning comparing to usual BARs, so claiming them is not needed.

Return immediately from pci_claim_resource() to prevent misleading
"can't claim BAR ... no compatible bridge window" error messages

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-res.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 4043aab021dd..dc9b52f11922 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -138,6 +138,9 @@ int pci_claim_resource(struct pci_dev *dev, int resource)
 		return -EINVAL;
 	}
 
+	if (pci_can_move_bars && !pci_dev_bar_movable(dev, res))
+		return 0;
+
 	/*
 	 * If we have a shadow copy in RAM, the PCI device doesn't respond
 	 * to the shadow range, so we don't need to claim it, and upstream
-- 
2.24.1

