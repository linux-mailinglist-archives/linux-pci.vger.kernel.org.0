Return-Path: <linux-pci+bounces-10217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2E7930058
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 20:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AE6284D7E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 18:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D8617DE0C;
	Fri, 12 Jul 2024 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzUGdd9h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A717DE03;
	Fri, 12 Jul 2024 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807978; cv=none; b=qtgvsa6Kxs5anu0VqNQfmYGum3x2R09v+sU+7ELzq8kGS/5y5QhTBEMHBI+anhBNI4+VVfJIuxyFuOFPX2b3oIqePuZWeDM/7TEz6Mppj99OofxJkADUI5Qiac2jtcL5fczByNVFJkT45HThkpWO6/G/1Axsot27C+Qtb2IC2eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807978; c=relaxed/simple;
	bh=I3YOKrgcX9tYEahHIc86VPfwH1MjXcqGLk7gRDw/2fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkIo22CRY03jOCcl4bjWXXXZeTmjXSmLzmWUD6Uwe2UG2c1BvYkkGQ6REXk/O3RTaWCX0kkD8VXdfy6aQHG/wxs1Ss1r5bmsJhEUQI5USUgNr53gviUOSe49GSrdtmwHXDpl2VrbfTWgxiqB8b0qyrzGgyC3UINplhSn6M8ZYDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzUGdd9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43485C4AF0B;
	Fri, 12 Jul 2024 18:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720807978;
	bh=I3YOKrgcX9tYEahHIc86VPfwH1MjXcqGLk7gRDw/2fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XzUGdd9hxzX8GfjEwuF0oDiL740HXQIoEZOCyRPWXRX0Bv7uuTnG/d7jslvwJNJ2w
	 iGV8yn3ogTMp6RQ1Po3Qpd2cxjvsk7p0U/dwie8LMWORRHHk7WxWzj8Iy3JjWZLw24
	 ffJyV2nIhfaKLjk9NsgGCgL8UtC5XbZD9tvZMT3WLu3z/3fM67psVQjvbpCh6v3BR7
	 6X2L4Da69mjTsW7snnGtDR4ynwk97E4SmfBi9CjbEUbp6OEKM1cPXbCHlESPNeFKip
	 9ayt7nNHMkZx/2KWUlYuT/t/f0CKULEgXeleb/78HgDcJGqHBowlotrO840eKt4m5y
	 EnRzU3B7084uA==
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
Subject: [PATCH v3 5/5] PCI: Drop Radeon quirk for Macbook Pro 8.2
Date: Fri, 12 Jul 2024 13:12:46 -0500
Message-ID: <20240712181246.811044-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712181246.811044-1-superm1@kernel.org>
References: <20240712181246.811044-1-superm1@kernel.org>
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


