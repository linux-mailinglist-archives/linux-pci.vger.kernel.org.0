Return-Path: <linux-pci+bounces-29185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B95AD16A4
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 04:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E337A4C53
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 02:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1418235963;
	Mon,  9 Jun 2025 02:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbZcC5uw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41581FC3
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 02:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749434733; cv=none; b=JxU6Oz9N0vUl7RiP6w/sY0tRiz4xa3aLl3oMwcpq8XQL3vobL6mvwn67+lDYPlFvAwMWK/AurDHlc2zjeV2CnfC9smq3Oo4lMqWIY8dA8qs2ZL0aMbF6bq76Fzc6qZ/cnNCNrj1uRdezTSb5wrN1h49MeTbguD1+UM2lOqVYHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749434733; c=relaxed/simple;
	bh=Q0vWS7gcm1V0GLNI8LlX0ba8va3fmQxLElqs6/Z6R/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVZNt/b/IPpN990sWlHkGGFxwjhyy0QzwE2cNNDxZeRbLy4RJvnia2s1MOucKO/n+0PFDKmCCqOZKP3aE0EQf7Moh68AYVewkxYSFT+/0kutxFVK21FAix79Hm0ZbNjNZXCyGrK2hl2T9Uyg28xVAu2CZ0eLzcKeeinnfVWWFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbZcC5uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB261C4CEEE;
	Mon,  9 Jun 2025 02:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749434732;
	bh=Q0vWS7gcm1V0GLNI8LlX0ba8va3fmQxLElqs6/Z6R/k=;
	h=From:To:Cc:Subject:Date:From;
	b=kbZcC5uwsrbha266iPE47T8pEzCNFfWnWX8uqZ2ttNE6QIH8LnN1De7enFbBvvKqh
	 hneESM13Up5HOuaj8mfi2kglLGOeT6DtupUpON2FaQwYeYtsKO6TYOQIIY00IYNifp
	 /f/z9DU0bhiR6dCFn/WhZ8MPw8I6s86Sv3w7tdBjQVB+94evB8/NKD72vUDkD7OFG9
	 nE53DRRCg+d403Sz7Dep9N++9Bl7xz2OEcCodtsDRc7b7917J8rtjc/B1sJIg/xkof
	 PPP8eVdg8ryojUZDPdyLNEaUr60ubNHFwbYJW818jTvCK21txX2MEAG57qv5Vv2GNo
	 fLe/KhupA6AbA==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com
Cc: bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/4] usb: xhci: Avoid showing errors during surprise removal
Date: Sun,  8 Jun 2025 21:05:17 -0500
Message-ID: <20250609020518.289812-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When a USB4 dock is unplugged from a system it won't respond to ring
events. The PCI core handles the surprise removal event and notifies
all PCI drivers. The XHCI PCI driver sets a flag that the device is
being removed as well.

When that flag is set don't show messages in the cleanup path for
marking the controller dead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/usb/host/xhci-ring.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index e038ad3375dc9..997628f8d06e5 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1377,12 +1377,15 @@ static void xhci_kill_endpoint_urbs(struct xhci_hcd *xhci,
  */
 void xhci_hc_died(struct xhci_hcd *xhci)
 {
+	bool notify;
 	int i, j;
 
 	if (xhci->xhc_state & XHCI_STATE_DYING)
 		return;
 
-	xhci_err(xhci, "xHCI host controller not responding, assume dead\n");
+	notify = !(xhci->xhc_state & XHCI_STATE_REMOVING);
+	if (notify)
+		xhci_err(xhci, "xHCI host controller not responding, assume dead\n");
 	xhci->xhc_state |= XHCI_STATE_DYING;
 
 	xhci_cleanup_command_queue(xhci);
@@ -1396,7 +1399,7 @@ void xhci_hc_died(struct xhci_hcd *xhci)
 	}
 
 	/* inform usb core hc died if PCI remove isn't already handling it */
-	if (!(xhci->xhc_state & XHCI_STATE_REMOVING))
+	if (notify)
 		usb_hc_died(xhci_to_hcd(xhci));
 }
 
-- 
2.43.0


