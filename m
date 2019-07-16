Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 153796ADBD
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 19:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfGPRew (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 13:34:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39992 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPRew (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2019 13:34:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id m8so20764714lji.7
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2019 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=U1ln5M2Wl3gVsjRqvWLCd4oEQkwWlQsy/9s+22rpX6w=;
        b=RviBK+1mHVWxBy8mQQo83IpRVNWLoRwfBm68i31KHy02oQAOxbpiX83wHctjFpC+A1
         yMagMNjaBew40FJsqUeJ2Iz81+fMhVAYXqlpvTnGDh6INBEEWRTcMD+dpRzvIMsqpKPw
         wMt0ApJyth8PoHbdOZc4yCo2BPhESTKjmVsmWWgy8OclubRKBvP24BWs9CsCXSqTQ/Zk
         4zwwWbbh1Giq2ja8KUiB5xLWjUiaUP9kY4oISmjch2LP/PiRLPqr43SmRiqunfl9BVEP
         1MZCKkPTMgxlxpbsHQFGkayrqlAcU1laLQSChpr9Aj8hyH96nl0ZgXPBDzbocyhQk3p7
         iWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=U1ln5M2Wl3gVsjRqvWLCd4oEQkwWlQsy/9s+22rpX6w=;
        b=Ak6iYnLDFnC4C9TS4j8g/4wy3+lh60F/aYz2SlJ9fD8pq9Bxm14zgj1A3uxcXHvMOk
         HuMUPuRTt9DsJLqvCSBRgQuyHiKXRjwZr/KEt/NJ4Nv8dyx9lOHOObIjR14TIS4Qvy0h
         LItMaNECKlW4pnG8gSh0Q0mit6GDdatg4btcIb4Pc0KuAuYrPARgFX1Q5lf0HEzAvRjh
         5jBXr7/In7goPbQybBGVZfLaGUTNrtACJTl+5M4pmyyJaa1z8gW3Oi2wMMW5JQ+vV/3Z
         njqdI6NHQP2hqWczvY3vIFD93tbyRVyVQIQIq5DBzFNDQ0EdZ8ooLXlt8369dQ1twfyc
         ae/g==
X-Gm-Message-State: APjAAAVvPA+UL6aIOPkjalTGte2HL9mSWED4Z48/cQw24zTaeDxJ35wD
        lNhEz8bJYBxXN8WIE0djW2s=
X-Google-Smtp-Source: APXvYqw2S1DK8F+9pnEfLxx2gkN+Hei5a3XLh84E3DbwfeZUNEPDKdRKM+2bhB+1/w5Vg0tJTdYg3w==
X-Received: by 2002:a2e:9158:: with SMTP id q24mr18457905ljg.119.1563298490308;
        Tue, 16 Jul 2019 10:34:50 -0700 (PDT)
Received: from localhost ([89.207.88.249])
        by smtp.gmail.com with ESMTPSA id m9sm3278678lfo.45.2019.07.16.10.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jul 2019 10:34:49 -0700 (PDT)
Date:   Tue, 16 Jul 2019 20:34:48 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Allen Hubbe <allenbh@gmail.com>, linux@yadro.com
Subject: [PATCH] ntb_hw_switchtec: make ntb_mw_set_trans() work when addr == 0
Message-ID: <20190716173448.eswemneatvjwnxny@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On switchtec_ntb_mw_set_trans() call, when (only) address == 0, it acts as
ntb_mw_clear_trans(). Fix this, since address == 0 and size != 0 is valid
combination for setting translation.

Signed-off-by: Alexander Fomichev <fomichev.ru@gmail.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index db49677..45b9513 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -305,7 +305,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 	if (rc)
 		return rc;
 
-	if (addr == 0 || size == 0) {
+	if (size == 0) {
 		if (widx < nr_direct_mw)
 			switchtec_ntb_mw_clr_direct(sndev, widx);
 		else
-- 
2.7.4
