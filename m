Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F24321DDF1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 18:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgGMQzR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 12:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730325AbgGMQzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 12:55:16 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A1CC061755;
        Mon, 13 Jul 2020 09:55:15 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d18so14277287edv.6;
        Mon, 13 Jul 2020 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iiHt01yExxr+UGjzI6XflZ+uDY4MKkRXHZbIPXDUuRY=;
        b=HmmxQ/aEsuwnYmu7uvp6iPKhOMZAIHMXP42//F908Nkqa4MLYdR6vM0f8CaAYqWowF
         cmLlcXg6JpO6pxfq/D/zt1YR+ZwGTV4syUfrH+YTz6B1Fs4vVUcsGP19zyzOASXLQlmZ
         qTKgzZNYZoquze0LtCBNYu9CdDrzkE2u3ekNQis8W69z1bxrl9hJzhzv1GepBQWS873d
         gw2++hMdnjYAB3HOhDaTO0eEJ/h40zjf9peBORLPHgXxyloTyKyiPqbw9YGSUU9NprrK
         bMu4dxYW7BLe+/eTe3hwCtah6QY+qHfien1FLHGr9zVADP/vvGBpx56b4RcfHUG+cyQ5
         6/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iiHt01yExxr+UGjzI6XflZ+uDY4MKkRXHZbIPXDUuRY=;
        b=Ih8UPvzzHNrcy17DJmaMUJ1Y3SxO8ttDv/THiPQE7VeOvZoBZ7iZeoXNnzU6BPo+O0
         VJ1dm28QyoRMCu7B/h3E9QqZYUWWaK/5RRpvuJJRiwXI1468LvqszfFhsqs+oYx31gRS
         xd/m58vmpZAL8q567UndpK+siXMaiFb1C3MYQ1vF58uB/ugRBrV0ynsLTKre+Zi+YioI
         7b27SxgKp4Plh5DcirZgFMoe18N2/EvD2ehCZRHLR1uFFoGDys7CmK7ol7WXjz+OlIFn
         EvaOcDW8SO/5TJf5fix0hvGExqQvBiDF+Oq7nXjJ+0gxPHhAgp62EdaS7VJmSqMBTvOh
         Twcw==
X-Gm-Message-State: AOAM532/+1xQokP3L/X4qqZiT1TTe8WWaK+HO5/e1vuF2cqtova3JNVx
        p3JOpYZsaMBhCYGSR3MMFI+JCLUeZr+TPA==
X-Google-Smtp-Source: ABdhPJz2hbS/YAxk7ynpXEBxv0L7UVNCdcghPyy01UrXKtCfUacUfQIn8EVUfGf1smzuZiWEtLdarg==
X-Received: by 2002:a05:6402:3099:: with SMTP id de25mr348700edb.228.1594659314697;
        Mon, 13 Jul 2020 09:55:14 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id w3sm11838938edq.65.2020.07.13.09.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 09:55:14 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     skhan@linuxfoundation.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Subject: [PATCH 8/14 v3] PCI/ACPI: Check the return value of pcie_capability_read_*()
Date:   Mon, 13 Jul 2020 19:55:28 +0200
Message-Id: <20200713175529.29715-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713175529.29715-1-refactormyself@gmail.com>
References: <20200713175529.29715-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure pcie_capability_read_dword() sets it's last parameter,
val to 0.
However, with Patch 14/14, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x). 

This bug can be avoided if the return value of pcie_capability_read_word
is checked to confirm success.

Check the return value of pcie_capability_read_word() to ensure success.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/pci-acpi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 7224b1e5f2a8..39eb816bc3b8 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -248,12 +248,13 @@ static bool pcie_root_rcb_set(struct pci_dev *dev)
 {
 	struct pci_dev *rp = pcie_find_root_port(dev);
 	u16 lnkctl;
+	int ret;
 
 	if (!rp)
 		return false;
 
-	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
-	if (lnkctl & PCI_EXP_LNKCTL_RCB)
+	ret = pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
+	if (!ret && (lnkctl & PCI_EXP_LNKCTL_RCB))
 		return true;
 
 	return false;
@@ -792,12 +793,13 @@ bool pciehp_is_native(struct pci_dev *bridge)
 {
 	const struct pci_host_bridge *host;
 	u32 slot_cap;
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		return false;
 
-	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
-	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
+	ret = pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
+	if (ret || !(slot_cap & PCI_EXP_SLTCAP_HPC))
 		return false;
 
 	if (pcie_ports_native)
-- 
2.18.2

