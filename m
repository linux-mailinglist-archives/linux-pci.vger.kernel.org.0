Return-Path: <linux-pci+bounces-10878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD1293E323
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 03:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797E1B23822
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 01:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CF61A0AF3;
	Sun, 28 Jul 2024 00:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7jekoSr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC46144D3B;
	Sun, 28 Jul 2024 00:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128158; cv=none; b=J6etfFpFnajAIq+ENNEXyHcbSiylBTWWGU25wGXwZMK1AWRmulAHlOGUfURgTylMiNElaBhOjE+oy/xS311DaDuzdnNyIPW9siUn5aNXBJN4cWW9GwoXGvSuh0kvVT/LzDPDOYRhUPwcFaaM3PlhtRy3TLtaDfkoVvAetPYykjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128158; c=relaxed/simple;
	bh=9XdjIhhCHp4Fs2reZyTtD/5PXktI2IbKTKMS0PteLTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbtiIgg1/m87cbdRn69KJZYa9JUPsX5wNBFhLQts63AvbyuvNvbrKfMhpkuj425V7KPCBo1DaF/O1SClMC3WlXeTP14oXC11wkrjPbBJQVUM8be9mjwHNqD2qJXBuAfwW2ubGzNvf6DJ2ETcP4jR/OjFUxKVkMjRumASGiqz1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7jekoSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F348EC32781;
	Sun, 28 Jul 2024 00:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128158;
	bh=9XdjIhhCHp4Fs2reZyTtD/5PXktI2IbKTKMS0PteLTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7jekoSrEh57z4PqXWfhGhfHadvG45Loh+WKkADSgMBovVrRauTfUxsTZxJu/05Ni
	 RPqGusSr4aqaoWdLaxHaQPQ3XK/XdFgSF/MoXsRH8cO9KqyzwmcDBBZ57TcIFJcQea
	 F4yL5hSX7bYDIh5+1mfatRTsD5fGcE/Mq/jAB/6T6t38BUfXezHulgpg7cIcEt/dJT
	 sHINIIPln/GjGdfasZA6oSMhFV4r1NCG+uXSn/kgQloeLFNpnbgFzCsGZwr/bQ/j8C
	 YdTBcKAM3xi+EL7z3zWXJjP++hhB7wpODaQXChiXzg2voFjWSnBKZurloA3GA7PNrE
	 wlWwW3cTFJEwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/6] PCI: Add Edimax Vendor ID to pci_ids.h
Date: Sat, 27 Jul 2024 20:55:44 -0400
Message-ID: <20240728005549.1734443-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005549.1734443-1-sashal@kernel.org>
References: <20240728005549.1734443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 2590ccda29ab9..66e95df2e6867 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2113,6 +2113,8 @@
 
 #define PCI_VENDOR_ID_CHELSIO		0x1425
 
+#define PCI_VENDOR_ID_EDIMAX		0x1432
+
 #define PCI_VENDOR_ID_ADLINK		0x144a
 
 #define PCI_VENDOR_ID_SAMSUNG		0x144d
-- 
2.43.0


