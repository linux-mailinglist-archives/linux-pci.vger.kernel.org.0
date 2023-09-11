Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D694579AE74
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 01:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350552AbjIKVjF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbjIKNVq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 09:21:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FF012A;
        Mon, 11 Sep 2023 06:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694438502; x=1725974502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hhntH08KwDzWZFhlYntAoxLtfPyiIglkNSydQprvVBY=;
  b=X4jOnLMj2h4yiCltYX+ye0HDttqjrB8EcyX4EsyuxNN88xBh5Dz552ff
   tK1Yrz90g2i6Yuog5uxhROQpr1Y337C4ldRcFVq3q+NjbpLgUzjB1XG7k
   TQthZbm61ezwjUtJ8mtWWsSWn6tF7otkAb6Ol6duxO5FIN8q1yv+wUIss
   ewwIqCXDcWqV6d7nLiP0/W7x4hDdbdWBVPTCrTSB82dc7fV/HaFD4G2Vz
   /Rm7l0Vk18KqQ4HbRgTSUacjSWCJ+/Zr58IlfGL9c/fpf9RBCCyyYUveE
   xywRE30Gow97u9jhJtVHMfPwmgNI5j/D5X6WDYdk7oaMtb9KRz0oF6Nnp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="357517039"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="357517039"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 06:21:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858312440"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="858312440"
Received: from unknown (HELO bapvecise024..) ([10.190.254.46])
  by fmsmga002.fm.intel.com with ESMTP; 11 Sep 2023 06:21:38 -0700
From:   sharath.kumar.d.m@intel.com
To:     helgaas@kernel.org
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        D M Sharath Kumar <sharath.kumar.d.m@intel.com>
Subject: [PATCH v3 0/2] PCI: altera: add support to agilex family
Date:   Mon, 11 Sep 2023 18:52:12 +0530
Message-Id: <20230911132214.1776157-1-sharath.kumar.d.m@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906110918.1501376-3-sharath.kumar.d.m@intel.com>
References: <20230906110918.1501376-3-sharath.kumar.d.m@intel.com>
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

