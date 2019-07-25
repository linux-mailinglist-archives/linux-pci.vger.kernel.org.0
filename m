Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5062074D0D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 13:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391878AbfGYL1O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jul 2019 07:27:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40318 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391453AbfGYL1O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2019 07:27:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so22905102pgj.7
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2019 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oOy2/w31W9prrf1qRc4uM+eKhTQbKI+KZqbKGj7rGkQ=;
        b=KRk632jafTWXzbt9QpM3Zs7F1+q7Lo3h5MjlVwdu/ixd5Zts6twKsDYRmrvrWYo2bN
         gaVJRa0JbAHWHdNF3qBqOJQ7lotftk4HgZKM1cAVakcTfubdlQA4dFqMfQ8Bo10tyGn7
         o+H1aSz8+lr6ikvJ+tk5mr70aj/mGmFc2JC4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oOy2/w31W9prrf1qRc4uM+eKhTQbKI+KZqbKGj7rGkQ=;
        b=HPgSEISWVhxBFPO2RHf2obUhSr8LdMUiAvNDkNjuiFYCwbA4ptQRgJLc6E606xVibz
         j0tq1QWx69xvDztBERIDSBRwIjfVcODp3mJwxnjqZCk4a2rTbr3b7beCRrmsEag8sD+4
         OprliXI32qECDOoogqlFKOhLLsWUaiDa7otxtLLxHVx9EfAPaUchwQqwLQywFzgQ/6Im
         XlRNv8uKbVA6wvsX67yghA791JduYYL6VXCfceMZEr4LL081rBTMlHSUUu3qmY4LkF2A
         kCUbumF+Q5NNzBnvjx4I0Npuyge0b/XERIszKhYGS+P9Xa6Zdgd1mCV/xfKAK72nlQmw
         F+Dg==
X-Gm-Message-State: APjAAAXpLaNE7ifDXgheGt3sfyrLd76VdgVIgytsiZNUhE1w38O0vG0z
        Cp9M9vpGtjv4VU+jjsQayAaWKw==
X-Google-Smtp-Source: APXvYqycVbrheRWmSuI10jLm9yQOIA3BdFr8deqlfTumx2u6Pn+8hcM8H4pPBeNr76mcEsvZcvylgw==
X-Received: by 2002:a17:90a:8a84:: with SMTP id x4mr90838017pjn.105.1564054033314;
        Thu, 25 Jul 2019 04:27:13 -0700 (PDT)
Received: from dhcp-10-123-20-16.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id h1sm67214752pfo.152.2019.07.25.04.27.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 04:27:12 -0700 (PDT)
From:   Sumit Saxena <sumit.saxena@broadcom.com>
To:     helgaas@kernel.org, Christian.Koenig@amd.com
Cc:     linux-pci@vger.kernel.org,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        stable@vger.kernel.org
Subject: [PATCH V2] PCI: set BAR size bits correctly in Resize BAR control register
Date:   Fri, 26 Jul 2019 00:55:52 +0530
Message-Id: <20190725192552.24295-1-sumit.saxena@broadcom.com>
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
these bits are set to "1f". Latest megaraid_sas and mpt3sas adapters
which support Resizable BAR with 1 MB BAR size fails to initialize
during system resume from S3 sleep.

Fix: Correctly calculate BAR size bits for Resize BAR control register.

V2:
-Simplified calculation of BAR size bits as suggested by Christian Koenig.

CC: stable@vger.kernel.org # v4.16+
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203939
Fixes: d3252ace0bc652a1a244455556b6a549f969bf99 ("PCI: Restore resized BAR state on resume")
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29ed5ec1ac27..e59921296125 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1438,7 +1438,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
 		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
 		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
 		res = pdev->resource + bar_idx;
-		size = order_base_2((resource_size(res) >> 20) | 1) - 1;
+		size = order_base_2(resource_size(res) >> 20);
 		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
 		ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
 		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
-- 
2.18.1

