Return-Path: <linux-pci+bounces-29309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE36AD33A1
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 12:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142AE1897AAC
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7536A28C85E;
	Tue, 10 Jun 2025 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhHdX2Qv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED5921D59F;
	Tue, 10 Jun 2025 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749551557; cv=none; b=vE9wuNO7Tvso9Wddw8vzo/l0Mn+HzcIfOwXMOHzNwAtofahsv+oULx/hhn2iWArn0X0zztH+sJrkr+f3Z0hnpo3xZHqSIbCmm10sWgdNDnkRuh2fo/peUy7K3H6oDnnkiklvTdciJ/FZDuKC5PXORqKOHDBa/3KpAw/C5yNFhzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749551557; c=relaxed/simple;
	bh=FpBSC2xVTPB5Ko/OrzcBChzht3GRAD298DcZnb89s98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZUWmAkP+Bh3sytHCE9KEUJ7eLSEwyLXddjoethiMxB8ctSGI1M90n2z5vtcpP9aEdSHt0CADYVzIxTnlYorJ2M6zBXXpW/h12lPldWlMWcqbRkUHS2Ot4BGMQA9rjO8VYNIaHw9ItV4Zz6kG9YDcVPwPLcL6SreNV+TCurwzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhHdX2Qv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749551556; x=1781087556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FpBSC2xVTPB5Ko/OrzcBChzht3GRAD298DcZnb89s98=;
  b=IhHdX2Qvg1Alou/fvtli3LcsBYiF2egnEc8G0YVQL/H21bWsaW65O7O7
   IT6Mr/HKAIluC/bE3gs3k01L+EVOgy4gIyQhNLSjX9GP0orRjGSihstgm
   UAywAWtXHi3nky7PkZFHk3XdGU7VK01M2wkDnblYtA4SMpSi0flskmKey
   4AvrzeFvlWTQNW/+JXC1wg8csv/neBUiMZ/NcvLS9EW1G/ktlAMjbDd0H
   3M5EENL2VXHzbXGQmmOTC+5V/rP2bSuSbcV/5bkDOeh0pMuLgh4zDDGgu
   yYdydCw6z0kt9T35+6uyqR8lX8Ib0jTvt2PNDjJcPKBl4yTaX/LOo3YpN
   w==;
X-CSE-ConnectionGUID: dLEBSYOERfe5cH00juuKwA==
X-CSE-MsgGUID: WDTOiF8nRRWSue6V7ww0iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51362683"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="51362683"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:32:35 -0700
X-CSE-ConnectionGUID: i4huHt0qQiam06ejMiMQaA==
X-CSE-MsgGUID: mLbvw7MwRGy97naDlMpxUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="146720033"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:32:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/3] cxgb3: Split complex PCI write statement into logic + write
Date: Tue, 10 Jun 2025 13:32:05 +0300
Message-Id: <20250610103205.6750-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610103205.6750-1-ilpo.jarvinen@linux.intel.com>
References: <20250610103205.6750-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of trying to complex logic within the PCI capability write
statement, split the logic onto separate lines for better readability.
Also, don't pretend just clearing the fields, but set the fields to
what 0 means (128 bytes).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/ethernet/chelsio/cxgb3/t3_hw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
index 171bf6cf1abf..b9327d8c6893 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
@@ -3267,9 +3267,9 @@ static void config_pcie(struct adapter *adap)
 
 	pci_read_config_word(adap->pdev, PCI_DEVICE_ID, &devid);
 	if (devid == 0x37) {
-		pcie_capability_write_word(adap->pdev, PCI_EXP_DEVCTL,
-					   val & ~PCI_EXP_DEVCTL_READRQ &
-					   ~PCI_EXP_DEVCTL_PAYLOAD);
+		val &= ~(PCI_EXP_DEVCTL_PAYLOAD|PCI_EXP_DEVCTL_READRQ);
+		val |= PCI_EXP_DEVCTL_PAYLOAD_128B|PCI_EXP_DEVCTL_READRQ_128B;
+		pcie_capability_write_word(adap->pdev, PCI_EXP_DEVCTL, val);
 		pldsize = 0;
 	}
 
-- 
2.39.5


