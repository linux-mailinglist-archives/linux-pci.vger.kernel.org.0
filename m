Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A89273FB39
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 13:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjF0LiV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 07:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjF0LiP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 07:38:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5F22712;
        Tue, 27 Jun 2023 04:38:13 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1b80512a7f2so13280265ad.3;
        Tue, 27 Jun 2023 04:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687865893; x=1690457893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xEO3Nk6Y8XH6bTMW8nJppcuxQHpEE9aHNdQQmfT2ado=;
        b=Ykh79237L6j9Ib6rQESfFRbNpvxe1FrB4gQoazP9KifD3Wm81K+8wPiyx/LYR/7Aeu
         YmvyEge4bY5vzF3SlCDitPRfOfuV7c9RDOPGbtQfetsNHigRhvUpXf1T/Cw8LfaCBzux
         uJkYQKndrlvWa4xm0EjcAIlEYVmpi6mSqB5f/aGHYGsHb5WIqMI1tglwVnh0veDTGeDH
         6Y01zwJwKpqJikkKXV+wbpMXkRBeS2nhu7EMBpH4ACkARZvSQvnI53G3pgEs74t3Z5aG
         +R+snEuP1cwlfuzaxfImywrLgO9zM8EXMvy+wCMIflGm71KltwBhDYSJZRkwvzTRlL3H
         m1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687865893; x=1690457893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEO3Nk6Y8XH6bTMW8nJppcuxQHpEE9aHNdQQmfT2ado=;
        b=i5hqsYkqHwRZu1fXEIOG5iwpPluv7a5fBIk1ikQq2sWNgDGi2KM27h4v2L2nrYPags
         Beke+K+UIRrwBkSW3/M9wngcONufeMRcc3yMDgrHXrxFrDc7gIJFRFv7UGfbmF17PFul
         QATZ/lm/l6OMo/xyw4cAPglyO+8dIRaJoQOYYKICtXmNzNO3X2nByzn79OAWiMxLlTdU
         tuEBNduSK3w3hd99Yv7JjiK1uNEMlsCiV5bNJ44Cgr2Spe89NhQTq9IFrmTrRA4/jKc3
         eJ0p/s+kXspLVYOz8BUqt0QCoUIJlSQXUfY+Ccg+i4BBib3RtDj6InU2Cgu52NSWnhta
         Jk7Q==
X-Gm-Message-State: AC+VfDxvaXfxzufdzl1SOMQe5ke1twWGrMgXMAn6FmYfnK+Li4D4tZHd
        IBP1uRDGi3mk2PeqqO5/7kg=
X-Google-Smtp-Source: ACHHUZ6lCoe3QSvXEcmkL3etA0B5Y5jJ0ziNUHLpRsO/DWbR9IEhh7l0EM9rdeAPdLCPcbcv7Mgtlg==
X-Received: by 2002:a17:903:189:b0:1b5:1467:c4e8 with SMTP id z9-20020a170903018900b001b51467c4e8mr7663857plg.15.1687865893120;
        Tue, 27 Jun 2023 04:38:13 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e5c900b001b67a2896bdsm4280944plf.274.2023.06.27.04.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:38:12 -0700 (PDT)
From:   korantwork@gmail.com
To:     kw@linux.com, nirmal.patel@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        linux-pci@vger.kernel.org, Xinghui Li <korantli@tencent.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH] PCI: vmd: Clean up an indentation issue reported by Smatch
Date:   Tue, 27 Jun 2023 19:38:08 +0800
Message-Id: <20230627113808.269716-1-korantwork@gmail.com>
X-Mailer: git-send-email 2.39.3
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

From: Xinghui Li <korantli@tencent.com>

There is one inconsistent indenting warning:
"drivers/pci/controller/vmd.c:1058 vmd_resume()
warn: inconsistent indenting"

Fix it and remove the unnecessary if.

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Xinghui Li <korantli@tencent.com>
---
 drivers/pci/controller/vmd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 990630ec57c6..356bbeb548fe 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1055,10 +1055,7 @@ static int vmd_resume(struct device *dev)
 	struct vmd_dev *vmd = pci_get_drvdata(pdev);
 	int err, i;
 
-       if (vmd->irq_domain)
-               vmd_set_msi_remapping(vmd, true);
-       else
-               vmd_set_msi_remapping(vmd, false);
+	vmd_set_msi_remapping(vmd, !!vmd->irq_domain);
 
 	for (i = 0; i < vmd->msix_count; i++) {
 		err = devm_request_irq(dev, vmd->irqs[i].virq,
-- 
2.39.3

