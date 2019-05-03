Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B47E612697
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 06:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfECEAX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 00:00:23 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38687 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfECEAW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 00:00:22 -0400
Received: by mail-oi1-f195.google.com with SMTP id t70so3472176oif.5
        for <linux-pci@vger.kernel.org>; Thu, 02 May 2019 21:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yoA0qcUcZf9hNKPIWW0C4rSDs4LhPQglzx9oFAh3Sp8=;
        b=PCIU09pTLCDoNBfuGUpnEwF/031Tw8z2XMWTENYF9S2enJJC9C0X9GP97RazgMNftx
         J6TBwEw1BI93Psj5Fw+9WbYsRWjhAiAMwoF1SBTxWFRmBdt2b2fDMC1CAu6pJl6u9CUk
         bBaeR5fHRRQQ8ZadgpMzUqYf+1ahLXHpYwsuKWhrVrZWvh+TRaJ8nuhU6hi3RNndaYPN
         z67KgNqV3la0jAkzrIA130TI32Wx562a5GP+UEUWilbL6JFPvQoWBiDACyxu+uNW1ms8
         cro3wAfFUUS1bzig0Lgq1dUivtSZZY2cyAUULOTINeO2agVt9oNDtwvLeiiwtobQPXtd
         Leog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yoA0qcUcZf9hNKPIWW0C4rSDs4LhPQglzx9oFAh3Sp8=;
        b=Kl888HVeZkdh0OxZ3iqdgcfkuQsPStc5Lx5NB2STaeKT0q7CX3lHDw+Ur/ZQs3TuId
         rSApgdxXkabqJzz20nywkgBWZdIwGBtOlSsDldjAr87mFAd8LXm02usC2VThzj2oA2Il
         HAAlJh7VlUik3qgfE8Rsi1h3Y992tg4nSpjO3+nLLu4D23lO6IfDvAcBmuPoD9o5znrS
         hd+Ud6exquNwRsckY+1Phb9+UwgwAf+2g1M0Kaivnv2cl/d9mllz0zprpBeQRAwPCcMx
         MJkbzZkbJ4I/BxaQHxkOyydaeuWWcOotufFrebHVw/psDhgbgw/mOY8i2bqGWJjoV0vL
         pRGA==
X-Gm-Message-State: APjAAAVDmDru2pSBDDYeI3zl5n7Y0ZIv7hR5FHi4HfI1TpT1CGNnDTHW
        amv8GjyzHMwJjCfDVDFcOqGVMg==
X-Google-Smtp-Source: APXvYqzV4giO3K8ryYMsLh3jD9fGBT9x5cgZ/aCBmN7s2tyWpB4CldLG7uLNMfdnn+oxiAcHESSLdg==
X-Received: by 2002:aca:4f85:: with SMTP id d127mr4301389oib.123.1556856021605;
        Thu, 02 May 2019 21:00:21 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:5518:38b8:ef25:393a])
        by smtp.gmail.com with ESMTPSA id w5sm413787otg.34.2019.05.02.21.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 21:00:20 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v2 4/9] PCI/LINK: Prefix dmesg logs with PCIe service name
Date:   Thu,  2 May 2019 22:59:41 -0500
Message-Id: <20190503035946.23608-5-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503035946.23608-1-fred@fredlawl.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

bw_notification.c currently does not have any dmesg logs. As the
service continues to expand in functionality, prefix logs anyways.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/pcie/bw_notification.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
index d2eae3b7cc0f..a4bb90562cd5 100644
--- a/drivers/pci/pcie/bw_notification.c
+++ b/drivers/pci/pcie/bw_notification.c
@@ -14,6 +14,8 @@
  * and warns when links become degraded in operation.
  */
 
+#define dev_fmt(fmt) "BWN: " fmt
+
 #include "../pci.h"
 #include "portdrv.h"
 
-- 
2.17.1

