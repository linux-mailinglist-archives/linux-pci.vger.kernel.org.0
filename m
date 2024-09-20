Return-Path: <linux-pci+bounces-13332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E793997D901
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 19:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9051A1F22956
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 17:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7351EF1D;
	Fri, 20 Sep 2024 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdjRU8tQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF726AF3
	for <linux-pci@vger.kernel.org>; Fri, 20 Sep 2024 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853290; cv=none; b=OZ9WYr8UK4cAaEmRn2ETmq6fWMI9aQzEa/f/QZID3RfieRLY8fzrNdkdNrgkBRUhnyd0AgMBAKRuswgQIf0itsXoPSSc+w2cx8G8vqLXtpnpyDkncU8ox7ZhPCSklkluD/rC3i8NDjgtrOIa54Tyhtqgv719+VbwYHocUjkQ5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853290; c=relaxed/simple;
	bh=6Wwg7wRcmCKnw61litvaGWv26gm86DrWn4uFeen2lF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OtMjsJcHxetZC28cKmJ60rRPdGtQbWRUOxKCJ0TWIL7E5kDYn4h5jdkV+iLVryCraHMaV/0ywn+j+Rtno3c3rOwQRmNr1LyoGGyJCgK6Ju6uQzsRWaE+aJ51sSWJfpi2Dpr9SkT5jmDknSS0ePelpkp8IasJWGCeolD/RNAyLHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdjRU8tQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726853290; x=1758389290;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6Wwg7wRcmCKnw61litvaGWv26gm86DrWn4uFeen2lF4=;
  b=mdjRU8tQSg79+M63BPTlLomY8H7yz0eGypMt1EitU4iUKpV733LzvCLE
   rhk6+w4agKroEI6/EjMqwNX850n451caihOWLkTBiMTVFLJx3CDXb2X9q
   KP3Tl0VWeNhnPHUsxwle08qB76fMk1S8xATPi2bB+sUMw98nFO4vtasJp
   cAGqn6dEJIHd2hWuV2sx/kUUad05A/4fdhMcqZv8pFfuo673TPs3eMknk
   BiMJmEHsj02OB8+MHJB0vFFflkLQn4gBjD/+ZHwxHiPX8GsndpWpxJDfh
   Gi6cPV3JGsloszctPkPCQr2KKnLnj2PnbaNawjdBbqpFtQhLwmmPQD/kY
   w==;
X-CSE-ConnectionGUID: SJbbZsKfQGaDlhJ6st/wxQ==
X-CSE-MsgGUID: FyrP0HSsT2mnaCIsjO8X5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="43338539"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="43338539"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 10:28:09 -0700
X-CSE-ConnectionGUID: v5XLAeP/TxSoqowvQaCw1A==
X-CSE-MsgGUID: 0okM30/PSsu2UvPMQwxnqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="75329654"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.45])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 10:28:08 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: <linux-pci@vger.kernel.org>,
	paul.m.stillwell.jr@intel.com
Cc: Nirmal Patel <nirmal.patel@linux.ntel.com>
Subject: [PATCH] PCI: vmd: Add DID 8086:B06F and 8086:B60B for Intel client SKU's
Date: Fri, 20 Sep 2024 10:27:53 -0700
Message-Id: <20240920172753.234891-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nirmal Patel <nirmal.patel@linux.ntel.com>

Add support for this VMD device which supports the bus restriction mode.
The feature that turns off vector 0 for MSI-X remapping is also enabled.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.ntel.com>
---
 drivers/pci/controller/vmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a726de0af011..4429a3ca1de1 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1111,6 +1111,10 @@ static const struct pci_device_id vmd_ids[] = {
 		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
 		.driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xb60b),
+                .driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xb06f),
+                .driver_data = VMD_FEATS_CLIENT,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.39.1


