Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0E9E6E8D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 09:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbfJ1Iyo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 04:54:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41498 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730954AbfJ1Iyn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 04:54:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id l3so6460249pgr.8
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2019 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7H6mKTh9zqXvYcy1Ua/XMd20wDfeej2CMStIpNchhTw=;
        b=N5nPdIZ4q7Aq0XXxne5lc8oSpDsdue75MjJhQbt611aYDKsSLPsg9RDWo6DsU2AcuL
         QVVGogrCKr9KnK9OCLRYj6xH1DrYh3hSSwNdzGRRSd9hBfD1HEIzopHu4xztvApzhvhb
         VrQzeJMGLI8oYIE5Zof0T8gbAqQBMmWfpq2agZopq5IrTD89oh91ZHT3vyvqwtFc4j42
         dmS1qYkH4g/fo4YZBKmJiovXyOKviT+Gd6nynRLB/Saew38voSvgvByDaitfP1EE7XsD
         KcFT9imbXVUvcP9UUSI0PByFW1hj/l/fgS2KAGVr/GbCYNEw/ZzovGeP6UcpfugQLoPD
         a08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7H6mKTh9zqXvYcy1Ua/XMd20wDfeej2CMStIpNchhTw=;
        b=czeP7AgTwbIvPxFmFvLHIgV32U/awfS5BRc/xibUjwinCrHfbc4qmqHd/d/3jcgIFN
         fWaZXJsS+tZFIelPxKysxFOR+yhbK7sqph154duUqDMVLDdxRYSOdSjd+3xmwyQLprNH
         IY1bENhzGfUHlgEoRwKzdh/AbyZ/kP+a+KTF76EPdkqH/BaheppIgiTXZZJKDq7ce2C0
         U14tytMYPuEguzvbB8ChOI8RYHWD91zxWynBaOvt/Ah7AWtgsjg/NxsibT6Qq47/OPqg
         z+Rzr5/l2PqJpAwcxstQu601jUvVEtfntx8L/xMrHNa1x5AyRdzRNuI8w8b2+IBj/g+p
         q8Mw==
X-Gm-Message-State: APjAAAUwU/bTRar5QRNV+FCgMp2VEXfFgVRwb+h6KmtsmrgJQHGLULqH
        EAoIQP+xyqxLGzIZ9Hi+MaFY4XXaVH0=
X-Google-Smtp-Source: APXvYqxUV43b7g9mMcqrN31QguLDDNjtEwSPvccNFhr/Ei5Vy6JN7s2fJnlfHWr8ItTacgAdU+8OYg==
X-Received: by 2002:a63:2c2:: with SMTP id 185mr17549116pgc.219.1572252882682;
        Mon, 28 Oct 2019 01:54:42 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id l24sm10046115pff.151.2019.10.28.01.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 01:54:41 -0700 (PDT)
From:   Oliver O'Halloran <oohall@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     aik@ozlabs.ru, shawn@anastas.io, linux-pci@vger.kernel.org,
        Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH v2 1/3] powernv/iov: Ensure the pdn for VFs always contains a valid PE number
Date:   Mon, 28 Oct 2019 19:54:22 +1100
Message-Id: <20191028085424.12006-1-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On pseries there is a bug with adding hotplugged devices to an IOMMU group.
For a number of dumb reasons fixing that bug first requires re-working how
VFs are configured on PowerNV. For background, on PowerNV we use the
pcibios_sriov_enable() hook to do two things:

1. Create a pci_dn structure for each of the VFs, and
2. Configure the PHB's internal BARs so the MMIO range for each VF
   maps to a unique PE.

Roughly speaking a PE is the hardware counterpart to a Linux IOMMU group
since all the devices in a PE share the same IOMMU table. A PE also defines
the set of devices that should be isolated in response to a PCI error (i.e.
bad DMA, UR/CA, AER events, etc). When isolated all MMIO and DMA traffic to
and from devicein the PE is blocked by the root complex until the PE is
recovered by the OS.

The requirement to block MMIO causes a giant headache because the P8 PHB
generally uses a fixed mapping between MMIO addresses and PEs.  As a result
we need to delay configuring the IOMMU groups for device until after MMIO
resources are assigned. For physical devices (i.e. non-VFs) the PE
assignment is done in pcibios_setup_bridge() which is called immediately
after the MMIO resources for downstream devices (and the bridge's windows)
are assigned. For VFs the setup is more complicated because:

a) pcibios_setup_bridge() is not called again when VFs are activated, and
b) The pci_dev for VFs are created by generic code which runs after
   pcibios_sriov_enable() is called.

The work around for this is a two step process:

1. A fixup in pcibios_add_device() is used to initialised the cached
   pe_number in pci_dn, then
2. A bus notifier then adds the device to the IOMMU group for the PE
   specified in pci_dn->pe_number.

