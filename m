Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38E3559438
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 09:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiFXH22 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 03:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiFXH20 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 03:28:26 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4C434668;
        Fri, 24 Jun 2022 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656055706; x=1687591706;
  h=from:to:cc:subject:date:message-id;
  bh=snvblPvKjV1IKbOUXUELrOXw2vLdM8KVAMtXE83IZTw=;
  b=LC3ccEy6Ook4yMaG3SlNFQ6AAWBazAzIkTZ2Autj2YWnicxOipIZbE1b
   uYvbYA8+zwa9WH9492LDJ1WPjh4JhJEocJXl66zRQbwdDCTxFz99WT/E8
   kXsCQRSuOLCuEUbWTRDYYNikm6z6hHb95D3f1PkPzxQ8/KrsW+/5YxhF8
   A=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 24 Jun 2022 00:28:25 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 24 Jun 2022 00:28:24 -0700
X-QCInternal: smtphost
Received: from hu-krichai-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.37])
  by ironmsg02-blr.qualcomm.com with ESMTP; 24 Jun 2022 12:58:07 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id EC2C43CD6; Fri, 24 Jun 2022 12:58:05 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v1 0/2] PCI: Restrict pci transactions after pci suspend
Date:   Fri, 24 Jun 2022 12:58:00 +0530
Message-Id: <1656055682-18817-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the endpoint device state is D0 and irq's are not freed, then
kernel try to mask interrupts by writing in to the vector
table (for MSIX interrupts) and config space (for MSI's).

These transactions are initiated after clocks are getting disabled
as part of PM suspend call. Due to it, these transactions are
resulting in un-clocked access and eventual to crashes.

So added a logic in qcom driver to restrict the unclocked access.
And updated the logic to check the link state before masking
or unmasking the interrupts.

Krishna chaitanya chundru (2):
  PCI: qcom: Add system PM support
  PCI: qcom: Restrict pci transactions after pci suspend

 drivers/pci/controller/dwc/pcie-designware-host.c |  12 ++-
 drivers/pci/controller/dwc/pcie-qcom.c            | 115 +++++++++++++++++++++-
 2 files changed, 123 insertions(+), 4 deletions(-)

-- 
2.7.4

