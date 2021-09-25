Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD9541846F
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 22:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhIYUeS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 16:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhIYUeN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 16:34:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2139DC061769;
        Sat, 25 Sep 2021 13:32:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g16so38315200wrb.3;
        Sat, 25 Sep 2021 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YGJlwr2TgrXRfWneKRDsk4/Af6P1h7wSgc5Vc8J2024=;
        b=PFdJIClUviW3KXuNKJE+H6ls1LLMZD8ZnRUiIzhy/EGpa5nuJfcuygtInTm9TxRddx
         L/MN531XpjR64tFqU//TTmtzWx/AyzNYOQ8b/gA8//7KK+NiJqxz0HLCe2jerIkKhQ3l
         BKHTYwb7LxJCaxyYtO5gRD2+22dP4UJ41Oc4xBNxtf+zpu0FaPAcMqqyuISDIUzlKLWO
         C12rvZtUdByHjKXSqv5Rb6rULeUdOxTK555+QZeBjUC5T76LexM6mg1T5p6wMatzpH6l
         mtcQFqO+ghZ2q2QvdgQkY7CWblLcnoZXENDN7LUZMqb18ZsPKYHKEVLjqzU7NaHG0P8K
         UBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YGJlwr2TgrXRfWneKRDsk4/Af6P1h7wSgc5Vc8J2024=;
        b=evuofuscLYezkE0A/fyZPCQ/7YNKPOM8i1hlBL3x1u2i/JbD2ezBCYPEXZI6nI4rh9
         ZPQKTwuL6RwcFUwuqGL0E9bKxGimScw+JbCQLoDEwTaMVgCdW0+AXbDnvWQ81yNtYWZ8
         FLPWrvV4g2HevhCDrzYl9URGhzVbhS0yotbw0H5wBtuqZth7xm3Xrj4oehufq/l9CcOq
         xmbjV5r/O782WssS+GTnL3apc6vE3YOpuqcpo1DFOyecWvp0GFRPoPGvP0PPHCnwh3im
         Y2dPt9Xk06clWeV1AEPYbxB98klpTtjCqcv2lRYpC4eo0hhxmsQeEeUvL3+44bA13gAp
         Z02g==
X-Gm-Message-State: AOAM530DUGYCNEs7E7RWsTnaISibiCYyqpfx661Jkg856wXcIb0D6Kmi
        638CnLvP+KRqqlNRkIvr25Y=
X-Google-Smtp-Source: ABdhPJwIeSjsdRl4hxHnhQhhjCG31SKIMxpVNFgDBVktB0VGtnJwUeufSCGaKYc4FjlkTA8pYynJ/w==
X-Received: by 2002:a5d:6450:: with SMTP id d16mr18209600wrw.40.1632601952804;
        Sat, 25 Sep 2021 13:32:32 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id a202sm16703279wmd.15.2021.09.25.13.32.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Sep 2021 13:32:32 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] staging: mt7621-pci: properly adjust base address for the IO window
Date:   Sat, 25 Sep 2021 22:32:24 +0200
Message-Id: <20210925203224.10419-7-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The value to adjust in the bridge register RALINK_PCI_IOBASE must take into
account the raw value from DT, not only the translated linux port number.
As long as io_offset is zero, the two are the same, but if you were to use
multiple host bridge in the system, or pick a different bus address in DT,
you can have a nonzero io_offset. At this means to take into account the
bus address which is used to calculate this offset, substracting it from
the IO resource start address.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 6acfc94a16e7..503cb1fca2e0 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -482,7 +482,7 @@ static int mt7621_pcie_enable_ports(struct pci_host_bridge *host)
 
 	/* Setup MEMWIN and IOWIN */
 	pcie_write(pcie, 0xffffffff, RALINK_PCI_MEMBASE);
-	pcie_write(pcie, entry->res->start, RALINK_PCI_IOBASE);
+	pcie_write(pcie, entry->res->start - entry->offset, RALINK_PCI_IOBASE);
 
 	list_for_each_entry(port, &pcie->ports, list) {
 		if (port->enabled) {
-- 
2.25.1

