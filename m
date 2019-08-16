Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32DCB9062B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 18:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfHPQvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 12:51:25 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:51484 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbfHPQvY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 12:51:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 5298742F04;
        Fri, 16 Aug 2019 16:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1565974281; x=1567788682; bh=Wvr/G5+MCulC+fzeKgzpPc5JueFBdqSVqZ/
        r8VC32lw=; b=DE2kQ8gzLAqhowh2HemKFf/A2xmFpKpjxsAlinl7UjemCfPuIRq
        pG8bHWEdYBcxD+WHnhrEMlIZuqV5/QSVbgQQavMH6PeqXMAOtl5H8U4a1TcpmnDL
        E/NxJ8FcNoCau5OZyie/t71V1c6ipEFwuGeyb5CRXbkI9fznSkbnQihk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PKREUo0eCtq5; Fri, 16 Aug 2019 19:51:21 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8D1FA42EEC;
        Fri, 16 Aug 2019 19:51:13 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 16
 Aug 2019 19:51:13 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 21/23] nvme-pci: Handle movable BARs
Date:   Fri, 16 Aug 2019 19:50:59 +0300
Message-ID: <20190816165101.911-22-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816165101.911-1-s.miroshnichenko@yadro.com>
References: <20190816165101.911-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hotplugged devices can affect the existing ones by moving their BARs. The
PCI subsystem will inform the NVME driver about this by invoking the
.rescan_prepare() and .rescan_done() hooks, so the BARs can by re-mapped.

Tested under the "randrw" mode of the fio tool. Before the hotplugging:

  % sudo cat /proc/iomem
  ...
                3fe800000000-3fe8007fffff : PCI Bus 0020:0b
                  3fe800000000-3fe8007fffff : PCI Bus 0020:18
                    3fe800000000-3fe8000fffff : 0020:18:00.0
                      3fe800000000-3fe8000fffff : nvme
                    3fe800100000-3fe80017ffff : 0020:18:00.0
  ...

, then another NVME drive was hot-added, so BARs of the 0020:18:00.0 are
moved:

  % sudo cat /proc/iomem
    ...
                3fe800000000-3fe800ffffff : PCI Bus 0020:0b
                  3fe800000000-3fe8007fffff : PCI Bus 0020:10
                    3fe800000000-3fe800003fff : 0020:10:00.0
                      3fe800000000-3fe800003fff : nvme
                    3fe800010000-3fe80001ffff : 0020:10:00.0
                  3fe800800000-3fe800ffffff : PCI Bus 0020:18
                    3fe800800000-3fe8008fffff : 0020:18:00.0
                      3fe800800000-3fe8008fffff : nvme
                    3fe800900000-3fe80097ffff : 0020:18:00.0
    ...

During the rescanning, both READ and WRITE speeds drop to zero for a while
due to driver's pause, then restore.

Cc: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/nvme/host/pci.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index db160cee42ad..a805d80082ca 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1645,7 +1645,7 @@ static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	if (size <= dev->bar_mapped_size)
+	if (dev->bar && size <= dev->bar_mapped_size)
 		return 0;
 	if (size > pci_resource_len(pdev, 0))
 		return -ENOMEM;
@@ -2980,6 +2980,23 @@ static void nvme_error_resume(struct pci_dev *pdev)
 	flush_work(&dev->ctrl.reset_work);
 }
 
+static void nvme_rescan_prepare(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	nvme_dev_disable(dev, false);
+	nvme_dev_unmap(dev);
+	dev->bar = NULL;
+}
+
+static void nvme_rescan_done(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	nvme_dev_map(dev);
+	nvme_reset_ctrl_sync(&dev->ctrl);
+}
+
 static const struct pci_error_handlers nvme_err_handler = {
 	.error_detected	= nvme_error_detected,
 	.slot_reset	= nvme_slot_reset,
@@ -3049,6 +3066,8 @@ static struct pci_driver nvme_driver = {
 #endif
 	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
+	.rescan_prepare	= nvme_rescan_prepare,
+	.rescan_done	= nvme_rescan_done,
 };
 
 static int __init nvme_init(void)
-- 
2.21.0

