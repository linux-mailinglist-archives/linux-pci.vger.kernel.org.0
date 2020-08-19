Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91C9249D03
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 13:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgHSL7T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 07:59:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:31803 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbgHSL7N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:13 -0400
IronPort-SDR: yHw3ZwBnEmCkLaPo/LX8AVe2sU/KdiWDAkGCaK8dS2YGBHNPEus8HfCkVYsyjJi1bVmgN0TOpM
 SvFxakRfr+YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="135160284"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="135160284"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:10 -0700
IronPort-SDR: nxi/5AY/23BGtTBP5/pHeITqLiRkcnCFR+WljHGgHaq95cDGgK+GQ2RtjcVvqXw47tF8sWQAWo
 kqq06Rwa5Szg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="497212550"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Aug 2020 04:59:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5A4C326A; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Dana Alkattan <dana.alkattan@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 02/19] thunderbolt: Optimize NHI LC mailbox command processing
Date:   Wed, 19 Aug 2020 14:58:48 +0300
Message-Id: <20200819115905.59834-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rajmohan Mani <rajmohan.mani@intel.com>

Currently the Ice Lake and Tiger Lake NHI (host controller) LC (link
controller) mailbox command processing checks for the completion of
command every 100 msecs. These controllers are found to complete this in
the order of 1 ms or so. Since this delay is in suspend path, surplus
delay is effectively affecting runtime PM suspend flows.

Optimize this so that we do the wait for 1 ms after reading the mailbox
register. This should make Ice Lake and Tiger Lake runtime suspend take
less time to complete.

Reported-by: Dana Alkattan <dana.alkattan@intel.com>
Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/nhi_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/nhi_ops.c b/drivers/thunderbolt/nhi_ops.c
index c0d5ccbb10f5..28583f9faf46 100644
--- a/drivers/thunderbolt/nhi_ops.c
+++ b/drivers/thunderbolt/nhi_ops.c
@@ -97,7 +97,7 @@ static int icl_nhi_lc_mailbox_cmd_complete(struct tb_nhi *nhi, int timeout)
 		pci_read_config_dword(nhi->pdev, VS_CAP_18, &data);
 		if (data & VS_CAP_18_DONE)
 			goto clear;
-		msleep(100);
+		usleep_range(1000, 1100);
 	} while (time_before(jiffies, end));
 
 	return -ETIMEDOUT;
-- 
2.28.0

