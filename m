Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DD1692A32
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 23:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjBJWdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 17:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjBJWdv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 17:33:51 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1032122;
        Fri, 10 Feb 2023 14:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676068427; x=1707604427;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=pR1CO4fGX0zX/77VlHz6LJJtRsjIRqOd/EPNDg0FKN4=;
  b=l5mxGiw9oGegyuKI84XDIQhPYM4cV1RRoXmaWwnsgF7nkr27ZYRqbmFf
   rFQU/mPnY5NIFZfC8l/eNYowXlluZdGaeBZi9L+Z7oH7P/8fqS7+xAZvD
   eJkYJqbt4IJdXKF0ZVzLW9yd45i6zubS/9xwDIelYwStipJ625Vb/UZqA
   lHhtUsBml8mgNGKkTuaWIgMWktWtZr9MLB2w5NW8i1sJPboua8xDgrz5S
   vF65fmt+D5ADdFs2oc+oKpMFKsHu517FTrFRzbwFR3Xq7D2kZcdJIx5SP
   ZPRAl0lY4WOZzU23nODdOtQhONG371916q0O0heU9vNsHeZ4Ri8Tyce4c
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="416766936"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="416766936"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 14:33:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="700624145"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="700624145"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.70.240])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 14:33:45 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Fri, 10 Feb 2023 14:33:23 -0800
Subject: [PATCH RFC] PCI/AER: Enable internal AER errors by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230209-cxl-pci-aer-v1-1-f9a817fa4016@intel.com>
X-B4-Tracking: v=1; b=H4sIADPG5mMC/x2NQQrCQAwAv1JyNrC7BWm9Cj7Aq3hIs9EGlrVkq
 RRK/27wOAPD7NDEVBpcuh1Mvtr0Ux3iqQOeqb4FNTtDCqkPKYzIW8GFFUkM45AznSMPqR/Bi4m
 a4GRUefamrqW4XExeuv0XD7jfrvA8jh9tCYHMdwAAAA==
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, Stefan Roese <sr@denx.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676068425; l=3060;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=pR1CO4fGX0zX/77VlHz6LJJtRsjIRqOd/EPNDg0FKN4=;
 b=3gNeuhIE1BaE04Aim9tnTthinw/4LA+7yLTjBnO8gGUzW2sdpOgvErYPebdih+13TlsLOCjpPZUv
 zSJGeLxpB7zBCh1i+fLENggLlNM8qNAkifL9PSc8Gwe1eYSJ0PZQ
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The CXL driver expects internal error reporting to be enabled via
pci_enable_pcie_error_reporting().  It is likely other drivers expect the same.
Dave submitted a patch to enable the CXL side[1] but the PCI AER registers
still mask errors.

PCIe v6.0 Uncorrectable Mask Register (7.8.4.3) and Correctable Mask
Register (7.8.4.6) default to masking internal errors.  The
Uncorrectable Error Severity Register (7.8.4.4) defaults internal errors
as fatal.

Enable internal errors to be reported via the standard
pci_enable_pcie_error_reporting() call.  Ensure uncorrectable errors are set
non-fatal to limit any impact to other drivers.

[1] https://lore.kernel.org/all/167604864163.2392965.5102660329807283871.stgit@djiang5-mobl3.local/

Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Stefan Roese <sr@denx.de>
Cc: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Oliver O'Halloran <oohall@gmail.com>
Cc: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
This is RFC to see if it is acceptable to be part of the standard
pci_enable_pcie_error_reporting() call or perhaps a separate pci core
call should be introduced.  It is anticipated that enabling this error
reporting is what existing drivers are expecting.  The errors are marked
non-fatal therefore it should not adversely affect existing devices.
---
 drivers/pci/pcie/aer.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 625f7b2cafe4..9d3ed3a5fc23 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -229,11 +229,28 @@ int pcie_aer_is_native(struct pci_dev *dev)
 
 int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
+	int pos_cap_err;
+	u32 reg;
 	int rc;
 
 	if (!pcie_aer_is_native(dev))
 		return -EIO;
 
+	pos_cap_err = dev->aer_cap;
+
+	/* Unmask correctable and uncorrectable (non-fatal) internal errors */
+	pci_read_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK, &reg);
+	reg &= ~PCI_ERR_COR_INTERNAL;
+	pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK, reg);
+
+	pci_read_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_SEVER, &reg);
+	reg &= ~PCI_ERR_UNC_INTN;
+	pci_write_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_SEVER, reg);
+
+	pci_read_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_MASK, &reg);
+	reg &= ~PCI_ERR_UNC_INTN;
+	pci_write_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_MASK, reg);
+
 	rc = pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
 	return pcibios_err_to_errno(rc);
 }

---
base-commit: e5ab7f206ffc873160bd0f1a52cae17ab692a9d1
change-id: 20230209-cxl-pci-aer-18dda61c8239

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

