Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7044A4D77F6
	for <lists+linux-pci@lfdr.de>; Sun, 13 Mar 2022 20:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiCMTbC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Mar 2022 15:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbiCMTbB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2022 15:31:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82014D604
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 12:29:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97BEBB80CF8
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 19:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1588C340E8;
        Sun, 13 Mar 2022 19:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647199791;
        bh=UOpshoQL5wNElzDvJvmD94VczSXO1d5Ji6JC3kIUJCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M4qNMxtobic8vI4B/oKgtfTQZz7KK7mpB3gEuTPokEA+fXx9sfyXJcCheg4bb2GN/
         cErjmWc0npSJKWY0w6AsL14fwxrBPmGkA2OOuvUdRbD5EMhBw9QW7x5VSTT2Gfc5Hh
         HouZHgnZz7VTU6oYdVD9G3zheGxlxzrdN2gDUj6eoTf3CbcXjzfQuInWCgCDSihsZ5
         xcL0a+Nfil3uNjI+I3s4NGDnF9+BnapTGclTACKTuxomJGHNk4f7bUMFIApCYmepBA
         /6hgs3nBmWopvATAOfj656sLrTYAwzvgP5Xyb3z6ms+5QWhegQrjBeaXCRfmxd0Yb7
         sf+YrAiDQPvyw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5/5] PCI: ibmphp: Remove unused assignments
Date:   Sun, 13 Mar 2022 14:29:33 -0500
Message-Id: <20220313192933.434746-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220313192933.434746-1-helgaas@kernel.org>
References: <20220313192933.434746-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Remove variables and assignments that are never used.

Found by Krzysztof Wilczyński <kw@linux.com> using cppcheck, e.g.:

  $ cppcheck --enable=all --force
  unreadVariable drivers/pci/hotplug/ibmphp_res.c:1958 Variable 'bus_sec' is assigned a value that is never used.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/ibmphp_hpc.c | 2 --
 drivers/pci/hotplug/ibmphp_res.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
index 508a62a6b5f9..a5720d12e573 100644
--- a/drivers/pci/hotplug/ibmphp_hpc.c
+++ b/drivers/pci/hotplug/ibmphp_hpc.c
@@ -325,11 +325,9 @@ static u8 i2c_ctrl_write(struct controller *ctlr_ptr, void __iomem *WPGBbar, u8
 static u8 isa_ctrl_read(struct controller *ctlr_ptr, u8 offset)
 {
 	u16 start_address;
-	u16 end_address;
 	u8 data;
 
 	start_address = ctlr_ptr->u.isa_ctlr.io_start;
-	end_address = ctlr_ptr->u.isa_ctlr.io_end;
 	data = inb(start_address + offset);
 	return data;
 }
diff --git a/drivers/pci/hotplug/ibmphp_res.c b/drivers/pci/hotplug/ibmphp_res.c
index ae9acc77d14f..4a72ade2cddb 100644
--- a/drivers/pci/hotplug/ibmphp_res.c
+++ b/drivers/pci/hotplug/ibmphp_res.c
@@ -1955,7 +1955,7 @@ static int __init update_bridge_ranges(struct bus_node **bus)
 						bus_sec = find_bus_wprev(sec_busno, NULL, 0);
 						/* this bus structure doesn't exist yet, PPB was configured during previous loading of ibmphp */
 						if (!bus_sec) {
-							bus_sec = alloc_error_bus(NULL, sec_busno, 1);
+							alloc_error_bus(NULL, sec_busno, 1);
 							/* the rest will be populated during NVRAM call */
 							return 0;
 						}
@@ -2114,6 +2114,5 @@ static int __init update_bridge_ranges(struct bus_node **bus)
 		}	/* end for function */
 	}	/* end for device */
 
-	bus = &bus_cur;
 	return 0;
 }
-- 
2.25.1

