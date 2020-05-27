Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AF31E4B1C
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 18:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgE0Q4X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 12:56:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:24076 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731071AbgE0Q4X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 12:56:23 -0400
IronPort-SDR: Io9eTP1wKiyxR/X56jmHBzlH3aC4xDP8Bq6GoS+EbIMOgGkw3xIj2JVDo6cVYiHkJ5yPgTzEOY
 OG0HGAzZDmlA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 09:56:21 -0700
IronPort-SDR: ujYw5J0Ds55WcBUIgiqzIcxegHTqrsY0WWGCVy3NeTygRwye5U4hftzMqLpuzODQa4HMMQxVfB
 fjuemY8Z6qaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="302522288"
Received: from jderrick-mobl.amr.corp.intel.com ([10.209.128.69])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2020 09:56:20 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <iommu@lists.linux-foundation.org>
Cc:     <linux-pci@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v1 0/3] iommu/vt-d: real DMA sub-device info allocation
Date:   Wed, 27 May 2020 10:56:14 -0600
Message-Id: <20200527165617.297470-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This set adds the support for real DMA sub-devices to have device_domain_info,
leading to the correct domain type being used.

This applies on Joerg's origin/next. This also applies against v5.6.12
and v5.7-rc7 with some API modifications, making it a stable candidate
that fixes the issue reported in [1].

For v5.6.12 and v5.7-rc7, identity_mapping() would return 0 for real DMA
sub-devices due to not having valid device_domain_info, leading to
__intel_map_single() paths. This is a problem if the real DMA device
started in IDENTITY, leading to a NULL Pointer Dereference:

	__intel_map_single()
		domain = find_domain(dev);
			dev = &pci_real_dma_dev(to_pci_dev(dev))->dev;
			info = dev->archdata.iommu;
			return info->domain;

		iommu = domain_get_iommu(domain)
			if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
				return NULL;

		cap_zlr(iommu->cap) <-- NULL Pointer Deref

This issue was also fixed by 6fc7020cf298 ("iommu/vt-d: Apply per-device
dma_ops") due to removing identity_mapping() paths.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=207575

Jon Derrick (3):
  iommu/vt-d: Only clear real DMA device's context entries
  iommu/vt-d: Allocate domain info for real DMA sub-devices
  iommu/vt-d: Remove real DMA lookup in find_domain

 drivers/iommu/intel-iommu.c | 31 +++++++++++++++++++++++--------
 include/linux/intel-iommu.h |  1 +
 2 files changed, 24 insertions(+), 8 deletions(-)

-- 
1.8.3.1

