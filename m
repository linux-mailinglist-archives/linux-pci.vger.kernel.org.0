Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C2F399F1A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 12:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhFCKlI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 06:41:08 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:33557 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhFCKlI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jun 2021 06:41:08 -0400
Received: by mail-pj1-f50.google.com with SMTP id k22-20020a17090aef16b0290163512accedso3188026pjz.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Jun 2021 03:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pRg79UT6E/Gj74wGPI8V0FYVbz3jkCUsXaAsm44vs+g=;
        b=T4sE1cyf15ztjxxnjWVzAtElXiP/nRBYyn2vr5v4vHgqpXUieoec8O3DK0vp/WPvV0
         B5C1QVWhFMavalpOFa5hHC3JGlTBPJrqgnO0ncxBJupE39lEQyByH/w0eK7k0mtNmav4
         mvUDM8FEmKbTUUWcBNHsE5do4D//Y6fYfHVasv9ilHwFEtpWlVsuvyps3s16HON3R1C/
         l4L4iMwGcnpzLg3LccfhfBEDp/nmUOp+m0L7AGwLw01kE9Ce49o9pG7rD43gDIhkC86O
         lMghye1L74Z61P68mI4/ONasCV0+NN/yDz6omGkybOEbD9Vzg4XLLGszhH8uFCpy9gmP
         qOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pRg79UT6E/Gj74wGPI8V0FYVbz3jkCUsXaAsm44vs+g=;
        b=GFXxMKulzdiZWDaaPamXR44HT0d19vcJeODUJCLSaPATNhJS/j/Ht2RZ2C9hIZzGr5
         Fy6ioPaWs6MZs9eC+qvYlIJbt/xBihU3ESaZK084HirhtZzbixw36beYDL5LPdd14GXB
         vZLqstapY2zQfaqi4LZwDMt2J8yWSgFyUYdXV68y5qkLpDHMHcizMxqxHQn2T4x7mnoZ
         RUA0pP9dMkGzTPE9bxmp7PGfWYobJXkwfdl6O8byibkpfF43xrr+GbfEepzX0KWBkxhx
         j8NXt/PKXobIjJyEBiUPUVc+sy+9/AU01enwd3qH87CtRwdGme2QFATzeBcT0BxDG8tE
         /EQQ==
X-Gm-Message-State: AOAM530SorW+1L17j6VFOEwh5mwxKZmCKUFyMZ5OMy5ZgANzrd2D59vO
        ZXidqZH6BKfdcUOSe3zL+pee
X-Google-Smtp-Source: ABdhPJwexUDiehxBzS/6kyi+GFZp5yt7L/1dwn0Ks+AyLd1s9HY3PLCoPBjJZLQj7O2YsrA9u7EHOQ==
X-Received: by 2002:a17:902:7684:b029:f4:b82b:b893 with SMTP id m4-20020a1709027684b02900f4b82bb893mr34494121pll.67.1622716703839;
        Thu, 03 Jun 2021 03:38:23 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.41])
        by smtp.gmail.com with ESMTPSA id v67sm2053370pfb.193.2021.06.03.03.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 03:38:23 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] Add Qualcomm PCIe Endpoint driver support
Date:   Thu,  3 Jun 2021 16:08:11 +0530
Message-Id: <20210603103814.95177-1-manivannan.sadhasivam@linaro.org>
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

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 144 ++++
 MAINTAINERS                                   |  10 +-
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 780 ++++++++++++++++++
 5 files changed, 944 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-ep.c

-- 
2.25.1

