Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D266A63D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 12:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfGPKLR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 06:11:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41112 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbfGPKLQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2019 06:11:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so8880334pff.8
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2019 03:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=R81ZzKgxtCEhGNXrZhRMrtHubJyNabvopqXLt4EYV7c=;
        b=bTxhlALZdZwuNaMJD0l76DKiv/xY60vuGKCqaS8QEqqZRcExr5r8b0wvXFTmRJ01Hi
         t+hWMBBM7n7xC7e3ED+y1vL6vldMWi34cXGfhoB6ktO3TCwSjuLu4qfS4+XS0oCg5M1g
         akiBiNwTe4ySYlcurbv/fAKMbXR1Phzha3WFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R81ZzKgxtCEhGNXrZhRMrtHubJyNabvopqXLt4EYV7c=;
        b=t+b1m6j15LBpT8iz2StOAU5D9mZgoSHegSPFMiEPfSPBWjDQfdWJY0YiQ8Ap67Aw2d
         gW0szc7KmLhhaWgF8pZXRmULwS7zwbRecNyV/tg/l3LnCf2e61ghudVZwBVxZOHM6AdR
         ghiTuEPfZ08hDKfXPxvW2ArIhN6Zj4Yg74fN/sS/r+pDOD0omM7FKVyoRB4DfkT5vsGq
         8SRMt9tv8W6NBlnzAGj6E6RetHswuiT1e8onY0hDJ3UA0o9HAMZ9mQNG0vLQp8LYv9vN
         km/0gllgPxzjHQTl11JInVWGfkbmEbJyObhk1X81GP/TOufb/C0De1OKIjkpa668CRPr
         c82A==
X-Gm-Message-State: APjAAAUa9Zwil2A8p1N8l59oUyEBPhzWk+Rsi1/xuZXIlQldoTyBq/qs
        ekII72VZZIMIU3/NHTPq8PhaIWpD15U=
X-Google-Smtp-Source: APXvYqzmndE3ZEiKWKq5APqXbLOEmW9FQSA1N3MEMEcwNkG38eeNgwpsXeo4PZJIJ/mYOmOVZOIOGg==
X-Received: by 2002:a17:90a:5288:: with SMTP id w8mr35239474pjh.61.1563271876140;
        Tue, 16 Jul 2019 03:11:16 -0700 (PDT)
Received: from dhcp-10-123-20-16.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x14sm22966839pfq.158.2019.07.16.03.11.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 03:11:15 -0700 (PDT)
From:   Sumit Saxena <sumit.saxena@broadcom.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, stable@vger.kernel.org,
        Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH] PCI: set BAR size bits correctly in Resize BAR control register
Date:   Tue, 16 Jul 2019 23:39:40 +0530
Message-Id: <20190716180940.17828-1-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In Resize BAR control register, bits[8:12] represents size of BAR.
As per PCIe specification, below is encoded values in register bits
to actual BAR size table:

Bits  BAR size
0     1 MB
1     2 MB
2     4 MB
3     8 MB
--

For 1 MB BAR size, BAR size bits should be set to 0 but incorrectly
these bits are set to "1f". 
Latest megaraid_sas and mpt3sas adapters which support Resizable BAR 
with 1 MB BAR size fails to initialize during system resume from S3 sleep.

Fix: Correctly set BAR size bits to "0" for 1MB BAR size.

CC: stable@vger.kernel.org # v4.16+
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203939
Fixes: d3252ace0bc652a1a244455556b6a549f969bf99 ("PCI: Restore resized BAR state on resume")
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 drivers/pci/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8abc843..b651f32 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1417,12 +1417,13 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
 
 	for (i = 0; i < nbars; i++, pos += 8) {
 		struct resource *res;
-		int bar_idx, size;
+		int bar_idx, size, order;
 
 		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
 		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
 		res = pdev->resource + bar_idx;
-		size = order_base_2((resource_size(res) >> 20) | 1) - 1;
+		order = order_base_2((resource_size(res) >> 20) | 1);
+		size = order ? order - 1 : 0;
 		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
 		ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
 		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
-- 
1.8.3.1

