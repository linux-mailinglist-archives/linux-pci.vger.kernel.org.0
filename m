Return-Path: <linux-pci+bounces-5411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A51891F06
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 15:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A441F2757A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 14:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6331BEDE7;
	Fri, 29 Mar 2024 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbNdHYo4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DBB1BEDE5;
	Fri, 29 Mar 2024 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716684; cv=none; b=IM4L87IZgWq1hsNPFOhww4nE8YV7TXVTYwHzHegTUWOdZiusTRHC6bCgKQbz5xXljOmOajz3KZxFnhkbss2GqLptfn7VPRBsBEHMc1XZQiCMJtVtXa07wIIklyxeZwv3PypUAFS8R06WduZJP8badTMR7b1cPy2KeyrpUmn55jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716684; c=relaxed/simple;
	bh=X1my/7+7X5B9OA9NnI7yjwSBlsp4CFdaaHUnPmmMCqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9gJbgVwCCCreuP+3+pWq5YhFjYJ4t4hoqLcRcwQn4sfuXf//Qe3U+V7QQAPQFrBjL0y9NLucYlZXP2L4jlbInxJyoFjpiXflS5pPB/Q02TkxHOXgLof50dzDsXM32Q2h/B21AzPQ9dFHsGgAEO4Pkb4Uwol1FDyhOOUOrbos+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbNdHYo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9867C433C7;
	Fri, 29 Mar 2024 12:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716683;
	bh=X1my/7+7X5B9OA9NnI7yjwSBlsp4CFdaaHUnPmmMCqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RbNdHYo4ik+x1TSj0Q5Nc79EdaKDYE7Xm8+/JmT2B3jiTWT1bl+CafOCkCh6d0cwc
	 FU0Ia6aH099Bb/WG0OM75SVZ8Fyce1EEJY5/XhUzrxCILNgEoZRWqyqXH/0YI55qwN
	 95qAOj9xYkkGZLigoYJ855zRUzDz+707KKnDzjiwCBulUe5gz6yEUU6K8ZPAtdHGxK
	 8HAV2dP8XfyMoS3Ke30fh27J6rIMeiXMe4T76HuhM+Q9mo1d/az8aN5QiVNSA82vwQ
	 8kH5UAWFREfi1ESbdgxHoy6V4LJkivirquRcwlqYQELq4LL6SbZDyJmsjhKCsYVM3j
	 6w1tufFfDHlaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edmund Raile <edmund.raile@proton.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 12/19] PCI: Mark LSI FW643 to avoid bus reset
Date: Fri, 29 Mar 2024 08:50:44 -0400
Message-ID: <20240329125100.3094358-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125100.3094358-1-sashal@kernel.org>
References: <20240329125100.3094358-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
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
index 99a8a24ea79dc..132b7cd6805c8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3504,6 +3504,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
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


