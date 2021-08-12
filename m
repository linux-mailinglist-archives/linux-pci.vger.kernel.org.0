Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D423EA327
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 12:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhHLKym (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 06:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbhHLKyl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 06:54:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782D8C061765;
        Thu, 12 Aug 2021 03:54:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w14so8701730pjh.5;
        Thu, 12 Aug 2021 03:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCXbaLZyAk42RWgMxpHdoCR+RmbVoLlnmRpT4XB1Zs0=;
        b=OXl36u7mUGRjrLqjsNMrUu/aSFE/HWV5G5ZUWIi3gUAh4V/Uj7o0dtNQLkHNoAlbvh
         g+eYvlrjVGMS/hq7JwC4+gbKBO4mUg5gJ0LZ0UgHnZrDSioeqvUZ9LASaolIh4WXXQ73
         bdzTfRaNKux/yL8kBiBZpj+lO4nXcP3TRQrHRAVlE+LzlBHw0qTzvpH2rglAGMxrFwIE
         ++luP571SbOdqpxN4jXkL8Mehq32mslAEXlADFMiFk328vPnmZoRlheLYLaXIIHFl28j
         4tsZYKjAyUW+bV61gXSAMuqVsNRmCDWLOuT3pUk40E1xWlh1VB6VGNYCoUYuV387SYeD
         Z7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCXbaLZyAk42RWgMxpHdoCR+RmbVoLlnmRpT4XB1Zs0=;
        b=kSFhlpc0lbEJk1CMCl4W0L9Oc7AiPOXaD3bjFXMfs0JOHoI4XIetsExkPDQaQtcwfR
         YH2Bg6XwtiiMmy8xr8g3/YVzbcao8wevPcYyIxwFKz3dd1J9hbVYSwMaWrMN4Fl/HM67
         GHifUSnjaEXPNrRb3RmsLHveShAF0nA8rn2BEvsEb5B6P0l7LlwjaWnbS7MiSG2OA4oY
         5Hcg3oRx8LUFaVEokdH8X2uiZEItW/T9lqmTjxkkWOczoeN6C9P9XEKbpEUXwfFL4jGL
         0XTr1TU7qgx1QVHFV+aYmmVsQiVTwaSY6U4+rKQ/pR2BIE27x52WipSFny46vTA1vfSK
         62dw==
X-Gm-Message-State: AOAM533qLKKpmgg03rC4jL0C3N26hxPMN7pSrHHk7PXBbRuNYSu3TvqW
        dlEuAXDDsZQGgeL/IciVuBs=
X-Google-Smtp-Source: ABdhPJwk3GRwrN27Su119B29DfpaU4Jt5FxZZYTT1kwDKcpIdN0ZZ+01KRiiUCo4i46IzAb/cZ3M4Q==
X-Received: by 2002:a65:5288:: with SMTP id y8mr3306317pgp.275.1628765656004;
        Thu, 12 Aug 2021 03:54:16 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:73b9:7bc0:297c:e850])
        by smtp.gmail.com with ESMTPSA id j16sm3070866pfi.165.2021.08.12.03.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 03:54:15 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
        maz@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linuxarm@huawei.com,
        robin.murphy@arm.com, will@kernel.org, lorenzo.pieralisi@arm.com,
        dwmw@amazon.co.uk, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2 0/2] msi: extend msi_irqs sysfs entries to platform devices
Date:   Thu, 12 Aug 2021 22:53:39 +1200
Message-Id: <20210812105341.51657-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

Just like pci devices have msi_irqs which can be used by userspace irq affinity
tools or applications to bind irqs, platform devices also widely support msi
irqs.
For platform devices, for example ARM SMMU, userspaces also care about its msi
irqs as applications can know the mapping between devices and irqs and then
make smarter decision on handling irq affinity. For example, for SVA mode,
it is better to pin io page fault to the numa node applications are running
on. Otherwise, io page fault will get a remote page from the node iopf happens
rather than from the node applications are running on.

The first patch extracts the sysfs populate/destory code from PCI to
MSI core. The 2nd patch lets platform-msi export msi_irqs entry so that
userspace can know the mapping between devices and irqs for platform
devices.

-v2:
  extract common code for msi_irqs sysfs populate/destory from PCI to MSI core,
  platform_device can directly reuse common code;

-v1:
  https://lore.kernel.org/lkml/20210811105020.12980-1-song.bao.hua@hisilicon.com/

Barry Song (2):
  genirq/msi: extract common sysfs populate entries to msi core from pci
  platform-msi: Add ABI to show msi_irqs of platform devices

 Documentation/ABI/testing/sysfs-bus-platform |  14 +++
 drivers/base/platform-msi.c                  |  10 ++
 drivers/pci/msi.c                            | 124 ++-----------------------
 include/linux/msi.h                          |   4 +
 kernel/irq/msi.c                             | 134 +++++++++++++++++++++++++++
 5 files changed, 171 insertions(+), 115 deletions(-)

-- 
1.8.3.1

