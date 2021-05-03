Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42A937224F
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 23:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhECVRs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 17:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhECVRr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 17:17:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45C3C061573
        for <linux-pci@vger.kernel.org>; Mon,  3 May 2021 14:16:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z9so5671222lfu.8
        for <linux-pci@vger.kernel.org>; Mon, 03 May 2021 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cgEcrLG6Tv3NyXnRkNQXuoY43NfQ4p5xaxIzZuye7xE=;
        b=nZ3zICIA7TDF7qpQcKJ11Ki/5Exvc6RpaIoyYXZ+Yb9u44ufTP/F20loqGYPbxGR+C
         0T0aYuQ7Wt1FqhPrMlM3Bt/qz3HiajNfGKFqBq1UflR5mecNcrPwEbmCglpZ6hZxMUes
         +5ibdJ++8ERbXLs0sPuBku772fRrvnkJVfqRSbPCvsiN5lUDYkU0DGG7VyrtqZ5fn+GH
         YvbLL67Rf+PoY/S8FpGMkGPvso/5PhQA+VLicUGot74yQOWZEWJQZTTwBjlIsC+hDRha
         3Mq8Uo+lkIKXFs7RbP8s6YP/glIHrPa+bKXv42avH3GL6kyzVuXE5j8xbnyWU0TIA4ey
         W35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cgEcrLG6Tv3NyXnRkNQXuoY43NfQ4p5xaxIzZuye7xE=;
        b=CTanc/iFuB06yMGEgvs0lvCrq3GJG+85ICjbxVmFPemcqPsttuUNtSi3eAEgu4Z8xr
         lEIwRCmXtSJkotyWbai0KYSjyYPZiy+IUbTIhM1hKKzH430n0lSQaaJoAyXm/uNGaFmS
         ccnx0Hy71z+n1f0wDApXxNhBPoNGx9IeTfFPcLUZfErPLsA2OZrRSioIpz2TuuAfbsOf
         BxMdyv7wI3wvlENTme3zpWeS7680NzyOTfn2uRK/d9Cn5cdvtYUQ2g/RK10pihrBJxUG
         5/aSx0FNAlZAdr5NoueAGPG8AUZ8BDEeaX9PESYxlxvEY75i0p7vEkteva/iXhAoFbWZ
         jvJA==
X-Gm-Message-State: AOAM532LvzY+IiYeEDupq7I0YYSCIyc+EBrSVrRnRlV4k9pXyDaMKLh8
        FzAxklmoirYUgBAkvkILuN1HEsI0o7YaPQ==
X-Google-Smtp-Source: ABdhPJwHxao6gbZUy6Sc2ryeaDIiNfFve2Z3YIO52fWjK+te93h7Dq3Irs2EvVgcKrqr29SIYv0/5w==
X-Received: by 2002:ac2:51ba:: with SMTP id f26mr11910297lfk.545.1620076612346;
        Mon, 03 May 2021 14:16:52 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m12sm67676lfb.72.2021.05.03.14.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 14:16:52 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/4] IXP4xx PCI rework
Date:   Mon,  3 May 2021 23:16:45 +0200
Message-Id: <20210503211649.4109334-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series reworks the IXP4xx PCI driver. The plan is the
following:

- Implement a new proper host controller that is just used
  when booting IXP4xx from device tree. (This patch series.)
- Delete all boardfiles.
- Delete the old PCI driver in arch/arm/mach-ixp4xx.
- Only device tree and proper PCI driver remains.

Linus Walleij (4):
  ARM/ixp4xx: Move the UART and exp bus virtbases
  ARM/ixp4xx: Make NEED_MACH_IO_H optional
  PCI: ixp4xx: Add device tree bindings for IXP4xx
  PCI: ixp4xx: Add a new driver for IXP4xx

 .../bindings/pci/intel,ixp4xx-pci.yaml        |  96 +++
 MAINTAINERS                                   |   6 +
 arch/arm/Kconfig                              |   3 +-
 arch/arm/Kconfig.debug                        |   4 +-
 arch/arm/mach-ixp4xx/Kconfig                  |  33 +-
 arch/arm/mach-ixp4xx/common.c                 |   1 -
 arch/arm/mach-ixp4xx/fsg-setup.c              |   1 +
 .../mach-ixp4xx/include/mach/ixp4xx-regs.h    |   7 +-
 arch/arm/mach-ixp4xx/ixp4xx-of.c              |   8 +-
 arch/arm/mach-ixp4xx/nas100d-setup.c          |   1 +
 arch/arm/mach-ixp4xx/nslu2-setup.c            |   1 +
 drivers/ata/pata_ixp4xx_cf.c                  |   1 +
 drivers/net/ethernet/xscale/ixp4xx_eth.c      |   1 +
 drivers/pci/controller/Kconfig                |   5 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pci-ixp4xx.c           | 684 ++++++++++++++++++
 drivers/soc/ixp4xx/ixp4xx-npe.c               |   2 +
 drivers/soc/ixp4xx/ixp4xx-qmgr.c              |   2 +
 18 files changed, 836 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
 create mode 100644 drivers/pci/controller/pci-ixp4xx.c

-- 
2.29.2

