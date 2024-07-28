Return-Path: <linux-pci+bounces-10912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDFA93E869
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4071C21785
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAF918F2FB;
	Sun, 28 Jul 2024 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVjP2bDn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C8018F2F6;
	Sun, 28 Jul 2024 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722183016; cv=none; b=oFJGJw8hqQN3ebjypk1DJtcuOicyzrdZOMmSY2ZiBDgFMll8ouv659GDYiT0olZoNIAaGCePlAQkbbBf8RYYLffVDIEeapwim6QSWHpCP1lAp0z5DD/I3A8tU6DyLH7NkfwRU+ciEoWNqOd054ou63VKdkDYLd1WcXwDAceQ8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722183016; c=relaxed/simple;
	bh=Mbi6RhR6aJ+6JApKJEYaRlVBNaqkSekKs3pFS5l7UzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xl3LyPiGhcIEn0TmZ2yTdGhonQgiARL68F2Sot7SXazU/MNz4f05yVe+TkjJ3nqkkd0LZ+oQRWpi4/uR+7rCWHsRUdN5linDYWc1LYGMVIh7vnl3pcoR3uzZrnfg5osz24gc5D/JwBMGSFzFxsWi4/qluH46mpqogbkiUCco2mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVjP2bDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBB8C32782;
	Sun, 28 Jul 2024 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722183016;
	bh=Mbi6RhR6aJ+6JApKJEYaRlVBNaqkSekKs3pFS5l7UzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UVjP2bDnVIC0LyT2VvWKkUm9JkJDGx1rXYg2kWFkvzSK7QOE3N6wm4xHETHCXTAyJ
	 z4tSjZKL9rGO+QQqmawl+ToUytdgH/nOOg47FFrq06U43L87FmFkEJYGQjUIAIH6A3
	 ZtZtnGQHV8VZAH2cC+JtGsiKUX6MUqQj+a0rE67XEkVifQ2MJhADjQ/JQb5amgcDwS
	 uQU/d45ACUmQX7nty8f3/jw54+SLwELzK+SoMa9F7zanZLPDl83jtyLFfWP6pXHOxx
	 IT6CWhA8WBrfCTtZE1CpsSsWYOIjZUUjm/kCOtfgLC8G2wve5WGT2hYx8rr6OAyTqX
	 3zLiWEJu+mt3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	mahesh@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 08/11] PCI/AER: Disable AER service on suspend
Date: Sun, 28 Jul 2024 12:09:41 -0400
Message-ID: <20240728160954.2054068-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160954.2054068-1-sashal@kernel.org>
References: <20240728160954.2054068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index d58b02237075c..974d56644973f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1373,6 +1373,22 @@ static int aer_probe(struct pcie_device *dev)
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
  * aer_root_reset - reset Root Port hierarchy or RCEC
  * @dev: pointer to Root Port or RCEC
@@ -1431,6 +1447,8 @@ static struct pcie_port_service_driver aerdriver = {
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
+	.suspend	= aer_suspend,
+	.resume		= aer_resume,
 	.remove		= aer_remove,
 };
 
-- 
2.43.0


