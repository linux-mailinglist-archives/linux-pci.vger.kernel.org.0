Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040BA62CD08
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 22:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbiKPVts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 16:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiKPVtW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 16:49:22 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECFC5985A;
        Wed, 16 Nov 2022 13:48:49 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id f18so394128ejz.5;
        Wed, 16 Nov 2022 13:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loIeYsbIfqk2P074OtBAWf7HGIfr867twQZf+5G/rew=;
        b=aPwVJ/UR6Vnv1p3AHkmaOpKOfKdqgLvC9LfsqTKgWaMIkZ+QNqK2KBxgGm1z/pJsaZ
         rAlxfgPSpk9MbN0DNg1hphCCUYuSISDN9PsuF3W3J3mpKzSBW8xGhyQvcCnpVb0C36cl
         zOKEDC8aQrmuxO2m9fdDj7GZsPUaoZVbgdgudCsSIdaZYOAXkCs6EQKv25mitRFa/bHc
         YMpTxzmbWRzTC+IGhDZzZCKDsVT7n4txBGFSe+pWRWMp+mEk5juxJLLUGI9YPZTiiBLH
         msD0waPDZjyjRGkPnJc4mQR3hnPPrd/cfEKGmypxd4NPezjsm5/a3LQ77t5YhB03uxOU
         WRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loIeYsbIfqk2P074OtBAWf7HGIfr867twQZf+5G/rew=;
        b=YE8dJ0DPKn1sueoX0xFXdGmb2HEKZLYmsJuZ+Th3yCzf8qdfjcG3p+5l6qTQy3W+vH
         f/Zl7evJah/EZGf3WxTeVaNX6S9RJVdJpleqjk6+SgHIp9+LKU2V9Ou6In4IPrWRiZMq
         yPRX0ddU6rRbDahWRNDfp61Xtuxx5dWEFdGY4VrVFexojq8ipgyDX/5yPWlqrdxDJFEP
         zX5cg3WxGiV7Dd5jw6rlICv4UoerX/5ICwTBBTzGCTZ5nYNw0uykugZsMYKwbtY9UN1G
         GXZUPZmmwUz6Ijw8HmSvVxoCsuE9O1nfrsG3Dqgk4Ip39MhAYWcPn90LeOjSAxety6GC
         EuWQ==
X-Gm-Message-State: ANoB5pmXPjGOr+h9RXc0VvnThgZtdjyPz7QghhAWi1pzHyJMdJjyDvze
        tdUZVwK+LfMpSs2u48CJ2qk=
X-Google-Smtp-Source: AA0mqf7yO//UJKXGudN4u0MPQe8SLmp39YTSF9gtSAzsDRwB/WN65OyI7e+EzGo6XowVfnaNtKOCew==
X-Received: by 2002:a17:906:1c85:b0:7ae:ca2f:171d with SMTP id g5-20020a1709061c8500b007aeca2f171dmr18160540ejh.353.1668635328326;
        Wed, 16 Nov 2022 13:48:48 -0800 (PST)
Received: from fedora.. (dh207-99-145.xnet.hr. [88.207.99.145])
        by smtp.googlemail.com with ESMTPSA id b14-20020aa7dc0e000000b00462e1d8e914sm7931341edu.68.2022.11.16.13.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:48:47 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 4/9] arm64: dts: qcom: ipq8074: set Gen2 PCIe pcie max-link-speed
Date:   Wed, 16 Nov 2022 22:48:36 +0100
Message-Id: <20221116214841.1116735-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116214841.1116735-1-robimarko@gmail.com>
References: <20221116214841.1116735-1-robimarko@gmail.com>
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
index b1decedbd080..585e5f0a139d 100644
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
2.38.1

