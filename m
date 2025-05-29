Return-Path: <linux-pci+bounces-28519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8927AC75AC
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 04:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9810A4E55DA
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 02:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F63242D6E;
	Thu, 29 May 2025 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aBdLgbhj"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4362020E00A;
	Thu, 29 May 2025 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748484674; cv=none; b=CaojPRYK6LWUnMZPrCWcb45X9yUSBcbGBhMB3o7lKDr0GK7VJj/LnmC2OfUYRdI2H8zTag1TzQR+XLszmXm4DgX4Y/i0XEHm38nWY25KW3velXInoUCy//JHhkCTHxA2oVrb1kJgmX6tFG9AEgoSo21PYadrAt4R127E/zouia0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748484674; c=relaxed/simple;
	bh=B3zeO8g4fFN8F19L04LcwNQHZiE3uxCJY/TJ/CN6c8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p2QG6FPqM6jHdklA6jehKQaWLIT6CUz5RO75ae3EUFh3SlidQ1V9sOsV5cuhhElr6dQ6l+SZUucwX65hTIUqin5aFxSD2d/Z+iLv/PMO5GfyWt9G0u76TYsGFVCOgQJH4ofyfcouJhkt9YmJVl1DPEBWEow9UMA/TfBQyPF3Se8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aBdLgbhj; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6F
	GpfdKChf67+YNJyhUDIvvblsh59zW18p9yEzKXv14=; b=aBdLgbhjcuEXQBu/dc
	D9/YCmVfW+xrEGT3r+JOru7/yoHfE939AIbPcOdDx42N+rtExbM4Cy1YenyIJo3z
	VOh0IDZaxL58RfejY1XABwZdAsjzR0pHBizlj6gu/0xhfsQg8qcE05yjX8zLBp9+
	kMFz6wUvxPvqMNscNgPRyn+0A=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC3we4Uwjdot_dqEg--.40331S3;
	Thu, 29 May 2025 10:10:34 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	krzk+dt@kernel.org,
	manivannan.sadhasivam@linaro.org,
	conor+dt@kernel.org
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 1/3] dt-bindings: PCI: Extend max-link-speed to support PCIe Gen5/Gen6
Date: Thu, 29 May 2025 10:10:24 +0800
Message-Id: <20250529021026.475861-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529021026.475861-1-18255117159@163.com>
References: <20250529021026.475861-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3we4Uwjdot_dqEg--.40331S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWUZF48XF18tw1rJw45Awb_yoWDZrgE9F
	y8Jws2q3yIvFZ8Kw4rJFWrGFya9a1jgrsrJrykXF1jya45ZFWkuFyvyay5Jrs8W3y7ZF43
	Ar9IyFy0kr17CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZL05UUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwtco2g3vlq+SQAAs3

Update the device tree binding documentation for PCI to include
PCIe Gen5 and Gen6 support in the `max-link-speed` property.
The original documentation limited the value to 1~4 (Gen1~Gen4),
but the kernel now supports up to Gen6. This change ensures the
documentation aligns with the actual code implementation.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 dtschema/schemas/pci/pci-bus-common.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
index ca97a00..413ef05 100644
--- a/dtschema/schemas/pci/pci-bus-common.yaml
+++ b/dtschema/schemas/pci/pci-bus-common.yaml
@@ -121,7 +121,7 @@ properties:
       unnecessary operation for unsupported link speed, for instance, trying to
       do training for unsupported link speed, etc.
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [ 1, 2, 3, 4 ]
+    enum: [ 1, 2, 3, 4, 5, 6 ]
 
   num-lanes:
     description: The number of PCIe lanes
-- 
2.25.1


