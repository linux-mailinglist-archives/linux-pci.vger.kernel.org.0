Return-Path: <linux-pci+bounces-12125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B8595D1D4
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 17:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47911C22602
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F8818E03D;
	Fri, 23 Aug 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sE02QXZ6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875EC18E02E;
	Fri, 23 Aug 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427638; cv=none; b=YuTXeoLqoF6nlkOc6o3aZ2qRoCOjumRhaeuqJ6HerFzE3AhBlzFt43PvaEBGDxQ/Z6Smex1IETAkey5yYdjEsmOgcHn85gD4QlV+kVsnv01V2kfmzr7yIjfF4OzlgpunhBwPlrVTcuYfYDCFqkemIKHVeLz2nsUrL8YIhMeMvtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427638; c=relaxed/simple;
	bh=YJmRm6eClwNstoqHflRiHBsbT7/PRWVFpj8/WSZOKdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tO5K/QdRZqkuomrYRsoZhBm2vHvQ3u8oQKkHVhOhDOVceoKGKDRqNYq1PCdy7pkFGmpXT0/g2auOI6C/9fn+Jk93Pr8kj20ryDRQckANSrD60fspHMyNizw1v4n/+7OzXToxiWQGsrVPViublvdtBgtJxgLLJdXSBMmmav4n+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sE02QXZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53538C32786;
	Fri, 23 Aug 2024 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724427638;
	bh=YJmRm6eClwNstoqHflRiHBsbT7/PRWVFpj8/WSZOKdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sE02QXZ6vCH+ZswKAXP1QFPKq4YIXoEhi9DL5+GGh3/LYf0ck85HwXH9Bb7ANB2hH
	 p8nsEyd+BIeFJ4FwI0lNBInLh1NEXf1/g+pfI3VQYx8CABeGU7QvCxH2RsTZrxhv3B
	 5pyttE55xwzH1FVUB85kT5PU5SQhH9wOdGq0EjSxmJkFqN9mof3S+CgX3JtHFnsqLW
	 W8y2F+r6V9rjfcyCGo+N3E0IZbs28x2mGAhbGhyvENvuK9Nl6LwF0dZ41g+NFZjcLX
	 mzGuo1xMuW13sMLLTvp6IReUMTYIZ2qgj7m2PQNR3CHtHs7/+fP87k7RQkak7Pg0iM
	 THifJ8CwmOMyA==
From: Mario Limonciello <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 3/5] PCI: Verify functions currently in D3cold have entered D0
Date: Fri, 23 Aug 2024 10:40:21 -0500
Message-ID: <20240823154023.360234-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823154023.360234-1-superm1@kernel.org>
References: <20240823154023.360234-1-superm1@kernel.org>
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
v4->v5:
 * Add missing string for new pci_reset_type
---
 drivers/pci/pci.c | 12 ++++++++++++
 drivers/pci/pci.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f032a4aaec268..02d94e0527e6a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -188,6 +188,7 @@ static const char * const pci_reset_types[] = {
 	[PCI_DEV_WAIT_BUS_RESET] = "bus reset",
 	[PCI_DEV_WAIT_RESUME] = "resume",
 	[PCI_DEV_WAIT_DPC] = "DPC",
+	[PCI_DEV_WAIT_D3COLD_D0] = "D3cold->D0",
 };
 static_assert(ARRAY_SIZE(pci_reset_types) == PCI_DEV_WAIT_MAX);
 
@@ -1426,6 +1427,17 @@ int pci_power_up(struct pci_dev *dev)
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
index be06c38342c76..6a48419924ea1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -11,6 +11,7 @@ enum pci_reset_type {
 	PCI_DEV_WAIT_BUS_RESET,
 	PCI_DEV_WAIT_RESUME,
 	PCI_DEV_WAIT_DPC,
+	PCI_DEV_WAIT_D3COLD_D0,
 	PCI_DEV_WAIT_MAX,
 };
 
-- 
2.43.0


