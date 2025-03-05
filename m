Return-Path: <linux-pci+bounces-22947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 520D6A4F78C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 08:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8028A16D7F6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 07:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9211D7E42;
	Wed,  5 Mar 2025 07:00:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B3B1624F4;
	Wed,  5 Mar 2025 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741158040; cv=none; b=O1bs3/TQ8NIjBnatYLNfF6vXvIIoc9PIuKW3tW9DPjZL+vkQarxXyE33WaAAb91j9JEgNPUesMCoiC0toYjqnoXQNtdaDAXYAvuLoVYhM/7spPxTa18CljrtFRGyQpECNBqgE+LskkhE/mY3UaLtu/nGssWzckCEJcc6yYqwuhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741158040; c=relaxed/simple;
	bh=9QikDYK+3tYTuvc1ymNruhEwmkpk0z0bcmhi7zHeuho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fUXmsbi/2NmoHN9d5yn0OKY3NU01djQjY+DJF9JItYwgO/sWNrORRycwnkwFd3FbNRUsFO3tEVevVBce9Ywx9r06xEF3M4yPz586m7G0y0sAL/Abfjiix81OAzmMVIJPlxbBCjz0SKRlG+ODiaD1AVK/TyPitI+2dnGfQv7m5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201604.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202503051500254125;
        Wed, 05 Mar 2025 15:00:25 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 15:00:24 +0800
Received: from locahost.localdomain (10.94.3.63) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 15:00:23 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] PCI: mediatek-gen3: fix inconsistent indenting warning
Date: Wed, 5 Mar 2025 15:00:22 +0800
Message-ID: <20250305070022.4668-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201613.home.langchao.com (10.100.2.13) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 202530515002533dc4868a0a3680aa1f21efe3607861b
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
drivers/pci/controller/pcie-mediatek-gen3.c:922 mtk_pcie_parse_port() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 3583e5481dc8..2d1675ba496b 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -919,13 +919,13 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 		return pcie->num_clks;
 	}
 
-       ret = of_property_read_u32(dev->of_node, "num-lanes", &num_lanes);
-       if (ret == 0) {
-	       if (num_lanes == 0 || num_lanes > 16 || (num_lanes != 1 && num_lanes % 2))
+	ret = of_property_read_u32(dev->of_node, "num-lanes", &num_lanes);
+	if (ret == 0) {
+		if (num_lanes == 0 || num_lanes > 16 || (num_lanes != 1 && num_lanes % 2))
 			dev_warn(dev, "invalid num-lanes, using controller defaults\n");
-	       else
+		else
 			pcie->num_lanes = num_lanes;
-       }
+	}
 
 	return 0;
 }
-- 
2.43.0


