Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B97117389
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 19:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfLISL6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 13:11:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37105 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLISL6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 13:11:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so17350756wru.4
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2019 10:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPZYuKzuHS01ypbpAypAPWL2i1nnzUw0mtei/SOU8FI=;
        b=eChG24HveCLJr1w7htcnEaSdvHwWYy3dopCe7PzKjFIohfKepun/JzeHDOVtJdhFBX
         krj9dCfZna5uDRah00TO6hMrC5CxJ839KjvhzTUWqxzJ0nzCKaHhF508qHSSy0GZtoSx
         KJKhRNuYym1oZf7HWKmhQjbPY2WwKkqcLV/aEZnMdOGhN7+MIwQiCiCZ6KKFGROEzZxL
         Htj1QWdRJqh6WeQx5GUmgHJil8TmhNhDhDAyvl7+sHEzB6M95GtfmZ/PLcNOaeZEdyGj
         IBWYXgi+wPjUJZNb7Xjum2/nBvekCA934r8JznZDGI55yX51UEARM1sRTsF7H8bRaJoC
         7XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPZYuKzuHS01ypbpAypAPWL2i1nnzUw0mtei/SOU8FI=;
        b=DAj1wrqCsx5uDbD30fXjPyZ1wWwz7H1mqpS4KLCmJ7aT6kvPDKmZthfXOtLYmjyyRv
         eNVWOOaXD9ERijGLZN4SyyWbAR1mSC75oTUQ4UYPCYJclefJAC5DL2foyw254S+1jAvo
         hLaXt3/SLJU95YnIFICzYUx4tc/Uze+SdArYfm50FrevHx/piGsGYE0wItHUVyLgkD5/
         jfWTnIuXQZY7jRNpaIi0NaF0YtH0S3u7oc46zQTcTnjgEEftMgQ4yJUKRCLzXtNCjZen
         z6RIHt4YRliZE9xgkJxXhpcXoUtnpA8PluMhcwdqay7XqIn5LCPqHU/BT7Ebm+IDZC8k
         DYgw==
X-Gm-Message-State: APjAAAWj8Mo+dtMYiGDQfDuRhb83TZSQWwr2L3zTizgXNgkvBK9CaGkf
        olhr0WkOKyUER0CSzXbmyawBabHS5oY=
X-Google-Smtp-Source: APXvYqzT1ymN3phudM5XMKZ/AIHs5aojcXL1B8J2G48oy5R7vLLmgXJx0GUEWH2l1syk1oV2bTStlA==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr3593884wrv.198.1575915116081;
        Mon, 09 Dec 2019 10:11:56 -0800 (PST)
Received: from localhost.localdomain (adsl-62-167-101-88.adslplus.ch. [62.167.101.88])
        by smtp.gmail.com with ESMTPSA id h2sm309838wrv.66.2019.12.09.10.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:11:55 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        eric.auger@redhat.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org
Subject: [PATCH v3 00/13] iommu: Add PASID support to Arm SMMUv3
Date:   Mon,  9 Dec 2019 19:05:01 +0100
Message-Id: <20191209180514.272727-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Substream ID and PASIDs to the SMMUv3 driver.
Changes since v2 [1]:

* Split preparatory work into patches 5, 6, 8 and 9.

* Added patch 1. Not strictly relevant, but since we're moving the DMA
  allocations and adding a new one, we might as well clean the flags
  first.

* Fixed a double free reported by Jonathan, and other small
  issues.

* Added patch 12. Upstream commit c6e9aefbf9db ("PCI/ATS: Remove unused
  PRI and PASID stubs") removed the unused PASID stubs. Since the SMMU
  driver can be built without PCI, the stubs are now needed.

[1] https://lore.kernel.org/linux-iommu/20191108152508.4039168-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (13):
  iommu/arm-smmu-v3: Drop __GFP_ZERO flag from DMA allocation
  dt-bindings: document PASID property for IOMMU masters
  iommu/arm-smmu-v3: Support platform SSID
  ACPI/IORT: Support PASID for platform devices
  iommu/arm-smmu-v3: Prepare arm_smmu_s1_cfg for SSID support
  iommu/arm-smmu-v3: Add context descriptor tables allocators
  iommu/arm-smmu-v3: Add support for Substream IDs
  iommu/arm-smmu-v3: Propate ssid_bits
  iommu/arm-smmu-v3: Handle failure of arm_smmu_write_ctx_desc()
  iommu/arm-smmu-v3: Add second level of context descriptor table
  iommu/arm-smmu-v3: Improve add_device() error handling
  PCI/ATS: Add PASID stubs
  iommu/arm-smmu-v3: Add support for PCI PASID

 .../devicetree/bindings/iommu/iommu.txt       |   6 +
 drivers/acpi/arm64/iort.c                     |  18 +
 drivers/iommu/arm-smmu-v3.c                   | 462 +++++++++++++++---
 drivers/iommu/of_iommu.c                      |   6 +-
 include/linux/iommu.h                         |   2 +
 include/linux/pci-ats.h                       |   3 +
 6 files changed, 437 insertions(+), 60 deletions(-)

-- 
2.24.0

