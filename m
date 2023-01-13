Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC91669EA9
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 17:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjAMQsL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 11:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjAMQrT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 11:47:19 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B715C7BCC6;
        Fri, 13 Jan 2023 08:45:03 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hw16so41768452ejc.10;
        Fri, 13 Jan 2023 08:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSzg8ro4VicBsd4Z6YxYop5coys1WHe/3Ul2C/JMj58=;
        b=iL3CqfCmDWIfqj8iaZc9rPyCV2YPsBuDEozU94ki+7XD4R0RT+Kh5o8qmygei5yHdF
         eLJA4LegAfQsvVHVrTFTSI8DfNaFwJT3nTx6RyBpAl4DuGeFJQN9KEC1s5fYvFu7ubRu
         QwLwMLNZpNJLghiKsV6J30uZD2lg0pW8rf0MXarJoMm6/gGkzwg0kZDU66cKzMVA1t87
         15hsoepyRlZSRAKxNezL4LOx4CTzU3BafwZ6ZxtMva8cNjoV3FKrWMNeaaqMuF6HvfCq
         +iT0ToavwrrgLj8tVZs+MUuPj1GUIY3bLmB+Wm67+coFFGWubGl29mKPG4WM312D8uds
         Gm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSzg8ro4VicBsd4Z6YxYop5coys1WHe/3Ul2C/JMj58=;
        b=pL9sgTbblHvYxfgAdh27xinVODkhnKS2EqnmUgc651e/PwaOHR8g/B7kxYmGDwW/ba
         KZTwn5soin/zieMuJFCzKbWAW5kgGGgYkw3eveCi/KMxqup3H+HNBazMLwggw1vRX5HE
         7BsThZ1hVFX5iFkeeoHyDCx4s4T/KhjJrT/oYpfH2nq6ns0Mco5QjalgxMgHe+mDud4q
         hwMdk7S1Z8Kqo2ghC2ISxrv845USKK3Jn9Emv2mHjxD6Yy3O6gZ+MqVQBiOBEMiNGX3r
         7LGLpK7TdLIigI8UGiW6mbd9l77GjLiZ3h9lycZm8ij7pTqea+GJyA4noBT0p272aodl
         O7Cw==
X-Gm-Message-State: AFqh2kpCfTyUHtaarvvCqfgyWtKb9NmrIzyuED0OXeN4gm7ZB3KI05Wo
        z74g94qlCjSr7jfMLz8vThmifWeKeCqlCw==
X-Google-Smtp-Source: AMrXdXsKNJd2j8ldjOFQzjdF0s0MkRvf9VWdq5hj7FDnJ97o4yTcaNfmrBKrsU+GlumFI5iEsecz4w==
X-Received: by 2002:a17:906:5dad:b0:7c0:dfba:54d3 with SMTP id n13-20020a1709065dad00b007c0dfba54d3mr11846198ejv.20.1673628303265;
        Fri, 13 Jan 2023 08:45:03 -0800 (PST)
Received: from fedora.. (dh207-97-147.xnet.hr. [88.207.97.147])
        by smtp.googlemail.com with ESMTPSA id sb25-20020a1709076d9900b007b2a58e31dasm8777831ejc.145.2023.01.13.08.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:45:02 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 9/9] arm64: dts: qcom: ipq8074: correct PCIe QMP PHY output clock names
Date:   Fri, 13 Jan 2023 17:44:49 +0100
Message-Id: <20230113164449.906002-9-robimarko@gmail.com>
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

Current PCIe QMP PHY output name were changed in ("arm64: dts: qcom: Fix
IPQ8074 PCIe PHY nodes") however it did not account for the fact that GCC
driver is relying on the old names to match them as they are being used as
the parent for the gcc_pcie0_pipe_clk and gcc_pcie1_pipe_clk.

This broke parenting as GCC could not find the parent clock, so fix it by
changing to the names that driver is expecting.

Fixes: 942bcd33ed45 ("arm64: dts: qcom: Fix IPQ8074 PCIe PHY nodes")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 74eecca4f9e3..c6cbeb66c0e7 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -257,7 +257,7 @@ pcie_phy0: phy@84200 {
 				#clock-cells = <0>;
 				clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
 				clock-names = "pipe0";
-				clock-output-names = "pcie_0_pipe_clk";
+				clock-output-names = "pcie20_phy0_pipe_clk";
 			};
 		};
 
@@ -285,7 +285,7 @@ pcie_phy1: phy@8e200 {
 				#clock-cells = <0>;
 				clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
 				clock-names = "pipe0";
-				clock-output-names = "pcie_1_pipe_clk";
+				clock-output-names = "pcie20_phy1_pipe_clk";
 			};
 		};
 
-- 
2.39.0

