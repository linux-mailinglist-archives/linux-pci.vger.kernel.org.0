Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71317DA741
	for <lists+linux-pci@lfdr.de>; Sat, 28 Oct 2023 15:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjJ1Ncb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Oct 2023 09:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1Nca (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Oct 2023 09:32:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507C3E1;
        Sat, 28 Oct 2023 06:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698499948; x=1730035948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7UdsIxjI1/S/O/G5ftgNxkblPhVvB0/4vMkTP7ecMmY=;
  b=aYvEQLQ5hmnqE5my+N5ob0PftLNoN4Idqdwymexe80Cd0SmYZsT6Pn0M
   QW4/Hz4Hbzuqd9pmDqWXF50IydZXXviMSmRYsdss2IM4JFJu/8k65EUFx
   g5Uv/eymKBiRQcvXP0OK5ZUlt+Xhrv8jP2NwUG+117YBmcwbJ1ULHXXKJ
   /fHY36HoHQoZEFwqGQ4xfyo9iDwIjZBKSjei0ESgZzGvjs0Wt4yQzbIpZ
   NxR3tzbKN1pY1K8USNrmvI18jxezWZJrA5JC2VY78OJP1hLezvVtVoinX
   KOdH82SyR4osccEM3IpPjeLaQLEdQhOabU2l9TS3oCSPAcQKdvpamoNc7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="737525"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="737525"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 06:32:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="7907691"
Received: from unknown (HELO bapvecise024..) ([10.190.254.46])
  by fmviesa001.fm.intel.com with ESMTP; 28 Oct 2023 06:32:10 -0700
From:   sharath.kumar.d.m@intel.com
To:     helgaas@kernel.org
Cc:     bhelgaas@google.com, dinguyen@kernel.org, joyce.ooi@intel.com,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        sharath.kumar.d.m@intel.com
Subject: [PATCH v5 0/2] PCI: altera: add support to agilex family 
Date:   Sat, 28 Oct 2023 19:03:14 +0530
Message-Id: <20231028133314.493901-1-sharath.kumar.d.m@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025215116.GA1768116@bhelgaas>
References: <20231025215116.GA1768116@bhelgaas>
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

changelog v4:
added below callback for root bus
alt_read/write_own_cfg
added below callback for non-root buses
alt_read/write_other_cfg

changelog v5
the driver is tested on agilex7 and information is below
https://www.rocketboards.org/foswiki/Documentation/Agilex7PCIeRootPortDesign

incorporate review comments from Bjorn Helgaas
added comments on the supported family
{.compatible = "altr,pcie-root-port-3.0", /* agilex7 P,F tile */

printing the satus
dev_err_ratelimited(dev, "unexpected IRQ %x\n", status);

indentation etc

D M Sharath Kumar (2):
  PCI: altera: refactor driver for supporting new platform
  PCI: altera: add support for agilex7 family fpga

 drivers/pci/controller/pcie-altera.c | 313 ++++++++++++++++++++++++---
 1 file changed, 280 insertions(+), 33 deletions(-)

-- 
2.34.1

