Return-Path: <linux-pci+bounces-21109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4645CA2F895
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 20:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 560777A2679
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 19:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B365259498;
	Mon, 10 Feb 2025 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWXqfJ52"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAE0257447;
	Mon, 10 Feb 2025 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215451; cv=none; b=dzrwi0g5/EZheVdIuOwb0+nwqVBHubamdZaC5+L63SGsTqqBea2b4SL0IKpUK1Stgml+FMy/sWEFd6ZNJhS7mSiksryEjb9k8gzYKxfPFnVjVQfaNNPMpXpGJI7XIeDKbMUAmJl2MCgCx8dwPCjrIae6ceL/f6bL8oCyRLFQu6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215451; c=relaxed/simple;
	bh=cj0NxklMDpQLejnIH1WTb5QzUrFHN/+zrlInglvaL7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IP1p0I10S5KjreHNsRbAbpufpG8I/6sYqlxWoHql7/0mpT2OG9PuL4hj3ehWwcW2AVZ72EvPpES9PCagqRi1vFtsEwUJv2IAuKRsWO7LWoyibe/k4IeZ60z0L78dKj65hTUqcTUTpxbf2bxNs+ZuONYdwhamK1YyzjhdO3DG9tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWXqfJ52; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739215449; x=1770751449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cj0NxklMDpQLejnIH1WTb5QzUrFHN/+zrlInglvaL7o=;
  b=fWXqfJ52YP7N5BhiEgoWDx7mysRiIHxbk/CbPaIR2K8qPJXCFzs+fjuU
   MUbQSQTdEkxGQNWnBWcXxPY7dZnAHFrefZrA8c+xVPpc1R1TZ0JtR/i1k
   wF3E6Q/IcavmDum0BoQlXW/2NlTWN/vfpeA8iMjnm01d3wQmxA6SrGnNX
   2GS1jsZ4JQDR/7qMjN4OFZx1klk3d3pVgy3nlGbBltpsLY13Z/3Odi3pT
   KnCicV+XYMpDRY9wsTNNHmiSyTAolqSMeN0SCkc6Znu3fv+jTW7rnBdgl
   JWv9STtElXRe7lp6IqN7YDC81Ke/ulCzmsRcWOKu8Q+zTmsxwKpBTViH9
   A==;
X-CSE-ConnectionGUID: s1J0MzjCQ/KuTr4IOkkGdA==
X-CSE-MsgGUID: gqUxIsNZTmOSTjjfDMOOBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39929272"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39929272"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 11:24:02 -0800
X-CSE-ConnectionGUID: pb56rcPzQga0E2NUYXNUOg==
X-CSE-MsgGUID: FFY66tXgQZODJGnN7mwcKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112733895"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 10 Feb 2025 11:24:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Gerhard Engleder <eg@keba.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	gerhard@engleder-embedded.com,
	rostedt@goodmis.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	pmenzel@molgen.mpg.de,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	Avigail Dahan <avigailx.dahan@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 10/10] e1000e: Fix real-time violations on link up
Date: Mon, 10 Feb 2025 11:23:48 -0800
Message-ID: <20250210192352.3799673-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210192352.3799673-1-anthony.l.nguyen@intel.com>
References: <20250210192352.3799673-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gerhard Engleder <eg@keba.com>

Link down and up triggers update of MTA table. This update executes many
PCIe writes and a final flush. Thus, PCIe will be blocked until all
writes are flushed. As a result, DMA transfers of other targets suffer
from delay in the range of 50us. This results in timing violations on
real-time systems during link down and up of e1000e in combination with
an Intel i3-2310E Sandy Bridge CPU.

The i3-2310E is quite old. Launched 2011 by Intel but still in use as
robot controller. The exact root cause of the problem is unclear and
this situation won't change as Intel support for this CPU has ended
years ago. Our experience is that the number of posted PCIe writes needs
to be limited at least for real-time systems. With posted PCIe writes a
much higher throughput can be generated than with PCIe reads which
cannot be posted. Thus, the load on the interconnect is much higher.
Additionally, a PCIe read waits until all posted PCIe writes are done.
Therefore, the PCIe read can block the CPU for much more than 10us if a
lot of PCIe writes were posted before. Both issues are the reason why we
are limiting the number of posted PCIe writes in row in general for our
real-time systems, not only for this driver.

A flush after a low enough number of posted PCIe writes eliminates the
delay but also increases the time needed for MTA table update. The
following measurements were done on i3-2310E with e1000e for 128 MTA
table entries:

Single flush after all writes: 106us
Flush after every write:       429us
Flush after every 2nd write:   266us
Flush after every 4th write:   180us
Flush after every 8th write:   141us
Flush after every 16th write:  121us

A flush after every 8th write delays the link up by 35us and the
negative impact to DMA transfers of other targets is still tolerable.

Execute a flush after every 8th write. This prevents overloading the
interconnect with posted writes.

Signed-off-by: Gerhard Engleder <eg@keba.com>
Link: https://lore.kernel.org/netdev/f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch/T/
CC: Vitaly Lifshits <vitaly.lifshits@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/mac.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index d7df2a0ed629..44249dd91bd6 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -331,8 +331,21 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
 	}
 
 	/* replace the entire MTA table */
-	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
+	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
 		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
+
+		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			/*
+			 * Do not queue up too many posted writes to prevent
+			 * increased latency for other devices on the
+			 * interconnect. Flush after each 8th posted write,
+			 * to keep additional execution time low while still
+			 * preventing increased latency.
+			 */
+			if (!(i % 8) && i)
+				e1e_flush();
+		}
+	}
 	e1e_flush();
 }
 
-- 
2.47.1


