Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD5450D1EF
	for <lists+linux-pci@lfdr.de>; Sun, 24 Apr 2022 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiDXNXm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Apr 2022 09:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbiDXNXl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Apr 2022 09:23:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADFFAE5B
        for <linux-pci@vger.kernel.org>; Sun, 24 Apr 2022 06:20:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id h3so17202860lfu.8
        for <linux-pci@vger.kernel.org>; Sun, 24 Apr 2022 06:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=13bAhAMjv2je6RMOj1RTuCmatzo9I4F5Zv7WwkP8+gk=;
        b=u8Fh+X/orbfnwbnBJeGYv39MuQFzNu5KAHWMwplOnLS5OegN1HK15Tn+HV3iUo8hzm
         0HUpMnDgdSFyA6FliVEH2sUSdI1rYfwRzEmYF7X3drv4wto/dZ2sdyGKqT020K77fUe0
         brR4YoLvVs0ovkuBcw/R4K0ZbxszzwpNxvBaU0LGyzC/OtIG3G9lDDlSmWmV+MPh5Sf+
         6qV6z/Q4V8JrKUSjQ+sRegQZF80azSHOEB72tzpKQ5Fjxpn6EU12dmIOJIlo7A1bMA+p
         yQyN25HZjkwnZwgeB0x6+ljlLlSBt9YXFbLqrgRcHxGtXi3Sq/xN8CAQFK/EHb34ZQwl
         h51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13bAhAMjv2je6RMOj1RTuCmatzo9I4F5Zv7WwkP8+gk=;
        b=yqu6af/L2baKgtaf974GETmX6lMQQBNRs2hQYMGAVmJNnJijUObpHdaq1lZmbpE8/j
         U0C39/jyLtn2mHEGv74vwX1UhZwHvlGElVHg1fHU1lKVWRQTLdw+x1EsFaLVxh4cxroL
         FcTRbFIkdVUBTd5Kiw18TDQVnQIwo9Dl65NB0mqHCVpPu+XRB6rcbt9V/1ZoeyPxxeVO
         ZgqXizsjgZpQ1QyTFzi6qA5pd3KjeNAgfgaWPaE3uqK7pQ3phfM2nvu5Q6qmy5KqdVKv
         xQSOlXt0fgRNmxOUuKXScAGFqWEi0vE5/OXR6nL9S4BUbNDY7F/RUR1Tjw1dq0wus0bB
         JKgg==
X-Gm-Message-State: AOAM53003siHTIJycb2tWjdsZH3aOzzfdT2G1gtSCyVB8bDPoiEOLuCG
        4Iuye6bL76/EemohWvjnp2+t8w==
X-Google-Smtp-Source: ABdhPJw3kncz5bBeFvGNHHjQHWuKAmMjfyyD4wJtaWuf72K9qaqlzxZROoUJU/oZxzv4EwKivcuIhg==
X-Received: by 2002:ac2:48ad:0:b0:472:4ef:d347 with SMTP id u13-20020ac248ad000000b0047204efd347mr892271lfg.422.1650806437307;
        Sun, 24 Apr 2022 06:20:37 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id l12-20020a056512332c00b0046d0e0e5b44sm1015877lfe.20.2022.04.24.06.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 06:20:36 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/8] dt-bindings: pci/qcom,pcie: resets are not defined for msm8996
Date:   Sun, 24 Apr 2022 16:20:28 +0300
Message-Id: <20220424132034.2235768-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424132034.2235768-1-dmitry.baryshkov@linaro.org>
References: <20220424132034.2235768-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On MSM8996/APQ8096 platforms the PCIe controller doesn't have any
resets. So move the requirement stance under the corresponding if
condition.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 496ba3baf6d2..3a1d0c751217 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -113,8 +113,6 @@ required:
   - interrupt-map
   - clocks
   - clock-names
-  - resets
-  - reset-names
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
@@ -502,6 +500,18 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      not:
+        properties:
+          compatibles:
+            contains:
+              enum:
+                - qcom,pcie-msm8996
+    then:
+      required:
+        - resets
+        - reset-names
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.1

