Return-Path: <linux-pci+bounces-27246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19193AAB3E8
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 06:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E631C05BAA
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 04:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D148F393E76;
	Tue,  6 May 2025 00:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmiX3xEb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A62820B6;
	Mon,  5 May 2025 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486440; cv=none; b=shEqZ82KFUsMPWwsGzc39mVJ3/K1aMPiP9LAQ7zpHh9tFTW73kynsz4IwHMWHPmPWspcyGoeSQFlEf+izXFZ1jed+LzHrRMSDHG7GRNO5CuvvtP2E8h7DKTirwzh4tibDTUplciwLE8VWDtr36kyjkUIcBbF043pSD/D7bDq16Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486440; c=relaxed/simple;
	bh=KaqquR1b8CryzCbEEB78i5OSjwg3YazSDLhrsKVJAh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtuDI215ESWbbnHaM2UNT2KqoLtwBL6JZhk3i3gDQ/9W5yq4jnfp/e5rgXToFxgK92Ht7t2BwFzUDt7grhr0Bm6JwFhCR53v/HgfWWYYI1bn2XKERnHmwKJqdLsvq8gx7RGHw+NWUrflBEJCEeS3Et0JbeynUAtTl41a71hYGYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmiX3xEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3C6C4CEEF;
	Mon,  5 May 2025 23:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486439;
	bh=KaqquR1b8CryzCbEEB78i5OSjwg3YazSDLhrsKVJAh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmiX3xEb4npLRSoGnrZz+whrEheVF0uwlDpSr61c6HJJCp+rCqWJuvMjLMuqzJ/ef
	 /muq6gSVXiKjyonE4QetVTTmeIt5lcOThomJ83GLJ4d7aJIGX4eG34u54fumbauC2z
	 eIQjiYGiY1ri5FWzas8qwml3BSTxEflsJXe18mohDcquJ5Sy5m41EFkxIwKq2/JhvZ
	 IXf+QNXfEr6mkw6j/IVFULDKvQVjdieNqJVjKuoARSVm88V6/drirjBy2JrwLwX/hy
	 p0SGrEpLVuQ7/by8p/GskWiMJwmBuHYu0Jc3ALUc2qaPUZD0eAD4tL+GMOzav6+88J
	 yFgyHgjcLG/Ww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	nirmal.patel@linux.intel.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 028/212] PCI: vmd: Disable MSI remapping bypass under Xen
Date: Mon,  5 May 2025 19:03:20 -0400
Message-Id: <20250505230624.2692522-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Roger Pau Monne <roger.pau@citrix.com>

[ Upstream commit 6c4d5aadf5df31ea0ac025980670eee9beaf466b ]

MSI remapping bypass (directly configuring MSI entries for devices on the
VMD bus) won't work under Xen, as Xen is not aware of devices in such bus,
and hence cannot configure the entries using the pIRQ interface in the PV
case, and in the PVH case traps won't be setup for MSI entries for such
devices.

Until Xen is aware of devices in the VMD bus prevent the
VMD_FEAT_CAN_BYPASS_MSI_REMAP capability from being used when running as
any kind of Xen guest.

The MSI remapping bypass is an optional feature of VMD bridges, and hence
when running under Xen it will be masked and devices will be forced to
redirect its interrupts from the VMD bridge.  That mode of operation must
always be supported by VMD bridges and works when Xen is not aware of
devices behind the VMD bridge.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <20250219092059.90850-3-roger.pau@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/vmd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 09995b6e73bcc..771ff0f6971f9 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -17,6 +17,8 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 
+#include <xen/xen.h>
+
 #include <asm/irqdomain.h>
 
 #define VMD_CFGBAR	0
@@ -919,6 +921,24 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	struct vmd_dev *vmd;
 	int err;
 
+	if (xen_domain()) {
+		/*
+		 * Xen doesn't have knowledge about devices in the VMD bus
+		 * because the config space of devices behind the VMD bridge is
+		 * not known to Xen, and hence Xen cannot discover or configure
+		 * them in any way.
+		 *
+		 * Bypass of MSI remapping won't work in that case as direct
+		 * write by Linux to the MSI entries won't result in functional
+		 * interrupts, as Xen is the entity that manages the host
+		 * interrupt controller and must configure interrupts.  However
+		 * multiplexing of interrupts by the VMD bridge will work under
+		 * Xen, so force the usage of that mode which must always be
+		 * supported by VMD bridges.
+		 */
+		features &= ~VMD_FEAT_CAN_BYPASS_MSI_REMAP;
+	}
+
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
 		return -ENOMEM;
 
-- 
2.39.5


