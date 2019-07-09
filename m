Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBDFF62D57
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 03:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfGIBSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jul 2019 21:18:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37998 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfGIBSc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2019 21:18:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so1374067wmj.3;
        Mon, 08 Jul 2019 18:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7hNWY8uNbIRl37SQi0eQaMekWDSfGmV7hpebI34lt8c=;
        b=npo/sUpfXJcUqz17u/z89ANUyQv6FiXOWQvxEzg1IUOv5EW/d9krTekRbCIJ9SjKBN
         o4WE3uAIHwmQzF4Y7GJWvWi9Kswi1hXGQYhG1skPMksn4fVlueEFUGuCBRnRJDoO9UkH
         nXFvLlJUchqsXXN9bJDbikrQJSz30+kCf4NSXk9OLMRKy1o+QyRdj/xBcNo9Dk42m3mp
         2fipsf3vCphCLUHpcmx/LjTZyKdyt2fxUq4LCeACZmxB2OKhwpLw2GqdwglaBN4wYcK/
         0q6sCSHsOUAa37VYfVwAVOI6MT82koUozQLN1NhtYIDe5oxqvMGTl+deYvdpgZov5JF6
         J1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7hNWY8uNbIRl37SQi0eQaMekWDSfGmV7hpebI34lt8c=;
        b=FL5qrNkywLl83Rubq9P0mI29UcrfrL22YJ7A/1GjFkhW0T1xd7uB1cZUFbgIwVGQ8E
         vCSonWAqD/swqgaFybPpkkCLyskG4Px2fUpn+PMv+5MpLjgAXO7DsmfgaqRDbdmKS7Xw
         dnPbs1EynZxZLYnYtmByayyZ1sOYlbJfrcBDH2GeJ+yCivB6CWA6S0CAAM+wVpgXTP/P
         XTS/Gw4Lnp07BWPrzwUkHT22D0NDtjTZH7tDQUt7YPa1gDu9vF/37KEYKqbnoJbxrCjU
         K98XtXrkIzU7rw9gaFqJ+kXdoWcLMOpLWG0RMA9w1Ey1eDbujrO8MNdwJt6rsyoLJ9Lv
         yevw==
X-Gm-Message-State: APjAAAVNb3Pu2k6jz0ZvYnYfYESctbL9KeqZzmBT7o+9jzsmO/P2pGP6
        O+pwzo6DKjmm+sVKy/XHW4zWE6vf
X-Google-Smtp-Source: APXvYqyxlglEmxp5kkh8NHQLMdo1U+mkZoNWuEemxfDk4AMdRj3uhE3e4QeF5S529Ms8A7Tzg9fwOA==
X-Received: by 2002:a1c:7e90:: with SMTP id z138mr18285817wmc.128.1562635109863;
        Mon, 08 Jul 2019 18:18:29 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id a8sm935505wma.31.2019.07.08.18.18.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 18:18:28 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/2] PCI: rcar: Recalculate inbound range alignment for each controller entry
Date:   Tue,  9 Jul 2019 03:15:59 +0200
Message-Id: <20190709011559.12379-2-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709011559.12379-1-marek.vasut@gmail.com>
References: <20190709011559.12379-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Due to hardware constraints, the size of each inbound range entry
populated into the controller cannot be larger than the alignment
of the entry's start address. Currently, the alignment for each
"dma-ranges" inbound range is calculated only once for each range
and the increment for programming the controller is also derived
from it only once. Thus, a "dma-ranges" entry describing a memory
at 0x48000000 and size 0x38000000 would lead to multiple controller
entries, each 0x08000000 long.

This is inefficient, especially considering that by adding the size
to the start address, the alignment increases. This patch moves the
alignment calculation into the loop populating the controller entries,
thus updating the alignment for each controller entry.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
 drivers/pci/controller/pcie-rcar.c | 33 +++++++++++++++---------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 938adff4148f..48f361b5d690 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -1029,25 +1029,26 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 	if (restype & IORESOURCE_PREFETCH)
 		flags |= LAM_PREFETCH;
 
-	/*
-	 * If the size of the range is larger than the alignment of the start
-	 * address, we have to use multiple entries to perform the mapping.
-	 */
-	if (cpu_addr > 0) {
-		unsigned long nr_zeros = __ffs64(cpu_addr);
-		u64 alignment = 1ULL << nr_zeros;
+	while (cpu_addr < cpu_end) {
+		/*
+		 * If the size of the range is larger than the alignment of
+		 * the start address, we have to use multiple entries to
+		 * perform the mapping.
+		 */
+		if (cpu_addr > 0) {
+			unsigned long nr_zeros = __ffs64(cpu_addr);
+			u64 alignment = 1ULL << nr_zeros;
 
-		size = min(range->size, alignment);
-	} else {
-		size = range->size;
-	}
-	/* Hardware supports max 4GiB inbound region */
-	size = min(size, 1ULL << 32);
+			size = min(range->size, alignment);
+		} else {
+			size = range->size;
+		}
+		/* Hardware supports max 4GiB inbound region */
+		size = min(size, 1ULL << 32);
 
-	mask = roundup_pow_of_two(size) - 1;
-	mask &= ~0xf;
+		mask = roundup_pow_of_two(size) - 1;
+		mask &= ~0xf;
 
-	while (cpu_addr < cpu_end) {
 		/*
 		 * Set up 64-bit inbound regions as the range parser doesn't
 		 * distinguish between 32 and 64-bit types.
-- 
2.20.1

