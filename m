Return-Path: <linux-pci+bounces-38107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8C7BDC2E2
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 04:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0F644F8E94
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 02:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97B30C36C;
	Wed, 15 Oct 2025 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M0Sl/X9z"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB7B30DEBF;
	Wed, 15 Oct 2025 02:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496136; cv=none; b=efiXScKvmaqAL/v0lFRFta76BBJSrFtIET/ycYW2KsaxMUSWCadD6ZltnWzzIPw2Y84v3WB8S9uBWf5a9bupQUK8WQ2vnmlhwYgxE404C4d2tAxJj2dCIQxmHBCz6dLIcRYsOJS3UZRPm5pV1e8zgvnXylVfeJtqR593xwPx4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496136; c=relaxed/simple;
	bh=u7eiwwl0Lu8N4+alST3rfrqz5EwABFU6V4ZOUYw0JqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGY5qEi1xJJcaG+94eM0r6UXo1NAXjd+APosbrDIP91vUoM9Yw3V/LGFuDGLIaYZEDEoXIFAQGU/Y0ujK8WtYvvJEePuiinKwtAKoJbwcCmH0LWgRGyqqf8/SxfuGSn6XWjyKPrheydOsddcJDNhsOwASEi0CriWLWKpoSLVUec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M0Sl/X9z; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760496126; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2YpK1F7xJrl75rOzzaOJkPak7Buh/ePLPsLeAsL/GDA=;
	b=M0Sl/X9zJ0r3Osv/8FSPQJ6CXjrou6Q6i/hNEkDeuZwXKccjvrF2WBUZFljJQ9IxL3n+B1m9RLL8gJt3ZhOqBg7TzipE3wBlUwvsSaXqRVtRUjk8X4qqsUKBazypSREdHEciSddGSebUigp3VI70rQB+yZTjSkv31wMaxfyW4Xk=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqEYD84_1760496125 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Oct 2025 10:42:05 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bhelgaas@google.com,
	kbusch@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: mahesh@linux.ibm.com,
	oohall@gmail.com,
	xueshuai@linux.alibaba.com,
	Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com,
	tianruidong@linux.alibaba.com,
	lukas@wunner.de
Subject: [PATCH v6 5/5] PCI/AER: Clear both AER fatal and non-fatal status
Date: Wed, 15 Oct 2025 10:41:59 +0800
Message-Id: <20251015024159.56414-6-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DPC driver clears AER fatal status for the port that reported the
error, but not for the downstream device that deteced the error.  The
current recovery code only clears non-fatal AER status, leaving fatal
status bits set in the error device.

Use pci_aer_raw_clear_status() to clear both fatal and non-fatal error
status in the error device, ensuring all AER status bits are properly
cleared after recovery.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/pcie/err.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 097990094b71..28c5ca7d86ce 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -290,7 +290,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 */
 	if (pcie_aer_is_native(dev)) {
 		pcie_clear_device_status(dev);
-		pci_aer_clear_nonfatal_status(dev);
+		pci_aer_raw_clear_status(dev);
 	}
 
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
-- 
2.39.3


