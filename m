Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CA721D6C3
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgGMNX1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbgGMNXZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:25 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23E7C061755;
        Mon, 13 Jul 2020 06:23:24 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f12so17133529eja.9;
        Mon, 13 Jul 2020 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ogb36sa6vQqtiEyWjTGxiNgWIm0WCLEYPRrILza4y+A=;
        b=gSWxYJ9bQdXtfjpV5tTR8o48guQJpHgLZf/AFrheK3RnuqHSN8PTPjtDsp1el2JhLA
         xFCqfnmY4I7S2CJAQ1NmuTzbhZ+piSkoZznsvy3Ns6sv6mxGXQY1LdtWlLP+9RnLbvXe
         r/Z3B8mPu7oFnRhOq8liQCkwx28YatrK0EbWmFhCqq/6Rr79MhPcZV4WnSI65ji95OpV
         ms24mXH2uX3XY+qu+zM38pKy89l+0Gj1XPT4jmw8tkzOC0+cpGPcRFakRw5saJjkZrdH
         lY4jJJb8LP1Ym3wBB9vuW3lr9lDBYXspDKgKgVf6kbF4xOtHe02GGveSvba0Tbzeq0Zz
         tSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ogb36sa6vQqtiEyWjTGxiNgWIm0WCLEYPRrILza4y+A=;
        b=Wh28Jd0x3OCWzsv47ogDDKPj98/4x+x7bcwkfJX5WNgfvevfWp2uFXKaW1nhJCIg6T
         MAF5pbj8TfQ+OMj/W07n+wyuq3BaZ+AniuXWErgceqjwkmMJqDwEYz/3cIxqkpO4TW+n
         JbQKAJ8qfcbVvc4mnrmzNs/BoD4SMQrECG0l12PxrXj2vJX0Tf+m8yRjUUNfodkhdoR4
         6LGb5CM4DwN5FaFzPeSlMDIM+58/Dgeryg+kCPeTolSqz7uK+hQdEu1b7c4E8RoOxCH9
         5cKcCfiIIQkPGg2bYwszuaY3vzXn7GgC7nT3GdiN5l5kk3GbbJji7OClEWhVoNDdpfyK
         UhIw==
X-Gm-Message-State: AOAM533TpyGxBpxrmeC90F5/a+o/IuhZvsE2754rcbd9XOyk2BA3uCBS
        c86YRKHkQcptoI+cxJJ3k1c=
X-Google-Smtp-Source: ABdhPJwwo3WT8dxUL0Kf6TWRHS0OPQZfA5A+WaxpTkL2dVH32LbSdz8Gf2rnEGSvvqVJFQLgzS7Lig==
X-Received: by 2002:a17:906:7c8:: with SMTP id m8mr73051911ejc.527.1594646603546;
        Mon, 13 Jul 2020 06:23:23 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:23 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 35/35] alpha: Tidy Success/Failure checks
Date:   Mon, 13 Jul 2020 14:22:47 +0200
Message-Id: <20200713122247.10985-36-refactormyself@gmail.com>
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
This patch depends on 34/35

 arch/alpha/kernel/sys_miata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/sys_miata.c b/arch/alpha/kernel/sys_miata.c
index 1b4c03ac34d8..539f803c1614 100644
--- a/arch/alpha/kernel/sys_miata.c
+++ b/arch/alpha/kernel/sys_miata.c
@@ -185,7 +185,7 @@ miata_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	if((slot == 7) && (PCI_FUNC(dev->devfn) == 3)) {
 		u8 irq=0;
 		struct pci_dev *pdev = pci_get_slot(dev->bus, dev->devfn & ~7);
-		if (pdev == NULL || pci_read_config_byte(pdev, 0x40, &irq) != 0) {
+		if (pdev == NULL || pci_read_config_byte(pdev, 0x40, &irq)) {
 			pci_dev_put(pdev);
 			return -1;
 		}
-- 
2.18.2

