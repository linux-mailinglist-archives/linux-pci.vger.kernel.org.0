Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD1BFB1EE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 14:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfKMN5p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Nov 2019 08:57:45 -0500
Received: from mail-oln040092254024.outbound.protection.outlook.com ([40.92.254.24]:6128
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbfKMN5p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 08:57:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bR/sFBPtoKMDRXbbcxUE5hjcx+/n3ZHPASE5qM+6Ef4LT1fkchs0eSFvmxLhbLSrMeH4FmiDNSBh4P1k6uqKMQSsz/2F/9h71rC2J3E7p77gmyjuD0c+WvsZb1HIPDWttu9sCkuG8lHX3usRmKAWf9dbUFniXle3Rem628nzjNTeLiLF6pdkqSNGsXV1RN7aZhGqwc8O+NzIgYvbn7EkVQn67z4WtJdxdLyTzHLLlIGENlAxtKSf+jfcUat7cT4j1CYOGm1+6uAWCNZoKNXaB85EnY/mA22etZ+EF0cAfGRacTpWMwIHJuWSv7863Kh44SGvtiNyPv5As/cWalYJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drYE0EXlvyEI4lTc6ApKMIRqPYnAsiQdhwzfiE+t+3A=;
 b=a4M0/0iRibjLByN24rvtyxq+VMNpDi8TVDdZpW9uZLYFTfQRCrp1lSYBuAAd6Ru7GmhuHXvCq26Of/dJ0UEfa17fa8dIcv9UgCWf7lW8woxjlNp7xbjnIn2x0QEol+St0PDD7Rfpfk7maMxwuTi57M94muPzSu8fkht9yjU0wHdjcVqCgKRsz36QqFSBHXPRgufD0jCFPhOTF3q4LtvmLydekK6jGdrjASwmaTAIicv95VkPa/mnH5Lc6XoHgVtmf5xEeDvNqJjiXAOQdReX5846m6uEKKDBRjpp8hwzhm3b8qrGc61vH1LpaCM9P9GK/o7tfoFDhjucPLH921BS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT035.eop-APC01.prod.protection.outlook.com
 (10.152.252.51) by PU1APC01HT145.eop-APC01.prod.protection.outlook.com
 (10.152.252.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22; Wed, 13 Nov
 2019 13:57:40 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT035.mail.protection.outlook.com (10.152.252.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2451.23 via Frontend Transport; Wed, 13 Nov 2019 13:57:40 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 13:57:40 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v10 4/4] PCI: Allow extend_bridge_window() to shrink resource
 if necessary
Thread-Topic: [PATCH v10 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Index: AQHVmipQD6IVIo4CH06tgrNCofJKQg==
Date:   Wed, 13 Nov 2019 13:57:40 +0000
Message-ID: <PS2P216MB07558A279BA82EA1DD6F3FED80760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYXPR01CA0130.ausprd01.prod.outlook.com
 (2603:10c6:0:30::15) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:2ABEA560384B9B8FA2C66A623A4AC663329D72E94F3165E6B0C775BFE77F0E9F;UpperCasedChecksum:8DEEF3DFAC532FDC985BB551507388ACFBF31E0E16B48B16A04DA223256426E4;SizeAsReceived:7669;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [857o3DCpeyidSAsZzlX1z2g/1tU3e7DQeax4aJM5YZTzVahGoAkJzpPRsTkRxMyCSLBtjfSRXTE=]
x-microsoft-original-message-id: <20191113135731.GA3234@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 0a16115a-1f72-4898-a492-08d768417294
x-ms-exchange-slblob-mailprops: gjx25WM8ZNUUcF99Xf9jcIZVmoSE4UEuKZKzQN6lc/weducocDDqrcTNFmsYlRbfbtBJSXIFSm9XfzRo/ht9eb4Ksk05TLiiv78d6J7YOTDEVRMImaa+W8MU+JIWLo3ll6TdvNr7f68jQDOzDpAjt6F0y5rI4YWmHHPKbB+UUYMFeFu+5iWxv+RQuujM8ANRpEWud6lRw9wqmUcdlYoBCXTpVFLytjFC8Dy3bH/3mAMskqREDusJYb965bkcdZp/m5X5ZEOiU4Wuvmfrcim8UyXD6pg5pqqFWdbbhDVqMpIfk0vovt95G4BPqGctXSiAiWrsFOuM1LLIL69dIdAkQ4/riZnGKVDwXJTAuSNuE45CZpjHYfEw4fj27b5exwtUKCmQFtT6OtLeSNB2ezRcMg3WBH5s3E/ggzvl1S33Zhi9+92dIn5bFCvnsNjgkFOQolgfe+FRfQMVCghXkPsoBrqDahZfS3XVEZ/qb25k+YSQ4RlDwge1RrHRH/llV4y7Ugh0UCf+/k5+nb4xsiq1ww6miPdwfhDEnbZUxfPBou72yjTQiIXui0qpCQAFjvwt63QEtG8ypsNt/KdiBbHo37WzzihqHKN2CmQnFv3yMkYaVNkBtqR64abupK5NTgP/MxqPNCbVBsEtys7FOj77WPZ9fdV2/je+RYV8B+2uEbdBKwsH2X7JSrA9zhGDztRat02/rITZKBmMHdWwmfJmM1mfnZzxReYh4KoyWPA0wbE=
x-ms-traffictypediagnostic: PU1APC01HT145:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/HraAPjtAiWBNBz+OX7DGwBIQZ+4LLjrc7BXbZ1w1KVYqIEbYlChUbr0DIETgP5YlEDvYvnOuVvB1m6Mdz0ubWplZZwG1WoBdYJy/xmcsuVMJRc53Cs3ds8mUa9KUa+yXcQTYNPSfHgt4uwGR1z2Sf+n6bEK/trqFc7Q7sX4xuoXquNW13TK86HwFflLzfi
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C2EE9ACC98D66C40B7C875114B3FDF46@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a16115a-1f72-4898-a492-08d768417294
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 13:57:40.3510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT145
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove checks for resource size in extend_bridge_window(). This is
necessary to allow the pci_bus_distribute_available_resources() to
function when the kernel parameter pci=hpmemsize=nn[KMG] is used to
allocate resources. Because the kernel parameter sets the size of all
hotplug bridges to be the same, there are problems when nested hotplug
bridges are encountered. Fitting a downstream hotplug bridge with size X
and normal bridges with non-zero size Y into parent hotplug bridge with
size X is impossible, and hence the downstream hotplug bridge needs to
shrink to fit into its parent.

Add check for if bridge is extended or shrunken and adjust pci_dbg to
reflect this.

Reset the resource if its new size is zero (if we have run out of a
bridge window resource) to prevent the PCI resource assignment code from
attempting to assign a zero-sized resource.

Rename extend_bridge_window() to adjust_bridge_window() to reflect the
fact that the window can now shrink.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index d83c55169..6b64bf909 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1814,22 +1814,29 @@ void __init pci_assign_unassigned_resources(void)
 	}
 }
 
-static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
+static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 				 struct list_head *add_list,
 				 resource_size_t new_size)
 {
-	resource_size_t add_size;
+	resource_size_t add_size, size = resource_size(res);
 
 	if (res->parent)
 		return;
 
-	if (resource_size(res) >= new_size)
-		return;
+	if (new_size > size) {
+		add_size = new_size - size;
+		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
+			&add_size);
+	} else if (new_size < size) {
+		add_size = size - new_size;
+		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
+			&add_size);
+	}
 
-	add_size = new_size - resource_size(res);
-	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res, &add_size);
 	res->end = res->start + new_size - 1;
 	remove_from_list(add_list, res);
+	if (!new_size)
+		reset_resource(res);
 }
 
 static void pci_bus_distribute_available_resources(struct pci_bus *bus,
@@ -1865,9 +1872,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 * Update the resources to fill as much remaining resource space in the
 	 * parent bridge as possible, while considering alignment.
 	 */
-	extend_bridge_window(bridge, io_res, add_list, resource_size(&io));
-	extend_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
-	extend_bridge_window(bridge, mmio_pref_res, add_list,
+	adjust_bridge_window(bridge, io_res, add_list, resource_size(&io));
+	adjust_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
+	adjust_bridge_window(bridge, mmio_pref_res, add_list,
 			     resource_size(&mmio_pref));
 
 	/*
-- 
2.23.0

