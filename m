Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C408923C
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 17:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfHKPKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 11:10:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43182 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfHKPKS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 11:10:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so27909813wru.10;
        Sun, 11 Aug 2019 08:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vj2vxmEq04G+0lv3DiBK9P3rP7zDECsRpielYU6EHVQ=;
        b=BJEmKCR9rKbO/86x4Vb3gYf2GGTlDGyo0AFhR3ZKcxYF4C/H+waQFYI2re02H3k3k6
         XlYiH3+ykF5CR31jtQ2v1t5QnB9onVozi5HKWwKecaeCBHm4UlkTQZtMYUpUv+/TOP9x
         MYy4wRtDNqb1wrIq9k7hkIOHV5L7P4ZAV+PLirmnDEBfPTGELXF0F2fqYJ/Ho8gwJ2uA
         QulUB8mbt6WEa6b3ts4vytEcEEnzUhNoSKZEkRnsWWHJ4TEWj9AO0PHE2KLQmmJGNH82
         cIvttOZjaHfxuCNIQiPe3amkdKUIVqOxDAU5NWwWpvI1zPEh6+dprooZ2Ef8uLWEY40+
         52Hg==
X-Gm-Message-State: APjAAAV86/HGT3KZQuBjzmhSSiWyaacvYlt7CwRi4ZHFJGVvXI42dAbk
        7WBBaILPl7gwwQXnF+BP8fE=
X-Google-Smtp-Source: APXvYqzD15wCpqhoSznLdo+VOoB+/5W/wWM9KDpP06MrKPaWev2h+3Mx8cU8mRArMcKwxx7SkWaU/A==
X-Received: by 2002:a05:6000:1085:: with SMTP id y5mr27884882wrw.285.1565536216498;
        Sun, 11 Aug 2019 08:10:16 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id y16sm227049408wrg.85.2019.08.11.08.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 08:10:16 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] efifb: Use PCI_STD_NUM_BARS in loops instead of PCI_STD_RESOURCE_END
Date:   Sun, 11 Aug 2019 18:08:02 +0300
Message-Id: <20190811150802.2418-7-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190811150802.2418-1-efremov@linux.com>
References: <20190811150802.2418-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch refactors the loop condition scheme from
'i <= PCI_STD_RESOURCE_END' to 'i < PCI_STD_NUM_BARS'.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/video/fbdev/efifb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 04a22663b4fb..6c72b825e92a 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -668,7 +668,7 @@ static void efifb_fixup_resources(struct pci_dev *dev)
 	if (!base)
 		return;
 
-	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		struct resource *res = &dev->resource[i];
 
 		if (!(res->flags & IORESOURCE_MEM))
-- 
2.21.0

