Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E713778FB
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 00:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhEIWWG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 May 2021 18:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhEIWWF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 May 2021 18:22:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BCFC061573
        for <linux-pci@vger.kernel.org>; Sun,  9 May 2021 15:21:02 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x2so20479335lff.10
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=06UDRhTVQGenT2r+cwM7MdBOZw0vEgUxmfuu+7CAgyE=;
        b=jjlQri4dxGQN8CT+gi4r4UwKPXgO7frK71gLoos/GqLkp25wyLM4XhN05IyicmqQ4e
         kKe5zZZ2aI3BJJMmFb8Pcy2cn1kMPIe7Cc67qtmT46jgmJblFNl2ScAl/EWlygtJX/n9
         JAaMrHzVRxjnlhfbeL+agTvb7lHZz5O7ZwGwNd+uxuZmJchCKxdp9HRpZ/5O/d4rdUiP
         +5WF4ZY4hwL6St8viOCchA45eDhmyqj4gxXRWz8Jik9xdxP3QcdP/EuahX67tjx/E9vJ
         FuWtrA5ZMe4AaPdK1QjpqcB6+KNWyo8lfcf/Zo4SaUyplK3FQf9pJw0C6ZGmGg4ml6yo
         1P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=06UDRhTVQGenT2r+cwM7MdBOZw0vEgUxmfuu+7CAgyE=;
        b=SpuTvMKpiOepFLarqygVyUiio3g2jEH5TmURdBSIHmrB5l/89cVHkyUpWe0SUFRTfh
         OzH5MaOAV0ov5pGfN1sfnMxip/FFDSwEHKc5S+0p4Awp91sZEWhQtw1773DJFvDMq/WF
         Q4sUYnHbFWeBGiVYkAC7GnCn9EiVHW2GHm14VHCKwYqcMbfQtg70Fr1bnmgX7ohIixM9
         SENyslX/BbXxN5UkylFkdanOgkEDk9R/jCpERwObp1uQ5fCM9pVkoTLwBM8wxa7exJ9n
         +8wVM5fGYeECzHx/PK3M86eWDtkTDfjF/p0ugNUWUhyI0N6QsE74iKGW8z0I67sZFbRq
         CCHA==
X-Gm-Message-State: AOAM533XoIdz4ed5c6/QZtvKXTWU4/a8mNZSpvkuPSVwl8+KCbBX+t1J
        HhoOJs6342G8+DLuWiJcpedVHA==
X-Google-Smtp-Source: ABdhPJxL6EiKIuL3mRgX3JPOCHXoI/WQqrzPhqGztGMqhSHZIhFcRK9U3VnHP+tF1bcUXadixTOgHA==
X-Received: by 2002:ac2:43ce:: with SMTP id u14mr14834083lfl.439.1620598860553;
        Sun, 09 May 2021 15:21:00 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u12sm2978012ljo.82.2021.05.09.15.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 15:21:00 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/4 v3] IXP4xx PCI rework
Date:   Mon, 10 May 2021 00:20:51 +0200
Message-Id: <20210509222055.341945-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.30.2
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

Changes from v2->v3:
- Fix bindings according to Rob's comments
- Fix a double assignment in the driver

Changes from v1->v2:
- Address Arnds comments
- Address build errors

Linus Walleij (4):
  ARM/ixp4xx: Move the virtual IObases
  ARM/ixp4xx: Make NEED_MACH_IO_H optional
  PCI: ixp4xx: Add device tree bindings for IXP4xx
  PCI: ixp4xx: Add a new driver for IXP4xx

 .../bindings/pci/intel,ixp4xx-pci.yaml        | 100 +++
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
 drivers/pci/controller/Kconfig                |   8 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pci-ixp4xx.c           | 705 ++++++++++++++++++
 drivers/soc/ixp4xx/ixp4xx-npe.c               |   2 +
 drivers/soc/ixp4xx/ixp4xx-qmgr.c              |   2 +
 18 files changed, 864 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
 create mode 100644 drivers/pci/controller/pci-ixp4xx.c

-- 
2.30.2

