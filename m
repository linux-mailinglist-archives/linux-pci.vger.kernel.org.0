Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BF16B89CC
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 05:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjCNEqp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 00:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCNEqm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 00:46:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DA17FD76
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 21:46:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so3830450pjt.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 21:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678769200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvfvphEax9rDC9DBLoGwM3hS+dg6woN4JsLGnKLFC0E=;
        b=x9dbAT+U55WpGhZBn9XjA1sU8XP2hJCiwXGEZLHNnpcNKsQQPTcTifF4u8u1X6bFqx
         4H+rRYxH67YPKQvBdwJSwzg/g+5NDOkJPtcKZILIlOJ11CvgNpLM1x2QU5JuXopxYw1C
         pgFV4zkm8zwHAPpHNXgiN2Y/9kTxHj4tnsFw0KQR6Rbjx+NwrIO8tLg12MgtvXfMDE6o
         vxvcemOyZFeSWVXFnlLYIhQnP0myhuJRATOAxu+AbLZ8ykEwtkMKX6y5o4WTE8ZgSHqL
         LOwIz50CMcQlhpmJm+GsbsmPpemHO10ExwxYNaFwkIGyslc/caR/Ryt+1pM0lAGrauYN
         M8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678769200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvfvphEax9rDC9DBLoGwM3hS+dg6woN4JsLGnKLFC0E=;
        b=44V+gRiwJiUAwtIvIf4hUc21s07e4u0kn8CBdTpeYBDZlEzV7Dj1gr6jkL1Ut2vjcy
         1dQh+BSr7YESGyBz9WCe0UZOMoz3U0DlFslJ5pWnrGz44+a/B7LdsMT0OIS6Ns9uNosG
         I2ldBq0ZcaX7zaz8werldteBldzIvTD3o1QkirPZob3TBpSqyRJ02Z/l6FK2iIEBQPmK
         mc8haxmG9vBJSw5NRt/0EwKOu6Evt4vN59wwqOh7FZ4TNpEOaIKoKzPJKTo/aVxdBXfL
         5MLiFhC8s+l/MDn0wo619GVcQpyIzSrmRBgi6wKzlk5ewBBJ0pjlJHie51A+ka3UL1R/
         cGKw==
X-Gm-Message-State: AO0yUKXytv6r/ymAhM/Z4rCGFbq9Mp7Kd4NobrXJ5RRk+SbwlBUgfhjN
        YkF9/jtkUVabuAjmtB11HbLn
X-Google-Smtp-Source: AK7set9y+g8VwmRr3moBuKI6t0VF0OxEOdcecvS03t2Ok7N9OIe/DiiEm/zARK4lIC9n+3EhjESCVg==
X-Received: by 2002:a17:902:d512:b0:196:704e:2c9a with SMTP id b18-20020a170902d51200b00196704e2c9amr43011634plg.22.1678769199864;
        Mon, 13 Mar 2023 21:46:39 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id lh13-20020a170903290d00b0019c2b1c4ad4sm690125plb.6.2023.03.13.21.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 21:46:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/7] PCI: endpoint: Warn and return if EPC is started/stopped multiple times
Date:   Tue, 14 Mar 2023 10:16:18 +0530
Message-Id: <20230314044623.10254-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
References: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the EPC is started or stopped multiple times from configfs, just emit
a once time warning and return. There is no need to call the EPC start/stop
functions in those cases.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 4b8ac0ac84d5..62c8e09c59f4 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -178,6 +178,9 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
 	if (kstrtobool(page, &start) < 0)
 		return -EINVAL;
 
+	if (WARN_ON_ONCE(start == epc_group->start))
+		return 0;
+
 	if (!start) {
 		pci_epc_stop(epc);
 		epc_group->start = 0;
-- 
2.25.1

