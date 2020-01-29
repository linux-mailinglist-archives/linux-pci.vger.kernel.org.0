Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8086D14CD5A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgA2P36 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:29:58 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55788 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbgA2P36 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:29:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id B8F4647624;
        Wed, 29 Jan 2020 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311795; x=1582126196; bh=Tgz54u7diwIvb8dpIP5Ngql5sr+OK2jAKnY
        mPkeaoNM=; b=nxYSUhCtAVLUme49e0lXcJlNhlXtj1daLyaPmPeJ30kSanSqRZQ
        KH1cUfUO1VBKlLw0MPlGolX2ea5AMQMuV3uciC1a0xPbaFk3e+gx3PTIqOvCNKKG
        399ck0r2A/gmrF9arLjsL/d1pHFx7NZHIG611JcVIUQO7Ce+l5khNg+M=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 863QO87jZGyP; Wed, 29 Jan 2020 18:29:55 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 2F831475F3;
        Wed, 29 Jan 2020 18:29:52 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:51 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 08/26] PCI: hotplug: Try to reassign movable BARs only once
Date:   Wed, 29 Jan 2020 18:29:19 +0300
Message-ID: <20200129152937.311162-9-s.miroshnichenko@yadro.com>
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

With enabled BAR movement, BARs and bridge windows can only be assigned to
their direct parents, so there can be only one variant of resource tree,
thus every retry within the pci_assign_unassigned_root_bus_resources() will
result in the same tree, and it is enough to try just once.

In case of failures the pci_reassign_root_bus_resources() disables BARs for
one of the hotplugged devices and tries the assignment again.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b9521ca8b24c..e87fefa12f62 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1827,6 +1827,13 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	int pci_try_num = 1;
 	enum enable_type enable_local;
 
+	if (pci_can_move_bars) {
+		__pci_bus_size_bridges(bus, NULL);
+		__pci_bus_assign_resources(bus, NULL, NULL);
+
+		goto dump;
+	}
+
 	/* Don't realloc if asked to do so */
 	enable_local = pci_realloc_detect(bus, pci_realloc_enable);
 	if (pci_realloc_enabled(enable_local)) {
-- 
2.24.1

