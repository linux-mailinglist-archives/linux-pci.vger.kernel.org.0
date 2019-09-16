Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F07B426C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391655AbfIPUrw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:47:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34066 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391687AbfIPUrw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:47:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id y135so871409wmc.1;
        Mon, 16 Sep 2019 13:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=52Ok3SbrITEZp2+/epaFkzm4cA6Xg3yiQs6lhoB6dtE=;
        b=QmsRC2A8rWI/D2+psCaMFTL1158kKui/MBsjBR58T+JdQxzO46kpmZD0gNZASTt1Su
         FRfLbAhaaXZvwNJBBuY9Ek/0YgdRycz7TJT7OrBL88RYtoJ3Rropdy0IEfhkbpsDtzxA
         CtL2mLD5WJbpDYLuenOieIYXjTixnzapYY0qS3ZZVY4WRsgwDzUwPkMBwqdb/O50gvJz
         bBzNBgJUhQDFjrusqKUCdvo6Mdh53m2fw0zMld/z9IbRD9qoQ0Oaa7S98seYgT/PMP/y
         A9CJ9sMFBdgdCqEB4L3622CaPT1DlbPmBoIJHlCRkugpMyfHHgl3tAAcetT9nlUHfQfy
         jMEw==
X-Gm-Message-State: APjAAAUMagXesZsU+yNwgfK8C4AVifxWE4RM0CEvdbV3jnSCMYXFKl1d
        jwgwfJxxp6cD9gBVkdfiabA=
X-Google-Smtp-Source: APXvYqz6Jmo3KBQBa3LCnNmy1P65ruQhcV1dGeEJa0J9si07nknK6v9wQUPUY21xKRf/Wf3b3Yux/Q==
X-Received: by 2002:a1c:7c0b:: with SMTP id x11mr675946wmc.92.1568666869752;
        Mon, 16 Sep 2019 13:47:49 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:47:49 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 25/26] usb: pci-quirks: Use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:57 +0300
Message-Id: <20190916204158.6889-26-efremov@linux.com>
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

Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/usb/host/pci-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index f6d04491df60..6c7f0a876b96 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -728,7 +728,7 @@ static void quirk_usb_handoff_uhci(struct pci_dev *pdev)
 	if (!pio_enabled(pdev))
 		return;
 
-	for (i = 0; i < PCI_ROM_RESOURCE; i++)
+	for (i = 0; i < PCI_STD_NUM_BARS; i++)
 		if ((pci_resource_flags(pdev, i) & IORESOURCE_IO)) {
 			base = pci_resource_start(pdev, i);
 			break;
-- 
2.21.0

