Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCEC64A334
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 15:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiLLOZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 09:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiLLOZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 09:25:13 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D7F1146F
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 06:25:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay40so5539543wmb.2
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 06:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/VkX0ZgY+XC31wIVV7Rqaaa4AmLATaZui7Ah2xDnRSU=;
        b=MdCDSlAeAfE4xBO1BOBln/d6leue6jP5BSnNKVUzPvIhMKjGAv7wKNJv/OAHnPXBao
         tGYmgfldh4pDjjPrKgSKb8HVfwT2UuzpDyWNh79KuzcHfVXdIcSgelPCCy7gwylvcLCh
         LheOd6KbTJJauO0qnbhXZNszNkBr66U0iwtWGwDJy5bQpmccdm3zHEy/e8S5GP86BBCr
         c+AnJa8I7jiLTnbYEvOg7D4p4D4BmFbXctugQYWUxRgDrIXY9q78fcbz3/NOz7IJFqJk
         +rvhTT0OpVqGmoHVD1Xn50CG693w0KEyhwL5Ysd/3hV6soqUN7d2JAFgbIZaNBllokOl
         pJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VkX0ZgY+XC31wIVV7Rqaaa4AmLATaZui7Ah2xDnRSU=;
        b=O64TtWcTuhQvVGum6ND9Nr99cty5Lket10MViGi7+ZDtGPoBsZ76n7W7Cv7S3E+eJg
         dsbDWBJSrAFUu+a6pVmPCAU+nq3SrDk5fatvPJMYkK5401HAnrvfrZ8iIOJ+0qTUambN
         rlgPZdCreHLE3VHxxEWuHOyR9wP1LhYPjSWD09twfHrtjdES1xAa6izolYCEOG6BKpa5
         vAcNKefRStCGKDn2tOl3FEQNdO3V7qsixrHYNlRfSmml4ytSmX/98J72lfgYAK5OXQ/Q
         WHuB0GSnS3q34O+wQOdTN16akxdRSB74d7gFtzvTJ/q5RR1tnA8qMQxMDLO8A+EKOgce
         yfVg==
X-Gm-Message-State: ANoB5plG9nEiTmhPY8hju744pu+1rrxugFyOCsYRydyWYFeG2/in9GVL
        O69QdjlDZqGgiTmOwZZMe5Fmy5BwIIyAlMEi
X-Google-Smtp-Source: AA0mqf7azZI79xLlzzwTkKfotuoktvz3SBud6DANHCbaRb2o6qqS5Mj0Ewhu77XzNgU4ftL3DIW7eQ==
X-Received: by 2002:a05:600c:3ac7:b0:3d0:7fee:8a70 with SMTP id d7-20020a05600c3ac700b003d07fee8a70mr12761565wms.19.1670855110537;
        Mon, 12 Dec 2022 06:25:10 -0800 (PST)
Received: from localhost.localdomain (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0a4100b003d1e3b1624dsm10662692wmq.2.2022.12.12.06.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 06:25:09 -0800 (PST)
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-pci@vger.kernel.org,
        Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: [PATCH 0/3] virtio: vdpa: new SolidNET DPU driver
Date:   Mon, 12 Dec 2022 16:24:51 +0200
Message-Id: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
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
 drivers/vdpa/Kconfig               |   11 +
 drivers/vdpa/Makefile              |    1 +
 drivers/vdpa/solidrun/Makefile     |    3 +
 drivers/vdpa/solidrun/snet_hwmon.c |  191 +++++
 drivers/vdpa/solidrun/snet_main.c  | 1114 ++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_vdpa.h  |  192 +++++
 include/linux/pci_ids.h            |    2 +
 9 files changed, 1526 insertions(+)
 create mode 100644 drivers/vdpa/solidrun/Makefile
 create mode 100644 drivers/vdpa/solidrun/snet_hwmon.c
 create mode 100644 drivers/vdpa/solidrun/snet_main.c
 create mode 100644 drivers/vdpa/solidrun/snet_vdpa.h

-- 
2.32.0

