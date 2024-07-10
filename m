Return-Path: <linux-pci+bounces-10104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA6592DA73
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 22:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4977A1F236EE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 20:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CB21990A7;
	Wed, 10 Jul 2024 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2luYN4D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE071990A2;
	Wed, 10 Jul 2024 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720645129; cv=none; b=Ft8Y0yvIXgBRyQY32EA6/sSkXwaItAzOqEUBJGidSlP/oA1ptSQ6RNO5lmvfv0E1KFhcch0eN8S87JRxvNdatK90ETlD9wxk/A13XZzUcBhLmyeEp1qlh4UmY3z7rNsYp/Z6M2SV5SX0XlRzP4DigBRopaqRPj41jh2nqdSdkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720645129; c=relaxed/simple;
	bh=Sf//l44VgFBV264bHR4zMgdtmXA3iNg9kC65iwFdMXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onTe/ku+LEoN4UTSjtkBaJIpWPvQ6zH8jZGwmUJ1eAZLookQ10cqXQkxL3o6T3FzQ+47UGdqxMbqrlaBaczAxtvmxwdaVPQ5A+PxFmH7tZh/UlbHKkLHsPIMi9FbVwg4YO5toT7EU2e/oAegHQTgxCr5hCrFj1i5X5uUWqCLPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2luYN4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0479C4AF16;
	Wed, 10 Jul 2024 20:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720645128;
	bh=Sf//l44VgFBV264bHR4zMgdtmXA3iNg9kC65iwFdMXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i2luYN4DKORwTCxfJDxCgcPHVWXq8GKs8SVlKkDGBpVi0nCVjPIH2bXGHwnz4xvu3
	 1hWl3iYS2WHZmFspw9yyNv1FVKexko9S9JBpjCjrifkXVA8azcRzPEact5rE4GVe/L
	 7NepBgu/77bBmFJnUaEkjCpjgbDB8KPAaYBAaSUSLNTBkIqgjfm0qJ5QVD26Y6qouW
	 N/5dk7gW3yrnmKhyEE/KproCWEQ2+UNGL5amcwJKzKYzjB0j6jr2wrq7vnV3p+WzbR
	 8Trf707SW2FtJ26mBNpPqJoY7BqOwn/Caqs+4fy3MGd3PTcIZzWTGO7ygsNqrvv92I
	 +UtAlYfS+iUqQ==
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
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/4] PCI: Verify functions currently in D3cold have entered D0
Date: Wed, 10 Jul 2024 15:58:36 -0500
Message-ID: <20240710205838.2413465-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710205838.2413465-1-superm1@kernel.org>
References: <20240710205838.2413465-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

It is reported that USB4 routers and downstream devices may behave
incorrectly if a dock cable is plugged in at approximately the time that
the autosuspend_delay is configured. In this situation the device has
attempted to enter D3cold, but didn't finish D3cold entry when the PCI
core tried to transition it back to D0.

Empirically measuring this situation an "aborted" D3cold exit takes
~60ms and a "normal" D3cold exit takes ~10ms.

The PCI-PM 1.2 spec specifies that the restore time for functions
in D3cold is either 'Full context restore or boot latency'.

As PCIe r6.0 sec 5.8 specifies that the device will have gone
through a conventional reset it may take some time for the
device to be ready.

Wait up to 1 sec as specified in PCIe r6.0 sec 6.6.1 for a device
in D3cold to return to D0.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4ad02ad640518..9af324ab6bb02 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1388,6 +1388,17 @@ int pci_power_up(struct pci_dev *dev)
 	else if (state == PCI_D2)
 		udelay(PCI_PM_D2_DELAY);
 
+	/*
+	 * D3cold -> D0 will have gone through a conventional reset and may need
+	 * time to be ready.
+	 */
+	if (dev->current_state == PCI_D3cold) {
+		int ret;
+
+		ret = pci_dev_wait(dev, "D3cold->D0", PCI_RESET_WAIT);
+		if (ret)
+			return ret;
+	}
 end:
 	dev->current_state = PCI_D0;
 	if (need_restore)
-- 
2.43.0


