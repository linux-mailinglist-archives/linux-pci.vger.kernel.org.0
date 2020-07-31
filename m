Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09D923452A
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 14:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbgGaMCv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 08:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733001AbgGaMCV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jul 2020 08:02:21 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05544C061574;
        Fri, 31 Jul 2020 05:02:21 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bo3so8536415ejb.11;
        Fri, 31 Jul 2020 05:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ml221r4dHqXe07i3xfLOyBkeN0U7ADgIKojP7DQw/XU=;
        b=tdc87K9UnCJy6h8rTMzof2JLZE4gpUzsMej7iiUfVOUd8Id5xNJOXDAFSfsuz1w6u7
         iPtFsNJnx1SkMUgFfvLUPtv9cu83vKOHYyRXtSmX7KgJcVnPQ3gnhE8Vn7frgHaIxoVi
         Z+sknEjd13Z6IBnP0Jr1Gxd6tF5MYqxOo+hJMYp26pN1GTyaYHyecoyhHHtGfC0VobdR
         mBKxZ07cIazEDKChb+I7ckeC2rc+uHvtBAkpedhjsjR469MF4Evszk9aoUuX/w/fp92p
         VaLu2ghSiNVcmXKdZDtlEE5Eunx6Vqus4obfwNnNzChqQ/gvK3jUU6SEn0bMJjdZoz9a
         s00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ml221r4dHqXe07i3xfLOyBkeN0U7ADgIKojP7DQw/XU=;
        b=VO/ZHz++ggkO+pZzm9eTS5b2vfxdGXT75PU0zHBT5WIBFppuBmqUp8V9qnlTQI/VVJ
         nv7PJUUQeEzZsET6ZeSiK7uiP14M+ggjfBA0y7yqEnkT9CqavTltXov8uzwQGaPEeF2N
         UqS1q5e7iL6Z3H69POQO0esEl54ZQKeRafBIn6Sg8RLu/9r6gYv/nZle4vJWdHUgbQCP
         BJvJbEIIjMqTBerXA3Zvit58XF9LGFvMezdg/Cqc6Ar1N9wwbzs6sKeNxbob/USMMF/5
         c31nvKEV85k2QHUptBkyRJzFzXoy6TJqrOxkX26fdDB4eiBsHslvBSs0aGMj+aDVk0s5
         cs8Q==
X-Gm-Message-State: AOAM533jhp02Z7kl5ZeUzfHPAv465O7ZvSo0NDgiHpFKKKRWtKAazGcq
        EiD1y+0AVRUV25hdIZrueB+a7UDtjUwS2g==
X-Google-Smtp-Source: ABdhPJzVmRwWuzV+in/VwaHSzymsIW0npTezXTXxbvP7G3I49+S4RYZeWtmVO3+jrmVNC2IMOL/qcQ==
X-Received: by 2002:a17:906:a94b:: with SMTP id hh11mr3659252ejb.104.1596196939763;
        Fri, 31 Jul 2020 05:02:19 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id j5sm9091734ejk.87.2020.07.31.05.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:02:19 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/12] misc: rtsx: Check if pcie_capability_read_*() reads ~0
Date:   Fri, 31 Jul 2020 13:02:30 +0200
Message-Id: <20200731110240.98326-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200731110240.98326-1-refactormyself@gmail.com>
References: <20200731110240.98326-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On failure pcie_capability_read_word() sets it's last parameter, val
to 0. In which case (val & PCI_EXP_DEVCTL2_LTR_EN) evaluates to 0.
However, with Patch 12/12, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x).

Since ~0 is an invalid value here,

Add an extra check for ~0 to the if condition to ensure success.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/misc/cardreader/rts5227.c | 2 +-
 drivers/misc/cardreader/rts5249.c | 2 +-
 drivers/misc/cardreader/rts5260.c | 2 +-
 drivers/misc/cardreader/rts5261.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
index 3a9467aaa435..cab816639df1 100644
--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -106,7 +106,7 @@ static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, OLT_LED_CTL, 0x0F, 0x02);
 	/* Configure LTR */
 	pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &cap);
-	if (cap & PCI_EXP_DEVCTL2_LTR_EN)
+	if ((cap != (u16)~0) && (cap & PCI_EXP_DEVCTL2_LTR_EN))
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, LTR_CTL, 0xFF, 0xA3);
 	/* Configure OBFF */
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, OBFF_CFG, 0x03, 0x03);
diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 6c6c9e95a29f..4382ac753fda 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -119,7 +119,7 @@ static void rts5249_init_from_cfg(struct rtsx_pcr *pcr)
 		u16 val;
 
 		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
-		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
+		if ((val != (u16)~0) && (val & PCI_EXP_DEVCTL2_LTR_EN)) {
 			option->ltr_enabled = true;
 			option->ltr_active = true;
 			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index 7a9dbb778e84..3d52c86aaaa3 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -519,7 +519,7 @@ static void rts5260_init_from_cfg(struct rtsx_pcr *pcr)
 		u16 val;
 
 		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
-		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
+		if ((val != (u16)~0) && (val & PCI_EXP_DEVCTL2_LTR_EN)) {
 			option->ltr_enabled = true;
 			option->ltr_active = true;
 			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 195822ec858e..7e1188740194 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -440,7 +440,7 @@ static void rts5261_init_from_cfg(struct rtsx_pcr *pcr)
 		u16 val;
 
 		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
-		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
+		if ((val != (u16)~0) && (val & PCI_EXP_DEVCTL2_LTR_EN)) {
 			option->ltr_enabled = true;
 			option->ltr_active = true;
 			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
-- 
2.18.4

