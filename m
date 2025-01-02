Return-Path: <linux-pci+bounces-19149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56DC9FF768
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 10:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B946E1603DE
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 09:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2531218CBFE;
	Thu,  2 Jan 2025 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LWirDWJD"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B119D2B2CF;
	Thu,  2 Jan 2025 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735810310; cv=none; b=bLJzidmhi8ZvV3KBOBqQG4oJZrSw4bT6dEBUB+ls9K86OzewvU192mKzzM3YX/Fl5h8efhgoVkIUEF6cnTGsFs2a3oZeTK7y1mkXSKR3cZHc8ouUvFCVo4c86eNOLVs4BxXOvBIjMzraGYpi3XG0rSrgOIu9jklyYfhi0c9kGkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735810310; c=relaxed/simple;
	bh=o33ah91KFLI2Mper54avizBvVCj8nqa9c5exm+Bt0zA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JAQ4r1KSLWTceWgqYvU8fZ0XpexPVWMBEa1Pxzhj0AkCnQZy99poZqvhBVSxvUkpgfgO+heN0txCiGh8vdzlxXaqqAkF1tnCKC4ydbcermtxfB5Bo4vWYYDz5ttaDWkdE8f4ZDz+doJpa7Uo9AEhkEUTA7jVzLn/AA85Nqt/r9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LWirDWJD; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PYNeB
	ZFBpo4ARmEKbqNMtAREcy6y9EU65GWaqlFz5gU=; b=LWirDWJD9Ur1u/0E+SRjz
	wwykGII6NPtBhrsX9spPWt39fil4do+IXVRTIpIBGYKWxkQh1x5m20nRxpHEOtnQ
	HXPVmwhaJF+9IY3NS882oCZy8vPBoCRLNcTg40EimezJDAmxVYtNMZINyXakfy5Q
	WAFmXeQwkSkA4xIl5H379s=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXGp3UXHZncHsFHw--.1414S4;
	Thu, 02 Jan 2025 17:31:16 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jpinto@synopsys.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Fix a double free in __pci_epc_create()
Date: Thu,  2 Jan 2025 17:30:58 +0800
Message-Id: <20250102093058.177866-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXGp3UXHZncHsFHw--.1414S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw15KF48AF4UZrW7tFy7ZFb_yoW3Kwc_Wa
	4UZrW7Wr4UXwn5K34Ygw4xAFWjkwnaqFs3AF1IqFyayF98urZrZw4avFZ8Gr9ru390vryD
	Ca4qyrs8Zw17JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNkucJUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbizR7IC2d2WTdWqwAAsS

The put_device(&epc->dev) call will trigger pci_epc_release() which
frees "epc" so the kfree(epc) on the next line is a double free.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 46c9a5c3ca14..652350f054cf 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -818,7 +818,6 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 
 put_dev:
 	put_device(&epc->dev);
-	kfree(epc);
 
 err_ret:
 	return ERR_PTR(ret);
-- 
2.25.1


