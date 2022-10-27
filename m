Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1CB60F688
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 13:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbiJ0Lvh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 07:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ0Lvg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 07:51:36 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B2E3A3B54;
        Thu, 27 Oct 2022 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pL/rs
        MZcAfjalFQs06h+m85GbtUtZ1JtImfRSdcQ5Tc=; b=Y65k7xgF1Ja0/tkXTW+eB
        tvmb8vLsWT7SfJmTq5qcg+B6CJ3dpQBmxVgXcVC+6R7J/fWyMDBh1hHBs7VzzGZp
        rYhA0vnXFqlzngAzrKvwNDkbirPW4GJ52uePYqLUdY+du0HgVn/CiqCLG78LpvhP
        nPenkUufz+Ea+cGCOzTd30=
Received: from jbd-ThinkPad-X1-Nano-Gen-1.. (unknown [223.104.68.105])
        by smtp7 (Coremail) with SMTP id C8CowADn7G29cFpjxAdLOQ--.44181S2;
        Thu, 27 Oct 2022 19:51:26 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] PCI: Add vendor ID for Quectel and Cinterion
Date:   Thu, 27 Oct 2022 19:51:23 +0800
Message-Id: <20221027115123.5326-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowADn7G29cFpjxAdLOQ--.44181S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1kXFWDKr13Jryktw1UWrg_yoWfWrg_Aw
        n7Waykur45uF1xtw4kZ345ZwnIk3s2vFnIvFZYkrs5uas0kFW5C3s7Gr97Xa4F9a1qkr15
        Jan2g34Iv3WYkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKdgWPUUUUU==
X-Originating-IP: [223.104.68.105]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiRx6nZFc7ZFT0ZQAAsX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In MHI driver, there are some companies product still
do not have their own PCI vendor macro. So we add it
here to make the code neat. Ref ID could be found in
link https://pcisig.com/membership/member-companies.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 include/linux/pci_ids.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b0..e3bfea06b90e 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -172,6 +172,10 @@
 #define PCI_DEVICE_ID_BERKOM_A4T		0xffa4
 #define PCI_DEVICE_ID_BERKOM_SCITEL_QUADRO	0xffa8
 
+#define PCI_VENDOR_ID_CINTERION		0x1269
+
+#define PCI_VENDOR_ID_QUECTEL		0x1eac
+
 #define PCI_VENDOR_ID_COMPAQ		0x0e11
 #define PCI_DEVICE_ID_COMPAQ_TOKENRING	0x0508
 #define PCI_DEVICE_ID_COMPAQ_TACHYON	0xa0fc
-- 
2.34.1

