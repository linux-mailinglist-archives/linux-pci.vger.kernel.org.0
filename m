Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5F01E3237
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 00:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391271AbgEZWRk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 18:17:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:7297 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389638AbgEZWRk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 18:17:40 -0400
IronPort-SDR: L8MtWR+/i5iHSz4CbrtfAQ72Pvgc8uU2hUFyN1E9rHbkUEag+yr8k1vWGAGSymn4ol6tWEi298
 UpxgaDrnjf6A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 15:17:39 -0700
IronPort-SDR: LQRNBHg29mtUm+BYhW/F0JYJJY+Cx1gdDil/ex+yWAzjp61fCcXcLRRNl6lMtygMxkLl6ENDcN
 YPLwPdtukCtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; 
   d="scan'208";a="468512269"
Received: from otc-nc-03.jf.intel.com ([10.54.39.25])
  by fmsmga006.fm.intel.com with ESMTP; 26 May 2020 15:17:39 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Darrel Goeddel <DGoeddel@forcepoint.com>,
        Mark Scott <mscott@forcepoint.com>,
        Romil Sharma <rsharma@forcepoint.com>
Subject: [PATCH] iommu: Relax ACS requirement for Intel RCiEP devices.
Date:   Tue, 26 May 2020 15:17:35 -0700
Message-Id: <1590531455-19757-1-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All Intel platforms guarantee that all root complex implementations
must send transactions up to IOMMU for address translations. Hence for
RCiEP devices that are Vendor ID Intel, can claim exception for lack of
ACS support.


3.16 Root-Complex Peer to Peer Considerations
When DMA remapping is enabled, peer-to-peer requests through the
Root-Complex must be handled
as follows:
• The input address in the request is translated (through first-level,
  second-level or nested translation) to a host physical address (HPA).
  The address decoding for peer addresses must be done only on the
  translated HPA. Hardware implementations are free to further limit
  peer-to-peer accesses to specific host physical address regions
  (or to completely disallow peer-forwarding of translated requests).
• Since address translation changes the contents (address field) of
  the PCI Express Transaction Layer Packet (TLP), for PCI Express
  peer-to-peer requests with ECRC, the Root-Complex hardware must use
  the new ECRC (re-computed with the translated address) if it
  decides to forward the TLP as a peer request.
• Root-ports, and multi-function root-complex integrated endpoints, may
  support additional peerto-peer control features by supporting PCI Express
  Access Control Services (ACS) capability. Refer to ACS capability in
  PCI Express specifications for details.

Since Linux didn't give special treatment to allow this exception, certain
RCiEP MFD devices are getting grouped in a single iommu group. This
doesn't permit a single device to be assigned to a guest for instance.

In one vendor system: Device 14.x were grouped in a single IOMMU group.

/sys/kernel/iommu_groups/5/devices/0000:00:14.0
/sys/kernel/iommu_groups/5/devices/0000:00:14.2
/sys/kernel/iommu_groups/5/devices/0000:00:14.3

After the patch:
/sys/kernel/iommu_groups/5/devices/0000:00:14.0
/sys/kernel/iommu_groups/5/devices/0000:00:14.2
/sys/kernel/iommu_groups/6/devices/0000:00:14.3 <<< new group

14.0 and 14.2 are integrated devices, but legacy end points.
Whereas 14.3 was a PCIe compliant RCiEP.

00:14.3 Network controller: Intel Corporation Device 9df0 (rev 30)
Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00

This permits assigning this device to a guest VM.

Fixes: f096c061f552 ("iommu: Rework iommu_group_get_for_pci_dev()")
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
To: Joerg Roedel <joro@8bytes.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Darrel Goeddel <DGoeddel@forcepoint.com>
Cc: Mark Scott <mscott@forcepoint.com>,
Cc: Romil Sharma <rsharma@forcepoint.com>
Cc: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/iommu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2b471419e26c..31b595dfedde 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1187,7 +1187,18 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
 	struct pci_dev *tmp = NULL;
 	struct iommu_group *group;
 
-	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
+	/*
+	 * Intel VT-d Specification Section 3.16, Root-Complex Peer to Peer
+	 * Considerations manadate that all transactions in RCiEP's and
+	 * even Integrated MFD's *must* be sent up to the IOMMU. P2P is
+	 * only possible on translated addresses. This gives enough
+	 * guarantee that such devices can be forgiven for lack of ACS
+	 * support.
+	 */
+	if (!pdev->multifunction ||
+	    (pdev->vendor == PCI_VENDOR_ID_INTEL &&
+	     pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END) ||
+	     pci_acs_enabled(pdev, REQ_ACS_FLAGS))
 		return NULL;
 
 	for_each_pci_dev(tmp) {
-- 
2.7.4

