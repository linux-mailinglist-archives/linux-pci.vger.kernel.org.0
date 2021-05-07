Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACBD3763C5
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 12:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbhEGKbs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 06:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbhEGKbr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 May 2021 06:31:47 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E421AC061763
        for <linux-pci@vger.kernel.org>; Fri,  7 May 2021 03:30:46 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id w4so10911297ljw.9
        for <linux-pci@vger.kernel.org>; Fri, 07 May 2021 03:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zZlWv2eoYwu6FIictFnpaYayN+D3NB+SHpyAnN1tjs=;
        b=Z3QAViBpUgbTRwrjuqrIVAIfcUCK3JpYqWNL3yB1GMXej/+BF6R6ZikDY/tZyLrdtX
         d+gxJIJI9OncWJhu0ZxmjbFL0Oh2TcrC1Ys4JWg10mDRmgZD7LFm1hixQy56iZYqlKSo
         0wlHi3eliQ+AYsUizq2r0q53PIQevty3sL9cL/59jA1d9WUbuomLvcc+umPACj64Quth
         iup0vigoh2R/GX7PXqqHW1vZ9hgTj9wSFVa9h5HBW/3ZYy+qaTYTnNIv7xJ/ECjnf8oq
         79ZU62EV7x5mgB0fYWuZZdWCH3B9IXK8C5qvv2d4MkKMwtNcr0t4kRRv12AkHbJL7/vc
         AoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zZlWv2eoYwu6FIictFnpaYayN+D3NB+SHpyAnN1tjs=;
        b=lU57RK7rnFPAROidhn542KP8kQI+vaM0ACxiiW71O1uuVTy3gy+GwkdjiYYz/w3opm
         UmxHYesd4eZ1wal0+q0dXqIWV6jdwOtw85ZcD6e+nTPEP+ISIehwNjX+42ex9b8Vd0Kz
         SqKZa8+FrQP7qDoJ/zsVEln1ScQbg9cVwJ6gelEUV2ZnUU6A0kCXN1Hkm7LAKH4JoJHm
         XqL96Hr5Cx9/svxI3fLclSbOR+zSevdeQkEmXJDVG1do7SVb/dDpcxoSZ0mwoz+7h5Wj
         bxg2PgX98k2rN0KlQxz8coOmmPaR0VL0Ab++Fv+ONGL2t191QKrabrVlq1VvY009NNIZ
         HeEQ==
X-Gm-Message-State: AOAM5318b3j3egC4XiB9mB8hAiX/3Pr56cLQ+5G2Icje/ckWPyISyyvX
        z8280iRRRMH6oI8gpsSo7+rNIw==
X-Google-Smtp-Source: ABdhPJxDdUkpgEtFYbgsupZcHQAxMz7k1XDipW40W3YzAhHgXdx9GDkXvYPi56Lt+qyY2DwiBABUug==
X-Received: by 2002:a05:651c:1068:: with SMTP id y8mr7110889ljm.59.1620383445428;
        Fri, 07 May 2021 03:30:45 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id y7sm1314218lfb.62.2021.05.07.03.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 03:30:45 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/4 v2] IXP4xx PCI rework
Date:   Fri,  7 May 2021 12:30:36 +0200
Message-Id: <20210507103040.132562-1-linus.walleij@linaro.org>
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

Changes from v1->v2:
- Address Arnds comments
- Address build errors

Linus Walleij (4):
  ARM/ixp4xx: Move the virtual IObases
  ARM/ixp4xx: Make NEED_MACH_IO_H optional
  PCI: ixp4xx: Add device tree bindings for IXP4xx
  PCI: ixp4xx: Add a new driver for IXP4xx

 .../bindings/pci/intel,ixp4xx-pci.yaml        | 102 +++
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
 drivers/pci/controller/pci-ixp4xx.c           | 706 ++++++++++++++++++
 drivers/soc/ixp4xx/ixp4xx-npe.c               |   2 +
 drivers/soc/ixp4xx/ixp4xx-qmgr.c              |   2 +
 18 files changed, 867 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
 create mode 100644 drivers/pci/controller/pci-ixp4xx.c

-- 
2.30.2

