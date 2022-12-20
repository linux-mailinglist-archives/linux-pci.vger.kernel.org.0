Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639A0651A22
	for <lists+linux-pci@lfdr.de>; Tue, 20 Dec 2022 05:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLTE7n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 23:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiLTE7m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 23:59:42 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D9A10FF3;
        Mon, 19 Dec 2022 20:59:41 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id x2so11098068plb.13;
        Mon, 19 Dec 2022 20:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6MBdNuzRmYZGPUVsUdzTX10W9MvR0khMZxSOxixUkqw=;
        b=HNs/gmhK/nROiKYidMSIQkGMFrSYg/8+JDCCOulLFewzX3/GPHvWSSTudmdnj45py7
         Ouy+wbnzJ06kK8gAyYChDRLnEgA0xH1W2ATvPxu79Lgxuofc6VIF5KbGLe9fILTS5Gj0
         QiHmEIfzxCvMEZrLKwS7PByaVAg8oCUCRbl2Mu7x/7zLtpTkQQw98f/1C8KTvN2fMo1B
         oTMFqDTExAonnCmdE3dprWCT/XJkFIN/k2+vIlEmSZPuqMdjywskHMB+z/s1TE2xDaEa
         NkzDvyIjCt55As3YP51lO9VeiZH4Xm/6QP8AKMdBo3GDrKFGkIBO0h3yNEFyiowFuv37
         oQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MBdNuzRmYZGPUVsUdzTX10W9MvR0khMZxSOxixUkqw=;
        b=NPbs25V47cizg9bE18WnhuTjwVJlO3OWae6PRbuMvZV9FmRd2CFDsdvcXiEcrJUzrj
         UXXlLjgUX+MgevQM+cBdeh4t7zLYByKL2/3Z8vECD/Lx88aA1/OtT995qfUIRXjBgdih
         Dyjr5OgTiyWlUnfvLciGcygJbMvbxWaLtBvHVxoM//MCNMRJS+VOkd3vWuNnZBVAiwic
         cN21jG5ePqdxi2nVR1ivgGnjKAbmX+NkKIJKcnjrr7aJEUj04Kr3OU8+VGbww7ln2Tz1
         0QCwM9GScEsSkjpAlmbIyL3wUi3r2qZxj+uNwHFbV+rIeqcLovEJ2AE4EcDWp3nOao3z
         V8xA==
X-Gm-Message-State: ANoB5pmqNjA8qMblf7NO/aJJBl2LiyPaxFVDtVc4+gw2AYfazt01U8hZ
        0LYM8aJeh/M1iPdu3qJwWYE=
X-Google-Smtp-Source: AA0mqf4oU7fYSGubzlGlDgzKhrVdgspDyBfduwgSdU/Gn0CeiwGP+jjf6nBjq1XTsxca69Bbka6mdA==
X-Received: by 2002:a17:90b:fce:b0:219:3ad8:9190 with SMTP id gd14-20020a17090b0fce00b002193ad89190mr45881560pjb.23.1671512380743;
        Mon, 19 Dec 2022 20:59:40 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id 7-20020a631347000000b0047063eb4098sm7137784pgt.37.2022.12.19.20.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 20:59:40 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] PCI: endpoint: Fix potential double free in __pci_epc_create
Date:   Tue, 20 Dec 2022 08:59:29 +0400
Message-Id: <20221220045930.1106921-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When all references are dropped, callback function pci_epc_release()
for put_device() already call kfree(epc) to release memory.
Remove abundant kfree to fix double free.

Fixes: 7711cbb4862a ("PCI: endpoint: Fix WARN() when an endpoint driver is removed")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 2542196e8c3d..7dc640c99d9a 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -800,8 +800,6 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 
 put_dev:
 	put_device(&epc->dev);
-	kfree(epc);
-
 err_ret:
 	return ERR_PTR(ret);
 }
-- 
2.25.1

