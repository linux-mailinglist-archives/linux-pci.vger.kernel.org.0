Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14B743DA15
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 06:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhJ1EHy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 00:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhJ1EHy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Oct 2021 00:07:54 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF6AC061570;
        Wed, 27 Oct 2021 21:05:25 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso6753645ota.9;
        Wed, 27 Oct 2021 21:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JAFmGbzliFdK9YUpB9Pr3vqgYOv/hA15ip0ARBAHB14=;
        b=C35/2Awskpi7sNIUy/6w5UofmU1anZCwUM80cB/vCG2/CefovGQ81gUT5vvZIyDwQ9
         7xPfVeN1qtXyaLFSWnOO07fQpkIVjXDcQ++qr5HZuEcOhxPFKAcIM2LosLW8suU1RioL
         jekV9t5MxCv2imE6VA/bSzlZ8JgY8T3LrpDc+o1ntSTNG1OHFJUw2rZziJCLaH8rUAYC
         sGJ/RYuMDmYdAmKkovwp9N0mSAEE8UABBpO9WYb5TG23mfO8aG9Qe5lVur98yK6clk8V
         W/lRi4ViEwlmbMurcCZii2sDailHkp8rhSpN+4ghEn8bAXqtslxbwpeTxup7TIQH7tRs
         Ozpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JAFmGbzliFdK9YUpB9Pr3vqgYOv/hA15ip0ARBAHB14=;
        b=RZv5nak1F4+H5j8+P1zdQV7CDO6q8tcjcZuxpDmTCmxnfOa/FehCIYH0aU6uxoR08r
         ouh9eoH4mRHulXkrmy5/7MAKn1TXhO8U7Qvc4uN13msrsGyhxUKJgneK4UplFOdz7UBw
         ZUlKrAe1ce43TWij1kqJVHdBcp3Wp6QhL8zImp3KPLsSrRYxTN/XE30cslTQja7LqqCI
         y3BWne7OT/VH/RdMeJY8qFEoaNoDXinD8w/RiJqBkwAP1szIEOdmWqCjLRSvkZrPwISi
         dotuaJ0RhZzHjGy23T+52pEYBpXmOeaBzDVKBF3G4QXG2Rp9SuqdW6nnK8eRM1G3LzDm
         LC7A==
X-Gm-Message-State: AOAM532qm/qT9I0+SRL+nyxyFVrBhJLE6OKtpDvPSAQM6MgGfnoCnDMT
        3k/eLutf+zC5Fz6H1ItyLCg=
X-Google-Smtp-Source: ABdhPJx4B5/4gp731H1f4QXFtngh+vXOd8jkpnUjaTWTt4quVnYpOJCHW3DbJdeqr7RLQ9eYEXjimw==
X-Received: by 2002:a05:6830:1e95:: with SMTP id n21mr1482616otr.141.1635393924615;
        Wed, 27 Oct 2021 21:05:24 -0700 (PDT)
Received: from localhost.localdomain ([8.26.182.76])
        by smtp.gmail.com with ESMTPSA id v13sm720310otn.41.2021.10.27.21.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 21:05:24 -0700 (PDT)
From:   Yanteng Si <siyanteng01@gmail.com>
X-Google-Original-From: Yanteng Si <siyanteng@loongson.cn>
To:     tsbogend@alpha.franken.de, sergio.paracuellos@gmail.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com
Cc:     Yanteng Si <siyanteng@loongson.cn>, sfr@canb.auug.org.au,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        chenhuacai@kernel.org, sterlingteng@gmail.com,
        linux-next@vger.kernel.org
Subject: [PATCH v2 0/3] MIPS: Fix build error ERROR: modpost:
Date:   Thu, 28 Oct 2021 12:04:51 +0800
Message-Id: <cover.1635390750.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v2:

* Pick Sevrgio's Acked-by tag to Patch 1/3;
* Rewrite prefix;
* Use EXPORT_SYMBOL_GPL();
* Add haojun's patch into my thread and rewrite commit message.(Patch 3/3)

note: These errors are generated in the *linux-next.git*.

https://lore.kernel.org/linux-mips/cover.1635333327.git.siyanteng@loongson.cn/T/#t

v1:

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

Wang Haojun (1):
  MIPS: Export board_be_handler to modules

Yanteng Si (2):
  MIPS: mt7621: Add MODULE_* macros to MT7621 PCIe host controller
    driver
  MIPS: Export mips_cm/cpc/gcr_* to modules

 arch/mips/kernel/mips-cm.c           | 5 +++++
 arch/mips/kernel/mips-cpc.c          | 1 +
 arch/mips/kernel/traps.c             | 1 +
 drivers/pci/controller/pcie-mt7621.c | 2 ++
 4 files changed, 9 insertions(+)

-- 
2.27.0

