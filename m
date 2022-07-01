Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0127E563773
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 18:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiGAQMF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 12:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGAQME (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 12:12:04 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A52315A;
        Fri,  1 Jul 2022 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656691923; x=1688227923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1UOqR7z0v60WglGmcoRLRqX/2H4WzWvDM22PGtcJloM=;
  b=c8qBHu0uaiqhRHjd2Y0ScoURv6Isvccf55vet7oGgXpKbUgXhkPVpybT
   fAboJ2BoVAtMENTwngUBTzKJ/2ez/dJ8wECbhmoA1MarOA3iCIqfTktcs
   Mge0032G3Yik9+WqVqIrByddHvoDa8Kpj1LvAOmAOMg+5jgQrLNFeBoKs
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 01 Jul 2022 09:12:03 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 01 Jul 2022 09:12:01 -0700
X-QCInternal: smtphost
Received: from hu-krichai-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.37])
  by ironmsg01-blr.qualcomm.com with ESMTP; 01 Jul 2022 21:41:40 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id C28C34244; Fri,  1 Jul 2022 21:41:40 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v2 0/3] PCI: qcom: sc7280: add missing aggre0, aggre1 and ddrs sf tbu clocks
Date:   Fri,  1 Jul 2022 21:41:36 +0530
Message-Id: <1656691899-21315-1-git-send-email-quic_krichai@quicinc.com>
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

Add missing aggre0, aggre1 and ddrs sf tbu clocks supports to PCIe node.

Without voting these clocks, PCIe link is going down when system is
suspended as these clocks can get turned off as no-one is voting for them.

Krishna chaitanya chundru (3):
  PCI: qcom: Add sc7280 aggre0, aggre1 and ddr sf tbu clocks in PCIe
    driver
  dt-bindings: pci: QCOM Add missing sc7280 aggre0, aggre1 clocks
  arm64: dts: qcom: sc7280: Add missing aggre0, aggre1 clocks

 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 6 ++++--
 arch/arm64/boot/dts/qcom/sc7280.dtsi                 | 4 ++++
 drivers/pci/controller/dwc/pcie-qcom.c               | 3 +++
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.7.4

