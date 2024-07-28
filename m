Return-Path: <linux-pci+bounces-10880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EDB93E348
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 03:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AEA31C21342
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 01:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30C11AAE28;
	Sun, 28 Jul 2024 00:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yze8tDbo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96B41AAE24;
	Sun, 28 Jul 2024 00:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128191; cv=none; b=D1YtpEPHHyXrJD8z9GNOV5UR/NqJ+MIZ9BKJMWfiAXIb2ZCn4564OZ4ZRaBxpVD3GQuZhanjxDK7RdV4vo3fXku1nXS9K68kEO7A8cbwnWijWhaHiYpI2PCFjMNKRuBT3aHbmOdlU3wx7Jix0z7xJNyct/ExXfV+dI3wWI8R5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128191; c=relaxed/simple;
	bh=0rcmY79FtDNPnNWCwL5bjtlpLytwi8+JdwfV9ggHtl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1TfAxE9S2w0DCAGi8Cw6ciL1Tc6ERfmjd4mUaTZpknIykQ00dGmIv/WDptBTW/lIM2V5tTdN02k7A/MLX2feDHy2HGYsVt7z4zut37pYCnEWl5wD+G5dVdoUjbfF1cSeuNVHsBAbgsn4Aebla7+I+wxXYZMW6JDVUOCQ0eldVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yze8tDbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EB4C32781;
	Sun, 28 Jul 2024 00:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128191;
	bh=0rcmY79FtDNPnNWCwL5bjtlpLytwi8+JdwfV9ggHtl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yze8tDbowbCW2ZqbB962EOEtPUooWF0sKDz7ytsUII7NHDp72ix6ocOBRLj75QVrZ
	 +PqCy6BlAyr0X2SEHSlsfrsPSobpMARhBE2BH0e4Wz9ozTFIAI4OkXTD8A81+r3wGj
	 gS71GfeLykPjcYBoU0IQ+ER3gtvlLnIoTLsq1acenxYtSwUSPm3Bd8B4hvYsue+2BT
	 GB1R/1+ZrIBaCiWQIw6q0JfDxK/8Q4eGezokG9WzIN6bAyu4HeYF3+75Zx9rPgflJI
	 5rleH+eKgdr5cnut5/4flWgG3QJDrv9R4mFsKHtFQ3bLzZlBGmYcDwSm3neB1QeH22
	 avuWkWA+890CA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/6] PCI: Add Edimax Vendor ID to pci_ids.h
Date: Sat, 27 Jul 2024 20:56:16 -0400
Message-ID: <20240728005622.1736526-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005622.1736526-1-sashal@kernel.org>
References: <20240728005622.1736526-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index d8b188643a875..bf8548fbdf558 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2136,6 +2136,8 @@
 
 #define PCI_VENDOR_ID_CHELSIO		0x1425
 
+#define PCI_VENDOR_ID_EDIMAX		0x1432
+
 #define PCI_VENDOR_ID_ADLINK		0x144a
 
 #define PCI_VENDOR_ID_SAMSUNG		0x144d
-- 
2.43.0


