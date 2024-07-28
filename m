Return-Path: <linux-pci+bounces-10916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5BC93E87F
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6715CB2269E
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A863219047D;
	Sun, 28 Jul 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYCbOvKF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794DE19047A;
	Sun, 28 Jul 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722183043; cv=none; b=AFIUuI749VKVefaEelDSxHCc+05Etz4xBce3ro0BF9dJ4b2iu7RTZ7waKA/KzJKwBG5SBtKDCevjwL9R+A8DN8hQU2AzoAH0hnyiwqy4a2ltrWnZcoNhtafYjzUzpO9VxBjG4Y7yQKmatxjEvtNYmQH5PjRfWKgZXQEo1svKYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722183043; c=relaxed/simple;
	bh=vn66BbcHqOBfybRR+KiMPzhueZa+Csk42gnPhnH454Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4htatGq6U5J2hUNvP8zBxsOI7gAuGKx4KFuLwpHApLP9DGruHFwBrGMHpRdasT/Isttx0BRBtkCi4I708w5MtZdauEUDtTZ/JcN2Nx+k4S61I4507pt+JN9ZWAA/ksYhKitbCAIXnthWv3w0c2M/AVClLeAI1lsXGHMnH0/naA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYCbOvKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ADBC4AF0F;
	Sun, 28 Jul 2024 16:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722183043;
	bh=vn66BbcHqOBfybRR+KiMPzhueZa+Csk42gnPhnH454Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYCbOvKF3nkvSCwX8b+JcQnfveEFUdBmD1enlSeu3IYUCeJTKprTd4tjX/8tnDDse
	 vpFnfXKCGRQ5ApXm4mXc+kEgQ+oBwaM+kng4Juh22W7F2NYtI7nCIM0rNtR2e6lHAm
	 5NYwPKEn+AurpzsJYnCFHKmY+zsvB9mWJaVRVDKQ5i405ycIL5GyZ+sD7+4XoiZH3D
	 Kyoiefw7FcJgo0hl6GfnNR3GY8xnkFxzMDSRTJkkpl2Q74KaQRt20NCA33MapAMc8u
	 huzo/RRiIf9/WYwzs7QcC1bbWRMGXYxRmxueYz9qocgqYIKWJ1hUBf5hFs9AmUur6Z
	 yxeq0KIluKNlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	mahesh@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 4/7] PCI/AER: Disable AER service on suspend
Date: Sun, 28 Jul 2024 12:10:24 -0400
Message-ID: <20240728161033.2054341-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728161033.2054341-1-sashal@kernel.org>
References: <20240728161033.2054341-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index 6b5c9f7916fac..ee38ca162a7c8 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1407,6 +1407,22 @@ static int aer_probe(struct pcie_device *dev)
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
  * aer_root_reset - reset link on Root Port
  * @dev: pointer to Root Port's pci_dev data structure
@@ -1447,6 +1463,8 @@ static struct pcie_port_service_driver aerdriver = {
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
+	.suspend	= aer_suspend,
+	.resume		= aer_resume,
 	.remove		= aer_remove,
 	.reset_link	= aer_root_reset,
 };
-- 
2.43.0


