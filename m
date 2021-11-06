Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD61446F92
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhKFR5v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbhKFR5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:57:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5F5C061570;
        Sat,  6 Nov 2021 10:55:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o8so44667318edc.3;
        Sat, 06 Nov 2021 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/ckoETcz+yDddWrcBDGrX7LHLDThJbVjbuAhn7hXgw=;
        b=SFtPHmKQmzg2xNySjUeW7uj9FY8djQRU2IHJpRV7StO1e9KqYwy82fMh0vANf8XyHC
         Smply+kcEW/e8/5pUKaXdPJ1C1E6iEsaPNN2K6MIrC06zZVSJ1DMj/ZumieiyAeiOZ8G
         dDQP/Pif9btC8RxWLFFe6JMdx/JgrJTPe83BBoq5FrC9w0Z2xe63FN/ZeeA8pO2VKTVY
         PEebt7T0WoWUKQuiOdZbAuGsBviXkBFrkRLxiNa7xdqsxnAYezadpohEL9hmRUs16Zkk
         AyhanJ41xMEr1y3c0CexvuKpvKnetnp+GJnOupIoDtNTa42Vb/Na5e89POfM0GD+8gaG
         +dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/ckoETcz+yDddWrcBDGrX7LHLDThJbVjbuAhn7hXgw=;
        b=f2+ftb6KeK2t3wgEhd6L+foFZXGTdLf+V501GhkeXB2q78hcUIyYV1u04DCbqb5nT6
         XhtoyVqfhNLdMVB2YGaQiPhY52Gzgci0qxJtKxXc3W5+Dnda7dQ2n9ATljNaNUdB1+gJ
         rCXx3orsneCLxN14jwDtegWRVyVVDLfRG8p5kYmIeDceijzFm9yM6ZtuvF6rgBLYymHr
         ev6ZSOnPtsd6tKekyuAVO53DX1q4pbJKALrpETs6uXeGIgxFWn16zU4OI2I4COFKtgsc
         95yhahR5wCDZIjhm42V3Amfy69Anojr2c5SpghpJM1d6tRMYPGpoPIfVivXB3kvOuj0n
         dxvg==
X-Gm-Message-State: AOAM532M8Ixc+wxqVsxwgTL7qokicOPNYCld/aFqkufa707pGjmL88F6
        WHVN+IVr1VFodJ+VCHnW06M=
X-Google-Smtp-Source: ABdhPJy64kPU3OqrrSSQGHxhbjsgy2XMgPPRzMctH5uVasLD2sxUJIHcPnbnq+KRzoYE9o48nf3vTA==
X-Received: by 2002:a05:6402:3488:: with SMTP id v8mr63961116edc.170.1636221307512;
        Sat, 06 Nov 2021 10:55:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id 25sm6542848edw.19.2021.11.06.10.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:55:07 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 1/5] PCI: Handle NULL value inside pci_upstream_bridge()
Date:   Sat,  6 Nov 2021 18:54:59 +0100
Message-Id: <20211106175503.27178-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211106175503.27178-1-refactormyself@gmail.com>
References: <20211106175503.27178-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Return NULL if a NULL pointer is passed into pci_upstream_bridge().

Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 include/linux/pci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..b087e0b9814e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -695,6 +695,9 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
 
 static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 {
+	if (!dev)
+		return NULL;
+
 	dev = pci_physfn(dev);
 	if (pci_is_root_bus(dev->bus))
 		return NULL;
-- 
2.20.1

