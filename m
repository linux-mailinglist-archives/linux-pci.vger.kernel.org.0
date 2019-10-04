Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A7DCBFB2
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 17:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389999AbfJDPsQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 11:48:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34325 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389794AbfJDPsQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2019 11:48:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19so7032043lja.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2019 08:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=65IRqF9iEJ/IX4KJA6Ve1T8fQpJLO1C2LUNxK3vGQ5E=;
        b=tIZOTDIX9/mh7HqNCj+3OFxymAY8cJdj9Qu7NPIPclQFmrsCeK2KdYPAufEmEWvx/x
         /xo5oI+ylTxBPCJoJIVPccBZaK4q68BgE2ZZF0761j31uYOErVa5XbpTJAsRUKQIt5g1
         nQp+SGqWwBZEqiliRkAtPidtDKbbPsbtizPn0UI5/fO0+GsMVOyPOXrvZ9fe116TOewA
         70jokXIdg4s710rgmf94uIs3bEJMugB0SLDlxJHH2DYIs4im4iNPToo38ZSb8XAvXBAL
         C9uMyw3aiKxXRqdZz/HXDSAmkJlWrxylKLqJtkdfolurdLqR9XTLGJCwi6WjME0jKJnY
         dSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=65IRqF9iEJ/IX4KJA6Ve1T8fQpJLO1C2LUNxK3vGQ5E=;
        b=Pf/ap7lMsRIEwy7dZ0aVuPQG2+bWR8kuH00vR5PHmIduqij7/gK6M+/VjMBsyGD/H8
         cAX1RbzjIMDx4yHPuKH22Um6fmavy9O5Z2XTtdUvbQxV48Ud27Ped87fyQl40lSPDxrH
         FJQknxrTSM+SINRdMC5PaFU/kxdefX+SNEXQEgbtJ2cB8qNU+7wwEHsZfe0jrBMkkvSu
         1/jxuBKuTJNw8OrgV9XBpMGAOHrWFFjBr+lo5SJLzG8dr4FXSjJ4fW1o7x9fh1INGgzn
         qv0Kfp3ALT2tAdAN5sAhJp4ttOyDYEefZq4dptPrdhJEttPR649SWC2wmivgbxQx/sC1
         dgTw==
X-Gm-Message-State: APjAAAX4OCSvT9huqTyHwk2GUKeu4/GYjNFpRWAUtVBalO/1/E4hxtU/
        H3feTfIgVFgvELLNKqY7Ty7gOZHKzvw=
X-Google-Smtp-Source: APXvYqyICBsbJ0YaZB241pxgd14d/34wYhv0f9VzYlt+AadDwu4G/o5yGHwcl8yBO539y9EHYHfGtw==
X-Received: by 2002:a2e:8789:: with SMTP id n9mr10110278lji.52.1570204093988;
        Fri, 04 Oct 2019 08:48:13 -0700 (PDT)
Received: from monakov-y.office.kontur-niirs.ru ([81.222.243.34])
        by smtp.gmail.com with ESMTPSA id 14sm1411020ljs.71.2019.10.04.08.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 08:48:13 -0700 (PDT)
Date:   Fri, 4 Oct 2019 18:48:11 +0300
From:   Yurii Monakov <monakov.y@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     m-karicheri2@ti.com
Subject: [PATCH] PCI: keystone: Fix outbound region mapping
Message-ID: <20191004154811.GA31397@monakov-y.office.kontur-niirs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe window memory start address should be incremented by OB_WIN_SIZE
megabytes (8 MB) instead of plain OB_WIN_SIZE (8).

Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index af677254a072..f19de60ac991 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -422,7 +422,7 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 				   lower_32_bits(start) | OB_ENABLEN);
 		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i),
 				   upper_32_bits(start));
-		start += OB_WIN_SIZE;
+		start += OB_WIN_SIZE * SZ_1M;
 	}
 
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-- 
2.17.1

