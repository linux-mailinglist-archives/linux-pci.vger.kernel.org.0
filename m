Return-Path: <linux-pci+bounces-27241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D415EAAB043
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 05:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741023A7056
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 03:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E653ED7C9;
	Mon,  5 May 2025 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4/cGwbW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64763B2F74;
	Mon,  5 May 2025 23:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487252; cv=none; b=PgRKK22XDl5mBM4WEpmbf+AhW02JivUeRBPsJIPii1h/m+pFw0mTvYbdrvVaA/y7+X7YlRruXNWiE/mOK3f1o0tEdWsfg7sxyoogU9uVhm6tJaM0Ryt17t3nz5U+/8AgUos8/lgbpuXZU1sHpaGJ5DxJBgMH4jULvxi+4gEjKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487252; c=relaxed/simple;
	bh=TBiToOS22xXZR/yDLGAa0T27o9hnSJUf3WOeI4oWn+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuuW5RPG8lMRter5urHDV/+LJB9qWvZxnioXHIkkacuiclhe02fgr9dX6nMiosb9b/sUkmmZ1HtNieCLRD0xMxjZT1rFqXDS7S6b153OFtQK+BfcmsXx7VKtJ4u9QllmZ112DgeXFojz6PUfy/uxuddG7FTnuE1pKjXUv8Y8VGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4/cGwbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D92C4CEE4;
	Mon,  5 May 2025 23:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487251;
	bh=TBiToOS22xXZR/yDLGAa0T27o9hnSJUf3WOeI4oWn+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e4/cGwbWwPmrVSfFh+VU+OfPNSV7/5pRE4ROkuQ7p7QNNZg7IMhY+3AbbL+dYbT0Y
	 gNdeAMcEqE86ENW3GMDvMNjRTT72U1QFylsjDOxjTLTMiAQMA0pLIN/4tJWdfDCjdt
	 /qdELomT0WhmDxeW0JkSywqD83g/1XHpNCHlNQg6/Unx/kfagiFxh0U8pJ5nXYo4vM
	 ZuDcqsWrrXTHFGYZjxhggj+lIR+ldFQol5/L+V7bOHcTsb60M5aM9KzWdILfHnsOA2
	 IGLgWhtL4agFqil4x7RcDVEOiiBeVeCp6CZZae1KeeSHhgpakrcrzgYX+Pg9YdVbB4
	 xIknX9uSR40EA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xiaochun Lee <lixc17@lenovo.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 080/114] PCI: Fix old_size lower bound in calculate_iosize() too
Date: Mon,  5 May 2025 19:17:43 -0400
Message-Id: <20250505231817.2697367-80-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index a159bfdfa2512..04c3ae8efc0f8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -806,11 +806,9 @@ static resource_size_t calculate_iosize(resource_size_t size,
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


