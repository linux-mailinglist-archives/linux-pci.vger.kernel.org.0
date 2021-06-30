Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023A83B7C35
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 05:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhF3Dtl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 23:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbhF3Dtj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 23:49:39 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36887C061760
        for <linux-pci@vger.kernel.org>; Tue, 29 Jun 2021 20:47:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so3358515pjs.2
        for <linux-pci@vger.kernel.org>; Tue, 29 Jun 2021 20:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nfp5Ud7Atbg6Yf9Rudx7u8PLh35aqeWCQdA0/EvN+9U=;
        b=KyHZGH0hhhRJhA5+2alc8wkmgYE+A2aP0Q3TkoCB+BvEuNnTaK8VgwCOpZIOoYNCQj
         eYY7hp8FsfKGnPjpkPALQePXe6hz3livFjYKZb8VSOathXRNgQV58H4AyrU5X0y61e5P
         rrea4D0JhwTtAYCYHnZ3Y9y3j4aVH77JL7y9uqmyFE77fW8+e59OGxCd1cYBlSNvbQEK
         +r4eDq+blNJvXOKYPrZm0DovqK8iNCFnOMN3ZESsLU6F1VEABVn9x1jYT600HXoncXRH
         kLLV0zExKOMXNr8C2t0Nnk/sG7TyRO5CG7ueReXXZ4Q5PiGNCMnaTvXPEJ0dGrfH7SZt
         pv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nfp5Ud7Atbg6Yf9Rudx7u8PLh35aqeWCQdA0/EvN+9U=;
        b=CTr9RVz5LFIIgw7XWEfLdYiMDpohmH1+0iAHq0ADXzlvM8nf00PUccf+bAIdD+ClwD
         q/DZ9J+jZ4tt/feKqQGndNY7eBa4+B0E/tMqDE2d50X5KKBVVEZiS1M7sW7kkHh5Yn/9
         PdsSyfybBI42k0/c3uAIQwLJUalq3vA8j0QOzkxOKuUbACXKwSrc3NPncbe9du9QeWPD
         skC5W2ZHQwPNMXSzBss9EBpztYOQt7Ux/UUO1dsRq0hh4bp8SCtqLOylsc2YeTeBhGTo
         j9fPIkSeRCAYiTp4DcNwdcrM/jd3J25YGI0L+JprO50yxQAgF9JwPtdrI+gWb94hgZYA
         bNLQ==
X-Gm-Message-State: AOAM531JXFSoH24rlv2Crdbqqrl7MkyDYgqk3HmwLK4gYxYQlDSH2ivX
        83phlw5OyKYLKQy6BELtB7ME
X-Google-Smtp-Source: ABdhPJxnsYs6giJBbGIHTa1sKzCAGQ49BvL5z990kkngzJ/gKaT4MBrJG06vvgL6q9NDq/L6IAlJTQ==
X-Received: by 2002:a17:90b:8cc:: with SMTP id ds12mr37596230pjb.36.1625024829523;
        Tue, 29 Jun 2021 20:47:09 -0700 (PDT)
Received: from localhost.localdomain ([120.138.13.102])
        by smtp.gmail.com with ESMTPSA id j15sm19565081pfh.194.2021.06.29.20.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 20:47:08 -0700 (PDT)
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
Subject: [PATCH v5 0/3] Add Qualcomm PCIe Endpoint driver support
Date:   Wed, 30 Jun 2021 09:16:50 +0530
Message-Id: <20210630034653.10260-1-manivannan.sadhasivam@linaro.org>
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
  PCI: dwc: Add Qualcomm PCIe Endpoint controller driver
  MAINTAINERS: Add entry for Qualcomm PCIe Endpoint driver and binding

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 160 ++++
 MAINTAINERS                                   |  10 +-
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 742 ++++++++++++++++++
 5 files changed, 922 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-ep.c

-- 
2.25.1

