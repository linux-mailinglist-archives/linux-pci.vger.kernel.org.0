Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A38D014CD63
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgA2PaK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:10 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55810 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727112AbgA2PaK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:10 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id CA9C24764A;
        Wed, 29 Jan 2020 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311807; x=1582126208; bh=nTwQVNqKc1oZ/BG+7BiUIzTNNF70SzPZsJQ
        u1kL4W+I=; b=jubS1uzIZkFvGtcwhmM8/Y1bvbiTy5/dm25FTfOqI8R3Ego1Qlv
        0BCSqLgeGOtAUgkMHxbNWvDQAl+jNL/XpT3YbFJmkna/B0Z4hrCRWWyAo+gdIBPX
        9uVgJtOrjWymI3wy/z4vQcc0RH+Ss4/pL8FPBpWpdeEiz1AUDSuBscW4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LhPz2JvsOZeb; Wed, 29 Jan 2020 18:30:07 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id DE2BC47608;
        Wed, 29 Jan 2020 18:29:55 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:55 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 26/26] PCI/portdrv: Declare support of movable BARs
Date:   Wed, 29 Jan 2020 18:29:37 +0300
Message-ID: <20200129152937.311162-27-s.miroshnichenko@yadro.com>
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

Currently there are no reliable way to determine if a driver uses BARs of
its devices (their struct resource don't always have a child), so if it
doesn't explicitly support movable BARs, they are considered immovable.

The portdrv driver for PCI switches don't use BARs, so add empty hooks
.rescan_prepare() and .rescan_done() to increase chances to allocate new
BARs for new devices.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pcie/portdrv_pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 160d67c59310..df1faf2fed86 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -205,6 +205,14 @@ static const struct pci_error_handlers pcie_portdrv_err_handler = {
 	.resume = pcie_portdrv_err_resume,
 };
 
+static void pcie_portdrv_rescan_prepare(struct pci_dev *pdev)
+{
+}
+
+static void pcie_portdrv_rescan_done(struct pci_dev *pdev)
+{
+}
+
 static struct pci_driver pcie_portdriver = {
 	.name		= "pcieport",
 	.id_table	= &port_pci_ids[0],
@@ -215,6 +223,9 @@ static struct pci_driver pcie_portdriver = {
 
 	.err_handler	= &pcie_portdrv_err_handler,
 
+	.rescan_prepare	= pcie_portdrv_rescan_prepare,
+	.rescan_done	= pcie_portdrv_rescan_done,
+
 	.driver.pm	= PCIE_PORTDRV_PM_OPS,
 };
 
-- 
2.24.1

