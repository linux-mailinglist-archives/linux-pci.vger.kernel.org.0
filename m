Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A8787082
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 15:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241340AbjHXNkk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 09:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbjHXNkj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 09:40:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941D8A8;
        Thu, 24 Aug 2023 06:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692884437; x=1724420437;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Egbc3/xwA89sTLjIq+b/Y1PG7QSPGjqIoRnT1iD9+vM=;
  b=DxHWvResGOgyzlZ9d9dtL7Rv+Zk57ip4/5UFmwtrwNf6OUBV0ZMxpQXs
   2sudcsoomSbGmFCJPtEp3kZT6RD1OUldncnPQEpncdC948RAsgwXaL+kF
   GKEPBczsaOT8Z3Mktz2EnjOWo5+mXHAntgs7DC8Eo/7yOXqIafmmM22bd
   Prn6K4DeMN/rbiEafBxzf8mvUUpoSUqJ6sL+RPQWAYQoc/OW1PiAG4gCM
   eKEn3s4Vtvlnrm+2icwM9AM1Rp6gVsQVYy39gMzC0sXg0Egib6FQ33TpH
   6bCzFgB0nZECUt/eeqy9SgeDISeDdMRc7evtUd85GC2n25Cg6gA5aQslf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440792060"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440792060"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802539587"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802539587"
Received: from abedekar-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.213.29])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:28:45 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/14] PCI/treewide: Cleanup/streamline PCI error code handling
Date:   Thu, 24 Aug 2023 16:28:18 +0300
Message-Id: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As the first step towards converting PCI accessor function return codes
into normal errnos this series cleans up related code paths which have
complicated multi-line construct to handle the PCI error checking.

Ilpo Järvinen (14):
  alpha: Streamline convoluted PCI error handling
  MIPS: TXx9: Do PCI error checks on own line
  sh: pci: Do PCI error check on own line
  atm: iphase: Do PCI error checks on own line
  hwmon: (via686a) Do PCI error checks on own line
  hwmon: (vt8231) Do PCI error checks on own line
  I2C: ali15x3: Do PCI error checks on own line
  I2C: nforce2: Do PCI error check on own line
  I2C: sis5595: Do PCI error checks on own line
  PCI: Do error check on own line to split long if conditions
  PCI: xgene: Do PCI error check on own line
  scsi: ipr: Do PCI error checks on own line
  hwmon: (sis5595) Do PCI error checks on own line
  perf/x86/uncore: Remove unnecessary ?: operator around
    pcibios_err_to_errno() call

 arch/alpha/kernel/sys_miata.c        | 17 +++++------
 arch/mips/txx9/generic/pci.c         | 43 +++++++++++++++-------------
 arch/sh/drivers/pci/common.c         |  7 +++--
 arch/x86/events/intel/uncore_snbep.c |  2 +-
 drivers/atm/iphase.c                 | 20 +++++++------
 drivers/hwmon/sis5595.c              | 35 ++++++++++++----------
 drivers/hwmon/via686a.c              | 18 ++++++------
 drivers/hwmon/vt8231.c               | 11 +++----
 drivers/i2c/busses/i2c-ali15x3.c     | 10 +++----
 drivers/i2c/busses/i2c-nforce2.c     |  4 +--
 drivers/i2c/busses/i2c-sis5595.c     | 20 ++++++-------
 drivers/pci/controller/pci-xgene.c   |  5 ++--
 drivers/pci/pci.c                    |  9 ++++--
 drivers/pci/probe.c                  |  6 ++--
 drivers/pci/quirks.c                 |  6 ++--
 drivers/scsi/ipr.c                   | 12 +++++---
 16 files changed, 123 insertions(+), 102 deletions(-)

-- 
2.30.2

