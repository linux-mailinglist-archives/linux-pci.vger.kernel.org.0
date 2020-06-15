Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255621FA270
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 23:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbgFOVGl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 17:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbgFOVGj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 17:06:39 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09859C08C5C2;
        Mon, 15 Jun 2020 14:06:39 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id x93so12565686ede.9;
        Mon, 15 Jun 2020 14:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bh2m7yBBFpphGSLnQ2t1Jsojy/ZnrrVmbVXPSEiIJns=;
        b=FNs0CRYtsNATVl4vdOR9CODEwIZN1Vx9CWZ5LlImi+2sYEsQTsqPd9RFmHQfhC+UCE
         qtR3JUHFUUaod2cYXXZfgCHzrpX8YekVGwIkJo+fWwKPJUUyrqZdgePpz0nqz9vLr/Ln
         3SKXSFAzF2yXbzld3jvYv2qELiOeE3CFEqHbfq2GQXxg+woR0qSD4id0CcnbtAkEP1iP
         g2LjPdgK9m/OMHDIM14qa12aBsAd+ar8rFJ8Vb1A1FPU5hrMFaLltDfT9YUfTpb/FdjT
         AcvZZVBXteHIr8xK8+NaKbsxAMVB5s7z3b5B9mB67RNx1lPhKcDAf/ooKS4B0Ik6eXa6
         LPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bh2m7yBBFpphGSLnQ2t1Jsojy/ZnrrVmbVXPSEiIJns=;
        b=DvPWZLo683JJ9GArA9J7iRpw2DT7g5KlHMUNzRtR8t9QMhqhNZo5Q/LNd+k9b+wt6I
         MZooq9D66XIPOivZ0uRJZsqFeG/KN12IlVrURTN7bCusH3JuFi4X/qqBhJJ6sxaO+n5L
         zCKPHVxA2uChmSW+8aLb73QfhNbZiM0woghwltWRnl+bQDgsyuGfjE52W1ugZd5juDvW
         SfjFbB65FVgg7DMU2VFf1eoDLcXTYztBVPYEGOkszwmKeByd5cyb3GpZ4RQgRtbUgDAH
         2JjxnnDS34K55szldhf/3ZgxK80gJgNrBt1/3p4xDU+/WMFSBNatzzQtcyC8z86DduyX
         cFfg==
X-Gm-Message-State: AOAM533eoCJMlN+8xZsQlyqIwL1OTX9K6GgHmTvBQtmUD+YHNUeefwPU
        1LilJnvAV4KzPsGOyWL9luk=
X-Google-Smtp-Source: ABdhPJxnkeg+c6UmESzTHYxMxZgx+zykL2kfHKyWujkTe2BOlg5tGkinMQAAdEEVKgCMK2Gc5eoCBA==
X-Received: by 2002:aa7:db51:: with SMTP id n17mr24696770edt.241.1592255197657;
        Mon, 15 Jun 2020 14:06:37 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-95-238-254-39.retail.telecomitalia.it. [95.238.254.39])
        by smtp.googlemail.com with ESMTPSA id d5sm9662226ejr.78.2020.06.15.14.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:06:37 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/12] dt-bindings: PCI: qcom: Add ipq8064 rev 2 variant
Date:   Mon, 15 Jun 2020 23:06:06 +0200
Message-Id: <20200615210608.21469-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200615210608.21469-1-ansuelsmth@gmail.com>
References: <20200615210608.21469-1-ansuelsmth@gmail.com>
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
2.27.0.rc0

