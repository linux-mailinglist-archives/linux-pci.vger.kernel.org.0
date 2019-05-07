Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4210116C02
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 22:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfEGUMw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 16:12:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35639 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfEGUMw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 16:12:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so201137wmd.0
        for <linux-pci@vger.kernel.org>; Tue, 07 May 2019 13:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nKyf6025ESUlz44iZjTU3xgvh1d2L7dl/tSUxUygF54=;
        b=jxUWPsa/nwhQMD1Up0ro9gYVLBTsB69QCBtelpvkkHH/U4WltTqU+TeW2ReEvy8q9q
         sX0kyRBTwNnL7SwllYk6023asNEv2PsMkCFs5l0dCatWIrbjQ3J4hwmw1BHP42EoFyc/
         Av29i9t7RJo6BF7qUggdx3GWTUW60la8w1M29FIrSF0INObmExX23zsEPiewVq04DvJR
         uH3DkpQbixgNOTvmYUh3GIrQOZ2pJRgr4LHyg3+6zTLz8EC+SqY0l2J/X6MDzhKsx7P9
         AoeO11RsKV0sVD+CWvKhdWnt64EfN4aLxKEiKaxtHZFa6o4sHMnT2rgEeYHc/2eUirp3
         5EbQ==
X-Gm-Message-State: APjAAAX5Ta5vDvrh9/xFb8ZxwzkXCRWHZXd1aCgRe1uPHLb4eVnn4x9y
        dVX3ASm+sZAuKmnPRlOqKctPtA==
X-Google-Smtp-Source: APXvYqwZRrRSjcME6wz3K5cp6UgzFBiTNBrzm2raKXWh189lYmXlU/yFHjMwGfGrR5YMDOa7yLG/1A==
X-Received: by 2002:a1c:ce:: with SMTP id 197mr129846wma.105.1557259970785;
        Tue, 07 May 2019 13:12:50 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:ac7d:46be:871b:a956])
        by smtp.gmail.com with ESMTPSA id c10sm31816882wrd.69.2019.05.07.13.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 13:12:49 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Lyude Paul <lyude@redhat.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v2 0/4] Potential fix for runpm issues on various laptops
Date:   Tue,  7 May 2019 22:12:41 +0200
Message-Id: <20190507201245.9295-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CCing linux-pci and Bjorn Helgaas. Maybe we could get better insights on
how a reasonable fix would look like.

Anyway, to me this entire issue looks like something which has to be fixed
on a PCI level instead of inside a driver, so it makes sense to ask the
pci folks if they have any better suggestions.

Original cover letter:
While investigating the runpm issues on my GP107 I noticed that something
inside devinit makes runpm break. If Nouveau loads up to the point right
before doing devinit, runpm works without any issues, if devinit is ran,
not anymore.

Out of curiousity I even tried to "bisect" devinit by not running it on
vbios provided signed PMU image, but on the devinit parser we have inside
Nouveau.
Allthough this one isn't as feature complete as the vbios one, I was able
to reproduce the runpm issues as well. From that point I was able to only
run a certain amount of commands until I got to some PCIe initialization
code inside devinit which trigger those runpm issues.

Devinit on my GPU was changing the PCIe link from 8.0 to 2.5, reversing
that on the fini path makes runpm work again.

There are a few other things going on, but with my limited knowledge about
PCIe in general, the change in the link speed sounded like it could cause
issues on resume if the controller and the device disagree on the actual
link.

Maybe this is just a bug within the PCI subsystem inside linux instead and
the controller has to be forced to do _something_?

Anyway, with this runpm seems to work nicely on my machine. Secure booting
the gr (even with my workaround applied I need anyway) might fail after
the GPU got runtime resumed though...

Karol Herbst (4):
  drm: don't set the pci power state if the pci subsystem handles the
    ACPI bits
  pci: enable pcie link changes for pascal
  pci: add nvkm_pcie_get_speed
  pci: save the boot pcie link speed and restore it on fini

 drm/nouveau/include/nvkm/subdev/pci.h |  6 +++--
 drm/nouveau/nouveau_acpi.c            |  7 +++++-
 drm/nouveau/nouveau_acpi.h            |  2 ++
 drm/nouveau/nouveau_drm.c             | 14 +++++++++---
 drm/nouveau/nouveau_drv.h             |  2 ++
 drm/nouveau/nvkm/subdev/pci/base.c    |  9 ++++++--
 drm/nouveau/nvkm/subdev/pci/gk104.c   |  8 +++----
 drm/nouveau/nvkm/subdev/pci/gp100.c   | 10 +++++++++
 drm/nouveau/nvkm/subdev/pci/pcie.c    | 32 +++++++++++++++++++++++----
 drm/nouveau/nvkm/subdev/pci/priv.h    |  7 ++++++
 10 files changed, 81 insertions(+), 16 deletions(-)

-- 
2.21.0

