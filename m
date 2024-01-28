Return-Path: <linux-pci+bounces-2639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B6B83F75D
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 17:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89015B21622
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189052D044;
	Sun, 28 Jan 2024 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ4OA2zO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45FA67E80;
	Sun, 28 Jan 2024 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458467; cv=none; b=bhUZqYTc+WDjN5EuBTKbre08crjObeKKyFIxl5/OzveaZNITknm0Iat2hjGx3g1DschCaJhdJJ1RjmgyrIteXwAsd5JJb7fD5RX5VWorp62T01n07V6VmFKYkxFxNe/16mjzZvkXbKs0YuqWjgmpct0drbX/PCs8KB7BLv/drsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458467; c=relaxed/simple;
	bh=BHTcqvUgtPvztzSo0fBhW5ml0BE2+RcAl3Xy4aZ74bM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4mZqM+U56llu1ictYc2cFh0JkeX/+cU+UJzS71UsbYGKNPyXOuPAWUm+OnyIHrMGTGESp9OdeiIm6TwlC6p2oywkSHPWFlRVhmkW1ZtZ6FmklsN9yEcs/YGZxDGexEc4X9LlkQeZvXoO4gYrxXF2N/2AdJ+c6OgtqmexD3k2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ4OA2zO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C14C433F1;
	Sun, 28 Jan 2024 16:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458466;
	bh=BHTcqvUgtPvztzSo0fBhW5ml0BE2+RcAl3Xy4aZ74bM=;
	h=From:To:Cc:Subject:Date:From;
	b=IZ4OA2zO+7E4DAjQaOOutnG9oJxLE8l3SIiSdMhiCYmCwEI5yLMrZd//uPz/x15Zv
	 pBa3TBVtZq5fegssTRkqzJBSy0Yp6J7sOl6LQ1yVeT/ZcTc+v5sjLCu93A2m4U0dW9
	 umBfwRfkcWy5oPGUf6t+U5hxbAQ9piFBZRmVCWteHyd0ubTFEdKWTtPzF9Plxa0uQh
	 DieMLFP5+efhOkwNT3fZJ8PErO2f5T8M8gxF/ubjcPSOYevuwL70vidunCoBrMYaAz
	 nWV7RPFJ/ugtN4CzRcOFiK32aN9K2fMVMdSR68snHjkZiqqFUBfgtvWVEI0CGfsJ4S
	 wIswfcJ2i5Vdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Huang Rui <ray.huang@amd.com>,
	Vicki Pfau <vi@endrift.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/27] PCI: Only override AMD USB controller if required
Date: Sun, 28 Jan 2024 11:13:46 -0500
Message-ID: <20240128161424.203600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
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
index 8765544bac35..75b297c15cf5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -607,10 +607,13 @@ static void quirk_amd_dwc_class(struct pci_dev *pdev)
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


