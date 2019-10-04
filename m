Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD21CBED8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 17:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389690AbfJDPQg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 11:16:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45383 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388802AbfJDPQg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2019 11:16:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so6873368ljb.12
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2019 08:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=65IRqF9iEJ/IX4KJA6Ve1T8fQpJLO1C2LUNxK3vGQ5E=;
        b=f2MRXP7pemwsE08WYBFD9zx+OBOxN/DK07TIslWduDw4ib8UA64hvMVOJ+pvmLVKy5
         riOW9NzPV1EA2jIYev4z1TajsyZbQtzg4jVmdtOxhtJ4LDAYk4JEjUcz+RgohrotsBPf
         fq0fLIK5egOj0nEUda3orPnCLOr3C1KVl9uqCjlh9mQ1/EesjvobEtxAbRt+Ovlk0/3C
         Sn7NS1uMWVJjH1Jo0csSfl+Mn+NNZETreIU8jNL5DMxGIil8ptzVCBPse8O6V8CnTB4o
         ougvmsiQFSwyfjJy5VNgY3uwK9Uldz/hq48Vyy0N/tDil/jF/X8Jpcp5DNhymZMKhytt
         YY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=65IRqF9iEJ/IX4KJA6Ve1T8fQpJLO1C2LUNxK3vGQ5E=;
        b=Ps04OiQWBhnv1kmpg4adrJkCs137G+h+657jlGVefXw+hm3lfGbHc5m6G5T7XBEtN5
         OqPcelOaKiofXzk973hZDUOYD53g1JN/hIlaiWC+wr9rzK4nIKKpnFX27NxZHtrqrUWT
         BVt34HcP1QIMYDNTcm0a7HhyRvRhpb8wf19v4mQNnzmJLOKX2smT4M4CLt85yukEhcQi
         WijtBclWtRw9j3gmNSrF8IcShJOo6XXd83SpqL5RdkoLsdxg7RYVbtYAC7eupz9FRZIK
         QvxVvgB2e/7iMM7fgSakdJ+73JzilGWpLioZkHdoHjvgVGXzqejWfw48BnYvHNSk0bIS
         l+HA==
X-Gm-Message-State: APjAAAVzEVNr5MqQ0GB9LgyXnJfF9ewaEwgdOApK1+UVdTmryb9h02tp
        4bofRCEfVclj5PkPVTiuCk9glDcoCG4=
X-Google-Smtp-Source: APXvYqz776iPhohQxfb9KlUykDs4RJV21qYdoJSgz1L14ReT0rVprHhXKxqsHzQByVfcwFC3m3le4A==
X-Received: by 2002:a2e:b00b:: with SMTP id y11mr10185468ljk.50.1570202193998;
        Fri, 04 Oct 2019 08:16:33 -0700 (PDT)
Received: from monakov-y.office.kontur-niirs.ru ([81.222.243.34])
        by smtp.gmail.com with ESMTPSA id q3sm1309077ljq.4.2019.10.04.08.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 08:16:33 -0700 (PDT)
Date:   Fri, 4 Oct 2019 18:16:31 +0300
From:   Yurii Monakov <monakov.y@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     m-karicheri2@ti.com
Subject: [PATCH] PCI: keystone: Fix outbound region mapping
Message-ID: <20191004151631.GA29570@monakov-y.office.kontur-niirs.ru>
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

