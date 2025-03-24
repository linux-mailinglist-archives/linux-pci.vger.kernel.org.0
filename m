Return-Path: <linux-pci+bounces-24525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCBEA6DAE0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 14:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E96C27A2BD4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C55D25F784;
	Mon, 24 Mar 2025 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s8HfnPDU"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA3825EFB4
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821971; cv=none; b=ScJfD7AOVYtjFmiJuvybBTkRJ3+yRhYXqM7/VXGBVW03f9hT1rAgoVKcrYIf1rVHL42+af7E4eb3KR8L0idnNzRUUMyotcMQUYcbyD4zZ14Ae8AwJmjY7N0q/6pzXchvbcMVLaWyX2QWkbs87REHAJTFnqoVLNsXWWt2Eucns8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821971; c=relaxed/simple;
	bh=oc5XKv/FYSLQe79g2KK255FxNDPOV1tV7MK6x3zreVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMfZZOcxyQoH8yutPa2/Ni0foYWogcrlbqsKP7abDMr2yW54ZKp2CG9a411nd+LHSfjdycAMGB8J25GA2Wqal+jqsnn1R8I3UtpCIOS6CvFfl+9wSJH6A1xbIe2uuqIYtA3wz7inLvTPVb1ZEJu/51+YhbYvok5qveyI2HLfIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s8HfnPDU; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742821958; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dadNLO58bpbO2LNXhHxcyyLUFy6oOfuHgT5h+hXN3Jk=;
	b=s8HfnPDUdIbVcwQO2WHu9Hp50sgJjdG146PtiY/dfzuUtF9b0HR7n9mQ2LsI9Po062w1uvZAyaMpz0tCi8IuM4dIVktpKNg/OlBTAmNus5kiE7nzK4FeJFH5YFOrYQByayE9iED1yJnP0UdRDS7R/u7lfBg7R6uSs7f8by/vl7o=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WShIis4_1742821953 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Mar 2025 21:12:38 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] PCI/IOV: Make the display of vf_device more readble
Date: Mon, 24 Mar 2025 21:12:33 +0800
Message-ID: <20250324131233.116341-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "0x" prefixes and set its print width to enhance formatting.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/pci/iov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9e4770cdd4d5..df40663c1881 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -500,7 +500,7 @@ static ssize_t sriov_vf_device_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sysfs_emit(buf, "%x\n", pdev->sriov->vf_device);
+	return sysfs_emit(buf, "0x%04x\n", pdev->sriov->vf_device);
 }
 
 static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
-- 
2.43.0


