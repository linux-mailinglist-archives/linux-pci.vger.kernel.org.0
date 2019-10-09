Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3DB3D1C19
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 00:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfJIWqf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 18:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731736AbfJIWqf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 18:46:35 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7882920B7C;
        Wed,  9 Oct 2019 22:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570661194;
        bh=X4MnfuIslLW8blcOn4yQwQq8QlC4Uf+as3cLP18fUQI=;
        h=From:To:Cc:Subject:Date:From;
        b=YAQZDCIMKr0xvp1BCRV8R3czGYmhTwPYvtPlXjdmDagf29hifU2QtsQOGvEkD/Yf0
         BvdjTgSXdPoCd9eUT91GNFqh8p5vmX+6Yj4S49nyuXpDoE3IdlwcozlNUgF2OJi8Id
         TikkS8ndWH0JWv2gbWpMTfJk6adpqFpp5mhOnFv8=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] iommu/vt-d: Select PCI_PRI for INTEL_IOMMU_SVM
Date:   Wed,  9 Oct 2019 17:45:49 -0500
Message-Id: <20191009224551.179497-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

I think intel-iommu.c depends on CONFIG_AMD_IOMMU in an undesirable way:

When CONFIG_INTEL_IOMMU_SVM=y, iommu_enable_dev_iotlb() calls PRI
interfaces (pci_reset_pri() and pci_enable_pri()), but those are only
implemented when CONFIG_PCI_PRI is enabled.  If CONFIG_PCI_PRI is not
enabled, there are stubs that just return failure.

The INTEL_IOMMU_SVM Kconfig does nothing with PCI_PRI, but AMD_IOMMU
selects PCI_PRI.  So if AMD_IOMMU is enabled, intel-iommu.c gets the full
PRI interfaces.  If AMD_IOMMU is not enabled, it gets the PRI stubs.

This seems wrong.  The first patch here makes INTEL_IOMMU_SVM select
PCI_PRI so intel-iommu.c always gets the full PRI interfaces.

The second patch moves pci_prg_resp_pasid_required(), which simply returns
a bit from the PCI capability, from #ifdef CONFIG_PCI_PASID to #ifdef
CONFIG_PCI_PRI.  This is related because INTEL_IOMMU_SVM already *does*
select PCI_PASID, so it previously always got pci_prg_resp_pasid_required()
even though it got stubs for other PRI things.

Since these are related and I have several follow-on ATS-related patches in
the queue, I'd like to take these both via the PCI tree.

Bjorn Helgaas (2):
  iommu/vt-d: Select PCI_PRI for INTEL_IOMMU_SVM
  PCI/ATS: Move pci_prg_resp_pasid_required() to CONFIG_PCI_PRI

 drivers/iommu/Kconfig   |  1 +
 drivers/pci/ats.c       | 55 +++++++++++++++++++----------------------
 include/linux/pci-ats.h | 11 ++++-----
 3 files changed, 31 insertions(+), 36 deletions(-)

-- 
2.23.0.581.g78d2f28ef7-goog

