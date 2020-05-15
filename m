Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5471D4B51
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 12:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgEOKs3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 06:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgEOKs2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2020 06:48:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8ECC061A0C
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2020 03:48:28 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n5so2159464wmd.0
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2020 03:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpC2phLyyYKF8S2b2HVZs4m4/FDmGsrLmfDUKIq2+XU=;
        b=UTrbu7phaIKvcCKf/Ve9t6teHJmN3bXqWH26QoPA9XW9/eFXVzFMnJd7yXk/ufGYO6
         LG4QvKt9zY+sCvKwdmFzBcalHGa3Rbh1I1KJPJBZ2uxo7jWJ45R6JaMa6XWdcV/GOPKP
         tUYFz3NcWw50UGDz+eyN8vwJ441gSD7aTICtNuV9th4D1crstiW7bfxp9T2fVw7fQuVW
         zm6HtX5EFTwISIAY11pWVRaYj/uaKucP/T7x4kzyFwdv+lmzX80pD+xcYCNelol9g+bb
         h3RQo4K/F8AKExBgzpfQ36PTd1yfEVOKckHXo+e1DxxLcKzCzGN0U7DFyoS7T3y4oQTB
         GuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpC2phLyyYKF8S2b2HVZs4m4/FDmGsrLmfDUKIq2+XU=;
        b=ukFvNnMnjDP+sx115eqLsAwgfSbpqEVspU8dES2tYMNPXogMevXcJVwxXFs4BMZhOv
         CguSIbfVz+vWs7pWhM/SOg63dtWxJX9amjWoqTXWQMfIK/AC97UR/UOMhYTpVuO1A9CA
         3dg7isGSDdgXix/eIQqRlVMPfj6+nljBmDOi/p0eoHnAkl6pddo5HpRb0RphPYIUyWvm
         4PYe8h7UuDoxaU5wV7JSd265Z8KVPA5DRrTFD8Qll5TpBieumnRoYMZZfbbVz1TfJQTZ
         YmlruuuDhmnKZTOoVh4TEz32ilS1GbJDSjc1bi5618oNiqQ/wLe1lUDROCSNxyop3zhZ
         Vyvg==
X-Gm-Message-State: AOAM531vL8rgIrrbJ5ZPpqRAXklP/cZx0CERuCYkNu384eH1p821SowS
        /Q2ukjRQ2E/NTFKGjd149gPRVXynxBw=
X-Google-Smtp-Source: ABdhPJzpE90JsHWFWmiq3DLTcslPe1cuELNW3ZN0iUxPcNk8zGAYa3lMkhSlVxo89SFkbP4lE1f/Ig==
X-Received: by 2002:a1c:6706:: with SMTP id b6mr3116259wmc.54.1589539706443;
        Fri, 15 May 2020 03:48:26 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id h27sm3510392wrc.46.2020.05.15.03.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:48:25 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com
Cc:     will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 0/4] PCI, iommu: Factor 'untrusted' check for ATS enablement
Date:   Fri, 15 May 2020 12:43:58 +0200
Message-Id: <20200515104359.1178606-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I sent these in March as part of ATS enablement for device-tree [1], but
haven't found the time to address the largest comment on that series
about consolidating the root bridge ATS support between the different
ACPI tables.

I'm resending only the bits that consolidate the 'untrusted' check for
ATS, since there have been more discussions about this [2]. Patch 1
moves the 'untrusted' check to drivers/pci/ats.c and patches 2-4 modify
the ATS-capable IOMMU drivers.

The only functional change should be to the AMD IOMMU driver. With this
change all IOMMU drivers block 'Translated' PCIe transactions and
Translation Requests from untrusted devices.

[1] https://lore.kernel.org/linux-iommu/20200311124506.208376-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-pci/20200513151929.GA38418@bjorn-Precision-5520/

Jean-Philippe Brucker (4):
  PCI/ATS: Only enable ATS for trusted devices
  iommu/amd: Use pci_ats_supported()
  iommu/arm-smmu-v3: Use pci_ats_supported()
  iommu/vt-d: Use pci_ats_supported()

 include/linux/pci-ats.h     |  3 +++
 drivers/iommu/amd_iommu.c   | 12 ++++--------
 drivers/iommu/arm-smmu-v3.c | 20 +++++---------------
 drivers/iommu/intel-iommu.c |  9 +++------
 drivers/pci/ats.c           | 18 +++++++++++++++++-
 5 files changed, 32 insertions(+), 30 deletions(-)

-- 
2.26.2

