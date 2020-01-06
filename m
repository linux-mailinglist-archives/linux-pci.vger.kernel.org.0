Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF81131517
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 16:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgAFPrc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 6 Jan 2020 10:47:32 -0500
Received: from mail-oln040092255091.outbound.protection.outlook.com ([40.92.255.91]:62528
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbgAFPrb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 10:47:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPsbhrnjY8esTreQr2sgZkl7J0nxKh24TqyM8VDrmhKk+X3jh326gkVhWOrf2f/hpHOxz9TvcHkGUZmOjAeC1AzQnWyOQ5fs7nKxSQMGyp3Ol24i9qAL9CUgACMGJocTG9OvgDo7vfGP8cTaZe7RXp5HAzKEGblIfbXX/53+lROIIPofTl7dL65VaAA3ZD7P3rEpv+5HeAaRt0BRBSCsOsSQ+MWNQvOSgRAy7m0gozdLvRMDMB0dwyPXUBZCTDapbe08ERzXxy7uzlJtJGwvIiZ2yeUZi+5KWvUHwluAPsD+4bXrL/4BXCt1/E10zCuFBpCLgF1+z+Rtpr1TejwYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC/L95QDvIDVqaEbmyCPLI25dO/7DMT10XX9IPbUKBc=;
 b=bsgHNDTFYB1aOgm/CS1ZOx8OW6DYexBeazHPoTQTUwQkrKXLcpeF0Uwr/ufZ2YdXeEoUd0YaPKQRqcNqftYIwL1iRX8HfJbgiy56y8izG98niOJg/QSWyjhZc0fn5SX3JQm8wEjGh4ZuWAC/bG7n7rCF6rYfvDl6cvbqkQc8S2LHb781HBP2UQ2U7uMUKVPuEto3MpcRWxjQPHNg/IAVgBLSMcTv931WGRna1EHVygI3zXKZT017WB7ogccVWlgBaRLUmtRhpsKu1M2eRTMhSh1GLBxF3M6u05ZqLacOuvGEh5cxsEntxQK0uUJtaRVNFsJtqxsEjnYuWTKefJ4Ivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.60) by PU1APC01HT122.eop-APC01.prod.protection.outlook.com
 (10.152.253.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 15:47:26 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.59) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 15:47:26 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2602.016; Mon, 6 Jan 2020
 15:47:26 +0000
Received: from nicholas-dell-linux (49.196.2.242) by ME2PR01CA0071.ausprd01.prod.outlook.com (2603:10c6:201:2b::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 15:47:24 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v1 2/4] PCI: Rename extend_bridge_window() to
 adjust_bridge_window()
Thread-Topic: [PATCH v1 2/4] PCI: Rename extend_bridge_window() to
 adjust_bridge_window()
Thread-Index: AQHVxKiYVkMXiVVjV0e7nVZLFkb5Kg==
Date:   Mon, 6 Jan 2020 15:47:26 +0000
Message-ID: <PSXP216MB0438C47B3473D0C9DE531F18803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0071.ausprd01.prod.outlook.com
 (2603:10c6:201:2b::35) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:7D265AF8A88138C58CA7EB271D831F71EF099B6238DA5151A513AA9B90D82BC3;UpperCasedChecksum:DC80366EFE9ADC5AD70326E1754D9B4F33872FE8B4C0150D7DAED8013FC490BA;SizeAsReceived:7793;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [UOr+758f9cB+tUoZ+Usx5XpuH1SfpJ2M]
x-microsoft-original-message-id: <20200106154718.GA2555@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: cc53108c-1823-4a83-8c0f-08d792bfba77
x-ms-exchange-slblob-mailprops: Zv/SX2iM+5X+ova95ZZQG91BCNa2vH60F/nlaJpFtG4IdfIuDG+gPLdC8qcx3lbiQvZFcaxUSbqV0W5rBGzX6m9YG3XhOjQl8utgtKY9T7oKXapfrTe61pgnEzt/Dvm83feRDkEPJGFlO9tDjwn6E5/th/dmcVcHY490RANDLFC8vTNm6QhmXjpiwdH3nVBFlAawUZXbeYF1mYUxTvJKi9bW48hqcW99L0Ofrht5gKSfeCtYYNbDbpLvD4yQmPAPaPWJGztZzP8PUq2X+YsagdT6nNCSCiW/bZZ68NwUJEgicbfmpvpmFG6O1LVd5DHmDMm1p1Z3/cyKf5cZd+c3/PlcK+uvTjBFFQswOzo3A3x2c5Pb04XIj5i39ns3IGjBp3XtlNm/6LsSrt/Jnc5gFkVIG74f+oLgwiPNNEwPYwwIyTPJvpBKGetfGXgEwmNoA+v35lEbKlEHXJqf1MzYSNlnycOrpLoowtMSlIqZstOg3vwXS5Met2EsAO2UgXlLPTdvp/1D/M/LlwGIVn0Qfg2vj5o6YGv4Ziwck2/wCJVhBN9d0OOxe361VZwyZJHbiAd8qSAs+RIaLWSNvMbxthsj30QuTSFN2PeuNsenBnagUGIA6oXLSXPsJ5bl4nx5MxL/InbDa5Vvd9cYFSRutlzlJVxUWbC64YkFe/DDMXAZI78GDKZL7MIlLVbpYG53hS6l4Bh5RMU=
x-ms-traffictypediagnostic: PU1APC01HT122:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o8zum7yq8DqqrlUwAB6P4/eTnyapSTA9/7FJyxGtD10eBJBavHAwBOeBFYPd+jXcTDWFSQfkiZFkez1HAMIZyZuklx0lzYefUIU8WogvKTuxh9lDyPbTPAbUq+B8Yax3ZtzjAGMo2xuQyxNxCFEb2RtTxUGADcJOCeJGuLR4fSFcXr/PK0eyBVvye534PSca
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13A01649C73514438397BCF737FECF1D@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cc53108c-1823-4a83-8c0f-08d792bfba77
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 15:47:26.4178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT122
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename extend_bridge_window() to adjust_bridge_window() to prepare for
the fact that the window will be able to shrink.

No functional changes.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed5055ef7..de43815be 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1832,7 +1832,7 @@ void __init pci_assign_unassigned_resources(void)
 	}
 }
 
-static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
+static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 				 struct list_head *add_list,
 				 resource_size_t new_size)
 {
@@ -1895,9 +1895,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 * calculated in __pci_bus_size_bridges() which covers all the
 	 * devices currently connected to the port and below.
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
2.24.1

