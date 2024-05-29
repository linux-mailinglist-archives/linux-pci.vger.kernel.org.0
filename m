Return-Path: <linux-pci+bounces-8048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B25398D3D08
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 18:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95AE1C21003
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FF3181D06;
	Wed, 29 May 2024 16:43:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3D8181BA7;
	Wed, 29 May 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000991; cv=none; b=WLIPigFmBoycTRocMn6ir0tFH8NSHitdwkvq3pNCC+76lJ+ab0KikPUQVGNHJR3YNxFBHXv4EkATA0FCwsi2UCNKYQifu3NQMaJlOdw0aritR75uGJlt55frLYBpT9b8WSJ9l0WULVlldNW55xnlNB3orydZNCnqMJPcwsq+JDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000991; c=relaxed/simple;
	bh=Pg7dtSeZRbGiEEo/2LMdLmfJSSsQRJspheIXnTlwNLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6eXQPEXJdBOfLpZljVtf7XJxAQtM5lhPzD4YFVinjEw6a7Uc+pBlssQnG5rJ+yiPmChyXm0GD727YmPnBPU4gPAdS6o7UeFX0uGMFXOYNPC0hl98dhOllyqov/IWdiKIKnWzYCdzuFk758ncNiKiBDQdaeBgAk2IdgYOzjDPUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqFSr5GLnz6K5Xn;
	Thu, 30 May 2024 00:38:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E762B1400CA;
	Thu, 30 May 2024 00:43:06 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 17:43:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Will Deacon <will@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<linuxarm@huawei.com>, <terry.bowman@amd.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH 4/9] auxiliary_bus: expose auxiliary_bus_type
Date: Wed, 29 May 2024 17:40:58 +0100
Message-ID: <20240529164103.31671-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529164103.31671-1-Jonathan.Cameron@huawei.com>
References: <20240529164103.31671-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

In the PCI portdrv shutdown we need to find and remove any
auxiliary devices before pci_free_irq_vectors() is called.
Allowing the bus type to be accessed means we can just use
the device types on the auxbus to do this without having to
keep yet another list of what is registered.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/base/auxiliary.c      | 2 +-
 include/linux/auxiliary_bus.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index d3a2c40c2f12..5bde62918dad 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -244,7 +244,7 @@ static void auxiliary_bus_shutdown(struct device *dev)
 		auxdrv->shutdown(auxdev);
 }
 
-static const struct bus_type auxiliary_bus_type = {
+const struct bus_type auxiliary_bus_type = {
 	.name = "auxiliary",
 	.probe = auxiliary_bus_probe,
 	.remove = auxiliary_bus_remove,
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index de21d9d24a95..465b5ac2862e 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -248,4 +248,5 @@ struct auxiliary_device *auxiliary_find_device(struct device *start,
 					       const void *data,
 					       int (*match)(struct device *dev, const void *data));
 
+extern const struct bus_type auxiliary_bus_type;
 #endif /* _AUXILIARY_BUS_H_ */
-- 
2.39.2


