Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AF679B317
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 01:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350668AbjIKVkb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbjIKMyX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 08:54:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FCECEB;
        Mon, 11 Sep 2023 05:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694436858; x=1725972858;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/wVoKjEeeLBla+cD7axdVwdKaE7wsNtpVj0vYnNrywc=;
  b=Z3fj7/2EfR1b3zuqQtYOaM4Yb6DW282iMlq+B69OcNKYepd0qNVuV31z
   lJ73kZHdjxFHj+TdSw6+Tienu22amOVY35deP/3o4tQBqhmx1IZu061me
   mowQRZu6GIIXfr4OL2ppgYe2Bp5OQT0efZv8a98PzYteMP0xNjXo0WfCR
   Stql+xNZfXygVuAEZj5bYVo+uzIRNxe7pI2wEpIxKWO4BPQYZCu7dOLVI
   k2/cXyVIluxOR581pjqjxBXyl3mcyjuF9AnB5Y3f2aL92VORQTRdUJYzD
   x2zpBcpN37L8rNdxSf+y45Aeuxj2ZPu42IkvVRsNgXQPuKplyUgMG32fu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="357511140"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="357511140"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858304123"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="858304123"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:54:02 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, 3chas3@gmail.com, brking@us.ibm.com,
        dalias@libc.org, glaubitz@physik.fu-berlin.de,
        ink@jurassic.park.msu.ru, jejb@linux.ibm.com, kw@linux.com,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-atm-general@lists.sourceforge.net,
        linux-scsi@vger.kernel.org, linux-sh@vger.kernel.org,
        lpieralisi@kernel.org, martin.petersen@oracle.com,
        mattst88@gmail.com, netdev@vger.kernel.org,
        richard.henderson@linaro.org, toan@os.amperecomputing.com,
        ysato@users.sourceforge.jp,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 0/6] PCI/treewide: Cleanup/streamline PCI error code handling
Date:   Mon, 11 Sep 2023 15:53:48 +0300
Message-Id: <20230911125354.25501-1-ilpo.jarvinen@linux.intel.com>
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

I'd prefer these (the remaining ones) to be routed through PCI tree due
to PCI accessor function return code conversion being built on top of
them.

v3:
- Return pci_generic_config_read32()'s error code directly
- Removed already accepted patches

v2:
- Moved ret local var to the inner block (I2C: ali15x3)
- Removed already accepted patches


Ilpo Järvinen (6):
  alpha: Streamline convoluted PCI error handling
  sh: pci: Do PCI error check on own line
  atm: iphase: Do PCI error checks on own line
  PCI: Do error check on own line to split long if conditions
  PCI: xgene: Do PCI error check on own line & keep return value
  scsi: ipr: Do PCI error checks on own line

 arch/alpha/kernel/sys_miata.c      | 17 +++++++++--------
 arch/sh/drivers/pci/common.c       |  7 ++++---
 drivers/atm/iphase.c               | 20 +++++++++++---------
 drivers/pci/controller/pci-xgene.c |  7 ++++---
 drivers/pci/pci.c                  |  9 ++++++---
 drivers/pci/probe.c                |  6 +++---
 drivers/pci/quirks.c               |  6 +++---
 drivers/scsi/ipr.c                 | 12 ++++++++----
 8 files changed, 48 insertions(+), 36 deletions(-)

-- 
2.30.2

