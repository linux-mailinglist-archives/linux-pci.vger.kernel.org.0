Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA13673F98
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 18:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjASRKt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 12:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjASRKp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 12:10:45 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4138F872BF;
        Thu, 19 Jan 2023 09:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674148239; x=1705684239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bhthSGOnd5mtZVdhRqBp03RIkiK20hhGEQnqr2CdGfw=;
  b=cNQ/CKiRwsyGpoc/4dLBFZzykhBVi154dwwroi6CVhtWoQNvSjLnYYiu
   BVziKcm7+lT9yzepDDbN/96E8JBTHQrKillLO6B01eSolwnOAfaPwGJL4
   KM34qb6kNugCaLbZmjKodO9eTWGMDNk6XIef7Wyqqa9GD9XMzJ64nUTCK
   QBrgcKrwHPLwPYATVB5UeMigmq4zxilgvlYeMbONl8TegMrXyoRmkO76G
   HUmYRvnJruZyYwlH79+ikOA7MX9shACoFddFmuuC6uaawTPOpkchi/qJ6
   zuA8RD107bWgFZpUWA93lL5bxTtDHg5HbF23eNzWL420H8VxmtKD+ilvC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305714639"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="305714639"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 09:06:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="784124757"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="784124757"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2023 09:06:13 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        darwi@linutronix.de, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/2] PCI/MSI: Hardening fixes
Date:   Thu, 19 Jan 2023 19:06:31 +0200
Message-Id: <20230119170633.40944-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Here are 2 hardening fixes around MSIX table size/offset handling,
aiming to prevent a malicious device or VMM from triggering bugs by
supplying bogus values.

Alexander Shishkin (2):
  PCI/MSI: Cache the MSIX table size
  PCI/MSI: Validate device supplied MSI table offset and size

 drivers/pci/msi/api.c |  7 ++++++-
 drivers/pci/msi/msi.c | 12 +++++++++---
 include/linux/pci.h   |  1 +
 3 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.39.0

