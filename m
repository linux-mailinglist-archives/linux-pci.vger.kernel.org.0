Return-Path: <linux-pci+bounces-12319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A62961ACF
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 01:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA92F1C22A89
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 23:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C96B1D54C2;
	Tue, 27 Aug 2024 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVHTRZUe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71341D47DF;
	Tue, 27 Aug 2024 23:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802549; cv=none; b=WK4AbvKq1gOZ9OttxkeAV0oWtMiMdk97pE24/WQKJUNycgpmkuRYcj1vE8jntbiZvmt1czts42rVT+KcUdRyEurGI0oFOistYHrONmPpjXOhIOZocIyy0/rTRennYO6QWWcnIv1u4NNia9GwMadQ/zjTQWITpMFMjbyk7vvmTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802549; c=relaxed/simple;
	bh=GUjXysZkcE9Al0g58rZDOL7Ff/D+Z/t6J6RgE6+JPfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DuKGqYqM8WHtDpuf5ueYbGAXQgqTLXMqin992W/WuktlKfFwLw9pT0AU7c5VPM1m71DUjxwZ4aDO6dQyXZ+P6hTz/3jUy1c+LIjF4jcugVtI99zWkmDUV9RFKJSNcQ7sIx9oX0+lWts/kHCtIjHRaun1hU7GJVqNlo6I8i6Ee3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVHTRZUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8C5C4FE96;
	Tue, 27 Aug 2024 23:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724802548;
	bh=GUjXysZkcE9Al0g58rZDOL7Ff/D+Z/t6J6RgE6+JPfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVHTRZUeNthBl1yHJaMLD4BoVZ+n+pu5+Nnr2p6VkveaSWD86Oni2+BBIsuRkupux
	 aBHWp+JXeDju7gfidhYZZp0ye8s/J2rvlBZAi8/h1no0G1SO3C/vrl78DwIlzee+/m
	 3BZ5F+y08HoCtmoiY9qqR5kCrRkDq99qRSLCahlwoE+oEKXUUDPxbJVqYzTDsTGHkz
	 Tg4bbiW4Ym1e7+kEfEiJTU53YKP3K3xmB98iv92dMO7HEcEUmF8Nb6KR5+L0EFr6sH
	 zW+eivz3w1P2RNG/WN0HhfTMALK9cROwjOcUsf/T9s8SA1guifvs89SdtJBhjGe50r
	 MJB41lcSRoS7A==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Duc Dang <ducdang@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 2/3] PCI: aardvark: Correct Configuration RRS checking
Date: Tue, 27 Aug 2024 18:48:47 -0500
Message-Id: <20240827234848.4429-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827234848.4429-1-helgaas@kernel.org>
References: <20240827234848.4429-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Per PCIe r6.0, sec 2.3.2, when a Root Complex handles a Completion with
Request Retry Status for a Configuration Read Request that includes both
bytes of the Vendor ID field, it must complete the Request to the host by
returning 0001h for the Vendor ID and all 1's for any additional bytes.

Previously we only returned the 0001h Vendor ID value if we got an RRS
completion for reads of exactly 4 bytes.  A read of 2 bytes would not
qualify, although the spec says it should.

Check for reads of 2 or more bytes including the Vendor ID.

I don't think this will fix any observable problems because RRS only
applies to the first config reads after reset, and those are all currently
dword (4-byte) reads.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pci-aardvark.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 8b3e1a079cf3..e66594558ce2 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1153,11 +1153,11 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 						 size, val);
 
 	/*
-	 * Completion Retry Status is possible to return only when reading all
-	 * 4 bytes from PCI_VENDOR_ID and PCI_DEVICE_ID registers at once and
-	 * CRSSVE flag on Root Bridge is enabled.
+	 * Completion Retry Status is possible to return only when reading
+	 * both bytes from PCI_VENDOR_ID at once and CRSSVE flag on Root
+	 * Port is enabled.
 	 */
-	allow_crs = (where == PCI_VENDOR_ID) && (size == 4) &&
+	allow_crs = (where == PCI_VENDOR_ID) && (size >= 2) &&
 		    (le16_to_cpu(pcie->bridge.pcie_conf.rootctl) &
 		     PCI_EXP_RTCTL_CRSSVE);
 
-- 
2.34.1


