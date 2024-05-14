Return-Path: <linux-pci+bounces-7450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D6D8C531C
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 13:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFB31F22D16
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00AC13AD06;
	Tue, 14 May 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mm7hOBmN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F913A3F4;
	Tue, 14 May 2024 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686310; cv=none; b=KO68XeWzM4o2TS6NNdaq2jP0KFMix2AEjl4TKsgP2QyzoNPM2d8QlZOZYuTxzfGYQzdjVs9KhYdNeaaan+ve7MNWtjVN1r+tziSKXmSw5oR0rqA62iTR6jZa866Trry/Ae2NAK3QwUyaLXhDm7MhQFSTZ1ngoQbgzaIzqfMLuBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686310; c=relaxed/simple;
	bh=vrR9lSZtbojiA2EubTfEXC7NUqhoH2bBkEIK7kkkTFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTd4g6o5xiQvNbGik6uV8a3ZwGvD9RIh6L18+Jn28QLvyuV7fA16/VE1Pdup/4bl/bqSpb9MKLJF3XCPPGClY4k6Q/AayhJPEoCcHLZdvtuZv27bk4uSzLXblXFA8G7Td3qhe/sQHPIsWmOSKNI7nc40TO+aPtO1uhtLmHDPZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mm7hOBmN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715686309; x=1747222309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vrR9lSZtbojiA2EubTfEXC7NUqhoH2bBkEIK7kkkTFA=;
  b=mm7hOBmNMUAGZnL02CKUKubZHxyGIk1NzAHwUfGUjQGWdclbj2RJ+7bM
   A1AVk6YYBpNJEjvaiFIBQE5jj7JPFxSKqvFOHlW76Yl+zZU5u7rwhTaFs
   X12/GCyj9QVElNvX7fav0L2/XtfPK18zSrtSB/QEnzf9e6ZGtQaibG/1L
   +NvOMfsyp6r6crtHxT6aKDnko2c7ABX8cfW2hnGcSM8V3cFZ8c8FcoALK
   sRb9HtvyiXByCPGBb5urSS14sYm65XQ0W+nbkMDFPJIWUdBoEPwBu8S23
   NKXab9ohuVh7wLraTcOj1uewCx9GVhtJgENhydvviMOE37lQe2ao+B9dh
   w==;
X-CSE-ConnectionGUID: ubtNonguQxC4F31d4Qoe9w==
X-CSE-MsgGUID: 3QNQqwuPT+aLCs6NPdDCmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11828362"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11828362"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 04:31:48 -0700
X-CSE-ConnectionGUID: KG7Hzpw5QAiIDG1AMRMHXQ==
X-CSE-MsgGUID: tq9/EgpNSqGv1BQd50GHDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35546228"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.94])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 04:31:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 4/7] PCI: Use unsigned int i in pcie_read_tlp_log()
Date: Tue, 14 May 2024 14:31:06 +0300
Message-Id: <20240514113109.6690-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240514113109.6690-1-ilpo.jarvinen@linux.intel.com>
References: <20240514113109.6690-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Loop variable i counting from 0 upwards does not need to be signed so
make it unsigned int.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/tlp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
index 2bf15749cd31..65ac7b5d8a87 100644
--- a/drivers/pci/pcie/tlp.c
+++ b/drivers/pci/pcie/tlp.c
@@ -24,7 +24,8 @@
 int pcie_read_tlp_log(struct pci_dev *dev, int where,
 		      struct pcie_tlp_log *log)
 {
-	int i, ret;
+	unsigned int i;
+	int ret;
 
 	memset(log, 0, sizeof(*log));
 
-- 
2.39.2


