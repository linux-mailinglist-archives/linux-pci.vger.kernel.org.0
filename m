Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B486B12D000
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2019 13:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfL3Mbj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Dec 2019 07:31:39 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60366 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfL3Mbi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Dec 2019 07:31:38 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVVD1039095;
        Mon, 30 Dec 2019 06:31:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577709091;
        bh=Dykt1nNdxSlaBSScgYbBExjvH9iWIh6LdXzuuGC21fs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KPuSKbVPR6zbcYDDgbh/5JZtO8V6nH9bAZK2BK3aEPrAj25xA+68ZR4pEzldrF32o
         0HzMt3MU1eRoqYfbcS7PsZeb1dtFhDF7ZZx96FN9wpxvDfOt+I6UWzI3rA6EZjLEwk
         xR+A2Ihzvo9F5p3xU7mA7kCjk3QMmpXto9vLseDY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBUCVV0Y058813
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Dec 2019 06:31:31 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 30
 Dec 2019 06:31:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 30 Dec 2019 06:31:30 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVEhR002491;
        Mon, 30 Dec 2019 06:31:28 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] misc: pci_endpoint_test: Fix to support > 10 pci-endpoint-test devices
Date:   Mon, 30 Dec 2019 18:03:13 +0530
Message-ID: <20191230123315.31037-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230123315.31037-1-kishon@ti.com>
References: <20191230123315.31037-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding more than 10 pci-endpoint-test devices results in
"kobject_add_internal failed for pci-endpoint-test.1 with -EEXIST, don't
try to register things with the same name in the same directory". This
is because commit 2c156ac71c6b ("misc: Add host side PCI driver for PCI
test function device") limited the length of the "name" to 20 characters.
Change the length of the name to 24 in order to support upto 10000
pci-endpoint-test devices.

Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 861b3d0cea19..b622e234f57c 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -652,7 +652,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 {
 	int err;
 	int id;
-	char name[20];
+	char name[24];
 	enum pci_barno bar;
 	void __iomem *base;
 	struct device *dev = &pdev->dev;
-- 
2.17.1

