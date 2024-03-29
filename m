Return-Path: <linux-pci+bounces-5409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02921891FFE
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 16:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D36F6B2FF20
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 14:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96851B11DB;
	Fri, 29 Mar 2024 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CO1bvjME"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA81B11D6;
	Fri, 29 Mar 2024 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716580; cv=none; b=boCQU3v/8E3J66MEUdbt5t6pq59PLTk+ipifpX6eaGDmIhhIa9hg9nMxt48PKccD3zsVtbLe2XiteDqr7gd1h6t+GyFLGVSjMMAnt9nxMHJp3O36imD9JBXI77iCMONeu+K40OlRCt+OtqNbxKgtRsUIIVFhoq60X92i4f6ot1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716580; c=relaxed/simple;
	bh=8THCduGIwQ+m+/W/iGE67JZa5hZtwWMwPxdC8E75i6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUSDrLuCc7HKKej+i0XsSx0zt3YJZQUOoCtZ99qowjqY4qqY4MAQwQdQtqA2n+idDjDDJZ0Tskfu/N5EtWldkgDfA6CYLpAasIZq2gdVulEP8RsW4B39C+YNO/gkmRA9X/FFA8lnyoKdbtZSzY3a+hkU1ezJEIwfXoko0fJadM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CO1bvjME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F687C433F1;
	Fri, 29 Mar 2024 12:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716580;
	bh=8THCduGIwQ+m+/W/iGE67JZa5hZtwWMwPxdC8E75i6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CO1bvjMENGLmnTxWEbFEwylffggAseotY3xKqs62KgXgP2PuMWPdTYJ9Ig5uCe+bQ
	 uAS8XcJFeffPIkczHU5sWvs5Fj49c42xhfI3qg4EHimTUsCYhvejw4x1/S1KK/p74X
	 V4mv5BCcR9dT+g0g8FM4ztdFWIHY7i+amLaPedYjlZCWIPrjB7saXTxDJcI/lM795R
	 76M8wQKg91uN3ckczgwVa/PVZlUB3QKFiWJahi7W2pGYb9HHZvNiB4KqOj+yvaqy9w
	 AEk/BTGh5P5sab9HCGC41xjAHalxxAbCps/O77FVGKxlcsWjWHgjM71OzNOCBbmw4Y
	 iu3t6L2YoLKgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edmund Raile <edmund.raile@proton.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 21/31] PCI: Mark LSI FW643 to avoid bus reset
Date: Fri, 29 Mar 2024 08:48:38 -0400
Message-ID: <20240329124903.3093161-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit

From: Edmund Raile <edmund.raile@proton.me>

[ Upstream commit 29a43dc130ce65d365a8ea9e1cc4bc51005a353e ]

Apparently the LSI / Agere FW643 can't recover after a Secondary Bus Reset
and requires a power-off or suspend/resume and rescan.

VFIO resets a device before assigning it to a VM, and the FW643 doesn't
support any other reset methods, so this problem prevented assignment of
FW643 to VMs.

Prevent use of Secondary Bus Reset for this device.

With this change, the FW643 can be assigned to VMs with VFIO.  Note that it
will not be reset, resulting in leaking state between VMs and host.

Link: https://lore.kernel.org/r/20240227131401.17913-1-edmund.raile@proton.me
Signed-off-by: Edmund Raile <edmund.raile@proton.me>
[bhelgaas: commit log, comment]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b67aea8d8f197..99d33902a6154 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3610,6 +3610,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
 
+/*
+ * Apparently the LSI / Agere FW643 can't recover after a Secondary Bus
+ * Reset and requires a power-off or suspend/resume and rescan.  Prevent
+ * use of that reset.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5900, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5901, quirk_no_bus_reset);
+
 /*
  * Some TI KeyStone C667X devices do not support bus/hot reset.  The PCIESS
  * automatically disables LTSSM when Secondary Bus Reset is received and
-- 
2.43.0


