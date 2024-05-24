Return-Path: <linux-pci+bounces-7807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6326A8CE103
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 08:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA072823BA
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 06:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37C82207A;
	Fri, 24 May 2024 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bRfeisR0"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5D381DF;
	Fri, 24 May 2024 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716532233; cv=none; b=HTUFj88n34FDxpDmBH8t3GWFfUmxzwhvJKwIda0ZMg8grBC+x/b0e/zc3gYSPb9ZcjONY8QZLzEF5JUZL9uPm6PJwvek5lRWR+tfr7iCQhey/mujSTv0UCgfjM7OgaJTe4X59Q1WJFUo7GSSJvSS7u9to3bhv0T2USWDpTO+FKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716532233; c=relaxed/simple;
	bh=3UoxeqbBMKbmjTS7oVcj+8a9bJ9zUGrCAQeT0hunQAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hdS7KBukfnsd6chzKaRTL4+0xFHuNTo7Dd8skcMF31S5VGYZe5NvYkKRa+yq6U+Y39nz4ikp7WW2Xi2mu/GMCVCj4A8ukUQxswBaTrRf8iBX1xVzLGfR8p8J6LA74RZUR1hAeeaRp7hSL3b9dbFXZBYQHipjJQIJrnTOwylk5Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bRfeisR0; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716532227; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aWmDooCH+504yrVciyeVZogdYg0a3sQ6PlOGFpfiMIU=;
	b=bRfeisR0W0UtOIqWbNFPjJnhB6HIsiZdsA/RM4BNKenHZMmLMisBbbYkriQIdPQEzJ/aWsWfbGz93wHi1MisJs2loZ8cbvssS/hJYsIfYxFt8Ix6L67RRcEC/605jghWlxRXmfKGQPEl03VUD5vjW3LzSL/EXo2j9C9001iPh7s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W757k.t_1716532225;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W757k.t_1716532225)
          by smtp.aliyun-inc.com;
          Fri, 24 May 2024 14:30:27 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: bhelgaas@google.com,
	lukas@wunner.de,
	weirongguang@kylinos.cn
Cc: yaoma@linux.alibaba.com,
	kanie@linux.alibaba.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: pciehp: Use appropriate conditions to check the hotplug controller status
Date: Fri, 24 May 2024 14:30:23 +0800
Message-Id: <20240524063023.77148-1-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The values of 'present' and 'link_active' have similar meanings:
the value is %1 if the status is ready, and %0 if it is not. If the
hotplug controller itself is not available, the value should be
%-ENODEV. However, both %1 and %-ENODEV are considered true, which
obviously does not meet expectations. 'Slot(xx): Card present' and
'Slot(xx): Link Up' should only be output when the value is %1.

Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
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


