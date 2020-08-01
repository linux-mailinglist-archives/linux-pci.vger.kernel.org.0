Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3176235230
	for <lists+linux-pci@lfdr.de>; Sat,  1 Aug 2020 14:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgHAMZ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Aug 2020 08:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgHAMY3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Aug 2020 08:24:29 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FAAC06174A;
        Sat,  1 Aug 2020 05:24:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so34004786eje.7;
        Sat, 01 Aug 2020 05:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Hm0xl1/zOdRxUCQdh+5jYfhueeXY+Q37DPWRkan6/c=;
        b=Z1fsyewnXQPs1lEotbQp/siATWa4jPRJDiJOVvbugGAkrgk71MteS23QotXjqzoO6o
         Djbxi2UnNQBeRQetCyJcsmj7XEkbkjEUsrBRRb6SSdxo55cJ1ZZw3oOBTdeEG+T9gawB
         kqNWywFCaiN15ibTWf1BBqrYlc4eZxFrmTcx+hCY6rhOR32GwDODZtJzWI8oqbxgWDev
         ReSpEHfAs2jsheSPy+jkWL96hPBZOWdpyEMcDEoPotp6vo8kMCyYZuAgCYRUcmJsRwj8
         4++uigvxKo2XWAIiON6LohksmU20urMe65RhsLkFj4Tv65j0t+uef+LixeYj3ogSaNCl
         FujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Hm0xl1/zOdRxUCQdh+5jYfhueeXY+Q37DPWRkan6/c=;
        b=raCIMhZ2RshNCSiW2hXwT1c/N/uJ8AChSr76HJG3zQn237f1lm/gBytUhCTf+EHK5I
         9s1yJiyK/oNtaIzgOIW0oEM63m3DJrd8s1nwheGxlKTSgaTmMoeCjiUKvoQyibFyfsX/
         m4AosNrprzH349i7O93RK0srRid+/hroGgeSIiCPZQrAM5782J8KUCg00IUqBfimIO9y
         7K3WFtpsQizxsv6gjGgqeqVIiiCSMHLJGCqLap46OuvjfZiqNLnUsOjU5lmVGnC3Ltqg
         hhXCO+8WokeUIoXzwNnApv+A5S75FAZE4WtO14SSomvvLZ6AtmZkHGWuB4XbqhdjqtNY
         /g2A==
X-Gm-Message-State: AOAM531oCoq6FCnNDI3LvV3qII3tWiNBBBhhcFgFrr2uBUC1QaTOsIzl
        RXyG6dhrnseL+ndo9ahmPlU=
X-Google-Smtp-Source: ABdhPJyuINeMO/fLzFyuKElJkCfpuhowBNnZHWiajwgeM00jZQZtTv2sANzv6LrgYELawrptxq0bLw==
X-Received: by 2002:a17:906:7743:: with SMTP id o3mr8213034ejn.224.1596284667784;
        Sat, 01 Aug 2020 05:24:27 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id a101sm12083131edf.76.2020.08.01.05.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 05:24:27 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [RFC PATCH 03/17] bcma: Drop uses of pci_read_config_*() return value
Date:   Sat,  1 Aug 2020 13:24:32 +0200
Message-Id: <20200801112446.149549-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200801112446.149549-1-refactormyself@gmail.com>
References: <20200801112446.149549-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The return value of pci_read_config_*() may not indicate a device error.
However, the value read by these functions is more likely to indicate
this kind of error. This presents two overlapping ways of reporting
errors and complicates error checking.

It is possible to move to one single way of checking for error if the
dependency on the return value of these functions is removed, then it
can later be made to return void.

Remove all uses of the return value of pci_read_config_*().
Check the actual value read for ~0. In this case, ~0 is an invalid
value thus it indicates some kind of error.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/bcma/host_pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bcma/host_pci.c b/drivers/bcma/host_pci.c
index 69c10a7b7c61..912d5311a444 100644
--- a/drivers/bcma/host_pci.c
+++ b/drivers/bcma/host_pci.c
@@ -372,9 +372,11 @@ int bcma_host_pci_irq_ctl(struct bcma_bus *bus, struct bcma_device *core,
 
 	pdev = bus->host_pci;
 
-	err = pci_read_config_dword(pdev, BCMA_PCI_IRQMASK, &tmp);
-	if (err)
+	pci_read_config_dword(pdev, BCMA_PCI_IRQMASK, &tmp);
+	if (tmp == (u32)~0) {
+		err = -ENODEV;
 		goto out;
+	}
 
 	coremask = BIT(core->core_index) << 8;
 	if (enable)
-- 
2.18.4

