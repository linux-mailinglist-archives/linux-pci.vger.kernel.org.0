Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFE54976A2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbiAXAbE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:31:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:40965 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240611AbiAXAbD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984263; x=1674520263;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9phvsEdVa2NG/oq5IvGjMBe+GhzMW82MW8Sk8mr3eO8=;
  b=Z39eAnVL4l+JKRvTMoKeiKUz2vSK+gCkh2e+e5uT4LcnVVWVmOtzME2w
   zTEvwGEEGCUqNqzlWBPcqC2CrIF2Iqw+1zcpL5grTUTTFpGJ+rQVuWQfe
   mICieFRtfsD7lOB1gr3bQ6/kyoa5ttwEHzmTyXIkZYAk5raRhPhXJXgmh
   95fZ3S96K3gBe59poOg/GjmGJTyZuV1jL8Rmtv2V23sUzbGeihqJ47ysY
   t8dtMA/RX60NtWHqtFQMtuko34ffr0hqRXr5BGxN7LD5mTPqi9YG6MLbB
   WpCGGMq9DfPP2jMOPmvKPWlfO5jhn9NDB5C/7Sn8O5EXjqtEKtNeebdPj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="225915283"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="225915283"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:31:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="768517306"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:31:03 -0800
Subject: [PATCH v3 27/40] cxl/pci: Cache device DVSEC offset
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:31:02 -0800
Message-ID: <164298426273.3018233.9302136088649279124.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

The PCIe device DVSEC, defined in the CXL 2.0 spec, 8.1.3 is required to
be implemented by CXL 2.0 endpoint devices. Since the information
contained within this DVSEC will be critically important, it makes sense
to find the value early, and error out if it cannot be found.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxlmem.h |    2 ++
 drivers/cxl/pci.c    |    9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 90d67fff5bed..cedc6d3c0448 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -98,6 +98,7 @@ struct cxl_mbox_cmd {
  *
  * @dev: The device associated with this CXL state
  * @regs: Parsed register blocks
+ * @device_dvsec: Offset to the PCIe device DVSEC
  * @payload_size: Size of space for payload
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
  * @lsa_size: Size of Label Storage Area
@@ -126,6 +127,7 @@ struct cxl_dev_state {
 	struct device *dev;
 
 	struct cxl_regs regs;
+	int device_dvsec;
 
 	size_t payload_size;
 	size_t lsa_size;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index e54dbdf9ac15..76de39b90351 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -408,6 +408,15 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlds))
 		return PTR_ERR(cxlds);
 
+	cxlds->device_dvsec = pci_find_dvsec_capability(pdev,
+							PCI_DVSEC_VENDOR_ID_CXL,
+							CXL_DVSEC_PCIE_DEVICE);
+	if (!cxlds->device_dvsec) {
+		dev_err(&pdev->dev,
+			"Device DVSEC not present. Expect limited functionality.\n");
+		return -ENXIO;
+	}
+
 	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
 		return rc;

