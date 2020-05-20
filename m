Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AD01DB83D
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 17:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgETPct (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 11:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgETPcs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 11:32:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8CDC061A0E
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 08:32:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j5so3634899wrq.2
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rS3MgHL31zdXvs2YX1XoxnJ/QACnY+W7BlrTCAAllU0=;
        b=hY9oaplVLKnDyaWbfEcx3s8I1dfHkZlzlOwiaJuO2n+epmAgtp1JTI4feeUEaBrJs3
         6/revPgKuLi9A6H2mT3sQu0jH/eDEBa09OwTcwN4EXCM/I8T6ZO+o6nWqfcqE0u2+d1r
         cAPVjWmGEKC8LCbZd72iUB+DM7p0cQR0Vm9qPKqeXHgGu4T93KwE47r4s7cXKfaHSUPk
         /hJ5ngY4U+iINK6ZhPrINbx7+l9uHPvnjLKZk7iamIRNVZ3qLpxEUhj1zF5hW2KQZiT4
         ZFuGhyhRQW1or7xs+BQYyLhbHQJyub1sUSRRYeYGlATkrd9gA4Ff5irEJAVfzafwzR72
         PA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rS3MgHL31zdXvs2YX1XoxnJ/QACnY+W7BlrTCAAllU0=;
        b=o0rTIzQKdw5SBte/zopXv+QuNmQnZJl/kd1m06XA+cKNJHJvxaLyzyls6F3T/jOsGz
         fNQSj07NWYtWtYijrowDQ/UyhiB6aReYfR9ZgZylEJ6jYDBFvJ1SSDpEHfOo6PWe9e5S
         qvZPwaXuwKOHvKta+YUxI2UwlnJTIEkpECS87BuHVdCxb2S6QvNCFNIAPv6fDoa95JFl
         Ayon3T/bZJhwVQrqL+Y7hcWOtRpFY2TXG0ZSukCd5ZsUuL2ynaTFwRwoVRU+6ugC3CRX
         YIoZyzOFpxTHIo612Lq0gsTWNnfIx9feV+OdfPuWQ9r8MHcTOk9aL076H3iHtmNxBecH
         Uw0w==
X-Gm-Message-State: AOAM5314E66aRD5jpvtTm3DKs60Gc2i/r3dI2D1XyMdw5by8PQUJEpF8
        JhGQLObRfWRa65qoKG/GMEiHqUqcZvU=
X-Google-Smtp-Source: ABdhPJyH2SJWlWmAdD/I/XNWbNecG/p9BGtXgaK0Dlhtqu9Ep77NQ7dbbkvudTLDgN0b4pgGbvMpPg==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr4372203wrt.147.1589988766791;
        Wed, 20 May 2020 08:32:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 5sm3395840wmd.19.2020.05.20.08.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 08:32:45 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com
Cc:     will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 0/4] PCI, iommu: Factor 'untrusted' check for ATS enablement 
Date:   Wed, 20 May 2020 17:21:59 +0200
Message-Id: <20200520152201.3309416-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IOMMU drivers currently check themselves if a device is untrusted
(plugged into an external-facing port) before enabling ATS. Move the
check to drivers/pci. The only functional change should be to the AMD
IOMMU driver. With this change all IOMMU drivers block 'Translated' PCIe
transactions and Translation Requests from untrusted devices.

Since v1 [1] I added tags, addressed comments on patches 1 and 3, and
fixed a regression in patch 3.

[1] https://lore.kernel.org/linux-iommu/20200515104359.1178606-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (4):
  PCI/ATS: Only enable ATS for trusted devices
  iommu/amd: Use pci_ats_supported()
  iommu/arm-smmu-v3: Use pci_ats_supported()
  iommu/vt-d: Use pci_ats_supported()

 include/linux/pci-ats.h     |  3 +++
 drivers/iommu/amd_iommu.c   | 12 ++++--------
 drivers/iommu/arm-smmu-v3.c | 20 +++++++-------------
 drivers/iommu/intel-iommu.c |  9 +++------
 drivers/pci/ats.c           | 18 +++++++++++++++++-
 5 files changed, 34 insertions(+), 28 deletions(-)

-- 
2.26.2

