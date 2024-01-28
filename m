Return-Path: <linux-pci+bounces-2631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BC583F654
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 17:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA201C21336
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9490E25773;
	Sun, 28 Jan 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOz2zkp/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9128DD3;
	Sun, 28 Jan 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458293; cv=none; b=AGNyRg2gs/kpkQ2vgVI/csnCVhMAbMPgIZIY7CWsIi5NZD0dRmy8wEdqHH8XwnnVHD4RmIB7FGSWM5MCXa0DOj2t7iqpnsGfHr7pU6PwZT/ZW1l9Zg3A5edUraGfOncENYFFDndMqyaADSGGT9OMDDmriNU6p5kp9BNjTA1gkOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458293; c=relaxed/simple;
	bh=ocJPjEvL0sWzeGacwEL8sSLQL5CMiLfRvLgXXAcMD4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIExzf90ZXp/a9Uw0JMCaHNaQFsRWnWKmtCKj3jhaDN6/p/AZT+XwEVPGTMe/c4UAmXOH/TAtVyAUD4Xzd6e/lucLfZEvrlwHsLlyHLeRZhuAGH+f5ttxDw3Wd6zT36XHNCDl90HjuirMEpMrBPa7HuRTRUAg9tzrLbU8F+6tjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOz2zkp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFC2C433F1;
	Sun, 28 Jan 2024 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458292;
	bh=ocJPjEvL0sWzeGacwEL8sSLQL5CMiLfRvLgXXAcMD4I=;
	h=From:To:Cc:Subject:Date:From;
	b=sOz2zkp/aLjvj5xFoGzK4HWT+x4F4st6y18ZTWcX9KgcFMVtgX4e/uUW/eJJia6MK
	 WQ7iAjI1HFHR1tEMFU4WxPlEtXn0GMEMdwYAaSCDhd/mRD3VGjKfyyJ/4dtgYmwfvg
	 BbICaEKil+C4x58926rOGXsw4OfkXPIMXnJOKH1NoaDQ7vZ8YwwRi+hfsrH/gq/V1n
	 NDxcnI9KxIqb8bykL+c8iz9g3oH2mXAbfviyAnHzxIxVErUKwXpKGGY8WJuoH0CsCA
	 RK2C9FOxf5kNYJwH4IDwsyBAIFr7qAoOTnjgOBXBfV/SMcXpbWNLX4b/AfeJ/RF38W
	 5ABQcQ75oknRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Huang Rui <ray.huang@amd.com>,
	Vicki Pfau <vi@endrift.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 01/39] PCI: Only override AMD USB controller if required
Date: Sun, 28 Jan 2024 11:10:21 -0500
Message-ID: <20240128161130.200783-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
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
index d55a3ffae4b8..057cd5bb89f9 100644
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


