Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70631E6CF1
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 22:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407319AbgE1U5y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 16:57:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:34385 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406652AbgE1U5w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 May 2020 16:57:52 -0400
IronPort-SDR: KLyWNveOuxdJQO1WWOZCqffoltcSpHa4n4GED4KHfeFuXaU7jtYdTHb6vl0CKYRv3WO8LZ0/s8
 cYc10AEnGrmw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 13:57:51 -0700
IronPort-SDR: g97HzgpaCyP0RNtnAdIcT04mBb3TUUtTVMkD+bqeBN0v9vYO4vCsG/uu90zlloqNGBS/nnZ5Ha
 1pR/6s9+n1sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; 
   d="scan'208";a="285292590"
Received: from ssp-nc-cdi361.jf.intel.com (HELO otc-nc-03.jf.intel.com) ([10.54.39.25])
  by orsmga002.jf.intel.com with ESMTP; 28 May 2020 13:57:51 -0700
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
Subject: [PATCH] PCI: Relax ACS requirement for Intel RCiEP devices.
Date:   Thu, 28 May 2020 13:57:42 -0700
Message-Id: <1590699462-7131-1-git-send-email-ashok.raj@intel.com>
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
v2: Moved functionality from iommu to pci quirks - Alex Williamson

 drivers/pci/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 28c9a2409c50..63373ca0a3fe 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4682,6 +4682,20 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
 		PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
 }
 
+static int pci_quirk_rciep_acs(struct pci_dev *dev, u16 acs_flags)
+{
+	/*
+	 * RCiEP's are required to allow p2p only on translated addresses.
+	 * Refer to Intel VT-d specification Section 3.16 Root-Complex Peer
+	 * to Peer Considerations
+	 */
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END)
+		return -ENOTTY;
+
+	return pci_acs_ctrl_enabled(acs_flags,
+		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
+}
+
 static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	/*
@@ -4764,6 +4778,7 @@ static const struct pci_dev_acs_enabled {
 	/* I219 */
 	{ PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_rciep_acs },
 	/* QCOM QDF2xxx root ports */
 	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
 	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
-- 
2.7.4

