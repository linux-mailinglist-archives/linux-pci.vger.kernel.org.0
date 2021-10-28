Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10E443DA1B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 06:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhJ1EIF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 00:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhJ1EIE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Oct 2021 00:08:04 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A84FC061570;
        Wed, 27 Oct 2021 21:05:38 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id y133-20020a4a458b000000b002bb71084420so121622ooa.6;
        Wed, 27 Oct 2021 21:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6FpxS9c54/M2hbJ4gBGI81tkUflwGxgqjonrkZ/Miw=;
        b=RB8Wv5J0MEh+omOWxA361i9lMRUw0w2BBNk4W4cNisr/OmEzYLCv704F7OjKh92tNg
         /cCkEDgpEaW0HEKSxxtKzx801K4VfnTWBhgWpzRyL16O9A+5jrmETYLU6Q+noZ+LjUoh
         w682UuyzjdUsI3Bza9zI5G/h6CfN7qFfWQwlbyaXh3dcxvOKdDuQC/q5F7eEDfvqcxwj
         WpZtZ5kahKRER0E4hxowGE7G5CDr/rQ9AWVhlEkEnMjtkfSxrBswI/eyoiJd0Oarzn4l
         j13H3jC+Oyh2Oq+LN1nSHbt2qL3HGII+xNhFzhCIVkn3qabENuOSHHgouZcwjF1RetIX
         5+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6FpxS9c54/M2hbJ4gBGI81tkUflwGxgqjonrkZ/Miw=;
        b=ji+hPYXhnEdb2qTB+rUsWL3IOTH+xk/Y4QRHx6F9r/QtCxWa8jzwbVdVeF9MG42Wlv
         9W8MoZWhv5TkvO+Gu1fJf44PfSp/us/jNck++fueQ2R5fktCK25Xsrao6aIM2fLWWDtI
         BfQoJrClcVVFYilE6URI2YRkv7m0CSVg5PwqLbuaam+bwOyA6hVP3b5KgRtmtHp2bHk7
         KhRJrNIuxZ8iDe6QQ1m4MYDA7Rn/0fIwLIE0MbyuKAcdjj4dM5BCRjO29vfVskbVmg0L
         cR2TMe3WF3l1tx7dXf7wEuMRx+be+WV5t8GqosGSZt2L87vkwLkXQPXMOkvwX7ql8WPY
         JT6w==
X-Gm-Message-State: AOAM533rCkuatye4duz1x9Fw0c1TNSoFWsAals8FY+K7bxeOw+JqFSZq
        RQEKeSxvfgRLq5972QxDqRE=
X-Google-Smtp-Source: ABdhPJx4NETM+KKu/LTnM/+SJMhfnAvqGLqcWBLQvtfeJodq4O1EuBPAxy3c3qqjf8NHoQErspcDZw==
X-Received: by 2002:a4a:c80d:: with SMTP id s13mr96122ooq.4.1635393937516;
        Wed, 27 Oct 2021 21:05:37 -0700 (PDT)
Received: from localhost.localdomain ([8.26.182.76])
        by smtp.gmail.com with ESMTPSA id v13sm720310otn.41.2021.10.27.21.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 21:05:37 -0700 (PDT)
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
Subject: [PATCH v2 2/3] MIPS: cm/cpc: export some missing symbols to be able to use them from driver code
Date:   Thu, 28 Oct 2021 12:04:53 +0800
Message-Id: <112fea0c8c1b65a762ac98412216239160721263.1635390750.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1635390750.git.siyanteng@loongson.cn>
References: <cover.1635390750.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
the MT7621 PCIe host controller driver is built as a module but modpost complains once these
drivers become modules.

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
index 90f1c3df1f0e..892258760bf3 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -12,8 +12,11 @@
 #include <asm/mipsregs.h>
 
 void __iomem *mips_gcr_base;
+EXPORT_SYMBOL_GPL(mips_gcr_base);
+
 void __iomem *mips_cm_l2sync_base;
 int mips_cm_is64;
+EXPORT_SYMBOL_GPL(mips_cm_is64);
 
 static char *cm2_tr[8] = {
 	"mem",	"gcr",	"gic",	"mmio",
@@ -353,6 +356,7 @@ void mips_cm_lock_other(unsigned int cluster, unsigned int core,
 	 */
 	mb();
 }
+EXPORT_SYMBOL_GPL(mips_cm_lock_other);
 
 void mips_cm_unlock_other(void)
 {
@@ -369,6 +373,7 @@ void mips_cm_unlock_other(void)
 
 	preempt_enable();
 }
+EXPORT_SYMBOL_GPL(mips_cm_unlock_other);
 
 void mips_cm_error_report(void)
 {
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 8d2535123f11..26392d18729c 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -13,6 +13,7 @@
 #include <asm/mips-cps.h>
 
 void __iomem *mips_cpc_base;
+EXPORT_SYMBOL_GPL(mips_cpc_base);
 
 static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
 
-- 
2.27.0

