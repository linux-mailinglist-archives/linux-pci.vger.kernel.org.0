Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2479497694
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbiAXAaV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:30:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:40918 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235274AbiAXAaU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984220; x=1674520220;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gKpdhZAaBNUuMaafJQnNa65ezDLaMTn1uNHY5ZzTzvo=;
  b=UhLLBveLnhXtL+68C1NK5vp9MgOed4MI9BcP9TWZ+DzSJdcL1iBIvb1p
   mx/64oCLsBGg4ulOK5NwXRy69o2RQR3wCNUR30xuqoTDrUyq/+HsxiaAR
   eqkjPtoXbcDqKE+E6pG9WT8Ya3dfJ9Rnq/ARPeNQsNCORklZbBE1vp7TK
   GH3bSDegE/AlDwb/+EwrVh9PsBemPNp6mV3k9fKD1vCnp/Ot+5LWZpqC0
   2FK/C071W82zWYhoiYyreT5OcYp4YI6M7+uZQ5iCsr7TxoacwI932NGmt
   NW5kc6eVnDsi5gJx01ufk5MrbIkDZYLbR6zCsDeCbCmpE2Zne8bJ705oi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="225915215"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="225915215"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:30:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="519730985"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:30:20 -0800
Subject: [PATCH v3 19/40] cxl/port: Up-level cxl_add_dport() locking
 requirements to the caller
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:30:20 -0800
Message-ID: <164298422000.3018233.4106867312927858722.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation for moving dport enumeration into the core, require the
port device lock to be acquired by the caller.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c            |    2 ++
 drivers/cxl/core/port.c       |    3 +--
 tools/testing/cxl/mock_acpi.c |    4 ++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index ab2b76532272..e596dc375267 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -342,7 +342,9 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 		return 0;
 	}
 
+	device_lock(&root_port->dev);
 	rc = cxl_add_dport(root_port, match, uid, ctx.chbcr);
+	device_unlock(&root_port->dev);
 	if (rc) {
 		dev_err(host, "failed to add downstream port: %s\n",
 			dev_name(match));
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index ec9587e52423..c51a10154e29 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -516,7 +516,7 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
 {
 	struct cxl_dport *dup;
 
-	cxl_device_lock(&port->dev);
+	device_lock_assert(&port->dev);
 	dup = find_dport(port, new->port_id);
 	if (dup)
 		dev_err(&port->dev,
@@ -525,7 +525,6 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
 			dev_name(dup->dport));
 	else
 		list_add_tail(&new->list, &port->dports);
-	cxl_device_unlock(&port->dev);
 
 	return dup ? -EEXIST : 0;
 }
diff --git a/tools/testing/cxl/mock_acpi.c b/tools/testing/cxl/mock_acpi.c
index 4c8a493ace56..667c032ccccf 100644
--- a/tools/testing/cxl/mock_acpi.c
+++ b/tools/testing/cxl/mock_acpi.c
@@ -57,7 +57,9 @@ static int match_add_root_port(struct pci_dev *pdev, void *data)
 
 	/* TODO walk DVSEC to find component register base */
 	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
+	device_lock(&port->dev);
 	rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
+	device_unlock(&port->dev);
 	if (rc) {
 		dev_err(dev, "failed to add dport: %s (%d)\n",
 			dev_name(&pdev->dev), rc);
@@ -78,7 +80,9 @@ static int mock_add_root_port(struct platform_device *pdev, void *data)
 	struct device *dev = ctx->dev;
 	int rc;
 
+	device_lock(&port->dev);
 	rc = cxl_add_dport(port, &pdev->dev, pdev->id, CXL_RESOURCE_NONE);
+	device_unlock(&port->dev);
 	if (rc) {
 		dev_err(dev, "failed to add dport: %s (%d)\n",
 			dev_name(&pdev->dev), rc);

