Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC18131519
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 16:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgAFPrv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 6 Jan 2020 10:47:51 -0500
Received: from mail-oln040092254105.outbound.protection.outlook.com ([40.92.254.105]:29408
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbgAFPru (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 10:47:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijmtXcuEgh49Pc3DLgffwhFrbFl0C7+kWKoi2qBPDvjyCJzBsUQLaV6F3XxkuRbPZ2jHVZxuoXV07neYgXJ2EFa+AXGZ2RdY2M7KXLNh6yEnt1XPrCUB0Vrv0YmOYVi2G9CksZ1WDEy9F/QfWiHhyYnmzacB4GTPP2U/us9MgTxJI+AKQINKg8/VUKVs3O47XXjdWN4LCkXGVbVeS9THowgvLcXtPNiR51RJ2K+iiHREMySKQowv4CMLk2qO20tQ8F2cVE04B7mn4q97Is/5qF2IsiglQAyfaFZ9YOftW3eFDTNB0g8aEtbAIRP9Eo0E/kH2XLFHwtiiaawy63gtsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1G7E/xOATCSFhCmuNY6VUB0fIguhBCNQ4FAllQUnTw=;
 b=M8lOtjWw0gerQhz6phlc0VwwvUvJfuTCvlyF38auWEajqvQLEbSX1k37+/0ZJnRF3EDHmQhJ5CTkY7ForPSrMWrSQbun+Tb5LopZKgPsfJ2MwdbLzW4KM9w0bOpJ1xLsHhImlSrKIeMxvByIeGH2OKZ0gPly6OwPP86J2AHPZjh3bR7CiObBAam3mebgb7tDlwhq0+lqIhvJIIRh9sp/GRHEqmb3PAKygDNKcSLxXe5y4GzdOtMNKBRJrhQC+fWV5JrB1d/ppdrhqowe0rKvHYhTcivevhrBONPPhZ43LCAqbEYVNtRwclilQSIhT9XaIBuTAjLyoEWK8G7gqYJIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.57) by PU1APC01HT217.eop-APC01.prod.protection.outlook.com
 (10.152.253.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 15:47:46 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.59) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 15:47:46 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2602.016; Mon, 6 Jan 2020
 15:47:46 +0000
Received: from nicholas-dell-linux (49.196.2.242) by ME4P282CA0001.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:90::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 15:47:43 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v1 3/4] PCI: Change extend_bridge_window() to set resource
 size directly
Thread-Topic: [PATCH v1 3/4] PCI: Change extend_bridge_window() to set
 resource size directly
