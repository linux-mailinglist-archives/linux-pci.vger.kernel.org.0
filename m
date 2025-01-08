Return-Path: <linux-pci+bounces-19505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56264A05483
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 08:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABCC162A59
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 07:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64761AA1FA;
	Wed,  8 Jan 2025 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MQwS3aUR"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627D21AAE13;
	Wed,  8 Jan 2025 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736321212; cv=none; b=cAvDpKW5pikRVJrMjuZ9so5yLGFGdbOTdk5t4+4tXhw4CYOlrsQqwNdNrEC+MqVEh5qZMBhJFVXlh/bsMaTMqiDZW1h+7OFXcZb+wl2WwHONgZcfRKIHcVhTe0CNipJzYeotxRl8aCJCsVLmEKWVouVvbf/NuLNsWWhZrxVbFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736321212; c=relaxed/simple;
	bh=QfwGYfSMyag/NVz+X2u68wZLFBTnVF7yPas9GLokXDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XET5qZMjrPOCTZPam4OfRBeLaT/8mH0kiCF8xgsXTBmW59E/9JoNtTQKRbvrw2tyQ887wdLa6U8fjd9CHu+QHJcW5KYIqq7UUSmfnz10ys0ady+lAXeRkNKtzOmL577Yljlw3ZDrHom5QVCV2//uYYbT5r4Gqg5K8LxHrhNjY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MQwS3aUR; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nwJ3t
	YBg/P1vKzpzW1qKRtqgeeZIOLd21wsc5BggDLU=; b=MQwS3aURYSuF3GggpIpoj
	Iqxn4TPQkSX3Decn6QOhME+RWDMY+hoZFYbwNNgrTgdUUH9e4W+HXVCxB//Xbone
	5rvPYZsI1zY5IQ67cTO14fMAfEJwM0GQGPPLeCNgKdy1FgaFDKMZ7+QBiK+qxcFF
	Mgm9beYbNE1yR0qlGMY7zk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHk3pWKH5nJeDMEQ--.48179S3;
	Wed, 08 Jan 2025 15:25:14 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: manivannan.sadhasivam@linaro.org
Cc: kw@linux.com,
	kishon@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	Hans Zhang <18255117159@163.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [v9 1/2] misc: pci_endpoint_test: Remove the "remainder" code
Date: Wed,  8 Jan 2025 15:25:03 +0800
Message-Id: <20250108072504.1696532-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250108072504.1696532-1-18255117159@163.com>
References: <20250108072504.1696532-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHk3pWKH5nJeDMEQ--.48179S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1UGry7Ww48Ww4fZr1rtFb_yoWDArc_Wa
	4fXwsrurnrAr18KF40y3WxZrZruw45XF1Uur1xtrZxJa47A3yDZry0gr4DXr4xA3ZxAr9I
	kw12kr93tF1xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8oqcUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDx7Oo2d+I+KAQwABsm

A BAR size is always a power of two. buf_size = min(SZ_1M, bar_size);
If the BAR size is <= 1MB, there will be 1 iteration, no remainder. If
the BAR size is > 1MB, there will be more than one iteration, but the
size will always be evenly divisible by 1MB, so no remainder.

Signed-off-by: Hans Zhang <18255117159@163.com>
Suggested-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee..0e68dfa7257a 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -313,12 +313,6 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 						 write_buf, read_buf, buf_size))
 			return false;
 
-	remain = bar_size % buf_size;
-	if (remain)
-		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
-						 write_buf, read_buf, remain))
-			return false;
-
 	return true;
 }
 
-- 
2.25.1


