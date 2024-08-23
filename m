Return-Path: <linux-pci+bounces-12063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A690695C430
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 06:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5151C20BE4
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 04:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B431813C810;
	Fri, 23 Aug 2024 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uX1Hcz5d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676513C66A;
	Fri, 23 Aug 2024 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724387162; cv=none; b=QR6u6LcXg2bJTfhT9jKdN6QjkopmjqwvU+izqW3GBmsn6Y8tXHqe8WtCmyUxWzyX3l/+KJxEUDgKdGMcLog4xFP+2mSZ5JL3PWCt5Y5A92yfyePkcjTDr70zO6QQerQs+x4yDTeVaMU/UQEPgCOEHuRiKwKPfvgsu4Hcne8KQH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724387162; c=relaxed/simple;
	bh=Rzi8UdSIlhz3Lz27Lgf4llrXyRuDGgJEajx2s+fq7bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVkgyJbNhJC/Yf4am+LxAAY/1KVecrxpCc+CD2IwM3C1CgvzlInWKTNYXX569RGH/8ldV6y8ajw4AM8EAjp+UGbPe57b08Bd8xByXWrwF92OrgT0IjZ6rIUhFlI28579hGcpNZT7yG8GKzMPsE+C+FRPQNUcu5SIe3i2BVu23nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uX1Hcz5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08774C32786;
	Fri, 23 Aug 2024 04:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724387162;
	bh=Rzi8UdSIlhz3Lz27Lgf4llrXyRuDGgJEajx2s+fq7bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uX1Hcz5dZVuGVBg+ODao+DPp4pCyuYwuvpA9Tuoa5xHlmEEVneOVXni4DQ5Mc3FY1
	 fRb6iFq6dKHCput+mUtlG3BoHxfbJBBaaJWfSpUGSZ6LTh+oW/g6BnWik+hoyq491Y
	 lji4oUQhHQRzrBWOyhuGbBE+zJhJRjmFgoDPqi/YtpLGGQXiVEKCL3Dhvho+/ZM1wt
	 TBIryOBvPp55dGnXeu6qm33D1u/sK77f0VUpwIdNJtngG4tmWQzGKR9CKxhNeA5w7x
	 8zQGL+Sn8vHTJ/c8PPDW2hy8NXOcpKJ+JDJJFo20C+UX16xINyLN5h0XaO4E+0RQaN
	 gOZtD5dVdn8Dg==
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
Subject: [PATCH v4 5/5] PCI: Drop Radeon quirk for Macbook Pro 8.2
Date: Thu, 22 Aug 2024 23:25:08 -0500
Message-ID: <20240823042508.1057791-7-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823042508.1057791-1-superm1@kernel.org>
References: <20240823042508.1057791-1-superm1@kernel.org>
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


