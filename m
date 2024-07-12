Return-Path: <linux-pci+bounces-10215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9B3930051
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 20:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEC07B22775
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 18:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE0517D89D;
	Fri, 12 Jul 2024 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oibZr1LI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A64A17D898;
	Fri, 12 Jul 2024 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807976; cv=none; b=LWjFjIlU0z0be8pH9C322b2UPZ+JcqGWvTmeQxJWNEA2VXK117n6l1bsnL3hx3kV6qOeBemel9hER3dUJAZeAcf9N0IcoouPW+Nej7JzuDb9FoYgvjlzIvt98azx2sEVo99/Z4IhZoTX2RM/Wcf1VVvpyUOdsMoQQJEB72deU2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807976; c=relaxed/simple;
	bh=hLZ13tB6qAQEHvHpUsidz/Qnom4FichvzgyqtE0sOJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZAQNkucNpGpCk/IRrNKvlSBMeVpqIG2JZ81C6PlMdmTyOpaFKy2fUkQOSx2vxHgGGM/1oITQ5SkY8RaLDboJix0V3wtL5WJUk52KgzORnO3urufIM6eUgCiJrtVZbo7e3AMiepvfVat74f0hkRZkCTd8Ll7eqyXr2Ac075SO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oibZr1LI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43D8C4AF12;
	Fri, 12 Jul 2024 18:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720807975;
	bh=hLZ13tB6qAQEHvHpUsidz/Qnom4FichvzgyqtE0sOJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oibZr1LIQWv1tC997nGrg8NSafblI/Uv6Mgy30HhWxzN5aOrL0agOBXi9y7Weo3CU
	 +9pBEMHGJRcQ2XqHYqYbYT4JEUTEB0Bp/oAtwJA1+IIFKX6SPpLb9Fu+A4kaWpVS/h
	 hgiMks3LioZnDfGWCgFneN2BeNs6/fewsrcokSP1BrEeIhwrUDcwJZp8nY2rxzLA4A
	 gQDA/TSPNJzHPgBvwPDvMoFWgP1b+kdJTbyeCOdKAKH0DxwgHx4aMWerTMFSdg4DXV
	 A11910we7S8LsTZ2JgsdYWJiribIqwImSJHwa1vGhp/lyQwxvmEJGgJzi71p3Blb+2
	 KyEChaAligCHg==
From: superm1@kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 3/5] PCI: Verify functions currently in D3cold have entered D0
Date: Fri, 12 Jul 2024 13:12:44 -0500
Message-ID: <20240712181246.811044-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712181246.811044-1-superm1@kernel.org>
References: <20240712181246.811044-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

It is reported that USB4 routers and downstream devices may behave
incorrectly if a dock cable is plugged in at approximately the time that
the autosuspend_delay is configured. In this situation the device has
attempted to enter D3cold, but didn't finish D3cold entry when the PCI
core tried to transition it back to D0.

Empirically measuring this situation an "aborted" D3cold exit takes
~60ms and a "normal" D3cold exit takes ~6ms.

The PCI-PM 1.2 spec specifies that the restore time for functions
in D3cold is either 'Full context restore or boot latency'.

As PCIe r6.0 sec 5.8 specifies that the device will have gone
through a conventional reset, it may take some time for the
device to be ready.

Wait up to 1 sec as specified in PCIe r6.0 sec 6.6.1 for a device
in D3cold to return to D0.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 11 +++++++++++
 drivers/pci/pci.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 658a139f74ab0..14dab7bc64ba4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1396,6 +1396,17 @@ int pci_power_up(struct pci_dev *dev)
 	else if (state == PCI_D2)
 		udelay(PCI_PM_D2_DELAY);
 
+	/*
+	 * D3cold -> D0 will have gone through a conventional reset and may need
+	 * time to be ready.
+	 */
+	if (dev->current_state == PCI_D3cold) {
+		int ret;
+
+		ret = pci_dev_wait(dev, PCI_DEV_WAIT_D3COLD_D0, PCI_RESET_WAIT);
+		if (ret)
+			return ret;
+	}
 end:
 	dev->current_state = PCI_D0;
 	if (need_restore)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 88f54d22118dc..9482539b9830a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -11,6 +11,7 @@ enum pci_reset_type {
 	PCI_DEV_WAIT_BUS_RESET,
 	PCI_DEV_WAIT_RESUME,
 	PCI_DEV_WAIT_DPC,
+	PCI_DEV_WAIT_D3COLD_D0,
 };
 
 /* Number of possible devfns: 0.0 to 1f.7 inclusive */
-- 
2.43.0


