Return-Path: <linux-pci+bounces-2650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88DE83F801
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 17:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675F01F23769
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDD72E62A;
	Sun, 28 Jan 2024 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxrD9qpI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26131420AF;
	Sun, 28 Jan 2024 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458600; cv=none; b=NaBAZ/apdHigg7SBLZGbUYjiqvvq1fmcgSOrG2Vga7V7+9vaW1TGRc8QLZjbdqxonY39OIdaelHIZ/B1VfJTc9rP9E6HJby+uuTYu7Y312Zd9G1EytztsHTPRh68/dQ0YHzKJR6I6IUiqmZNeVQjnv6xNwh49qlQc0MJcqeS0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458600; c=relaxed/simple;
	bh=CdgMKeIksrFFuV/eXvgcFMtnoqTQQIkjEXkh5z4kh4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldC7LY//iGn8eR3TCbsUC+R9Y9O9moFkTOdqNNcj78vAiwWidjkX2+YXZwGfA91ArKk/45Hcq3Q7LGlqefhO069xHLkLPAtMx5BzW2W4id3WKVp7fsQ8XuJdu5u/np79NfQKhL+kGG0gdpX03zqvFeaxMXODRSt/GbsJW+RxIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxrD9qpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD228C433C7;
	Sun, 28 Jan 2024 16:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458599;
	bh=CdgMKeIksrFFuV/eXvgcFMtnoqTQQIkjEXkh5z4kh4I=;
	h=From:To:Cc:Subject:Date:From;
	b=FxrD9qpI6//kYfRQZE7ZuHWuCIfmq8XMHY9I/c85fgzV3W5QGSkpmE5v+aOlhM5XT
	 mPQwfaNu/Jl9NpvXfwV9hX6rIuPWIQ1oJ2Cy4MyZygSaUDXSsT/7a2Sx7v7z6Vw301
	 qFlmKaMCurXg4ki1ZhWUeL93Z4786DYV2P2/LlcUhAuELQxaw8Xl3FEMRObhnSug/r
	 +59hU8HXyJxXyHv+xiNM5szGkf98MiNiFqC0l2VFcheQbxx9fO7Vxxhj20tXTHelsF
	 SIAtFrb8r1lmt9HULmCc+61K3uGyjsVbEzuErOMzwNctM9MYCnwoVem0OtKYmYAlUO
	 ZKfVwPbFXMHAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Huang Rui <ray.huang@amd.com>,
	Vicki Pfau <vi@endrift.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 01/11] PCI: Only override AMD USB controller if required
Date: Sun, 28 Jan 2024 11:16:22 -0500
Message-ID: <20240128161637.205509-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
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
index cc8f2ce1e881..810dd75f9072 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -609,10 +609,13 @@ static void quirk_amd_dwc_class(struct pci_dev *pdev)
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


