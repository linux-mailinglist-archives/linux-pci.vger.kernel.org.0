Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755AD3E917E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 14:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhHKMee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 08:34:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52842 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhHKMeY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 08:34:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17BCXlc2014869;
        Wed, 11 Aug 2021 07:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628685227;
        bh=HtVlu5vamZ+/bnr3Oc9P0wb8o/E/T9hmFwSHky9CGS4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OaYJVgN0TUxKPFfxwg9TQ234DWxA+rDRo/IDfCSCJSsehniuJKKveqCzUbU6QPuXa
         MyQQ1zrVHWZzOjsy8YF2TyhLBBk05xLNwimZheSn44yixZwOXXWTaqNsQVFdMfBqK2
         jLcSaFbadQwy6TfOtgPdH4nQAApLWEqNdMbU4pb8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17BCXlHh060003
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 07:33:47 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 07:33:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 07:33:47 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17BCXbiv083813;
        Wed, 11 Aug 2021 07:33:42 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nadeem@cadence.com>
Subject: [PATCH v3 1/5] PCI: cadence: Use bitfield for *quirk_retrain_flag* instead of bool
Date:   Wed, 11 Aug 2021 18:03:32 +0530
Message-ID: <20210811123336.31357-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210811123336.31357-1-kishon@ti.com>
References: <20210811123336.31357-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No functional change. As we are intending to add additional 1-bit
members in struct j721e_pcie_data/struct cdns_pcie_rc, use bitfields
instead of bool since it takes less space. As discussed in [1],
the preference is to use bitfileds instead of bool inside structures.

[1] -> https://lore.kernel.org/linux-fsdevel/CA+55aFzKQ6Pj18TB8p4Yr0M4t+S+BsiHH=BJNmn=76-NcjTj-g@mail.gmail.com/

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c    | 2 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 35e61048e133..0c5813b230b4 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -66,7 +66,7 @@ enum j721e_pcie_mode {
 
 struct j721e_pcie_data {
 	enum j721e_pcie_mode	mode;
-	bool quirk_retrain_flag;
+	unsigned int		quirk_retrain_flag:1;
 };
 
 static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index b72de578b996..6f97fb4e58a6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -312,7 +312,7 @@ struct cdns_pcie_rc {
 	u32			vendor_id;
 	u32			device_id;
 	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
-	bool                    quirk_retrain_flag;
+	unsigned int		quirk_retrain_flag:1;
 };
 
 /**
-- 
2.17.1

