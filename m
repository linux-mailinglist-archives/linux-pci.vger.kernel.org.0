Return-Path: <linux-pci+bounces-27224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13431AAAAA4
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 03:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D219A2416
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 01:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BE62E61EF;
	Mon,  5 May 2025 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1kXA2W+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F2A36EF26;
	Mon,  5 May 2025 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485861; cv=none; b=oalPIUCPM8eBVLp0ugl3oLIdZf4tvbcMhs9Li2uDZvc2CTj9JKGosUf+kd2aa5N7WmPK1UHFWBdd5sxWEkEQHZ2sj5gNgfZU+PUzVStAf/tEjJhrU2IfF3+Tv3BymKB0nJWLr0yIQUKkSoXZvFShU2w7upOFeWNWlAGszOSg5jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485861; c=relaxed/simple;
	bh=n/xcGtcActF4OHLhnY34V8NfaTeXOL8f7VrAboRer90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1hcuIooUjeHy7b9AXaA/u6uP7qhbMofRKlmzgC637Jz5MEJ6PmzgTQ+1HJS4Te5WNHB/qUNLVnwl6wHdnV957g14THYPVnzKP10dSAEgTBxQQYnXofJI+F3HSgNMCJQvHOINVX1P/dPtgP/hv2kxulFw+FZvC/Ke2zOqFjH3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1kXA2W+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD80EC4CEF2;
	Mon,  5 May 2025 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485860;
	bh=n/xcGtcActF4OHLhnY34V8NfaTeXOL8f7VrAboRer90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J1kXA2W+XsRQcPMlD/RON+IQUdniS/IUIDrOwIC3ppMEymYINaOYYqiXkQfw0koTL
	 mprHNpXHfAtS5bNKuXANb7pVQYCgU4av9pPqtLLbE5uFPyJFb1/7L/uV2O+fpyor3e
	 ZdTF+GnP4GIl9mXZUTkEyWmuAW9N+Luj2eFgVCuX7HCfWBbX1YqF+ogiIAd+m6THie
	 xEym3dlZIM9A5eJiZbnbfQxc3lXH7izVr7t/Am8dhvnU1c4G+7jW5l+0bykQtQiEsb
	 vO52FKOnggh4a/TXgdAbLtPVR+efcmF1WxAHjMS2HPweP0Kki51hhmf8f00n07hmlX
	 m7SKz4yQFddBg==
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
Subject: [PATCH AUTOSEL 6.6 034/294] PCI: vmd: Disable MSI remapping bypass under Xen
Date: Mon,  5 May 2025 18:52:14 -0400
Message-Id: <20250505225634.2688578-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index dfa222e02c4da..ad82feff0405e 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -17,6 +17,8 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 
+#include <xen/xen.h>
+
 #include <asm/irqdomain.h>
 
 #define VMD_CFGBAR	0
@@ -981,6 +983,24 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
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


