Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E73712D862
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 12:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfLaLer (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 06:34:47 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:32842 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfLaLeq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 06:34:46 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBVBYHGs097830;
        Tue, 31 Dec 2019 05:34:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577792057;
        bh=wyWNxMP+yMhE2vhg63JvjcfQkIOPbmIBjduJwe6FrHA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MHqSgTK5pL83EbaxttUKDQWDjwyKXlVMYbglNHVZ0qkO9XVsmr4QHJFIjAK4Noimo
         7wG375clbDJ/tHkNGuzmVBeoj470VECaxsoFDay3H6uhjOmstQheQqy37JV2xDjYsr
         3+1Z52ijtA7UB9qHEGXy7IAnlWdHyAG8Vx1rrmxM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBVBYHQB091197
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Dec 2019 05:34:17 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Dec 2019 05:34:17 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Dec 2019 05:34:17 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBVBXX38024759;
        Tue, 31 Dec 2019 05:34:11 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 7/7] misc: pci_endpoint_test: Populate sriov_configure ops to configure SR-IOV device
Date:   Tue, 31 Dec 2019 17:05:34 +0530
Message-ID: <20191231113534.30405-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191231113534.30405-1-kishon@ti.com>
References: <20191231113534.30405-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
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
index b2458988939e..0f448c33f45c 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -840,6 +840,7 @@ static struct pci_driver pci_endpoint_test_driver = {
 	.id_table	= pci_endpoint_test_tbl,
 	.probe		= pci_endpoint_test_probe,
 	.remove		= pci_endpoint_test_remove,
+	.sriov_configure = pci_sriov_configure_simple,
 };
 module_pci_driver(pci_endpoint_test_driver);
 
-- 
2.17.1

