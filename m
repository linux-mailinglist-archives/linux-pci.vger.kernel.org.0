Return-Path: <linux-pci+bounces-10875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7990693E28B
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 03:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9F01C20372
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 01:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6937E824B3;
	Sun, 28 Jul 2024 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaGffoD6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5382498;
	Sun, 28 Jul 2024 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128047; cv=none; b=qioq+vQAUf9W5JjvnvYx+XIe5p2DmSOJ+at5BmgENBcaUsKNcQAGraxyQPeZOV+akUY68+wbQMZ5byAKyeVAOkYyVrmydm4Othp6qsGSvs2hZUTfa2986LChr46OnO+6ehMPDDTGAKzMOpO9INkrAD5U4MkjWlWPeCd6gfootQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128047; c=relaxed/simple;
	bh=3byeUw1tP7C75gGuipgS58h1R3RGy34qL20vqepN2FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K14f5dmUVj+0b5jclEaz94QPY7ryuQHnokHOBi+CnI3Sd2E2uVGQ+Xxuf7i2s0hdkeowRacrJgnV2/sMqchcwIB9vehSpdAvfHOU/iEKGpadzU0e/P418JfMiepDppiVP3HiglBPH5YQSG0uUAOILY3Fe3khPEpFsIULGJ8qhgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaGffoD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39334C4AF09;
	Sun, 28 Jul 2024 00:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128047;
	bh=3byeUw1tP7C75gGuipgS58h1R3RGy34qL20vqepN2FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UaGffoD6j0SmXTbOXp/gFhwtIzb7ze2/OaKDHabbIwy1e/qHtTEWJIS30gjdkZWDp
	 72knUaNZgbLOADMkkclSDQBxZMOMPC/XgkUFvGO2WuACV/gpKTk4H4sz2gFgD1bUS+
	 I9FeRx5dt0iOclJJXV5PzVB3dgS3E9WOTdaQaQi+SwYQactw3SgsIw4c7g5A5XwNwz
	 le1CmQRIv26IwKaIFDCbBVnPDeL5zYuJwOMmeBbgoo0TjMRxfQsr+TPzoTlG/m8Yac
	 aQTWyE5sGdseY8rMENppoowJsUFK/qtsjXsXO8eL607RAN4cOtOZcxKR84iNYsz/yx
	 G4eTMWac/0THg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 12/27] PCI: Add Edimax Vendor ID to pci_ids.h
Date: Sat, 27 Jul 2024 20:52:55 -0400
Message-ID: <20240728005329.1723272-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 942a587bb97e3..677aea20d3e11 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2126,6 +2126,8 @@
 
 #define PCI_VENDOR_ID_CHELSIO		0x1425
 
+#define PCI_VENDOR_ID_EDIMAX		0x1432
+
 #define PCI_VENDOR_ID_ADLINK		0x144a
 
 #define PCI_VENDOR_ID_SAMSUNG		0x144d
-- 
2.43.0


