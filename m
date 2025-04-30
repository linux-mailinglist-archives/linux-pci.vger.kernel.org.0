Return-Path: <linux-pci+bounces-27034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8CEAA4594
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 10:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB8D3A892A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 08:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1D621A425;
	Wed, 30 Apr 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHUBIDew"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6721A447;
	Wed, 30 Apr 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746002138; cv=none; b=URGmjTSTpp2sE4NJO/cRHvX4kfC6IBXFSALNKg8kYbUVzpx6TJUhoWsZXCLFwX6vlaK2/3069LMAxr6QRKGd8ZnZULOHaHSvBEgr00uXDlWUCSnLiGMDD4Ii/hqDE8+QhbXcwTFx9jTKF1T1H5wRouPZoBiNcyU512Mh7pIm4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746002138; c=relaxed/simple;
	bh=lp2kLG8XQZUWdd8RuhDARxZ1LX3wqTCY+gVpOwpUw2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hrg0XhcyRs+Fe8c4WhnUTdJAR2WYRrbELbqwdM7mVghuq6Gn3+phk0B2cbmGDKM0mxiNlshfYwtmkZ40Z6HqRREa09j/f2xBYDzZdA5swglW1w5H+WYSA9C3F96Id6/0R0BH06lS4yuzw/Joz8GuVTpl3mgFC2K/Ta1BU9j/RnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHUBIDew; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746002138; x=1777538138;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lp2kLG8XQZUWdd8RuhDARxZ1LX3wqTCY+gVpOwpUw2M=;
  b=GHUBIDew7aMENa9islLufHLZU1OhntahbxY98Jpeuy0dBf3bBEhEUW2A
   Qo1nveI1TG+szdh843JZitpH2SB7mu10I4JQc2GgjTDU9yEN8z2L90L54
   +pYJatDipfgW6FJy1sjtVnTLiof1tzFxEo8vsVy3rU1Odqf97jB/qKNgU
   1X9Y1ni2dME83IJ/T/zKUdB8pXVn8oXPxMxWFbolgoa26y2SW0GVQztmO
   j+T4qPoBfxDmVoN0+ciBiOjEXGpF0odGmx1UZMY5J5bpgrD776VY4qOZU
   FLuLfeMsdsHQKRcYquyCxMV2IgEpdWP0z7Tb+hkQW021RByx9yQle0lTw
   A==;
X-CSE-ConnectionGUID: 8rOyqwaFQ0Sxq6e/hCBMQw==
X-CSE-MsgGUID: rzPH7mnnQZajTak9UgiycQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47534106"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47534106"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 01:35:37 -0700
X-CSE-ConnectionGUID: 14GVnVnfRDCAk5tXbPRSgQ==
X-CSE-MsgGUID: ePVJ2zgjQSSMdagW/RanMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="165001559"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 01:35:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <kbusch@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Fix lock symmetry in pci_slot_unlock()
Date: Wed, 30 Apr 2025 11:35:26 +0300
Message-Id: <20250430083526.4276-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit a4e772898f8b ("PCI: Add missing bridge lock to
pci_bus_lock()") made the lock function to call depend on
dev->subordinate but left pci_slot_unlock() unmodified creating locking
asymmetry compared with pci_slot_lock().

Move pci_dev_unlock() inside an else branch to match the logic in
pci_slot_lock().

Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4d7c9f64ea24..26507aa906d7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5542,7 +5542,8 @@ static void pci_slot_unlock(struct pci_slot *slot)
 			continue;
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
 }
 

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.39.5


