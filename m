Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBD21C0A0A
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 00:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgD3WHE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 18:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgD3WHC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 18:07:02 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444ABC035494;
        Thu, 30 Apr 2020 15:07:02 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id j20so5862341edj.0;
        Thu, 30 Apr 2020 15:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GGrIxEWXzwehaT8FT6nKgZsnpuz5Dtb8eh67YeQzlak=;
        b=dTiaPueOgnv9OLXqJI/ei6m0H+zbohSlQpPWh9F00TKRMLYRfVSL3OmhnS5opLb1gy
         wSmzPYcQURJuS1Izkj7IZNS3Ard3eB1+Zg48flNUz6BL1U9o0G4aZ6+j02CBbwC8R7Pt
         e5WxXfY9/I5mJdeRXCiFLlYVYUY5yZdLTw+9VkN/jYzTtAGjFOxJ2/+12WtkvmbbKlL4
         mVi24cTsQuD0jQia5yduBtzwHXecH/h9IQZO0C8jDl3L5bfDE1DkdJFFFuL5/Hb/f33c
         wSb8mEZzAt3GgAFe8r78K9ReFW7jEBdr06TKMTpAIvPSoIavMyzJcRuxwg1JRX2RraOl
         SEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GGrIxEWXzwehaT8FT6nKgZsnpuz5Dtb8eh67YeQzlak=;
        b=MYrAo9m5OMAcSJwEyZ5o//VD/Z/gnlD20X6vEOsXo1pyx7Jt0eKqqJCzRUQZ6RDuIp
         43ZkSRvKnvDKNGtHT9I6bOPt3gl40IHzOLN4xO7opFuufUOGJ46/je8CreSqJfClbaRv
         ccoyYrGeWZ/MomZvu4qJ7zEmguen7AcnQg0Px14YU8BRReRAgbR845jQoJsITuh9ULiY
         AUvrsvNu0zN5oPB2cOzFXUyio49vDLRmC4XC7rcEpDW4Yy2zZgMjVl45rKzIFvjN5qVy
         MgFLXGoU+gtV4kL8PSLHNgNTsbUyQcGC0OCFj/ZcQkMF5SlODzZS2cQ4VvBOWQfSO+Yl
         5D/A==
X-Gm-Message-State: AGi0PuZoDW2bM7/PwvjawVC7iLaefIIyvYRAvMjxjDmkKl1VcXu9M6z+
        6+ArYlPfROorO3n38d+Jxus=
X-Google-Smtp-Source: APiQypItUbxWgaRfatqnrsd/zwXmNIzwpBaKlQdKxT0/vx7UfHE9/vUciN0g9dr6vwxiR2AXULY1JA==
X-Received: by 2002:a50:874b:: with SMTP id 11mr1047142edv.384.1588284420954;
        Thu, 30 Apr 2020 15:07:00 -0700 (PDT)
Received: from Ansuel-XPS.localdomain ([79.37.253.240])
        by smtp.googlemail.com with ESMTPSA id t17sm54185edq.88.2020.04.30.15.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 15:07:00 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/11] devicetree: bindings: pci: add ipq8064 rev 2 variant to qcom,pcie
Date:   Fri,  1 May 2020 00:06:17 +0200
Message-Id: <20200430220619.3169-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200430220619.3169-1-ansuelsmth@gmail.com>
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document qcom,pcie-ipq8064-v2 needed to use different phy_tx0_term_offset.
In ipq8064 phy_tx0_term_offset is 7.
In ipq8064 v2 other SoC it's set to 0 by default.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 8cc5aea8a1da..c7102863d855 100644
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

