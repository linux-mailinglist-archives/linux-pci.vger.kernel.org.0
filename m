Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433F0599DCB
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 16:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349650AbiHSOur (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 10:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349646AbiHSOuq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 10:50:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2613EEF05
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 07:50:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pm17so4842495pjb.3
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XInyNyoE5i7OhwCUXB49kMUFySGOdTQm0Z6ZisLc1Ak=;
        b=AiicFUozRBRJgx3EpLjmOHxJhWiUomCIY+PJWCn2zF7fAJwBHOAXxq09QXRY6fE2mU
         E5SvbACXNdUTI64ZSg5Iqtv3KHSenqvEMq5FMoHHc8JlyqZZREBNwnE1EqjlSYq2Xxz9
         cTdxA++GVnsxqSw7mhJ2WM03g7kMmH1P8ooHM+54WU9UDryXHPdb+NjZQaitwBimBJyY
         sMp2kUNSa1unMZ4TTC5CVVoo02tM0azkMeEnr+mApeCuTzf9/XTai+jpVhfl37BxQXr3
         vAmME1yZhBfH3gqgR2zijWT19yWHmV7FEpx8QSd10hEw7A90p3KkHANHL9pvqty3oyQY
         zqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XInyNyoE5i7OhwCUXB49kMUFySGOdTQm0Z6ZisLc1Ak=;
        b=ehqrjq2X5HpgRKmsx/3qE1lyyc79q7spYVSXX3fWrvPaChy74ql7ZVu+I/NQNn03vM
         sSHxCBUCzr7RRAkSjZ5K2GIM9W/IdMcnuF6R+rcL3+9zrJPh72XS69KPaqyRjFgkRh23
         5AkosmyQ4sumt34EWNwqEiRbxLfZyodG4Qh4e3z/YGpUoFrLLc5uhc17oh/CbVZqnVPO
         Z+xK5e21L3lb98EvEECjoRsKtSraGgr5u/vAEITkVi3OzCf9uTC1o8wExui6mBSMY/oG
         uSNOzvl1UkI2DPNTmxVnYBXdHWiQSJnjx7vWveuDCrQTPFWizUzANgAOe79Ojj4400XY
         glWA==
X-Gm-Message-State: ACgBeo36u0scPMFKzGzVE6CWOg+ZUJMHW0M0x5m2u/9Zxb+sZrUCADjr
        sZ8vQoE6aBQf5rh5rKHD9haY
X-Google-Smtp-Source: AA6agR4ff8A9bwFpTHkfw+a+dW3aETF6Yw+WGS7v0D0J/1vNaUKBj6e9GJaazVuNhb3NxoXfhSt11A==
X-Received: by 2002:a17:902:b607:b0:170:c7fc:388a with SMTP id b7-20020a170902b60700b00170c7fc388amr7684061pls.29.1660920645412;
        Fri, 19 Aug 2022 07:50:45 -0700 (PDT)
Received: from localhost.localdomain ([117.217.188.127])
        by smtp.gmail.com with ESMTPSA id x24-20020a17090a789800b001f312e7665asm3268380pjk.47.2022.08.19.07.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:50:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, gregkh@linuxfoundation.org, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mie@igel.co.jp, kw@linux.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/5] tools: PCI: Fix memory leak
Date:   Fri, 19 Aug 2022 20:20:17 +0530
Message-Id: <20220819145018.35732-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
References: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Memory allocated for "test" needs to be freed at the end of the main().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 tools/pci/pcitest.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index a4e5b17cc3b5..a416a66802f3 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -157,7 +157,7 @@ static int run_test(struct pci_test *test)
 
 int main(int argc, char **argv)
 {
-	int c;
+	int c, ret;
 	struct pci_test *test;
 
 	test = calloc(1, sizeof(*test));
@@ -249,5 +249,8 @@ int main(int argc, char **argv)
 		return -EINVAL;
 	}
 
-	return run_test(test);
+	ret = run_test(test);
+	free(test);
+
+	return ret;
 }
-- 
2.25.1

