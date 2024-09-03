Return-Path: <linux-pci+bounces-12661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED06969F13
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 15:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3B5286793
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 13:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBA915C3;
	Tue,  3 Sep 2024 13:31:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3E1CA690;
	Tue,  3 Sep 2024 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370304; cv=none; b=lXf/CkjuHyWV0CMVmU0KHK08sr5X49O6lD9ZZXHs4DhMQYSvKB5hA6BJ1R3eXuyH/XjbCd3553eTYOQ7NU2vMIS/Qw752LGgSttlysja+HQ5NybU1ZyW2sqL1LF2voMK+7VEmaMa6JRMR16X7otg7YI+O2VBg0TCTlI11KUxrck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370304; c=relaxed/simple;
	bh=fgHkKrSQB093cpACmm0V158wvczBKs1pxwZPoVHk44Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=blPZu7yvn78SxiN4W7HrPz38wKPKp5oqDdZ2qYRmLes0xyIIHQjrEt6R9BmCBIWGPvWe81t+JzVVY6m4DmEoujbvYwcHJAKrU0nuipWmisP3Mpn9lJ7teaMaz5lWO5Rq3SDsZT2sgBUHR+UZv/PcfLKM63LBT5mnqPgsh0tPaco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WymjJ1WKfzyRSX;
	Tue,  3 Sep 2024 21:31:00 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BC751402CC;
	Tue,  3 Sep 2024 21:31:37 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Sep
 2024 21:31:37 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <thomas.petazzoni@bootlin.com>, <pali@kernel.org>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <liaochen4@huawei.com>
Subject: [PATCH -next] PCI: mvebu: Enable module autoloading
Date: Tue, 3 Sep 2024 13:23:11 +0000
Message-ID: <20240903132311.961646-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/pci/controller/pci-mvebu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 29fe09c99e7d..bf193f8c258d 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1715,6 +1715,7 @@ static const struct of_device_id mvebu_pcie_of_match_table[] = {
 	{ .compatible = "marvell,kirkwood-pcie", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, mvebu_pcie_of_match_table);
 
 static const struct dev_pm_ops mvebu_pcie_pm_ops = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(mvebu_pcie_suspend, mvebu_pcie_resume)
-- 
2.34.1


