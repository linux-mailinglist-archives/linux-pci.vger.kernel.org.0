Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403877CE25B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 18:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjJRQJw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 12:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344911AbjJRQI4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 12:08:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00AB134;
        Wed, 18 Oct 2023 09:08:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57528C433C9;
        Wed, 18 Oct 2023 16:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697645333;
        bh=qlnXN3MZd2ARQ31evVzZVp4O53rhkgUkI2a0l80jXDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcbAcu+YMSg5yT4gUSldXaovmU2XwHq47h8wYZsP19p/unz5kwPx6OC2p/5Q1y8/c
         7Pz3hZO50YcLqlB27EGZb1OFh9zxDolSJsei1CvCY+vrhOZWRr8qKrCb3jz3LHXohi
         9KJ84glQN8Lpa52+RvZFZS+W0d6qqI1uV8lU0+V+pxW9cTa43A3SdW3XVsYRwsJzZX
         Scv5oqLBw/lmSn4Dnwcak00My+slH1kMm+1KAJQLHCTzdz+1um4uqcUUvKk3zcWORy
         6P5fKff8X/3l9agprwxOP8LnUJgsfT/irkEjOkqodTSejFwLKoOARfOh7sg4ii/tQa
         AYqVzB+U02EHA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Mateusz Nowicki <mateusz.nowicki@solidigm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 7/8] lspci: Remove spurious colon (':') from PCIe PTM decoding
Date:   Wed, 18 Oct 2023 11:08:35 -0500
Message-Id: <20231018160836.1361510-8-helgaas@kernel.org>
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

Remove spurious colon from PTM decoding to match other enabled/disabled
decoding.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-ecaps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ls-ecaps.c b/ls-ecaps.c
index 5bc7a6907349..a22da6173e67 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -1245,7 +1245,7 @@ cap_ptm(struct device *d, int where)
 
   buff = get_conf_long(d, where + 4);
   printf("\t\tPTMCap: ");
-  printf("Requester:%c Responder:%c Root:%c\n",
+  printf("Requester%c Responder%c Root%c\n",
     FLAG(buff, 0x1),
     FLAG(buff, 0x2),
     FLAG(buff, 0x4));
@@ -1266,7 +1266,7 @@ cap_ptm(struct device *d, int where)
 
   buff = get_conf_long(d, where + 8);
   printf("\t\tPTMControl: ");
-  printf("Enabled:%c RootSelected:%c\n",
+  printf("Enabled%c RootSelected%c\n",
     FLAG(buff, 0x1),
     FLAG(buff, 0x2));
 
-- 
2.34.1

