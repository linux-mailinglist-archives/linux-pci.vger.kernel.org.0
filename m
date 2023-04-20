Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925CF6E8E6E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 11:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjDTJpY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 05:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjDTJo4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 05:44:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C14A1BE;
        Thu, 20 Apr 2023 02:43:42 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-63b509fe13eso658017b3a.1;
        Thu, 20 Apr 2023 02:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681983822; x=1684575822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IT835FHNi4eC4qAmIN/OZRmU8iTSk2BDGuwcGxroAxI=;
        b=KYK+ePHNSqDAiv3omCR7zst85XghhmVd3WfUQmuLquIfIrv7OuXytSfqYxfT3MBYiC
         SxWiDkM+QZ1vRqv90s/96x/79QLaxahLgtAnubH+oOs1DlU6ZaMOOfbT4NIBlgZdWwV5
         X6Q7GNNmYx5FU3uTxTHXECOHFAD+I2XN601tLvwc9BtGFVfCWyOItivAz457E66Bk/0/
         4JW9dP6BAap/XPhwD7h4LvHGFUoMmM+X1KrJcva5x7GZTs2m572il1M8jRAv8nwN0l3c
         NiC+o9mVNgID7RMqXI5C253jmAXMqPENI5TpASNwdY/fGe43RMeRQnUyjA9nzRDCk9nM
         w+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681983822; x=1684575822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IT835FHNi4eC4qAmIN/OZRmU8iTSk2BDGuwcGxroAxI=;
        b=PxIXD2Yi2oV9mxEAVX1B8A4qPnSk/9DJldBr/QXcDmBZIAjzYdTv851uN3VjG857m8
         TmYa16WY//fFvd7TZzYBeqPG0i2shJ8584VcfxOAV0Mq35c7zJ9773zCuXJUWIGoFBRg
         WidePaTk3W8cuSdGzszb3XwKjQdq6skHlrdhHLTu6Ng8cJXrFhfJkNlvHARtDiiXFf3c
         wCBf4cBZ9aL8jqfpnsJ6QYfLmu+bgtv7orgrRycvhksCB4mIsxNXHHwVf8vw4FyfsCQh
         5jCrHcj0A3uXmFCiszv1/KnDCbHJq2b7E1B7MvWJvQKOKY3OOVOT5nX2Sh1Gfl5XPwm7
         bIHg==
X-Gm-Message-State: AAQBX9emqov8oS55RbWzaThILn92xykZu3byg1H9Tuk4Woz5rpodb2dt
        dsjtZ9ozdEN8crC67dhmtCI=
X-Google-Smtp-Source: AKy350bghrZeQFXX0RutRlIwOIMLB3eyLNMwB+Kk4fzMrBqoeQsgB3djakmCSPppuLX0Qoa/O2WQIw==
X-Received: by 2002:a05:6a00:1749:b0:63d:6228:6888 with SMTP id j9-20020a056a00174900b0063d62286888mr883906pfc.3.1681983821659;
        Thu, 20 Apr 2023 02:43:41 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id t1-20020a62d141000000b0063b8ce0e860sm874336pfl.21.2023.04.20.02.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 02:43:41 -0700 (PDT)
From:   korantwork@gmail.com
To:     dlemoal@kernel.org, helgaas@kernel.org,
        nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v2 2/2] PCI: vmd: Clean up one inconsistent indenting warn reported by Smatch
Date:   Thu, 20 Apr 2023 17:43:32 +0800
Message-Id: <20230420094332.1507900-3-korantwork@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230420094332.1507900-1-korantwork@gmail.com>
References: <20230420094332.1507900-1-korantwork@gmail.com>
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

Fix it by formating its indenting.

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Xinghui Li <korantli@tencent.com>
---
 drivers/pci/controller/vmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 1a36e9a52b93..1b68fa606bff 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1056,10 +1056,10 @@ static int vmd_resume(struct device *dev)
 	struct vmd_dev *vmd = pci_get_drvdata(pdev);
 	int err, i;
 
-       if (vmd->irq_domain)
-               vmd_set_msi_remapping(vmd, true);
-       else
-               vmd_set_msi_remapping(vmd, false);
+	if (vmd->irq_domain)
+		vmd_set_msi_remapping(vmd, true);
+	else
+		vmd_set_msi_remapping(vmd, false);
 
 	for (i = 0; i < vmd->msix_count; i++) {
 		err = devm_request_irq(dev, vmd->irqs[i].virq,
-- 
2.31.1

