Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7CA709A2C
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 16:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjESOmi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 10:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjESOme (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 10:42:34 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05AF1B3
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:42:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d1e96c082so1411795b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684507349; x=1687099349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvBjA4f+x+l+Skjyvt+2SPWzkMrr8PFd+q36DPYPr/I=;
        b=R4NGZh+kyEpvz3e7PT+yaclPEL2kwI6gZhTm/8lyVyZNTOfqJ6veRg6ojkWRuXi7TQ
         FwIicjNtl+WxTGJuFHm3mbyn9ypf9cE1UyeRCq+vlSATWAjK7DC9cl6f0nAUMbTcQN6p
         lkPpMDwarJjsOpgRWTZu7YQV+rYRVHqTUXDBWZ/8y4S893bnSBSkmRW9EH51s8/ii3Io
         /nYG1utOZnxOJGbxg6A2+Oj/fOrGhe7/X6Ew0HmxsdYlTPLSPp8IaFqcInjxt8IRLClg
         bB/sLgK2eO3VqwX71zZTLPg9KuptD/j6XLxPmx2oQMyhpkf0IkEGBAFS3l7802WLg2qg
         M5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507349; x=1687099349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvBjA4f+x+l+Skjyvt+2SPWzkMrr8PFd+q36DPYPr/I=;
        b=HhzqGZJPwy1Tg/lbm1K6SE/dnPAtHS7NkgA/A7Y1t5O2e+WFiAdZoZkLsgdnWYPju2
         fSeXSCr+RpZiccd4R3VEUjBN6lL7ECouBiJn3o8EKVAmIOGV+Ck9dpS/v93D3qF0jXZT
         flzje26hjAR0XITZ6AkJyxGfr5egNtdlxlGSxXtvW7arCsqf3Co72ymjBNPSqUaVl8pb
         tTAEVvX4mN9+TFHYRjAiz7bOhLZzDUVScmaNWkHhwEsbFEMSoyQ1Vh50JDtOxyv3I+jG
         HCZ3XOoaa2XPMwczjJdIh/JmfxqraPRteo7rkQTvMpcV4psQc+mZbs/hdQee2p1t+oNM
         /R9A==
X-Gm-Message-State: AC+VfDw6pGz1SxafbtwL+PzgiU8cFtiDmK3zUZrEw0ZeqgRI9viiriSe
        cdgjTycIn58RlpCziy7SS5pz
X-Google-Smtp-Source: ACHHUZ48kti1zsiseNnGSruNYLUnZDHxc/T9r5O44EbXj1OoUN2f3Sb4Ok53RHmSI88hVbapILFroA==
X-Received: by 2002:a05:6a00:1783:b0:645:ac97:5295 with SMTP id s3-20020a056a00178300b00645ac975295mr3204372pfg.9.1684507349113;
        Fri, 19 May 2023 07:42:29 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.13])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7808b000000b005d22639b577sm3089611pff.165.2023.05.19.07.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:42:28 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 2/7] PCI: endpoint: Warn and return if EPC is started/stopped multiple times
Date:   Fri, 19 May 2023 20:12:10 +0530
Message-Id: <20230519144215.25167-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
References: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the EPC is started or stopped multiple times from configfs, just emit
a once time warning and return. There is no need to call the EPC start/stop
functions in those cases.

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
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

