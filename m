Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC2071A1C7
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 17:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjFAPDs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 11:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjFAPDh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 11:03:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8B2106
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 08:02:26 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b024e29657so4262185ad.3
        for <linux-pci@vger.kernel.org>; Thu, 01 Jun 2023 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685631680; x=1688223680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUOB4637lLFnr9fHn02ced7NePSyLCUhv1k9hLDeCPA=;
        b=IPyg2ZH+AHXqTknKHOyPR90o6cDHqz6BBonfB3u7L9bA7LA7GPC0YxeJ+5iNs+HC4X
         gzNuVtuUSumSchH6huzx8tYSIndh37sS2KAB7MF9n7N6132Z00gt5ghqwcCWbacJEE6R
         9tNZ6G+NtKQg8KFxID6gizmQ4jQYDuzisZAvJndaEb9Gfy6BC/KF2eEg5eh5z4qf1+5d
         X4N8f26Dbe5pnrL0/iJIwgMO8CVl5BnAmw0RuQnO3i4YG6HtAq57CpLgFhlbJgLmEa0H
         mY4e81JjjMt5ATLqTUz+4mjD79xL2qzvDIDHSujXbsvkZ9ZSDUI9KeCaHR3LlFsaQ6KE
         kYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631680; x=1688223680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUOB4637lLFnr9fHn02ced7NePSyLCUhv1k9hLDeCPA=;
        b=kPi3crh8MmFdLjJnwVUw96UNytAj8lkiE2F+e5wKPhgLXTtwGfHiDxLkHXrS0h/ZAN
         yjGT1meRJptMmadAWZf6xz0HF99mmScbdKdrt+4zxOs8ifSTVV5J/aau4LIrLBt9Pr8N
         /eglzhCVVImBPnMuNEQcYuOMUiUwp2XbFRosAcnK03IIwimLu0JfFu9ElXRC/oqbJY6/
         1hxDIkq1QyfuMywpeztBam4/SDOegxwum4bjDb1Jv9B4EC5ec6cM0ZfDteSNgjC4icqp
         Ze5tLYsA/E0yya+j6Y7V/7LLUhDAP04fD+R4qkVBsYNPBuqCuoQp8KIjzjZ3Qighh5Rx
         Zc6g==
X-Gm-Message-State: AC+VfDybs1py6yivGLGK17kP2ptaTNSFj5o/lUGlQpb1+VzWWBkNaRx5
        +zeZirYTCuSh7hT1eISC5rF/
X-Google-Smtp-Source: ACHHUZ4VeUsluNBNE20HQInmhW22MQ3b5CnsUxoaJpqUPx3FeEOcM3V+7mgkPaXNqleZfzMbX2vWkg==
X-Received: by 2002:a17:902:dace:b0:1b1:1168:654f with SMTP id q14-20020a170902dace00b001b11168654fmr4218393plx.56.1685631680483;
        Thu, 01 Jun 2023 08:01:20 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001b0499bee11sm3595480plx.240.2023.06.01.08.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:01:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH v5 0/9] Add support for MHI Endpoint function driver
Date:   Thu,  1 Jun 2023 20:30:54 +0530
Message-Id: <20230601150103.12755-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Changes in v5:

* Moved the PCI EPF driver match logic to pci_epf_match_id() function and used
  that to get the matched driver ID for passing to driver probe instead of
  storing the id during match.
* Added a patch to fix the missing documentation about MSI/MSI-X start vector.
* Addressed the review comments on the MHI EPF driver. Most notably, got rid of
  local variable for tracking MHI registration and used the mhi_dev pointer.
  Also, modified the MSI vector increment comment to make it clear.
* Added a patch for adding MHI EPF driver to MAINTAINERS file

Changes in v4:

* Collected review tag from Kishon
* Changed the IP_SW0 channel numbers as per latest MHI spec

Changes in v3:

* Fixed the probe function of EPF_VNTB driver

Changes in v2:

* Rebased on top of v6.3-rc1
* Switched to the new callback interface for passing events from EPC to EPF
* Dropped one patch related to notifier

Manivannan Sadhasivam (9):
  PCI: endpoint: Add missing documentation about the MSI/MSI-X range
  PCI: endpoint: Pass EPF device ID to the probe function
  PCI: endpoint: Warn and return if EPC is started/stopped multiple
    times
  PCI: endpoint: Add linkdown notifier support
  PCI: endpoint: Add BME notifier support
  PCI: qcom-ep: Add support for Link down notification
  PCI: qcom-ep: Add support for BME notification
  PCI: endpoint: Add PCI Endpoint function driver for MHI bus
  MAINTAINERS: Add PCI MHI endpoint function driver under MHI bus

 MAINTAINERS                                   |   1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   2 +
 drivers/pci/endpoint/functions/Kconfig        |  10 +
 drivers/pci/endpoint/functions/Makefile       |   1 +
 drivers/pci/endpoint/functions/pci-epf-mhi.c  | 462 ++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |   3 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |   2 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c |   2 +-
 drivers/pci/endpoint/pci-ep-cfs.c             |   3 +
 drivers/pci/endpoint/pci-epc-core.c           |  56 ++-
 drivers/pci/endpoint/pci-epf-core.c           |  20 +-
 include/linux/pci-epc.h                       |   2 +
 include/linux/pci-epf.h                       |   8 +-
 13 files changed, 559 insertions(+), 13 deletions(-)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-mhi.c

-- 
2.25.1

