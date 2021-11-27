Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FE545FF15
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245742AbhK0OT1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355251AbhK0OR0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:17:26 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357F9C061763
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:27 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i5so25194463wrb.2
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZeGEHAKfMbPXR1KcbmOU/2a8N0rO1GRkwrWVxl0aiQg=;
        b=gcSYaUwzjMwLMP3bKGNxML/5OfboqYPpZggkfRIAPteA8TS/CxqONSzMUiDG72CNPC
         /plyMk/py+hgr0ScuXJ1M2P5APY0Q8JTEbuAX44eYRXx+fHwM3tFUcVdFXLqBmsUcYeP
         fvt7vZ3yM+N2jXSBQX7rcHrT1B2llxLoce5TAkx96152MfdaLdcnpKoPpEm341CsihQn
         wi5q/aDGF31/GJy5G2KwwblBkPrMRP8Dv1A6JaOORVGeE6iiDEzRm/8HD5lJntPZYM+a
         4n6NLlqCfq1lqzJEOcFHEoOuA1bPPrwY4fvidlByJb8m3VrbuwVa1T72woO5h0CjgyNR
         0I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZeGEHAKfMbPXR1KcbmOU/2a8N0rO1GRkwrWVxl0aiQg=;
        b=X/So05YpSP7CBbPqtfBF4SKBV3OKuh0N+IfC0/o9A/VFM+f4vDj4qSfPS1qtYLZxkU
         5UH99ls3a76wYtkXn+jiBJB6ixEWxRUy+HvUtp6ckCTdM2vv18prmJYmuEK4KiKJZD5k
         U5klsHYWn6PmUg8MuDBRNiQghXaKYjwOWCVtyulFqZnreCSuog6jDUfAH5ddtZpEUwEY
         +EHr7cBpbcve2LT2ZKr9RLgohjMQ3VNgn1oKGeQqWEtoKVQxYfsaFL8iCVjshOGTv7HU
         /h5XG+wiMwjbhiyUetSSqXKQoEpy2Wd32q/gNqYvPFwVQ7yMELxlwobSih4M6BOyI8xj
         12IA==
X-Gm-Message-State: AOAM532953igRFmEkkL9QuCLdB+Naft9ZVi0/DOEqFQBV47az+ikEe09
        4UxZWTUtU9yd2aTsShFXxKY=
X-Google-Smtp-Source: ABdhPJz3JR+3GFMnwgGc//wlK0+gs4iSCW/wFpcUwHRCNjQJOtAhQ/EDm5AQltBrm479VWDFJfG84g==
X-Received: by 2002:adf:ce8b:: with SMTP id r11mr21063033wrn.294.1638022285592;
        Sat, 27 Nov 2021 06:11:25 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id q26sm8754522wrc.39.2021.11.27.06.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:11:25 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 00/13] Unify device * to platform_device *
Date:   Sat, 27 Nov 2021 15:11:08 +0100
Message-Id: <cover.1638022048.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCI controller structs contain "device *", while others contain
"platform_device *". These patches unify "device *dev" to 
"platform_device *pdev" in 13 controller struct, to make the controller 
struct more consistent. Consider that PCI controllers interact with 
platform_device directly, not device, to enumerate the controlled device.

Fan Fei (13):
  PCI: xilinx: Replace device * with platform_device *
  PCI: mediatek: Replace device * with platform_device *
  PCI: tegra: Replace device * with platform_device *
  PCI: xegene: Replace device * with platform_device *
  PCI: microchip: Replace device * with platform_device *
  PCI: brcmstb: Replace device * with platform_device *
  PCI: mediatek-gen3: Replace device * with platform_device *
  PCI: rcar-gen2: Replace device * with platform_device *
  PCI: ftpci100: Replace device * with platform_device *
  PCI: v3-semi: Replace device * with platform_device *
  PCI: ixp4xx: Replace device * with platform_device *
  PCI: xilinx-nwl: Replace device * with platform_device *
  PCI: rcar: Replace device * with platform_device *

 drivers/pci/controller/pci-ftpci100.c        |  15 +-
 drivers/pci/controller/pci-ixp4xx.c          |  47 ++--
 drivers/pci/controller/pci-rcar-gen2.c       |  10 +-
 drivers/pci/controller/pci-tegra.c           |  85 +++----
 drivers/pci/controller/pci-v3-semi.c         |  19 +-
 drivers/pci/controller/pci-xgene.c           | 222 +++++++++----------
 drivers/pci/controller/pcie-brcmstb.c        |  35 +--
 drivers/pci/controller/pcie-mediatek-gen3.c  |  36 +--
 drivers/pci/controller/pcie-mediatek.c       |  31 +--
 drivers/pci/controller/pcie-microchip-host.c |  18 +-
 drivers/pci/controller/pcie-rcar-ep.c        |  40 ++--
 drivers/pci/controller/pcie-rcar-host.c      |  27 +--
 drivers/pci/controller/pcie-rcar.h           |   2 +-
 drivers/pci/controller/pcie-xilinx-nwl.c     |  28 +--
 drivers/pci/controller/pcie-xilinx.c         |  21 +-
 15 files changed, 328 insertions(+), 308 deletions(-)

-- 
2.25.1

