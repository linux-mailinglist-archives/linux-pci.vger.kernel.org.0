Return-Path: <linux-pci+bounces-10106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 092A092DA79
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 22:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8184284A8D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 20:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F3E19922C;
	Wed, 10 Jul 2024 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUwEXMYc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7A9199229;
	Wed, 10 Jul 2024 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720645131; cv=none; b=KkCBYnIrr86RRfuNsjtfXwapVYOhHpohKFxDO5trKINzNyeuSWNu8p4UMrORvHmHqAQUGDi+hQgDl2uLJWTBRRsysMOHDDWWfOAWm2dBdITdji7TiyAKHR2+CpwYqH/KNWj1cldcbRXbfYD4DxRcpcnv3DI6ZeNPgHSBTZe5jSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720645131; c=relaxed/simple;
	bh=I3YOKrgcX9tYEahHIc86VPfwH1MjXcqGLk7gRDw/2fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlfCf1uNVslbpIZ0woImMdNu26RK8Wh+EF/cBt4HSRZIW+SPa4/IWc8jC8mxWYFTmH0zgUdp664O4EE2S9QsVEooU9gtg1A/dzaSkZm8Te6RoPNwT8/TzvIEJrFLpmJi5odO8jK0qhXeiTFlI2L+TRVK/KaR/E7JN1o1bE5EtS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUwEXMYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E72C4AF07;
	Wed, 10 Jul 2024 20:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720645131;
	bh=I3YOKrgcX9tYEahHIc86VPfwH1MjXcqGLk7gRDw/2fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fUwEXMYcVUojiT6jCDSqB/JPgH1/Q4cnLyJeW5r+bl5dTWHvRDZjjRp5VgyeXeNeP
	 NfRXtvwFqiST+aGDNgd+YGKY/ZWvkqUP0cyUJ57b0aLCc/9ZLBszq+SNfZGBI1aCqO
	 2kHJCRJMBDBD6ebg/Gov98BO0PNEyIHTGnykDzFDc9battr0urkiIRH2wr/w4gQakg
	 mvG3PFTFo763eIdQonjWHfaKTbwYGsQld4NJWBqQ3Jd+2CD+hCDPDK24X7WnndM5FT
	 ayejLwfv8fraJIHjUV52TErFjDcBxwm0PueQwFU/zZbAnD15M348zJGDuMGGhdZjSp
	 1DwjKaRDus2bQ==
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
Subject: [PATCH v2 4/4] PCI: Drop Radeon quirk for Macbook Pro 8.2
Date: Wed, 10 Jul 2024 15:58:38 -0500
Message-ID: <20240710205838.2413465-5-superm1@kernel.org>
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

commit 5938628c51a7 ("drm/radeon: make MacBook Pro d3_delay quirk more
generic") introduced a generic quirk for Macbook Pro 8.2s that contain
Radeon graphics to ensure that enough time had past when the device
was powered on.

As the PCI core now verifies the device is in D0 during power on this
extra artificial delay is no longer necessary.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/quirks.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 942d0fe12cb1a..19be953c9f373 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2038,14 +2038,6 @@ static void quirk_d3hot_delay(struct pci_dev *dev, unsigned int delay)
 		 dev->d3hot_delay);
 }
 
-static void quirk_radeon_pm(struct pci_dev *dev)
-{
-	if (dev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
-	    dev->subsystem_device == 0x00e2)
-		quirk_d3hot_delay(dev, 20);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
-
 /*
  * NVIDIA Ampere-based HDA controllers can wedge the whole device if a bus
  * reset is performed too soon after transition to D0, extend d3hot_delay
-- 
2.43.0


