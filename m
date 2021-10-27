Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF3B43C8AB
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 13:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbhJ0Les (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 07:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhJ0Les (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 07:34:48 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F86C061570;
        Wed, 27 Oct 2021 04:32:23 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id o83so3008114oif.4;
        Wed, 27 Oct 2021 04:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxnEh8qDpD3iOItAOuA1sNXr05vu5xRHywG7hStSzyY=;
        b=et5L9NEnejyIEGEiArFB9FLsIUGc9E6M2ykMKP8cUHxmtWWzQi8HPIaUhGmPly3ekg
         qPq2V/CPTW6nlwXzJTMjpkWHZIEfW9GO98NyOuEk9hTQvXfd2AH/rEEacXionCwTbIns
         2wPxeLfhPiW7p96jDtMBAd/6ArqoPxPXOFP94j++YUjq9EICFvurwVGNPxUue4GQepeb
         XdqfClaaQoQHaWsCeR7TQtSzrpJgq6kNcdY8KmyjhD2GwehmjJj9i1HIiLTKwDiav4Xu
         BNkeRCqT99mRfLSn/8Pn7Fqzg2bN/vu4XfmHAIeTrtne9d7Zb3EuUIZM76u2VIbDB7BM
         WQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxnEh8qDpD3iOItAOuA1sNXr05vu5xRHywG7hStSzyY=;
        b=Jj9jngoPc4HHX5EuStp8XYxP5Sx8i8+TkbQwefihVnMANC7oYikknId7PrhIQBfNrs
         KdGsNGYAo8xpcvldbIWNeZeqHB7gkc7JhGa7tEkRj62ZbRNhufG6UrEuiDQm1X/dw6iC
         Ahdxsbez6A60JHj3YrbUxC1zHQgCBVqe/SkGtVROxuVq7Szy9+MCQE4z9wHi9ubv/37d
         2Hd+wM8OkV+YuX4YUegnT1OGrZepUXRg4H0F/KuqPymopLcw86QfJJ/ajh6BgF8tNDCu
         s0rDtGTkkUStJuViXEpHU7/eXisOvBUrA0NUkiqrlUg9xEzRAEVys8jxiBa/TgUB/aI1
         m4ig==
X-Gm-Message-State: AOAM530lqfoW+c9YU/+3WytnVx4Eu+UbdDCONG53DLVTB49Unbony1YI
        //nAzHjDr5L0/OV8crjBEO4=
X-Google-Smtp-Source: ABdhPJz7y8144DGSg9tx87fxTtRWoMAHMm0FTUttcN539FMIs7jp7wK8pUrJKxA9JIdJZseZMkX37g==
X-Received: by 2002:a05:6808:21a1:: with SMTP id be33mr3107402oib.161.1635334342419;
        Wed, 27 Oct 2021 04:32:22 -0700 (PDT)
Received: from localhost.localdomain ([8.26.182.170])
        by smtp.gmail.com with ESMTPSA id e23sm5430106oih.40.2021.10.27.04.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 04:32:22 -0700 (PDT)
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
Subject: [PATCH 2/2] PCI: mt7621: Export mips_cm/cpc/gcr_* to modules
Date:   Wed, 27 Oct 2021 19:31:40 +0800
Message-Id: <abead7ae64e1a0cc96a09647a5facf30d03381aa.1635333327.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1635333327.git.siyanteng@loongson.cn>
References: <cover.1635333327.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

modpost complains once these drivers become modules.

ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!

Let's just export them.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 arch/mips/kernel/mips-cm.c  | 5 +++++
 arch/mips/kernel/mips-cpc.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 90f1c3df1f0e..b07f20323132 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -12,8 +12,11 @@
 #include <asm/mipsregs.h>
 
 void __iomem *mips_gcr_base;
+EXPORT_SYMBOL(mips_gcr_base);
+
 void __iomem *mips_cm_l2sync_base;
 int mips_cm_is64;
+EXPORT_SYMBOL(mips_cm_is64);
 
 static char *cm2_tr[8] = {
 	"mem",	"gcr",	"gic",	"mmio",
@@ -353,6 +356,7 @@ void mips_cm_lock_other(unsigned int cluster, unsigned int core,
 	 */
 	mb();
 }
+EXPORT_SYMBOL(mips_cm_lock_other);
 
 void mips_cm_unlock_other(void)
 {
@@ -369,6 +373,7 @@ void mips_cm_unlock_other(void)
 
 	preempt_enable();
 }
+EXPORT_SYMBOL(mips_cm_unlock_other);
 
 void mips_cm_error_report(void)
 {
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 8d2535123f11..dfd3d58fd412 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -13,6 +13,7 @@
 #include <asm/mips-cps.h>
 
 void __iomem *mips_cpc_base;
+EXPORT_SYMBOL(mips_cpc_base);
 
 static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
 
-- 
2.27.0

