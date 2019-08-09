Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3A08818B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 19:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407576AbfHIRsf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 13:48:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53506 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfHIRsf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 13:48:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so6509326wmp.3;
        Fri, 09 Aug 2019 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+ph51ddfAMHxsV4U4mVgIYNDFpq4leR2YkXuGPovKA=;
        b=ODw1VWOk2pY/Y6L8dxZAHgwAh++yC8hcFSobe4N3wZdVrLP43CjF+AhJMhA+9Q92qe
         vPi1ZAlhzw7vC9FvVCYC5fIKU1fLcKa3vNT2Dfns1fa20TIiY3bym/EPNm1KSJvckSp2
         fIGLWIlcaiGZaxx/50Hpi/nF9lxhF19XIOIdbvee04UzJQiTx88011q1i+HWzJIpjk+O
         Zq+b11vyy/fOE7vLYz34tgVMquPKQeQrez+Gdhk/6lYCT2Eam2zN2vvQAEaeo5CmHDOI
         Cxgek5c+RoZpR8B0RpYiXHYFRKZQXwrk3cHaHr9Lk5arFXrshF1+0nGTQnzaYCj8oYB0
         mOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+ph51ddfAMHxsV4U4mVgIYNDFpq4leR2YkXuGPovKA=;
        b=KGebr0AZ4dsfI8JvRhxE82tM+XnyH4/6acgwU1Wkkad3iTMu6FRNxmFbLZwXRw6X2b
         Ii2ghhlkLLbSShRNqb/lFcWzKUEFDm+nR31fjne9UM68qdkO9xNktd3YRzXmSHMwcqz1
         dPl253ehWK3UliDSUsT9EesSX5CNeAoYT0hgxq753dVR+lBIRVOZWvEPbERpf4iJbrj8
         0Mt1lz5uIavBfclEudypjjET+T3siIPOJCCI5xiXt8El95UrdNPptpqOuWPdM11VGrbO
         3lQDVLMR55og/l7VE+PCzdw/poWDFvqUpnoCNj8w8MK7IE3PccoOhSDAaZI05Rmo4HFD
         SLBg==
X-Gm-Message-State: APjAAAWoNqgkXIuB2oDZxi3kA2nVHiQpPnQyCgLIXDuGXTx63ILHS7E8
        9d7pz9Hgi/dubE0YxxO5UFm07op5
X-Google-Smtp-Source: APXvYqxdwunAut7qarespasbnRFivAqSmVHNLCg51VEwmRSEUPncgby36lJVpN1cAWRpRDvZk7FKXQ==
X-Received: by 2002:a1c:80d0:: with SMTP id b199mr11917626wmd.31.1565372912850;
        Fri, 09 Aug 2019 10:48:32 -0700 (PDT)
Received: from chi.lan (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id z18sm3999182wml.10.2019.08.09.10.48.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 10:48:31 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2 1/3] PCI: rcar: Move the inbound index check
Date:   Fri,  9 Aug 2019 19:48:23 +0200
Message-Id: <20190809174825.2572-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Since the $idx variable value is stored across multiple calls to
rcar_pcie_inbound_ranges() function, and the $idx value is used to
index registers which are written, subsequent calls might cause
the $idx value to be high enough to trigger writes into nonexistent
registers.

Fix this by moving the $idx value check to the beginning of the loop.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
V2: New patch
---
 drivers/pci/controller/pcie-rcar.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index f6a669a9af41..0f501acbc3bb 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -1048,6 +1048,10 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 	mask &= ~0xf;
 
 	while (cpu_addr < cpu_end) {
+		if (idx > MAX_NR_INBOUND_MAPS) {
+			dev_err(pcie->dev, "Failed to map inbound regions!\n");
+			return -EINVAL;
+		}
 		/*
 		 * Set up 64-bit inbound regions as the range parser doesn't
 		 * distinguish between 32 and 64-bit types.
@@ -1067,11 +1071,6 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 		pci_addr += size;
 		cpu_addr += size;
 		idx += 2;
-
-		if (idx > MAX_NR_INBOUND_MAPS) {
-			dev_err(pcie->dev, "Failed to map inbound regions!\n");
-			return -EINVAL;
-		}
 	}
 	*index = idx;
 
-- 
2.20.1

