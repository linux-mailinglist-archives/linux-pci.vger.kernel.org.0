Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAE84C4D6A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 19:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiBYSNP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 13:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiBYSNO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 13:13:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB8F16A58B
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 10:12:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65DE3B82AB8
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 18:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE466C340F1;
        Fri, 25 Feb 2022 18:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645812758;
        bh=zX1/+g9L2/4b/UFUS0xmE7/KhKaZ/JnZojdJEum39Jk=;
        h=From:To:Cc:Subject:Date:From;
        b=MjgzmZ3tyoWnBS4uyvmGAJI1kjTcyWCs5oZ6JPkKK3051XDMiKT56a8U1+lSIplYL
         hrn+rh3hCm63+F0islTiCzNn8b64bgCgIX0hczD+dNazdXMw0LgGIISdvGBeGWg+45
         tfNFFUQX3gtV+JM8JLWmrh9o6XVPjMWwDCF80wXD6S8V+WLpV6vLtiYg6o81ZHqnQo
         dz2Kxh/kx7Qr6WKLNz4snBWQHw6pBQzc59nz7MsfFRKNwUQlx5YwJCSWEc8hbKs4bM
         PDaGw/+73BRfEdYEXXSuBgb5WNUZOhmGSOuSmlJokTY5MgbmJeTMtl4xVTi+53p8SW
         dljbggUrJ62AQ==
Received: by pali.im (Postfix)
        id 0C1567EF; Fri, 25 Feb 2022 19:12:35 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH] lspci: Decode PCIe 6.0 Slot Power Limit values
Date:   Fri, 25 Feb 2022 19:12:09 +0100
Message-Id: <20220225181209.12642-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the Slot Power Limit Scale field equals 00b (1.0x) and Slot
Power Limit Value exceeds EFh, the following alternative encodings
are used:

  F0h   > 239 W and ≤ 250 W Slot Power Limit
  F1h   > 250 W and ≤ 275 W Slot Power Limit
  F2h   > 275 W and ≤ 300 W Slot Power Limit
  F3h   > 300 W and ≤ 325 W Slot Power Limit
  F4h   > 325 W and ≤ 350 W Slot Power Limit
  F5h   > 350 W and ≤ 375 W Slot Power Limit
  F6h   > 375 W and ≤ 400 W Slot Power Limit
  F7h   > 400 W and ≤ 425 W Slot Power Limit
  F8h   > 425 W and ≤ 450 W Slot Power Limit
  F9h   > 450 W and ≤ 475 W Slot Power Limit
  FAh   > 475 W and ≤ 500 W Slot Power Limit
  FBh   > 500 W and ≤ 525 W Slot Power Limit
  FCh   > 525 W and ≤ 550 W Slot Power Limit
  FDh   > 550 W and ≤ 575 W Slot Power Limit
  FEh   > 575 W and ≤ 600 W Slot Power Limit
  FFh   Reserved for Slot Power Limit Values above 600 W

Previously only values F0h, F1h and F2h were covered.
---
Thanks Bjorn for providing this documentation!
---
 ls-caps.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index b0caa50943d6..0b6c97b3ed75 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -659,18 +659,16 @@ static int exp_downstream_port(int type)
 static void show_power_limit(int value, int scale)
 {
   static const float scales[4] = { 1.0, 0.1, 0.01, 0.001 };
-  static const int scale0_values[3] = { 250, 275, 300 };
 
-  if (scale == 0 && value >= 0xF0)
+  if (scale == 0 && value == 0xFF)
     {
-      /* F3h to FFh = Reserved for Slot Power Limit values above 300 W */
-      if (value >= 0xF3)
-        {
-          printf(">300W");
-          return;
-        }
-      value = scale0_values[value - 0xF0];
+      printf(">600W");
+      return;
     }
+
+  if (scale == 0 && value >= 0xF0 && value <= 0xFE)
+    value = 250 + 25 * (value - 0xF0);
+
   printf("%gW", value * scales[scale]);
 }
 
-- 
2.20.1

