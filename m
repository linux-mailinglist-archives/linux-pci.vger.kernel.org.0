Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55324669E93
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 17:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjAMQrc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 11:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjAMQrI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 11:47:08 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C374D4AB;
        Fri, 13 Jan 2023 08:44:57 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so53646862ejc.4;
        Fri, 13 Jan 2023 08:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Myq7mHdqsUE+VFev1hT0NgPEUBx3bz87gHy9ti3y5O0=;
        b=CSvoS7chzkXNLmc/XORHl9BROENcpS3fJZq2ie/HnCE1o88cqobm9BFVk1wSqQStRI
         RKXHfAySsNC9u2SCfUg1B6Oy9d3034AQ8e1nD5A8h6/kF7DVgibMchQgh5+w3WDkPzhu
         Nb9POAtxPwPqzqIXaaRw9SBUaQlCz5n/LZclFK3YfZocECFYkFnJxZ9sb+OP1YTOUFnC
         T/c14TJeU8YVznPhy2+Fps9Iq/CvPD2MuLwC+rp6MgtNAAL4znLx8qb58Ht3y7lMoWGG
         Ej+TwprS85rbDpSYAV4Q5KjYtlQVJjjjEKPzMUT9g7/4b70wtpFLE0sLPxY3xT/MbCk8
         9wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Myq7mHdqsUE+VFev1hT0NgPEUBx3bz87gHy9ti3y5O0=;
        b=w2U8QVIjtDHAoPR0qjTjr14BZuyBTkRnnZ2gcfr6o7uhTIRcMZ0Hjsv3fHnJlln1vB
         kL5OkwYC2f71RdhAB2WWNKC0aCBeeOElHUeakIUhDBn3xRFDwsGj0eyDJxqPjMzj9Ym0
         ry2Z/O1erADjjUJpRke61C+JWe1W+9jGW2pQgU2YoQn33q+SZ7OfYwaLTjW5Tty+lYYt
         LFS7BCQ4arjpaVTb7vXRgmJn/jk8JYBmhFMcnCmaK+DLeXtVl9HCMlXTN4n0l8w2glnt
         TZw2DoEkF7c0gCvcRHS4nU3rsAH7Z/0KAIKATui7RL0e0mqXDinHz+8PIIx0WFY5v3T8
         vGLg==
X-Gm-Message-State: AFqh2kql6KciP18kkiOTepWR3xGmjB0YnkvjpKYjikOVo4b2kUXhI+lX
        1oukEtWGM7hze8WmE/hQF8E=
X-Google-Smtp-Source: AMrXdXsX/QFL1vjuOlzwdBt9QbrHSmDOuc2kBWTMwdrq6QZ5HvDsgWHK8Utz7kGARCRQ/37C1lUXoQ==
X-Received: by 2002:a17:906:370a:b0:7c0:a350:9d29 with SMTP id d10-20020a170906370a00b007c0a3509d29mr66478731ejc.18.1673628296317;
        Fri, 13 Jan 2023 08:44:56 -0800 (PST)
Received: from fedora.. (dh207-97-147.xnet.hr. [88.207.97.147])
        by smtp.googlemail.com with ESMTPSA id sb25-20020a1709076d9900b007b2a58e31dasm8777831ejc.145.2023.01.13.08.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:44:55 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 4/9] arm64: dts: qcom: ipq8074: set Gen2 PCIe pcie max-link-speed
Date:   Fri, 13 Jan 2023 17:44:44 +0100
Message-Id: <20230113164449.906002-4-robimarko@gmail.com>
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

Add the generic 'max-link-speed' property to describe the Gen2 PCIe link
generation limit.
This allows the generic DWC code to configure the link speed correctly.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 06e1da176334..5ef4383ab18b 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -801,6 +801,7 @@ pcie1: pci@10000000 {
 			linux,pci-domain = <1>;
 			bus-range = <0x00 0xff>;
 			num-lanes = <1>;
+			max-link-speed = <2>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-- 
2.39.0

