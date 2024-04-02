Return-Path: <linux-pci+bounces-5569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34116895C0E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 20:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B71CDB24726
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 18:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D4A1CF87;
	Tue,  2 Apr 2024 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5sLe9dG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F8D15B129
	for <linux-pci@vger.kernel.org>; Tue,  2 Apr 2024 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084269; cv=none; b=p6xke7eTvWOEJfNdVM2HquFIRfOb4SWuVKyevetSW2S/Z1r6gNLlpMOytzAlcQGQeVz3SJJPKF20SqrpjwadGRLZT+r+KcxmKgX7n30D3qHzazAOA+n9/++TmWPWbR+3CP5pSbn93uSC+3ZOHoipVIxEn7vLYOnOh1OWQgOIr/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084269; c=relaxed/simple;
	bh=oHHhLiXrvdlW3ySm9j6oZQXbKS0fRwGJ00mNlGSOOS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DOsO84S2zAYQDv/+kFC7XpyQHYAzvEuLyqHlnH4EdEUvA0rGM1D7Mlr9MDh+d3GLMDAqNuZ7xe772leMxfJ+4Kgit8eBcQysbalsqzGHLSZcnbUmfdAGAMhbX9yJHHNlJNVQ9MBfnyedNyeA/LXuodnvUJ4gZIk2cqoQC2R8PqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5sLe9dG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712084268; x=1743620268;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oHHhLiXrvdlW3ySm9j6oZQXbKS0fRwGJ00mNlGSOOS4=;
  b=j5sLe9dGgA6Zf6dv8cgiMXLB2tS2v4nslwMuJW2b9Lwtnd6sYgTm612j
   tP0NJs5+r5OuEVpe2o558Ou4FKY4ZbjfyEDT9vikjWt3WT26SA4eednIE
   CEPEcsOia4+9cKzJ/eY5o3jGhEc7ITadNXwaZ+5dVlN709mqSiZMSaLmN
   11A8g2cqhTQs4JTojVy3goj2cW+MDmrlTRAc7knq8gysjZfP7m0I2ek55
   m+Yj22Bm3CgP4ntyf3KQVS81INxGvJu/G+JoLY3dWAJ3ae2P2ONxUON1R
   jifThiezmMt6RuP3P5sAHgZEh3XH3bhEajcZU6SnuNNbgLFa97Uo88PNX
   Q==;
X-CSE-ConnectionGUID: a4wIp7GDRTmnVUkcLlA5dQ==
X-CSE-MsgGUID: PHoNxnM5TvOv6KGY3gg5Ag==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7208572"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7208572"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 11:57:47 -0700
X-CSE-ConnectionGUID: y3CTlOWPRNK8o2fwxw992g==
X-CSE-MsgGUID: nDFkxNfgSbOpki0kU8dD4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="22874766"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 11:57:46 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: nirmal.patel@linux.intel.com,
	<linux-pci@vger.kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2] PCI: vmd: Disable MSI remap only for low MSI count
Date: Tue,  2 Apr 2024 14:34:41 -0400
Message-Id: <20240402183441.142596-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMD MSI remapping is disabled by default for all the CPUs with 28c0 VMD
device. Initially MSI remapping was disabled for 28c0 to improve
performance since VMD had only 64 MSIx vectors. Newer CPU with more VMD
vectors don't see the performance impact anymore. Keep MSI remapping
enabled when vector count is more than active CPU in the system.

Note, pci_msix_vec_count() failure is translated to ENODEV per typical
expectations that drivers may return ENODEV when some driver-known
fundamental detail of the device is missing.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
---
v1->v2: Updating commit message.
---
 drivers/pci/controller/vmd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..d56ad4126815 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -807,13 +807,20 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	sd->node = pcibus_to_node(vmd->dev->bus);
 
+	vmd->msix_count = pci_msix_vec_count(vmd->dev);
+	if (vmd->msix_count < 0)
+		return -ENODEV;
+
 	/*
 	 * Currently MSI remapping must be enabled in guest passthrough mode
 	 * due to some missing interrupt remapping plumbing. This is probably
 	 * acceptable because the guest is usually CPU-limited and MSI
 	 * remapping doesn't become a performance bottleneck.
+	 * There is no need to disable MSI remapping when VMD MSI count is
+	 * more than cpus.
 	 */
 	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
+	    vmd->msix_count >= nr_cpu_ids ||
 	    offset[0] || offset[1]) {
 		ret = vmd_alloc_irqs(vmd);
 		if (ret)
-- 
2.31.1


