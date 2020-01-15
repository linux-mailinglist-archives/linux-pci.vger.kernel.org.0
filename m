Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F76213CB6D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 18:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgAORzl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 15 Jan 2020 12:55:41 -0500
Received: from mail-oln040092253099.outbound.protection.outlook.com ([40.92.253.99]:62544
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbgAORzl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 12:55:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ehj5yglgyc8wkXGfFw2CxYRxkPES0nygaDLGuF+6Q4ugpzIQzoq6foqs5Bmp/5qGgrQFksye5xyC4b0LhOJzTEbB0cUeNPqf6mv5KmiFJEm7srZXHPgyc8u+q1hIeJXLakGobA7Y2PZYCPgK1fKefg2ECbhunXxuNpV+f7vj3rSrsrwUzd1+qLHbO2iiDJUts1nsMRywhCqQKWDKRyfdnAxLId7LoPv1uDvga2bdeU/N8nBh+P97M39gGsq5PKb5j1sgn/puVB1LIzs6yrBjj3fOSkppJMn2OzQ/xAlFvhtHk/Ea71aquMsiPRk9rs5z8Jc+Wi00mfhTT/4kwuDc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaWrRiUlxqKC/gKwrQ6i+Mwd0PrSM1EXI3p/EN1u1OU=;
 b=nMDFtwan/FjN/psUmPH2HfpvNaBBfxy4Ya2W6SHrdIzITQBzngBd4JBbQ5yYYd9xe3PAB2n5kvdsnGVHjlgyBQuaV7mAdFsshGCMysC1pMy0ml6n3ghczHhCdX2EIT4v6NIlBKRabLCLPUTjwFnFL+GTTJw+x1x8cdhMV0vJ7fV2vcN7eGjzCrhKqOkvnB18/Llt99mXDErD3jHgG9ophp8x89dG7/lc95XtLd4ctXtr95Lg7EpBy4Y6jeCnremFJMhHjgMfOdbXPtGJNNy2sn9FXPRr5HmHc3qQ+XHDOesJC+dHH7CLY0mUFJjLa+RKu3SQ5XthGwjaTXltqecmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT115.eop-APC01.prod.protection.outlook.com
 (10.152.252.54) by PU1APC01HT069.eop-APC01.prod.protection.outlook.com
 (10.152.253.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Wed, 15 Jan
 2020 17:55:36 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT115.mail.protection.outlook.com (10.152.252.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 15 Jan 2020 17:55:36 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2623.018; Wed, 15 Jan
 2020 17:55:36 +0000
Received: from nicholas-dell-linux (61.69.138.108) by ME2PR01CA0059.ausprd01.prod.outlook.com (2603:10c6:201:2b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 17:55:33 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 1/3] PCI: Remove redundant brackets in
 pci_bus_distribute_available_resources()
Thread-Topic: [PATCH v2 1/3] PCI: Remove redundant brackets in
 pci_bus_distribute_available_resources()
Thread-Index: AQHVy8z9Ar1BXjAzu02TW9NgPGJS+w==
Date:   Wed, 15 Jan 2020 17:55:35 +0000
Message-ID: <PSXP216MB043862CDB5DEC7B58D5A1B7B80370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0059.ausprd01.prod.outlook.com
 (2603:10c6:201:2b::23) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:A77651BFBE56B22DE675C464AECA7AD6224C5B8F6FA06847F6A0524CC330A123;UpperCasedChecksum:119053F4C44AFB5D7071DF8C9D9019510F6A007824BE182D5106C05F9C68EC58;SizeAsReceived:7828;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [+cZ8q41Eg7q3G2XpRomHGhh7FZvLmmQL]
x-microsoft-original-message-id: <20200115175528.GA4505@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 7b203514-f05d-4236-63ac-08d799e41f8e
x-ms-exchange-slblob-mailprops: Zv/SX2iM+5VJNhHB98CBUJCpDp+U+pvxxmPlOs7EevofASLKSzltoElL1zmS5cefwn8lmMZPKG3nlQsxJkBf+uX2luHuwMHJTkQsLmGtiH7r1GVkjM0EERHfi8uPoRjbLNzgK6UpNFB4d9Y/Q3o89bdFpg6Nmyt6NuuiIDkbPtwUc9EGn9c8SZ92IIuJMPhXiQxOda0BdqoblD2LYEJqArdHNS8y58NBT25uROApJoX93KKf7qKgFgsDqmaHH9MeLSdsmDcrXRM5a4QleyaqvV+/v5kFM++1lmghtoKfSUbg+CmGh5GQraj0v6ZQ6sTIDjgiOdLASfSHWkWJjDZb4Y0wF61jR3iO/2J8bPdxPxRyDB5DlNpkB+iZ9y/ow+VmgFkRnM1Q28Ev3bVfz6TfyNNe6KtJKDO7Uaj/Xjvf/4hhN1p0LdGoc997Aysv5VDK9lqxfuve/N+BT8hHusma/brH6X16Xhw8tncACLzuPJJFQn/eHhuJsEhj1b+AgHJGSvGLFvMxry+4EpupFIyzOJvtJ0JnKFrNbhpO7Hc8D0HC1b6mbr4+Q06Fj0mPSpEDvpXV6u/+s5DFj+aItC0+F1c31CM/ruot9WdxvXbUk1xhw1N19DFZSIsJaSVRuQlSwjxDdmj18aYYPP1V+Hytb4bCbNjvJ85vnjvAjhdZ7iX3tVie9+3R1TTxohyeYmarjuIK/SyOAEM=
x-ms-traffictypediagnostic: PU1APC01HT069:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ylJBPrzEq6HFbSkZHrBj/AcCFKlNjjWETxPjWXtxR5Jvm2eqvPQdaVf4CAyAZh3jgZEMUb/JoZcZtMVFANqO1MiO9R0dotv9eMFeTu5VEMyEum/+fYmEueBZ8G3Aw4lJBTVe5VMWKxc3ar0Pd5Kb4s/MifmlR2hD7QF7Sa8rDumLO7c+L6hKp6AIkZsWpa5z
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A58F04F1A923040A8900979CECFEFC9@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b203514-f05d-4236-63ac-08d799e41f8e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 17:55:36.2280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT069
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove redundant brackets in pci_bus_distribute_available_resources().

No functional changes.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f27982620..465a8b565 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1902,11 +1902,10 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 */
 	if (hotplug_bridges + normal_bridges == 1) {
 		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
-		if (dev->subordinate) {
+		if (dev->subordinate)
 			pci_bus_distribute_available_resources(dev->subordinate,
 				add_list, available_io, available_mmio,
 				available_mmio_pref);
-		}
 		return;
 	}
 
-- 
2.25.0

