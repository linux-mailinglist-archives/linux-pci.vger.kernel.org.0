Return-Path: <linux-pci+bounces-32672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA23B0C9B4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 19:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A3C1891C2C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 17:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A402874E5;
	Mon, 21 Jul 2025 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="ImjF/7Ab"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85251A08A3;
	Mon, 21 Jul 2025 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119088; cv=pass; b=Pz2xe1JsRrBuVhCtvF3duUrx5WWm+h0v+JFKFrfWNfVUa47xqeASk/tdzdALtmYERfuCJOPOUTOsVnizTq2Tiia/zURVMDc9Y/5fqBpJeqoj1Lmt8nUx4qJv/QhIX5asxcqL9PsbIBVcQCIBFZjWj9TCRvcRthg0zoKreUPR4n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119088; c=relaxed/simple;
	bh=1fTr1Y7U+b4KL1BYT43SQDhDS04ylGF96jrfv2LDSN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/8lbDa3pVs/i64ShnW/6ehLSlAya2Q1YzGpJ05OjrlNGDT+g/kJOs+3pg+skOPnIWwmMRwWwdUTjGSeKqAYNISndxTqKf6MjT9vrCvnOS0UuWRPlLiiBCMPj1L9G7ho5SaS5yMFv5RqMgDq9I08q7/7KDs7AjRBkITpV4v9ZzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=ImjF/7Ab; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1753119072; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z7bEa0Xa2mWFL+y2qcbx3Q7RGTnx6CN3/q2d/9D/IrJzDyBmdt7+TVCo20jlKhzmFM8zqrzsrnlwtWBuoLHsv2sJohr57X21TX5ukNAlRamRfn4sRVHl6s65R8x9znSCEiCNYtvOaTqwBVA2B/7NThxPdoK9TOMeU8++IYsvnAM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753119072; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ImS4Azflmxc74vwR1MKlrS9ROU2xqa3Al5LEIyLX5PU=; 
	b=A8lefDwaylSZQ/vmMrpUzJaI58pjieHdjh0gFNe2EN7/UbN7MHhsG84TVpeBlPEhADh5RXz5b72up+P9SDxS+ND+s95BQlTODLhxwKL9XcieU3B4o6ABdt6yuK6pk8FKQ595oRr2334WVrmPX1R+CmcyqDdbP1bNRyAJQSBS4Zs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753119072;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ImS4Azflmxc74vwR1MKlrS9ROU2xqa3Al5LEIyLX5PU=;
	b=ImjF/7AbXUCQT5rXNE35r40gFZ71HTdson0NJfGB0TgWUYnppka+YPySyXHBZkQx
	EDJUMtovWet7sIXiTH5hjFRkjgW3SR1zaIlNnR+Vjbu7rl8fGPJndXK6zgEzaXPdFd/
	jksQg4NmmeQbaNmyvMSAXQmXABGFLgIZ7773Te8sQ37/cVZSq716YSSU+PD4EA7Wr1F
	Rjz1c/h6aPlZCEmeR+z20He+uY3TLnTEU7u22ULN/rliohC6Oxjs35Tl0MywmzCtqfA
	sHwuJ6iZxzXy4OEjzBCRBDxu+EAEFVslK4lP6wH0RgCGwSC8k+ThNL+u0so8LgrXQJe
	yQQ911GIoQ==
Received: by mx.zohomail.com with SMTPS id 1753119070005505.4824892322754;
	Mon, 21 Jul 2025 10:31:10 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: linux-pci@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Han Gao <rabenda.cn@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH] PCI: hide mysterious 8MB 64-bit pref BAR on Intel Arc PCIe Switch
Date: Tue, 22 Jul 2025 01:30:57 +0800
Message-ID: <20250721173057.867829-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The upstream port device of Intel Arc series dGPUs' internal PCIe switch
contains a mysterious 8MB 64-bit prefetchable BAR. All reads to memory
mapped to that BAR returns 0xFFFFFFFF and writes have no effect.

When the PCI bus isn't configured by any firmware (e.g. a PCIe
controller solely initialized by Linux kernel), the PCI space allocation
algorithm of Linux will allocate the main VRAM BAR of Arc dGPU device at
base+0, and then the 8MB BAR at base+256M, which prevents the main VRAM
BAR gets resized. As the functionality and performance of Arc dGPU will
get severely restricted with small BAR, this makes a problem.

Hide the mysterious 8MB BAR to Linux PCI subsystem, to allow resizing
the VRAM BAR to VRAM size with the Linux PCI space allocation algorithm.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/pci/quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d7f4ee634263..df304bfec6e9 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3650,6 +3650,22 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d0, quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d1, quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d2, quirk_broken_intx_masking);
 
+/*
+ * Intel Arc dGPUs' internal switch upstream port contains a mysterious 8MB
+ * 64-bit prefetchable BAR that blocks resize of main dGPU VRAM BAR with
+ * Linux's PCI space allocation algorithm.
+ */
+static void quirk_intel_xe_upstream(struct pci_dev *pdev)
+{
+	memset(&pdev->resource[0], 0, sizeof(pdev->resource[0]));
+}
+/* Intel Arc A380 PCI Express Switch Upstream Port */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4fa1, quirk_intel_xe_upstream);
+/* Intel Arc A770 PCI Express Switch Upstream Port */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4fa0, quirk_intel_xe_upstream);
+/* Intel Arc B580 PCI Express Switch Upstream Port */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xe2ff, quirk_intel_xe_upstream);
+
 static u16 mellanox_broken_intx_devs[] = {
 	PCI_DEVICE_ID_MELLANOX_HERMON_SDR,
 	PCI_DEVICE_ID_MELLANOX_HERMON_DDR,
-- 
2.50.1


