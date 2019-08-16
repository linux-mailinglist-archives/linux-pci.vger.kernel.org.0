Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD388FEFA
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 11:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfHPJ0X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 05:26:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34693 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfHPJ0W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Aug 2019 05:26:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id e8so2774286wme.1;
        Fri, 16 Aug 2019 02:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IolRIeTGcRrWhMPHSs5hGUeW7sCKN9H4QrJAPD2CaXs=;
        b=UZxYYnvhNYop13mkLpDgj8Sn+co0KbQBZ7ycyn7IbmZ41BI7cI6V2AdDwwOP5DSrX9
         914lBGPWYiadgpVcpXjA+YWgkIRClT857OUad8PW6Pj0W/EqEkfGatp/XqTZ+tZEJ5bN
         4eX8gZkSehkC2gMRm8B+kU4VMsoV+cijOV+nQLU3IZzSK5JVIQG2guTVuk2L645vamaM
         YNLSvIq528kaLRdchaNNhb/wodgYPtaMzMXIMdRQksWVFqAIiQsyZjz2gulmXmZdpIPQ
         J46DhMWqnb5FVcpIjcf3iDx0w6i4cXGKmSfbzL4bonjllwvzibkuVETPXd2Qj042vsW2
         6gvg==
X-Gm-Message-State: APjAAAVGD73kCMs9zOBTgTidZtHJeW0qYnPQLkpyDhzMPftbt8rOnIhh
        qZap2Nn+UCezDTBHBjUwtgM=
X-Google-Smtp-Source: APXvYqzZTJggv0PlnsUCE87zj1rpi2PYlHhjlC+A+bUWKgcBGnPNV4fmxljDubNFccwPDYU4KCwiLA==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr6179932wmg.155.1565947580049;
        Fri, 16 Aug 2019 02:26:20 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id q20sm16521138wrc.79.2019.08.16.02.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 02:26:19 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/10] efifb: Loop using PCI_STD_NUM_BARS
Date:   Fri, 16 Aug 2019 12:24:34 +0300
Message-Id: <20190816092437.31846-8-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816092437.31846-1-efremov@linux.com>
References: <20190816092437.31846-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refactor loops to use 'i < PCI_STD_NUM_BARS' instead of
'i <= PCI_STD_RESOURCE_END'.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
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

