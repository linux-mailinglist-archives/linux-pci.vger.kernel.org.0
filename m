Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 891B716AC7C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 17:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgBXQ7I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 11:59:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35574 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgBXQ7F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 11:59:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id b17so71280wmb.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 08:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=scmbAO6wzrt+IWcheRPZehqNHYX56WQHidyo5gafnSg=;
        b=lTdy9mhOFPsmoLMiWYWzUPwO5/L1ZW/zHrw5WHhTOGFGqo0qp1pO1XqXgivCA5tu8f
         4WQQor5LDVG67jiip5XJXjVu0KBJp/48upaRAm3sUJkDdX8PI8Y/dZ2sqayP4YFM7Lth
         M6NG+tFPUc0L24XYFzihuldbhJ9jKoGp/GZFOaf6/CoDo5RnB+s36ZN5IY188JGQYAua
         D1Q+Xkpfkhq1pefdMw0+/huUWPOh1m1Yli+CU0oFvjD/jwECwDIQHByH5vst8JzbuY8K
         pPjJqk1eTJaZLDapQ2r9fU/Bhlrc+tTo4251aNoGDPfuLR/VY5I8Ze3QoL1+aHlvUZRj
         ecdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=scmbAO6wzrt+IWcheRPZehqNHYX56WQHidyo5gafnSg=;
        b=pxTy+LHJxCdAk4ujWUum85+K9Bubz4NQQb1E0kRil1yQAgiIBstyRs851Exsd3/pRI
         B1Q9vL4CdeSWRkwGlvKootv9wihuALXv9mADMWB4YyVfQefiRL9rqLisjpQsMS19X3vV
         8Gjoa6uzFCuE/Cojf6OsOJhMnAa9dUKnDAsnF+mKHea+Omj55H2Yl2k2SWKFCBbGxDmX
         WpCgpysEKE6ZQGrs3xi7n6AnF8b5UMUAODVK7qRsXezsZDSlWnG/lL9WEEjXylmPi6fW
         dy9qnaMomsARX/TcyA9pt+gUGLrboL7M2QwZqXCNMG7UHI0bnNEXzRdk2XwnfAp4ZFwf
         exBQ==
X-Gm-Message-State: APjAAAUTm3kYr2xF8AaBbNqq+2ubhrBewCyTQ9PIGn+lI7H72gh+gnAb
        +1+hDzRX4Nt4/qEjGYSZgaz2629kZoU=
X-Google-Smtp-Source: APXvYqxpXn2k4aIHPUjRRSjdhBRuWiMSxycEwYczmhlVZO7EaXRfsvHlrCGZTCB+GlB0NKSXYk0O+w==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr22387669wma.81.1582563542078;
        Mon, 24 Feb 2020 08:59:02 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id b10sm19473978wrt.90.2020.02.24.08.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 08:59:01 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, will@kernel.org,
        bhelgaas@google.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org, robh@kernel.org
Subject: [PATCH v2 0/6] iommu/arm-smmu-v3: Finish PASID support and command queue batching
Date:   Mon, 24 Feb 2020 17:58:40 +0100
Message-Id: <20200224165846.345993-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Finish off PASID support for SMMUv3, and batch command queue.

Since v1 [1]:
* Added patch 4 to factor command queue batching
* Included patch 6 from Rob [2]

[1] https://lore.kernel.org/linux-iommu/20200213101435.229932-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-iommu/20200213205600.19690-1-robh@kernel.org/

Jean-Philippe Brucker (5):
  PCI/ATS: Export symbols of PASID functions
  iommu/arm-smmu-v3: Add support for PCI PASID
  iommu/arm-smmu-v3: Write level-1 descriptors atomically
  iommu/arm-smmu-v3: Add command queue batching helpers
  iommu/arm-smmu-v3: Batch context descriptor invalidation

Rob Herring (1):
  iommu/arm-smmu-v3: Batch ATC invalidation commands

 drivers/iommu/arm-smmu-v3.c | 139 ++++++++++++++++++++++++++++--------
 drivers/pci/ats.c           |   4 ++
 2 files changed, 115 insertions(+), 28 deletions(-)

-- 
2.25.0

