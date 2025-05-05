Return-Path: <linux-pci+bounces-27251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F8AAAB5F8
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 07:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C974A2387
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 05:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C81D34E1AB;
	Tue,  6 May 2025 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPlyNmLX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E43BE0AC;
	Mon,  5 May 2025 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487408; cv=none; b=lg9poEjZc1Kkx6E5AkGzLNX9IGTSJqCYXLj+Y2LiPd/fMXfQEH3Wy+Qpmg7ftO/lioECJPtiaYZvJ0fT433dnxUp95xh1MAlKMPLFweKTvZB9L62fcmmyP/EsHzEL7lOfM+LbztL7fQPHl3vM79KpoYY1wheJcf0GORYS4iV1mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487408; c=relaxed/simple;
	bh=hKUiINuiaux0kf5AuOdaEyHIw81+k5EKGTxhvDeCSao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuGo6pJj/I4rovu/IP5i9/hclvlurUsn/5xe4GTSEJAWw4Pad16bfMxQdiIcJhILkXqVwONSwdlVdax/2qcfjPsR83a6ilWCc19ekAj5e63XF7R8YbVCRNwJTV8I/+0G4VNY5j+J1aQvtX6/WMuCQUuEk61ddIVfOFfC9Ova5w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPlyNmLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D711C4CEE4;
	Mon,  5 May 2025 23:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487407;
	bh=hKUiINuiaux0kf5AuOdaEyHIw81+k5EKGTxhvDeCSao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tPlyNmLXGvyv5KKrf4+WJ24i6HcaZUL6X9Wgl4kH6ih4hrm8QZOKYDIk3CcRDXty3
	 182YB57tNuIphdXgd8G6QZP3Z0VHkfcxKI7zCdrv8amH4tI59YGVEVXbnpOaCcSRDd
	 tWi31kkEICBg3HwtFHLgrIJKZlvHjloq46VP0k3M/yioS48ga5cLRxWbcOA6mKlvo0
	 5eA73aLoA/ufCr/qX21aWwvvm4qUQpIomgnE6OqhI7boaec8l8vfxSYq9Aa3069qkA
	 CXP1N3lg4GctAO6Ya8ptwWvHYf8X3MZNuIV+vdLhm1J9UctZwsQFADZKKKbQCVD8nj
	 9bQW6IIV1HnCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xiaochun Lee <lixc17@lenovo.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 53/79] PCI: Fix old_size lower bound in calculate_iosize() too
Date: Mon,  5 May 2025 19:21:25 -0400
Message-Id: <20250505232151.2698893-53-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index 32e34ade736c3..1793e1084aeb3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -800,11 +800,9 @@ static resource_size_t calculate_iosize(resource_size_t size,
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


