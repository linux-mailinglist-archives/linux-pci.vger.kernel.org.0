Return-Path: <linux-pci+bounces-19307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD62EA01844
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 07:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0F33A35F5
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 06:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728073595A;
	Sun,  5 Jan 2025 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="dUggafPS"
X-Original-To: linux-pci@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164A61BDC3;
	Sun,  5 Jan 2025 06:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736056984; cv=none; b=gcIyiL0J3Ut/tO9Pq1Q6OBtjrfsPxOECKn88QA+BbrefJjaIDfUpO5vohsapS+hmI/Qeoawz8Io8DfmX0UoLKWyrL3MOF4OmfaLrI3+6inzVgR1kpcVnzLgJAyfcIeDg471uWaE4NbSxlWDSoZIdsVQ8PRM1Wyqp7EGtXY8x4hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736056984; c=relaxed/simple;
	bh=ljcqXNSzvAWcAno6sw8/xCxCE4+is3tD5z9YqtdeCIo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=l9oP82/l9kfJiVUK8/3pAowHjY1I37GN1Qb8rpDpsflU18UzI6Csvn5Em2SFTIIOODwgB+7/BgN9BN39ViEj3D73+mCWMusAPSdTsS5hzH03ay5T0aWdTLhHoTH+TABZV2CqYSRYKyi20ccYIr0QBhfy/4oux3vmsO7MzyHP5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=dUggafPS; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736056676; bh=tuSQf2/SB/aButLjZ/0dfORHyj8pi8iEwOjjELQDRDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dUggafPSYTF5tNsaOpjFOjnoQgsIvZE7kPSodApxyBHtqw4jZQHXGULPKJ030KQ+i
	 MZrx6Y4FIxmQ3uQTA66weSGDlEwofokr6S8TcNNxXTX8hPPIM2lM0u7vdFXUZjnb+6
	 0jY3Lg4EWamx8HieQJSe/TbWlmkkrWhohO5aPiSE=
Received: from Ubuntu.. ([240e:305:25d4:e300:e2d9:1fb6:5f8b:3c3f])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id E7534067; Sun, 05 Jan 2025 13:57:53 +0800
X-QQ-mid: xmsmtpt1736056673tx6e30xse
Message-ID: <tencent_6F826F87DF787845466AE67AEFF37E073E08@qq.com>
X-QQ-XMAILINFO: MapnONytPuziafDcN9vkGEkdxlXC9IdW28vfD++22D6BxNqaf6FHiQTsWTU2/6
	 GbZRJ6w8T2YZ3v80AcJlPMgaUXx+LdA3TiIhQMc8xUqz9uXAXoiub8g8T99Qzwhw6qM3WG5msTve
	 fsfQfhnVR1HqCb5ySwKwUCFO4MQuAidPuA9cPbVoym/ci78/z4kaqAEYiuKAqrz2lxGR8HqyAbYA
	 bCBI82KOajz2DMXJA+M1qxevOH2sJI/KUWOibb2n5cYQFmKXAb03rp8ioWIt7FrfYw4oUj94Aikp
	 kOI2KOe8u7egHxrvid0w4I3HBYV8c0dcFyINkCV5rozSIxeXbIcEX5riRp+O4C8o9XoELGXHpQaz
	 H11FYMVLPjehbrqUF9gIXbv1jHnPq/ZxaCbH7aUCTgLf7N3uycAIPUYTqF2YuFlUMFOIJkO2Seza
	 lxa+sBrLFjqxViD406qLLS+Qvz2HaOGqm42SGyGHp84x8mqXXvSO3jeXv1+qBlqbYVfF5+UXycVK
	 CU9zufMOVu0Qm5B6LpwmJ9Nc1zCZYK/pnGDLuY232NdwXfK4nWV3X5YZb9pMQkx9pGnbBM825y+k
	 7XNIoY8kH2oTjUOibIppId3tpbcXRE3XWcEBzrrx72k16FCdvo/l7Pkc62Ms4TXOv0X5dwLdnZOm
	 9IbmWyFAUO5ROZKhAa+L+LFBf7TiFG2KY+x2JGFSB968hslNPEbujcfdA68WxN4/FZjrIE5Aa+NA
	 UYmND2XspBnVgxRIxjvhVms/4Wmj0GHkSPBPXg6LPJL1atBYaNLzD0cXM7bCBFC0iG8gMWzvaH/s
	 YSxtUIUFKiQu6sqc5JW/fSIvLwWpPP3nhTi8YAmK7DNShk1WnNjWzPaGjtMGhCUYm9tGIj3mcukW
	 Lkw6kvHXC6pVsD8FmFbQ9T+Ya/SiNBbaQ+L2zALXOJaVlXVc8X4JZxUCc6DC51TRC/0CFM+LEui/
	 +piPPD7eqA3OxKUK+7CIIj7BjGj7V2jNL20YSJSb0fYNEriZuC/6XjyhSvC9ZHheCzRB63TAQwAc
	 6fD1ODu5LWxaSq4Zsy839YgzkJRtioa0BMbrsx1+tMVelyipqmOEiTnYFIOCSpUSn7+twC9YShfq
	 TqXRcG
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: kingdix10@qq.com
To: s.shtylyov@omp.ru,
	marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	King Dix <kingdix10@qq.com>
Subject: [PATCH v2] PCI: rcar-ep: Fix the issue of the name parameter when calling devm_request_mem_region
Date: Sun,  5 Jan 2025 13:57:51 +0800
X-OQ-MSGID: <20250105055751.175881-1-kingdix10@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5f8d43fe-25e3-450d-b5c2-2d69b9bc9923@omp.ru>
References: <5f8d43fe-25e3-450d-b5c2-2d69b9bc9923@omp.ru>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: King Dix <kingdix10@qq.com>

When using devm_request_mem_region to request a resource, if the passed
variable is a stack string variable, it will lead to an oops issue when
eecuting the command cat /proc/iomem.

Fix this by replacing outbound_name with the name of the previously
requested resource.

Signed-off-by: King Dix <kingdix10@qq.com>
---
Changes in v2:
  - Fix the code indentation issue.
---
 drivers/pci/controller/pcie-rcar-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index 047e2cef5afc..c5e0d025bc43 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -107,7 +107,7 @@ static int rcar_pcie_parse_outbound_ranges(struct rcar_pcie_endpoint *ep,
 		}
 		if (!devm_request_mem_region(&pdev->dev, res->start,
 					     resource_size(res),
-					     outbound_name)) {
+					     res->name)) {
 			dev_err(pcie->dev, "Cannot request memory region %s.\n",
 				outbound_name);
 			return -EIO;
-- 
2.43.0


