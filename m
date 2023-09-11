Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4EF79B833
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350600AbjIKVjd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbjIKNpN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 09:45:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698AFCD7;
        Mon, 11 Sep 2023 06:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694439909; x=1725975909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hhntH08KwDzWZFhlYntAoxLtfPyiIglkNSydQprvVBY=;
  b=bx0Q+MLK5Z0fq2p+Z3aVkc/TlRX6yUx9C/681XRUMaM0wNVYlgW6Zqmu
   EKhcUr96N9maVJDoM8cbSSiq4qHaQaTR+WsS6SuDQD4vz22nCodsAb81R
   R+yfMRFXd/Ym1r45DoxY9wyAtWm5ayy7ISsm4vSOTlbKGLDTVgGNp4Evp
   shT1WWyM4e6GJ81rIc7K0l7J4pI6Kizq6r+NLWyOs8nhJCtgeBeIjz+EP
   hNJHkY9Q281iM8+y7d2Z2OjQitIIjeuX5ZVYDMO0gZ5wa6u4bMSvmOuly
   C+GzR72Tm8kJgF51+6/ou4YBZJnIe9l1lnGyN5dxNSDk4dH8Cg9prnDbb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="444500435"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="444500435"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 06:45:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="813379966"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="813379966"
Received: from unknown (HELO bapvecise024..) ([10.190.254.46])
  by fmsmga004.fm.intel.com with ESMTP; 11 Sep 2023 06:45:05 -0700
From:   sharath.kumar.d.m@intel.com
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org, dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        D M Sharath Kumar <sharath.kumar.d.m@intel.com>
Subject: [PATCH v3 0/2] PCI: altera: add support to agilex family
Date:   Mon, 11 Sep 2023 19:15:39 +0530
Message-Id: <20230911134541.1777043-1-sharath.kumar.d.m@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616063313.862996-2-sharath.kumar.d.m@intel.com>
References: <20230616063313.862996-2-sharath.kumar.d.m@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

