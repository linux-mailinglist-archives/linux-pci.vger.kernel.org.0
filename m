Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D514DB452
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 16:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351255AbiCPPKf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 11:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356991AbiCPPKU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 11:10:20 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CFB66CAE
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 08:09:03 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 82B483F623
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 15:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647443341;
        bh=0TkaUHsdiaalOGmdOdYbrrLuoBcQ76N1kyxAw52pHyQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=S8/5VgUcxOPjAVlshLMznvrtZI2Kr0MQXCoCOTqpkY7JvlpktWLhFiD5BvSR0KUb0
         8VdZJPpR0ff7XaMRPH76ZqvfmbIjRtQyp4czWJlSPwWM+qMgtFlDSITm1vcrbGkaX8
         aBlHuO9HKAOMMPwRweiU7L7cVeJQlE8rZorYXS2n7JOTuZeiCaPz8fBVVf0pNffR6h
         h89M+bTcQkHDpWz8VqilNb0fZ72+aWeuJzk/MUP3cgfJKVqeXTFG8PvzbQvwegfR79
         FFtrfyLFoc9RMelkjPfYrUzhwLCo57pqbO5q53tf3VUsUZfUacXgKuSqRmEWzToOx2
         5BTnq4nzDyyhg==
Received: by mail-wm1-f70.google.com with SMTP id k41-20020a05600c1ca900b00389a2b983efso809000wms.4
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 08:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0TkaUHsdiaalOGmdOdYbrrLuoBcQ76N1kyxAw52pHyQ=;
        b=Y8igysISI+NRuftxnngisU981IXPStB1DMA7fGYyU8B2WRvAXO1ddo+sj8DSjw3Xbo
         JDivTZTMd7J4+gqNYyX0MkVSkSbqWpXJkEL5kI5Ei3x1xAG6pBJeTaYqWDmhTjur+BqV
         KV/nO2vjM7+WdC+/NkkJw+3LIVPmRBSrepupfPi93F7fTF9BaQHlbWUIbr19AnL7m5VR
         ZQS4t+7TvvtVcZNzx1LY13gB6dRc9hmhBmz7x9qPzCvmmylDqC5xZ7mRhWSlYLDHSgic
         EtoszYasPzpNblSpRedi3cnqMs6EEQAVZdJaG1c32986exUJueSiPiWHdUZ/dgCjU3an
         rKeA==
X-Gm-Message-State: AOAM532mu+Q91m6AAyWAcjvZFIqjMj3ekTMicNhru5CWwy2HTQmkxF1M
        1WmoF4sYAU4TS5TjfncOH9jsAhZ2isBO+bhijwRZXv6555Coa+bhnmEZZfsTjo2qB+je14UNevj
        HNQGtJIOiJds93zSr179chXwd/EzLlaONBT8EMA==
X-Received: by 2002:a5d:6442:0:b0:203:dff2:866c with SMTP id d2-20020a5d6442000000b00203dff2866cmr272615wrw.465.1647443340523;
        Wed, 16 Mar 2022 08:09:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnOg2aSuuzk/AN13SVnFGjUvC/KtTXL980cTeRfOeIj0D4M/X0M0ZN717fC4+xLvcCtZ4GNg==
X-Received: by 2002:a5d:6442:0:b0:203:dff2:866c with SMTP id d2-20020a5d6442000000b00203dff2866cmr272574wrw.465.1647443340291;
        Wed, 16 Mar 2022 08:09:00 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b001f04e9f215fsm1895105wrm.53.2022.03.16.08.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:08:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        stable@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 09/11] clk: imx: scu: Fix kfree() of static memory on setting driver_override
Date:   Wed, 16 Mar 2022 16:08:01 +0100
Message-Id: <20220316150803.421897-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
References: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The driver_override field from platform driver should not be initialized
from static memory (string literal) because the core later kfree() it,
for example when driver_override is set via sysfs.

Use dedicated helper to set driver_override properly.

Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells binding support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/imx/clk-scu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 083da31dc3ea..4b2268b7d0d0 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -683,7 +683,12 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
 		return ERR_PTR(ret);
 	}
 
-	pdev->driver_override = "imx-scu-clk";
+	ret = driver_set_override(&pdev->dev, &pdev->driver_override,
+				  "imx-scu-clk", strlen("imx-scu-clk"));
+	if (ret) {
+		platform_device_put(pdev);
+		return ERR_PTR(ret);
+	}
 
 	ret = imx_clk_scu_attach_pd(&pdev->dev, rsrc_id);
 	if (ret)
-- 
2.32.0

