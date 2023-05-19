Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B74709A24
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 16:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjESOm0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjESOmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 10:42:24 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F361A6
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:42:23 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d41763796so80109b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684507342; x=1687099342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QxW2dC8DpIB+E4FM2rEwoLKWijA29j1mc0pHII1lmCA=;
        b=thHAa7CchoE1NLBuAq+oeQzOJwWOma12Pim3N47UBdIaWaxLX0R8ZQdMC6WKOV4jyo
         5JcCgklVz4JxqY6af2ID56MeyN7O9H3dCXsArvauQRqbFxGLPnqmlGwGJ8TVuE8G/Ck6
         +2Ed4edM4bSeBczjrRlV93bLQiU5LkT7AqTyu7XDVMjYuxmuHY2jaO7mJ4PnPdggMT9X
         VuZmPrDv3eriUV4a1kw+H8wTGdIqjaUd0m+VlvEIwHxbUFCRJ1/bGoOmRpMya9Fhz7rV
         LuJSbDhuWoGR6ysqDmJg/kHoiNDBy8sratCyNiLsnepVOYDa6UBOP4tzMHWUPU10SqhP
         UR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507342; x=1687099342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxW2dC8DpIB+E4FM2rEwoLKWijA29j1mc0pHII1lmCA=;
        b=L1SrqRIZJTqwnG31yF+TNVvC9Chw/17m9ySJqfZ33Cfq89F5RtH8HUtEeZ+akiWcJg
         vvN/jeJLMXx9dbT/ERToG7TS1/4kG/OwGfmJRIuDcYJt6qhJ6KmjzucE0nO/duUiwo4E
         Em6qHIWmfMT9eb2CAaeldYDX8Xx9H8imAv2v3CUV20hoWhoE4Kygrjo8pQjmKVLhnxcL
         09SV9n96ToDU5SNDo+HOZciBSVWVz8+8lIPBr58FKz0zoDIZdQ2HuqgF9BCLP0HSm+8g
         mPPtgiic3Tf5xNSuSZ4G3lLyevWqjoeQ70Atf+3NOyV4+Wj4re0ticv2qz4l27Gpq7TB
         Rviw==
X-Gm-Message-State: AC+VfDxJn4rz48MSATqxkLjbprQ3a3ebNwBexhpvAutsb+SiktYLkHI7
        0JGQXVtrjU91iG+wpXPRMbmX
X-Google-Smtp-Source: ACHHUZ7gLvpq5YXfYHPI4+dpDWfbf0UV4FW4SIGLJ9Cv15xtMezdH2Gy5DqP+Zy28ziYouuXLP/Pdg==
X-Received: by 2002:a05:6a00:845:b0:64a:f730:154c with SMTP id q5-20020a056a00084500b0064af730154cmr3577224pfk.13.1684507342475;
        Fri, 19 May 2023 07:42:22 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.13])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7808b000000b005d22639b577sm3089611pff.165.2023.05.19.07.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:42:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 0/7] Add support for MHI Endpoint function driver
Date:   Fri, 19 May 2023 20:12:08 +0530
Message-Id: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

This series adds support for Modem Host Interface (MHI) Endpoint function
driver and few updates to the PCI endpoint core.

MHI
===

MHI is the communication protocol used by the host machines to control and
communicate with the Qualcomm modems/WLAN devices over any high speed physical
bus like PCIe. In Linux kernel, MHI is modeled as a bus driver [1] and there
are two instances of MHI used in a typical setup.

1. MHI host - MHI implementation for the host machines like x86/ARM64.
2. MHI Endpoint - MHI implementation for the endpoint devices like modems.

MHI EPF
=======

The MHI Endpoint function driver (MHI EPF) is used on the MHI endpoint devices
like modems. The MHI EPF driver sits in between the PCIe EP and MHI EP bus and
carries out all of the PCIe related activities like BAR config, PCIe Event
handling, MMIO read/write etc,... for the MHI EP bus.

Below is the simple representation of the setup:


                 +----------------------------------------------------+
                 |                  Endpoint CPU                      |                   
                 |                                                    |
+------------+   |   +------------+   +-----------+   +-----------+   |
|            |   |   |            |   |           |   |           |   |
|            |   |   |   MHI EP   |   |           |   |           |   | PCIe Bus
|  Modem DSP +---+---+    Bus     +---+  MHI EPF  +---+  PCIe EP  +---+---------
|            |   |   |            |   |           |   |           |   |
|            |   |   |            |   |           |   |           |   |
+------------+   |   +------------+   +-----------+   +-----------+   |
                 |                                                    |
                 |                                                    |
                 +----------------------------------------------------+

The data packets will be read from the Modem DSP by the MHI stack and will be
transmitted to the host machine over PCIe bus with the help of MHI EPF driver.

Test setup
==========

This series has been tested on Snapdragon X55 modem a.k.a SDX55 connected to
the ARM64 host machine.

Thanks,
Mani

[1] https://www.kernel.org/doc/html/latest/mhi/mhi.html

Changes in v4:

* Collected review tag from Kishon
* Changed the IP_SW0 channel numbers as per latest MHI spec

Changes in v3:

* Fixed the probe function of EPF_VNTB driver

Changes in v2:

* Rebased on top of v6.3-rc1
* Switched to the new callback interface for passing events from EPC to EPF
* Dropped one patch related to notifier

Manivannan Sadhasivam (7):
  PCI: endpoint: Pass EPF device ID to the probe function
  PCI: endpoint: Warn and return if EPC is started/stopped multiple
    times
  PCI: endpoint: Add linkdown notifier support
  PCI: endpoint: Add BME notifier support
  PCI: qcom-ep: Add support for Link down notification
  PCI: qcom-ep: Add support for BME notification
  PCI: endpoint: Add PCI Endpoint function driver for MHI bus

 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   2 +
 drivers/pci/endpoint/functions/Kconfig        |  10 +
 drivers/pci/endpoint/functions/Makefile       |   1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c  | 454 ++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |   3 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |   2 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c |   2 +-
 drivers/pci/endpoint/pci-ep-cfs.c             |   3 +
 drivers/pci/endpoint/pci-epc-core.c           |  52 ++
 drivers/pci/endpoint/pci-epf-core.c           |   8 +-
 include/linux/pci-epc.h                       |   2 +
 include/linux/pci-epf.h                       |   8 +-
 12 files changed, 540 insertions(+), 7 deletions(-)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-mhi.c

-- 
2.25.1

