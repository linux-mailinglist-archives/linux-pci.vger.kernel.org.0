Return-Path: <linux-pci+bounces-12127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D15895D1D9
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 17:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF9428588A
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639401925AA;
	Fri, 23 Aug 2024 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZainWfEj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C3C1925A4;
	Fri, 23 Aug 2024 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427641; cv=none; b=OrEvgYpL9Qu63fj459czKT0Hgbicy88yXnDm5wBhAcY+GqfAh6QHaV2gU1KoB3v31r/7PlR00fjRDsPP+cEaUL5y32hPRWKpvsS2SZNwlURFxMVa6FQwvnngAz2de24T9Q4kSPoP4nSlf7/jENSmt6+G/QhXbDfFjtXSyMBCebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427641; c=relaxed/simple;
	bh=Rzi8UdSIlhz3Lz27Lgf4llrXyRuDGgJEajx2s+fq7bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeE3Kr+O5byo4puKtJnIYFuDfI7TeaTGr/pX7g8A3kTmmJ+wPC24RmzJFpYLdScpqJ9wLpMnTCq79pQz1wYbBFEu0jDPcKmZd/5asEAjt0LGQbEBIsiGIrShcc+Bn3FwittPcka8J8H9o+Sk8eesndSa7WOcxK503Lg3Ukdfv+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZainWfEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041BFC32786;
	Fri, 23 Aug 2024 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724427641;
	bh=Rzi8UdSIlhz3Lz27Lgf4llrXyRuDGgJEajx2s+fq7bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZainWfEjAcoLLIr/iwYN9VAPpOfo9SIuUVicFsmx/GEqolnS2f7HqQsExuei7QwOC
	 xSdxTGWUenTNqzgSR4r36K88kVEB3HIbozH4X5K5pMYnPwBjbmiMn6K5enNIonQFWK
	 ZoB+3mxo5eNK/HDzvGc8VKde7+x/YqS/PTmKes5nAcSn/uQZfnzqg6Y/7NH7i+myxR
	 4pDY8AJLRCYTWNuTuzEaBgojLWtcffJqBDRnREt8ou7VATyxfmKgcXLSR5Ces/a67C
	 UIHh6QKY2fmSP+/HS/4ExaYYzA9t44E+LhoD/ObwZjx6GIYJbyTAkHCosPkIh7Ovur
	 BE1qOWdS2uNCQ==
From: Mario Limonciello <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 5/5] PCI: Drop Radeon quirk for Macbook Pro 8.2
Date: Fri, 23 Aug 2024 10:40:23 -0500
Message-ID: <20240823154023.360234-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823154023.360234-1-superm1@kernel.org>
References: <20240823154023.360234-1-superm1@kernel.org>
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
index 3480a0445ff50..e76ff1037fb35 100644
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


