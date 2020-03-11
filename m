Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A891818A9
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 13:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgCKMrK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 08:47:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38441 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgCKMq4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 08:46:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id t11so2450535wrw.5
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2020 05:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aHr7/EWopa+d5MVT7UWPgRiU9Syfo6iTheTFisLSBg=;
        b=FXsN33JoJealTXC3dRRue6HkzhWSIRjvlNRUP49llb/Tp1/P6LLbWK2WENByBzb932
         Vi1Fg8Ri+qgxJrwy5zjp/NXrbWtEhuMkRTQj1X4R9I44S53W3vZuVYp8IrCbYVblbQ3t
         O28JXtBnjgkZqXtJcIVINkr/xuwcmJ4AcO+2ctUVBEJKMuSZEV7wYUoSaD3Zco3ZO7q/
         ujjg+wfK4m1DiebSFJn9cbZqflg/q7DAWj/98GahfRpw7xqn470ERyL3IPCqRQQaQIB0
         0zSlrkdrriSBVsPOQ4i+h5gPOwW+U83Jz9SjjpEDyMiKdpx/YTRM4O6K6sHqODrD7YCC
         shxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aHr7/EWopa+d5MVT7UWPgRiU9Syfo6iTheTFisLSBg=;
        b=mfV6QWN3eUQhniqg0FARY7W97Cw89lLVpmuE/QQQ6VO1u88T5cadtMoVyyaiaRT5Li
         bKE26u4o0rbCiOevnDnxVTysEWLD4DMI9HAvnIU5lDAcEjpAp1Gg6ExHrG/YDobUArcp
         JDpCw8yJPqdaFIjdqaFhygHgngUlnlyeDFc7nWi/+9kJaOhI/hw9AI4be5NChDljG4CY
         I6KfA9zI3+k+Ljy4Us/vvzXOoayWFAMl5xnU/Afmm5xlYF4sdDHplC9cRtRaaTjA3TEN
         YYOnzHTRj+cdcXwj0KhRr5ZjTw6bSHWEuJPzB2+oVLPNqLLCZ6do8xlueZRs0mUWu3Nn
         OLZg==
X-Gm-Message-State: ANhLgQ0SKxc5cMtTOvg5eFTnw8WvKNHcXbFcBwSL6Kt7AGHIVY2epl4a
        mpb2ofwTb0EVi23htOplveFf+A==
X-Google-Smtp-Source: ADFU+vvLjmlfZFee1kgQb0ezvJQIIb3y7DZjOUpYxqDYvVtYVhI9wjUkV+NDFpgxKBOntX41muaOsw==
X-Received: by 2002:adf:bb81:: with SMTP id q1mr4344011wrg.110.1583930814354;
        Wed, 11 Mar 2020 05:46:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c2sm8380020wma.39.2020.03.11.05.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:46:53 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        joro@8bytes.org, baolu.lu@linux.intel.com, sudeep.holla@arm.com,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     lorenzo.pieralisi@arm.com, corbet@lwn.net, mark.rutland@arm.com,
        liviu.dudau@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 00/11] PCI/ATS: Device-tree support and other improvements
Date:   Wed, 11 Mar 2020 13:44:55 +0100
Message-Id: <20200311124506.208376-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable ATS on device-tree based systems, and factor the common ATS
enablement checks into pci_enable_ats().

Since v1 [1] I added acks and review tags, simplified patch 3 and tried
to clarify the comment in patch 2.

I'd like acks or comments on the following patches:
* PCI on patches 2, 3 and 5
* Arm SMMUv3 on patch 7
* Intel VT-d on patch 8
* arm64 DT on patch 10 

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/20200213165049.508908-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (11):
  dt-bindings: PCI: generic: Add ats-supported property
  PCI: Add ats_supported host bridge flag
  PCI: OF: Check whether the host bridge supports ATS
  ACPI/IORT: Check ATS capability in root complex node
  PCI/ATS: Gather checks into pci_ats_supported()
  iommu/amd: Use pci_ats_supported()
  iommu/arm-smmu-v3: Use pci_ats_supported()
  iommu/vt-d: Use pci_ats_supported()
  ACPI/IORT: Drop ATS fwspec flag
  arm64: dts: fast models: Enable PCIe ATS for Base RevC FVP
  Documentation: Generalize the "pci=noats" boot parameter

 .../admin-guide/kernel-parameters.txt         |  4 +-
 .../bindings/pci/host-generic-pci.yaml        |  6 +++
 arch/arm64/boot/dts/arm/fvp-base-revc.dts     |  1 +
 drivers/acpi/arm64/iort.c                     | 38 +++++++++++++------
 drivers/acpi/pci_root.c                       |  3 ++
 drivers/iommu/amd_iommu.c                     | 12 ++----
 drivers/iommu/arm-smmu-v3.c                   | 18 ++-------
 drivers/iommu/intel-iommu.c                   |  9 ++---
 drivers/pci/ats.c                             | 30 ++++++++++++++-
 drivers/pci/controller/pci-host-common.c      | 11 ++++++
 drivers/pci/probe.c                           |  8 ++++
 include/linux/acpi_iort.h                     |  8 ++++
 include/linux/iommu.h                         |  4 --
 include/linux/pci-ats.h                       |  3 ++
 include/linux/pci.h                           |  1 +
 15 files changed, 109 insertions(+), 47 deletions(-)

-- 
2.25.1

