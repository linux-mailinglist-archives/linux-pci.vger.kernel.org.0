Return-Path: <linux-pci+bounces-24233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E113A6A87E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 15:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2723B64BE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DA81DF25C;
	Thu, 20 Mar 2025 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CO+b5Kp5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739FB1EB1B7;
	Thu, 20 Mar 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480929; cv=none; b=ZWSw1vU+MrIpLeupOVI6+5iyyn7kkho9Xa3MJ/zrO7qxLAifk0RY+s94ZAR0DB+cn8FCkRlO3XU7G4g2GINQBJEcsbONViSCCPjgep3hJcCdtOCXmHdqBYlG/YiXO57Ho39OoXyb6mXKBIADb4v9KOGZt/cfCT8c341NEucAPm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480929; c=relaxed/simple;
	bh=pmp2fvoZbSSIP/cR3+6X2bBT1jjNzPYdwRj2PDcPLvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cbdUUSSud+C3Zev6WeEyOJrWrobavMhlSxy509qzQ/jc8rim5kr93VpVcIlzb5Es9N0/2f2qaJ+FF8yUdaOYr9AIqxnQkM0SXyNr4Fr33cCK82vNX1taqqnVU+3rLYtNS2HamOvmIjJAauJLXSnEhQ/7EByFND5zSwd05Wh8S+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CO+b5Kp5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742480928; x=1774016928;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pmp2fvoZbSSIP/cR3+6X2bBT1jjNzPYdwRj2PDcPLvo=;
  b=CO+b5Kp5IRTFCAz90jaKOYg2sGolwE+c/WhBdTpMvBAHmYpfMzNNcWa3
   oANKpX5gSe17e1F1reswYWuC32b/AwW2XNXwQtHZZhHLrqdExMtrqXJOE
   eLVg5nG2rRUdqbxiPnno0/jKcV1KJn0k8pif4tnj8waqeQPxdzKR7kaiy
   laxZDnDnXIhTTlIF+FfnFZFSU/aIQ+876qOhsokWm+hNeGOirSLvpSRSQ
   K3Bnv+YFejhD+JAFIVSs4+cXhxU2R+iSX05StnD37T8BkPXKlS6fKb7+0
   g8K9QqxYLQyIjc8ikTVD357NCbsXtYW73XGCXq21IrSFIICAJnaDpOkNb
   g==;
X-CSE-ConnectionGUID: AMEqQg29SLeK/s8taWMldA==
X-CSE-MsgGUID: zcRdSFBdTE2vOFbHpTYPSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43727207"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="43727207"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 07:28:47 -0700
X-CSE-ConnectionGUID: IhYc5BhvSvm/LGBYGiRsQA==
X-CSE-MsgGUID: OlMNPw+tRei4NiWU4NDSHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="122919875"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.210])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 07:28:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Subject: [PATCH v3 1/1] PCI: Fix BAR resizing when VF BARs are assigned
Date: Thu, 20 Mar 2025 16:28:37 +0200
Message-Id: <20250320142837.8027-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__resource_resize_store() attempts to release all resources of the
device before attempting the resize. The loop, however, only covers
standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs that are
assigned, pci_reassign_bridge_resources() finds the bridge window still
has some assigned child resources and returns -NOENT which makes
pci_resize_resource() to detect an error and abort the resize.

Change the release loop to cover all resources up to VF BARs which
allows the resize operation to release the bridge windows and attempt
to assigned them again with the different size.

If SR-IOV is enabled, disallow resize as it requires releasing also IOV
resources.

Fixes: 91fa127794ac ("PCI: Expose PCIe Resizable BAR support via sysfs")
Reported-by: Michał Winiarski <michal.winiarski@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v3:
- Check that SR-IOV is not enabled before resizing

v2:
- Removed language about expansion ROMs

 drivers/pci/pci-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b46ce1a2c554..0e7eb2a42d88 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1556,7 +1556,7 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 		return -EINVAL;
 
 	device_lock(dev);
-	if (dev->driver) {
+	if (dev->driver || pci_num_vf(pdev)) {
 		ret = -EBUSY;
 		goto unlock;
 	}
@@ -1578,7 +1578,7 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 
 	pci_remove_resource_files(pdev);
 
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
 		if (pci_resource_len(pdev, i) &&
 		    pci_resource_flags(pdev, i) == flags)
 			pci_release_resource(pdev, i);

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.39.5


