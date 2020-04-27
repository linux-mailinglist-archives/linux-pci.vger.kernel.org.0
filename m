Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD421BAC84
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 20:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgD0SYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 14:24:30 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53048 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbgD0SY3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:29 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2E15F4C870;
        Mon, 27 Apr 2020 18:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011866; x=1589826267; bh=fu1E8WOX4eOpLnmJsfb/+rhytgo+CrbLTo9
        FEu6gt2g=; b=OKt49nuSrMkPbLRfgGXpcIPSg8Iazs5Pf57sCFNfGySZjBHQhrw
        QhtOeZZav+utZozC0YybMAaFkSSgWu7L7FSSUpxViC9RV3q4cHJT6Zoj/dai3bzw
        6fX80HxY15/tWK3i5gy2VV0mEtCSZxKeHVI2j+A+AWzRtZygmrG7/67M=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sQqm9Z39-T3h; Mon, 27 Apr 2020 21:24:26 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id BD22D4C84F;
        Mon, 27 Apr 2020 21:24:13 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 Apr 2020 21:24:14 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v8 23/24] PCI/portdrv: Declare support of movable BARs
Date:   Mon, 27 Apr 2020 21:23:57 +0300
Message-ID: <20200427182358.2067702-24-s.miroshnichenko@yadro.com>
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

Currently there are no reliable way to determine if a driver uses BARs of
its devices (their struct resource don't always have a child), so if it
doesn't explicitly support movable BARs, they are considered fixed.

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

