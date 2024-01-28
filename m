Return-Path: <linux-pci+bounces-2647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5156C83F7D9
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 17:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED2C1C2244F
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333AC4E1C8;
	Sun, 28 Jan 2024 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkK99O5W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083D313BEA3;
	Sun, 28 Jan 2024 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458569; cv=none; b=FyXjYuyJH9kHvILOADfqG1XluhPZRaxF4DF0W14T2jXFlJQ7pxus/FBsDpbhyE8QrpUp953FREnlm7IIJN14LZ92FNLIyTrmVg/L4vEZkSui7rozEn6L8xMBCjDM3K71qeUfUtUzl74ggJ7Fme68FKgnGb7zTonsoentzMwuQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458569; c=relaxed/simple;
	bh=MpGym25+0xsBa9yTq0iFKbRgXNgQwFzL0JBmq/qXBC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYHIMK679CRHIyySEaLIpd6v2ABE/OSQFUzDCS1wnaRB+x/srDD/+FZ5m/C9gHVLNfbHz+1R0peNj34uzmQi5ck17ZdNWp4otWIG/SH3nOrQlvREE0V40DWzeI6Vm1ECay0vMCal7+osZUn7g5iZuTOKN5nLsm/iIGN8UDZiwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkK99O5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D77C43390;
	Sun, 28 Jan 2024 16:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458568;
	bh=MpGym25+0xsBa9yTq0iFKbRgXNgQwFzL0JBmq/qXBC4=;
	h=From:To:Cc:Subject:Date:From;
	b=dkK99O5WLKGk2cJGuHpbrcySRwNqc6zfHFk0Z+FCrAtwHTVI6X7sst+aEVao3m7lN
	 dMTiZqfWJy/SOEYSwHamBlmJXAzF1Fz/K3+Ee6idnQ/GNpcwtzMqMtAvnwrEd9JqAg
	 K6B80BJ053/UVQzBA7vCu9unQv4yqD478Rf7TZBZk0l4EV7fixdU5Gep6Y94rYiJ4I
	 tI+RtyPgni6wGuvov2lNkrLRMPAgMxexmdGEaLNtouxSbKfNvFwNYReSc5rrg6Xcjq
	 alG3sNSXJyHGvTjmfMDy0XnmwFu8gNlL6LWS8SJBqzmbp4X7PG8C8RizdntRIEduMz
	 FpURFP0TH/s/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Huang Rui <ray.huang@amd.com>,
	Vicki Pfau <vi@endrift.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 01/13] PCI: Only override AMD USB controller if required
Date: Sun, 28 Jan 2024 11:15:47 -0500
Message-ID: <20240128161606.205221-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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
index 500905dad643..b663b3b3c87a 100644
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


