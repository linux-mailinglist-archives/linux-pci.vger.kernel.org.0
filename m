Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6685F6B89C6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 05:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCNEqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 00:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCNEqf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 00:46:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B435AB67
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 21:46:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so13928877pjp.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 21:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678769193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UasGxUvD/6g4IwIcOZQz9JmOw1F78bhUJX7l6AUhgEk=;
        b=ABdMLy0qDOTqhAEOBhgimyuNWzeR/Zq5TUIKYOS3Qg/oz1Q5nV6Cu5vjpZE7o0ErJE
         VygRD7tCfY+mb/m6T1HY1BV4iLZl17WK7INjQXz1vFJbAwPDgrH9mqIhXJEwovlPh817
         v4KfnPuyqnKGTBW4VwbI2FAuYqWefezJqTn1wWm4bRXfQ4lmAl886AsC3YPdHUtQIOYD
         yNXAyIyd+J+NzElYfwRWL+RJSS0FC49fJqpUiGx4tpzBKxgZF35qh5dXw3tLtRwNFxqg
         t4NwwSppme77as7jki7UhJ4c4MFT3lpfWn688RVhVCHdN+EegQtAzgJ06V01dMBAtUxa
         E8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678769193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UasGxUvD/6g4IwIcOZQz9JmOw1F78bhUJX7l6AUhgEk=;
        b=nPKBSSmgK2cPXKtHRnkjW8uodrG5VpjtIIj8m8xurVktY2kvaCZT5HlP1vCc1XtWtx
         lAaJRwFNGF4nAirHPXt8peDvp46BTqLSv67HWMPIEvNLwM8/v9RZzNO70vuGycsY6MTT
         dwmFF6feLnOHrYQPnuPzlbo6tjf1qP+CsgCUoREXlm4OA4fzmJudL1AZ+mDyuklCAq3Z
         6LwJfmaJ6lYYBXXTdRndDY1YxOY7GGuLZYRqIJg8RRqhuUE9u1cLWi6ronF8Fjud3OGc
         EYqrvc+GsgZPULjTfLfUFiH9jso3JQHVLTD8rVSv7oAjSVMVtKg1n+l7rAEeICEdCi3b
         Qngg==
X-Gm-Message-State: AO0yUKXI35aY3VNFDan/UoqeXY/wg90eJEW0Du/PPego6IqWwJ9ZcgTF
        rXqU/HSp9BWKsxiA6G6xMDEs
X-Google-Smtp-Source: AK7set9w0z5ELRqjpIFXFvbpfdGQuGD93hmPVj3hFDC/IOl8akSJqOB1b6dOFR3oMdAMhNGpOXNm0Q==
X-Received: by 2002:a17:902:c946:b0:19c:be03:d1ba with SMTP id i6-20020a170902c94600b0019cbe03d1bamr42635675pla.6.1678769193313;
        Mon, 13 Mar 2023 21:46:33 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id lh13-20020a170903290d00b0019c2b1c4ad4sm690125plb.6.2023.03.13.21.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 21:46:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/7] Add support for MHI Endpoint function driver
Date:   Tue, 14 Mar 2023 10:16:16 +0530
Message-Id: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

