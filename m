Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178A2724170
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 13:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbjFFL6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 07:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbjFFL6d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 07:58:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE6710CA
        for <linux-pci@vger.kernel.org>; Tue,  6 Jun 2023 04:58:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b026657a6fso52172135ad.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Jun 2023 04:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686052709; x=1688644709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OCaUDE4A9Imgmixgd3Y+GDeqRFqT+5tR5O8CZs6HCl8=;
        b=OutYyqP2xn67DBS724mHcqAKPlm5BziPEw9lgNNo/rpmoJrqoCOo0m77dboBQ5dYwS
         taARkLSVyKUedrKlkYHLmbaj2CIa59MSfjPwVoS2F1OCt9S24/0MBzbEnktIvBIjfQOk
         tvtR7z0eU3V4+O4A9eOkVpKnhOE+PLvZhTgsBGCSFPRgzau4LhkqjmQtviGpLqWhAVg/
         aSFObId+faFtVHRbKDQN4u4PWUAbikKrGtI1xGfuPbFydxcqDmnBlZwISk6dTx89OBHZ
         D4vL/PaFiuU+QGfz+zakip6Dyn3Yt4UZtxRN9bALIA/2AAHWtG+u6NNVLsAnLBTwu5Dx
         125A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686052709; x=1688644709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCaUDE4A9Imgmixgd3Y+GDeqRFqT+5tR5O8CZs6HCl8=;
        b=AzPeKqUsiqu7QedyYJrBeuhIGuZXVcINenPT/d+iDnRBtPihcT+eb+wPTkwZBYbp/s
         V9YixXEcM8VrXjzbXBLPeq0OUpOqtWLWwWtYK2Raw8krUx6O8I3hLD0xtUp6NZCtguZa
         zJrkYmRoOi4gpjKqPNWzjVjhnjcW1eUAHhH6eyiijpA3R2308Qh8nLDcmgrRBWLW5Rqz
         CWc3vPigBdTvS1xAKWcmHRox6/a7+HXe1P4oHIkzFcCtatUFuWgXWvB9aAa/LUuCVFCq
         F9rjUedrg45q6eM70taBAIo/NKnE9k2zWoe0zg6XF4BX7OE4lGsRhlTWsm4HIYvV1zYr
         O1Nw==
X-Gm-Message-State: AC+VfDwzR7USmgSmZjkZ+9XoORYo+QPwGLcvcW6kRTHdGeJVhww9IsDZ
        EAi7/Z8HYAcxlEuTVJQ3wBlS
X-Google-Smtp-Source: ACHHUZ7LiLTUZzIr7HVLq0dVaYBc4JzUaiFd97KbZ9P7zFK9qNmSK6k1+OyEzgML1k4N9ldhuGeh5A==
X-Received: by 2002:a17:902:c411:b0:1ac:5717:fd5 with SMTP id k17-20020a170902c41100b001ac57170fd5mr2830030plk.60.1686052709081;
        Tue, 06 Jun 2023 04:58:29 -0700 (PDT)
Received: from localhost.localdomain ([117.202.186.178])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b001acaf7e22bdsm8419226plh.14.2023.06.06.04.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:58:28 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/7] Improvements to Qcom PCIe EP and EPF MHI drivers
Date:   Tue,  6 Jun 2023 17:28:07 +0530
Message-Id: <20230606115814.53319-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This series adds eDMA (embedded DMA) support to the Qcom PCIe EP and EPF 
MHI drivers for offloading the transfers between PCIe bus and the EP
memory. eDMA support makes use of the recently merged eDMA DMAEngine driver
and its integration with DWC PCIe EP core [1].

This series also adds Qcom SM8450 SoC support to EPF MHI driver that has
the eDMA support built-in.

- Mani

[1] https://lore.kernel.org/all/20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru/

Manivannan Sadhasivam (7):
  PCI: qcom-ep: Pass alignment restriction to the EPF core
  PCI: epf-mhi: Make use of the alignment restriction from EPF core
  PCI: qcom-ep: Add eDMA support
  PCI: epf-mhi: Add eDMA support
  PCI: epf-mhi: Add support for SM8450
  PCI: epf-mhi: Use iATU for small transfers
  PCI: endpoint: Add kernel-doc for pci_epc_mem_init() API

 drivers/pci/controller/dwc/pcie-qcom-ep.c    |   5 +-
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 280 ++++++++++++++++++-
 drivers/pci/endpoint/pci-epc-mem.c           |  10 +
 3 files changed, 281 insertions(+), 14 deletions(-)


base-commit: 1966e58011bc65eccf6d862096a94e4930ba4fe2
-- 
2.25.1

