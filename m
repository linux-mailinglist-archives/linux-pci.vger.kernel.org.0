Return-Path: <linux-pci+bounces-5405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40827891E06
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 15:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55329B2F5C3
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 14:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E0F1C68A7;
	Fri, 29 Mar 2024 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxmYgiOD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690691C68A5;
	Fri, 29 Mar 2024 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716308; cv=none; b=flkNocJGzA1YdgRm72FOy7V6Rova8SQ5YxNbXzfG3Sh5149S9yPIKPdsI4HE6HcNPlk/eZVbN8SMQcYw8C/bkFiPRi0kOLnFofbi8vQPNFoCTVO9XZkF98JnKLdjBQV3xxJUkaTQRn8EXEyuAOrBp/j8n5iN/FAezXGL9e06Bvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716308; c=relaxed/simple;
	bh=MNK7HuWoOXNVT4BfoeYZQGbxdA+Bd16yswGD6fUDbyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYu4Xip30PmNWiq1vS7w/E94Wny9VYkYgh2eVfS3aidICft4n5+3Jq0NbZABaQU3rsrj9Nn1T/tGiNc0Qqe6RiIOfluPRcQnR2rnXDVNfIICK62NUZgaV3nYjgOCyujTUKGG8Yjub3dVxoQOWGM+8fs2iY2AyUs0xaauw4B+v1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxmYgiOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9411FC43609;
	Fri, 29 Mar 2024 12:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716308;
	bh=MNK7HuWoOXNVT4BfoeYZQGbxdA+Bd16yswGD6fUDbyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxmYgiODu2zB8VbXShVv1M8azTJjzBpzLsSaPvF6TfubHK5gh2ELt7VDKGj8jE4np
	 uiKwd9abkShYTnIsMJ0lonxa9ee6eVEypR0Zb+nawrNpflHck01jHCiAB89tQJf6FH
	 4yFPJkGSv66tPqT55CUkUi5GY5uH9Z9y3bqUlDGssfGRqLgLSTzb1Mke1hGGNhvCH5
	 o8MCNPHToL84xhA2Hx+s3pvmryPOpMQpf4WJvWF9SmJ5V0BTan2ZlOq69pk3rEvdPe
	 Q9A0PnPIQg7PDoZNDyTjs3frBF0QnJ9Bi4vsFtt7uyUHhfu/zzq7n2THTQVt6zQ3Ua
	 0aaxet59bLiSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edmund Raile <edmund.raile@proton.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 52/75] PCI: Mark LSI FW643 to avoid bus reset
Date: Fri, 29 Mar 2024 08:42:33 -0400
Message-ID: <20240329124330.3089520-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index b5b96d2a9f4ba..687f9b00b3057 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3758,6 +3758,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
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


