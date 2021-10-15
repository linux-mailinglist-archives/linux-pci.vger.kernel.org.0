Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB78742F619
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbhJOOsj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbhJOOsi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:48:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A58C061764;
        Fri, 15 Oct 2021 07:46:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso1880070pjw.2;
        Fri, 15 Oct 2021 07:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hOpzKqtZkl4vpPBZR8uQl2s3BPZXOsp3vKlUaVIS/Mo=;
        b=lGnDCLP8y6cK8sv7p2OZlrGk97vBTKAG2qRs3qpGUCsOeOSA+8Eg6eKhbQ9Ur8G4AK
         QL3e95caq6ledLj+vqpKoKy9JEpKMfivJ1341LnWux3fnFzCNGsYnGJanxZqaFkVwBR6
         bX13DDXre68T7KAPeSVanJN4EiAbGsgROJ11EyNQ2/KLuwki3eHUwn5AP76wFBU5WEkM
         2VhnhGfiFSiJrau7UAG3h9p7aDnKvjDNFj3ZMcovitC/Bfx0XzA6blFPC0jZQ9w133yj
         80Ru/QQuyuIjxeebyzEja50/QqoI0u2KuJXOdJVBfI14y67dSZVOCqpcI2652vEuwLYK
         V88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hOpzKqtZkl4vpPBZR8uQl2s3BPZXOsp3vKlUaVIS/Mo=;
        b=LthU5isMu6WBLuihMahCAi7LcgxQF2/sZgibK7V+GNcb+obtBtl1C2H4G/xYagtg/O
         ISruySwd0sfaJiuqQLm69HWy87dn15vazZHiToS/WZG5Nmob8sKt7Y0d67DX5aW3T/yK
         fNa6/BxLg1urVEhN5ALYTLOoDznt5Py1Yu5eunwKuZFKrEdErbPxO7Es9+ElJ0YlOrdG
         vptecSN0CTzbvlX/YZf6nK8E8aDGuXltJIPM8Gq+vMx+CkzLpCOTgKZPYB3265ac7G5i
         LkWj7AQ9QN/Mo6DR9jnAYw7ffqvKkOvcK3FW3tF7fGMuv8prFc5sKYiYhAYleTv0pD0U
         0jHQ==
X-Gm-Message-State: AOAM531MfUNVR42ouS9rCkbh/ogOJbXQTdBala+RrN9STHSurWPyyr+t
        sEYr3IKGgOb9m/vRudZj2Hg=
X-Google-Smtp-Source: ABdhPJyYyqfcsJzI243JmXVG3+21XjY11IqHy3sc/D6aNXGZkvJA2D+wvBQJSu7RAMcZHo+4OnX3Ug==
X-Received: by 2002:a17:90a:5d89:: with SMTP id t9mr5623662pji.21.1634309191523;
        Fri, 15 Oct 2021 07:46:31 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:46:31 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v2 20/24] PCI/PME: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Fri, 15 Oct 2021 20:09:01 +0530
Message-Id: <a6bb07c191901d98a90944598d7d6939df18443b.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use RESPONSE_IS_PCI_ERROR() to check the response we get when we read
data from hardware.

This helps unify PCI error response checking and make error checks
consistent and easier to find.

Compile tested only.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/pme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 1d0dd77fed3a..24588d0b581f 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -224,7 +224,7 @@ static void pcie_pme_work_fn(struct work_struct *work)
 			break;
 
 		pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
-		if (rtsta == (u32) ~0)
+		if (RESPONSE_IS_PCI_ERROR(&rtsta))
 			break;
 
 		if (rtsta & PCI_EXP_RTSTA_PME) {
@@ -274,7 +274,7 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
 	spin_lock_irqsave(&data->lock, flags);
 	pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
 
-	if (rtsta == (u32) ~0 || !(rtsta & PCI_EXP_RTSTA_PME)) {
+	if (RESPONSE_IS_PCI_ERROR(&rtsta) || !(rtsta & PCI_EXP_RTSTA_PME)) {
 		spin_unlock_irqrestore(&data->lock, flags);
 		return IRQ_NONE;
 	}
-- 
2.25.1

