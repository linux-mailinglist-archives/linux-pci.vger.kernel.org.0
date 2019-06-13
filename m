Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7069644FB0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 00:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfFMW5Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 18:57:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbfFMW5P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 18:57:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C9A55944C;
        Thu, 13 Jun 2019 22:57:15 +0000 (UTC)
Received: from gimli.home (ovpn-116-190.phx2.redhat.com [10.3.116.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6279445CA;
        Thu, 13 Jun 2019 22:57:12 +0000 (UTC)
Subject: [PATCH 1/2] Revert: PCI/IOV: Use VF0 cached config space size for
 other VFs
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     KarimAllah Ahmed <karahmed@amazon.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Hao Zheng <yinhe@linux.alibaba.com>, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, nanhai.zou@linux.alibaba.com,
        quan.xu0@linux.alibaba.com, ashok.raj@intel.com,
        keith.busch@intel.com, mike.campin@intel.com
Date:   Thu, 13 Jun 2019 16:57:12 -0600
Message-ID: <156046663197.29869.3633634445109057665.stgit@gimli.home>
In-Reply-To: <156046609596.29869.5839964168034189416.stgit@gimli.home>
References: <156046609596.29869.5839964168034189416.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 13 Jun 2019 22:57:15 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
other VFs") attempts to cache the config space size from the first VF
to re-use for subsequent VFs, but the cached value is determined prior
to discovering the PCIe capability on the VF.  This results in the
first VF reporting the correct config space size (4K), as it has a
special case through pci_cfg_space_size(), while all the other VFs
only report 256 bytes.  As this is only a performance optimization,
we're better off without it.

Fixes: 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for other VFs")
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Hao Zheng <yinhe@linux.alibaba.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/iov.c   |    2 --
 drivers/pci/pci.h   |    1 -
 drivers/pci/probe.c |   17 -----------------
 3 files changed, 20 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 3aa115ed3a65..525fd3f272b3 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -132,8 +132,6 @@ static void pci_read_vf_config_common(struct pci_dev *virtfn)
 			     &physfn->sriov->subsystem_vendor);
 	pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
 			     &physfn->sriov->subsystem_device);
-
-	physfn->sriov->cfg_size = pci_cfg_space_size(virtfn);
 }
 
 int pci_iov_add_virtfn(struct pci_dev *dev, int id)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9cb99380c61e..3fc227ef0815 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -293,7 +293,6 @@ struct pci_sriov {
 	u16		driver_max_VFs;	/* Max num VFs driver supports */
 	struct pci_dev	*dev;		/* Lowest numbered PF */
 	struct pci_dev	*self;		/* This PF */
-	u32		cfg_size;	/* VF config space size */
 	u32		class;		/* VF device */
 	u8		hdr_type;	/* VF header type */
 	u16		subsystem_vendor; /* VF subsystem vendor */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0e8e2c186f50..a3a3c6b28343 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1555,29 +1555,12 @@ static int pci_cfg_space_size_ext(struct pci_dev *dev)
 	return PCI_CFG_SPACE_EXP_SIZE;
 }
 
-#ifdef CONFIG_PCI_IOV
-static bool is_vf0(struct pci_dev *dev)
-{
-	if (pci_iov_virtfn_devfn(dev->physfn, 0) == dev->devfn &&
-	    pci_iov_virtfn_bus(dev->physfn, 0) == dev->bus->number)
-		return true;
-
-	return false;
-}
-#endif
-
 int pci_cfg_space_size(struct pci_dev *dev)
 {
 	int pos;
 	u32 status;
 	u16 class;
 
-#ifdef CONFIG_PCI_IOV
-	/* Read cached value for all VFs except for VF0 */
-	if (dev->is_virtfn && !is_vf0(dev))
-		return dev->physfn->sriov->cfg_size;
-#endif
-
 	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG)
 		return PCI_CFG_SPACE_SIZE;
 