A side effect fixing the pseries bug mentioned in the first paragraph is
moving the fixup out of pcibios_add_device() and into
pcibios_bus_add_device(), which is called much later. This results in step
2. failing because pci_dn->pe_number won't be initialised when the bus
notifier is run.

We can fix this by removing the need for the fixup. The PE for a VF is
known before the VF is even scanned so we can initialise pci_dn->pe_number
pcibios_sriov_enable() instead. Unfortunately, moving the initialisation
causes two problems:

1. We trip the WARN_ON() in the current fixup code, and
2. The EEH core clears pdn->pe_number when recovering a VF and relies
   on the fixup to correctly re-set it.

The only justification for either of these is a comment in eeh_rmv_device()
suggesting that pdn->pe_number *must* be set to IODA_INVALID_PE in order
for the VF to be scanned. However, this comment appears to have no basis
in reality. Both bugs can be fixed by just deleting the code.

Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
v2: Re-wrote commit message, got very depressed about the state of things.

    The real fix here is to move the IOMMU group setup for both VFs and
    PFs into pcibios_bus_add_device() and kill the pcibios_setup_bridge()
    hack and the bus notifier hack, but doing that requires some pretty
    gnarly changes. The fix here is much less invasive.
---
 arch/powerpc/kernel/eeh_driver.c          |  6 ------
 arch/powerpc/platforms/powernv/pci-ioda.c | 19 +++++++++++++++----
 arch/powerpc/platforms/powernv/pci.c      |  4 ----
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index d9279d0..7955fba 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -541,12 +541,6 @@ static void eeh_rmv_device(struct eeh_dev *edev, void *userdata)
 
 		pci_iov_remove_virtfn(edev->physfn, pdn->vf_index);
 		edev->pdev = NULL;
-
-		/*
-		 * We have to set the VF PE number to invalid one, which is
-		 * required to plug the VF successfully.
-		 */
-		pdn->pe_number = IODA_INVALID_PE;
 #endif
 		if (rmv_data)
 			list_add(&edev->rmv_entry, &rmv_data->removed_vf_list);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5e3172d..70508b3 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1558,6 +1558,10 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 
 	/* Reserve PE for each VF */
 	for (vf_index = 0; vf_index < num_vfs; vf_index++) {
+		int vf_devfn = pci_iov_virtfn_devfn(pdev, vf_index);
+		int vf_bus = pci_iov_virtfn_bus(pdev, vf_index);
+		struct pci_dn *vf_pdn;
+
 		if (pdn->m64_single_mode)
 			pe_num = pdn->pe_num_map[vf_index];
 		else
@@ -1570,13 +1574,11 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 		pe->pbus = NULL;
 		pe->parent_dev = pdev;
 		pe->mve_number = -1;
-		pe->rid = (pci_iov_virtfn_bus(pdev, vf_index) << 8) |
-			   pci_iov_virtfn_devfn(pdev, vf_index);
+		pe->rid = (vf_bus << 8) | vf_devfn;
 
 		pe_info(pe, "VF %04d:%02d:%02d.%d associated with PE#%x\n",
 			hose->global_number, pdev->bus->number,
-			PCI_SLOT(pci_iov_virtfn_devfn(pdev, vf_index)),
-			PCI_FUNC(pci_iov_virtfn_devfn(pdev, vf_index)), pe_num);
+			PCI_SLOT(vf_devfn), PCI_FUNC(vf_devfn), pe_num);
 
 		if (pnv_ioda_configure_pe(phb, pe)) {
 			/* XXX What do we do here ? */
@@ -1590,6 +1592,15 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 		list_add_tail(&pe->list, &phb->ioda.pe_list);
 		mutex_unlock(&phb->ioda.pe_list_mutex);
 
+		/* associate this pe to it's pdn */
+		list_for_each_entry(vf_pdn, &pdn->parent->child_list, list) {
+			if (vf_pdn->busno == vf_bus &&
+			    vf_pdn->devfn == vf_devfn) {
+				vf_pdn->pe_number = pe_num;
+				break;
+			}
+		}
+
 		pnv_pci_ioda2_setup_dma_pe(phb, pe);
 #ifdef CONFIG_IOMMU_API
 		iommu_register_group(&pe->table_group,
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 2825d00..b7761e2 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -816,16 +816,12 @@ void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 	struct pnv_phb *phb = hose->private_data;
 #ifdef CONFIG_PCI_IOV
 	struct pnv_ioda_pe *pe;
-	struct pci_dn *pdn;
 
 	/* Fix the VF pdn PE number */
 	if (pdev->is_virtfn) {
-		pdn = pci_get_pdn(pdev);
-		WARN_ON(pdn->pe_number != IODA_INVALID_PE);
 		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
 			if (pe->rid == ((pdev->bus->number << 8) |
 			    (pdev->devfn & 0xff))) {
-				pdn->pe_number = pe->pe_number;
 				pe->pdev = pdev;
 				break;
 			}
-- 
2.9.5

