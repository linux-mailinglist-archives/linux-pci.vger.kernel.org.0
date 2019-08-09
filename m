Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD65E8818F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 19:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407580AbfHIRsi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 13:48:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39806 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfHIRsh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 13:48:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so8871046wra.6;
        Fri, 09 Aug 2019 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N8v/vsKYyFK0GSXJqNCKBYrpEsFmIGgnkcwBPmA9Px8=;
        b=HApaXr0M5NTA2CpdC56HOPjOzxweksKhrsgaZoNkFAvok7lzjlEqTwoKbMMzxxhOZW
         Hl8iOYfidKYwfJeWWXkpLqU7zkZVbk15k6AkoJZOLBccpBiCcukh9HpUAz6FXGgmW6M6
         jkoKPoaGT+bZeJCTVRE8iVBLHxW2j43LaYHApusLkHiVjkcCe3UEin8e/FfiN3WJs7uK
         BLJuqnSrww/EStjbV+nSuuQLzYdAfd4fl83wfD1GU70hwzG6PYh1xsLykHpuR5UBE9b0
         kpPjQLECAdOuTzCJI6eFpNjdiYV506xSwL8845+j6NlPfJ26QCO8ZpQdTNDeLdv5jf6m
         vOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N8v/vsKYyFK0GSXJqNCKBYrpEsFmIGgnkcwBPmA9Px8=;
        b=Vrn9dUZIegabjcEShGKIXUOjXodpW72G2VVLiRfnpOTvYQALvU+O7b7EKRe10kbeRR
         /ztzFDrv3T022P+WFKcqHEfG3vywuBwaOcQ6jlAM8fwSRNhVxi0TmoKqFZ/k6bZFIDUo
         d9lcPCgWEQcISYbJjdChl5wXhmUf2G3RJnBSddDXgnHNJFhQvAS5BzUh5U1THz/EbCjR
         fp5PRT4pDlgdjE9DC1eP+6UM0ZErW44TErqqa31VgJsYEHX1IkKK+shx1SmACoIT/F0m
         6pnpVCt14O5kI3nbn1i0aODIyaGjKV7NCX1xr3krVoiPZhu4RZn1aU+0zYWyCPoS/JSN
         nUgg==
X-Gm-Message-State: APjAAAVBw0oXoRsFf7ZRUuXABkR3Dp8U9WP2HDaRYpfuy6fg4VraV9vx
        4SYpVtRfL0skWatjhvcKC9eYrdt+
X-Google-Smtp-Source: APXvYqy06agShtnC/TUqiPscb+vnYZRqB/on6L/9kiqrRPA1PpjYm9vrQCEsbgngrLUBU65i3GwsDw==
X-Received: by 2002:a5d:63d0:: with SMTP id c16mr20467423wrw.22.1565372915112;
        Fri, 09 Aug 2019 10:48:35 -0700 (PDT)
Received: from chi.lan (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id z18sm3999182wml.10.2019.08.09.10.48.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 10:48:34 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH V2 3/3] PCI: rcar: Recalculate inbound range alignment for each controller entry
Date:   Fri,  9 Aug 2019 19:48:25 +0200
Message-Id: <20190809174825.2572-3-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809174825.2572-1-marek.vasut@gmail.com>
References: <20190809174825.2572-1-marek.vasut@gmail.com>
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
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
V2: Update on top of 1/3
---
 drivers/pci/controller/pcie-rcar.c | 37 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index ee760bdc7786..dd8da6ef8323 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -1029,30 +1029,31 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 	if (restype & IORESOURCE_PREFETCH)
 		flags |= LAM_PREFETCH;
 
-	/*
-	 * If the size of the range is larger than the alignment of the start
-	 * address, we have to use multiple entries to perform the mapping.
-	 */
-	if (cpu_addr > 0) {
-		unsigned long nr_zeros = __ffs64(cpu_addr);
-		u64 alignment = 1ULL << nr_zeros;
-
-		size = min(range->size, alignment);
-	} else {
-		size = range->size;
-	}
-	/* Hardware supports max 4GiB inbound region */
-	size = min(size, 1ULL << 32);
-
-	mask = roundup_pow_of_two(size) - 1;
-	mask &= ~0xf;
-
 	while (cpu_addr < cpu_end) {
 		if (idx > MAX_NR_INBOUND_MAPS) {
 			dev_warn(pcie->dev,
 				 "Too many inbound regions, not all are mapped.\n");
 			break;
 		}
+		/*
+		 * If the size of the range is larger than the alignment of
+		 * the start address, we have to use multiple entries to
+		 * perform the mapping.
+		 */
+		if (cpu_addr > 0) {
+			unsigned long nr_zeros = __ffs64(cpu_addr);
+			u64 alignment = 1ULL << nr_zeros;
+
+			size = min(range->size, alignment);
+		} else {
+			size = range->size;
+		}
+		/* Hardware supports max 4GiB inbound region */
+		size = min(size, 1ULL << 32);
+
+		mask = roundup_pow_of_two(size) - 1;
+		mask &= ~0xf;
+
 		/*
 		 * Set up 64-bit inbound regions as the range parser doesn't
 		 * distinguish between 32 and 64-bit types.
-- 
2.20.1

