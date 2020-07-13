Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9A921D6CF
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgGMNXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbgGMNXR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:17 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A83C061794;
        Mon, 13 Jul 2020 06:23:17 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y10so17169951eje.1;
        Mon, 13 Jul 2020 06:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=srnOr+oWrll92VFUDRSxv+y9DkOgl2yMHs+bARSxTtw=;
        b=hA2Advwg9sPYlSG9PVyUZ2WxXF2yoKE51xpWubaLGvH0fSblpcRpOX7e6gGzjKV04x
         PMFVOsT0MkAAWHx/FNBm7u+ko/ASFkGJxc26fYHAg1vB6uPjWj33Ye1n4cHZrpXXbaRx
         nhZM8JRv3BAsf3daoqySITIQioWtOixUOHScO7N/T+1fau8RNPEchPtffv6+cIY97p0A
         eAJh12CTy0jakb/slMUfM+jjHRINUVVY3p9U6FLZ1gVHvv7eFB+K1zWa5We3M/VrwWjy
         YYy9yms4BEUIE0AFFnl6IE4d3AA4Egtge7EmhM4QLUcjfFMwcjEwHeibMNPRKjAO2aqm
         rosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=srnOr+oWrll92VFUDRSxv+y9DkOgl2yMHs+bARSxTtw=;
        b=hGGltrDQCz4rJiNdm+QMwbqH3VMr1GAepcuh2BhT1zWejKcPdyOP8etxWCp6AlTCZp
         bTUKJ5QUkvXjUHiXnobW3gXdvzMri9alN6HEyM1bcCeK0J1+MYcXh+Rchyfl5QDo4zid
         GwjRJlBl21LuvY8l9jtidppqg/ikK+X2M9tuMoOCN+gSbepCyME4kSSdxgWK2lglkh4C
         4Qdt9kIR+xVXZpU2CIEMCoCrajo4sfE3eh++HRAR4RGMbhjcE5xUPj3FmqzUqTvyZGNL
         xS6a69yszMdh0nHUXArnnJ34a+ACK322fVr06GWjKomIvypDkQB+9FlbhqxqsIh0d8zF
         /SeQ==
X-Gm-Message-State: AOAM533uFVmwy6Q4VfmJ8d5Q0bW4dOvZhQc4/BbSeEy7l2LpVqNHcs67
        k9bMkXLgO0fMilrWUFpoLTU=
X-Google-Smtp-Source: ABdhPJzvG9XEXrWjvWtZEu7yzcF9rZLh2zOC+Ra/3eYp8pyZIsCiFH715AqPn92Kt0ycrF58CyNztg==
X-Received: by 2002:a17:906:743:: with SMTP id z3mr9388063ejb.216.1594646596068;
        Mon, 13 Jul 2020 06:23:16 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:15 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [RFC PATCH 29/35] mips: Tidy Success/Failure checks
Date:   Mon, 13 Jul 2020 14:22:41 +0200
Message-Id: <20200713122247.10985-30-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary check for 0.

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
This patch depends on PATCH 28/35

 arch/mips/pci/ops-bcm63xx.c  | 2 +-
 arch/mips/pci/pci-ar2315.c   | 5 ++---
 arch/mips/txx9/generic/pci.c | 3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/mips/pci/ops-bcm63xx.c b/arch/mips/pci/ops-bcm63xx.c
index 3e88e4869f37..f2810af4fa24 100644
--- a/arch/mips/pci/ops-bcm63xx.c
+++ b/arch/mips/pci/ops-bcm63xx.c
@@ -295,7 +295,7 @@ static int fake_cb_bridge_write(int where, int size, u32 val)
 	int ret;
 
 	ret = fake_cb_bridge_read((where & ~0x3), 4, &data);
-	if (ret != 0)
+	if (ret)
 		return ret;
 
 	data = preprocess_write(data, val, where, size);
diff --git a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
index 2268b63d20e8..c2b9e62fbc18 100644
--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -259,8 +259,7 @@ static int ar2315_pci_cfg_access(struct ar2315_pci_ctrl *apc, unsigned devfn,
 	ar2315_pci_reg_mask(apc, AR2315_PCI_MISC_CONFIG, AR2315_PCIMISC_CFG_SEL,
 			    0);
 
-	return isr & AR2315_PCI_INT_ABORT ? PCIBIOS_DEVICE_NOT_FOUND :
-					    0;
+	return isr & AR2315_PCI_INT_ABORT ? PCIBIOS_DEVICE_NOT_FOUND : 0;
 }
 
 static inline int ar2315_pci_local_cfg_rd(struct ar2315_pci_ctrl *apc,
@@ -311,7 +310,7 @@ static int ar2315_pci_host_setup(struct ar2315_pci_ctrl *apc)
 	u32 id;
 
 	res = ar2315_pci_local_cfg_rd(apc, devfn, PCI_VENDOR_ID, &id);
-	if (res != 0 || id != AR2315_PCI_HOST_DEVID)
+	if (res || id != AR2315_PCI_HOST_DEVID)
 		return -ENODEV;
 
 	/* Program MBARs */
diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index bdff45b6b57d..9da38f8fa036 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -61,8 +61,7 @@ int __init txx9_pci66_check(struct pci_controller *hose, int top_bus,
 		if (PCI_FUNC(pci_devfn))
 			continue;
 		if (early_read_config_word(hose, top_bus, current_bus,
-					   pci_devfn, PCI_VENDOR_ID, &vid) !=
-		    0)
+					   pci_devfn, PCI_VENDOR_ID, &vid))
 			continue;
 		if (vid == 0xffff)
 			continue;
-- 
2.18.2

