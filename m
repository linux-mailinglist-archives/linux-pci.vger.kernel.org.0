Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E01881CC
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 19:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437013AbfHIR6O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 13:58:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40903 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHIR6O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 13:58:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so98972674wrl.7;
        Fri, 09 Aug 2019 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQWTJJ6S7RxirtJD9R73eQy6LDLBWJ0MPzTFIc93ZNU=;
        b=Ft70k0pWg0W4FbRaq6gXE4QluAB+shuXiJWgX0CDVAwZnzDU/B/r9KvOeiDtVd1LNK
         T234jOUilPYn6ARiCAnpjh6hVXulpa+Exh2AVy/BeZVDNIaRYgcE6oEb5GTiLMwvxTvC
         kwAUJ+sQeIygag3B4tkyqquQyComqtlFEK3XiA22OMVbEplk7oouBX9KUjitUfj/Xzwy
         gCRhTqcwfEo1nCofsEFc+dZ/AoTo0lfHQLHJcDwVFC3HP7G0RhRBndTbEAIBEyh2N12Q
         onvzGnCcQGM6mC99GP2wA+KxcYuImYpzllgqrauE2PQbuFt/cDJ5D8+1KIVLJaLwOiFS
         iArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQWTJJ6S7RxirtJD9R73eQy6LDLBWJ0MPzTFIc93ZNU=;
        b=FPrHo2yl/YHIREgsN0sQe1Zmt2qUTALpqZfxgiCTmpCclQIexcGvO9tA4lbJPaFAQV
         03QZCjYsqmD79EseLq0cjM21rWwa5Wzn6NKUZHiZqCJZf1xPUXOZZLvG+TrRXOzXeRng
         fi2eE29vmYjChSzZFJ9Y094jvW8Dl5jK5QbTMZqHTAAynly3OdPKT0KtrHvLD8Nb7J/3
         6EvbaSugE7fuF5U0bVK36hisTC7qw5xZdBx+1k8Qn34s2iCA4X4FTdpxovKNriaSpjnj
         iC6y/VFZRgq//es6XRxs6bnz1r+YKTPC5aPpOtQ8OO5DLQxUJjnF6HVScYhjw6fx02c1
         SiyQ==
X-Gm-Message-State: APjAAAV4vAEsPub1DYFg8tJBV49u/2P/BInIUM/QX2ZSyPykB/PvPTtm
        Yr6UGEG1Rp4jeIbv6trHvNfjfwqq
X-Google-Smtp-Source: APXvYqzQbSQuIpjecKlDRj7fQfRBQoSChICMzbl7EKHQo8257NMpTfD/sMmbqmagMc/M7tarKe6Ssg==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr19935099wrw.73.1565373491844;
        Fri, 09 Aug 2019 10:58:11 -0700 (PDT)
Received: from chi.lan (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id z6sm4078920wre.76.2019.08.09.10.58.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 10:58:11 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH V3 3/3] PCI: rcar: Recalculate inbound range alignment for each controller entry
Date:   Fri,  9 Aug 2019 19:57:41 +0200
Message-Id: <20190809175741.7066-3-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809175741.7066-1-marek.vasut@gmail.com>
References: <20190809175741.7066-1-marek.vasut@gmail.com>
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
V3: No change
---
 drivers/pci/controller/pcie-rcar.c | 37 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index e2735005ffd3..d820aa64d0b7 100644
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
 		if (idx >= MAX_NR_INBOUND_MAPS - 1) {
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

