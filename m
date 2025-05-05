Return-Path: <linux-pci+bounces-27212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C76AAA59F
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 01:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A963BBD48
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 23:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441E9312804;
	Mon,  5 May 2025 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtyU98iX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1269B3118D4;
	Mon,  5 May 2025 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484225; cv=none; b=T0J6QN+NkuqLSUQ2+MfQSFr2cPnXAnrMF7etUOndVl202rT5HcbrDlWkWQApo3ao1cQA7/gZ7gWJKXIG9k2QOFClO4FN1iUaV9qYWyrxdeuU0k7cjY2hlQcnC0VYUjvWMhPBHap0ROiy5pwj7rP1qD9+L4g2YQZfHiGo4wpVYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484225; c=relaxed/simple;
	bh=SB1zl0D51ZUCmHd21BmXadkusPCy3lNJ79caDLzynuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlQb4XL6vGdcMEcMm+rOqMW/6KwepuMnlnhOHEdFruVBJJNQyEqF0oKsEv3W+xlAgbl4wM2iJS97sPpqm9UPvCrOPaTo0hwWadiE0qro1/akTwhqVhX8Zw2gHKPC9WUjJjojadIBNQks4x5pIBTHkAj4SeAZ0rFiFlhTdQhvH84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtyU98iX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272D6C4CEE4;
	Mon,  5 May 2025 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484224;
	bh=SB1zl0D51ZUCmHd21BmXadkusPCy3lNJ79caDLzynuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EtyU98iXnuSGogVZWYJdkD3AhNbBhsVmLfPxcUYxRQ9DMicKehZnTrKj9Xzyn5A+a
	 e1G9hLoeyq+k1t4Iqut6JzD4o+uvU3GzIBmoQqj3vm7oh9UobZnbTMBU2gKj3cD1n/
	 OuD98uL9HPox+EL7nVUNVDm7oMGgI6DmzWDAdwrvXnDx88VZCTkXs6bb+khOmDHQN5
	 tRnRmPTpAD7r/U+vuZ63e8c0lxVjesDH+r/LjHUqxdLGnLbmWmRKrkoS3xX4bon416
	 SsW8Nv53ePrGKrOg2BFc6zYaN3Y7+uSNlYet6CMiZybswnQMmYOLUKNtxtMf8x8b3X
	 JxODLmosyUcuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xiaochun Lee <lixc17@lenovo.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 397/642] PCI: Fix old_size lower bound in calculate_iosize() too
Date: Mon,  5 May 2025 18:10:13 -0400
Message-Id: <20250505221419.2672473-397-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit ff61f380de5652e723168341480cc7adf1dd6213 ]

Commit 903534fa7d30 ("PCI: Fix resource double counting on remove &
rescan") fixed double counting of mem resources because of old_size being
applied too early.

Fix a similar counting bug on the io resource side.

Link: https://lore.kernel.org/r/20241216175632.4175-6-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Xiaochun Lee <lixc17@lenovo.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8707c5b08cf34..477eb07bfbca9 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -814,11 +814,9 @@ static resource_size_t calculate_iosize(resource_size_t size,
 	size = (size & 0xff) + ((size & ~0xffUL) << 2);
 #endif
 	size = size + size1;
-	if (size < old_size)
-		size = old_size;
 
-	size = ALIGN(max(size, add_size) + children_add_size, align);
-	return size;
+	size = max(size, add_size) + children_add_size;
+	return ALIGN(max(size, old_size), align);
 }
 
 static resource_size_t calculate_memsize(resource_size_t size,
-- 
2.39.5


