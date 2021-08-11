Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF313E8A74
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 08:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbhHKGsR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 02:48:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42376 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbhHKGsN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 02:48:13 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17B6lRA7026434;
        Wed, 11 Aug 2021 01:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628664447;
        bh=xZP94/W6e+feo2IXbD5QHf0IlP942uGU++0kfiWPUQA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Ueq+5HT2zc6XmzerlL2o33T6yr3GawzjilTCp3r6v/Bw4cES9klRkUWPN8jEfoIX5
         FQzdKkWA5GDjb4KiA4IpumWJ2/xwPCJWuMfeao5qCRbbyTfTxV3PFCl7TXUqqYIW67
         ixWOCdVjEvLBbJKmL/34/tEdw5eVO4ePTglIrCQ4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17B6lQ5o052283
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 01:47:27 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 01:47:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 01:47:26 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17B6kvu4013269;
        Wed, 11 Aug 2021 01:47:20 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>, <kishon@ti.com>
Subject: [PATCH v8 3/8] PCI: endpoint: Add support to link a physical function to a virtual function
Date:   Wed, 11 Aug 2021 12:16:51 +0530
Message-ID: <20210811064656.15399-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210811064656.15399-1-kishon@ti.com>
References: <20210811064656.15399-1-kishon@ti.com>
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

