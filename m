Return-Path: <linux-pci+bounces-32534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE2CB0A55F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 15:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2F33BA418
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D896137750;
	Fri, 18 Jul 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zf5ayih3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094892AD2F
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752846120; cv=none; b=lijILdEVAqbGjq0Co3mXHbcBlPNzSebQ3QPX3PNJ7DHddsQcnNopsG4dpNZjwD4ujhRjgVnu8GiJrloopaH1ppSFPJkETowzaX8V7bl5i0vpxujI20aEsm/J8O5sZOV+LkBpic/DVqt4IoOcQL98RdF2BjkwD9USM2MY1ByW7I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752846120; c=relaxed/simple;
	bh=agRi3M3zIiMHudWVKFgNUsYzY+TzqBpPSsm8Pa3LtqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BM3e4kgk9iblCcjZ/LUcHBCoekC9ZkU0yFa93zzdkq/pYP54J59xGwUGNhLN0HZm1tRS/C/SD36bGWzbC1OlV2/vwn5A2unUZl5GEvYHjkctI7khxZDtGIR8Q/KCAuXxDSpjJIwo5kbYkAgcWs51jQlvRCaJt637PZ3GS05DMK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zf5ayih3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661FEC4CEEB;
	Fri, 18 Jul 2025 13:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752846119;
	bh=agRi3M3zIiMHudWVKFgNUsYzY+TzqBpPSsm8Pa3LtqA=;
	h=From:To:Cc:Subject:Date:From;
	b=Zf5ayih3U7dhFtQ/yCjeeyOCb+eedoIeI1DaglvyTEMpYTGOfGNrz5ztRqk88V2yI
	 g9hCklk6wiIG3LDHj8SheiD4z9/UBIrKpvKyPZlUF00agkisQkDdA8MBKukEZyETOp
	 4/q7YPisO6Tz/fkZdmc9MdYF+em+cz6UCnmHzDBh8KxDgm8y62Y6hy36flqoCLlAwi
	 LHOmRG5eFMGM9mHZo+ViykkWm0wr/P16NXY3P17+UufelljbM8AaJtgoKf7KRQVWNo
	 QdpbjS8o/AKc7OkeXlbYEy1yRwtzaOM/M0r88+DGg/mhOwKuQmvSk+Dgj1IlST6Fx8
	 SjiTDHl/QU0Bw==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Fix warning without CONFIG_VIDEO
Date: Fri, 18 Jul 2025 08:41:33 -0500
Message-ID: <20250718134134.1710578-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When compiled without CONFIG_VIDEO pci_create_boot_display_file() will
never create a sysfs file for boot_display. Guard the sysfs file
declaration against CONFIG_VIDEO.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250718224118.5b3f22b0@canb.auug.org.au/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6b1a0ae254d3a..f6540a72204d3 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -680,12 +680,14 @@ const struct attribute_group *pcibus_groups[] = {
 	NULL,
 };
 
+#ifdef CONFIG_VIDEO
 static ssize_t boot_display_show(struct device *dev, struct device_attribute *attr,
 				 char *buf)
 {
 	return sysfs_emit(buf, "1\n");
 }
 static DEVICE_ATTR_RO(boot_display);
+#endif /* CONFIG_VIDEO */
 
 static ssize_t boot_vga_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
-- 
2.43.0


