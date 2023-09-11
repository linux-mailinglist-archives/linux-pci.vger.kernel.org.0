Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC38C79B915
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350634AbjIKVkI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbjIKMYJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 08:24:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74996CDC;
        Mon, 11 Sep 2023 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694435044; x=1725971044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hhntH08KwDzWZFhlYntAoxLtfPyiIglkNSydQprvVBY=;
  b=B8NAQrEcq1rjv1f2R9/u1JXboOL+RFAu4x4rdFIEVMG2OqbbETP7qs/P
   CyxYU8q0osPzBgChRVEbIdkUZmeiuUAMVe81t/Pyk02j4Dl1A1Psdzre/
   hLd4w60CdF+/jc+4LTk0Qh2uWQwCgUAErmkynvck22JI8AvQMWNkWi+vC
   SttRAjlgz3EnmGIL6JwyXygVcfgY/OdHyiWKnIeYGm7Z/Tsc0qfN+YL9e
   ldadl5LfKlmEfH4Xz0/ybD+6Mh5qpYnsrjRBMLjF/WzBm5XZI8Ut3irY+
   iTfOTT4hhVtrJgaOvzIjyyVrF4FSc06tJ116vfcEs9C1wLmXh42dTutB0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="376979009"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="376979009"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="736753877"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="736753877"
Received: from unknown (HELO bapvecise024..) ([10.190.254.46])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2023 05:23:59 -0700
From:   sharath.kumar.d.m@intel.com
To:     helgaas@kernel.org
Cc:     bhelgaas@google.com, dinguyen@kernel.org, kw@linux.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, robh@kernel.org, sharath.kumar.d.m@intel.com
Subject: [PATCH v3 0/2] PCI: altera: add support to agilex family
Date:   Mon, 11 Sep 2023 17:54:33 +0530
Message-Id: <20230911122435.1774301-1-sharath.kumar.d.m@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908195242.GA304243@bhelgaas>
References: <20230908195242.GA304243@bhelgaas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: D M Sharath Kumar <sharath.kumar.d.m@intel.com>

added new callback for
1) read,write to root port configuration registers
2) read,write to endpoint configuration registers
3) root port interrupt handler

agilex and newer platforms need to implemant the callback and generic root 
port driver should work ( without much changes ) , legacy platforms (arria
 and startix) implement configuration read,write directly in wrapper 
api _altera_pcie_cfg_read/_altera_pcie_cfg_write

changelog v2:
saperated into two patches
1.refactored the driver for easily portability to future Altera FPGA
platforms
2.added support for "Agilex" FPGA

this driver supports PCI RP IP on Agilex FPGA, as these are FPGA its up
to the user to add PCI RP or not ( as per his needs). we are not adding
the device tree as part of this commit. we are expecting the add device
tree changes only if he is adding PCI RP IP in his design

changelog v3:
incorporate review comments from Bjorn Helgaas


D M Sharath Kumar (2):
  PCI: altera: refactor driver for supporting new platforms
  PCI: altera: add support for agilex family fpga

 drivers/pci/controller/pcie-altera.c | 305 ++++++++++++++++++++++++---
 1 file changed, 275 insertions(+), 30 deletions(-)

-- 
2.34.1

