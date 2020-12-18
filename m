Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5195B2DE879
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgLRRmv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:42:51 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:38572 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727981AbgLRRmv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:42:51 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 063E3413D2;
        Fri, 18 Dec 2020 17:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313291; x=1610127692; bh=faXA1qHhZ+GvL5/hTU6Bm/jkEm46iZZ2A5G
        poLgSabg=; b=OSP40vJJ/x6Fe3nHZjvgjTanR/79u6CLTfpMEFLUg6QB3a1Ux8L
        Cwz8aaNfFmiGIze1gVaSfml8Na6SDQadtEFoKJmaQz8pTnXXu1IauKzRKWqYOq++
        3YXT0G9O7GJxlwxsgN6RhVOnBt3Z6+WR8TaTCpjFRhTUwOXXhyge5PO4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UQ7DE-EDqd8z; Fri, 18 Dec 2020 20:41:31 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id B5FFD413CE;
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
Subject: [PATCH v9 23/26] PCI/portdrv: Declare support of movable BARs
Date:   Fri, 18 Dec 2020 20:40:08 +0300
Message-ID: <20201218174011.340514-24-s.miroshnichenko@yadro.com>
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

Currently there are no reliable way to determine if a driver uses BARs of
its devices (their struct resource don't always have a child), so if it
doesn't explicitly support movable BARs, they are considered fixed.

The portdrv driver for PCI switches don't use BARs, so add a new hook
.bar_fixed() { return false; } to increase the chances to allocate new
BARs for new devices.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pcie/portdrv_pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 0b250bc5f405..3043f7e4d3c1 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -212,6 +212,11 @@ static const struct pci_error_handlers pcie_portdrv_err_handler = {
 	.resume = pcie_portdrv_err_resume,
 };
 
+static bool pcie_portdrv_bar_fixed(struct pci_dev *pdev, int resno)
+{
+	return false;
+}
+
 static struct pci_driver pcie_portdriver = {
 	.name		= "pcieport",
 	.id_table	= &port_pci_ids[0],
@@ -222,6 +227,8 @@ static struct pci_driver pcie_portdriver = {
 
 	.err_handler	= &pcie_portdrv_err_handler,
 
+	.bar_fixed	= pcie_portdrv_bar_fixed,
+
 	.driver.pm	= PCIE_PORTDRV_PM_OPS,
 };
 
-- 
2.24.1

