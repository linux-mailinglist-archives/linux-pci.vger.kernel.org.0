Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A96410FB8
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 09:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhITHBZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 03:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhITHBZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Sep 2021 03:01:25 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8BEC061762
        for <linux-pci@vger.kernel.org>; Sun, 19 Sep 2021 23:59:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y4so13814724pfe.5
        for <linux-pci@vger.kernel.org>; Sun, 19 Sep 2021 23:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9f/uoH0k3kcTrJoBN4xkFEVn3LDPuL95GvB2FHHsCJY=;
        b=nQh65a8mRcM96mOvKTtKO1GHdqpqYYHSImR7TUz+hO51elCwJPtoPE49ey40V++j4e
         aD6Fedx+KRVpN9tWVWDID+dSoLEaetnh1EvRN/EPtownN/QN36JjkPcxmxCZIZgEiowu
         KxUL90WiD2kvhEVM6dPEHYNZZ+H+U0hEiPZNGFANjaAym4WO7OvH+M5R+pYZKgktnNHV
         xplrA8/u/fctvqjTuo0jOHjRLiKm6FENyWGqCF/wZIaKTApT9GYi9PpLa8eoBlPptHVa
         iqlwPODsPUmiXmiStJ+ogWm2phq5vb2Glkkz9/oKfTLgphNBnfDMzIYkkNs409xOjW0x
         QQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9f/uoH0k3kcTrJoBN4xkFEVn3LDPuL95GvB2FHHsCJY=;
        b=MCyW/HoKEpHbjPLHwWjNT/jCV3LSbsXsScbX0FQBPTiOiB9+exU/ZSPL4aEvEV3O1v
         wAmxmw52xpQII8xsNzUCME6hoXjIUYAjuPFjqmiZvD5trpzPUKJRahe2ut+PAPSYXbar
         5041nzEGFr0TeikUNZL0PxSX7DgC3oEd1cI0m7VhzLLR1hJ1R5KMTViGsAPeNAzF0ICE
         /uIELp7oV1dyi7fOMgHTjYrw9uU4v7nfeidzvp5RU391WOEu6xCUSAHzSuUuzfDhfE//
         ww39/gtz3jndVY/i4m6zDzXY2HjqTeCaLmesIr/PAm4XHjW0y3oaPCFEQtjQysFPugbW
         ++Lg==
X-Gm-Message-State: AOAM530b1TqVE4heaQwhLmTTl+4L2XlYtPUbVwvZl6yH6Acv+Sp4VtFK
        rVJAnDEcKSRBIHqepEDSJfNg
X-Google-Smtp-Source: ABdhPJzynZnY3/+qUe0q4BQT2fPVEv59drurXiTSvxUmqHifbHPK84m7SA2qsr/ZcAe5w0hwoW7JIw==
X-Received: by 2002:a65:6398:: with SMTP id h24mr21590975pgv.367.1632121198220;
        Sun, 19 Sep 2021 23:59:58 -0700 (PDT)
Received: from localhost.localdomain ([59.92.98.104])
        by smtp.gmail.com with ESMTPSA id p15sm12768349pff.194.2021.09.19.23.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 23:59:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, bjorn.andersson@linaro.org,
        sallenki@codeaurora.org, skananth@codeaurora.org,
        vpernami@codeaurora.org, vbadigan@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v8 0/3] Add Qualcomm PCIe Endpoint driver support
Date:   Mon, 20 Sep 2021 12:29:43 +0530
Message-Id: <20210920065946.15090-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

This series adds support for Qualcomm PCIe Endpoint controller found
in platforms like SDX55. The Endpoint controller is based on the designware
core with additional Qualcomm wrappers around the core.

The driver is added separately unlike other Designware based drivers that
combine RC and EP in a single driver. This is done to avoid complexity and
to maintain this driver autonomously.

The driver has been validated with an out of tree MHI function driver on
SDX55 based Telit FN980 EVB connected to x86 host machine over PCIe.

Thanks,
Mani

Changes in v8:

* Added Reviewed-by tag from Rob for the driver patch
* Rebased on top of v5.15-rc1

Changes in v7:

* Used existing naming convention for callback functions
* Used active low state for PERST# gpio

Changes in v6:

* Removed status property in DT and added reviewed tag from Rob
* Switched to _relaxed variants as suggested by Rob

Changes in v5:

* Removed the DBI register settings that are not needed
* Used the standard definitions available in pci_regs.h
* Added defines for all the register fields
* Removed the left over code from previous iteration

Changes in v4:

* Removed the active_config settings needed for IPA integration
* Switched to writel for couple of relaxed versions that sneaked in

Changes in v3:

* Lot of minor cleanups to the driver patch based on review from Bjorn and Stan.
* Noticeable changes are:
  - Got rid of _relaxed calls and used readl/writel
  - Got rid of separate TCSR memory region and used syscon for getting the
    register offsets for Perst registers
  - Changed the wake gpio handling logic
  - Added remove() callback and removed "suppress_bind_attrs"
  - stop_link() callback now just disables PERST IRQ
* Added MMIO region and doorbell interrupt to the binding
* Added logic to write MMIO physicall address to MHI base address as it is
  for the function driver to work

Changes in v2:

* Addressed the comments from Rob on bindings patch
* Modified the driver as per binding change
* Fixed the warnings reported by Kbuild bot
* Removed the PERST# "enable_irq" call from probe()

Manivannan Sadhasivam (3):
  dt-bindings: pci: Add devicetree binding for Qualcomm PCIe EP
    controller
  PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver
  MAINTAINERS: Add entry for Qualcomm PCIe Endpoint driver and binding

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 158 ++++
 MAINTAINERS                                   |  10 +-
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 710 ++++++++++++++++++
 5 files changed, 888 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-ep.c

-- 
2.25.1

