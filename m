Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDAA249D45
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 14:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgHSMDW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 08:03:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:31803 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbgHSL7R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:17 -0400
IronPort-SDR: ++V/PbRKPi+sYaTeZCpv7lbt0fe87fo50vjto7d6fQf0NXP2JHQ4WP01OGEiNaz0pdMO0clFf6
 Hco9ZpdwWecw==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="135160287"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="135160287"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:10 -0700
IronPort-SDR: GSOtgI+uUpHX3Tbz0J8kb0LlqOieTjLHeeC4RbNBE0a9NYzylazaeO118rb9CzjVzxPtNMORqp
 Vmp1SmZXPxSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="336938682"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 19 Aug 2020 04:59:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 54887B8; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
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
Subject: [PATCH 01/19] thunderbolt: Optimize Force Power logic
Date:   Wed, 19 Aug 2020 14:58:47 +0300
Message-Id: <20200819115905.59834-2-mika.westerberg@linux.intel.com>
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

Currently the "Force Power" logic uses 10 retries, each with a delay of
250 ms. Thunderbolt controllers in Ice Lake and Tiger Lake platforms are
found to complete this in the order of 3 ms or so. Since this delay
is in resume path, surplus delay is effectively affecting runtime PM
resume flows.

Decrease the granularity of the delay to 3 ms and increase the number of
retries so we wait maximum of ~1 s which is the recommended timeout.
This should make runtime resume a bit faster.

Reported-by: Dana Alkattan <dana.alkattan@intel.com>
Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/nhi_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/nhi_ops.c b/drivers/thunderbolt/nhi_ops.c
index 6795851aac95..c0d5ccbb10f5 100644
--- a/drivers/thunderbolt/nhi_ops.c
+++ b/drivers/thunderbolt/nhi_ops.c
@@ -59,7 +59,7 @@ static int icl_nhi_force_power(struct tb_nhi *nhi, bool power)
 	pci_write_config_dword(nhi->pdev, VS_CAP_22, vs_cap);
 
 	if (power) {
-		unsigned int retries = 10;
+		unsigned int retries = 350;
 		u32 val;
 
 		/* Wait until the firmware tells it is up and running */
@@ -67,7 +67,7 @@ static int icl_nhi_force_power(struct tb_nhi *nhi, bool power)
 			pci_read_config_dword(nhi->pdev, VS_CAP_9, &val);
 			if (val & VS_CAP_9_FW_READY)
 				return 0;
-			msleep(250);
+			usleep_range(3000, 3100);
 		} while (--retries);
 
 		return -ETIMEDOUT;
-- 
2.28.0

