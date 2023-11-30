Return-Path: <linux-pci+bounces-263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC9A7FE67E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 03:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40B71C209B4
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 02:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6839A3C0C;
	Thu, 30 Nov 2023 02:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB2D1B3
	for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 18:09:50 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SgflW5fCVz4f3kKF
	for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 10:09:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AA35B1A0393
	for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 10:09:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
	by APP1 (Coremail) with SMTP id cCh0CgDX2hDl7mdlWxFECQ--.12383S4;
	Thu, 30 Nov 2023 10:09:46 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	yangyingliang@huawei.com
Subject: [PATCH] NTB: fix possible name leak in ntb_register_device()
Date: Thu, 30 Nov 2023 10:13:50 +0800
Message-Id: <20231130021350.2733064-1-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX2hDl7mdlWxFECQ--.12383S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyxWw4DKFy3JFyxtw47Arb_yoW8Zw13p3
	sxGasayrW0qr47ur45Xa1kZFy5Kay2v3y8CrWrCw1a9anxWrWFyFW8ta4rtF47JrW8ZFyU
	tFW2qa18uFWUZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

If device_register() returns error in ntb_register_device(),
the name allocated by dev_set_name() need be freed. As comment
of device_register() says, it should use put_device() to give
up the reference in the error path. So fix this by calling
put_device(), then the name can be freed in kobject_cleanup().

Fixes: a1bd3baeb2f1 ("NTB: Add NTB hardware abstraction layer")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/ntb/core.c                            | 8 +++++++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 6 +-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/core.c b/drivers/ntb/core.c
index 27dd93deff6e..d702bee78082 100644
--- a/drivers/ntb/core.c
+++ b/drivers/ntb/core.c
@@ -100,6 +100,8 @@ EXPORT_SYMBOL(ntb_unregister_client);
 
 int ntb_register_device(struct ntb_dev *ntb)
 {
+	int ret;
+
 	if (!ntb)
 		return -EINVAL;
 	if (!ntb->pdev)
@@ -120,7 +122,11 @@ int ntb_register_device(struct ntb_dev *ntb)
 	ntb->ctx_ops = NULL;
 	spin_lock_init(&ntb->ctx_lock);
 
-	return device_register(&ntb->dev);
+	ret = device_register(&ntb->dev);
+	if (ret)
+		put_device(&ntb->dev);
+
+	return ret;
 }
 EXPORT_SYMBOL(ntb_register_device);
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 3f60128560ed..8e4ed188ad5c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1278,15 +1278,11 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ret = ntb_register_device(&ndev->ntb);
 	if (ret) {
 		dev_err(dev, "Failed to register NTB device\n");
-		goto err_register_dev;
+		return -EINVAL;
 	}
 
 	dev_dbg(dev, "PCI Virtual NTB driver loaded\n");
 	return 0;
-
-err_register_dev:
-	put_device(&ndev->ntb.dev);
-	return -EINVAL;
 }
 
 static struct pci_device_id pci_vntb_table[] = {
-- 
2.25.1


