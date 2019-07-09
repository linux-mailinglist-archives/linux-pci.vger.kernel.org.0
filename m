Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 029CA62D55
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 03:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfGIBSb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jul 2019 21:18:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54435 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfGIBSb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2019 21:18:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so1301528wme.4;
        Mon, 08 Jul 2019 18:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vRVbPF/0ajosmPN4Ay8z+zKHDksJfcNn8uHA4+U9uZo=;
        b=EvzVRlYqYQ6yoFh4cC0XWd3R7HJSf9wCHcq+3VF25GatybqCHlhEimdyv3CtZIHoJZ
         eKcKwd7Mh8chovX6y5xmDSok4vpWLxDVE8CeELXOUD02NVRFPP2EaJu6Vqv3Rb3cxKzd
         pPZa+qQTeZZc/F02daQ2KXOV+ohb8DnRNoTXFE38GtW01YSa7F/F/IX5qH3Y78AumfHZ
         ZX36JEfizHmXGscAanulIZFQshHGKVk15CPg4r2aU0dQOn8ACXFS7bVpJw8qtPyZdqy7
         q9VXU9gPrJzCZSlQ0fgc1XDqIxO+VMQ8ArqHbHNhIMFzMGf8aOfyfXHQhVimcSWGLgSE
         xpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vRVbPF/0ajosmPN4Ay8z+zKHDksJfcNn8uHA4+U9uZo=;
        b=LDPJjFkLr3JJuaZWWT81qBFIKapSMHxffizFCtXnXPveQXCFUchJGdPhVUiY6A8sda
         0RPSrUVmYBIiJYLUNSGNp8dcoc9mrzw8cIkuz7eNm5ntsJQYIgKv3NlEusCjMzSy2m16
         /up7x7n3tG4dfnobPZ+wQ5GlwAQ+Vit/S2eS2SrI72XWQcJU2O1CJSKy9cWbAFcXwB+S
         MTCCwiL+fQGeWxfXgI3ZG30JSfFvULpxDqfMaBPr02dWeu0UfYIakHZYoY1ZZ2jCxET9
         KDHoBBd+XRgEreZ+wAXNbgrx9qxP8o/NVI1aK9cqVcUPh1dC7ZK7RHlT0C85Ojpsu0r0
         0L1g==
X-Gm-Message-State: APjAAAXE2RLDNFxSv5miX/G8pCzRt75xQa7ZOoMXVPE4ddMGLWaqfUAf
        jkU8gPivuLiiDqdKgxkoa1ebT0Sk
X-Google-Smtp-Source: APXvYqxUar/3qwAPoesl+6yYlgNNPaPGwPAqehO4FaJouMJW8FtGegTPfb++Q2YJ7XdU2WGLf6B0PA==
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr17227935wmj.87.1562635108528;
        Mon, 08 Jul 2019 18:18:28 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id a8sm935505wma.31.2019.07.08.18.18.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 18:18:27 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] PCI: rcar: Do not abort on too many inbound dma-ranges
Date:   Tue,  9 Jul 2019 03:15:58 +0200
Message-Id: <20190709011559.12379-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
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
 drivers/pci/controller/pcie-rcar.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index f6a669a9af41..938adff4148f 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -1069,8 +1069,9 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 		idx += 2;
 
 		if (idx > MAX_NR_INBOUND_MAPS) {
-			dev_err(pcie->dev, "Failed to map inbound regions!\n");
-			return -EINVAL;
+			dev_warn(pcie->dev,
+				 "Too many inbound regions, not all are mapped.\n");
+			break;
 		}
 	}
 	*index = idx;
-- 
2.20.1

