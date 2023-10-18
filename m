Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0547CE243
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 18:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjJRQJD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 12:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344667AbjJRQIu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 12:08:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A7211B;
        Wed, 18 Oct 2023 09:08:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E919EC433CD;
        Wed, 18 Oct 2023 16:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697645329;
        bh=U+icbxz1kQpSxKVwtVnxlURqaTCfhzPPoyC6yA7hpYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NzlTGalxvHoRIuy4CDpAJaYW4ce7iyvrTe8lNqZ7GubrpnYkvpdnZpUqEsltsr2P/
         erZHhyx/Fv4clNxoAm8fpaUAgVGvqYSdsCWG4fw/h+cIk4taXeAPZ/dxdJaDGGcELZ
         9rrFAt3HeG/bynpku7YWxpbEpfkUofTL6Re0hXEqWpWQbwc6diZit/FHRcP7Khs4pJ
         DM5Rg6PcILRi7eARssWlXeThkFRgtmjfQgnmCMa2u6X1ygomKXLgvtX8NbdFEcPWRW
         TbvNpnCx8+l3C/iBGQQZZvcDpPxbc9f79Pk+6rODZLqxzPf+mH9e3DsdfJ4LWjACVA
         5r1xiVMWkmzLQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Mateusz Nowicki <mateusz.nowicki@solidigm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/8] lspci: Decode PCIe DevCtl2 End-to-End TLP Prefix Blocking
Date:   Wed, 18 Oct 2023 11:08:32 -0500
Message-Id: <20231018160836.1361510-5-helgaas@kernel.org>
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

Decode the PCIe DevCtl2 End-to-End TLP Prefix Blocking bit.  The
"EETLPPrefixBlk" format is analogous to the existing "EETLPPrefix" format
used for the corresponding DevCap2 bit.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lib/header.h | 1 +
 ls-caps.c    | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index c3a720f716b7..4869617641f1 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -909,6 +909,7 @@
 #define  PCI_EXP_DEVCTL2_EPR_REQ	0x0800	/* Emergency Power Reduction Request */
 #define  PCI_EXP_DEVCTL2_10BIT_TAG_REQ	0x1000 /* 10 Bit Tag Requester enabled */
 #define  PCI_EXP_DEVCTL2_OBFF(x)		(((x) >> 13) & 3) /* OBFF enabled */
+#define  PCI_EXP_DEVCTL2_EE_TLP_BLK	0x8000	/* End-End TLP Prefix Blocking */
 #define PCI_EXP_DEVSTA2			0x2a	/* Device Status */
 #define PCI_EXP_LNKCAP2			0x2c	/* Link Capabilities */
 #define  PCI_EXP_LNKCAP2_SPEED(x)	(((x) >> 1) & 0x7f)
diff --git a/ls-caps.c b/ls-caps.c
index 19c59536f948..0d333d578407 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1178,9 +1178,10 @@ static void cap_express_dev2(struct device *d, int where, int type)
 	FLAG(w, PCI_EXP_DEVCTL2_IDO_CMP_EN),
 	FLAG(w, PCI_EXP_DEVCTL2_LTR),
 	FLAG(w, PCI_EXP_DEVCTL2_EPR_REQ));
-  printf("\t\t\t 10BitTagReq%c OBFF %s\n",
+  printf("\t\t\t 10BitTagReq%c OBFF %s, EETLPPrefixBlk%c\n",
 	FLAG(w, PCI_EXP_DEVCTL2_10BIT_TAG_REQ),
-	cap_express_devctl2_obff(PCI_EXP_DEVCTL2_OBFF(w)));
+	cap_express_devctl2_obff(PCI_EXP_DEVCTL2_OBFF(w)),
+	FLAG(w, PCI_EXP_DEVCTL2_EE_TLP_BLK));
 }
 
 static const char *cap_express_link2_speed_cap(int vector)
-- 
2.34.1

