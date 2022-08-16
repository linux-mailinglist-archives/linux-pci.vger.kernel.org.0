Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FC75958DA
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 12:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiHPKsk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 06:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbiHPKsK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 06:48:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A74399F9
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660644450; x=1692180450;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bmTpzpPhF0Npwic07iVz3ZPqSfTX6AFbhwS6KijY0vg=;
  b=Hc4I8gDAUrilHN6Jesdvj2+vr3fPTzPSG7T7cF0GmbGbrz74fD9NxVgH
   +NDfT2vkpLnxmBjA5NqW6aPTl76xN1vqvjQHYhpVq4w2dl6Z5QhiYlrIp
   2cbwKqB6Vr9+JBSQm5BPj7GJKxEO/0dO/UDq5fcFKeORm7LHacQn0kglb
   O7NJEK62exIj+hJISJXLSoF4MSk5NjjnY/5uDh1rMqtY9kfkH6Zb1tcaB
   sElH0F+dhb72M0egZPpQqZtwtPq7Y11YAxF7nMwWpReyglCwwnTsoV0pN
   xCFdjHRlvUz86r2M4yz2YuL2FjnqSIxr2BBhfZr8fpHtrNAMUZBWYKpVQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="292175642"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="292175642"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="667045725"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2022 03:07:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0D27D2D5; Tue, 16 Aug 2022 13:07:40 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 0/6] PCI: Allow for future resource expansion on initial root bus scan
Date:   Tue, 16 Aug 2022 13:07:34 +0300
Message-Id: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
hot-add but we have not done that upon the initial scan. The first three
patches make the initial root bus scan path to do the same.

The additional three patches are just a small cleanups that can be
applied separately too.

The related bug: https://bugzilla.kernel.org/show_bug.cgi?id=216000.

Mika Westerberg (6):
  PCI: Fix used_buses calculation in pci_scan_child_bus_extend()
  PCI: Pass available buses also when the bridge is already configured
  PCI: Distribute available resources for root buses too
  PCI: Remove two unnecessary empty lines in pci_scan_child_bus_extend()
  PCI: Fix typo in pci_scan_child_bus_extend()
  PCI: Fix indentation in pci_bridge_distribute_available_resources()

 drivers/pci/probe.c     |  13 +-
 drivers/pci/setup-bus.c | 290 ++++++++++++++++++++++++----------------
 2 files changed, 181 insertions(+), 122 deletions(-)

-- 
2.35.1

