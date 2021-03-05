Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951DB32E108
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 06:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhCEFFI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 00:05:08 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48950 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhCEFFH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Mar 2021 00:05:07 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12554kTU074947;
        Thu, 4 Mar 2021 23:04:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614920686;
        bh=xZP94/W6e+feo2IXbD5QHf0IlP942uGU++0kfiWPUQA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Aw77jxUakLN17FvgAG/jkmtIzJsR6ywXTsNadGsqlTyMGsF7wy6feVFZMY6P5aYIf
         Mhz7hu+w/KW8q0o/TSvQo3tdJycMycxCvu1Bsd4BmIlZ/f4Hm/kSaMFSt8VvK30ygt
         ETrambS5DvvmkMaf/amZexXLE3RQC7Y/dyOKa4Nc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12554k6Y128105
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Mar 2021 23:04:46 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Mar
 2021 23:04:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Mar 2021 23:04:45 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12554D98116197;
        Thu, 4 Mar 2021 23:04:38 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Nadeem Athani <nadeem@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 3/7] PCI: endpoint: Add support to link a physical function to a virtual function
Date:   Fri, 5 Mar 2021 10:34:06 +0530
Message-ID: <20210305050410.9201-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210305050410.9201-1-kishon@ti.com>
References: <20210305050410.9201-1-kishon@ti.com>
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

