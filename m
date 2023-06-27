Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99D673FC46
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 14:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjF0M4R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 08:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjF0M4Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 08:56:16 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBED26BA;
        Tue, 27 Jun 2023 05:56:15 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fa7512e599so55157345e9.2;
        Tue, 27 Jun 2023 05:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687870574; x=1690462574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0CmpeFe/W7bct0on6Cvz9lgbR3MqPfbzft85pRxf6ro=;
        b=g4OCr0xCnqtOLwIff9cOjbimo678mSohP7uVU+SD3EwzZ17aTKL42gv2ikphvZsson
         5g6ylW6ZyahqPBuFpa+opBxL8HbO9AgV52ftmztGHHX4jfHHjuxpiwu6zmnQ7IEZ9DwF
         4ZF+Yx+ozMUfGWsl57m0KyXjmbFERhb4/PW8Xktz3dQMg4/hnxcY/iUi7bpMxRJPa4Yu
         XkIpxBjyIygPv/ik0WZhzZTW24DFy14gP9TkOXvLR1eu5aArTsAy0SeD5Po0PtPKpFuc
         wJ//VE+td7ipEXQyL67jvpywdnqquB7g/8lDcFxWhrU/wnxZHyAKkHnAkYyNyQ74Z/cY
         K4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687870574; x=1690462574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CmpeFe/W7bct0on6Cvz9lgbR3MqPfbzft85pRxf6ro=;
        b=RREWShUzvQh8876NqqIzDdmQeHA9dfxUAwcRC65DAfbD/qUJC4PiopD1FTsh2Otlrp
         P666M4PhwpEgdDb9XH2wEiPMJy4FSBHizagB4aHLW4Kt4ibojM4QkjpkcM2i0L2Naw8q
         CVlY6PZXF15vjUvdkVPeHJwOLYtxQS6EPfd/awU8kdynQ35KkW8MtxbAhmaOvoD7IPH3
         xglb/Z3JbQE0qICmFPtj0CKGD+LvmBkgyrr1CyjOU8g6JAVCu+D529qMjMt1sy9HYA9S
         WT5uvatrvCQFkvfdE1nFQlRJYnf5H64Znzf6xbL6dz2HCSy/NHResbE42yOOU84bFLc/
         yLPA==
X-Gm-Message-State: AC+VfDwUfOv07y0hpoxcHMos47297h/9DlKGRbIRmz4loJLjxwvKZD3s
        ql6UAPHRBe5h1LSBbGZsxyoYubN0uyC8sg==
X-Google-Smtp-Source: ACHHUZ7zKsWmfe9syFfOnBXnGTnLWMSLV/h5hNjDh/rD9v8tbqRWdWWlu+EGK0726d1L4A3TSdoh6A==
X-Received: by 2002:a1c:7705:0:b0:3fa:c3e8:901a with SMTP id t5-20020a1c7705000000b003fac3e8901amr3249818wmi.25.1687870574209;
        Tue, 27 Jun 2023 05:56:14 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c21c900b003fb41491670sm3321616wmj.24.2023.06.27.05.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 05:56:13 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] PCI: ibmphp: make read-only arrays static
Date:   Tue, 27 Jun 2023 13:56:12 +0100
Message-Id: <20230627125612.724764-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't populate the arrays on the stack, instead make them static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/pci/hotplug/ibmphp_pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
index 754c3f23282e..50038e5f9ca4 100644
--- a/drivers/pci/hotplug/ibmphp_pci.c
+++ b/drivers/pci/hotplug/ibmphp_pci.c
@@ -329,7 +329,7 @@ int ibmphp_configure_card(struct pci_func *func, u8 slotno)
 static int configure_device(struct pci_func *func)
 {
 	u32 bar[6];
-	u32 address[] = {
+	static const u32 address[] = {
 		PCI_BASE_ADDRESS_0,
 		PCI_BASE_ADDRESS_1,
 		PCI_BASE_ADDRESS_2,
@@ -564,7 +564,7 @@ static int configure_bridge(struct pci_func **func_passed, u8 slotno)
 	struct resource_node *pfmem = NULL;
 	struct resource_node *bus_pfmem[2] = {NULL, NULL};
 	struct bus_node *bus;
-	u32 address[] = {
+	static const u32 address[] = {
 		PCI_BASE_ADDRESS_0,
 		PCI_BASE_ADDRESS_1,
 		0
@@ -1053,7 +1053,7 @@ static struct res_needed *scan_behind_bridge(struct pci_func *func, u8 busno)
 	int howmany = 0;	/*this is to see if there are any devices behind the bridge */
 
 	u32 bar[6], class;
-	u32 address[] = {
+	static const u32 address[] = {
 		PCI_BASE_ADDRESS_0,
 		PCI_BASE_ADDRESS_1,
 		PCI_BASE_ADDRESS_2,
@@ -1182,7 +1182,7 @@ static struct res_needed *scan_behind_bridge(struct pci_func *func, u8 busno)
 static int unconfigure_boot_device(u8 busno, u8 device, u8 function)
 {
 	u32 start_address;
-	u32 address[] = {
+	static const u32 address[] = {
 		PCI_BASE_ADDRESS_0,
 		PCI_BASE_ADDRESS_1,
 		PCI_BASE_ADDRESS_2,
@@ -1310,7 +1310,7 @@ static int unconfigure_boot_bridge(u8 busno, u8 device, u8 function)
 	struct resource_node *mem = NULL;
 	struct resource_node *pfmem = NULL;
 	struct bus_node *bus;
-	u32 address[] = {
+	static const u32 address[] = {
 		PCI_BASE_ADDRESS_0,
 		PCI_BASE_ADDRESS_1,
 		0
-- 
2.39.2

