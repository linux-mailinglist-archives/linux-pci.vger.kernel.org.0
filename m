Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38B93342B7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Mar 2021 17:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhCJQLc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 11:11:32 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55878 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbhCJQK7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 11:10:59 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AGAepp078828;
        Wed, 10 Mar 2021 10:10:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615392640;
        bh=we7tEI3t7CYiYHQjHpttOgbazqYJANHRmdU5X4Zij6w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IKQJC1r6XBZbXqpYRjWst3bE9lZE78EACSTGGxXRcJ3o9OUdNDHZSN2TJKmjuhZnn
         w5Cz3xxrxGyiNIxrvAb/wuC4H6Y7buF8Yfwv0iRFZgFhUQezzSaa5lJ0DT2zHHAsVu
         FhHp0yM08iB2P9ZAScfqywtcIRKV/Vq/ji7sdG/o=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AGAe09063434
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 10:10:40 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 10:10:40 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 10:10:40 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AG9qkx100440;
        Wed, 10 Mar 2021 10:10:33 -0600
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
Subject: [PATCH v4 6/7] misc: pci_endpoint_test: Populate sriov_configure ops to configure SR-IOV device
Date:   Wed, 10 Mar 2021 21:39:42 +0530
Message-ID: <20210310160943.7606-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310160943.7606-1-kishon@ti.com>
References: <20210310160943.7606-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Populate sriov_configure ops with pci_sriov_configure_simple to
configure SR-IOV device.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 1b2868ca4f2a..c7ee34013485 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -978,6 +978,7 @@ static struct pci_driver pci_endpoint_test_driver = {
 	.id_table	= pci_endpoint_test_tbl,
 	.probe		= pci_endpoint_test_probe,
 	.remove		= pci_endpoint_test_remove,
+	.sriov_configure = pci_sriov_configure_simple,
 };
 module_pci_driver(pci_endpoint_test_driver);
 
-- 
2.17.1

