Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF865881CB
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 19:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437009AbfHIR6N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 13:58:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39780 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436827AbfHIR6N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 13:58:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so8892641wra.6;
        Fri, 09 Aug 2019 10:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNK81rW078tKNHD8lBCI2aUIuH2iKKE88d8/v/IOfyM=;
        b=l82p4N8N17B5IyWLMWnnadHZgMe+xJMQcWPZEeJ4beUymYWmc+aP0vConoaTI+4nhP
         HaLoOGy5J6HIsk5B7gMEYIG4QAIDlhCcfYWxrTlv8Bh8m+NwBPCq5mJHEeVXEtEMnm2J
         B+vZ+9LZ8crEzKrtXnzHUb0BOs6WJHhfUUuuKC3WkH8kFLpjnYclWMdqqEtwHYobVUHz
         JLLI1m6RKB9nbTjMS8AHtWneMHQrachJjvOillNsbLhFjWek82NnVZL4dvFeXxceF/UY
         /8zIbD8qfmnVKxRYLD+3YbGVAYtux2FY+5fOZlh3DJNYupOnQsq7JA+uou4Vfl7aRTt3
         KZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNK81rW078tKNHD8lBCI2aUIuH2iKKE88d8/v/IOfyM=;
        b=GtsJMQItHsFkP5In/+nFOv5lib3NdCLl0JdSTtlIDTjG9a9QV3jl6/UXFLwdR/hCdR
         Xy8NIHBkGD0tQJb8Z8s7c55wz+lPSB6xXxnulQebaZ6jwOPA0pihwXg98D3YITti1Td3
         1zqFZzIVPFWxN7w6znTs0LJLntyDQVn22XThmIW34dx11mhZUqaTqLFTDp1kcv/snFpx
         pxfmXIAbkDhJxNMVQ9ix5xsPT/AsWNz5fmgGjj+Rlb+6plFq/LZ1LOHRsKyWy4Y+as+q
         t3tjj1EeMrEkcNJXK0lb+ShG3mb8gbV3m7E+WywpOfGT0rHh6VAfk7N7zbj/X20ewRk4
         QrQg==
X-Gm-Message-State: APjAAAVumuEnAGgWy5sXiqvnj/czO2Zkh15G46qK+1X7OhTa7l8qWoZH
        aXY9dAFnb6ULuY7N/uCpHakSvTrm
X-Google-Smtp-Source: APXvYqxV/5xxcIvNmDMUNB+ShJLsh4VdHdOTqqymXu2cPy251iQMjm9EhNDyJADnhV1TukokUc2zTg==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr26768399wru.27.1565373490741;
        Fri, 09 Aug 2019 10:58:10 -0700 (PDT)
Received: from chi.lan (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id z6sm4078920wre.76.2019.08.09.10.58.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 10:58:09 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound dma-ranges
Date:   Fri,  9 Aug 2019 19:57:40 +0200
Message-Id: <20190809175741.7066-2-marek.vasut@gmail.com>
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

In case the "dma-ranges" DT property contains either too many ranges
or the range start address is unaligned in such a way that populating
the range into the controller requires multiple entries, a situation
may occur where all ranges cannot be loaded into the controller.

Currently, the driver refuses to probe in such a situation. Relax this
behavior, load as many ranges as possible and warn if some ranges do
not fit anymore.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
V2: Update on top of 1/3
V3: No change
---
 drivers/pci/controller/pcie-rcar.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 56a6433eb70b..e2735005ffd3 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -1049,8 +1049,9 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 
 	while (cpu_addr < cpu_end) {
 		if (idx >= MAX_NR_INBOUND_MAPS - 1) {
-			dev_err(pcie->dev, "Failed to map inbound regions!\n");
-			return -EINVAL;
+			dev_warn(pcie->dev,
+				 "Too many inbound regions, not all are mapped.\n");
+			break;
 		}
 		/*
 		 * Set up 64-bit inbound regions as the range parser doesn't
-- 
2.20.1

