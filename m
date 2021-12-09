Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9577646F52B
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 21:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhLIUvG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 15:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhLIUvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 15:51:06 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93749C061746;
        Thu,  9 Dec 2021 12:47:32 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g16so6183671pgi.1;
        Thu, 09 Dec 2021 12:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=o36OcVX9L7eLvFsZYgQvL9nIHhtbTrJVafPXVJFttzI=;
        b=EvFvql7MpBWvp/CefTt46XcdvlSHzd9Do2EjU5AyumHQbSnSnOhDBpgkJ54qzhzwre
         l82OVNKHLzUa9npZlgRFO536zfFBFJOfoO/pMmpJ545Bi014mwtwAOyEKNmUb/5oY1XH
         meYglxSJC4ORz/3JpRNbX/mddrYhN5QWrGdY1SanPIEZsphY8cVm9HDW6cOWrEqaT1M+
         QmWXh4Z/5U999UvRjjkZhbb+483lsrNOWdYYs9FFzRJRSej7zaVqCvVy1rd9777K06VI
         uHqV9cD6fOHGKGOLeqd+ik/GDJP/rY8KucD9J6kEvEZs1daejx1Slnid79wQeVec48Bs
         ozgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o36OcVX9L7eLvFsZYgQvL9nIHhtbTrJVafPXVJFttzI=;
        b=fSpp3sD2RRPxCqZSSIii0TdV1hAqXXRnkZC4oQlK0sTN4tMkNUBPmmSqCmb423MQDt
         DvBMxT4Ujs107amcaMwqQwAsKPqJ0PnOXOi2cy5KExTxNEzmjhnankELizb4v4DCjofU
         ukVLGGtgr88pmJCJGM+ySPfmGW3tpyIP8EPIOqC7EV7XgZ97fuduHIWmta2P20ZwK+pc
         82dxCkHvNUHJMBQKQaV86bHNsMNuSdqnLtFNiLfgrjKrnHs2lp8hDSXLqSlahsuLkCB3
         oiU1xWGmrDJCtZ06veUC2TBIbXlwTZzx60+BAjzbxCYLvCdQQEk93HVBbqqxfE3+VMQ5
         Inag==
X-Gm-Message-State: AOAM533Ael4+TFOdo3iHaMmrH3ikVsuNjvyO4thS/AwnELtOBZZJCNzH
        s8z5EDYrN2WzOnKjlPh6J+WMm0qgZMU=
X-Google-Smtp-Source: ABdhPJzvkVwKpNpwtnIgaVSHV1aGVVpxmbZF8wLif7t67aUOW7Ugbaqc6I5ed9ngYBtQuBa1jN6Kzg==
X-Received: by 2002:a62:750e:0:b0:49f:a27d:62b3 with SMTP id q14-20020a62750e000000b0049fa27d62b3mr14030210pfc.37.1639082851868;
        Thu, 09 Dec 2021 12:47:31 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id f185sm568370pfg.39.2021.12.09.12.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:47:31 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE), Rob Herring <robh@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v1 0/4] PCI: brcmstb: Augment driver for MIPs SOCs
Date:   Thu,  9 Dec 2021 15:47:21 -0500
Message-Id: <20211209204726.6676-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With this patchset, the Broadcom STB PCIe controller driver 
supports Arm, Arm64, and now MIPs.

Jim Quinlan (4):
  dt-bindings: PCI: Add compatible string for Brcmstb 74[23]5 MIPs SOCs
  MIPS: bmips: Add support PCIe controller device nodes
  MIPS: bmips: Remove obsolete DMA mapping support
  PCI: brcmstb: Augment driver for MIPs SOCs

 .../bindings/pci/brcm,stb-pcie.yaml           |   2 +
 arch/mips/Kconfig                             |   1 -
 arch/mips/bmips/dma.c                         | 106 +-----------------
 arch/mips/boot/dts/brcm/bcm7425.dtsi          |  30 +++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi          |  30 +++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts      |   9 ++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts      |   9 ++
 drivers/pci/controller/Kconfig                |   2 +-
 drivers/pci/controller/pcie-brcmstb.c         |  82 +++++++++++++-
 9 files changed, 161 insertions(+), 110 deletions(-)


base-commit: ded746bfc94398d2ee9de315a187677b207b2004
prerequisite-patch-id: d47ce1906f7e175cc394be96f85a6eade86a9097
-- 
2.17.1

