Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D326B4249
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733197AbfIPUrQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:47:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35760 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfIPUrQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:47:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so724089wmi.0;
        Mon, 16 Sep 2019 13:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ClDwwNU7E7yVLshOYSMVtt4b9UbBrgClZoV7wecu9U4=;
        b=kx1FcIuxqvx/TvGD90QWt4xhIZr0MLjjtDVYiHMWkygeBFSujBP4FQDu5Vo+F6vaY3
         stlQ4K7oUUXrBK1zm2R70twTq1Hg+exGa2hVWpJkUH7Ojpp3b+L0NikXbEDfiXIe4L82
         ah+BTen1SSD1o/HY5A9y6U1YbsWXHvFyO8ZF2LU6eZF8Dv/kKaR1oXZsgoYx3wx8eKHU
         CjxCH1bIHYi/hqrOaQr6E9F6SYwowTpcikuylyBSeLqD0Xt7QYAqaOICjapY2tMHi49r
         TDPTTmP0uSBok/5Ch+JlwIGj11b/J8AAHzMrwCtK5cuFcsKU0S50Zt+VBxKc1oJ+tBCe
         WBIg==
X-Gm-Message-State: APjAAAUN7xBbYgORE2bYQUB3TnE4xxj99DMOg7NQp1t4BvYCr4TLexQw
        ZLRzKSujOf2B4R5gd0kqz88=
X-Google-Smtp-Source: APXvYqzA8iGacIv6b2eMRXNGIb5zr8TCz3Zb1d24cr0J6lDgd8GrnibalyRautcKXUroaMlIrfhYbw==
X-Received: by 2002:a1c:7319:: with SMTP id d25mr675553wmb.56.1568666834587;
        Mon, 16 Sep 2019 13:47:14 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:47:14 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Peter Jones <pjones@redhat.com>
Subject: [PATCH v3 15/26] efifb: Loop using PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:47 +0300
Message-Id: <20190916204158.6889-16-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refactor loops to use idiomatic C style and avoid the fencepost error
of using "i < PCI_STD_RESOURCE_END" when "i <= PCI_STD_RESOURCE_END"
is required, e.g., commit 2f686f1d9bee ("PCI: Correct PCI_STD_RESOURCE_END
usage").

To iterate through all possible BARs, loop conditions changed to the
*number* of BARs "i < PCI_STD_NUM_BARS", instead of the index of the last
valid BAR "i <= PCI_STD_RESOURCE_END".

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Peter Jones <pjones@redhat.com>
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

