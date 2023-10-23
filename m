Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ADA7D2CF9
	for <lists+linux-pci@lfdr.de>; Mon, 23 Oct 2023 10:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjJWIll (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Oct 2023 04:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWIlk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2023 04:41:40 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA77188
        for <linux-pci@vger.kernel.org>; Mon, 23 Oct 2023 01:41:38 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c4fe37f166so42410331fa.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Oct 2023 01:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698050497; x=1698655297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j/3+9nhVChZnrsltAT9zLhXg6t1HKK0voMsJum2aJa8=;
        b=E0MBVqiuBHmenHDZWeWUGwjRN+mxMLG0rZBsqT6j0SSPt0dPRfXitNF5Od7/TVUhD5
         RiWzhahT0Q3yCASngO0mHI9fuTVGtpC55O1O9DtJOyjScldgbV4AGjUfGgq74YxYxbWg
         VRFH+aWBhxCYGK3DBZYMyoMcAvLjERngAloqiJ832xFo7gnUFaWzIWy+RTrEyyrR4NAc
         it3yIr/s3VTvW1LR43Tjcg9h31FEJs3W9Qr8CTuzILEFwEIe5vfhm+EwAi4ROPOvvU0i
         CEkOnlNYyVpVP2p9SRxNCaQnaYR9syKTMG/lfi5alVUVS1rrOIb+eBZ8crv7vISA9DXX
         U2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698050497; x=1698655297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/3+9nhVChZnrsltAT9zLhXg6t1HKK0voMsJum2aJa8=;
        b=pkYvc90dvXPCNe5CL/aIf5Iyz4lO1QyMROJN6qqhKxvvUhPc4K5gM0KDKmeB5Oaedq
         +rIS7UkNxnkUR9tuYZoSMvj3y9exiXe8fBeYLgVHKpCJUcDhhvqFlYEF2rHp9OzuXIse
         6yaWoHexUTxD7KIV4Wlyw8Prd3RNlhCYPtZgnOJZSIAjmcK6XRg0ctrm45qsBdbkZj5H
         8CF/LMfgBjL4W1SOAXjusvbY05p2g5YHN2+3rMuH9cAzJbM9ijvLQt2hItT8xZVd0tRf
         Ov6aYqbizM35W16GeIiGYoEOBTBwYEyxRbp2Y86AuCVSBo4HVJF9BuwNsvevPWw9SdsF
         uZlA==
X-Gm-Message-State: AOJu0Yyus8liX2b2+EtB/H59+vhAl3BIc3t2MeupeoW6cLfgkh5OTfjz
        4eFUSUpP5IZFULe6edBMug8=
X-Google-Smtp-Source: AGHT+IFR1v0mw7zTzBR2BPgzhq9aUrkENzJleFstAC7MEtqnJD4Db3zlxeUheJ+OZest+hfPpBreCw==
X-Received: by 2002:a2e:2e06:0:b0:2be:54b4:ff87 with SMTP id u6-20020a2e2e06000000b002be54b4ff87mr5937105lju.40.1698050496481;
        Mon, 23 Oct 2023 01:41:36 -0700 (PDT)
Received: from desktop.gigaio.com ([109.95.116.180])
        by smtp.gmail.com with ESMTPSA id k6-20020a2e9206000000b002bfc44dd6b3sm1464022ljg.63.2023.10.23.01.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:41:35 -0700 (PDT)
From:   Tadeusz Struk <tstruk@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org,
        Tadeusz Struk <tstruk@gigaio.com>,
        Tadeusz Struk <tstruk@gmail.com>
Subject: [PATCH] p2pdma: remove redundant goto
Date:   Mon, 23 Oct 2023 10:40:50 +0200
Message-ID: <20231023084050.55230-1-tstruk@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove redundant goto in pci_alloc_p2pmem()

Signed-off-by: Tadeusz Struk <tstruk@gmail.com>
---
 drivers/pci/p2pdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index fa7370f9561a..a7776315996c 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -837,7 +837,6 @@ void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
 	if (unlikely(!percpu_ref_tryget_live_rcu(ref))) {
 		gen_pool_free(p2pdma->pool, (unsigned long) ret, size);
 		ret = NULL;
-		goto out;
 	}
 out:
 	rcu_read_unlock();
-- 
2.41.0
