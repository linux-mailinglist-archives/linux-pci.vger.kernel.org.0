Return-Path: <linux-pci+bounces-8932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3D190DDD1
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 22:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF8F285A3D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 20:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB66617B50E;
	Tue, 18 Jun 2024 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1HaqRJP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98D017D89D;
	Tue, 18 Jun 2024 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743794; cv=none; b=fOOhHcKDAwB3mArmvycD/EHn45c2HfasWg7bEWGF5ITRS8BOtq5Qam/1UBZFgCq4jFCTPyrgXG70nxHhHKIVre5RgRw+DCvgCdJBsex68Kyu/Ev3gAgAHUUMzi2tRe8jB09m2lH9uIx8xYhk5NR0V3Z59PWG4gxbIVER9jruynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743794; c=relaxed/simple;
	bh=JHzSKxuAUt5sskKJDUz7UVvUr/rjQm56XYg7g79WgHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=in8EN7CSnSTz0Nbp2e7OVrloGMIg37QhV/ymg5IWAgjyR9oeRKJz9KnSzjI4WTKqysOPPluLoXBDKHPDI1WR/KilXVyMp2thpGwmFA1QwgC0IJGP72BlKCblQZg/F3xcJiV97+aFNYAslFE2LXr8BoO3vgh2N7vFxaksscl4Sss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1HaqRJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049C7C32786;
	Tue, 18 Jun 2024 20:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718743794;
	bh=JHzSKxuAUt5sskKJDUz7UVvUr/rjQm56XYg7g79WgHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1HaqRJPzz0zJSG/rrBID1OFWnkvPyXQUHG+2hFSO5FynGak2I85FGd3Iw+wsZPTK
	 rTgSR9XE2n4Uft8hL0UMAfhPVKYDZkcaVAIcBRM0W1sEzYD8FZ3Bo+lZF2RRGn4L4F
	 /xC2B7x5WEaF22/wfFgIhMXWxjiRWxCfjH7iVJDFiENoWSRCrMbkshsxk1QBnJHq8u
	 1Gt+UxrkNlyAulGCl0fTJ1BL+L+bPpzfNrO0xq8iJC3hEP1Z1ddHLUukq9IrXB+G8c
	 2YiEdaYr1dvxeaLJIVU1fUXSicM3+dJ1o/084SxMmFybN3tLXBfvV2ae5tSRfq7Axn
	 9FcmsnYLNW7Xg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Thomas Crider <gloriouseggroll@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-nvme@lists.infradead.org,
	regressions@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v9 1/2] PCI/AER: Disable AER service on suspend
Date: Tue, 18 Jun 2024 15:49:45 -0500
Message-Id: <20240618204946.1271042-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618204946.1271042-1-helgaas@kernel.org>
References: <20240618204946.1271042-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

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
---
 drivers/pci/pcie/aer.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ac6293c24976..13b8586924ea 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1497,6 +1497,22 @@ static int aer_probe(struct pcie_device *dev)
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
@@ -1561,6 +1577,8 @@ static struct pcie_port_service_driver aerdriver = {
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
+	.suspend	= aer_suspend,
+	.resume		= aer_resume,
 	.remove		= aer_remove,
 };
 
-- 
2.34.1


