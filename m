Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E817CE24E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 18:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjJRQIs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 12:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjJRQIr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 12:08:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D58A4;
        Wed, 18 Oct 2023 09:08:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B6DC433C7;
        Wed, 18 Oct 2023 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697645325;
        bh=0W4Sppyp3HwvlYFqGlIds6vyM6WyAPFFDufarTci3ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXJ/dWUFIT+1+pvmXztSZ4SJW62NtR37Dqq8hzJOTHOR2n3nxvs1qf5vzGmNd0lAK
         eExJdpOqQdox/P6VxR3gVvOy/Iu8YyyH+pzP1Nrnp1hXu9dJCJgaaRIJESO/awLvfN
         c2IASy+p0HeI02GqoTuNGr+eMBdeVCNVwojL0G/5yxifmR5UNUvspdaUlpkeRQ9Snl
         GXb8tjipTwOeDZ+uO50zBp88Elh09kYO1vhZm0TJdH2NzKCAb5h5pHCMI1V7HcPVOW
         uoQQcDs8FBGD9ce/QJZbrgNSjBtj1F+/4T5NXRxUg/OyV6dAHMF4bYqJ6FD4f8IKIq
         fJzRBF8yO1QkQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Mateusz Nowicki <mateusz.nowicki@solidigm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/8] lspci: Decode PCIe DevCtl2 ID-Based Ordering Enables
Date:   Wed, 18 Oct 2023 11:08:30 -0500
Message-Id: <20231018160836.1361510-3-helgaas@kernel.org>
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

Decode the PCIe DevCtl2 ID-Based Ordering Enable bits.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lib/header.h | 2 ++
 ls-caps.c    | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/header.h b/lib/header.h
index 57ef0ae8a31e..5065465c33db 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -903,6 +903,8 @@
 #define  PCI_EXP_DEVCTL2_ARI		0x0020	/* ARI Forwarding */
 #define  PCI_EXP_DEVCTL2_ATOMICOP_REQUESTER_EN	0x0040	/* AtomicOp RequesterEnable */
 #define  PCI_EXP_DEVCTL2_ATOMICOP_EGRESS_BLOCK	0x0080	/* AtomicOp Egress Blocking */
+#define  PCI_EXP_DEVCTL2_IDO_REQ_EN	0x0100	/* Allow IDO for requests */
+#define  PCI_EXP_DEVCTL2_IDO_CMP_EN	0x0200	/* Allow IDO for completions */
 #define  PCI_EXP_DEVCTL2_LTR		0x0400	/* LTR enabled */
 #define  PCI_EXP_DEVCTL2_10BIT_TAG_REQ	0x1000 /* 10 Bit Tag Requester enabled */
 #define  PCI_EXP_DEVCTL2_OBFF(x)		(((x) >> 13) & 3) /* OBFF enabled */
diff --git a/ls-caps.c b/ls-caps.c
index beb7446a926e..0c7bef976144 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1173,7 +1173,9 @@ static void cap_express_dev2(struct device *d, int where, int type)
         printf(" EgressBlck%c", FLAG(w, PCI_EXP_DEVCTL2_ATOMICOP_EGRESS_BLOCK));
       printf("\n");
     }
-  printf("\t\t\t LTR%c 10BitTagReq%c OBFF %s\n",
+  printf("\t\t\t IDOReq%c IDOCompl%c LTR%c 10BitTagReq%c OBFF %s\n",
+	FLAG(w, PCI_EXP_DEVCTL2_IDO_REQ_EN),
+	FLAG(w, PCI_EXP_DEVCTL2_IDO_CMP_EN),
 	FLAG(w, PCI_EXP_DEVCTL2_LTR),
 	FLAG(w, PCI_EXP_DEVCTL2_10BIT_TAG_REQ),
 	cap_express_devctl2_obff(PCI_EXP_DEVCTL2_OBFF(w)));
-- 
2.34.1

