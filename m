Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE144E5EA6
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2019 20:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfJZS1M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Oct 2019 14:27:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40889 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfJZS1L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Oct 2019 14:27:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id o28so5755376wro.7;
        Sat, 26 Oct 2019 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FQQhcfOPZya8MAxlVOl/fI91d8FcIELIgTsbKp4qbw=;
        b=vXkkWsopH3WbTvIhF7sGtrS/ssJH2M++VpTzvJk0lQqMUc63vgj1y2+ey8rW4C2Ttx
         0SLWIJlBK/ICmLjgcaNFgIvQalaENaoxvmLr0/KrTtY3T3AOauCzyZ06K7eCDz6UYa/b
         C7cIVkxF9fMkb/SMWR7eH4JhPHorpeLUNpC4yCZLa27Uuh+6JgPiUWRcMulVCM23x1xI
         XXTRXlnCWf6/u92tr/0mr8S47vjHRCRBOHJn4+k8LFzQYjF1kcvRl5Af5aOxZvQmYpvg
         zphxCdikNUJ8sG0kgy54xnJSbxNV8Y04yPX+RE/PHKfHaTNmSKnxVy1KhyEUOc2oNL4f
         3iMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FQQhcfOPZya8MAxlVOl/fI91d8FcIELIgTsbKp4qbw=;
        b=KqVwfjHX0FWJomwbRHkZh4Hy0f/vcf0TeJ4lxAs2/EGHfvcnAGOo0GgSqVUqQLK66y
         vMPcyKQn4SMCZ+4p5BiQtQz0qIuzBM/YM83LMJoZxJUNzdBAzOQHZTPxwey9CDaTZ9OO
         P1NpRwXbKJmlqNkn++sS/IUi/Lht41PouJPq28DXcUlNuIOuXDNQ6mYNRMI5ZmwaIJ0r
         22hj0U/Ur/WVAkMNHHUgLE1YFmkd2+UAhTH5wwta/DG+tcS/+B8WaxG/Lh314cQd+qwq
         fDDLJbRs0+ZnFvLLGKpKjJQYB5WbiDL682T4TKvs6jZK2Oeqr14LIssIcOyTqq5NCYBh
         bUHQ==
X-Gm-Message-State: APjAAAUWhlKU+TvHG/1cGeECVBOHZPTUKNZfGUrlUIT7CPZowkx+TVNc
        ZznuFkK1KD0PSgMiBbQZOFmXrkcV
X-Google-Smtp-Source: APXvYqyXRGRpvFBhawFL1PBgkGJe/49pwRp3F/A6QfcCQF9TFgLy7cWcwwUb4GC3vOEFw4lEuM88Yw==
X-Received: by 2002:adf:9481:: with SMTP id 1mr4254385wrr.77.1572114427559;
        Sat, 26 Oct 2019 11:27:07 -0700 (PDT)
Received: from desktop.lan (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id p17sm7637982wrn.4.2019.10.26.11.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 11:27:06 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V4 2/2] PCI: rcar: Recalculate inbound range alignment for each controller entry
Date:   Sat, 26 Oct 2019 20:26:59 +0200
Message-Id: <20191026182659.2390-2-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191026182659.2390-1-marek.vasut@gmail.com>
References: <20191026182659.2390-1-marek.vasut@gmail.com>
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
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
V2: Update on top of 1/3
V3: No change
V4: Rebase on next/master and dropped 2/3 patch
---
 drivers/pci/controller/pcie-rcar.c | 37 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index b2a5c3e94245..0dadccb61051 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -1030,29 +1030,30 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
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
 			dev_err(pcie->dev, "Failed to map inbound regions!\n");
 			return -EINVAL;
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
2.23.0

