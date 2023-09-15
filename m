Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18227A2309
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 17:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbjIOP6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 11:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbjIOP6F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 11:58:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8484E78;
        Fri, 15 Sep 2023 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694793480; x=1726329480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3YJZk03nP9VduHGWvdc4C8fqF0hB8UJxG5XUppLNQHA=;
  b=BV3bDzdrnzL2o1OBjfpeL3QgsB4RWjxHDoJHUOWcYEPJEpbp6Xri2bvK
   znK6W3DJqgaOOZtoVg/mB9AU8nVv393+vm6vzSO+XNJQWINEKH8otI0RE
   QTbrLhxvoamOged7A/drAAxVLkEAaIan4/Yas7WT3eulIPFKl6JwPAuDu
   lmTB3FCUme9F1K0/5XD4h4yjXxgwJb9BtZCGnqVmXtd+8pIA+3gTHSmq1
   DwHpZz1xrlcHIG6Whgh1qwNsUZya1NQPWR6R0dBd8hsnLP0nkzHvJfDqI
   C4K60cACpOzYTjbm/rL5ZLSZsaOoWpNkarvYNPgIazI6B1r4cn+DTXXah
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="369594600"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="369594600"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:58:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="745036673"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="745036673"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:57:58 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/7] PCI/ASPM: Cleanups
Date:   Fri, 15 Sep 2023 18:57:45 +0300
Message-Id: <20230915155752.84640-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
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

What started as simple FIELD_GET/PREP() cleanup patch on ASPM became
this series of cleanups.

Ilpo Järvinen (7):
  PCI: Add PCI_L1SS_CTL2 fields
  PCI/ASPM: Use FIELD_GET/PREP() to access PCIe capability fields
  PCI/ASPM: Return U32_MAX instead of bit magic construct
  PCI/ASPM: Use time constants
  PCI/ASPM: Use FIELD_MAX() instead of literals
  PCI/ASPM: Remove unnecessary includes
  PCI/ASPM: Convert printk() to pr_*() and add include

 drivers/pci/pcie/aspm.c       | 71 +++++++++++++++++++----------------
 include/uapi/linux/pci_regs.h |  2 +
 2 files changed, 41 insertions(+), 32 deletions(-)

-- 
2.30.2

