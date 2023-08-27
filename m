Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED23789F85
	for <lists+linux-pci@lfdr.de>; Sun, 27 Aug 2023 15:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjH0Nhx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Aug 2023 09:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjH0NhV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2023 09:37:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A7D139;
        Sun, 27 Aug 2023 06:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693143438; x=1724679438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jtC8JeCuHQBuQkuR379mt3V20ulh/Vbw9AsnZRG2Oak=;
  b=BxXeLcrO6PGUCpFVtXKmyCpHhGLkTlw4Wrf3lf+2vHBNkUKFo2JJUG6g
   /whlZRj5deWRJvTm0eWCMrZC4L5lHSAFEq4EM34GUCT/uUgh9uN5Rha2E
   9hkhjHIZFIwdZaFVZdcQQHwGx06LJ2lMbe3wmI46hWcHOWL6+/4vOEUNk
   3zzPhQh96dIe5T4rv9xU7bbPGm7E+zHAte3nYSpqaRvPRtodfdCsBsXYj
   sv1dgkwiHiML9PlPyMSqb0CIjpcnhTtuRaXg2usZEb3INZB+ztc38SyVx
   qHJR7rdHUkXhhx5HSsfax0Fy2SGkod6Ovnfk55Kc/04kKePajBNMD6Kyu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="354470944"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="354470944"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 06:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="1068752070"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="1068752070"
Received: from dplotkin-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.41.231])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 06:37:14 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/8] PCI/treewide: Cleanup/streamline PCI error code handling
Date:   Sun, 27 Aug 2023 16:36:57 +0300
Message-Id: <20230827133705.12991-1-ilpo.jarvinen@linux.intel.com>
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

v2:
- Moved ret local var to the inner block (I2C: ali15x3)
- Removed already accepted patches

Ilpo Järvinen (8):
  alpha: Streamline convoluted PCI error handling
  MIPS: TXx9: Do PCI error checks on own line
  sh: pci: Do PCI error check on own line
  atm: iphase: Do PCI error checks on own line
  I2C: ali15x3: Do PCI error checks on own line
  PCI: Do error check on own line to split long if conditions
  PCI: xgene: Do PCI error check on own line
  scsi: ipr: Do PCI error checks on own line

 arch/alpha/kernel/sys_miata.c      | 17 ++++++------
 arch/mips/txx9/generic/pci.c       | 43 ++++++++++++++++--------------
 arch/sh/drivers/pci/common.c       |  7 ++---
 drivers/atm/iphase.c               | 20 +++++++-------
 drivers/i2c/busses/i2c-ali15x3.c   | 11 ++++----
 drivers/pci/controller/pci-xgene.c |  5 ++--
 drivers/pci/pci.c                  |  9 ++++---
 drivers/pci/probe.c                |  6 ++---
 drivers/pci/quirks.c               |  6 ++---
 drivers/scsi/ipr.c                 | 12 ++++++---
 10 files changed, 76 insertions(+), 60 deletions(-)

-- 
2.30.2

