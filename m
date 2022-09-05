Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EAE5ACD5B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 10:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbiIEICZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 04:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbiIEICV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 04:02:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFB7474FD
        for <linux-pci@vger.kernel.org>; Mon,  5 Sep 2022 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662364940; x=1693900940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B+EYZGtKlbuOilZNM/TUK8CI4yPWEx1HZJpand5x+Ek=;
  b=cOhHu7rI9CInkczP5OV1wnBctEsIVje+KQHZWjiuiRl4peomaIAftD38
   uDbjeXvGaxP/BhxYdswH1D6Xheb3RoTobPw+9gsEP8FgAjS3qGsMXUs3s
   4yomKExtnje1InJ3qHMCpOPBXDdB7iLvrvk2Bz/eS+ixqTgTPSi0F39bp
   T2HrdmhGZPVEpfqvTL3REhoCkyohtwrMSWsDAag6vktjmFkvvDM0TUO5J
   avwbynuzMLXy1x0QmARU9jSvzfPdD/VBpifCj2euvRJEPR9sj3WUy7h5Y
   Q2fiLmDlYby+Gl8lajDl16Xqy+kohmOZ9xP4ItdxbSrsAZGbzx1esN7OH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="297644431"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="297644431"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 01:02:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="616330059"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Sep 2022 01:02:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id AD8AF101; Mon,  5 Sep 2022 11:02:32 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 0/6] PCI: Allow for future resource expansion on initial root bus scan
Date:   Mon,  5 Sep 2022 11:02:26 +0300
Message-Id: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

The series works around an issue found on some Dell systems where
booting with Thunderbolt/USB4 devices connected the BIOS leaves some of
the PCIe devices unconfigured. If the connected devices that are not
configured have PCIe hotplug ports as well the initial root bus scan
only reserves the minimum amount of resources to them making any
expansion happening later impossible.

We do already distribute the "spare" resources between hotplug ports on
hot-add but we have not done that upon the initial scan. The first four
patches make the initial root bus scan path to do the same.

The additional patches are just a small cleanups that can be applied
separately too.

The related bug: https://bugzilla.kernel.org/show_bug.cgi?id=216000.

The previous version of the patch series can be found here:

  https://lore.kernel.org/linux-pci/20220816100740.68667-1-mika.westerberg@linux.intel.com/

Changes from the previous version:

  * Split patch 3 into two: move and then the actual fix as suggested by
    Andy.
  * Fold the two whitespace fixes into one patch.
  * Added tags from Chris and Andy.

Mika Westerberg (6):
  PCI: Fix used_buses calculation in pci_scan_child_bus_extend()
  PCI: Pass available buses also when the bridge is already configured
  PCI: Move pci_assign_unassigned_root_bus_resources()
  PCI: Distribute available resources for root buses too
  PCI: Fix whitespace and indentation
  PCI: Fix typo in pci_scan_child_bus_extend()

 drivers/pci/probe.c     |  13 +-
 drivers/pci/setup-bus.c | 290 ++++++++++++++++++++++++----------------
 2 files changed, 181 insertions(+), 122 deletions(-)

-- 
2.35.1

