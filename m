Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00767CE24C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 18:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344817AbjJRQJE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 12:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344761AbjJRQIx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 12:08:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2152119;
        Wed, 18 Oct 2023 09:08:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6746CC433C8;
        Wed, 18 Oct 2023 16:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697645330;
        bh=PzeEk2W5nKRvW7BKtpqaTV+ksXI9b1FDcRk+eepXmZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e5mWmt8AmVEDOoabuds9W7G5s4c45xq/6joWWLAQr2xO4r4UuD307wiyMqOeerjhf
         loKFiZn3n1f6+C+6Zk7dGYrRemE1XsnlYKs45BmAAZ56xdMwKc5PRW3hXcEGQxBJ46
         4LsndmrdxmgnV6Rf6smYLfsMVmpmhnrc3sDPOJ63yB5eNjJ6T/+OUquEOSNLpxMp5y
         TVgIvDzbWpBIpzllft4u8xqmvj3GcDiaCt9cb8/+RazaGS9RQjL6xw7UAvBUdSHDC6
         vuXHvKdqntcWR0yQjy4vLdxP5vSssAmI+H3VEeOUVbuEHArMvIN4xkKlZTUvg9Lw0d
         5k3gIIYcKYJIQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Mateusz Nowicki <mateusz.nowicki@solidigm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5/8] lspci: Decode PCIe LnkCtl Link Disable as 'LnkDisable'
Date:   Wed, 18 Oct 2023 11:08:33 -0500
Message-Id: <20231018160836.1361510-6-helgaas@kernel.org>
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

Decode the Link Disable bit as "LnkDisable" (not simply "Disable") to match
the spec terminology (PCIe r6.0, sec 7.5.3.7)

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ls-caps.c b/ls-caps.c
index 0d333d578407..6c5b73bf2dca 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -841,7 +841,7 @@ static void cap_express_link(struct device *d, int where, int type)
   if ((type == PCI_EXP_TYPE_ROOT_PORT) || (type == PCI_EXP_TYPE_ENDPOINT) ||
       (type == PCI_EXP_TYPE_LEG_END) || (type == PCI_EXP_TYPE_PCI_BRIDGE))
     printf(" RCB %d bytes,", w & PCI_EXP_LNKCTL_RCB ? 128 : 64);
-  printf(" Disabled%c CommClk%c\n\t\t\tExtSynch%c ClockPM%c AutWidDis%c BWInt%c AutBWInt%c\n",
+  printf(" LnkDisable%c CommClk%c\n\t\t\tExtSynch%c ClockPM%c AutWidDis%c BWInt%c AutBWInt%c\n",
 	FLAG(w, PCI_EXP_LNKCTL_DISABLE),
 	FLAG(w, PCI_EXP_LNKCTL_CLOCK),
 	FLAG(w, PCI_EXP_LNKCTL_XSYNCH),
-- 
2.34.1

