Return-Path: <linux-pci+bounces-14406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD90499B6D9
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 21:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5B51C21145
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 19:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04C11865EB;
	Sat, 12 Oct 2024 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RVMttrgv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D0ECF;
	Sat, 12 Oct 2024 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728762841; cv=none; b=bm6OVOoFEEeMH8zoQroubzeoguBMBtUZdZCMaQUE+gGyjMLYXcp9QchSdzsJhLN0zjzRNM/HrtKtEDOzTOhtvjNegITOKL9BvCgNTAFGbCwFQdthbtF+ZeVpQvbm2W1fEqdqm807eGYIZtDTMnTGbhzFh+BIposoTNN5cN1rnA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728762841; c=relaxed/simple;
	bh=o6csu3VpNTqjOnFk3FhyX8sbhAdr7OqCT1L0mIOHgUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NV1FUhjT7yQAuuoZ38Eh6p+7NtIS11j0vPSIadRXTe1JafUp3913dcQeIJXxG8pw/veaEVddwWlQZqLyJLOTM6xnPy9HwDBQ7kaHLqfPOpjG0sv023DaHqQrWC7auLeyhMwPYrLDTjV87OYS7GWfOq26C4heDnWicq83z3UTBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RVMttrgv; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ziBRslTt0WNPKziBSsJ3zj; Sat, 12 Oct 2024 21:53:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1728762830;
	bh=OjcGSSzZ5IYQEwwSTMZge8saiTVS9V3eUZeqwqwJl04=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RVMttrgvLoem8hG6LL91YqWYRhFJZUHKcKr8rjC5Lwpo17FxieqrlCT/FRd50B/D6
	 AsBZ2E/bArbUe0x4W52agKT8/OFKXwo3bUURhuKlNiw4dTxgR4dTnQtZlUPe4OdNSW
	 23qax4bISe/Tgy2OxzyOk1A+0fe4GmSZwzY+Q1IUvzWmhQjE9GJcgfUUr0/MjFdJOk
	 oteYBWbPQXp9pyvUlLVPSBA0Lsrfb0t6wjR45Npss/r5NpXaQv0HQUSI1RR2GbH1Zj
	 T312209wrstkoYXzQopapmNub/wrnOdhV5cgBsiXANuh2Y/CP7oL3oD5awuAcx3Rx2
	 nhHLYDrKxD0nA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 12 Oct 2024 21:53:50 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: cpqphp: Remove an unused field in struct ctrl_dbg
Date: Sat, 12 Oct 2024 21:53:42 +0200
Message-ID: <551d0cdaabcf69fcd09a565475c428e09c61e1a3.1728762751.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'ctrl' is unused, remove it to save a few bytes when the structure is
allocated.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/pci/hotplug/cpqphp_sysfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/hotplug/cpqphp_sysfs.c b/drivers/pci/hotplug/cpqphp_sysfs.c
index fed1360ee9b1..6143ebf71f21 100644
--- a/drivers/pci/hotplug/cpqphp_sysfs.c
+++ b/drivers/pci/hotplug/cpqphp_sysfs.c
@@ -123,7 +123,6 @@ static int spew_debug_info(struct controller *ctrl, char *data, int size)
 struct ctrl_dbg {
 	int size;
 	char *data;
-	struct controller *ctrl;
 };
 
 #define MAX_OUTPUT	(4*PAGE_SIZE)
-- 
2.47.0


