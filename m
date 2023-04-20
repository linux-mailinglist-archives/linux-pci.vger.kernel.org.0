Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358FE6E8C8C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 10:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjDTIUF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 04:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjDTIUE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 04:20:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4CB35B1;
        Thu, 20 Apr 2023 01:20:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1a686260adcso9452195ad.0;
        Thu, 20 Apr 2023 01:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681978803; x=1684570803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=50LQK5tmVS4ocKInYwi3ul8CsPS2duQjgndHkjAqgs8=;
        b=b8UWrtSE8d2gqNUM2H1uHk0ortZx/sPCi0GIgOnwb707NJgWvxYj2zXg98MvjfsgvK
         Z56vAWe2BOIorML3bVHV0psPwQ23v+9blH9HWKN1FSXMvB3bf2Ix8TEiQvZM9QK1NgcH
         73L+WZyy1rHGXeD0B5048otp+o9agwOvnDjCPoLqK+Q/nnPuJDwAFRmFYSzre+miVdML
         l4q2MUTaDU3Zpm9W+l4znRjfq0AnFV/exlYutGBmLSNOGUfmIpemh72QtylzELDDrXQQ
         32O8Fh1Z5AoccqRP+cc/17OeWNzqExfvYKI0XPZNZqKeejI4ANXPiWt56+Q9jISSPshr
         DM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681978803; x=1684570803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50LQK5tmVS4ocKInYwi3ul8CsPS2duQjgndHkjAqgs8=;
        b=KXL7b9qc8WyFxKRNXllrETwpyZAtVKd5a8X18eXUEsBbjVx3GObzxYCzZUWSsuw5Xr
         dE4hOREvwuWVN7qNXndRHCEkN08mJdLZPlj22Lan/hW4UFWLJ66sqtu6Sw7VXaGqPorp
         Vq2RUCew/ROjZbyc5OYgxNJXnXlT+76hUrZGeyDUhyV6/RyvsBD0w2ud4iE3+AsltwsH
         hMxQUccvjfsb7TFklyuvmysR1fTwHTCJ8Ulm4IkoLeMRYvaZysMh9gl+hpGq4zbVOfv5
         QMoQjMQavl4JPDIQmKYBnVgA9I7lAxMRrNbMOV89/Zjrp9liSegMg3VvncyHGwaOAtDm
         MSnA==
X-Gm-Message-State: AAQBX9dSV8TMFBYUVVWCW/yOe7qZN+vtpVkZ1BBH6YyXpGDTgWENi8+P
        76Srqrm50A21yi9Zsil1G+c=
X-Google-Smtp-Source: AKy350aybx0ziA66zSViUCxz9E9+apBFLxepV9bFNMgfHksbNe6Qc8KN82NS86sC6uCUzn/e316oPQ==
X-Received: by 2002:a17:903:2442:b0:19f:188c:3e34 with SMTP id l2-20020a170903244200b0019f188c3e34mr808450pls.53.1681978802743;
        Thu, 20 Apr 2023 01:20:02 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902a5c500b001a4fecf79e4sm680471plq.49.2023.04.20.01.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 01:20:02 -0700 (PDT)
From:   korantwork@gmail.com
To:     helgaas@kernel.org, nirmal.patel@linux.intel.com,
        kbusch@kernel.org, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH] PCI: vmd: Fix two issues reported by Smatch
Date:   Thu, 20 Apr 2023 16:19:57 +0800
Message-Id: <20230420081957.1440423-1-korantwork@gmail.com>
X-Mailer: git-send-email 2.31.1
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

There is one uninitialized symbol error reported by smatch:
"drivers/pci/controller/vmd.c:931 vmd_enable_domain()
error: uninitialized symbol 'ret'."

Fix it by assigning ret with pci_reset_bus return.

And one inconsistent indenting warning:
"drivers/pci/controller/vmd.c:1058 vmd_resume()
warn: inconsistent indenting"

Fix it by formating its indenting.

Fixes: 0a584655ef89 ("PCI: vmd: Fix secondary bus reset for Intel bridges")
Fixes: d899aa668498 ("PCI: vmd: Disable MSI remapping after suspend")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Xinghui Li <korantli@tencent.com>
---
 drivers/pci/controller/vmd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 7e1fd959e00d..0a7c1fdfeec0 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -943,7 +943,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		if (!list_empty(&child->devices)) {
 			dev = list_first_entry(&child->devices,
 					       struct pci_dev, bus_list);
-			if (pci_reset_bus(dev))
+			ret = pci_reset_bus(dev);
+			if (ret)
 				pci_warn(dev, "can't reset device: %d\n", ret);
 
 			break;
@@ -1084,10 +1085,10 @@ static int vmd_resume(struct device *dev)
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

