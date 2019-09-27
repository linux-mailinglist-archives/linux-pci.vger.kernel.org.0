Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDC67BFC5D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 02:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfI0AZD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 20:25:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32868 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfI0AZD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 20:25:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id o9so6809otl.0;
        Thu, 26 Sep 2019 17:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JkoxCwhnPe0SFeKySMCtF/hXJiLiKDyHZ2P8cGCAjJ4=;
        b=Z2umiizmy2F46GCtFv/rEpEMlzwFe4iMjl99d8mFPgLtZElqsGJ3hLucgRPEPlM/Z3
         sipX8quj6lthD2Yi1H62hcOvO/jLTw3mxdzleNGnGPSFKqCJR3jVUbmei+wd3BfjNdBr
         xyUs11VC1J7lhUQMP1WVJHLwhHKpcy25xBoSudrRPfwGCxzg9Z3nUcrzCtbKrfXso1hw
         S68umZSleNs/xnYUq6t0+xGS68xMexG2COiBY2Fvz4iv6bz8tB5OZvL9RPrFyFDAT9jW
         Q9Hj5MHynHYAhAo3iU1Bcgb4xR9yYBVZZlv6e1p2WPxbGa82if6Aiw269/+nRhNmkN7t
         FIpQ==
X-Gm-Message-State: APjAAAWydiRvx8Li8EBnz0Q1XTNfTznFEQ1HbWnGcWSjU760Vwli/6cT
        sxgOEyX3oQQd1ZR8OtdcCjhkkSM=
X-Google-Smtp-Source: APXvYqxZR3T1urKVEgD2urD3ZJXLbAOnRlRfEvJiEt8IQGqUlVsJBTO9efMTTpeSgg0sC4mgieqBMg==
X-Received: by 2002:a9d:4e0b:: with SMTP id p11mr1184024otf.280.1569543901894;
        Thu, 26 Sep 2019 17:25:01 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j11sm339866otk.80.2019.09.26.17.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 17:25:01 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
Subject: [PATCH 03/11] of: address: Report of_dma_get_range() errors meaningfully
Date:   Thu, 26 Sep 2019 19:24:47 -0500
Message-Id: <20190927002455.13169-4-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927002455.13169-1-robh@kernel.org>
References: <20190927002455.13169-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

If we failed to translate a DMA address, at least show the offending
address rather than the uninitialised contents of the destination
argument.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 8e354d12fb04..53d2656c2269 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -955,8 +955,8 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 	dmaaddr = of_read_number(ranges, naddr);
 	*paddr = of_translate_dma_address(np, ranges);
 	if (*paddr == OF_BAD_ADDR) {
-		pr_err("translation of DMA address(%pad) to CPU address failed node(%pOF)\n",
-		       dma_addr, np);
+		pr_err("translation of DMA address(%llx) to CPU address failed node(%pOF)\n",
+		       dmaaddr, np);
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.20.1

