Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8330675EDE3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 10:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjGXIkR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 04:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjGXIkL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 04:40:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428B9E73;
        Mon, 24 Jul 2023 01:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690188008; x=1721724008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dB65KYAnPw+sNmlSCdKHMTxaILoR7JZ35XDU87KFMkQ=;
  b=SmlsB+tw8Noal+1XL/3RZP3cnNoJ+IFkNJJgj4o6aflpCEFmvymX1TXn
   f7zg8ZTggaJ+FTzdFmeBA4ttHvkx08t/HZMB7tA+wHZ990ipHzysE0lWT
   lUKOnBZX/J1wi4gSy9NSAmZG89eccw/GKaOFY/REZ5aoCRFMcgNjdhhRk
   NJ753lC3wOLCmRBLXPhQx6xXQ5MbyINWDbzp3ot+7Oe1V+v2gUIOOKy34
   f1N4CvaoeUb7zflrn4Y1sSZuOO7P45QCHtrMnYXO9BjwFYWK5HGV7AMAk
   kFrZHWMfqDAN88a2G8OAmJXGqxFi6XiB9LI6l9E1xquNdsEKq7RId7sNE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="433627671"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="433627671"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:40:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="675749498"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="675749498"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.138.235])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:40:05 -0700
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
Subject: [PATCH v3 3/4] serial: 8250_pci: add support for ASIX AX99100
Date:   Mon, 24 Jul 2023 08:39:32 +0000
Message-Id: <20230724083933.3173513-4-jiaqing.zhao@linux.intel.com>
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

Each of the 4 PCI functions on ASIX AX99100 PCIe to Multi I/O
Controller can be configured as a single-port serial port controller.
The subvendor id is 0x1000 when configured as serial port and MSI
interrupts are supported.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index d2d547b5da95..62a9bd30b4db 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -67,6 +67,8 @@ static const struct pci_device_id pci_use_msi[] = {
 			 0xA000, 0x1000) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
 			 0xA000, 0x1000) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+			 0xA000, 0x1000) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
 			 PCI_ANY_ID, PCI_ANY_ID) },
 	{ }
@@ -5557,6 +5559,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
 		0xA000, 0x3004,
 		0, 0, pbn_b0_bt_4_115200 },
+
+	/*
+	 * ASIX AX99100 PCIe to Multi I/O Controller
+	 */
+	{	PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+		0xA000, 0x1000,
+		0, 0, pbn_b0_1_115200 },
+
 	/* Intel CE4100 */
 	{	PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CE4100_UART,
 		PCI_ANY_ID,  PCI_ANY_ID, 0, 0,
-- 
2.39.2

