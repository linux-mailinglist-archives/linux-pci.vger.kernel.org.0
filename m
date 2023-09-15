Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF597A2314
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbjIOP6j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 11:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbjIOP6Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 11:58:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CDFE78;
        Fri, 15 Sep 2023 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694793499; x=1726329499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M5bmNpQLqCow2r0+y/zZHPSJ1bKb8JVfyBcYO0ZR2N4=;
  b=h3fe+s4oA6plpXHVlCabtGwmTrzxRO+ACL7g2yCotlZbiT226d6d1NT1
   uHeLBLFRWzwm4vWJAurGYWkX+Nw+YmmQCZu3IbxS+JYW/0djpmYjLpUFx
   GB64FhQz5ZBD3jgUOWhQGlArsgWzH8/m7DVhtPu4VpY7RbG9T/AkxlQQm
   qNKs021OR5he6w49qgvTDh+zZ4ltF22fNHO0UG9airJA0GmDBxOQHh2g3
   1PSO01HpJ2NZzs/8HA2l5gpTGtf3i32y/KBlANVIQJxx+TA02O/483nr+
   2BGdXcB19S133SDwyuJv7N9Y0ODK0nVMzt4gBcvn+pyQk3vkHRllGDlwn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="369594662"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="369594662"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="745036705"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="745036705"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:58:18 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6/7] PCI/ASPM: Remove unnecessary includes
Date:   Fri, 15 Sep 2023 18:57:51 +0300
Message-Id: <20230915155752.84640-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230915155752.84640-1-ilpo.jarvinen@linux.intel.com>
References: <20230915155752.84640-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

aspm.c does not use anything from delay.h nor jiffies.h so remove the
includes.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index fac6c5a0be26..fb25892d15b7 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -19,8 +19,6 @@
 #include <linux/pm.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/jiffies.h>
-#include <linux/delay.h>
 #include <linux/time.h>
 
 #include "../pci.h"
-- 
2.30.2

