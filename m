Return-Path: <linux-pci+bounces-2635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CE983F6FE
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 17:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D67AB2095A
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 16:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECA23C484;
	Sun, 28 Jan 2024 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0nEYbeG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1748B3C467;
	Sun, 28 Jan 2024 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458398; cv=none; b=WZn83OyLmIJEbmXrzaESJkZpdXKSJTkL7a5nQlUXRFVaRLY7DbIoaAKvtcBpxa0WNyK6er4CSp9rwgzGuorHZ9ebMziapBwsb0cYs/MihsGEaQMS530ST01A6wNHg5B/T43RNFH5TdJ/wDe3n82BbThSyJhjkCfPDiGFCve1q/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458398; c=relaxed/simple;
	bh=QuWlol0LArnTvrXDBi3hNCwSdHzhFmjcSvL5Sl8hzR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ew0uvYN+YKqXhDOZzmfKyNJwV3E1OtPk3BCsPRd6kFkv8fSlwRNBeSos2IV3AIuveqByB31eRcvpXXrb7duYFk4IbBzOMZ1dTpa5RwxTQRkJC9BoiFe7lN5IlqAoXmjWe/lgg0/FFnMe1X9mJufy0RuL6rj6JWrfiYFNKT0R+5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0nEYbeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A649C433C7;
	Sun, 28 Jan 2024 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458397;
	bh=QuWlol0LArnTvrXDBi3hNCwSdHzhFmjcSvL5Sl8hzR4=;
	h=From:To:Cc:Subject:Date:From;
	b=u0nEYbeGxKDXEoNvnL67jm4rdTVX2rx4ZWnqrDrgddHcdetvSGW8gjZiPxosOzAJ/
	 1N82UVsoetMIdb82B1EiIolNFPUdiuHkk5F2/aHIEB2/lPtC5qmXJ3Zk7oF2g8JjFj
	 FuUQFPlwKgVlfZ43MrCFG7Lq+XLiLNdIwwuAqzTGFBXOlemtUyerbrZ8aEjgoC8mC3
	 u810pTb8znmIqG4HDdHST7JR82nAjL2kHvob3TanGkecJccI9nzq9gSGuPosWO5whL
	 +FKhBCV1LNhG0PZNlboP+CojFuWrhgOqfWaazAx1u/jOqEZI+H16CiZ8U7m8qrlcpX
	 0yZPt7lLn+zjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Huang Rui <ray.huang@amd.com>,
	Vicki Pfau <vi@endrift.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/31] PCI: Only override AMD USB controller if required
Date: Sun, 28 Jan 2024 11:12:31 -0500
Message-ID: <20240128161315.201999-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
Content-Transfer-Encoding: 8bit

From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>

[ Upstream commit e585a37e5061f6d5060517aed1ca4ccb2e56a34c ]

By running a Van Gogh device (Steam Deck), the following message
was noticed in the kernel log:

  pci 0000:04:00.3: PCI class overridden (0x0c03fe -> 0x0c03fe) so dwc3 driver can claim this instead of xhci

Effectively this means the quirk executed but changed nothing, since the
class of this device was already the proper one (likely adjusted by newer
firmware versions).

Check and perform the override only if necessary.

Link: https://lore.kernel.org/r/20231120160531.361552-1-gpiccoli@igalia.com
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Vicki Pfau <vi@endrift.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e0081914052f..76beed053bf7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -702,10 +702,13 @@ static void quirk_amd_dwc_class(struct pci_dev *pdev)
 {
 	u32 class = pdev->class;
 
-	/* Use "USB Device (not host controller)" class */
-	pdev->class = PCI_CLASS_SERIAL_USB_DEVICE;
-	pci_info(pdev, "PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
-		 class, pdev->class);
+	if (class != PCI_CLASS_SERIAL_USB_DEVICE) {
+		/* Use "USB Device (not host controller)" class */
+		pdev->class = PCI_CLASS_SERIAL_USB_DEVICE;
+		pci_info(pdev,
+			"PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
+			class, pdev->class);
+	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
 		quirk_amd_dwc_class);
-- 
2.43.0


