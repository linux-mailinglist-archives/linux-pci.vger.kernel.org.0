Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F00650891
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 09:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiLSIfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 03:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLSIfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 03:35:22 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246C895AB
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 00:35:21 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso5835579wmb.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 00:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QJNvWlx4hs2HzBNceRW3/M7eig4DdhugN3XpshYak/4=;
        b=vxew87ZC1wciAGea9e0EpXjGmJdmIIHDwsGA+WFKNonuRW+0xmvdaN1P9DrIXzIFlc
         UL1+upmwr7nSo83Ew9G4Bnuif1t+14rh1c//hwkQY7Ss/NstccMlKqJrDrmbCCHodWX/
         bwvMKywJKVVOMddNVmu6LmCVj7fOxe7R6Q9ZReasI6xScBXGDZWNZFo+ANKa2SQulXAO
         qzjpjmqWEqT4fyEevB4wVvm6s8tIYWX+a9sqbSMTNULIux9Qgv6nybjpWoOjlkeTffuR
         3aWjlHlMH0rPJBh6xUWZ12VHSGAHMopH2NfabBzukQBQEmzFgA/Jdjrj3iZK2lW065Zr
         huVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJNvWlx4hs2HzBNceRW3/M7eig4DdhugN3XpshYak/4=;
        b=eAhSZJcesDrobyMIZFoQzNl7lZ+oRgaoz6f55ClFPRw19YFjTB4kopZD/UndDubqkF
         4Flm5lyT/eJux6rrf2EGX3wvqElVtNV7IABl+47pKMmFEet1DbZ0V7LgVXcOWscF2ozB
         OzoTJ3uq4zQQCvDa950BWlAZ053NkOk/YddiDVRHFzD5LUxMeCRJLsuHCPYhIAEWYl7a
         l1xKTxNWsv5P6KJw0D/KQ878M8CKJdb4Q9MJui5H3RxomjnXuMNP8mX7PmU6gEFx6zjx
         ZPGGkPYuA94BpR/jZGXM/AIFOcKZA18a5ZTAK6UwsWGyCnakh6xeoZIBg4r+PVg2zVvn
         Werg==
X-Gm-Message-State: AFqh2koacOB1zH0tA0Fktqy/0cTfbWWv6wwvu4tzrjchfG+ZP0LyAJhg
        Aej5MCwLVS0pOZ18Y3fj5+CCqw==
X-Google-Smtp-Source: AMrXdXuPMXY4qJBry1TzKs47PEIklDEv++kof+LSyU3ukg70r+xBAV2/+gnOipHwdDp9j059uTPBAA==
X-Received: by 2002:a05:600c:4f83:b0:3d3:56ce:5673 with SMTP id n3-20020a05600c4f8300b003d356ce5673mr2597815wmq.6.1671438919611;
        Mon, 19 Dec 2022 00:35:19 -0800 (PST)
Received: from localhost.localdomain (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
        by smtp.gmail.com with ESMTPSA id z22-20020a05600c0a1600b003cfd0bd8c0asm11364246wmp.30.2022.12.19.00.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 00:35:18 -0800 (PST)
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
To:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: [RESEND PATCH 0/3] virtio: vdpa: new SolidNET DPU driver
Date:   Mon, 19 Dec 2022 10:35:08 +0200
Message-Id: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds a vDPA driver for SolidNET DPU.

Patch 1 adds SolidRun vendor id to pci_ids.
Patch 2 adds a pci quirk needed by the DPU.
Patch 3 has the driver source code.

Patch 1 is prerequisite for both patch 2 and patch 3.

Alvaro Karsz (3):
  Add SolidRun vendor id
  New PCI quirk for SolidRun SNET DPU.
  virtio: vdpa: new SolidNET DPU driver.

 MAINTAINERS                        |    4 +
 drivers/pci/quirks.c               |    8 +
 drivers/vdpa/Kconfig               |   10 +
 drivers/vdpa/Makefile              |    1 +
 drivers/vdpa/solidrun/Makefile     |    6 +
 drivers/vdpa/solidrun/snet_hwmon.c |  188 +++++
 drivers/vdpa/solidrun/snet_main.c  | 1111 ++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_vdpa.h  |  196 +++++
 include/linux/pci_ids.h            |    2 +
 9 files changed, 1526 insertions(+)
 create mode 100644 drivers/vdpa/solidrun/Makefile
 create mode 100644 drivers/vdpa/solidrun/snet_hwmon.c
 create mode 100644 drivers/vdpa/solidrun/snet_main.c
 create mode 100644 drivers/vdpa/solidrun/snet_vdpa.h

-- 
2.32.0

