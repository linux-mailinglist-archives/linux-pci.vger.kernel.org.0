Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70AF2B4268
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391681AbfIPUru (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:47:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36822 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391655AbfIPUrt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:47:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id t3so716561wmj.1;
        Mon, 16 Sep 2019 13:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRXIYYCqTzf80wPMvUGVQBZL1Q1d4vGLXXoDHnC/zIQ=;
        b=qp/sC5unG5ESbvaTRsJ7m6SuOgxTQQ8ptk6BtJaCJOi/z2Drew6QEZ3u6tBxFH0dXW
         CNHsR1nohingnN7POvKiQpN0MLFQJB9ELBF1uuNACbQB+312oSM3HPhrflvPDsfRcyh3
         Jkjv6fPfJe3Z8adxBhREj+jaZEHDc8KXtHjVLvnW+/HEk9t5iAc+6PURQzQ/3/MBglFs
         xCrs0ROx+VFSA7gFlfE3pLXPUQh5xGpUwigFGTt6+LvrL1uTtw/++WSnlVCMCl6g94fF
         WNKBbpP5GzS4lLYcnP1ciJbt8ebHeEzlJERuKg1iXi3QisxICDwXGI+SV/qxkGaisIZ4
         hvAA==
X-Gm-Message-State: APjAAAVNGSKoiSmoN4cR1lJ+C/D+SqHNC5koJvE+4/jzaFpCS9WhatZb
        JYAKh140ffiyFnRr9fLfCDk=
X-Google-Smtp-Source: APXvYqwTkEolBF+4/h20FKyB+xWEOb8/ZOCtjD6dCrukuPGeL6pmmum3arJeC1C9cYldAM8ty7ZNwQ==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr645276wme.35.1568666867296;
        Mon, 16 Sep 2019 13:47:47 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:47:46 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 24/26] USB: core: Use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:56 +0300
Message-Id: <20190916204158.6889-25-efremov@linux.com>
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

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/usb/core/hcd-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 7537681355f6..3a79e8623d66 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -234,7 +234,7 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		/* UHCI */
 		int	region;
 
-		for (region = 0; region < PCI_ROM_RESOURCE; region++) {
+		for (region = 0; region < PCI_STD_NUM_BARS; region++) {
 			if (!(pci_resource_flags(dev, region) &
 					IORESOURCE_IO))
 				continue;
-- 
2.21.0

