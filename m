Return-Path: <linux-pci+bounces-37326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D98E8BAF2A9
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 08:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622A43AA395
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 06:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22CB2D73AA;
	Wed,  1 Oct 2025 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hleH5zoV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEAF1BF58
	for <linux-pci@vger.kernel.org>; Wed,  1 Oct 2025 06:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759298412; cv=none; b=rD4vSvhod8aw8Wvljn9W/RGVqjEto+tU5sXblu+UktUZ6MrBhC69JBP5GPKmmdJYOuQ1x4iw7cTwJTiyXZUC+l7f+JDxoyu/NfwLt7MsPXX4nsLc/S4EBQXWgXRt8C3/pi6oyAc3g/43Cg94tuuRgISPu2GO46x71uXalkWpEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759298412; c=relaxed/simple;
	bh=IWlx0e8YyPwi5puoG7i06fzEK6gMQDybXLrNITU43+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M2o6vPnhXB7x9rIKfPwgkpeBh79SJ893IgmiuR0rHJs2JL2B+xoRFjzBMH/S2Ou74yQyUZIua0Xdbs+hNXGXi18XkmPLRA5ETcFLOqBYdwzEI8VtH2xM8RSvez6Fqrv2ds5MWbgk7w2/5OonXOAvD2NipdoEx1R8ztJCaObhxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hleH5zoV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759298411; x=1790834411;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IWlx0e8YyPwi5puoG7i06fzEK6gMQDybXLrNITU43+s=;
  b=hleH5zoVn6CRgUoApHd0v4Uuy02MfsETpPliBdRy+ZKpQi7au7UhJ+RB
   YCidQbw8lvTzze+4k8JhNka3uzBBXYwgz966/HMCk0RMhB2hlgtxW3GQ9
   xf+HHX5Zx46Fj8Q5HCitZh2149621P+xjyNVNV5WhoZVhH4uh+iZFgc6T
   nsHRzl3jFqyWsJxGxvauOjN3QqnHmg9YEt/7urlcWlTzfEgCTRXwBM1dN
   y8s6LKzUlLHKryddtPxXIBDMmzkNvhBpRK0jOnT6rI7hrDFXNLvCwIvwy
   YBt1KrYTDi7gbGTWwqhRVkVDERCV5126WDktmEGXOMvQ1/GMmAv7Wq4xf
   Q==;
X-CSE-ConnectionGUID: s/9NQekcRyaIq/5pR3g/qA==
X-CSE-MsgGUID: 6GcnvhejTI+k1yU6HaU69A==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="87012648"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="87012648"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 23:00:02 -0700
X-CSE-ConnectionGUID: VhPdm4bVQSi00jnTxS4eHA==
X-CSE-MsgGUID: gVyVpzqqRp+jgBRhLcttJA==
X-ExtLoop1: 1
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa003.fm.intel.com with ESMTP; 30 Sep 2025 23:00:00 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] PCI/VGA: release vga_user_lock before vga_put()
Date: Wed,  1 Oct 2025 11:28:13 +0530
Message-Id: <20251001055813.264300-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Release vga_user_lock immediately after list_del() and before calling
vga_put(). The vga_put() function acquires vga_lock internally, and
holding vga_user_lock while calling vga_put(). The VGA resource
operations and loop iteration don't require lock protection, only
the list removal needs lock protection.

This ensures consistent lock ordering and eliminates the deadlock risk
during VGA resource cleanup operations.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/pci/vgaarb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 78748e8d2dba..e86fe7fa3d6f 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1445,6 +1445,7 @@ static int vga_arb_release(struct inode *inode, struct file *file)
 
 	spin_lock_irqsave(&vga_user_lock, flags);
 	list_del(&priv->list);
+	spin_unlock_irqrestore(&vga_user_lock, flags);
 	for (i = 0; i < MAX_USER_CARDS; i++) {
 		uc = &priv->cards[i];
 		if (uc->pdev == NULL)
@@ -1456,7 +1457,6 @@ static int vga_arb_release(struct inode *inode, struct file *file)
 		while (uc->mem_cnt--)
 			vga_put(uc->pdev, VGA_RSRC_LEGACY_MEM);
 	}
-	spin_unlock_irqrestore(&vga_user_lock, flags);
 
 	kfree(priv);
 
-- 
2.34.1


