Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25587249D0F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 14:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgHSL7x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 07:59:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:1227 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgHSL7R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:17 -0400
IronPort-SDR: q9ccMLz+IN8zcluDn/ngIDYv3RgBrWlySZLIuANlmt4aTt3qUDI8XzLhffGQ6W0SvwwQN6SOD7
 uRKOeg0SVTMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="142904872"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="142904872"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:14 -0700
IronPort-SDR: PpzLTw4aqqPu8zna03CGkb69bCaPxR9U+8TtLKzKzB/zNpD+XQlUHtZdXYMZiIcR6kRpn1Cmou
 Ik7DN8K1GqLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="497724277"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2020 04:59:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7FB7B377; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
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
Subject: [PATCH 05/19] thunderbolt: Do not program NFC buffers for USB4 router protocol adapters
Date:   Wed, 19 Aug 2020 14:58:51 +0300
Message-Id: <20200819115905.59834-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

USB4 spec says that NFC buffers field is not used for protocol adapters,
only for lane adapters so make tb_port_add_nfc_credits() skip non-lane
adapters in order to follow the spec.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 698c52775eec..72756c8ceead 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -601,6 +601,13 @@ int tb_port_add_nfc_credits(struct tb_port *port, int credits)
 	if (credits == 0 || port->sw->is_unplugged)
 		return 0;
 
+	/*
+	 * USB4 restricts programming NFC buffers to lane adapters only
+	 * so skip other ports.
+	 */
+	if (tb_switch_is_usb4(port->sw) && !tb_port_is_null(port))
+		return 0;
+
 	nfc_credits = port->config.nfc_credits & ADP_CS_4_NFC_BUFFERS_MASK;
 	nfc_credits += credits;
 
-- 
2.28.0

