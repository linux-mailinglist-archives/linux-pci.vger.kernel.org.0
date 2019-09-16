Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0707EB425A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391574AbfIPUrg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:47:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39050 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391566AbfIPUrf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:47:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so836397wrj.6;
        Mon, 16 Sep 2019 13:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2FqysY5HATBDrBuyFDyYiBCyyYkjbnS9XQbtyyTHOy0=;
        b=GhMsmFP1zvXpfnfVTo1EVsAoGnZ2fuNtYU2CusLxWV/znhtGb0RGeJBLQUyjD4i2TF
         BmgUyCQj+6La8dwUAMQ6pULn6YG5ZLAuD8ZIXokTQ0BGRWxsPJBh61JsMznzwZPwnXP9
         2jsHkumrBxsk8PkN81ZuGOxv39FuRSOS6Qgv9f/SZsjaEAbFDjP/v9vSJ0dYQZkVc42j
         FY6Ew+jkMy/McFio618C6amtQ1hcvSuAD9+U9PR9rCCev3L8wHerF39frCg2ig9fiQo4
         7nmUxfassNcaT8uoTzpxfHHF3FHMpq/Pozys1H6ojr93kHuGvWAbeF47hb/l2Z94dXg7
         VGBQ==
X-Gm-Message-State: APjAAAXkDxbAwnAUNkF9y1vb4uWVIE7pAauwk81xTsJK1wDLcyVPGssY
        zoaJ1AViip+ESEhxibh7HVNcpIPW0zM=
X-Google-Smtp-Source: APXvYqyImLLCgKryGD8YrkgXaU55B5YLepDP0MFlB8OxuTaSZRBDTlao8EoEJYIvZczQZHXYodK1qg==
X-Received: by 2002:a5d:63c6:: with SMTP id c6mr204595wrw.117.1568666853795;
        Mon, 16 Sep 2019 13:47:33 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:47:33 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 19/26] ata: sata_nv: Use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:51 +0300
Message-Id: <20190916204158.6889-20-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the magic constant (6) with define PCI_STD_NUM_BARS representing
the number of PCI BARs.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/ata/sata_nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index b44b4b64354c..31a32a4bb05b 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -2329,7 +2329,7 @@ static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
         // Make sure this is a SATA controller by counting the number of bars
         // (NVIDIA SATA controllers will always have six bars).  Otherwise,
         // it's an IDE controller and we ignore it.
-	for (bar = 0; bar < 6; bar++)
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
 		if (pci_resource_start(pdev, bar) == 0)
 			return -ENODEV;
 
-- 
2.21.0

