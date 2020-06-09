Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25641F411D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 18:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbgFIQjj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 12:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgFIQji (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 12:39:38 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F1FC05BD1E
        for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2020 09:39:38 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p18so16884124eds.7
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2020 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9rhbPwp78p7QDimVV/M2bMrQTU8itpq+LDENhux7O1Y=;
        b=PLAd77ol0yF25+tIk17dV5rWVd/POy2hmwSfg8iMnlA4hyqou8+kNlnl+5oJ9/TyXm
         RvUO3Vu6/QUmHTVGXEVBO3UeSD12AWtkUSZn2GTQ3fn2PtnuTaWz8yQAJQG/tZyALvXC
         Awy2IQTbVrKHcx/Yg5yNXJQZMmxrU5UtqoUKb+wAeXuQ+wSCLszoDCOxMwa9+35SuumO
         R6IHC+zwtovR8FreNDan6hVXGjH/x24OU39PjEop6XubQS1+Fle31fdMOAfE25FSH7/9
         RK4i9g3ZJel2j1IjrA402aPHAvuFr+VpeNy0k+2rYEqLerlIIwx4fDvUWGALlhCS+WxJ
         mnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9rhbPwp78p7QDimVV/M2bMrQTU8itpq+LDENhux7O1Y=;
        b=PMrq0ykfMEp/ECJ6uQA4gBOK1XBFbL43VbhK9GsBhpRBDblh9yF9kM1+/3AmMopHsW
         3fQVAS2KHGqaQtkecZmLcqVUZeTtLrGBj1QVwsVVqTp/JA44Vki/GdRLeLi81E6pZVpI
         uyk5JWuo6xWXNkipv9a2aNzxX7M0+LkRKvjnQwIaWG73XixrgAjyKXuoE+zudjCABByc
         fgW8tWRqi1e1hkokV2iPUDOtZySODCRyAOsoNwQRXbYjQ9DIxqvvUELugYY4sdGpMlkn
         Ak5HQASFZw6VkDJK8gU1f9RCfoQFLgqXLghazvEeJuJboMTSkn6J6TznZgPePV0xIp+i
         85XA==
X-Gm-Message-State: AOAM532SfOxIeHGs0MIbgaKt0B1PV2TP9veumO60NgohD2aucd6+0Zqh
        vzh5oA1TgZmDPGf8LOZKXgk=
X-Google-Smtp-Source: ABdhPJw9Ap3KlgNPBVi8t1a5KFnBjFwtC3MNaxZeFOC5Jw5HhyPQe27VsCmCneFU5fyIqpEyW8OtIA==
X-Received: by 2002:aa7:d6d0:: with SMTP id x16mr28480134edr.175.1591720777186;
        Tue, 09 Jun 2020 09:39:37 -0700 (PDT)
Received: from net.saheed (0526DA6B.dsl.pool.telekom.hu. [5.38.218.107])
        by smtp.gmail.com with ESMTPSA id ce25sm8822176edb.45.2020.06.09.09.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:39:36 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH 1/8] PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
Date:   Tue,  9 Jun 2020 17:39:43 +0200
Message-Id: <20200609153950.8346-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200609153950.8346-1-refactormyself@gmail.com>
References: <20200609153950.8346-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

ioat3_dma_probe() returns PCIBIOS_ error codes from pcie capability
accessors.

PCIBIOS_ error codes have positive values. Passing on these values is
inconsistent with functions which return only a negative value on failure.

Before passing on return value of pcie capability accessors, call
pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
negative non-PCI generic error values.

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
---
 drivers/dma/ioat/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 60e9afbb896c..fc8889c2a88f 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1195,13 +1195,13 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
 	/* disable relaxed ordering */
 	err = pcie_capability_read_word(pdev, IOAT_DEVCTRL_OFFSET, &val16);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
 
 	/* clear relaxed ordering enable */
 	val16 &= ~IOAT_DEVCTRL_ROE;
 	err = pcie_capability_write_word(pdev, IOAT_DEVCTRL_OFFSET, val16);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
 
 	if (ioat_dma->cap & IOAT_CAP_DPS)
 		writeb(ioat_pending_level + 1,
-- 
2.18.2

