Return-Path: <linux-pci+bounces-10877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBB393E307
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 03:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB0D1F21D94
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 01:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40A719FA7C;
	Sun, 28 Jul 2024 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhxkjs3h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986EB19FA7A;
	Sun, 28 Jul 2024 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128137; cv=none; b=MaE+InkDgyYk2QEl3AMAyQhWZtYE1LIhaH2e0snjrPDxJ0r5InJE62L4cPCx6e6FbMyUYnRNQfNc7AwVBvMsT/yNi0uTF0n+X/97Mw9e7/5fKiCyiQxgxfJDk2igHRwHJN9Ub0O8OLDRA0H+vCsAdoZlvcAPq/q6m9lg7YheviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128137; c=relaxed/simple;
	bh=rCF3ZucRkejgOuzY4Xwh3zsgPoi4aVZ1lY+PQmtOr8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+ZgCpHpW2wvwW57mufQ/LSq8s7GgAc3N/8lYOCng62WCphYlXQcbsEsLsxsHhuNdfBoRCdB1DIwtyMA7XWJvm22rs1adaiwis1ZqUmf9FKxsp5npaoj5rMjDfyrkjVTfgpTyhA5TSnxt4cI3DVqgVeryDFou6QRIhxZ9SRk2wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhxkjs3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C2FC4AF0B;
	Sun, 28 Jul 2024 00:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128137;
	bh=rCF3ZucRkejgOuzY4Xwh3zsgPoi4aVZ1lY+PQmtOr8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vhxkjs3hq0/M5WDpc4quAZjA+2V9q5jg4E8GDaSonYWojDbu2okx8W+Q9CXuhQfHh
	 JbVCTBcaj6EU0kR4wlV31QKEpoysJAtKUInzDsELAWSAGijSO2MR8U7pm/97eSHyFc
	 q7uagFqQJQRhfYAsaApLx+v9SpOAUPlpsyzYM5U6G5o8i69KhzfgEaj2Y0z1i/iluo
	 ujgA5nTKlUW1Zb/+4K1pOij/Nxjfw/UyTiDc4OuHNkeb0yUvgPf2wkJszEiAp4IL9w
	 ZzA5WW1DzNO6wrGn+fo7Z0ZK+J4JzmL6l45m5hOvSUquB3Tqe5fY7HHHf2B7sJx0nY
	 Lbm3RgVlRTIDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/11] PCI: Add Edimax Vendor ID to pci_ids.h
Date: Sat, 27 Jul 2024 20:55:11 -0400
Message-ID: <20240728005522.1731999-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005522.1731999-1-sashal@kernel.org>
References: <20240728005522.1731999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index 2c1371320c295..f680897794fa2 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2109,6 +2109,8 @@
 
 #define PCI_VENDOR_ID_CHELSIO		0x1425
 
+#define PCI_VENDOR_ID_EDIMAX		0x1432
+
 #define PCI_VENDOR_ID_ADLINK		0x144a
 
 #define PCI_VENDOR_ID_SAMSUNG		0x144d
-- 
2.43.0


