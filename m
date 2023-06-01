Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F79571A127
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 16:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjFAO5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 10:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjFAO5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 10:57:38 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFAF18C
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 07:57:37 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5304d0d1eddso365839a12.2
        for <linux-pci@vger.kernel.org>; Thu, 01 Jun 2023 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685631456; x=1688223456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rmnvesiHm2PCRYYtqBcPxBFWmAHluzsL+dqvf9/FLR0=;
        b=TNhODOFe3VPpymqxm+ucXF7xfwzIVA6pOK2an6amjX7VFTE7lTOrDmS2K0/q8Wksmk
         gXvwWEAodZkrt7tASZY40Tb2IaMjMuc265O+eDLDT+Aoppkv7yi26HO1A6NsMhu1h049
         PzHiojGO/toLGLVlKyXCZaXtbUxUrNXs5PCpkNFh5fvazx3urVm65Lw9Xo2sRFbX2eKp
         11rQh0qvgPLDiGNmwM4TR3NrOSJmeBMeRyheCQvGte0P1kPdXxIUnR5EjsmB8tV+h/Vh
         70LcRWie4DKZ22SDG3TaGwfwaYjopTs7JDDu6NStyp83Y5I3GvlWgB+Yqr43SZFgVYyO
         hauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631456; x=1688223456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmnvesiHm2PCRYYtqBcPxBFWmAHluzsL+dqvf9/FLR0=;
        b=kVZ5ZQY6/yBwKAPlEhn8m2hbrgz2rVODfj4osF2koXSe5Z0QvB5T2NEb/9NyPa7YiZ
         DqFTyGh9L9pAk9Lce56yhu7pOhdnzrDaIgoPllAx1ZDTvEomrTLzAxIagXG6+z7LEn14
         SD9Vp741AYrw0Bf91gqpq19z8W2R9uzh/ad8lywO2R7lyMf93+bWyJoNhLsScELAOaYc
         E6r1spRUf3xeUbgezjwVG1Z+rX64EWGMV1C8kBeUbrROR4hke15h8j600S1ClztmXupr
         DGEbSndywLi3cWSl2UmOfQOqswixT5aYlurJIPclTq771ZRhvzZK3Ysku/t1bZudvf2t
         dGkQ==
X-Gm-Message-State: AC+VfDw1uyppPgpGIXvKvdjc4N+026CZv1RWGvVpq5xlUV7l0hMq/NIh
        6FcXVIGfY3mLA7wU1kPWG2ha
X-Google-Smtp-Source: ACHHUZ7/dnL69tsFA7uB9Tx68drmjDhTy9/bpwpA9IGEOCy4MaKUApeF6G/EOFIJAPKK4yx3GvNwqQ==
X-Received: by 2002:a17:902:e886:b0:1b1:84c5:8abf with SMTP id w6-20020a170902e88600b001b184c58abfmr2798729plg.49.1685631456620;
        Thu, 01 Jun 2023 07:57:36 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001b0603829a0sm3577826plg.199.2023.06.01.07.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:57:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 0/9] Add support for MHI Endpoint function driver
Date:   Thu,  1 Jun 2023 20:27:09 +0530
Message-Id: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
  MAINTAINERS: Add entry for MHI networking drivers under MHI bus
  PCI: endpoint: Add missing documentation about the MSI/MSI-X range
  PCI: endpoint: Pass EPF device ID to the probe function
  PCI: endpoint: Warn and return if EPC is started/stopped multiple
    times
  PCI: endpoint: Add linkdown notifier support
  PCI: endpoint: Add BME notifier support
  PCI: qcom-ep: Add support for Link down notification
  PCI: qcom-ep: Add support for BME notification
  PCI: endpoint: Add PCI Endpoint function driver for MHI bus

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

