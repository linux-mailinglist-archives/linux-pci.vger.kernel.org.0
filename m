Return-Path: <linux-pci+bounces-20868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A862A2BF6F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78B63AB83C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C821DE4DC;
	Fri,  7 Feb 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aLj7T9oz"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B141DDA2F;
	Fri,  7 Feb 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920911; cv=none; b=muLCRA74oJHBgx20aUwrXJBaHh1CLWA4Prutq67puXEaxa7kXmCWkIV6tyjeV2gP8e56a9VufpPTIQsZzMvwksjA/6x208Gox+1p6sZAv/UJNCd7nOPEc14LEvojo110/EJXWC1ebmQvE4PVk3s86NoLlg6D/MdeMI2zmWfThM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920911; c=relaxed/simple;
	bh=WVsBqCj6CZeiwYjGa7M1KTy+8EypTV0WDOnfEmqknag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9dsxsEal/eYXEbts4Q6THQ512bTPNIzApN26aiaJq6uK1XAeK7ru1g0rLeEW5tCbzIokj70dIqnwr8DWvfIP9VChFM2Smurm2iKqSYHttEf+pdZKE4t33+wwOw4c2zXvyxCYagAzkPDiUoJqlgid5v7y/4peINTxwHANZmh9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aLj7T9oz; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738920904; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lYqzDEofKcdbh54CmYKGDS4DQjLRikMCY9L55YlF/XA=;
	b=aLj7T9ozTzAXigIPFBYFPRtHLkXy1OZplDvU09Pb7s17beQpdq2S23MJXT4JumyahrdFFTppxx2Nw39mCvBnh5Il4UeGt4lQeqQfhwhgV11ZqjELHJSxoLkPF23+S+pnDEH8zAJaTNEoyJ5h3OqjmlXTVFcERNzExlGB2d4UBQ4=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WOyzNDL_1738920902 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Feb 2025 17:35:03 +0800
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
	terry.bowman@amd.com
Subject: [PATCH v3 1/4] PCI/DPC: Rename pdev to err_port for dpc_handler
Date: Fri,  7 Feb 2025 17:34:57 +0800
Message-ID: <20250207093500.70885-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250207093500.70885-1-xueshuai@linux.alibaba.com>
References: <20250207093500.70885-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The irq handler is registered for error port which recevie DPC
interrupt. Rename pdev to err_port.

No functional changes.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/pcie/dpc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 242cabd5eeeb..1a54a0b657ae 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -346,21 +346,21 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
 
 static irqreturn_t dpc_handler(int irq, void *context)
 {
-	struct pci_dev *pdev = context;
+	struct pci_dev *err_port = context;
 
 	/*
 	 * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
 	 * of async removal and should be ignored by software.
 	 */
-	if (dpc_is_surprise_removal(pdev)) {
-		dpc_handle_surprise_removal(pdev);
+	if (dpc_is_surprise_removal(err_port)) {
+		dpc_handle_surprise_removal(err_port);
 		return IRQ_HANDLED;
 	}
 
-	dpc_process_error(pdev);
+	dpc_process_error(err_port);
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
-	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
+	pcie_do_recovery(err_port, pci_channel_io_frozen, dpc_reset_link);
 
 	return IRQ_HANDLED;
 }
-- 
2.39.3


