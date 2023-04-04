Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF76D57F5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 07:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjDDF1U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 01:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjDDF1T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 01:27:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E051FC6
        for <linux-pci@vger.kernel.org>; Mon,  3 Apr 2023 22:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680586038; x=1712122038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xn+5wqp+MaitwuZLqQuoAimjR36AK/XcM11rGf5DnlQ=;
  b=dNq71YABtiORZG1bQq+hR7o6sapKihJT46IrD1sqA5Tg64vNs3J3WFYG
   mpi5sAweUJQgXWeA688bSXPa697HuUaZWAPwU9/f0XqxVscUl9ULJ843c
   exWCQ29bqR1X1ldTETdyinQWx16nnG4FkcpXkiC5xGy00ItDAA423yyPy
   PFWQ+pfF9+7V69F7viDzIFLgVUMiJ3W44HFLGL8+fnQAtx60uqrClG232
   4KKU1QbC4FTMDT0Mj92z2k89jrLslVqLo55rZ1GrCcIysRVVU+nO3BFqt
   H5ppv0XZd/ldpCLIAnI9C912U4RR6T9kHeedu8twtsXofPTYPeYywMi74
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="342116204"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="342116204"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 22:27:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="775501975"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="775501975"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Apr 2023 22:27:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 6CDE2133; Tue,  4 Apr 2023 08:27:14 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 0/2] PCI/PM: Resume/reset wait time change
Date:   Tue,  4 Apr 2023 08:27:12 +0300
Message-Id: <20230404052714.51315-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

This series first increases the time we wait on resume path to
accommondate certain device, as reported in [1], and then "optimizes"
the timeout for slow links to avoid too long waits if a device is
disconnected during suspend.

Previous version can be found here:

  https://lore.kernel.org/linux-pci/20230321095031.65709-1-mika.westerberg@linux.intel.com/

Changes from the previous version:

  * Split the patch into two: one that increases the resume timeout (on
    all links, I was not able to figure out a simple way to limit this
    only for the fast links) and the one that decreases the timeout on
    slow links.

  * Use dev->link_active_reporting instead of speed to figure out slow
    vs. fast links.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=216728

Mika Westerberg (2):
  PCI/PM: Increase wait time after resume
  PCI/PM: Decrease wait time for devices behind slow links

 drivers/pci/pci-driver.c |  2 +-
 drivers/pci/pci.c        | 42 ++++++++++++++++++++++++++--------------
 drivers/pci/pci.h        | 16 +--------------
 drivers/pci/pcie/dpc.c   |  3 +--
 4 files changed, 30 insertions(+), 33 deletions(-)

-- 
2.39.2

