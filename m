Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE20CB4262
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391649AbfIPUrn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:47:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36811 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfIPUrm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:47:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id t3so716328wmj.1;
        Mon, 16 Sep 2019 13:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOS2e0UepoELcBHR5ni67YDdvRavbzFfhcVGtDlKQTM=;
        b=XuITJ9/tp8KJKAOzlxh+TZajIZPbu3WOS+0GYuDCdB1P6CCJwR427RVA3O7p30prmn
         vfSAg7YXYnqaTnFS9wx3Rbybi4a7eLo7sXrxNwCS3JBzfq0nnCxZwtHaLLTgc6jLtgL9
         eXOjlpkr45umzNYfnvSEcfh6jexgaKDZl+e7RsmIWSqX3RO8+YBZ48VtbF4MC5QaaM7L
         XOdGvEynhthhfaDyewdsJyhguGFGTRwgPG5STf0db4sVmOdC1/t4Vkgg1GyjAVnvugIp
         gP5CByKEyjlomYJ8eecNEuEBtxuJcmRx61QQ2Pjew0bCVX8Od/usrvizNu3e2wJopX+O
         jlnQ==
X-Gm-Message-State: APjAAAXJ3IeFtAZAFL1Red45Fi5S3r2Mg9weE48nqhXVvNIa1YlODHQF
        waGsMAL19QQZO3hXIRv/tUU=
X-Google-Smtp-Source: APXvYqyX7XAbGO/BUSR5X35Cw9AHSwDhRRkjMy4wE0zfriRWnFmzs7vmkDcxj9/qRp/WecFZalwX9Q==
X-Received: by 2002:a1c:bcd6:: with SMTP id m205mr631830wmf.129.1568666860528;
        Mon, 16 Sep 2019 13:47:40 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:47:40 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 22/26] pata_atp867x: Use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:54 +0300
Message-Id: <20190916204158.6889-23-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use define PCI_STD_NUM_BARS instead of PCI_ROM_RESOURCE for the number of
PCI BARs.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/ata/pata_atp867x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
index 2b9ed4ddef8d..019198eb7099 100644
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -422,7 +422,7 @@ static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
 #ifdef	ATP867X_DEBUG
 	atp867x_check_res(pdev);
 
-	for (i = 0; i < PCI_ROM_RESOURCE; i++)
+	for (i = 0; i < PCI_STD_NUM_BARS; i++)
 		printk(KERN_DEBUG "ATP867X: iomap[%d]=0x%llx\n", i,
 			(unsigned long long)(host->iomap[i]));
 #endif
-- 
2.21.0

