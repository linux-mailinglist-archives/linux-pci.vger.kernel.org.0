Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBAE89238
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 17:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfHKPKL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 11:10:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36956 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfHKPKK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 11:10:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so548516wrt.4;
        Sun, 11 Aug 2019 08:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G2Y0IzyQvN3L+ryh+30m+GJo2QD0YzGvKKX16dAP924=;
        b=QXkkY5MdsJvsohfboQ5kWIBIKMbiQuiSoQQ0+Io4NJRUXtKLLuMzlfDGBSzjcSWRkq
         fHzI3xjZX4I3afoyhMS7lDlX8Bvccor27juwc7tIXa/Sx7+1K6u812J7i7Gbcm9EEHUY
         JljlrHV14SnV5g75lEwEbYfp+rPlCCgs3XL15iNBxqS+M0vATQtiZ3+0DWuwD5pY1wiG
         GWhJ6qHpfbfKo/IBIWnYNnznO2bQOBLJ99ei1krPs1acNNADMjLF6k9EXxPLUtIyACZu
         ErI5ZVEyfs6kXf4uGfdronAOstb2GKMKchjW6f3iY9LEbn4eXKsI7tTCVVUGnQbMgZXe
         4Hcg==
X-Gm-Message-State: APjAAAWy91PySrVk2t8jN9kpW6lxfYIwRBrHCQUuPpH2856wDoe+NBeF
        Js6vT5S1T3Do+54HozHVYVo=
X-Google-Smtp-Source: APXvYqwAOyO7u1Z+QZQa8A3kWzhh/ybTau/WlFtAYxoFb5yBtOy8Kt0sU2iNBawz8TrvflkZW3rWHg==
X-Received: by 2002:adf:f186:: with SMTP id h6mr35004721wro.274.1565536208696;
        Sun, 11 Aug 2019 08:10:08 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id y16sm227049408wrg.85.2019.08.11.08.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 08:10:08 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] rapidio/tsi721: use PCI_STD_NUM_BARS in loops instead of PCI_STD_RESOURCE_END
Date:   Sun, 11 Aug 2019 18:08:01 +0300
Message-Id: <20190811150802.2418-6-efremov@linux.com>
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
 drivers/rapidio/devices/tsi721.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 125a173bed45..4dd31dd9feea 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -2755,7 +2755,7 @@ static int tsi721_probe(struct pci_dev *pdev,
 	{
 		int i;
 
-		for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
+		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 			tsi_debug(INIT, &pdev->dev, "res%d %pR",
 				  i, &pdev->resource[i]);
 		}
-- 
2.21.0

