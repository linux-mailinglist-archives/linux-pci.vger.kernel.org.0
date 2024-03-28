Return-Path: <linux-pci+bounces-5361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D7B890C74
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 22:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F7728BF67
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 21:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D982E8003F;
	Thu, 28 Mar 2024 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqwhUh/o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3B40869;
	Thu, 28 Mar 2024 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660986; cv=none; b=iujWRabQrDeDuelHGgkM/wrbFZY+TF0FAQdRHdIoiIPVK9EIBNX7jNgBXeo/E49THNxg+0uiU3MRaFuKQbyt5O0Zh9vHlw++ucckRaLsTs7pErhajqAg8uy+wG2C/yCjcRxjTzsj2WHuPptRYRy0P1lf6PBic7jAWuNxdr3y3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660986; c=relaxed/simple;
	bh=6uyEuz7uekBnhha4U4S1CwLDt+blkt9SneZjG9SA4/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yx6GDzqNHFBnGrTbGLtPYSn5FQ8ULSPGArIWnZgbuMk62k7exDY2ROCHzHpssc9SGLOv4jA4GbSapUuQYmNLwdUF8bxNfb7gyV92rq/czK0bVhNc0cnnHMt4Jz159TZ4ADeASZrz/k84Dn8iI43wKdAtauVXWjgemFUSvwmQCbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqwhUh/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63365C433C7;
	Thu, 28 Mar 2024 21:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711660986;
	bh=6uyEuz7uekBnhha4U4S1CwLDt+blkt9SneZjG9SA4/E=;
	h=From:To:Cc:Subject:Date:From;
	b=RqwhUh/odbJ5s8t/G5PqQfAGzXnQj0rGFNJPuNhAkTn6S9mYHa5Tf5aP2rO8UiArc
	 HalAga3kCXTYihP8x2pDaPBGxr48bIdndSFQoTsen0Pi6VBQiASjZ1AzvWWaZSpIC+
	 U0iyzm1tmJHIZ3QvC3ZPuMSy7JUDFt5Stg8+HHGQZpRbhJUsuIUSurJroMZQGoQGp/
	 KSCsi9C0OvMcsIEIlOVwDVLrzXVZknAsEqQUgdnxPQZ6eexutwkjtdCPgwcfuvUaFc
	 T4IDCDR2TObmUF9OIFsIfXkz6nlU1kgB5JEam5dCUb6VIFzz9e2G66Ihx63HpFiZcV
	 kBcHQLOlsV7Vg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Edmund Raile <edmund.raile@proton.me>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] Revert "PCI: Mark LSI FW643 to avoid bus reset"
Date: Thu, 28 Mar 2024 16:23:02 -0500
Message-Id: <20240328212302.1582483-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit 29a43dc130ce65d365a8ea9e1cc4bc51005a353e.

29a43dc130ce ("PCI: Mark LSI FW643 to avoid bus reset") by Edmund was based
on the assumption that the LSI / Agere FW643 has a defect such that it
can't recover after a Secondary Bus Reset (SBR).

But Takashi Sakamoto reported that SBR works fine on this same FW643 device
in an AMD Ryzen 5 2400G system, so apparently there is some other aspect of
Edmund's system that accounts for the issue.

The down side of 29a43dc130ce is that when the FW643 is assigned to a VM,
avoiding the SBR means we leak data out of the VM.

Revert 29a43dc130ce until we figure out a better solution.  In the
meantime, we can use the sysfs "reset_method" interface to restrict the
available reset methods.

Fixes: 29a43dc130ce ("PCI: Mark LSI FW643 to avoid bus reset")
Reported-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20240325012135.36861-1-o-takashi@sakamocchi.jp
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index bf4833221816..eff7f5df08e2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3765,14 +3765,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
 
-/*
- * Apparently the LSI / Agere FW643 can't recover after a Secondary Bus
- * Reset and requires a power-off or suspend/resume and rescan.  Prevent
- * use of that reset.
- */
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5900, quirk_no_bus_reset);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5901, quirk_no_bus_reset);
-
 /*
  * Some TI KeyStone C667X devices do not support bus/hot reset.  The PCIESS
  * automatically disables LTSSM when Secondary Bus Reset is received and
-- 
2.34.1


