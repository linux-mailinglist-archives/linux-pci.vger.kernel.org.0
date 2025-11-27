Return-Path: <linux-pci+bounces-42195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92050C8E083
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 12:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32A6E4ED1F4
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 11:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D2532ED3E;
	Thu, 27 Nov 2025 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SX8Av6S4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F42E266C;
	Thu, 27 Nov 2025 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242484; cv=none; b=GDbXaDC3AN8ozS5g8EgPSBEiw8Q4hU0wGnN7et0L/2ImiqRrj2G7x5MakIEEirP0Bd37VuGptz9LSLTQnBEI5jpoMvzjFhSFR/3hYtNluy0A811Vo0EqGn3wVm8v/tEO8GDZh0NaQ60GDeXHIv6i8GYSO7uJlvQ6k3Ow8/DxUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242484; c=relaxed/simple;
	bh=tZ2G2x6ReqCnieJYI+sxWwMEk1z9dqDH8luBHJKF3FE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AbMKt6FnWw/ZnRr5g3jIHRuKKJTHdSkVS6q460gnKxSFRltaWbgeFY/+2r+Y55Mr1YnpVrWp/5ZIl8D47owfMB2W2eItHn5n71B3Yws1IGya6YQeLomIwrXIgE5DRTe/YgN3Xs0JJAjqguvFZVyCrYL2l3OhPSvsz3wQ7r89JBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SX8Av6S4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764242482; x=1795778482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tZ2G2x6ReqCnieJYI+sxWwMEk1z9dqDH8luBHJKF3FE=;
  b=SX8Av6S4UeTiOnbM9loTZ8F8xLYK86aFFZnz83Qv4rqYXl8k7/KhNh11
   VzgIMgZ7rW+yjyo+3MCEXyZ0ZrZ80UNzqcZOEaka94UkNviSrJx93F7XO
   ODXZfJNNQva609uYnmC1MdML//rh9ek/gtxLmvSW0Axa0DDHXUR/YgQA1
   GyymFge/aa7gy3bZq9a+kefkYMaAySmUv2YD67w/KcuXGes+vM+TAJflx
   YKZZqJHHt79lCBQP/IWOwzR9onrHCRi9vsIAWHf8FoEPvmd5KROwtVJZ8
   nypmyYnCA87cb9NJWcQfdl1djd0nxzshTDIMeg81pOmYQu0crIfhzMFXV
   g==;
X-CSE-ConnectionGUID: MdSdiw4JQySbeMXJ2PfCnw==
X-CSE-MsgGUID: UGzT0zNaQEKJewpu5si0Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66326240"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="66326240"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 03:21:21 -0800
X-CSE-ConnectionGUID: 3ZO8Io14RPeCn+myBVmH1w==
X-CSE-MsgGUID: ZAtJtYDTQ5m1ZvoGed7QrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="223910054"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 03:21:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Use res_to_dev_res() in reassign_resources_sorted()
Date: Thu, 27 Nov 2025 13:21:05 +0200
Message-Id: <20251127112106.5649-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

reassign_resources_sorted() contains a search loop for a particular
resource in the head list. res_to_dev_res() already implements the same
search so use it instead.

Drop unused found_match and dev_res variables.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1d9fc078c7ad..f6a37148ca66 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -413,7 +413,6 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 				      struct list_head *head)
 {
 	struct pci_dev_resource *add_res, *tmp;
-	struct pci_dev_resource *dev_res;
 	struct pci_dev *dev;
 	struct resource *res;
 	const char *res_name;
@@ -421,8 +420,6 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 	int idx;
 
 	list_for_each_entry_safe(add_res, tmp, realloc_head, list) {
-		bool found_match = false;
-
 		res = add_res->res;
 		dev = add_res->dev;
 		idx = pci_resource_num(dev, res);
@@ -436,13 +433,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 			goto out;
 
 		/* Skip this resource if not found in head list */
-		list_for_each_entry(dev_res, head, list) {
-			if (dev_res->res == res) {
-				found_match = true;
-				break;
-			}
-		}
-		if (!found_match) /* Just skip */
+		if (!res_to_dev_res(head, res))
 			continue;
 
 		res_name = pci_resource_name(dev, idx);

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.39.5


