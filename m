Return-Path: <linux-pci+bounces-9293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90EA917F7C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 13:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5B21C213EC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FD717DE1E;
	Wed, 26 Jun 2024 11:20:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out198-7.us.a.mail.aliyun.com (out198-7.us.a.mail.aliyun.com [47.90.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A499013AD11;
	Wed, 26 Jun 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400852; cv=none; b=RIDvi+T58IyuyLwdRXfGY+6qww4JB0nPAwKyis/kOovQFbpG93bMZptuIEj6/yVtXlIuZEkX8Cm6cTk/UXnlCts0M85ARAfbRZoggmmEPul7HiQcwWf3oS6nOlCVy8R/H9FGUvdmmLvcLFT3pe1qrW8CUpCfrfEHNhJMQO+dOEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400852; c=relaxed/simple;
	bh=2GDlNJlff6c0ErYM7JHzax75INsqjYAulL4ptn0hRh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=scSRQATBe0RRjAZ7QL537gZALKuiAMPPhnDuVlaBjjn6guAXf5+PUHFMrN5/Ge6MZf9VsZX4xhFhL62csgcxbl8wt0UTtHUpnDdbnJMsilqlmsoxo4h8tqpr9LXwloSTaXsx80CqtQ//QgPwAgm1Sdd4Hjw9+P3jyJ7QssKyr8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=47.90.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1003466|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00902339-0.000748427-0.990228;FP=0|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033070021165;MF=zhoushengqing@ttyinfo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.YAgb6ZO_1719400827;
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.YAgb6ZO_1719400827)
          by smtp.aliyun-inc.com;
          Wed, 26 Jun 2024 19:20:28 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: lkp@intel.com
Cc: helgaas@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	zhoushengqing@ttyinfo.com
Subject: [PATCH v2] [PATCH v2] PCI: Enable io space 1k granularity for intel cpu root port
Date: Wed, 26 Jun 2024 11:19:47 +0000
Message-Id: <20240626111947.367032-1-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <202406261735.9Fu2z2ic-lkp@intel.com>
References: <202406261735.9Fu2z2ic-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compilation error in drivers/pci/probe.c with commit
1f22711375ebe9fc95ced26c7059621c4d59b437

Changelog:
v2:
 - Fixed compilation error(missed changed).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406261735.9Fu2z2ic-lkp@intel.com/

Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
---
 drivers/pci/probe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3f0c901c6653..909962795311 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -463,6 +463,7 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 	u32 pmem, tmp;
 	u16 ven_id, dev_id;
 	u16 en1k = 0;
+	struct pci_dev *dev = NULL;
 	struct resource res;
 
 	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);

base-commit: 1f22711375ebe9fc95ced26c7059621c4d59b437
-- 
2.39.2


