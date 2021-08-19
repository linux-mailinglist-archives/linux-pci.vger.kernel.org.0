Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC28B3F196D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 14:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239558AbhHSMfS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 08:35:18 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41046 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbhHSMfR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 08:35:17 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17JCYFNd105161;
        Thu, 19 Aug 2021 07:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629376455;
        bh=xZP94/W6e+feo2IXbD5QHf0IlP942uGU++0kfiWPUQA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qK90ihm8ZTCDiy0YeI36BRVPEhCgyELzISZQxQjKUvFNdOI1iNOXzCsj45YSYRjLH
         qiexPgDwrPDeZRiKpogI2i29fjS+57nBOdx5/hw5EqZRRgU5X2InXqnAaHmQhFX9l8
         3N987oppTUnVCRVvSXkXVmgdHhlc8f0rVp1nRou8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17JCYF9b107283
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Aug 2021 07:34:15 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 19
 Aug 2021 07:34:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 19 Aug 2021 07:34:14 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17JCXlZR035715;
        Thu, 19 Aug 2021 07:34:08 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v9 3/8] PCI: endpoint: Add support to link a physical function to a virtual function
Date:   Thu, 19 Aug 2021 18:03:38 +0530
Message-ID: <20210819123343.1951-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210819123343.1951-1-kishon@ti.com>
References: <20210819123343.1951-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While the physical function has to be linked to endpoint controller, the
virtual function has to be linked to a physical function. Add support to
link a physical function to a virtual function in pci-ep-cfs.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index f3a8b833b479..999911801877 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -475,6 +475,28 @@ static struct configfs_attribute *pci_epf_attrs[] = {
 	NULL,
 };
 
+static int pci_epf_vepf_link(struct config_item *epf_pf_item,
+			     struct config_item *epf_vf_item)
+{
+	struct pci_epf_group *epf_vf_group = to_pci_epf_group(epf_vf_item);
+	struct pci_epf_group *epf_pf_group = to_pci_epf_group(epf_pf_item);
+	struct pci_epf *epf_pf = epf_pf_group->epf;
+	struct pci_epf *epf_vf = epf_vf_group->epf;
+
+	return pci_epf_add_vepf(epf_pf, epf_vf);
+}
+
+static void pci_epf_vepf_unlink(struct config_item *epf_pf_item,
+				struct config_item *epf_vf_item)
+{
+	struct pci_epf_group *epf_vf_group = to_pci_epf_group(epf_vf_item);
+	struct pci_epf_group *epf_pf_group = to_pci_epf_group(epf_pf_item);
+	struct pci_epf *epf_pf = epf_pf_group->epf;
+	struct pci_epf *epf_vf = epf_vf_group->epf;
+
+	pci_epf_remove_vepf(epf_pf, epf_vf);
+}
+
 static void pci_epf_release(struct config_item *item)
 {
 	struct pci_epf_group *epf_group = to_pci_epf_group(item);
@@ -487,6 +509,8 @@ static void pci_epf_release(struct config_item *item)
 }
 
 static struct configfs_item_operations pci_epf_ops = {
+	.allow_link		= pci_epf_vepf_link,
+	.drop_link		= pci_epf_vepf_unlink,
 	.release		= pci_epf_release,
 };
 
-- 
2.17.1

