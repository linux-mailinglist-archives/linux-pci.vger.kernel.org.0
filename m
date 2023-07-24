Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3936375EDE7
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 10:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjGXIkS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 04:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjGXIkP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 04:40:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D16E1A1;
        Mon, 24 Jul 2023 01:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690188011; x=1721724011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ACtwk6q0osdWK/LRY8lcrJv/gU2GjAAIEZNi8CD+KKM=;
  b=dPpx5aVju3ej9PX4u7K7zKzQViO7AN1G5Wb2VRVEqbiIVBJd3HDdGZF8
   Msi036d57dOHW/ZdOLMOubqMqYj6FjKoNJZjz789kvod+znaUCMYDXCDY
   W6++miZdpCpQQFKEnoCOsF9xy8WuMRA8pn7TcYaIjqQ96sZXCbXvy7ChF
   0LGEcTylfTXKmMlIvzngSbaPrw0/Fuz2FtIFYcxJLCjIvqcIIjsLk1dFL
   o172C2re2RnL5CA6aeU473YnO+JGJ8IpniMV4stqmt5YgcoeBSeF8mZdA
   UNApLqJ7av3+NXupfqFcv7nCYdMZlodCKND8zJcY9Ep5a5LwcsZTuOjAg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="433627685"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="433627685"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="675749521"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="675749521"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.138.235])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:40:08 -0700
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        support@ems-wuensche.com, linux-serial@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH v3 4/4] parport_pc: add support for ASIX AX99100
Date:   Mon, 24 Jul 2023 08:39:33 +0000
Message-Id: <20230724083933.3173513-5-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724083933.3173513-1-jiaqing.zhao@linux.intel.com>
References: <20230724083933.3173513-1-jiaqing.zhao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI function 2 on ASIX AX99100 PCIe to Multi I/O Controller can be
configured as a single-port parallel port controller. The subvendor id
is 0x2000 when configured as parallel port. It supports IEEE-1284 EPP /
ECP with its ECR on BAR1.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/parport_pc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 3bacbaf16f42..1f236aaf7867 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2655,6 +2655,7 @@ enum parport_pc_pci_cards {
 	netmos_9815,
 	netmos_9901,
 	netmos_9865,
+	asix_ax99100,
 	quatech_sppxp100,
 	wch_ch382l,
 };
@@ -2733,6 +2734,7 @@ static struct parport_pc_pci {
 	/* netmos_9815 */		{ 2, { { 0, 1 }, { 2, 3 }, } },
 	/* netmos_9901 */               { 1, { { 0, -1 }, } },
 	/* netmos_9865 */               { 1, { { 0, -1 }, } },
+	/* asix_ax99100 */		{ 1, { { 0, 1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
 	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
 };
@@ -2823,6 +2825,9 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	  0xA000, 0x1000, 0, 0, netmos_9865 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
 	  0xA000, 0x2000, 0, 0, netmos_9865 },
+	/* ASIX AX99100 PCIe to Multi I/O Controller */
+	{ PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+	  0xA000, 0x2000, 0, 0, asix_ax99100 },
 	/* Quatech SPPXP-100 Parallel port PCI ExpressCard */
 	{ PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SPPXP_100,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
-- 
2.39.2

