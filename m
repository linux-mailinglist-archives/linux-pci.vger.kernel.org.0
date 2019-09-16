Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E076B422E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391509AbfIPUoo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:44:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36942 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387513AbfIPUoo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:44:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id r195so707315wme.2;
        Mon, 16 Sep 2019 13:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z7l3aUvXVj0B4HmmemvPXtwnQthJwDdKiNtC0WPyylI=;
        b=oHehi/5o+BNYiojA1ENYI+u+vp9T+Lgkqy3Be/I6t/Tjgi+v+UkbCjzDRZutcHXVwv
         /HtBZKhgsJrf/03M/hTnaa7pegqPXX6GbvrHInnUKo4cCf7C06Xtri3dwwMTv9rl59bF
         upXd0SczvWHwmEwKxCXNtEByPsc02QTURs7GJUA2KgxZ1Nm/0eaZs0Yc2ixNMarXlWhf
         EJ3wSW6S9VTEsQrkGB9sE8vMRsLcihYlLbZJrO5c+NgTeRWqpF+f1ad2n/Cqssyh6CqQ
         wHebEfvC5CATftzY68Zfq8BhmPRtbgtVBDYIyj60AU39cyWr7iGFEqTyWe3rIdqsh2xr
         VxfA==
X-Gm-Message-State: APjAAAXeJPo88eYbvib/m3Ozp4fhxFlAzHKdURAKZYSmupHAkRCM0FHn
        V4D++mcTrMn6Ahi2TWVhlz8=
X-Google-Smtp-Source: APXvYqwmIDihAakEBWNT+Q6Du50C/CVUM793sq+dvYqGdI/1XywI6PROEUB6R/C69wEz/+yKfv1AaA==
X-Received: by 2002:a1c:9cd0:: with SMTP id f199mr646857wme.111.1568666681325;
        Mon, 16 Sep 2019 13:44:41 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:44:40 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 09/26] ia64: Use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:41 +0300
Message-Id: <20190916204158.6889-10-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use define PCI_STD_NUM_BARS instead of PCI_ROM_RESOURCE for the number of
PCI BARs.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/ia64/sn/pci/pcibr/pcibr_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/sn/pci/pcibr/pcibr_dma.c b/arch/ia64/sn/pci/pcibr/pcibr_dma.c
index 1e863b277ac9..ff981e415a28 100644
--- a/arch/ia64/sn/pci/pcibr/pcibr_dma.c
+++ b/arch/ia64/sn/pci/pcibr/pcibr_dma.c
@@ -295,14 +295,14 @@ void sn_dma_flush(u64 addr)
 	/* find a matching BAR */
 	for (i = 0; i < DEV_PER_WIDGET; i++,p++) {
 		common = p->common;
-		for (j = 0; j < PCI_ROM_RESOURCE; j++) {
+		for (j = 0; j < PCI_STD_NUM_BARS; j++) {
 			if (common->sfdl_bar_list[j].start == 0)
 				break;
 			if (addr >= common->sfdl_bar_list[j].start
 			    && addr <= common->sfdl_bar_list[j].end)
 				break;
 		}
-		if (j < PCI_ROM_RESOURCE && common->sfdl_bar_list[j].start != 0)
+		if (j < PCI_STD_NUM_BARS && common->sfdl_bar_list[j].start != 0)
 			break;
 	}
 
-- 
2.21.0

