Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840FA43BBCD
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 22:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbhJZUtH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 16:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbhJZUtG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Oct 2021 16:49:06 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99FCC061570
        for <linux-pci@vger.kernel.org>; Tue, 26 Oct 2021 13:46:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y205-20020a1c7dd6000000b0032cc8c2800fso3436475wmc.4
        for <linux-pci@vger.kernel.org>; Tue, 26 Oct 2021 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mccorkell.me.uk; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2B5bfak5pOn3LL50jYA5aIDVkCxJVMxnsF7xV9Yfu9I=;
        b=TvmhjVGcd0cY0CjdEdeeRciPgObuXMSvuQVIyp2TiXbvgQQNGrccjrUH496hJ4E+fi
         LaCD/2yFNXyybhHUFzSzdVBREb3pXTdJEoLasyyAEyeWzOGqsaEwmZrzi3B+a3kjfCOG
         Zl2cZb79AXuaMej6iQc9+XBxe26jOz0uIIq1NSxfUYVmw1Fd2BM0FLwYnW3MC9dqEImf
         b+8FjIYc5odyl4fuAsca2ucozyGAToiZbyEtj6tp+X0ZainXNmJcJg8s/4UEsn+WXONR
         PzTFlTBpdW4mPjs2SUpIs831TeGC1z9krLSqzlsKD6ETO/nXqvxVDj0aHZF3iT5HLHH/
         kfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2B5bfak5pOn3LL50jYA5aIDVkCxJVMxnsF7xV9Yfu9I=;
        b=RSacJCsUv0Je39CO3Sf4RhMOug40mjxpJMCoEmylQSrKuHgt/C6usjrO1kWlEKXLRf
         Fkga6XoClTo7A62Xhv8xVnc8QRNif5v8WnDlDiOEaz/Q5pE9/USHyXdvSlwAlJh3qEUW
         UsDe81F/IizpFzLCORC3srJ3XKftjfVqhHUhEypZb9TCQoJENmXv+Fq8CPgxUAseu3Al
         MiCN9v3xThoc4S/XSsrtz8RB7qB6jZSQE1//1wlNtWzqygwRokNpCTPEDOryw4I/xilC
         Qs+4eVZWioApvBtlf4bRbLVtgruAGDOSgy3cuJx6w38mPFJNEqaayvSuJfp3EMwsyC1i
         1Rkw==
X-Gm-Message-State: AOAM532oqGuu4snZCksKixe3XcCS8J1yMhjBnLui/3c6UBV5kNscti/X
        g6H+uiIW3G/kdBSjxYP8w+qb8KmsdJjp+A==
X-Google-Smtp-Source: ABdhPJxOB0NOz+Hmh8MljGFldwNTND/SjUv3x5DZcQMibHXGfT5vjYJudjq5QYAIPHTDMFo0u2hViw==
X-Received: by 2002:a05:600c:190a:: with SMTP id j10mr1075429wmq.149.1635281200168;
        Tue, 26 Oct 2021 13:46:40 -0700 (PDT)
Received: from apollo.. (cpc73842-dals21-2-0-cust781.20-2.cable.virginm.net. [82.4.111.14])
        by smtp.gmail.com with ESMTPSA id m125sm1466416wmm.44.2021.10.26.13.46.39
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 13:46:39 -0700 (PDT)
From:   Robin McCorkell <robin@mccorkell.me.uk>
To:     linux-pci@vger.kernel.org
Subject: [PATCH] Limit AMD Radeon rebar hack to a single revision
Date:   Tue, 26 Oct 2021 21:46:38 +0100
Message-Id: <20211026204639.21178-1-robin@mccorkell.me.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A particular RX 5600 device requires a hack in the rebar logic, but the
current branch is too general and catches other devices too, breaking
them. This patch changes the branch to be more selective on the
particular revision.

See also: https://gitlab.freedesktop.org/drm/amd/-/issues/1707

This patch fixes intermittent freezes on other RX 5600 devices where the
hack is unnecessary. Credit to all contributors in the linked issue on
the AMD bug tracker.
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce2ab62b64cf..1fe75243019e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3647,7 +3647,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 
 	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
 	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
-	    bar == 0 && cap == 0x7000)
+	    pdev->revision == 0xC1 && bar == 0 && cap == 0x7000)
 		cap = 0x3f000;
 
 	return cap >> 4;
-- 
2.31.1

