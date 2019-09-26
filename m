Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFBCBF1AC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 13:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfIZLcN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 07:32:13 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57298 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfIZLcJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 07:32:09 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBW1d1026527;
        Thu, 26 Sep 2019 06:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569497521;
        bh=88Xv9IRV7+oNSxAgr2jq3XB2+SHFQvDvj39xR9Z58mQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eyZNqkD+oH2zsbe88+Ktakn1JXraKUrcBJUMmBPftF8+Ry1V36N0LmBeo8NhyMzsr
         NsqdZJ9Cbl3tcy85cp1uGVuJ5vkqfLZ4abIP2F+abI4YsOJ0NPn4skrL4ro/kBCybP
         VFuPC3aepTsuTunrzfK/bKrjRW8jkJwx7chGJ4Pc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8QBW1NA032455
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Sep 2019 06:32:01 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:32:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:31:54 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUTkE069017;
        Thu, 26 Sep 2019 06:31:57 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-ntb@googlegroups.com>
Subject: [RFC PATCH 21/21] NTB: tool: Enable the NTB/PCIe link on the local or remote side of bridge
Date:   Thu, 26 Sep 2019 16:59:33 +0530
Message-ID: <20190926112933.8922-22-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926112933.8922-1-kishon@ti.com>
References: <20190926112933.8922-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Invoke ntb_link_enable() to enable the NTB/PCIe link on the local
or remote side of the bridge.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/ntb/test/ntb_tool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index d592c0ffbd19..04138e6a371b 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -1638,6 +1638,7 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
 
 	tool_setup_dbgfs(tc);
 
+	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
 	return 0;
 
 err_clear_mws:
-- 
2.17.1

