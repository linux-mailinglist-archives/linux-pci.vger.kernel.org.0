Return-Path: <linux-pci+bounces-2643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBE183F7A7
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 17:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41A5B22D16
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6214CDEC;
	Sun, 28 Jan 2024 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0dUJ//q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1422D4C629;
	Sun, 28 Jan 2024 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458527; cv=none; b=YPxqY99cRkoMj0wdXyLhKFl5H+NZ7IFmLoG9L3TpXNDCM6Aua8scqu0rsHx7ggtAb/VjfzMuLBztBrkfvDCZbiAs0Uy2VFFDrjuhwmhR6g/dIxbYMTls+9DcxIMHfHr91DWwyE/iTIMsi7rse8W2EtHywGoNaHe6tlu/cLshkkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458527; c=relaxed/simple;
	bh=RwSXAfc346kFLMeNKq4GZhlE6eXMPAKANtVWLwCmlZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FylwNF7w35iGjraFntKTqHx5FiiSxKiQ0lCPHpUrKjyLgbZe5QWzQ8owyfb8CE7eMqHhon+Bq1mizfJhgvFhZFBZIY/KzrAANapZt4ffeI2mINdWZW0BYEmXAcPNy42jjJ5UjbZDhAJHGq3sh49UFpBynesNwRNImvfNIeEM9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0dUJ//q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064B0C43399;
	Sun, 28 Jan 2024 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458526;
	bh=RwSXAfc346kFLMeNKq4GZhlE6eXMPAKANtVWLwCmlZY=;
	h=From:To:Cc:Subject:Date:From;
	b=a0dUJ//qVnRKgRkBbZeh5PzURZfA7gQK/+hLEplcAQAkDH+oZ6Vn1/eJWpg9WRKUu
	 Hez1E99SXPZWqvC/n/01cLeAUkuCALQM4f2b+fwJv3h8z+Kg5DdUuYF2JCCUXRMTty
	 7jCRTcLl4TlZIRNJrA50iIoaJfxSRmxrLcsFlKgbtZZPHEVZ0rJTuwa99ZdZp8zPAE
	 ejKORZwdUL2Er2d3J/+vrU43jSuPorDHmdIOvRpaKoL1Ib17UWDgzfiJylPf1wv2Z7
	 vhgleJno9ARX8GBaN0E67TIq0vHdYunPob8XM8w5FH5IGTVstmDt+UTkOc2VLcQKfc
	 kJBsJNwDotcgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Huang Rui <ray.huang@amd.com>,
	Vicki Pfau <vi@endrift.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 01/19] PCI: Only override AMD USB controller if required
Date: Sun, 28 Jan 2024 11:14:58 -0500
Message-ID: <20240128161524.204182-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 5d8768cd7c50..18716964013b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -604,10 +604,13 @@ static void quirk_amd_dwc_class(struct pci_dev *pdev)
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


