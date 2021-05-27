Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2622D3931D7
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 17:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbhE0PKN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 11:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbhE0PJX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 11:09:23 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F4AC06134C;
        Thu, 27 May 2021 08:06:58 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v14so148151pgi.6;
        Thu, 27 May 2021 08:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iACzWLVmLzVGbDObuCyVoRniRyVY+AS4XvWtkzM+TCA=;
        b=I2De53zHx9sUeH8xO92FDmgThOftuNThtNqV5rWNq1pHXmfUN4/RLRt2WmCja/ggqV
         T3UOSnxCHHYvO11KVWPHsJaUuSK6Qp+y+MZN6ylxeSKetTvJ+kQk9v38scgP8SX40RB1
         qEIfEmnMXvWOXxPLHdr9RAUATZolBfGHEkN1jd2JlgF/PnI58EW1Afqd61Pwmkj32o/W
         qen5UBx6G0SCdSJ98kuukoVQ0ukfFmRVMv/jjHcxzYC5hzyyeEzzdUBip5kUCTnRYAXB
         Uet5pYz1KkCmoTnB+vMkX00OHqZ33+hm4Y8gMkpbNtS3xuNmbZeWwR8iCeE/Xjv+CMFR
         7VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iACzWLVmLzVGbDObuCyVoRniRyVY+AS4XvWtkzM+TCA=;
        b=rkf6x9Eui0RqqITFA+atzApRUGpvH9YWuLecZV6gzqRUFRiiRvSAgLJ29llj4L65Ao
         emXUB4ivfnxW5hQl3DURU9aIN5lwC6DriTBvNsM09UI6A72hPeAjFizK1ao13v1zJCjC
         pRWnMM/ItFmUX12+ZtrKNP+w0PlikHmmhzLJYvujjvzEGt1Jxv/77RyTUxyPwXLkF15L
         RzB3DKvUL0vS9ZK7lvkcdPlw6qH5TemcSE9PWmPRfU/jbn+caxPuvi15KQAo9d33LhDa
         l8fXmANE4+sMMy0xLJQ6R8Iq5slWJlcA2u0Zr/Q3SmNP9hwQw7P0nvTPSlKcBXIrq2Xy
         vfPg==
X-Gm-Message-State: AOAM532x/h4/LgvTZ+4AS9fCmXkkBZCmtudRU/Hfhwd3qTu+UOMwzDHm
        cLWRmlhhFG5+qv8DBkcxqIqgFd8wAfI8Ug==
X-Google-Smtp-Source: ABdhPJyt2y6yo8Mr4sui/jdnkdSlmaGceJ+XDZGMAA0LUyLXGITxqn+34JTAuCKZr9wZptUBvqo/rA==
X-Received: by 2002:a65:6a44:: with SMTP id o4mr4078506pgu.145.1622128017670;
        Thu, 27 May 2021 08:06:57 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id mp21sm2315194pjb.50.2021.05.27.08.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:06:57 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandru.elisei@arm.com, wqu@suse.com, robin.murphy@arm.com,
        pgwipeout@gmail.com, ardb@kernel.org, briannorris@chromium.org,
        shawn.lin@rock-chips.com, helgaas@kernel.org, robh+dt@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] PCI: of: Override 64-bit flag for non-prefetchable memory below 4GB
Date:   Fri, 28 May 2021 00:05:41 +0900
Message-Id: <20210527150541.3130505-2-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527150541.3130505-1-punitagrawal@gmail.com>
References: <20210527150541.3130505-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some host bridges advertise non-prefetable memory windows that are
entirely located below 4GB but are marked as 64-bit address memory.

Since commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
flags for 64-bit memory addresses"), the OF PCI range parser takes a
stricter view and treats 64-bit address ranges as advertised while
before such ranges were treated as 32-bit.

A PCI-to-PCI bridges cannot forward 64-bit non-prefetchable memory
ranges. As a result, the change in behaviour due to the commit causes
allocation failure for devices that are connected behind PCI host
bridges modelled as PCI-to-PCI bridge and require non-prefetchable bus
addresses.

In order to not break platforms, override the 64-bit flag for
non-prefetchable memory ranges that lie entirely below 4GB.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 drivers/pci/of.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index da5b414d585a..b9d0bee5a088 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -565,10 +565,14 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
 		case IORESOURCE_MEM:
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
 
-			if (!(res->flags & IORESOURCE_PREFETCH))
+			if (!(res->flags & IORESOURCE_PREFETCH)) {
 				if (upper_32_bits(resource_size(res)))
 					dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
-
+				if ((res->flags & IORESOURCE_MEM_64) && !upper_32_bits(res->end)) {
+					dev_warn(dev, "Overriding 64-bit flag for non-prefetchable memory below 4GB\n");
+					res->flags &= ~IORESOURCE_MEM_64;
+				}
+			}
 			break;
 		}
 	}
-- 
2.30.2

