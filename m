Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5255C669EA2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 17:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjAMQr6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 11:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjAMQrP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 11:47:15 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE4155841;
        Fri, 13 Jan 2023 08:45:01 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id tz12so53628598ejc.9;
        Fri, 13 Jan 2023 08:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LC/kSTJgwG4TkbkacIZ8rFmg4tsFLgqDy6gtWI/V4yY=;
        b=Wrl8oHmkr5sSArBIjiUthAfhuCoz2L5r4tKmWUGMldj/7uMp4vsuU6eK/UlmGpBK/Y
         BenKnhQQv8wlOkasyhEFWlmUXAvQzF0+4SbrnCnUwoU3h/YQd8rxDspeXn0wUQr4BGQW
         6W4Bys+GD/+g0fz0uYG8wLsUBFQKutcUrnlA9G6RVddEnn5OIXgsUBS+Io8VsPLmHvd4
         9ofUY61QFsHsel1iuz4JP643uXjA/QwQT/0RZJRVzVaxoNcdML2+WUJNr+xflqaYoVhI
         N/IQ2d66zIu/abrprU4ao3woqFaGfnw6iJLjdKjmxBHnBy01tUZG05tb6pbhNjBRLUM1
         jrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LC/kSTJgwG4TkbkacIZ8rFmg4tsFLgqDy6gtWI/V4yY=;
        b=yvUR7GaT7hP11Aw7LhlUxiP7HLyokPQBVFcK28DkWdNGfAZNfdDoB/GEPq6MSRzmnc
         t6n9r1KMv2w0mCodDk7VKKXy3gRWq5m0GcMk6leYoMUi+qjhDG0zz03joe0z49oXmapj
         pW2sDmCHVhWnj7UbTR1x1VcKnXRrkC9AmZ5XUn2GGDe/fNz8sMFVICijfOaoDgoMrBAp
         NQ0NZ5cQBal+XCxypmUByQvLqNL6RHaqRhtPqOd9rpJs8/Mp1HQ/dEEiGH8suf3Xlk7S
         LruvytY1Q/25gtz/dbagoUKVq3PYWrT6Yhu5LNOO1Rz1lIKXpHY25iBXOt9JQDEkq25P
         PAFQ==
X-Gm-Message-State: AFqh2kpbl285oCUaQ+YIIdjzs6rcy68T7qmZDsA1A39ryTQ9G0eh/ODv
        YNP10SoLe65vHshhCgP5e5g=
X-Google-Smtp-Source: AMrXdXuQSpZkZl9bzHb0x7edoK9XQNmZoFFromch8yZWsWCQugSyhu/PAS+85LaZTJzXiZYIiN0cQg==
X-Received: by 2002:a17:907:6f09:b0:7c1:37:6d5e with SMTP id sy9-20020a1709076f0900b007c100376d5emr50441585ejc.2.1673628300521;
        Fri, 13 Jan 2023 08:45:00 -0800 (PST)
Received: from fedora.. (dh207-97-147.xnet.hr. [88.207.97.147])
        by smtp.googlemail.com with ESMTPSA id sb25-20020a1709076d9900b007b2a58e31dasm8777831ejc.145.2023.01.13.08.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:45:00 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 7/9] PCI: qcom: Add support for IPQ8074 Gen3 port
Date:   Fri, 13 Jan 2023 17:44:47 +0100
Message-Id: <20230113164449.906002-7-robimarko@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113164449.906002-1-robimarko@gmail.com>
References: <20230113164449.906002-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IPQ8074 has one Gen2 and one Gen3 port, with Gen2 port already supported.
Add compatible for Gen3 port which uses the same controller as IPQ6018.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Capitalize subject to match previous history
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b9350d93b4ba..b69a406a2660 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1817,6 +1817,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
+	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
-- 
2.39.0

