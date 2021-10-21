Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2862B43659A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhJUPQp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhJUPQX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:16:23 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A443C0432C5;
        Thu, 21 Oct 2021 08:13:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y4so673327plb.0;
        Thu, 21 Oct 2021 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nMMca6ogUWXi0ch4Y2WRyLimPI/FUHz8LX6jciCfSL0=;
        b=Ebt87PGCiA5DfC2ykF3q2FI75oUe+I22DKgpYutQWfZKv6HY11WV3QxfBdoZ2IZ/8R
         1dXQQC3ymsHSF7lHENRAW7heU7N3//R7ApODSTy2OPCTm8KgE/AdYPjd7BcjUw/JeXaQ
         G6d0gMcA5ImCvXHdrbfxenldCzozNVINxVpHzZU2dtq0JEiZYMzTAf6eS7YcNzYATO7a
         RFkZdTwYgxCgX5Yb7coZ5yE1oIPHu3K+j7/wBKwKhM9Xp01itiWZJ0+Ob03p93IpGsKR
         d44pWrjLExUCkKCJyqzDEUK0sO+89IQael7QvcRgen995yz6PiWAjLUmDvrkj/EXLhly
         Mjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMMca6ogUWXi0ch4Y2WRyLimPI/FUHz8LX6jciCfSL0=;
        b=qd9unDtwHQTHQKsmDNtVbxmg5VQhIxUGej9HhWtAwnoUPmBHYWnTgdPwRfh1bAXIln
         jt+s0zy/asQsj3yX0ISliJZ+FesfV2t7CssmTNWZWuaw8Uudhh2oRkEUpOjuMaIvD9Hy
         GfkV8LzHpKVKbN+xw25RMseGVvU4lb/A9pbtHBA4qJLd34FC7wpv1lFxpl6csl27w/Oo
         a49oiW/V6AeQlBKRiaEMsi/rJszrynu/8FgSinQW68txn0+e7N+7pvpNdN1CdxhyNHIb
         XXX34qR37f6ymodGaRf/PyCkXbOrJ2DPHVI1kQA+oL3IvU9vKYY2iWUkwD9H3P2LOiK7
         Dk7Q==
X-Gm-Message-State: AOAM533tju+/LJ+hBpLd/Cf74NXlGIgOZTBhnkNEdiN86VH1LFU2yADq
        88ANzi0EHsmbY8pAk6tOF+k=
X-Google-Smtp-Source: ABdhPJxlhCnhuhE7I8iz3HkOhUekSEuVNDqklOld2tfE6JglGG840MuyjWtZqqUSBBb9vuA4cFmhqg==
X-Received: by 2002:a17:902:b68b:b0:13a:1239:b8d9 with SMTP id c11-20020a170902b68b00b0013a1239b8d9mr5741580pls.25.1634829212923;
        Thu, 21 Oct 2021 08:13:32 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:13:32 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v3 17/25] PCI: vmd: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Thu, 21 Oct 2021 20:37:42 +0530
Message-Id: <5be1fdfdcf4b4a453117ef4dea0f71c9555fac24.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
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

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/vmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a5987e52700e..bfe6b002ffec 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -538,7 +538,7 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 		int ret;
 
 		ret = pci_read_config_dword(dev, PCI_REG_VMLOCK, &vmlock);
-		if (ret || vmlock == ~0)
+		if (ret || RESPONSE_IS_PCI_ERROR(vmlock))
 			return -ENODEV;
 
 		if (MB2_SHADOW_EN(vmlock)) {
-- 
2.25.1

