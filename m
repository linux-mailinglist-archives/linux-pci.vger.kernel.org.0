Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33814495B22
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 08:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiAUHsc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 02:48:32 -0500
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25547 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiAUHsb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 02:48:31 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1642751305; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=kCb+omkDYYAaxGpiHyvuYkAfKLaQ2P2VxSvQAqORX8rJ4RIJ1t6BvPZYVwwqSCMPUMvyYJ/unIKUjYNfNtQYLbk1jTa+kUEgzaXydQ/iwUU4xOMJBCnKpT9wKvmx+BUMdZtH/KXEIC512/V2y4kIbcUHft/Xwh+sspgCou3TRcM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1642751305; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=zS/E46hjknZynnTCbq+uMMNxcBLhWVmkZSc8YyaFfk0=; 
        b=kDCvnLyexiK+NFcKB1H3wgZ5r5wPtLQKM6j10ddiIT4N98pGOYSAuSurQhUGXzdktPzWhecvEDgzlRAhMRYjn17hf+KX6lwn40YKJQ8HYglUh+0mp9P6Pcs3Z5Y+9U2e2UZ1PmAw6LpN9ZEDsDxCOivHJ8E28QKpnEgipBhB4y0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642751305;
        s=zm2020; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=zS/E46hjknZynnTCbq+uMMNxcBLhWVmkZSc8YyaFfk0=;
        b=AM+6ogz5Skx4LeunRCdp5WhHxlgGwCiNdFm7d1V9ZN1JS4aPfsf8tkg2beyEjeDD
        g5G8/LtCkhOjlciHh1LU+vHAX9F0zwQwI4As1RzxSYDm6dYQQxvpFK9uMAyLWD5rDLD
        cH6U0m0vii/roCmyef+O51riS8Rovnt0BwtRwQgk=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1642751303433442.1455374520232; Thu, 20 Jan 2022 23:48:23 -0800 (PST)
Received: from  [203.218.243.128] by mail.zoho.com
        with HTTP;Thu, 20 Jan 2022 23:48:23 -0800 (PST)
Date:   Fri, 21 Jan 2022 15:48:23 +0800
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17e7b9b9ee6.c6d9c6a02564.4545388417402742326@zohomail.com>
In-Reply-To: 
Subject: [PATCH] PCI: endpoint fix misused goto label
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

If we goto err_map_addr here, buf allocated
via kmalloc won't get freeed, then memoryleak.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 96489cfdf58db..60303223976a1 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -441,7 +441,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		if (!epf_test->dma_supported) {
 			dev_err(dev, "Cannot transfer data using DMA\n");
 			ret = -EINVAL;
-			goto err_map_addr;
+			goto err_dma_map;
 		}
 
 		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
-- 
2.34.1


