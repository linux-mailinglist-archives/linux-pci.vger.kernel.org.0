Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F311A76691
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2019 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfGZMxp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 26 Jul 2019 08:53:45 -0400
Received: from mail-oln040092255085.outbound.protection.outlook.com ([40.92.255.85]:36856
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbfGZMxp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jul 2019 08:53:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMEZZTc3hwqf872KkDkWOU3srzFdvv8LaxQEAQOxDAPfAsHKQXFdqSh5dDnxeIiR7OCEElp3U+hH/kFny4cYTbw4tg91G+6m4uNNNffMxVGO5YVCdNwQlpxMRahr4G6bFftYmU1v6qnFaQrKfb3225TMANLhqJvPT+BvaEh8uf8ZzcjyR3T5SLFKd2rQHKL85r7gOuUUMtxLG4VNDon5LWNcKNAy2lM3GSxwHfgXp/ZzD36wAV+lzSXUQIhsiF6BVRYgmMf2Pd5R50ti8FPMGUvWGbexSqQKnyjfaCfNMams6dIrm8O5CljWOE1MER7HNs+IhbJb6DGLcaEYXoXJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyRMOmruoMTsEdPq3GMh6fs4pWM14KOxVlnvlLaQE28=;
 b=hCp7gvm9Jq8FOCGTFV82DJRVvo1iBfD/Eig0uuw4RXGD9EtdfEwim5X+EdsO1TwADRIpiC6DVrL7ubuVNJg2461g61i1aCEmafvoMD2j0us9SsKAvlzoWpBD/UTW9JxorQ/b25kCCOM79VAYBqn/QgUSdlNfuB0n4oQ2tdY7qYsCk0h/zvpcYsJmnICN4VbFBCw9p4s/mv9q0yuofhAwriiwkRrotga9TSYs/zf/pCorhD+dQsoxh60e11pnz6wZ96K2YbxHtfdhb/LMBjS6cmF22nn93+sHHay1ew6SiV99XzrRn3Z7NHc9YLpyKm5GPDKaZR7gy7ZdB8KPNxLIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from PU1APC01FT060.eop-APC01.prod.protection.outlook.com
 (10.152.252.51) by PU1APC01HT026.eop-APC01.prod.protection.outlook.com
 (10.152.253.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10; Fri, 26 Jul
 2019 12:53:41 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.59) by
 PU1APC01FT060.mail.protection.outlook.com (10.152.253.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2115.10 via Frontend Transport; Fri, 26 Jul 2019 12:53:41 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d%3]) with mapi id 15.20.2094.013; Fri, 26 Jul 2019
 12:53:41 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v8 2/6] PCI: In extend_bridge_window() change available to
 new_size
Thread-Topic: [PATCH v8 2/6] PCI: In extend_bridge_window() change available
 to new_size
Thread-Index: AQHVQ7EmHvhNFvqjQkKDAcL1eeAwVg==
Date:   Fri, 26 Jul 2019 12:53:41 +0000
Message-ID: <SL2P216MB0187C2C1536E8AA6CD318FDF80C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0194.ausprd01.prod.outlook.com
 (2603:10c6:10:16::14) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:3243A2BF0683CB6CD4A1DE0EC08C61B9A8D2910BA597942B49264F2CDF3D351D;UpperCasedChecksum:E34507274A8F45C1FDC4AD142BD5E81633550A6E0ABD7CCD5209832EC704A12F;SizeAsReceived:7707;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Iyy7SR1PbU6BTY2Zn8YbB6zaMhpyz4fJe68/7SPURleo1Ircgl3LkdO0zIPrsbBrHaGuXWdlC20=]
x-microsoft-original-message-id: <20190726125325.GA2676@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT026;
x-ms-traffictypediagnostic: PU1APC01HT026:
x-microsoft-antispam-message-info: 0qGqXzcNan3WbxBy0mvgwIXAJ0ow1nHcp/G7APoHKHMtm+PdjR+TsYKf2P5BMmPoxW/LmwsNGJWFOf4Piq7FNtxyXQRtvSN6bcJXN+uIfX1blF9smARLdIdougMs9uptKt7gmFLSAw7vHDW5HjwFaljaiz4vL/0yX4y1HKNfrU/5flaXhmkLBelMFnyhMlxh
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32F04AF87D5C5F4899EF4505162C4DEE@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: babbce03-7a3d-4b7b-152b-08d711c84917
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 12:53:41.6034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT026
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In extend_bridge_window() change "available" parameter name to new_size.
This makes more sense as this parameter represents the new size for the
window.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6835fd64c..3b3055e0e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1816,14 +1816,14 @@ void __init pci_assign_unassigned_resources(void)
 
 static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
 				 struct list_head *add_list,
-				 resource_size_t available)
+				 resource_size_t new_size)
 {
 	struct pci_dev_resource *dev_res;
 
 	if (res->parent)
 		return;
 
-	if (resource_size(res) >= available)
+	if (resource_size(res) >= new_size)
 		return;
 
 	dev_res = res_to_dev_res(add_list, res);
@@ -1831,10 +1831,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
 		return;
 
 	/* Is there room to extend the window? */
-	if (available - resource_size(res) <= dev_res->add_size)
+	if (new_size - resource_size(res) <= dev_res->add_size)
 		return;
 
-	dev_res->add_size = available - resource_size(res);
+	dev_res->add_size = new_size - resource_size(res);
 	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
 		&dev_res->add_size);
 }
-- 
2.22.0

