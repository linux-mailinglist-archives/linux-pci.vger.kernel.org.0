Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988E27CE248
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 18:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjJRQIv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 12:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjJRQIu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 12:08:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1478D119;
        Wed, 18 Oct 2023 09:08:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FCCC433C7;
        Wed, 18 Oct 2023 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697645327;
        bh=b8oAa/jdirMMTmQZgftTornsrNPKXWrb1kk+VtNeEYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kNUBrScUeqDw0NCA93kWHVjaqsImrYzD2M1Cu50OMLvVf8kZ4MRs/WEP0V3OLBG5W
         7q5R1ORwALM3X7BwLzBsbQ/Oq69b3sg4/XYWPvS7nA9siMpjOxZV6BJ8spuKEd8Tvt
         jBmXjhjWE8KSzl/4nYCLmDpv8wzCfF8qvNoeD7W5eng/SnuXXl4x7rA+U6yn6znsLd
         YHYN2JstE588u/vI9EjkktNgPRktDz1wWyBSdGBZH8Hg3eawuFFaqEmVR3BYEKEWkI
         sGJjOcvFbKV72c9GWvTkpUlrrJS57s4giIwN/vwRgDZ8bn1PE4LqeY9UIDNoUnmNvZ
         acC+lU20cWI/w==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Mateusz Nowicki <mateusz.nowicki@solidigm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/8] lspci: Decode PCIe DevCtl2 Emergency Power Reduction Request
Date:   Wed, 18 Oct 2023 11:08:31 -0500
Message-Id: <20231018160836.1361510-4-helgaas@kernel.org>
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

Decode the PCIe DevCtl2 Emergency Power Reduction Request bit.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lib/header.h | 1 +
 ls-caps.c    | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/header.h b/lib/header.h
index 5065465c33db..c3a720f716b7 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -906,6 +906,7 @@
 #define  PCI_EXP_DEVCTL2_IDO_REQ_EN	0x0100	/* Allow IDO for requests */
 #define  PCI_EXP_DEVCTL2_IDO_CMP_EN	0x0200	/* Allow IDO for completions */
 #define  PCI_EXP_DEVCTL2_LTR		0x0400	/* LTR enabled */
+#define  PCI_EXP_DEVCTL2_EPR_REQ	0x0800	/* Emergency Power Reduction Request */
 #define  PCI_EXP_DEVCTL2_10BIT_TAG_REQ	0x1000 /* 10 Bit Tag Requester enabled */
 #define  PCI_EXP_DEVCTL2_OBFF(x)		(((x) >> 13) & 3) /* OBFF enabled */
 #define PCI_EXP_DEVSTA2			0x2a	/* Device Status */
diff --git a/ls-caps.c b/ls-caps.c
index 0c7bef976144..19c59536f948 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1173,10 +1173,12 @@ static void cap_express_dev2(struct device *d, int where, int type)
         printf(" EgressBlck%c", FLAG(w, PCI_EXP_DEVCTL2_ATOMICOP_EGRESS_BLOCK));
       printf("\n");
     }
-  printf("\t\t\t IDOReq%c IDOCompl%c LTR%c 10BitTagReq%c OBFF %s\n",
+  printf("\t\t\t IDOReq%c IDOCompl%c LTR%c EmergencyPowerReductionReq%c\n",
 	FLAG(w, PCI_EXP_DEVCTL2_IDO_REQ_EN),
 	FLAG(w, PCI_EXP_DEVCTL2_IDO_CMP_EN),
 	FLAG(w, PCI_EXP_DEVCTL2_LTR),
+	FLAG(w, PCI_EXP_DEVCTL2_EPR_REQ));
+  printf("\t\t\t 10BitTagReq%c OBFF %s\n",
 	FLAG(w, PCI_EXP_DEVCTL2_10BIT_TAG_REQ),
 	cap_express_devctl2_obff(PCI_EXP_DEVCTL2_OBFF(w)));
 }
-- 
2.34.1

