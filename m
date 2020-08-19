Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5653D249D49
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 14:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgHSMD4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 08:03:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:31808 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgHSL7R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:17 -0400
IronPort-SDR: l8/2vkKrendYAOY5dt55fAjIQeqs/iwsYwBxdysla/ruPmxw9GrDpDrDYqQsFOrpSHcd2ri7xN
 ySuyWS8f2ZtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="135160286"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="135160286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:10 -0700
IronPort-SDR: lftiw1FH3jp+HE7eT6XXBSDQojVdz98HP+OoElTmQvNIk8KupFMrlo9xWfunLeWueYq633x+Kz
 g/Qr0DEnZvBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="336938679"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 19 Aug 2020 04:59:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 74B48374; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
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
Subject: [PATCH 04/19] thunderbolt: Use bit 31 to check if Firmware CM is running in Tiger Lake
Date:   Wed, 19 Aug 2020 14:58:50 +0300
Message-Id: <20200819115905.59834-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In Tiger Lake the Firmware CM is always enabled (so bit 0 is always set)
but it may be in "pass through" mode which means it requires Software CM
instead. This can be determined by checking bit 31 instead.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index ffcc8c3459e5..b51fc3f62b1f 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1635,11 +1635,14 @@ static void icm_icl_rtd3_veto(struct tb *tb, const struct icm_pkg_header *hdr)
 
 static bool icm_tgl_is_supported(struct tb *tb)
 {
+	u32 val;
+
 	/*
 	 * If the firmware is not running use software CM. This platform
 	 * should fully support both.
 	 */
-	return icm_firmware_running(tb->nhi);
+	val = ioread32(tb->nhi->iobase + REG_FW_STS);
+	return !!(val & REG_FW_STS_NVM_AUTH_DONE);
 }
 
 static void icm_handle_notification(struct work_struct *work)
-- 
2.28.0

