Return-Path: <linux-pci+bounces-10900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B335A93E815
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E528E1C20F28
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E984B15920B;
	Sun, 28 Jul 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blnUJMtM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E11591EE;
	Sun, 28 Jul 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182913; cv=none; b=mrtpT5KvbZfpzmGiz+6YiOQ9+vjkPg+qeZgdWy5Cu/mV/GlSWPOnf/RelIcOcSSfhHrwV4turDi9RwOgENYhoK0OTNLvmL9E4tTNzeQnihfxO9+nWU9a99Q1MGVgvZF1Y7QmdwnrLTjYKgqaCFUTJwtLNLRyslhWcvD+J++OFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182913; c=relaxed/simple;
	bh=8pTFupoM710vqVrajtHFS2NbmEsJ0mgAek5X4ZDyTlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2vkDfaN8ZSdBcTgH0Jf3Ohh6QHEOsN9RFJ1yy/84mjZNMZ3F4L6DIaB+jEaFVpPC9NvPYNM48lsHDRE2+TTRnG5CwRlqDejDhcGc3/6EfCfKkih+URyZB12P2HaP+//+gqHKeH4NPr8zolGqgSeEPMnrpQx/dfZoMvLJV6ooAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blnUJMtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED9FC116B1;
	Sun, 28 Jul 2024 16:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182913;
	bh=8pTFupoM710vqVrajtHFS2NbmEsJ0mgAek5X4ZDyTlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=blnUJMtMrsg7ccVyoVIHrPlktUx+AJ9t2+S3br/zZXBRg1o1Abr91PtzjZVXvEfuU
	 5W9NYC5YYjsw7VxEEtlk1Y34qkcJ8AClmsX1l4wi+urjj7QcZAowYVZLEOfGGMEhlP
	 M7fT+Q5LYJlzHi0hX268pm8wbQWD9tX8VWe0d1J9NCLozXdBOfm+IxRtc0e828ldjF
	 elhLR3hTz9BHL52QPgGP9UY4hIU/AJ2kkrMvfPmQSi/XQO6Y1CxJ2nIOju7qYdqBPJ
	 Al52LyDrL0Rw13x5BSyhOm+qymOlFGkUYamo0AyeJlGWDaV5P83mrx2kdZkUi9/XP3
	 orfZQlTEqOMOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	mahesh@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/15] PCI/AER: Disable AER service on suspend
Date: Sun, 28 Jul 2024 12:07:52 -0400
Message-ID: <20240728160813.2053107-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160813.2053107-1-sashal@kernel.org>
References: <20240728160813.2053107-1-sashal@kernel.org>
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 5afc2f763edc5daae4722ee46fea4e627d01fa90 ]

If the link is powered off during suspend, electrical noise may cause
errors that are logged via AER.  If the AER interrupt is enabled and shares
an IRQ with PME, that causes a spurious wakeup during suspend.

Disable the AER interrupt during suspend to prevent this.  Clear error
status before re-enabling IRQ interrupts during resume so we don't get an
interrupt for errors that occurred during the suspend/resume process.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=209149
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218090
Link: https://lore.kernel.org/r/20240416043225.1462548-2-kai.heng.feng@canonical.com
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
[bhelgaas: drop pci_ancestor_pr3_present() etc, commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 5426f450ce919..1b59e6fc7439d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1384,6 +1384,22 @@ static int aer_probe(struct pcie_device *dev)
 	return 0;
 }
 
+static int aer_suspend(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	aer_disable_rootport(rpc);
+	return 0;
+}
+
+static int aer_resume(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	aer_enable_rootport(rpc);
+	return 0;
+}
+
 /**
  * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
  * @dev: pointer to Root Port, RCEC, or RCiEP
@@ -1455,6 +1471,8 @@ static struct pcie_port_service_driver aerdriver = {
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
+	.suspend	= aer_suspend,
+	.resume		= aer_resume,
 	.remove		= aer_remove,
 };
 
-- 
2.43.0


