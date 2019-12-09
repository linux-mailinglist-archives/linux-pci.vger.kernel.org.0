Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32986116D6A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 14:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfLINAg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 9 Dec 2019 08:00:36 -0500
Received: from mail-oln040092255094.outbound.protection.outlook.com ([40.92.255.94]:27680
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727496AbfLINAg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Dec 2019 08:00:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOjM2v/IVv8L6G2rs6VN/WDIlwUEZjPci1p7LHafS+f0XNsM0ipvqIDH5jjVCYih9oknkHTW+RbeEm6jCPpAFuJ6CRzEmjAQSzKXxER6uzUerNxP4w0PD9faXFQWvB8DA530MpQJM6+DfJppq1PnwoYUJZmSBqsCstpaErJU8PfvW+j294nWeu1iKNGg7Bpfvs6iYlVllOGpDoauENVFW7ygnjxEH4SrfHH3dLquTp5CmPXqTgrjgK3WOfM3SFcM996mHfOFWEbG/f2oDWIpWirIZpjjINEVjWxIqDyGOb2bYzdnFQ4BjSajqrILzKaFqmotVj9k33g9Y7jTQo974w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyt+eS3rEXrUvomE+zlLjW5+zb4U5Tjm1OM05kjNPc4=;
 b=d5QXl73oqbbmnmS72jF+iqO9CfZlLxsRGD7Ikxp93BEhIJyH0+lTsibm60FT2KZpg4ZzDLhN2TmvRx/m/xo/Z7fRzm22afqBUofGML+Av3MKSyK1DBeLuC56+ZLbUSIS6v95RKxQQZcixztHwMns8IgZrEB9UdfgUSYa/XaxcKNRqfqhFJZY0h8q89JPafBtHH4pohh+fcVXR4uUvonkecEcD5ZEXin2ouLH9XLSVxOhUh35sBlwBfbgNfV4YpX26GkP5AkRGPi2FSEXPGVn/f3G9t8277tuFxg+QclxRG04WNeSeMKUZnoywLr7gDb21yYdTs5q5VwQ2bPpuAqH4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT003.eop-APC01.prod.protection.outlook.com
 (10.152.248.53) by HK2APC01HT050.eop-APC01.prod.protection.outlook.com
 (10.152.249.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.25; Mon, 9 Dec
 2019 13:00:31 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.51) by
 HK2APC01FT003.mail.protection.outlook.com (10.152.248.173) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25 via Frontend Transport; Mon, 9 Dec 2019 13:00:31 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 13:00:31 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v12 3/4] PCI: Change extend_bridge_window() to set resource
 size directly
Thread-Topic: [PATCH v12 3/4] PCI: Change extend_bridge_window() to set
 resource size directly
Thread-Index: AQHVrpCjhCjAA/xwlE6P73k2zd/lCg==
Date:   Mon, 9 Dec 2019 13:00:31 +0000
Message-ID: <PSXP216MB04388350323B9770446B096C80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYCP282CA0004.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::16) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:21A0B1BDED5DBF529341CBFA621B7AD740CE53C748A8F0F349AAF7E791CC9D6B;UpperCasedChecksum:27AE4DD4FD3EC513D4AE0D8E26601F16A04D54D121314D66BD7CAA36127A8992;SizeAsReceived:7609;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [UTLs0FqE+KsUCBIt6eNaraNujQiCj7BdKio3RaODShE2a67NS0T5AtatK7Tgh9gRx23J1TJLhkw=]
x-microsoft-original-message-id: <20191209130022.GA3014@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 86a71aca-d33a-4325-a636-08d77ca7c56b
x-ms-exchange-slblob-mailprops: FNsJQuRXwPqc5X5QZ6YF1p9pz8sDL8bcDHnxvHwZx/PjB1vs5ZdyFBFekSWm+KWydMSeinxmI1fia9mUyxKBsenmKK2P48Bn7PAomLPEDX/BFMkl8dP3EV4lNXEPuVaiolumN6os+yWskyxFIbVmnFuqXnkfUuYfKybaZ2fwE5ohT6T7Wn1xQ2h9r+77O6aV2arn2U/OygUYf7SjgoXiG+hWxxcmX6R8zmuqA8jpiz+q2ZzjBuaPI3MMyI7UG+R/RbnFJJT9pktno2YUvpva0XZGXNrh+4rfaOBaZlVrlhw+ztFOPEztlAldKz57uFFkbpQEWzINT8kIBX7FhPZ4ut1LSE87gNcdvkjToIZTVg8M22ttdCQa16/mQjeqt86MUkb9sRvNKxDrsj2EZk9/qLMPgqBSC1Q55UMdLpLeDyu4BY+WLrJqJFtHeq9Htw6jxG5cTlOBE2hm2bqWG7Idy4Orl/6jxYQWZC0b2gGjowjlrn8rkEEomhZC+5QPzdqMziwmj9ylSFn2fKZOgVxPPdRwNMF3GyppHcU1PMES8K+L4JsoCwrAJI7v8A8gxY71LCgIPja6jJykxKvDrdqTXXC3o5PpkoyDHNTP9Urtc+IaVcUVHRkEjg==
x-ms-traffictypediagnostic: HK2APC01HT050:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fHf651mqi+ejkzSxaWFSkKuaUx71cQZPKEojcvMAQwAwzC05BsBDDoZDQLrFAecTKSTxMn8oTu9LJo7/wAgYoDW2/W8EdiGeVoh8WeLaYVkUWVxvEI6+UPrNyoRS3/PWsf5Wswyf6ccQOEQt8RABJWDfdYcAttQ9GMFO9+zMnTRaAiDyxR5MI3qyWXPy99pv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <038612782B34D24C9E159BA6FD4286C8@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a71aca-d33a-4325-a636-08d77ca7c56b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 13:00:31.4191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT050
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

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 165a62a79..0e0c8b677 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1836,7 +1836,7 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
 				 struct list_head *add_list,
 				 resource_size_t new_size)
 {
-	struct pci_dev_resource *dev_res;
+	resource_size_t add_size;
 
 	if (res->parent)
 		return;
@@ -1844,17 +1844,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
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
-- 
2.24.0

