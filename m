Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00C53B2887
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 09:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhFXH2K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 03:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhFXH2K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 03:28:10 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45607C061756
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 00:25:50 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h4so4004676pgp.5
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 00:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T7hKBbNfZnUEFRVyGSb3NXeHE5g+9KB0412sx5zKsWc=;
        b=WmhHUBR9MFvp62nyWky5sL7YdhwHI4HK6/dsMwN3s+hGgUn0qByVEuoa7GyUu4xh0E
         p1SOmN08+ilFp4CdAYq4oHsWsDDlgst3Vvi4f8N48iTjUKNH44SxljmeDSSRNnvqKlDb
         vL6RlzefR/fUz/p9movHNNxfkC8xmeQcrrepgWrK8XdlUyJDcwIERMaovpEWV0U+2dMI
         5sulrsdMaUM8cbGCtRRqrRPrv3OaVXRcKZwgaFdOhL3+rN4h12KkY26le74F+OCPYMIy
         M+aKHfEbFyDYq1Uv4JC+CxlgSZo5C8i+AAU6sMRMLZm6MlXtdk1S8i6E5uN/bFQC7gvs
         smhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T7hKBbNfZnUEFRVyGSb3NXeHE5g+9KB0412sx5zKsWc=;
        b=Kd6EiGvW2PKj4NfTXSOIlMMXKtjz+hrUZ07US0eY8QM7l08doYeufUbHMdhI9vhhk5
         uN7GLyPDEz9lwIAn4HmU9FKTUyFLdWO0sXcjst52EngB0I4ey31qEaEirJi3QEVI1pPn
         ICgUbbQoD21YwCjgohz7hLpbazZYTnFLKhrqNznSO7IqZz11GVcG4T59ZKksFegug8f8
         hBiTAkOpL6tSn3KxellinMppDwvTzKYrqNySyFYgIHl+mryVqteB66j9Uel+WTs+VvnY
         MuiEOKDVE21/tdzXH9wYxBwm3xJKF0BilEgMd+tBwBPkyj5rZc2K4uylPxcUd+grDQcD
         kjBw==
X-Gm-Message-State: AOAM5315Cu7hep6dy4/sLCS8HsjyqbsT89ijHAt1U+iIyeyZoys3ionI
        CtfU7GPIyOm0XPW8hMbZZfV5
X-Google-Smtp-Source: ABdhPJzbC8sFhxzhtT90my6oBv8SO5Uf7hSmvwZew0WXOMnIwTiZ30h32OAgk0uwVDGkrSJztwUX7Q==
X-Received: by 2002:a63:e948:: with SMTP id q8mr3627859pgj.52.1624519549630;
        Thu, 24 Jun 2021 00:25:49 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.173])
        by smtp.gmail.com with ESMTPSA id g13sm1923802pfv.65.2021.06.24.00.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 00:25:49 -0700 (PDT)
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
Subject: [PATCH v4 0/3] Add Qualcomm PCIe Endpoint driver support
Date:   Thu, 24 Jun 2021 12:55:31 +0530
Message-Id: <20210624072534.21191-1-manivannan.sadhasivam@linaro.org>
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
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 751 ++++++++++++++++++
 5 files changed, 931 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-ep.c

-- 
2.25.1

