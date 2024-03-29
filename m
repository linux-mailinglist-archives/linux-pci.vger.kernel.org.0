Return-Path: <linux-pci+bounces-5407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE621891DC4
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 15:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF12A1C27CC6
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 14:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16813165C0;
	Fri, 29 Mar 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/xiYUB5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A772E14C580;
	Fri, 29 Mar 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716427; cv=none; b=HIdU7hJxThAkvaJJT4GXDy726Ztujpoy7IcnJlDLdHURbyONmp4V6A5o5pIEVbiGgxEjshPptGvhklj48nxoe26GVNNmBsVSPwPLXp602vvuzgA6n+Yn4Tf5Kua8Q8dlE+k7mn7OsKZ5Zp2fn8D5ZnkprNxeupcf2bpYg31vx1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716427; c=relaxed/simple;
	bh=3ltKAP+Cgy7PTZG6vBDKVQLPkdWTOdneISLREIlq3Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmqT8yC06NFzEbchQ8NIb8/GH4eG14Ra3FPsCs0QHzp7gyQAI6CbAg4ZkPSa0WdXU5a9AhaEoxx3Vi6nMVIe9EygT8+WsRO263hfCLG2vlJeMMkVT6DMEsp7SoApVmF2isjMAfDErEyCf5CvsFpYGg5Oss0aJDjTCUFO+gOSMC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/xiYUB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE1DC43609;
	Fri, 29 Mar 2024 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716427;
	bh=3ltKAP+Cgy7PTZG6vBDKVQLPkdWTOdneISLREIlq3Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/xiYUB5s/JORz5PjqJTS55UmSvQAiIDoIEkGYXAlTl+sPUXSnerrMIbwYGUyJr6m
	 exAfya1ERbpR9sMBuxSMxiCgsEaQRgGk9DcOqNPzZ7wazh5MS5q+SB+gAWo+1L4owz
	 Ypne7GYQbYJv6dCoby9e+c4EaFbNRHRRugGOSjGE3+w2RbThwRS0AoNaVygvh+6rcV
	 VvPXhLIHLA3KHAxxf0tZEJuPKcj8bRPtZSzb6KzCPfN/bbmvm8YA6fJWDyV5+eG9et
	 vit34ACrapLmOfmTjU8254kXD0ZEQWR+ks8YMdFCBcUcxqXlva45vSkgtj6U6pWuZn
	 4jNjcPunxfdtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edmund Raile <edmund.raile@proton.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 33/52] PCI: Mark LSI FW643 to avoid bus reset
Date: Fri, 29 Mar 2024 08:45:27 -0400
Message-ID: <20240329124605.3091273-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 51d634fbdfb8e..9090da46213b5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3663,6 +3663,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
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


