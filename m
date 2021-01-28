Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85AF307D21
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 18:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhA1Ryw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 12:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhA1RyN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 12:54:13 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DC7C061354
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2021 09:52:40 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id a12so8778550lfb.1
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2021 09:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YhHWk0hpFtEKwreT9I82hjXdPuDIowSRXuqfI7wusBw=;
        b=R9YeBg0DyiIE6kJi5OD9vsC7mHNBKj6kk1eTAc5k+ISlrHTzWAW7L+3rGlBeSJ0wX+
         aLIU2JTcNa7f/gU1Z94ZetMvrp1C5f+WiaP7yjejfeMwdg86tjMc8go0VwR7UnIl7mvl
         hCK860uG9MqhEI/MOj1Hy58cWxTE2DelBPtkH0QEHV2qfuLrAIQi/Q+B7cHXc0ctqYuK
         yzruaO5j7WuAIqxJo8kfGNupvaV6G7N4sebSgIbH5Tdb1E8xWsCVcDvdimdzqx84hNwv
         +F/6oW36Y6CJ+rjkZkCICnJwRvn+ATN+WgjQN3cZ6DD/dGNhsTT/zelpkldhbNGw2zUP
         PU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YhHWk0hpFtEKwreT9I82hjXdPuDIowSRXuqfI7wusBw=;
        b=YKRb4ZHwYrM6tFSpZ/eEcBsk+0Vb54ZZ6PMtjIQzuCv3M6DV2f1ctFrxP3yP/0Txib
         UV9DIAvfYiBSuwfVstKIzX9wghY8pG31A4XGIXcuOiccThBjwWlVmQ5TRtnJyj/tCxvk
         nSfMeBtjrLfJY47gutdRBP9Q+qE7BUPJBEgnaoVyKa7CUYRfh8JA/+serkPfktqUkF6I
         wQ/XEREoPSecJchr4JkOqhHEMzwqVVGLTbNrQ2gD43vjgceZkYEKtKKnfG7lJkY8nBld
         1SnGa5IItuGtE8SRlsVN2R+8N77xgBBC3pV6V1pzvMrupT5gSUei1UgdsP0Xj/9oLsnh
         jhpg==
X-Gm-Message-State: AOAM532qkFu1vJ5cxS4hNFmt/aJEu8GYi6TIKYvKf8KjDpr+tFXIO0rK
        BIamuyCGLZuQOJFye7vQFqLXZQ==
X-Google-Smtp-Source: ABdhPJxXq6Enj6CntWrJrW6xnC0/gzPkKOVwIt8Y/oZlEjb+wXCD0OMGAazEx9jh8prgW3NhgdSEuA==
X-Received: by 2002:ac2:44db:: with SMTP id d27mr118897lfm.248.1611856358975;
        Thu, 28 Jan 2021 09:52:38 -0800 (PST)
Received: from eriador.lan ([94.25.229.83])
        by smtp.gmail.com with ESMTPSA id w10sm2216119ljj.37.2021.01.28.09.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 09:52:38 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 4/5] arm64: dtb: qcom: qrb5165-rb5: add bridge@0,0 to power up qca6391 chip
Date:   Thu, 28 Jan 2021 20:52:24 +0300
Message-Id: <20210128175225.3102958-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128175225.3102958-1-dmitry.baryshkov@linaro.org>
References: <20210128175225.3102958-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If QCA6391 chip (connected to PCIe0) is not powered at the PCIe probe
time, PCIe0 bus probe will timeout and the device will not be detected.
So use qca6391 as pcie0's bridge power-domain.  This allows us to make
sure that QCA6391 chip is powered on before PCIe0 probe happens.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 2b0c1cc9333b..b39a9729395f 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -581,6 +581,18 @@ &pcie0 {
 	wake-gpio = <&tlmm 81 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie0_default_state>;
+
+	bridge@0,0 {
+		compatible = "pci17cb,010b";
+                reg = <0 0 0 0 0>;
+
+                #address-cells = <3>;
+                #size-cells = <2>;
+                #interrupt-cells = <1>;
+
+		/* Power on QCA639x chip sitting behind this bridge. */
+		power-domains = <&qca6391>;
+	};
 };
 
 &pcie0_phy {
-- 
2.29.2

