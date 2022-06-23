Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6516C558210
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 19:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiFWRJ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 13:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiFWRIq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 13:08:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B5C55353;
        Thu, 23 Jun 2022 09:57:24 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so1367183wmr.0;
        Thu, 23 Jun 2022 09:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3U0JvexK71NTNZkmX0NIsRWRyI4BPMxyMDkrutu/XI=;
        b=PlGKEfs2QZJui/v+gDPXf87JqHxXFHLJ1YzIZsM5GVST3Fym+W4HJLW7lSGfKRzNh5
         s5LxljZzyQCDtTVTk5WQ5SMXJbkPzJ+408oUftaJ2zskfP0ilQIezQ/hEnRF0LYvTHD8
         prQo+p6LaPhWsJcAW8r1jj1NqF/s2A3J2gprJJTPFTF/jqmWeRbeGOqKWrSQYebwEXnH
         FLTz5x5QgqmEX/1UREMMBGR/f6EceUGn8C4Lo2A8l7npCYnQdWoXkrA+dXChs+OexcpF
         BdYqJn7CQMtZT+/pBJuPIUUz6Gttfu/EmBU96WixCQVByRUTdUPGDnaVNBFXaUjZrnVx
         br+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3U0JvexK71NTNZkmX0NIsRWRyI4BPMxyMDkrutu/XI=;
        b=Bnlf1B/lnUngkZjN0TKzLOPOsysTOrHnoXEOWyuHpwpUruY6wV0DTqn7cSIGDUpj64
         kxgzN7UswXEkSZaiLotj4Y6z+Bh0oZOvWtlDt+Zltwbjxa/OhLQf+4kLsaiVZmcV6x5w
         9PFBPTiZ2QYju98kbrOLPtyMdsqd5oIoKhijuJ8dOnXoOMkEU4oVGgEtwz5PAUAmNDLj
         rBTp4qGo6zKhQHXp/tlCtXxcbQ3kJUAgXp82Bm9eF78Ki5AYKbKPEfZbdFheTjaprrrF
         3lyjh3WQweD6130AnHq4mXKr3h5osF1Rr3W0zyvKOFBnyY224bZ97zy253VdlPsk85ok
         9ppA==
X-Gm-Message-State: AJIora/XMJulfNMCPkxMmtcKMP1wxFNojOzfTaKKAyTQVxdkIul9K4Dg
        GYSciN78FHACVHBEl2kbjyQ=
X-Google-Smtp-Source: AGRyM1vOnY+XPrdkmfg3FiuwdduapQjCO/zQGdKRk02eOow6Z1ktaEfsJfb1f/ZWqebxM5JEn8htBw==
X-Received: by 2002:a1c:f213:0:b0:39b:ad32:5e51 with SMTP id s19-20020a1cf213000000b0039bad325e51mr5107372wmc.72.1656003430485;
        Thu, 23 Jun 2022 09:57:10 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bca59000000b0039746638d6esm3602006wml.33.2022.06.23.09.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 09:57:09 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@nxp.com>,
        linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] NTB: EPF: set pointer addr to null using NULL rather than 0
Date:   Thu, 23 Jun 2022 17:57:09 +0100
Message-Id: <20220623165709.77229-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
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

The pointer addr is being set to null using 0. Use NULL instead.

Cleans up sparse warning:
warning: Using plain integer as NULL pointer

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index ebf7e243eefa..fb31c868af6a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -605,7 +605,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 
 		ntb->epf->bar[barno].barno = barno;
 		ntb->epf->bar[barno].size = size;
-		ntb->epf->bar[barno].addr = 0;
+		ntb->epf->bar[barno].addr = NULL;
 		ntb->epf->bar[barno].phys_addr = 0;
 		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
 				PCI_BASE_ADDRESS_MEM_TYPE_64 :
-- 
2.35.3

