Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE95F687A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 15:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiJFNtp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 09:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiJFNtn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 09:49:43 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6D26159
        for <linux-pci@vger.kernel.org>; Thu,  6 Oct 2022 06:49:41 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c24so1782537plo.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Oct 2022 06:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=U+uptFLX/Zxx/MvN0q/9ClLT1ERUiDfb4vm7Q2Pz9Fw=;
        b=wzkljOut3o85PeRq6BvnlyCZTT53Euh29aXc2QjoXL3Z6TxxYAjyBj180oPx02qKaO
         el/V3Pdu4LeJAffz8LRHmAPq+WCcXfxzb0j5V0pFaRdzgR/QxcyGbD2kejPl4+cd5+3J
         loGfvLUpxelWEPVrsLjQBMMZNW7AwTJts+OQ89KyeHXHJHq1jn5jltI1wCqg2A+ao9tE
         jcesnIYrbnG9UuoeQ7S5S1UKObUeSAp30DnPpq0iRwJCiX8YYCiQf3ksL4FT7FOwXcME
         MUqCnDwFmmBgN31+MpYY7kLQpi10qM7zBfcMpKEYD8WyEshkMNcuOKuCa9uNFzK35DSu
         PMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=U+uptFLX/Zxx/MvN0q/9ClLT1ERUiDfb4vm7Q2Pz9Fw=;
        b=DBxkV36nfNs/TVI6VYoSSRl4+ysyxK4MXNC6K2zvnbcSqj+DLqXDeauw9pE27Mc00e
         PvPb44i8CXpdAxwRyW8mrD6RJbfVE6oqlr3etOX9Fhc4yjETSEt9w7sujw9okKGCBB0y
         0kcBaGN+m+7Yy78qTxlzF6BYc+5UrzCNCljQlmSOPEDJS1CtDuwR+rXZohHM3Q2d9iSw
         lloDsIE0H72YKz4t/Ek/DKqw+wABwLar3VbAY12RgHsHXa/bcHmT2yrQzSotiXyQSMRU
         Osk7gR24t3UFbyqmDhI1Uomz2yADrSISpRpw5Czd4XduuLYg7QxgHTVf/0xGGd71BnZo
         q8YA==
X-Gm-Message-State: ACrzQf2sqvXXU+J9qxVQrM+M+xR+1owZRBDXYFOfQdXXd/wNex2pq5W7
        rhSLPSLtNyM3wn/SN1Oc3wb9
X-Google-Smtp-Source: AMsMyM6oyKJ2214jUuxvdHBTmsVFEOGtPiDVhtSToZrXTpOE2I/0wIt6ljlyiispGmrOkwNXWWDPoA==
X-Received: by 2002:a17:90a:4ec6:b0:20a:96cd:2a46 with SMTP id v6-20020a17090a4ec600b0020a96cd2a46mr5516758pjl.171.1665064180930;
        Thu, 06 Oct 2022 06:49:40 -0700 (PDT)
Received: from localhost.localdomain ([220.158.158.220])
        by smtp.gmail.com with ESMTPSA id k25-20020a635a59000000b00434760ee36asm1874053pgm.16.2022.10.06.06.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:49:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/5] PCI: endpoint: Rework the EPC to EPF notification
Date:   Thu,  6 Oct 2022 19:19:22 +0530
Message-Id: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

During the review of the patch that fixes DBI access in PCI EP, Rob
suggested [1] using a fixed interface for passing the events from EPC to
EPF instead of the in-kernel notifiers.

This series introduces a simple callback based mechanism for passing the
events from EPC to EPF. This interface is chosen for satisfying the below
requirements:

1. The notification has to reach the EPF drivers without any additional
latency.
2. The context of the caller (EPC) needs to be preserved while passing the
notifications.

With the existing notifier mechanism, the 1st case can be satisfied since
notifiers aren't adding any huge overhead. But the 2nd case is clearly not
satisfied, because the current atomic notifiers forces the EPF
notification context to be atomic even though the caller (EPC) may not be
in atomic context. In the notification function, the EPF drivers are
required to call several EPC APIs that might sleep and this triggers a
sleeping in atomic bug during runtime.

The above issue could be fixed by using a blocking notifier instead of
atomic, but that proposal was not accepted either [2].

So instead of working around the issues within the notifiers, let's get rid
of it and use the callback mechanism.

NOTE: DRA7xx and TEGRA194 drivers are only compile tested. Testing this series
on the real platforms is greatly appreciated.

Thanks,
Mani

[1] https://lore.kernel.org/all/20220802072426.GA2494@thinkpad/T/#mfa3a5b3a9694798a562c36b228f595b6a571477d
[2] https://lore.kernel.org/all/20220228055240.24774-1-manivannan.sadhasivam@linaro.org

Changes in v3:

* As Kishon spotted, fixed the DRA7xx driver and also the TEGRA194 driver to
  call the LINK_UP callback in threaded IRQ handler.

Changes in v2:

* Introduced a new "list_lock" for protecting the epc->pci_epf list and
  used it in the callback mechanism.

Manivannan Sadhasivam (5):
  PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ
  PCI: tegra194: Move dw_pcie_ep_linkup() to threaded IRQ handler
  PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
  PCI: endpoint: Use callback mechanism for passing events from EPC to
    EPF
  PCI: endpoint: Use link_up() callback in place of LINK_UP notifier

 drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  8 +++-
 drivers/pci/endpoint/functions/pci-epf-test.c | 38 ++++++-------------
 drivers/pci/endpoint/pci-epc-core.c           | 32 ++++++++++++----
 include/linux/pci-epc.h                       | 10 +----
 include/linux/pci-epf.h                       | 19 ++++++----
 6 files changed, 58 insertions(+), 51 deletions(-)

-- 
2.25.1

