Return-Path: <linux-pci+bounces-7886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3CF8D1499
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 08:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC731C21CA0
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 06:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C376A039;
	Tue, 28 May 2024 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YAYTy97C"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95661FF6;
	Tue, 28 May 2024 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878539; cv=none; b=jjTzwU0rtQMpLOkzlhghDm+7Yrj18qiJ9Z2QCwZj6li6NC/6eE+25/sQ2ZN9nJjQR7YiXxsl7VYP7cg+UqktyyFItn8dtkmGxC5M9+97Ntr7YJheHMVyg21aGDPQBKjjWM1lz//VKi+8iwQFkdhYl9Q38d5ArjRPO/F1ABbJqSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878539; c=relaxed/simple;
	bh=unp07GJmZ++P8y9G7R8jwpKp8WXsLs59UX5DVYR1qVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UhClqjUMtGQgH/Y+97rw4u6NF1g+Froh0l+n/0qKUBfgqSAEqUMdqXEYuIUrLFWJb1EHdzXwRloWTJZ0ZsM0tASFksqxp+QA30l8Z9aixOrtHs8dURS6KsowSHUm3gT0mkrYVMOtKCkbn55nBZMVPMJL0KIyjnvGKxxZJfDCDS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YAYTy97C; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716878527; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1TYz2MSLWTBADR4fMNQi+uyHDoesbuC11bnI7fbU/Nk=;
	b=YAYTy97C4//M7/wp5gTfEV1m6srNwHt4opTs6wNkGhDcH40omnnsn5qmYKEMSX56N9X24E1qQuDAqORUaDKh9Htf2MRDdw2EJfED6z/DxmbJDkA7L3t5H5ZXjai21AvU0GvBpdiOk+8IImfN7RqWQLEy3RTzvaFINOMnNgcNVHg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W7OiUf9_1716878524;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W7OiUf9_1716878524)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 14:42:06 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: lukas@wunner.de,
	bhelgaas@google.com,
	weirongguang@kylinos.cn
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kanie@linux.alibaba.com,
	yaoma@linux.alibaba.com
Subject: [PATCHv2] PCI: pciehp: Use appropriate conditions to check the hotplug controller status
Date: Tue, 28 May 2024 14:42:00 +0800
Message-Id: <20240528064200.87762-1-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20240524063023.77148-1-yaoma@linux.alibaba.com>
References: <20240524063023.77148-1-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"present" and "link_active" can be 1 if the status is ready, and 0 if
it is not. Both of them can be -ENODEV if reading the config space
of the hotplug port failed. That's typically the case if the hotplug
port itself was hot-removed. Therefore, this situation can occur:
pciehp_card_present() may return 1 and pciehp_check_link_active()
may return -ENODEV because the hotplug port was hot-removed in-between
the two function calls. In that case we'll emit both "Card present"
*and* "Link Up" since both 1 and -ENODEV are considered "true". This
is not the expected behavior. Those messages should be emited when
"present" and "link_active" are positive.

Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
v1 -> v2:
1. Explain the rationale of the code change in the commit message
more clearly.
2. Add the "Reviewed-by" tag of Lukas.
---
 drivers/pci/hotplug/pciehp_ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index dcdbfcf404dd..6adfdbb70150 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -276,10 +276,10 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	case OFF_STATE:
 		ctrl->state = POWERON_STATE;
 		mutex_unlock(&ctrl->state_lock);
-		if (present)
+		if (present > 0)
 			ctrl_info(ctrl, "Slot(%s): Card present\n",
 				  slot_name(ctrl));
-		if (link_active)
+		if (link_active > 0)
 			ctrl_info(ctrl, "Slot(%s): Link Up\n",
 				  slot_name(ctrl));
 		ctrl->request_result = pciehp_enable_slot(ctrl);
-- 
2.37.1 (Apple Git-137.1)


