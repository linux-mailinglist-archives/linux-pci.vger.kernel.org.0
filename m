Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53BE36FDA0
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 17:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhD3PWx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 11:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhD3PWx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 11:22:53 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26D9C06174A;
        Fri, 30 Apr 2021 08:22:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s22so28527317pgk.6;
        Fri, 30 Apr 2021 08:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=poX0jQnUQhk/AWMVNFRISSgK6EmCwe0MNgMyHC82XII=;
        b=CCd2idsJSI0zZznIi6jQkuNv6NT2ZOGhkKAhxxT7RhkX1tohE6I049n5PvJhISot71
         v7iuOgmfFQ0sOf/ekj41jebUFQAzBNgRgdwmQWQWhy9sgVyU6mlrtAAXMsMl/HcteIqx
         L7wGV1sZ77SH3rEd+d7peCrDcWfEiR2D0VE0Ou3k9AOK189dpfFWu8RjSIDE4CQ2Gy9q
         W9lArQBnmTBHg5Iak9VKk14CJhrXJv5OMEojdBMh78Vn/PB+V0u0qdeAME6zz6cNzBAc
         aw8Vq4c26N30p0sh7twWsXGCGSecTg+jOaUO/30aj3BwBaUa0ZIxve6uZQP+WFVwGqnS
         6e1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=poX0jQnUQhk/AWMVNFRISSgK6EmCwe0MNgMyHC82XII=;
        b=F11xOsPLcj1az0PsDCHFyFxJ4t6/cQ31toJglLBniumPFB9R9GIHbbADROzlmHf6uX
         DjGRcGFCbrR/7hKBCMOiqk+8O2MlDMdiNJyVbWlP9ulWgvLHARcIVF+U1FVRRoDcydqV
         8hq/H6gdhdl5M4YuGbzpOiKprZj60neJ54v0rFJXVvZ7swOPBFh9MM01fmRYAfGUrohN
         DhCm7Oi+vx2uzcwKEKZ97MUXqApq3jO+Wk9xnaIf+JFc9JtudHRCLMzHLpmqnM9MP+AK
         DKEbd43akY6grBWBvRdc8f6Wyqa0pGe0ZGhBz4F/tU6YeW7TCMzJbddFIEHlO6aLaTHE
         2zoQ==
X-Gm-Message-State: AOAM5332gZ8tdEwCbVW2GfA/q4as0pgva0380tojzKOM0I66F8GvfJ4e
        jjPm1U+HU/iKfD7eBk1ICxg=
X-Google-Smtp-Source: ABdhPJy4bYpCylHtfAMkcEImKNWx/yD0v+z4IVFEl4ZrDL5pZFkYJrA6dzm5Varx6Sw69FWCyStT7g==
X-Received: by 2002:a65:6855:: with SMTP id q21mr5223531pgt.131.1619796124576;
        Fri, 30 Apr 2021 08:22:04 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q128sm2543034pfb.67.2021.04.30.08.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:22:03 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        jim2101024@gmail.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 0/3] ata: ahci_brcm: Fix use of BCM7216 reset controller
Date:   Fri, 30 Apr 2021 11:21:53 -0400
Message-Id: <20210430152156.21162-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v6 -- Added new commit which adds a missing function to the reset API.
      This fixes 557acb3d2cd9 and should be destined for linux stable.

v5 -- Improved (I hope) commit description (Bjorn).
   -- Rnamed error labels (Krzyszt).
   -- Fixed typos.

v4 -- does not rely on a pending commit, unlike v3.

v3 -- discard commit from v2; instead rely on the new function
      reset_control_rearm provided in a recent commit [1] applied
      to reset/next.
   -- New commit to correct pcie-brcmstb.c usage of a reset controller
      to use reset/rearm verses deassert/assert.

v2 -- refactor rescal-reset driver to implement assert/deassert rather than
      reset because the reset call only fires once per lifetime and we need
      to reset after every resume from S2 or S3.
   -- Split the use of "ahci" and "rescal" controllers in separate fields
      to keep things simple.

v1 -- original

Jim Quinlan (3):
  reset: add missing empty function reset_control_rearm()
  ata: ahci_brcm: Fix use of BCM7216 reset controller
  PCI: brcmstb: Use reset/rearm instead of deassert/assert

 drivers/ata/ahci_brcm.c               | 46 +++++++++++++--------------
 drivers/pci/controller/pcie-brcmstb.c | 19 +++++++----
 include/linux/reset.h                 |  5 +++
 3 files changed, 41 insertions(+), 29 deletions(-)

-- 
2.17.1

