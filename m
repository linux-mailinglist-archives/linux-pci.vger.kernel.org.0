Return-Path: <linux-pci+bounces-29184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4520EAD169E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 04:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073E7188A16D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 02:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1278317F4F6;
	Mon,  9 Jun 2025 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nP8bPIE5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8217D346
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 02:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749434550; cv=none; b=rVNvzSjcGqCPOOvE4kwulzTkZ0Psd6151daTWkSO3MsxGuKf9DCKMI+DQmUezGxiKa/s/v13zfq45tz1jjx4xnX5hiBr/JZjJbfAiUGFzoqLAPrEYuXjAJdK9PigeaPS7RcFrMF87fG9KUvUqv6YZ+UmHT3mF0GfUT+B6w7Djtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749434550; c=relaxed/simple;
	bh=sODM0sgcTmf0q3pCfBBBQ3Z4sJiyGddOs7xRMPvE1xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8hczm/U2395+TuGXQAFsoX4Tr1H5aYpE5BhGem+IDUke3+PbrWXwYFUn0PzHAgwWc+R2tQtxihcBzGSMWfV3KKtBVhBBgffkKb2b/hcQCsFOD5K1GaL3b+8SxWbd53jhWg9o4ROiP/8sq6LmlLIq6zM2LnpndOGOJ/olUZYLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nP8bPIE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221D2C4CEEE;
	Mon,  9 Jun 2025 02:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749434549;
	bh=sODM0sgcTmf0q3pCfBBBQ3Z4sJiyGddOs7xRMPvE1xM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nP8bPIE5/WqoLeOmlOXuzzpBpzqG0QCeK33zJALME0nzfISohz1rbjOdWbVkudblL
	 72T9/e1vwk8b5V/J0roSoS8RcxU3A8LpwjPokkyYJ/fGRJxIOOGz/5jDhpRC5oSYlA
	 UV5AG1UAUYdPuHip9WdkQWPcc1m46zQqnx3pUnlTAV8u3fzTHHpfl8eaddXNEqgTNq
	 kSYqIjIY6KsglUMEO1IMimvsc+W3LAXQ7SzwJKH2CiXafoPbhepj92nm2k/BJOa6vz
	 tqyU1dkGiBu465rHlROitOnqbmXoDmUlXaIG9s6hFfdq+nTY8AwCm3tDlEKglygnn4
	 rYm0nY5FWsWvQ==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 2/4] PCI: Fix runtime PM usage count underflow
Date: Sun,  8 Jun 2025 20:58:02 -0500
Message-ID: <20250609020223.269407-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609020223.269407-1-superm1@kernel.org>
References: <20250609020223.269407-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When a USB4 dock is unplugged the PCIe bridge it's connected to will
remove issue a "Link Down" and "Card not detected event". The PCI core
will treat this as a surprise hotplug event and unconfigure all downstream
devices. This involves setting the device error state to
`pci_channel_io_perm_failure`.

When PCI core gets to the point that the device is removed using
pci_device_remove() the runtime count has already been decremented and
so calling pm_runtime_put_sync() will cause an underflow.

Detect the device is in the error state and skip the call for this cleanup
path.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci-driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 9f6e145d93d62..ab4cfdfc8fbc0 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -479,7 +479,8 @@ static void pci_device_remove(struct device *dev)
 	pci_iov_remove(pci_dev);
 
 	/* Undo the runtime PM settings in local_pci_probe() */
-	pm_runtime_put_sync(dev);
+	if (pci_dev->error_state != pci_channel_io_perm_failure)
+		pm_runtime_put_sync(dev);
 
 	/*
 	 * If the device is still on, set the power state as "unknown",
-- 
2.43.0


