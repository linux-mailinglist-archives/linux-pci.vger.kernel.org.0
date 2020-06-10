Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBE31F589C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 18:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbgFJQHh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 12:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbgFJQHe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 12:07:34 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6084C03E96F;
        Wed, 10 Jun 2020 09:07:33 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p20so3163769ejd.13;
        Wed, 10 Jun 2020 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZIcmPOVlQLoKdIP9dCKqwaemztdzBXHNcMiHg1REgA4=;
        b=XZId+kqzhEi16ADYn9UF8ygFXk5SH0ej/H5Fbz/qBQO7EKQTbrA31hza5a9uuwg1qY
         R2Ta2p/5jXwEbU8NKmjPt9XAKrE2lHnzuimLLZ4bN638YfuSZDLp3Y92yRgz6tEIeuaY
         pZ327mRywwATOIbKGxpqCfIrhum5FOsNIYUldzEi0FtN7SNXIya9uQu+GKikYJQjSCYZ
         2D8as6OSR1mL0nUBW4d0/sGaIwG/YLoVVP2Pvu0M16zqrOyuSRf9+aHUhcswiL0WTgb/
         MOFPQdUlfb2J+79XZpujH3pmbCG/Wyi2omUnbltMdXlKzTrhJVXkxnuCAreKpvz+TVem
         emKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZIcmPOVlQLoKdIP9dCKqwaemztdzBXHNcMiHg1REgA4=;
        b=lD1TPohP2RrnQuX3w6dL+pXXNVTYNPPn0DmIsEVJqIaOzqbvJrAETle5nw2lGZa/IG
         z50GCeK2J0GmKQa3R0LPqvhclfcFP+JSpn1ZxbV14dWl3O4lm01CxWm8fpbAlSuy3BBO
         JXPH8tN62S3fSfdVZ4gonaStX2J6pku8TUANNzyy96i8HBa1TWTl4rkh4W9YAOIE3xyx
         IRWySMYydNYwJgJDftQmTxhXouALDFCnowgR/yce5znkyKqrsPRX47LfFr+oSfkwdAds
         HhmgvJ/Xq/GHdfFedaKcwUykuvhcXKhcuf5R07rlXUkW5am9DhEg8nd3Sdy7hKgJJJx9
         c2Hw==
X-Gm-Message-State: AOAM531ndZ9XIJw3fkks4ZvCOUe5IQO/6J4EkvzdcYhRqba0DSU+RGcF
        /SMinsaoQ3sMz4oHg0CN+B8=
X-Google-Smtp-Source: ABdhPJz/z0uv04oFo6Ksal5X8QjDiPKT0GLx7HBWK77h+M6TKECl0WPlUJd694bF0JH9Cml7V8haAQ==
X-Received: by 2002:a17:906:e2d5:: with SMTP id gr21mr3905582ejb.219.1591805252537;
        Wed, 10 Jun 2020 09:07:32 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-35-249-242.retail.telecomitalia.it. [79.35.249.242])
        by smtp.googlemail.com with ESMTPSA id ce25sm56067edb.45.2020.06.10.09.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:07:31 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/12] dt-bindings: PCI: qcom: Add ipq8064 rev 2 variant
Date:   Wed, 10 Jun 2020 18:06:52 +0200
Message-Id: <20200610160655.27799-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610160655.27799-1-ansuelsmth@gmail.com>
References: <20200610160655.27799-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document qcom,pcie-ipq8064-v2 needed to use different phy_tx0_term_offset.
In ipq8064 phy_tx0_term_offset is 7. In ipq8064 v2 other SoC it's set to 0
by default.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 6efcef040741..02bc81bb8b2d 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -5,6 +5,7 @@
 	Value type: <stringlist>
 	Definition: Value should contain
 			- "qcom,pcie-ipq8064" for ipq8064
+			- "qcom,pcie-ipq8064-v2" for ipq8064 rev 2 or ipq8065
 			- "qcom,pcie-apq8064" for apq8064
 			- "qcom,pcie-apq8084" for apq8084
 			- "qcom,pcie-msm8996" for msm8996 or apq8096
-- 
2.25.1