Thread-Index: AQHVxKijErSkuA6mHUWDAsVXSXsSfw==
Date:   Mon, 6 Jan 2020 15:47:46 +0000
Message-ID: <PSXP216MB04386BA48874B56BC5CB0292803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME4P282CA0001.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:90::11) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:E5A7E51C3DEBC1EC0D60CA76C86138AEAD698E1E8B87A74D193EA7202EA46697;UpperCasedChecksum:1BE29C202C672595D324CF7E016AF2F2D38FE3BD4241A0E7EFA7E691863C4B68;SizeAsReceived:7784;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Hk31UU2j0QgMxQqQVOmyqFdfJNXRVt/i]
x-microsoft-original-message-id: <20200106154738.GA2559@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: a1e38f1e-4d20-41dd-3bc2-08d792bfc647
x-ms-exchange-slblob-mailprops: mBy7Mai7yE6pvqwJQ6Mx8ls6+U3+cSxqRl4Pv7axpQA1J9/IVsYCYZ9gno4nkXuyUH7Hkk6wZMV2vdKPSRNEwt4v3w2aBwiZi1PEdFaOHy14gibmb3DoVkfqQXokBhlbl1EJun/DcH66nle/NlAOWyJwgWtK98QEryIbs33mfGb39bZMMQlAeIX9caDMrhcBBkwpedk6C8MPE+jE3Gj+TdHl0bHahdI7dxpzitDEri8vbvUgajp4zg1QXyEWzqrId5XCdBzCQmgmk7sVNxzrWsupTybwIMEJNk17FIOKph6uyfoI9y+KU57ahRwv069TnseKlOpLI+H4tc7KQZLc6VNM9XgnevYFq1v4g+j+NvJtQKn3h6Aj1hjbYkmhqc8yQqCs1mmseY8pzDBa1ycAzHCkHHcG/3cjqa7y6/nv+ReyBfDwusyctgSCmvPxehip/QcNOjMXjCmlNNbGajkhnPl7V73kMJMb20TgnGVJ90LThhrNmFWbkxclZLoZUiLn0UH2WN9zh6U1JCyQiaLOdv7LEFfRq8rB9FxD+971clPyQGQdOik/pEa846ca1zhpSAShSXqEslYYlxzZ2r5WReNnp3zUtUpwaPzgR0dDF9b02nJ5q5oe5W9PdFsjEgW8UQXWeftABG07g5iN3O8w3x8hMFI9OLVNJpTyys/F694tr8I39XODsvqWZDa0D1x5Sdmhf5TjsPj1xWB4GXThj5v2ko9+u+D1
x-ms-traffictypediagnostic: PU1APC01HT217:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uQHpNNDRey/85Ce6JN5ioDBkryZv6X/A/liCWfjyno+9x1cBxu+zu+569GZ8WM4PJ3ogi6B7+5vOvgDwBQswwKnM3ut0G+I8+8DmASweQ2mVfUnkymAcYT1eklEgdSqk5vDXcZkCc5TCwJoUDmPjvlch05Y8GMdTYZ476x0HVFmthV/92Ch+x1Mvz8mHzTn5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0CB312B40E6B6841BA65B9FEF4AF5E36@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e38f1e-4d20-41dd-3bc2-08d792bfc647
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 15:47:46.2209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT217
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change extend_bridge_window() to set resource size directly instead of
using additional resource lists.

Because additional resource lists are optional resources, any algorithm
that requires guaranteed allocation that uses them cannot be guaranteed
to work.

Remove the resource from add_list, as a zero-sized additional resource
is redundant.

Update comment in pci_bus_distribute_available_resources() to reflect
the above changes.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index de43815be..0c51f4937 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1836,7 +1836,7 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 				 struct list_head *add_list,
 				 resource_size_t new_size)
 {
-	struct pci_dev_resource *dev_res;
+	resource_size_t add_size;
 
 	if (res->parent)
 		return;
@@ -1844,17 +1844,10 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 	if (resource_size(res) >= new_size)
 		return;
 
-	dev_res = res_to_dev_res(add_list, res);
-	if (!dev_res)
-		return;
-
-	/* Is there room to extend the window? */
-	if (new_size - resource_size(res) <= dev_res->add_size)
-		return;
-
-	dev_res->add_size = new_size - resource_size(res);
-	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
-		&dev_res->add_size);
+	add_size = new_size - resource_size(res);
+	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res, &add_size);
+	res->end = res->start + new_size - 1;
+	remove_from_list(add_list, res);
 }
 
 static void pci_bus_distribute_available_resources(struct pci_bus *bus,
@@ -1889,11 +1882,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		mmio_pref.start = min(ALIGN(mmio_pref.start, align),
 			mmio_pref.end + 1);
 
-	/*
-	 * Update additional resource list (add_list) to fill all the
-	 * extra resource space available for this port except the space
-	 * calculated in __pci_bus_size_bridges() which covers all the
-	 * devices currently connected to the port and below.
+        /*
+	 * Now that we have adjusted for alignment, update the bridge window
+	 * resources to fill as much remaining resource space as possible.
 	 */
 	adjust_bridge_window(bridge, io_res, add_list, resource_size(&io));
 	adjust_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
-- 
2.24.1

