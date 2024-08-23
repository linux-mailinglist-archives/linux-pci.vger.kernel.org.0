Return-Path: <linux-pci+bounces-12061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA6E95C42A
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 06:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6F31C21D65
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 04:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6816136E2E;
	Fri, 23 Aug 2024 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6sGQS6z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C4136658;
	Fri, 23 Aug 2024 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724387159; cv=none; b=Y3Gt3mz2J3aETu8BweIzlnP7xtdvVBFMiT4SsIXI5yJ/KmzDqCovUbJNMLPiK9BusBv6w9u6jvY0BrzJu2WMlhqM5qgnyN6pjAPblikccMgXDL5+mipvb8aZ3JYvrJPBxbPwyJ5/FmaL9BUke0nifLpVAr6Q7AIpAgHyqw6UGdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724387159; c=relaxed/simple;
	bh=6qJIy4WqqsO1C50A53jNHauk0l6sBv1X7ojJgbZaFU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOoK8p6AuLVqk4ld5jtOJQkRzsb7I8TbKqpyufuCQgAL9xN4u8sPvc8WYRJkVtbWwhl/NwUQqx1hJAemEEBYgZvNOWCwulhkZuc25xTvN1c38DVVs01/IlkBxsPGmUj6UtOZsfyLZ0GsYJaKwWd8PAMFqXbrUJslwDcZxU88HfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6sGQS6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6408AC4AF0E;
	Fri, 23 Aug 2024 04:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724387159;
	bh=6qJIy4WqqsO1C50A53jNHauk0l6sBv1X7ojJgbZaFU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6sGQS6zBe18pLlWufIsgJbEP2N5vMWLF3VJ04Sl96qIlYuI9rD1TJFghHmV31pvL
	 RywmJBGjwhMlzUCGo897dV+mXk93DsxBOfe1j4CVTeqLVcpXjvHowvoDNOUf9pj8zi
	 b6M9xvMCse/Seif5E93kJntUXH7x9iWbvzxo28HcbR7LIA4gDHz/ARzaGIZW+OtHQB
	 fLEfh10QVA66XfCNZ47vL9hlX6G1Y/99+ypzGWRCInmBFAvsWhdNhGAgzd/g/MNxw8
	 MER0i9pyCG8HJx2g5PFH5BknbaptQpRjtO1rJTeZwclsZ4dPVG3nIRl7ptY+jLoH3U
	 xCyxL5FJtk5rg==
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
Subject: [PATCH v4 3/5] PCI: Verify functions currently in D3cold have entered D0
Date: Thu, 22 Aug 2024 23:25:06 -0500
Message-ID: <20240823042508.1057791-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823042508.1057791-1-superm1@kernel.org>
References: <20240823042508.1057791-1-superm1@kernel.org>
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
index b7717155e2fd0..7e861b6923d0a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1425,6 +1425,17 @@ int pci_power_up(struct pci_dev *dev)
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
index 477257e843952..a675f5d55f298 100644
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


