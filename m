Return-Path: <linux-pci+bounces-2653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF22A83F81F
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 17:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7378128AEC4
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B197524D5;
	Sun, 28 Jan 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kimVa8Gp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5041524CE;
	Sun, 28 Jan 2024 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458626; cv=none; b=ScnmdyWpuuLQPufnxM4fWCAMQTk3YSa+smelUCf4y7IYm7og4C3QqGm1shPIZVzuvNqyiYjPHNcfxv//Ix5P5bjSe2KA1B9dUfsufo4X2I/8afhhMF0vU7Q/g8RB0QhxXPZdvJgbS9Bj8NW18YuixDZrejomDLMN/6/lbrQivHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458626; c=relaxed/simple;
	bh=u0q5FwEYgYwFyxIi/xiCF/f00BSFyTncHUQhJOmA/oU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MchCz34PRweTfO0g5q8+XzD70lsEQL6j5iN9qtzIIJ6ITzyzJdtUju48SPpji0NxDvymcc5cRBq7g2UcfA3Kt3jNr9HqxnkST8J8hdEeE6dt7NCIkbCsI3zqkAwTs1GkOVGn1KAg9LZyGCFVfVQ5/nzeukLOGVV4DJQVnOdMmP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kimVa8Gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76284C433C7;
	Sun, 28 Jan 2024 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458626;
	bh=u0q5FwEYgYwFyxIi/xiCF/f00BSFyTncHUQhJOmA/oU=;
	h=From:To:Cc:Subject:Date:From;
	b=kimVa8GpB7Ve8hR1grHF8iV/zVNMj+Pm0JxVXZjCgj7veRQSlMlsWrTYC6ytXNEZf
	 PMGslZXPVecSEHGjp/yod+vAcoEARcaJp6wzmrLyhnoqoJBWurfmT9Op8+f06SGyWT
	 Ha+iam4V/RV1u8I62QrtSsyAEUF4KwGQ8aLheUQgs0xdFCyFeltXBpAEGAJFI0TZEm
	 YtDU0cFH5YF5EAB/yTZKCrNc+k6ot+MrLC+HXjkt5ClnVwu/QKo9lJ7TIyoKbcfSev
	 saMjlJEFFU2WgFMBjpt7qsFWWXqE58hY2ZtsR25ceJPRzLet4OqtK/9ndbBkBYS7+b
	 150TN9WGyxSvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Huang Rui <ray.huang@amd.com>,
	Vicki Pfau <vi@endrift.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/8] PCI: Only override AMD USB controller if required
Date: Sun, 28 Jan 2024 11:16:52 -0500
Message-ID: <20240128161704.205756-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.306
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
index eb507751c115..af9aba7c196e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -611,10 +611,13 @@ static void quirk_amd_dwc_class(struct pci_dev *pdev)
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


