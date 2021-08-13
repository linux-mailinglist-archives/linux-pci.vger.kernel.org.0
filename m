Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D693EAF04
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 05:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbhHMD5O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 23:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbhHMD5O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 23:57:14 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79104C061756;
        Thu, 12 Aug 2021 20:56:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so9914816pje.0;
        Thu, 12 Aug 2021 20:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hOydTfRsWf5FkWMj8BE6lR9D+1scpczz/SuhDex9Szc=;
        b=TZCq2I6YftrR2zFRyuTUnA2aQWQmDMgnQbXraUtcBSUi2WDMzUoQB1LBCVQMMrGgyO
         dcbo0Z3dDocwN6BQWOhY9xCh4/Ukukt8Q9eY/6kfIZ8aSrqudSunc8owyoRdWBUbYnUn
         +xRCZujfuboQGwbS+OTo4wjelxJPY4m3Hqfte7MmjoRI9IFzbkVAYi4UVBfkBNPDlvi4
         /bjhhSkBg+whKuPGSxcLovZIB8aKz1nvGqzebS929DGLaDzw3F0g/4DuqOnFUSoIj5p5
         78hLHEEWOaflcqbhyz+35JxOuqkPG1fgbQ3WTGzSFB60kyrWoKFfJrMKwMbRc0SrU2sc
         5Wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hOydTfRsWf5FkWMj8BE6lR9D+1scpczz/SuhDex9Szc=;
        b=KiH3Javdx1wyo5l/N6947Fy7hgICFObckE4q9jd49EFAwgIS4QI2Y9JTGiwteI+WYv
         Q2LNroZHeqzlGKvLu3CZqSZomzJLh5wpdfp8TnRanTbN1tApYNp4QMOU+wDQ8m88GMeT
         aMeHdLnJw9kTOsQDn8zPjXgaO6fPec58Q5UXIQRXUAcSRbl9VFsQIYx3BjqGdXYub1Fj
         jTndX/YLvN6wmQJKx2OFRVm83RJWMcFt3QChJ+l/O769XSeykWcD23+PrULG3D+s4ZRB
         typD8BeMJXHl/oG49Sj6BHeVsV3UzDlqftvaOVIm8pETvl6Ic7wV+GPbJLNqsHLbjrbF
         tqoA==
X-Gm-Message-State: AOAM531qEiEU2MYsU/kltlXhiX7YMe/glIoVw1v/P9kBU1JpDsPVpTuf
        RR08MQ/7rWl+P5pR5Xnms3BXpnnm9FfHsPUn
X-Google-Smtp-Source: ABdhPJyroy/GdDpliyBkGamzjHV8RSK+9Q8AJF1ksOeutmz7JIzbP8+ARJzj8FUgtYkQbymIhd6cxg==
X-Received: by 2002:a65:6288:: with SMTP id f8mr423662pgv.81.1628827007619;
        Thu, 12 Aug 2021 20:56:47 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:f39c:9aee:21bf:36f5])
        by smtp.gmail.com with ESMTPSA id n25sm297791pfa.26.2021.08.12.20.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 20:56:46 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de
Cc:     bhelgaas@google.com, dwmw@amazon.co.uk, gregkh@linuxfoundation.org,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        lorenzo.pieralisi@arm.com, rafael@kernel.org, robin.murphy@arm.com,
        song.bao.hua@hisilicon.com, will@kernel.org
Subject: [PATCH v3 0/2] msi: extend msi_irqs sysfs entries to platform devices
Date:   Fri, 13 Aug 2021 15:56:26 +1200
Message-Id: <20210813035628.6844-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

-v3:
  added Acked-by of Greg Kroah-Hartman and Bjorn Helgaas, thanks!
  refined commit log with respect to Bjorn's comments

  Hi Thomas & Marc,
  Would you please handle this series? Thanks!

-v2:
  extract common code for msi_irqs sysfs populate/destory from PCI to MSI core,
  platform_device can directly reuse common code;
  https://lore.kernel.org/lkml/20210812105341.51657-1-21cnbao@gmail.com/

-v1:
  https://lore.kernel.org/lkml/20210811105020.12980-1-song.bao.hua@hisilicon.com/

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

Barry Song (2):
  genirq/msi: Extract common sysfs populate entries to MSI core from PCI
  platform-msi: Add ABI to show msi_irqs of platform devices

 Documentation/ABI/testing/sysfs-bus-platform |  14 +++
 drivers/base/platform-msi.c                  |  10 ++
 drivers/pci/msi.c                            | 124 ++-----------------------
 include/linux/msi.h                          |   4 +
 kernel/irq/msi.c                             | 134 +++++++++++++++++++++++++++
 5 files changed, 171 insertions(+), 115 deletions(-)

-- 
1.8.3.1

