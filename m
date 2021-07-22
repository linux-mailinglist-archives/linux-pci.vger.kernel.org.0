Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187093D231D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 14:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhGVLc1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 07:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhGVLc1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jul 2021 07:32:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E014C061760
        for <linux-pci@vger.kernel.org>; Thu, 22 Jul 2021 05:13:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id my10so5872855pjb.1
        for <linux-pci@vger.kernel.org>; Thu, 22 Jul 2021 05:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=toqwJOa6X7fF0WvEMU298oqKFP2M/oQGkU+L/iT7lKc=;
        b=cvHifto+mU9zRDSMMwqAFpvfXK5Oe2JNVOpNUa7rzR3+hyQa04XxZHMERrlZKgAFZK
         WLPWDmsSrdO7/EpmyptNNnJV5fVdjdCLUHwMQx3wqio0Ie7+jG5cLjwJZQxnBnc+F2u7
         XSlZj64+qLDQVvT6cUBMEWp/9nadg7N/pjhskILCVOQnl6Zn2wfz65d7Jea1u7MUrTEP
         UvorFH1a13Eb9VW6BieXB0LjrISG/rKaWoUM9qNE2mk7fntVNnD2ev4n+v6BYxhYRfD8
         RCPSKAds/PXq9+xa1SPfncLjmLRYiT+fyhGhGqdZPFRaJama91iFqduKlWnVsIO8jzGg
         0GGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=toqwJOa6X7fF0WvEMU298oqKFP2M/oQGkU+L/iT7lKc=;
        b=CEKuisncGVhDcsUczSI8Y0afLvzX6NOwIc4P9dyNomlyvSauBcOSL78IPvwRFZyTMJ
         A2S9sVek0+C4mKw2KWmXYo2hX1CknI9kJznQPE27U/Ug2Cv6VmHI+pzO+EJM61inhYN8
         4I947SFrbAFjnAaqgjPoX/tbu509ueWBJVvAYQV3+zF/uT4qfqtAkXG0jIQTlrP1JOuI
         8lYzIHbaaCVleHzSGzJZj95bZpgwN0dXAjWPWEhCJXoP/NYZ3EqURxSs4WKdJD0hhcwt
         4WCRYWOVTyVsq9oVwtwMMHgb7CKLRStbuddimEA0b3erOwDQty/V/Ix1rv/NCs4YuIWX
         hKQQ==
X-Gm-Message-State: AOAM532Bs+VFOL9cpqBTYKOjfeF9nKsIXSRIDUxYsfTZ1XT5YBTLnybj
        dGiAXtA0TZB8tiaRahFtJxXb
X-Google-Smtp-Source: ABdhPJxWOwziGGT2SQN01qtgjtuhdI8WSQk7IqMXafah1WHp5WZi5fNcL8m0FmaOQZbU3Q0TfGyz2Q==
X-Received: by 2002:aa7:980a:0:b029:358:adf9:c37b with SMTP id e10-20020aa7980a0000b0290358adf9c37bmr7061445pfl.12.1626955981046;
        Thu, 22 Jul 2021 05:13:01 -0700 (PDT)
Received: from localhost.localdomain ([120.138.13.30])
        by smtp.gmail.com with ESMTPSA id cp6sm2913846pjb.17.2021.07.22.05.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:13:00 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, smohanad@codeaurora.org,
        bjorn.andersson@linaro.org, sallenki@codeaurora.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 0/3] Add Qualcomm PCIe Endpoint driver support
Date:   Thu, 22 Jul 2021 17:42:39 +0530
Message-Id: <20210722121242.47838-1-manivannan.sadhasivam@linaro.org>
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

