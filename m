Return-Path: <linux-pci+bounces-27249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 667B5AAB7B5
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 08:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E63A1C20B38
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 06:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086513A786B;
	Tue,  6 May 2025 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hijo+N4W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341C328469A;
	Mon,  5 May 2025 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487015; cv=none; b=OVypa9YT5b60c9ja0n02ech0NixkrJ/uqJJl8LxUt+h8SQl3MdAfZsWY8hYRMH6Vvku6rMJ3kzx1o7zHHDwaHk4+TXZrYOo1NM3V7Xg8f+Or1Ed/1ZMi0FTVbOAODGbJaCwofYkQry1NLGBrsvvy3pIUUl1UyIureQvDQLjLk8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487015; c=relaxed/simple;
	bh=TBiToOS22xXZR/yDLGAa0T27o9hnSJUf3WOeI4oWn+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABMDNC3VuTodpIWWcTeJmT+XS10gxzHLJpSQL93NbX5REXC9gVk+zaoD2CtjX7S9Y1Xpq/GdIVRgq0tI3fpDwU0iYRxsKDzVWL81L4D60Mfq7N3N41TrmdiRX3bYwv/nIupOrdJEsG4P9n8JhtZ7NZydbgqcgHWM9jnYeXewl14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hijo+N4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD794C4CEEF;
	Mon,  5 May 2025 23:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487014;
	bh=TBiToOS22xXZR/yDLGAa0T27o9hnSJUf3WOeI4oWn+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hijo+N4WP7o7uVFa6Zjgjqizh7luTpxPVRKCwHmTCJIOje3oYcwaGPvHYSJ71JoAM
	 YQAznE4SeVoqbZr4P5oIBjZdmztzTFTVZfiLV/I9mEUWQlqvHh0k2x2yNoP2Ip+xwz
	 l0o5DOTRhtd5cT5uwRyBPkhg6jQY1BoHjTp84EnwCLxmujoe+tesHqQPCTQ0NlQ/c/
	 GQA1kS3PfBZiWB6OaQoNCkMC+kdtT+3NpUwH0uHk03F2FSztFsQ5epXX/ghoX5z+tu
	 bsEOzu5PEFh9Xu1a2x9aZMyJjFZfh6vflpmaA4cITDMVkyapbNdJMWwDwob5TBK+f3
	 BORqHawXuWiMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xiaochun Lee <lixc17@lenovo.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 108/153] PCI: Fix old_size lower bound in calculate_iosize() too
Date: Mon,  5 May 2025 19:12:35 -0400
Message-Id: <20250505231320.2695319-108-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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


