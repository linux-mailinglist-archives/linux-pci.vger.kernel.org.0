Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB042505B0E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 17:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344935AbiDRPcH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 11:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344940AbiDRPbV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 11:31:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FFA64E5;
        Mon, 18 Apr 2022 07:44:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u3so18830208wrg.3;
        Mon, 18 Apr 2022 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/BmndimxRUeGnhgbDunPyQq29ma5+SBfEP8BqMsdFU=;
        b=ZLnqQm98G+ZMkFQXpLyGZSX7fecCPhjMaUZd1GrcqcdgaP6HD6TuQSlDJ3MYDJ6g7y
         fjGPUCmal/HdSK6Joq1ZM5PJTvmmrMpUwmh9uy8kZyyOytxq4Fz91uEVLK/alpOxuHD+
         hhKyyIWY6OZg4IaB8v/e30AnJ50CeXu34skkKWsH66GkjbeNa7HhkbRLzoYi5D01P4Gb
         G5IiYD7NH9MxyhCdiPXFNJ0pIWeASI4bs01Vyn9WUV+AurAIfp9oIcZHa0DdeIQuZLEK
         6dv3Howdcd6jr+QU19tVb12STIXLZaknW+Tm6Q12MyVCw1Mz9sQRQ7882olvihPcasSD
         Z0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/BmndimxRUeGnhgbDunPyQq29ma5+SBfEP8BqMsdFU=;
        b=m3i5mmN4b9dxY02Ht33enK1Is16KU5aNWitkytB6ggnDyZo0ZYPCo5YNpCxhXCJB/W
         jf3A9erR8ysECSKBJXejD04Ju63CeH6nQcuAT6J5J/aYrRC7tvPYr7qsNC3dFfsfx3vT
         p9HD/llAS2TnAx2sMdJAwWS/FMRCKZ4Jx54JOSlDSSlt7ZsomRqjjSMArd8BshsXAazw
         z8HrCaBcw8w0TWg4Of+/r9v1gGoVaBVT8Cgn5+2nvEEYnr1GlgdMautntnrOwfSBLzPT
         1+INy2LQDBJIlP17/QOdxncYbpRJCvQ/ZYkj4T5gYqgtHcXocmvJGX+VLBJWbCoDf26w
         vyig==
X-Gm-Message-State: AOAM533azVBcPXhL2mvdSWaw83vpux5ggO8a7FLT/mwdpOcbRamqhSqd
        luEt3RK7FX9BMQtbm1WQvyc=
X-Google-Smtp-Source: ABdhPJy6pPOJ+6VhwxYN/pnIzTHx+lgfuKlb7rqnPNvgzd2Y+LUnRXOI5h+9yUgPBmkfSXaE05jaAQ==
X-Received: by 2002:a05:6000:1ace:b0:203:d465:1a83 with SMTP id i14-20020a0560001ace00b00203d4651a83mr8476727wry.26.1650293058002;
        Mon, 18 Apr 2022 07:44:18 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d2-20020a056000186200b0020a7be3f1d2sm9107529wri.53.2022.04.18.07.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 07:44:17 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] PCI: versatile: Remove redundant variable retval
Date:   Mon, 18 Apr 2022 15:44:16 +0100
Message-Id: <20220418144416.86121-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Variable retval is being assigned a value that is never read, the
variable is redundant and can be removed.

Cleans up clang scan build warning:
drivers/pci/controller/pci-versatile.c:37:10: warning: Although the value
stored to 'retval' is used in the enclosing expression, the value is never
actually read from 'retval' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/pci/controller/pci-versatile.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index 653d5d0ecf81..7991d334e0f1 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -31,10 +31,9 @@ static u32 pci_slot_ignore;
 
 static int __init versatile_pci_slot_ignore(char *str)
 {
-	int retval;
 	int slot;
 
-	while ((retval = get_option(&str, &slot))) {
+	while (get_option(&str, &slot)) {
 		if ((slot < 0) || (slot > 31))
 			pr_err("Illegal slot value: %d\n", slot);
 		else
-- 
2.35.1

