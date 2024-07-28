Return-Path: <linux-pci+bounces-10879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4B093E335
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 03:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D31AB2432F
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 01:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2FB1A38DF;
	Sun, 28 Jul 2024 00:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S39KO+p8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED31A38DC;
	Sun, 28 Jul 2024 00:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128174; cv=none; b=nJ3T6T3Swq6VZZDA1jJCT46eCrmxDXO3j00ZgTf40q9N7B2+jTk23GYV1hdMkLCL12JIN+118dQpLu/4m/Q68Pze8UFdbihnOrxjuH83X/ovmLfgDCJUaEbm6ZKvYMyFGE8sXebaVq1W3HVPYPOEDgEjGLtyG70WZx0Sr3WHi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128174; c=relaxed/simple;
	bh=Ef22SrYGOyj0ub67bkMV0ZFTXX3vVHUn8GWa3x+MGnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+IEH7Tk0cD+2+AqWj6wYlVfChCcZGDQOwWgd6ROwWyz1l+gTTz2pxqx8PzSv7RUTO68XNJteYE7BV+467m42oJ4cpHuwZrnwFVRk66yOmiHzJozkLmXPuBuFrgC/6VUOuUWH2Ob+DdS1o0rl/Lvb9pEA8JmYTCBlbvtjzVICHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S39KO+p8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAB2C4AF0B;
	Sun, 28 Jul 2024 00:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128174;
	bh=Ef22SrYGOyj0ub67bkMV0ZFTXX3vVHUn8GWa3x+MGnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S39KO+p82RBLDcIlFlN9QbISM4OQ3SNJhi2NiDFQbsIBUNOU/kcYs7K7jvsbyrIAY
	 nkpr1gKaYkkrfyS/kZJMCVDX0G39oZ/j+cRCiZ94DXYtbfayH0E4DasLDTBo7Y0WUv
	 H/duD3nSYhdj7NtLZ0iayXWrREr19eoB+f0nh5T1bDwRNvTTKGxFgK0KXRAT8K1uHn
	 DyAbcOLwz4urGSV6B7zRUCO6F/YbmPpz3gVWw4QbCaN4GnhZcajtc/vp3JmGy//Mvx
	 +w3TeiUO04dqcZTQD+gmymul+LM++gWKbetlRaR6Gnd3aKQ4PvPQzxSd5hPGtArpvW
	 WyeLLtEvaU/gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/6] PCI: Add Edimax Vendor ID to pci_ids.h
Date: Sat, 27 Jul 2024 20:56:00 -0400
Message-ID: <20240728005606.1735387-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005606.1735387-1-sashal@kernel.org>
References: <20240728005606.1735387-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

[ Upstream commit eee5528890d54b22b46f833002355a5ee94c3bb4 ]

Add the Edimax Vendor ID (0x1432) for an ethernet driver for Tehuti
Networks TN40xx chips. This ID can be used for Realtek 8180 and Ralink
rt28xx wireless drivers.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20240623235507.108147-2-fujita.tomonori@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 80744a7b5e333..b2418bfda4a98 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2137,6 +2137,8 @@
 
 #define PCI_VENDOR_ID_CHELSIO		0x1425
 
+#define PCI_VENDOR_ID_EDIMAX		0x1432
+
 #define PCI_VENDOR_ID_ADLINK		0x144a
 
 #define PCI_VENDOR_ID_SAMSUNG		0x144d
-- 
2.43.0


