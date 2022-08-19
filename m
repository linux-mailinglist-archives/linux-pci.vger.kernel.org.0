Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21F75992F2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 04:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243004AbiHSCI2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 22:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbiHSCI1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 22:08:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E95952DE4
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 19:08:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso3539880pjj.4
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 19:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1s5fDBbPwDIfimCminJ//BlOKw42ZvouJWmPQDDpYhg=;
        b=SwMaUxyMweLmAnDFAdcsk8mb09Y6oGUSn+GrMbC/nXJqsp8lzlwtYBT/UeJXxN6FOr
         7bsHRqpSW00Zq1xKGZrxL4rC63LLyE/sHXin/Ev7RV9VoMKLWKaaYTKOoMSIboSvBBrD
         xreevRioe0kzyDukI+0pWWkq02VljatERUQ/vfrB80hAHwgG8o/Q1FI8ORoNyl8nu+Wv
         FljKbsMoRnsF68HsHdJrxWt2MaHGNqN1Kn+mDICFIUmGQusPLYC/ZqMO50UtN51zKLSR
         nYlq4Ep5NWDs0laD7XGUexnqmcB1T/GBPIvXvtKjugL3dmpiFswfa4zsC8oXVQVfslg8
         Z7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1s5fDBbPwDIfimCminJ//BlOKw42ZvouJWmPQDDpYhg=;
        b=lqV29wCtpgUIaVleIwCZSD65+6vlCIbc/AdZZLUEkZHtN1ZFRxijKO//J8dZolM1Rp
         TS6nEoczm7oUDl67yXhC9tLoieWGvrWz27h2DXvvXZimgeJvyReeFPzPinoRmxFlJaHY
         W/U97wH8e/Q3uN9+MmPRzJDEVQa9jiGYIrY6pAU979YNA1s+tSg+lDX3e2rbV/FxSAIF
         s9MJI2zX8TJ45xm+K/vCtN82dxN2ANAnTcNXXtETWUYqpwjA9OlY4/6nEPfUInZa1kJ3
         3TECbzL301b75/aO7THVGktoSkJ/J5ka0PPOhqxpNQLUvirKLkhEMYKOPgvNVYfvxSrp
         bS2Q==
X-Gm-Message-State: ACgBeo2NFDI45335+uY8B2cVvwl8j7gJWh0QdcUNlY3/LWJ/V6MLv7FK
        /NqY/favOMFAfMVl+9l9/ado
X-Google-Smtp-Source: AA6agR5cqavn3AxwZPFY+VqyxUtyzyvTjwT2H07i2jN8lUugalH0jnvrBxHmAvQXsi0rsx4jL8m1JQ==
X-Received: by 2002:a17:90b:4d88:b0:1f3:34aa:9167 with SMTP id oj8-20020a17090b4d8800b001f334aa9167mr5807425pjb.133.1660874905533;
        Thu, 18 Aug 2022 19:08:25 -0700 (PDT)
Received: from localhost.localdomain ([117.193.212.74])
        by smtp.gmail.com with ESMTPSA id v1-20020a622f01000000b0052d98fbf8f3sm2304252pfv.56.2022.08.18.19.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 19:08:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bhelgaas@google.com, lpieralisi@kernel.org, kishon@ti.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] MAINTAINERS: Add myself as the reviewer for PCI Endpoint Subsystem
Date:   Fri, 19 Aug 2022 07:38:17 +0530
Message-Id: <20220819020817.197844-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I've been reviewing the patches related to PCI Endpoint Subsystem for
some time. So I'd like to add myself as the reviewer to get immediate
attention to the patches.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 21081f72776d..58a163c2e5dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15682,6 +15682,7 @@ PCI ENDPOINT SUBSYSTEM
 M:	Kishon Vijay Abraham I <kishon@ti.com>
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 R:	Krzysztof Wilczyński <kw@linux.com>
+R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-pci/list/
-- 
2.25.1

