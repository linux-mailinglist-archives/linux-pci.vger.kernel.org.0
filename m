Return-Path: <linux-pci+bounces-27434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9DDAAF635
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 11:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBA44C7FB9
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8361F2557C;
	Thu,  8 May 2025 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzWPUT+/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F85239E95;
	Thu,  8 May 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694848; cv=none; b=Oi6BTNs9buxaBGyi+me/cd4Xt6j7C6GJ5HFkZ/L/MaDUkV3sgqFzqdL154Nd7MnlrXWIpfl5ENqTbDAwmHzLCPCtWmcSDxOclapvhf7dIV16KwTWCU/8shrY0AUhJZheVtEUiFB0BNICav//PncMy4CPZet+McTUFMKXIy44FYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694848; c=relaxed/simple;
	bh=lEDijyfpdRoWD6IXmI7dcnIiixR/KwmyqteLdtZJMmg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=izPOAUUm9BXk7cNIcyTnFw1ROzrzQfc7Jdpy4GGI8uo2jD8ozcxg8/BYjk9W3mWTIfCFITD2CTveQ/V8mV4WHJ5ZbDyJYdfbxoEVUpaMUR2U1XBRbgfsh6qSrv2oNEqgCJuhaeMcK5oWGiLL0y+SrodfHAXH8sGJqQKyPnwgJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzWPUT+/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746694847; x=1778230847;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lEDijyfpdRoWD6IXmI7dcnIiixR/KwmyqteLdtZJMmg=;
  b=TzWPUT+/NaE2pmt6NYi1eVEq4F2vMH3fNP+MaQYUsPYqFw1UVUVpvWeV
   b9zuwzAa3pD+py2Y3UjJDGT2q6OirV5/YOy4eycvPw93nj1Wc3GkkteNe
   4EoWD5k/gkWBOcMNVtY/BXKpGiElWn9i64gsM2xB/Cg0CFk3CYa5CbHhR
   u33ENBBOLDVaHWOZQLgL4RaJHXxyMRHUUYi8XANv4VnFd9Bp+3qefwdgA
   re4lGWlJzVA469mOx5VAH5QqxPYlju1hv2Cl2aUkOuektWmDWdxv5arbR
   9kJ5vCpqCnJQ51fOzD4UJOWd6uIVEPTN8XN72Q8w55kbqvE9ZJiGuqyMj
   g==;
X-CSE-ConnectionGUID: oFkv6Q1zS0+I3Pq9LmXIgQ==
X-CSE-MsgGUID: 2eYfjbZXSRCJTs8sh5/JOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52118542"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="52118542"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 02:00:47 -0700
X-CSE-ConnectionGUID: HH1a30xbQEe3a7iHL6TnDA==
X-CSE-MsgGUID: Dnh+Yw5LQO2XRvJRXq7amw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="136243871"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 02:00:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] PCI/bwctrl: Remove also pcie_bwctrl_lbms_rwsem
Date: Thu,  8 May 2025 12:00:36 +0300
Message-Id: <20250508090036.1528-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit 0238f352a63a ("PCI/bwctrl: Replace lbms_count with
PCI_LINK_LBMS_SEEN flag") remove all code related to
pcie_bwctrl_lbms_rwsem but forgot to remove the rwsem itself.
Remove it and the associated info from the comment now.

Fixes: 0238f352a63a ("PCI/bwctrl: Replace lbms_count with PCI_LINK_LBMS_SEEN flag")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Bjorn, this should be folded into the original commit I think.

 drivers/pci/pcie/bwctrl.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index fdafa20e4587..f31fbbd51490 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -45,15 +45,7 @@ struct pcie_bwctrl_data {
 	struct thermal_cooling_device *cdev;
 };
 
-/*
- * Prevent port removal during LBMS count accessors and Link Speed changes.
- *
- * These have to be differentiated because pcie_bwctrl_change_speed() calls
- * pcie_retrain_link() which uses LBMS count reset accessor on success
- * (using just one rwsem triggers "possible recursive locking detected"
- * warning).
- */
-static DECLARE_RWSEM(pcie_bwctrl_lbms_rwsem);
+/* Prevent port removal during Link Speed changes. */
 static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
 
 static bool pcie_valid_speed(enum pci_bus_speed speed)

base-commit: 0238f352a63a075ac1f35ea565b5bec3057ec8bd
-- 
2.39.5


