Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B911643C8A3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 13:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhJ0Lei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 07:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhJ0Leh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 07:34:37 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4701C061570;
        Wed, 27 Oct 2021 04:32:12 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id t201-20020a4a3ed2000000b002b8c98da3edso810125oot.8;
        Wed, 27 Oct 2021 04:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLuqEnTXe47rulVjhxN/gWoxn9OAXwjIoRJGGQuOV8g=;
        b=h8Z8RlLV8LM+pMediEGJWDOLVHznhnkpCSQuXO1FYmE45rAzSX/f863SQmiaeghzNa
         WhWV43HA6pPEupSoPRBFj9ifCmdlhY/P3Cc2D4ZyX3sOI/ZFFGJBlLAv71K/Tj1KD0Xz
         8pVVqz5qi8ZIiRTsoL4dr3uAN/lveNATuxj0d0Xn/cSS+HxMjRbeImLDEyjdkstOIKtV
         wZXuxmD++hsxEVivGZyst6WtMSs8bsMjEu6nX/h8FE1VrtcjuTcqS9nKPhfkxT/LUb7o
         ZcjL+UkELp0YyOa4FnseLXRCr7IKhTz1rA571q8XfyUGHcXx/780tH2R5AWiFliCKW3L
         NlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLuqEnTXe47rulVjhxN/gWoxn9OAXwjIoRJGGQuOV8g=;
        b=sR5ODlflnithXiChwukSNWE/IXStky7mzireIcnOC4gwoDPvs/QC4vIFU02svFoA92
         sOL5efb2ODRmKQ596K91OtNa2znUBopWDHQl8HglRdn4LUWwHeMYa0CLlM7PEub0RIPY
         swhKQIJvckDSTj8lfTLTIRDEkV3GKL2aTtGr2i4w770rxseUuxKBk/qMe+4yv1ZswyJb
         soIFHbstbb2EmwwEiiO8h2XLA/az/ZBlzLr6+RLeVfEctjpQaOnGkxE/AlGA0d/LSXjP
         mI4x/VI/zM0ITgiov5GoYXyBsvkFQJgQjuWKrZ9Ps0ot/8dSZ1NN4icVxg9Fy98Jv+gT
         e5dg==
X-Gm-Message-State: AOAM530NAhLhtceKG3YgI7I/btmriRQtBVx/A5f2z9UxubNcasi668uP
        rxm+tveJ+aXY1oqdezI4v1ahpTRBuyvUVQ==
X-Google-Smtp-Source: ABdhPJyYBY1m3ap3FTqF0Co+JOPNyvzi6NT3ywXO6Cyx7Bb7muZ84qjTwTFjt/pXvvyQN/ioacabnw==
X-Received: by 2002:a4a:e848:: with SMTP id j8mr3587427ooj.61.1635334331976;
        Wed, 27 Oct 2021 04:32:11 -0700 (PDT)
Received: from localhost.localdomain ([8.26.182.170])
        by smtp.gmail.com with ESMTPSA id e23sm5430106oih.40.2021.10.27.04.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 04:32:11 -0700 (PDT)
From:   Yanteng Si <siyanteng01@gmail.com>
X-Google-Original-From: Yanteng Si <siyanteng@loongson.cn>
To:     sergio.paracuellos@gmail.com
Cc:     Yanteng Si <siyanteng@loongson.cn>, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, chenhuacai@kernel.org,
        sterlingteng@gmail.com
Subject: [PATCH 0/2] drivers/mt7621: Fix build error ERROR: modpost:
Date:   Wed, 27 Oct 2021 19:31:38 +0800
Message-Id: <cover.1635333327.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
the MT7621 PCIe host controller driver is built as a module but no MODULE_*() attributes
were specified, causing a build error due to missing license information. At the same time,
modpost complains once these drivers become modules.

ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!

Let's just fix them.

Yanteng Si (2):
  PCI: mt7621: Add MODULE_* macros to MT7621 PCIe host controller driver
  PCI: mt7621: Export mips_cm/cpc/gcr_* to modules

 arch/mips/kernel/mips-cm.c           | 5 +++++
 arch/mips/kernel/mips-cpc.c          | 1 +
 drivers/pci/controller/pcie-mt7621.c | 2 ++
 3 files changed, 8 insertions(+)

-- 
2.27.0

