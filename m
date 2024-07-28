Return-Path: <linux-pci+bounces-10876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9004193E2D6
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 03:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A354280AA2
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 01:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A390195FF1;
	Sun, 28 Jul 2024 00:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6N9dBYX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505B5195FE6;
	Sun, 28 Jul 2024 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128100; cv=none; b=sN8OSB/Ep20jnSxrTfNqFBb1CgT+7uxoJ+09bGz8VOafv7yp67vHSWKKoa1Q4FtF3rQpdo0nOp2UXwnOEUjMsDiZm/QL9NnSroxpwfARDet6+pUxBUYr6qgfPTv480DqsTSetxTnbGWVgvQpViXzR1eYzwyT3ac6oVsyQ1/6dVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128100; c=relaxed/simple;
	bh=59tGfE22YawSwu4bIbk8Qrq7OcpzD5ok3JODljbRomM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcI4zsZEIQvZQwFnMyMds7BXZWXcvdOo/tZPdVbyHpym1MFzM9j5+73LuTeTCy/LYbLvMR2EQYDlttEnZXdP9WQh5Sg/745CQGDldg+37LUSyWuJPzdSCfpmfxFTpYj290eCRyMHM09BxX9lcis8TBv2VNRUWH7UhoWm/y0VS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6N9dBYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FB2C4AF0E;
	Sun, 28 Jul 2024 00:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128099;
	bh=59tGfE22YawSwu4bIbk8Qrq7OcpzD5ok3JODljbRomM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6N9dBYXz2boojYd9xLS0tOrEwoXjhP2h+q0J2yU2VW1HR9h34ADuz+lQA4PEdJ8N
	 /wi8TjZHBpMkiBjhuDbcu7JUkeA2Fji7AltpHZWyFXtQIR1MaA2VrrFGLadkb/On4c
	 GbIB8wgwz/KhwMBD0rKH2Lo9nMBFb3Gurs+frh2324RnZzwyZMEPAEBaZ8VR2T9huK
	 lDB0AQImCTqnFyjWOMhJWrt9iULhqwJK6Ef3Nfvy0ylFO3IVRZPm5hMVjF6N5GGvF0
	 ro/y+R+gCZ227nTgvkyUzwl7f4k541JUhMTMBATeSnqZpbip3cnOonEd5gW8JFHA9S
	 44DiaKtDY7dYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/15] PCI: Add Edimax Vendor ID to pci_ids.h
Date: Sat, 27 Jul 2024 20:54:28 -0400
Message-ID: <20240728005442.1729384-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005442.1729384-1-sashal@kernel.org>
References: <20240728005442.1729384-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 0a85ff5c8db3c..abff4e3b6a58b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2124,6 +2124,8 @@
 
 #define PCI_VENDOR_ID_CHELSIO		0x1425
 
+#define PCI_VENDOR_ID_EDIMAX		0x1432
+
 #define PCI_VENDOR_ID_ADLINK		0x144a
 
 #define PCI_VENDOR_ID_SAMSUNG		0x144d
-- 
2.43.0


