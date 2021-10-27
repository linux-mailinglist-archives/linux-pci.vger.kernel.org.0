Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5CB43C8A8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 13:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241653AbhJ0Len (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 07:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241655AbhJ0Lem (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 07:34:42 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2AEC061570;
        Wed, 27 Oct 2021 04:32:17 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id o83so3007774oif.4;
        Wed, 27 Oct 2021 04:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ulhn4KODo+M8bQOCOaLaS+XZsUOCyPb8RqRWLn0FhBo=;
        b=NdNt/0mG63IMHrYdKrGRchjJA3NLl73blNkn2CLJ9iW1ZGGJ4MjZszel2piHsEUbqg
         fgJkDpG5l92TH9cRhCifTd3dJGqR9XvpH/s3lIz3TJQYunHu+bpJkkR5GyuJd4glmzNB
         MoeygbQ1FmfFSAd4XsZFnkJEpN7S5ohnzRxB9oy340onnnsQ92ug9E0NfVPwaQJM0p2H
         fkA00Po14HGp91tFWr71+2Cx+EFhyptZPPomx/++zsiPJDHj0OyNQiAhrUB2d5MZ5Lxs
         WeuOdKgc5Qki/ja4jIgfWIws7UAV5wdOydVxdhtqR8zZuXLxcC8AsaXp5v7b3N5g/F9w
         Rxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ulhn4KODo+M8bQOCOaLaS+XZsUOCyPb8RqRWLn0FhBo=;
        b=oNLyE/51ITDO5ZbvQDrwjFXKq1FqbN+HPe1UFYhFMgKaVfzmx6ytrN/8sQ9I5Fq1CT
         9AHOuklk2LFJabcSSgARp8AaHUWej07ON+6b5e4SK0fVRW85E5vgAq+cuaf7iTarA2+E
         OHRoWdWgGa7JHB320XhsiY0hGC9XA4I+fW5cYECaSp2dPMbN/oDufjXy9F0wdc2sdkMZ
         JGtgxV05jDu7VyR4/SoM1B3PwROQPrPuBe46Pi+5Qr27RWkAEDFh1qE5BnXOxm3enOoj
         fu5c1UU5uAd9Ij0c3s3zkGky8pED0lpfkFrNBL5ytZVIxQNeq/dTWS/KhyVU1C3R+qjc
         k8Jw==
X-Gm-Message-State: AOAM533/H6QXA09akBnGNvdEp/JkfwZiZcQQ6YfzrgdZevJCFm/FB047
        bG3NLV8pnVf7Fpm51yjT2nc=
X-Google-Smtp-Source: ABdhPJyDtqXolJD9smrK9+TJiNjHaGA863agytaUNdu/NWWpgx1LiqcUGcw3mrk5rjhk7cXU0TEVEg==
X-Received: by 2002:aca:3343:: with SMTP id z64mr3098600oiz.100.1635334337149;
        Wed, 27 Oct 2021 04:32:17 -0700 (PDT)
Received: from localhost.localdomain ([8.26.182.170])
        by smtp.gmail.com with ESMTPSA id e23sm5430106oih.40.2021.10.27.04.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 04:32:16 -0700 (PDT)
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
Subject: [PATCH 1/2] PCI: mt7621: Add MODULE_* macros to MT7621 PCIe host controller driver
Date:   Wed, 27 Oct 2021 19:31:39 +0800
Message-Id: <50f5f509c15251fb10b0c87304d272e2c89841f0.1635333327.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1635333327.git.siyanteng@loongson.cn>
References: <cover.1635333327.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
the MT7621 PCIe host controller driver is built as a module but no MODULE_*() attributes
were specified, causing a build error due to missing license information.

ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o

Fix this by adding MODULE attributes to the driver.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 drivers/pci/controller/pcie-mt7621.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index b60dfb45ef7b..668b737f86fb 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -598,3 +598,5 @@ static struct platform_driver mt7621_pci_driver = {
 	},
 };
 builtin_platform_driver(mt7621_pci_driver);
+
+MODULE_LICENSE("GPL v2");
\ No newline at end of file
-- 
2.27.0

