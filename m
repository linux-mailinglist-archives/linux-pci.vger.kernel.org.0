Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F414D2DE87F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgLRRnQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:43:16 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:38596 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727967AbgLRRnQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:43:16 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 7409C413D5;
        Fri, 18 Dec 2020 17:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313292; x=1610127693; bh=cLgLn4rXA1xiaAB3ENuZEne5ERVt5u32Jus
        mMyXwWHM=; b=fWEezA475dRWxuKNqbIf1tW5G5lCL3v3YDTS0Qhv27i6xC9Me21
        K/0cwxljMltO4inYY1SvxrENm+7iNii2kmawyz3zqOWMoAcNITOQ72okdt6rd1Ut
        k4jLEgONfLP/KoUk2SX4CGzXGdBf0xIDssIiJZ+08F8Gp/pip7u5gt/g=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7Rbb2F7mdMFZ; Fri, 18 Dec 2020 20:41:32 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id EB213413E0;
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
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v9 24/26] nvme-pci: Handle movable BARs
Date:   Fri, 18 Dec 2020 20:40:09 +0300
Message-ID: <20201218174011.340514-25-s.miroshnichenko@yadro.com>
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

Hot-added devices can affect the existing ones by moving their BARs. The
PCI subsystem will inform the NVME driver about this by invoking the
.rescan_prepare() and .rescan_done() hooks, so the BARs can by re-mapped.

Tested under the "randrw" mode of the fio tool, and when using an NVME
drive as a root filesystem storage. Before the hot-adding:

  % sudo cat /proc/iomem
  ...
                3fe800000000-3fe8007fffff : PCI Bus 0020:0b
                  3fe800000000-3fe8007fffff : PCI Bus 0020:18
                    3fe800000000-3fe8000fffff : 0020:18:00.0
                      3fe800000000-3fe8000fffff : nvme
                      ^^^^^^^^^^^^^^^^^^^^^^^^^
                    3fe800100000-3fe80017ffff : 0020:18:00.0
  ...

Then another NVME drive was hot-added, so BARs of the 0020:18:00.0 are
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
                      ^^^^^^^^^^^^^^^^^^^^^^^^^
                    3fe800900000-3fe80097ffff : 0020:18:00.0
    ...

During the rescanning, both READ and WRITE speeds drop to zero for a while
due to driver's pause, then restore.

Cc: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/nvme/host/pci.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b4385cb0ff60..7993062b11b6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1656,7 +1656,7 @@ static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	if (size <= dev->bar_mapped_size)
+	if (dev->bar && size <= dev->bar_mapped_size)
 		return 0;
 	if (size > pci_resource_len(pdev, 0))
 		return -ENOMEM;
@@ -3152,6 +3152,28 @@ static void nvme_error_resume(struct pci_dev *pdev)
 	flush_work(&dev->ctrl.reset_work);
 }
 
+static bool nvme_bar_fixed(struct pci_dev *pdev, int resno)
+{
+	return false;
+}
+
+static void nvme_rescan_prepare(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	nvme_dev_disable(dev, true);
+	nvme_dev_unmap(dev);
+	dev->bar = NULL;
+}
+
+static void nvme_rescan_done(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	nvme_dev_map(dev);
+	nvme_reset_ctrl(&dev->ctrl);
+}
+
 static const struct pci_error_handlers nvme_err_handler = {
 	.error_detected	= nvme_error_detected,
 	.slot_reset	= nvme_slot_reset,
@@ -3238,6 +3260,9 @@ static struct pci_driver nvme_driver = {
 #endif
 	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
+	.rescan_prepare	= nvme_rescan_prepare,
+	.rescan_done	= nvme_rescan_done,
+	.bar_fixed	= nvme_bar_fixed,
 };
 
 static int __init nvme_init(void)
-- 
2.24.1

