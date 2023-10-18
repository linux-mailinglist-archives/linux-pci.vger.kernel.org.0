Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049207CE24D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 18:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjJRQIq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjJRQIq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 12:08:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB46119;
        Wed, 18 Oct 2023 09:08:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11776C433C9;
        Wed, 18 Oct 2023 16:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697645324;
        bh=LBqgEqSkWiN+BK8LYJfl340TaXdq+C0f570tWEKS9Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRenJn5llzBxbKpLJMy89gPfTgfhwAIT+1F75L6hZdWZLSTS619F0Xlx3JAVES0AK
         Z32UTZ/IcKoVOwTGbNlyxwQCD99RQ47ufXGyHfmWii7+9d/XevkZu9P8qsVFZH8TLP
         zL26TClR1Zxn0cURuVlRO2SFissSUXka0maT7ffXg2ZfQhnMQRWWqsfnkOO7shSID5
         Bo6vlgnDx9C84tL7kEwHPdZfYdIkJMsToGhjKb3f7E72XHxYz6oxLcOIQQd8vPjpeP
         mAJOdKNAYTSmVckp9ShYb2f/z85SnSU/M3odqizrslXJ0XHy9Ng/hoX9F/mbVxADQ2
         zwd/Kv4e2tuyA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Mateusz Nowicki <mateusz.nowicki@solidigm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/8] lspci: Reorder PCIe DevCtl2 fields to match spec
Date:   Wed, 18 Oct 2023 11:08:29 -0500
Message-Id: <20231018160836.1361510-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018160836.1361510-1-helgaas@kernel.org>
References: <20231018160836.1361510-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Decode the PCIe DevCtl2 fields in the same order they're documented in the
PCIe spec.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index 1b63262ef005..beb7446a926e 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1153,12 +1153,9 @@ static void cap_express_dev2(struct device *d, int where, int type)
     }
 
   w = get_conf_word(d, where + PCI_EXP_DEVCTL2);
-  printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c LTR%c 10BitTagReq%c OBFF %s,",
+  printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c",
 	cap_express_dev2_timeout_value(PCI_EXP_DEVCTL2_TIMEOUT_VALUE(w)),
-	FLAG(w, PCI_EXP_DEVCTL2_TIMEOUT_DIS),
-	FLAG(w, PCI_EXP_DEVCTL2_LTR),
-	FLAG(w, PCI_EXP_DEVCTL2_10BIT_TAG_REQ),
-	cap_express_devctl2_obff(PCI_EXP_DEVCTL2_OBFF(w)));
+	FLAG(w, PCI_EXP_DEVCTL2_TIMEOUT_DIS));
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
     printf(" ARIFwd%c\n", FLAG(w, PCI_EXP_DEVCTL2_ARI));
   else
@@ -1176,6 +1173,10 @@ static void cap_express_dev2(struct device *d, int where, int type)
         printf(" EgressBlck%c", FLAG(w, PCI_EXP_DEVCTL2_ATOMICOP_EGRESS_BLOCK));
       printf("\n");
     }
+  printf("\t\t\t LTR%c 10BitTagReq%c OBFF %s\n",
+	FLAG(w, PCI_EXP_DEVCTL2_LTR),
+	FLAG(w, PCI_EXP_DEVCTL2_10BIT_TAG_REQ),
+	cap_express_devctl2_obff(PCI_EXP_DEVCTL2_OBFF(w)));
 }
 
 static const char *cap_express_link2_speed_cap(int vector)
-- 
2.34.1

