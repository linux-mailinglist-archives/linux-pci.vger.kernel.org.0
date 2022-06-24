Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90209559650
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 11:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiFXJUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 05:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiFXJUO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 05:20:14 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6A762C1F;
        Fri, 24 Jun 2022 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656062413; x=1687598413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Q1svlYeyyqQq3MRGkaUqc3mqMaV5+/q6SjdnIQUN0ks=;
  b=NVdrf/5DgZk+dJMvSEf01c34ZfNw32GZby6kT1tPy+akAfm5TBpjGp2S
   pKGgX0/TAr284L7+9Wv0XpTV8odpUB201rODC/zcq21T/FwmApF+gUO6K
   k2A9buV7n3JYRZXSK0sW95tzXPxvgqV2N9tbLNJlzyAmNP3hB8wE8/x1u
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 24 Jun 2022 02:20:13 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 24 Jun 2022 02:20:11 -0700
X-QCInternal: smtphost
Received: from hu-krichai-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.37])
  by ironmsg01-blr.qualcomm.com with ESMTP; 24 Jun 2022 14:49:55 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id DB4383E39; Fri, 24 Jun 2022 14:49:54 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v1 2/3] dt-bindings: pci: QCOM sc7280 add missing clocks.
Date:   Fri, 24 Jun 2022 14:49:50 +0530
Message-Id: <1656062391-14567-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656062391-14567-1-git-send-email-quic_krichai@quicinc.com>
References: <1656062391-14567-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing clocks.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 0b69b12..313b981 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -438,6 +438,8 @@ allOf:
             - const: slave_q2a # Slave Q2A clock
             - const: tbu # PCIe TBU clock
             - const: ddrss_sf_tbu # PCIe SF TBU clock
+            - const: aggre0 # Aggre NoC PCIE CENTER SF AXI clock
+            - const: aggre1 # Aggre NoC PCIe1 AXI clock
         resets:
           maxItems: 1
         reset-names:
-- 
2.7.4

