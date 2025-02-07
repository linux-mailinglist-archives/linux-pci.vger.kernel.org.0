Return-Path: <linux-pci+bounces-20911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0DEA2C89B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFC1188B106
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E967318BB9C;
	Fri,  7 Feb 2025 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vhs65qZ2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE45189B94;
	Fri,  7 Feb 2025 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945392; cv=none; b=T8iUTkmotH/GNuJ/IGlPSCsH6aeVzCRGCQLq4FQs1dpYqkXuR2hgkptHCMPvIGdqRfCDjxxiMiNwX5O2CuL9fCA4e5ooi4/nPxbnMo/2kJp06EY993oY/17araVOF3yfgbnhu4QB0I7kOYRBtbfK//B+rEOJ+XJImgNxjbJKhJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945392; c=relaxed/simple;
	bh=whCYzTnNytr7VcqUble5w8K5UFVk9Nv8AzFfMYiEqW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=a9UNBL0s/+x7A3DzmZoUP1ipYjIBVT6BZTJtDsaJnr1yMvawN3XbWHGa6Lw89g+8LsRE5Vicij5jY1h+JvXxhoYRn37qULcpMQnOdvTd3YPW4KqjoC+Lc3YMOdQVALqmRvRL7PwWgqE08b74MkhI/tB9xKpHWSptLgsTNbPQJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vhs65qZ2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738945391; x=1770481391;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=whCYzTnNytr7VcqUble5w8K5UFVk9Nv8AzFfMYiEqW4=;
  b=Vhs65qZ251mGPIAPQolOmeFMNbfVMHtr8/jNAhcPi2c6IMmbGTCV0YEE
   8SZaHwAClrC4NLnL9+NNJUvFou+PNcpw0kJ/qzwMkdC/NSX42oc92Baf5
   tmwgvn1DMzHYB6evQXoOA7TUib5Qm4f2pSX9YKYFZWqS8xepuoTQxqv0w
   4gxc8Q9AT7oajvnXZwrtCRhgdyTB8dT6javfpWD01BA2wc6jMGaxUuNUN
   cBNZAWvWGK7OAxQ000AFehwkalTWd3oIrM6dMBP6j7qVJfyXgznvRAjrM
   lTzqP1tQ7JYo1WNS6OtxcaoJ0oxva6iVHBYe5V7M75f5QJXTpIGHWgElD
   Q==;
X-CSE-ConnectionGUID: GV7feD1LRA6+oMzS9JXdOg==
X-CSE-MsgGUID: zA10FSpeROCoCILlJ3tyRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="38822160"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="38822160"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:23:10 -0800
X-CSE-ConnectionGUID: kigaWAt4SQKCSzyrh3bYVQ==
X-CSE-MsgGUID: fOhFIS8dQqygyyCb/qvOxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="111483494"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:23:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Cleanup dev->resource + resno to use pci_resource_n()
Date: Fri,  7 Feb 2025 18:23:01 +0200
Message-Id: <20250207162301.2842-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace pointer arithmentic in finding the correct resource entry with
the pci_resource_n() helper.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/iov.c       |  2 +-
 drivers/pci/pci.c       |  2 +-
 drivers/pci/quirks.c    |  4 ++--
 drivers/pci/setup-res.c | 12 ++++++------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9e4770cdd4d5..121540f57d4b 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -952,7 +952,7 @@ void pci_iov_remove(struct pci_dev *dev)
 void pci_iov_update_resource(struct pci_dev *dev, int resno)
 {
 	struct pci_sriov *iov = dev->is_physfn ? dev->sriov : NULL;
-	struct resource *res = dev->resource + resno;
+	struct resource *res = pci_resource_n(dev, resno);
 	int vf_bar = resno - PCI_IOV_RESOURCES;
 	struct pci_bus_region region;
 	u16 cmd;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..c4f710f782f6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1884,7 +1884,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
 
 		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
 		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
-		res = pdev->resource + bar_idx;
+		res = pci_resource_n(pdev, bar_idx);
 		size = pci_rebar_bytes_to_size(resource_size(res));
 		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
 		ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b84ff7bade82..5cc4610201b7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -621,7 +621,7 @@ static void quirk_io(struct pci_dev *dev, int pos, unsigned int size,
 {
 	u32 region;
 	struct pci_bus_region bus_region;
-	struct resource *res = dev->resource + pos;
+	struct resource *res = pci_resource_n(dev, pos);
 	const char *res_name = pci_resource_name(dev, pos);
 
 	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0 + (pos << 2), &region);
@@ -671,7 +671,7 @@ static void quirk_io_region(struct pci_dev *dev, int port,
 {
 	u16 region;
 	struct pci_bus_region bus_region;
-	struct resource *res = dev->resource + nr;
+	struct resource *res = pci_resource_n(dev, nr);
 
 	pci_read_config_word(dev, port, &region);
 	region &= ~(size - 1);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index ca14576bf2bf..ad6436007148 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -29,7 +29,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 	u16 cmd;
 	u32 new, check, mask;
 	int reg;
-	struct resource *res = dev->resource + resno;
+	struct resource *res = pci_resource_n(dev, resno);
 	const char *res_name = pci_resource_name(dev, resno);
 
 	/* Per SR-IOV spec 3.4.1.11, VF BARs are RO zero */
@@ -262,7 +262,7 @@ resource_size_t __weak pcibios_align_resource(void *data,
 static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 		int resno, resource_size_t size, resource_size_t align)
 {
-	struct resource *res = dev->resource + resno;
+	struct resource *res = pci_resource_n(dev, resno);
 	resource_size_t min;
 	int ret;
 
@@ -325,7 +325,7 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
 
 int pci_assign_resource(struct pci_dev *dev, int resno)
 {
-	struct resource *res = dev->resource + resno;
+	struct resource *res = pci_resource_n(dev, resno);
 	const char *res_name = pci_resource_name(dev, resno);
 	resource_size_t align, size;
 	int ret;
@@ -372,7 +372,7 @@ EXPORT_SYMBOL(pci_assign_resource);
 int pci_reassign_resource(struct pci_dev *dev, int resno,
 			  resource_size_t addsize, resource_size_t min_align)
 {
-	struct resource *res = dev->resource + resno;
+	struct resource *res = pci_resource_n(dev, resno);
 	const char *res_name = pci_resource_name(dev, resno);
 	unsigned long flags;
 	resource_size_t new_size;
@@ -411,7 +411,7 @@ int pci_reassign_resource(struct pci_dev *dev, int resno,
 
 void pci_release_resource(struct pci_dev *dev, int resno)
 {
-	struct resource *res = dev->resource + resno;
+	struct resource *res = pci_resource_n(dev, resno);
 	const char *res_name = pci_resource_name(dev, resno);
 
 	pci_info(dev, "%s %pR: releasing\n", res_name, res);
@@ -428,7 +428,7 @@ EXPORT_SYMBOL(pci_release_resource);
 
 int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 {
-	struct resource *res = dev->resource + resno;
+	struct resource *res = pci_resource_n(dev, resno);
 	struct pci_host_bridge *host;
 	int old, ret;
 	u32 sizes;

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.39.5


