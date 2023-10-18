Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049C47CDA7F
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 13:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjJRLdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 07:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJRLdf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 07:33:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD18114;
        Wed, 18 Oct 2023 04:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697628813; x=1729164813;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9ROssOhumx09tQhub2UcmdGDVJ0uIUZmqJaxfmWuU/U=;
  b=N5Cpkj4BNPLsA1zpf/oyijhvWTPLE3kKWvmeo5RSugmfpzFDul7qWnSn
   iL1k0AJ9A9SxfrH1hPmrPBEfU1JiYdJOYLBxyWar3/ypfuGgopXG4cvfl
   iUyIfl7bWQmueopJ3CXLRD6Xv4+HnwaMpJpb+h7nT/neQZ2+9+ujnVXRs
   dsv7XcAk8mwEcQsyxOXjZWAudHpO0ZI5umfDDXZ91MpvIo2MARBFUKjAc
   YMmQyyJcx8TndhL8zZYlMkshV0sTUPKlbCS1VaKp+njUqGwHz9dhYIY83
   l/Y+QtK4TefvsCVQqTsyNVxo81LpPZyvgI5GIK+3WTlxWlU0mX0t9TNp2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="376365518"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="376365518"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:33:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="760191924"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="760191924"
Received: from suguccin-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.44.63])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:33:29 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/7] PCI: Use FIELD_GET/PREP() & other reg field cleanups
Date:   Wed, 18 Oct 2023 14:32:47 +0300
Message-Id: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Here's what I think should cover most of the remaining FIELD_GET/PREP()
conversions under drivers/pci/.

The patch from Bjorn is from
  https://lore.kernel.org/linux-pci/20231010204436.1000644-7-helgaas@kernel.org/
But has been adjusted to better blend in with the other DPC changes.
I've preserved Bjorn as the main From/SoB, and added myself before his
name instead (since I modified it but my main contribution was to
remove stuff he had made to it).

Bjorn Helgaas (1):
  PCI/DPC: Use FIELD_GET()

Ilpo Järvinen (6):
  PCI: cadence: Use FIELD_GET()
  PCI: dwc: Use FIELD_GET/PREP()
  PCI: hotplug: Use FIELD_GET/PREP()
  PCI/DPC: Use defined fields with DPC_CTL register
  PCI/DPC: Use defines with DPC reason fields
  PCI/MSI: Use FIELD_GET/PREP()

 .../pci/controller/cadence/pcie-cadence-ep.c  |  9 ++--
 .../pci/controller/dwc/pcie-designware-ep.c   |  7 ++--
 drivers/pci/controller/dwc/pcie-tegra194.c    |  5 +--
 drivers/pci/hotplug/pciehp_core.c             |  3 +-
 drivers/pci/hotplug/pciehp_hpc.c              |  5 ++-
 drivers/pci/hotplug/pnv_php.c                 |  3 +-
 drivers/pci/msi/msi.c                         | 10 +++--
 drivers/pci/pcie/dpc.c                        | 42 ++++++++++++-------
 drivers/pci/quirks.c                          |  2 +-
 include/uapi/linux/pci_regs.h                 |  9 ++++
 10 files changed, 61 insertions(+), 34 deletions(-)

-- 
2.30.2

