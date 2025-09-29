Return-Path: <linux-pci+bounces-37184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CD7BA865B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 10:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD3827A7BB5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 08:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D2C26A0B3;
	Mon, 29 Sep 2025 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cA62By0g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910DE269CE1
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134606; cv=none; b=fj9IORk7jc4ktkz3FHTLymSGey84Uy1SNrL16ezdKq/QZX6ISO28RDI8gQtjv7k01vClFmEbiL3WinOfpQ9aO1Vt/0Uqbu3R5S5fqRXEKvXX5hzmLxwJ56gP7/OcHhcP0kdTJC96/RuEZhgF9hyP1GexBVEJzQqdPIdvAWeFJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134606; c=relaxed/simple;
	bh=k2eTDDi94ezrIdVH06+ZP4tcnT3DAAyl073d6nRhiyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p3fihbUq0y/1h/Znztox52qGzKUuHMocrr1kFhueJMOhIgWweB7hN2MUcrlpQ2gJPFi0Zf0ChdRoqmdISJPNUyhYeG22IL7C5plFDxkYAvwHP7tj9FgHpoyXRiclfA4AxmC775pFP8gUOpSg3dfrle9eja1JSviMp4T2sBt4tYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cA62By0g; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759134605; x=1790670605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k2eTDDi94ezrIdVH06+ZP4tcnT3DAAyl073d6nRhiyI=;
  b=cA62By0g967OSo0lmlBHFQ8rSzTZQBr69UVXUuzGZKAvi8Z9pTbGbYBU
   wp7y1/ftBwrjJZLD2o6OcO5nOIxRYiOdVLnx5l0lnb3hJy8hrpudmBr1t
   VlpVAWzKvn82YfZ+7MIA2PnyVResiPijvwKlk0/E3/BqWwGEcu3Vx3NS+
   dCdSkSb7AWl6egKcxymd88OVf2LybOje3BtOY5XdMaZol4vUzGT+jd61X
   VAi57uzuP7ilO81j0dCHmDuap7UGLpTQcfFT/HGmybs0fac/JYWn5ATPd
   yA4zBB8TPRkN81LqDMxvL8Ib4xPbDec0v6OaRY4s4v+vJtTr/nSdGKF7z
   A==;
X-CSE-ConnectionGUID: ajyqqpueQbWumCJMC6bcKA==
X-CSE-MsgGUID: M5+Q3kPZQ3mNdzAZS8pc6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="61289677"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="61289677"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 01:30:04 -0700
X-CSE-ConnectionGUID: 6PvGOIDWQue1wmsPfjxsdw==
X-CSE-MsgGUID: Wyo8CMvgRqWxFgsQ8YMTPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="183358578"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa005.jf.intel.com with ESMTP; 29 Sep 2025 01:30:02 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] proc: Remove redundant size checks in proc_bus_pci_read/write()
Date: Mon, 29 Sep 2025 13:58:15 +0530
Message-Id: <20250929082815.238143-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove redundant "if (nbytes >= size)" checks in proc_bus_pci_read()
and proc_bus_pci_write() functions. The subsequent "if (pos + nbytes
> size)" check already handles this condition by adjusting nbytes to
"size - pos", making the earlier check unnecessary.

This simplifies the logic without changing functionality since both
checks serve the same purpose of preventing reads/writes beyond the
available size.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/pci/proc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 9348a0fb8084..da19e6a65ee4 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -47,8 +47,6 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 
 	if (pos >= size)
 		return 0;
-	if (nbytes >= size)
-		nbytes = size;
 	if (pos + nbytes > size)
 		nbytes = size - pos;
 	cnt = nbytes;
@@ -123,8 +121,6 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 
 	if (pos >= size)
 		return 0;
-	if (nbytes >= size)
-		nbytes = size;
 	if (pos + nbytes > size)
 		nbytes = size - pos;
 	cnt = nbytes;
-- 
2.34.1


