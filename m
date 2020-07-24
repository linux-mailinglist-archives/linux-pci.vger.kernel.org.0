Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB9922CBF4
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 19:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgGXRWc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 13:22:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:2758 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbgGXRWb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 13:22:31 -0400
IronPort-SDR: Qb0A5n7OLz27S5htWjpsuMUDYSY3Ps/ErPf/7hMQP7Vyu+dihtsTCNWsse5UZgc2nOp/OWAKr0
 0eBBaZtmyHPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="130823246"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="130823246"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:22:31 -0700
IronPort-SDR: BpDPFqNZRmEGycqgLI8FBRJBYTkz4LxUXiLZ8xt047fA2dFY8fQfCgtOk4Zx03B5kjwfM+MCoa
 GZ/0TklebrQg==
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="302730275"
Received: from seokjaeb-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.24.239])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:22:30 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@kernel.org, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [RFC PATCH 2/9] PCI: Extend Root Port Driver to support RCEC
Date:   Fri, 24 Jul 2020 10:22:16 -0700
Message-Id: <20200724172223.145608-3-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724172223.145608-1-sean.v.kelley@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

If a Root Complex Integrated Endpoint (RCiEP) is implemented, errors may
optionally be sent to a corresponding Root Complex Event Collector (RCEC).
Each RCiEP must be associated with no more than one RCEC. Interface errors
are reported to the OS by RCECs.

For an RCEC (technically not a Bridge), error messages "received" from
associated RCiEPs must be enabled for "transmission" in order to cause a
System Error via the Root Control register or (when the Advanced Error
Reporting Capability is present) reporting via the Root Error Command
register and logging in the Root Error Status register and Error Source
Identification register.

Given the commonality with Root Ports and the need to also support AER
and PME services for RCECs, extend the Root Port driver to support RCEC
devices through the addition of the RCEC Class ID to the driver
structure.

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/portdrv_pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 3acf151ae015..d5b109499b10 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -106,7 +106,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	if (!pci_is_pcie(dev) ||
 	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
 	     (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
-	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
+	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM) &&
+	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
 		return -ENODEV;
 
 	status = pcie_port_device_register(dev);
@@ -195,6 +196,8 @@ static const struct pci_device_id port_pci_ids[] = {
 	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
 	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
 	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
+	/* handle any Root Complex Event Collector */
+	{ PCI_DEVICE_CLASS(((PCI_CLASS_SYSTEM_RCEC << 8) | 0x00), ~0) },
 	{ },
 };
 
-- 
2.27.0

