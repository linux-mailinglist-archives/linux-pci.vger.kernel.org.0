Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A468C5AE0C7
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 09:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiIFHRN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 03:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238825AbiIFHRM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 03:17:12 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324A37390F;
        Tue,  6 Sep 2022 00:17:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d12so10441316plr.6;
        Tue, 06 Sep 2022 00:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=EuJPPf3+gOQ+Mj3XihQl7kx9QMOj/0MzDv+3h+Kjp/Y=;
        b=PxQfsJliUlBvt2c0ZZOHUHv1vw/zQ7b+Wouxon5GDThKnQ0jvdI1QQnAJSojGKWgaw
         ly8mqnZf8QbUG5FrMXyvdLg+9BBlhSs3KJGDN8P/KyB9a1iPpqKiHKBTipJC3tjdyqxY
         W//n46TaRVSo2E9o8VSYtZ/CdjK58o7B/HV6bsBtaCDAjhdhpTd/Fq5IZb+M3B/KcfeL
         EGsvXAKbYa38C/hSa8M49CpOtzo4+ZnLcRGVAFz4PPLiQlrJE9dOvUVl2daScKrfIXqF
         rt/ayV+Cs1ytUsYK9p+ZWKfjKN6315u6YyjBbAflmG/MZEdCD8FMuUejU+TRNOYB4u7C
         BK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=EuJPPf3+gOQ+Mj3XihQl7kx9QMOj/0MzDv+3h+Kjp/Y=;
        b=28b0IXkeQ69gIspJv6k/pKEg6f7pctkQYIt4M/326TqxvvfeizHR2XGlIwkEggtI0f
         4srPm7/AIGwUCAzagU6lSQFPYPG55BiG9AW8j4vfUy9TzqEjq9UqLQr7JlQbhsQqZjQ4
         osSLbY6t99rHNHT5YLeNYFNgNasnxTfpmGwqiSQypuzpzVB5d8eQlOpW6KxbmsPI7MGs
         tgEK2ybpWpdCzFMgJMcW2faa2z/P+c7ARzKKvdWWHX0Ca4+F0DED54pF+lN+WbGovOaS
         V9S++71VlDEnOiVisxukhpo8jC7Pn+esklaKtgtx4B4dM95C46sXGAcPAmJZthpnsbkQ
         3xOg==
X-Gm-Message-State: ACgBeo2HtwxLzfAqpMa0g1rz23SEwcQntwDY9wz+yfKY/JkpNTWPws4X
        DVX30YGUNLSIM5m3TBXzKmQ=
X-Google-Smtp-Source: AA6agR65jqq3t8Zmu7CpHTfJo9N0eRp5i4URxyb20PgzmvVUM1yYO3wrPbMWYW9k5NhTCJOALAux2Q==
X-Received: by 2002:a17:90b:1645:b0:1fe:b8d:307c with SMTP id il5-20020a17090b164500b001fe0b8d307cmr23532316pjb.185.1662448630627;
        Tue, 06 Sep 2022 00:17:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b130-20020a621b88000000b0052dbad1ea2esm9216700pfb.6.2022.09.06.00.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 00:17:10 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     lpieralisi@kernel.org
Cc:     robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] PCI: iproc: Remove the unneeded result variable
Date:   Tue,  6 Sep 2022 07:16:36 +0000
Message-Id: <20220906071636.336853-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value iproc_pcie_setup_ib() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/pci/controller/pcie-iproc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 2519201b0e51..bd32929ab265 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1244,7 +1244,6 @@ static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
 
 static int iproc_pcie_paxb_v2_msi_steer(struct iproc_pcie *pcie, u64 msi_addr)
 {
-	int ret;
 	struct resource_entry entry;
 
 	memset(&entry, 0, sizeof(entry));
@@ -1254,8 +1253,7 @@ static int iproc_pcie_paxb_v2_msi_steer(struct iproc_pcie *pcie, u64 msi_addr)
 	entry.res->start = msi_addr;
 	entry.res->end = msi_addr + SZ_32K - 1;
 
-	ret = iproc_pcie_setup_ib(pcie, &entry, IPROC_PCIE_IB_MAP_IO);
-	return ret;
+	return iproc_pcie_setup_ib(pcie, &entry, IPROC_PCIE_IB_MAP_IO);
 }
 
 static void iproc_pcie_paxc_v2_msi_steer(struct iproc_pcie *pcie, u64 msi_addr,
-- 
2.25.1
