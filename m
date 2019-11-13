Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B12FB1E2
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 14:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfKMN47 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Nov 2019 08:56:59 -0500
Received: from mail-oln040092255071.outbound.protection.outlook.com ([40.92.255.71]:50214
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfKMN47 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 08:56:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UN5PV8EKe0imzQcsjsBHQ4sN0Gw1Vf9180yJPal24tKfW1qMsyIaKqC1EvdiohFw6ZVAc5TxcIecMCNjCGX3f2OmZFNAg7ENhk/bXFzLU6W/oYH+nJHGI/ccV3dKtFK8k1kDLnJQMK0FkI0GbpbTB3rUI8v9ldtIJRySa4k2+wclrHVTm6p+1sr8UYB4yG/dlxbiMl6gRa7lchOlySM8PmIdagVTSdLQ53WmPOiIXCvo47Zy7f7oKUw7WjPsuP9a135CI8lNzmHcvG20py6Dg1opudhve0cSuhA8cG8RBue42plFloGspsEqO8fjExRg8Um5rlKjEKOjPk2WTFjGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nf10+7z0G+EnfjLVUGDq0Q0zMOOydC/Nljww+JKhsqI=;
 b=e7/ArhO40rvuslFVXUMzrP4XfK2y/TQOyjIRFEKuXKQFqBT3t3PbTMWc+B4Z7z9aUN92dZ3s4WujA9ofE8uQ2yX5BM/DL8IKhWqU63QIzbH/1o9msGhx+FLWavMprWS19GSqZPc64up8lldwJ2tKmdywnf8ZR4thn9P8EgJRZoJOUm3TCTiSWCj++S6M9tiVG63bMRd+fts70gNTSNAWCSTPgmGCvi4XNppzTAYLZdqkxhUcmZ7qsTOMhboVFIUPWUQNr0CGh06DVNTK/M0ki23wuplRwtGRG0kNNmuYXF2jjrbECzFu014bLg2k2Ko4gQ/kU1+yvqS0UIBlF/sZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT035.eop-APC01.prod.protection.outlook.com
 (10.152.252.55) by PU1APC01HT056.eop-APC01.prod.protection.outlook.com
 (10.152.253.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22; Wed, 13 Nov
 2019 13:56:54 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT035.mail.protection.outlook.com (10.152.252.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2451.23 via Frontend Transport; Wed, 13 Nov 2019 13:56:54 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 13:56:54 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v9 2/4] PCI: In extend_bridge_window() change available to
 new_size
Thread-Topic: [PATCH v9 2/4] PCI: In extend_bridge_window() change available
 to new_size
Thread-Index: AQHVmio1UPHQ91Txq0ecwsk7Nnr1Dw==
Date:   Wed, 13 Nov 2019 13:56:54 +0000
Message-ID: <PS2P216MB0755549F4C2941CD71DC68DD80760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0197.ausprd01.prod.outlook.com
 (2603:10c6:10:16::17) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:6ABFF8C6CB5C374E84EC9406E25A2B1D2CE7CE3FF859D33EF23710A2D99CD1E0;UpperCasedChecksum:EE51FB1531CB3BFF653E4977D9466CA2720D047675117CF78749BB980BE2349A;SizeAsReceived:7684;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [d6FG126QYELAKeKCY69GPDkm0PL3rfYSwjItcb0JdGmzxsfgNcu6fp0Ju1LBClc3CYlFZPZX8W8=]
x-microsoft-original-message-id: <20191113135645.GA3220@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 5221be0a-eed8-417d-31af-08d768415754
x-ms-exchange-slblob-mailprops: Eluf6BVNkXnWHxa7ZbiJC49Lj0H6xSaHWsHmds2yMHv17Tb5BrhIRnbD/a0tWCu1gSLWreanXa5G/VFuybTyPdE55IEJw9Dllbu6VOLc1M99D5pNpgMvBrEvGJd7Z0AZFFmRFAWuGesloQzPYcqF79+t1BQJxuIFNt8aS9XkcRen8vr9A+bvxGW6DBEOckZMrgnJyBj1cFaGt7WLqWhfMMl/Gs5THGUu3M11B8VuuU5tcudaMog0y3WPyheMGPd+QzIj3E6j8rFQOFKrj77l9FE4xqKsImrKFpwmKzuSfQ8BbRczqZDys3JqxhqNT1FhtO8XAPTqGvh+weQbWVrQCfebSZeW05CaVZTtIDNe/6ekU2NDb9olIZcky5kKn+FZXRvpKBYDt2rteVOEewWU7zYZfuB2MbU9TTXMUUxf29o4S8m1wLT28sjr6KSwyi8aUWkdU7hNb3zTQ6uMPVhi2PCb4h7lUjSfVcm4ugPCocPwTJ+cDDx0m+I1t3KSOFmu6Vt7CoLVdwi5mU2/TXwL9emFabGJLLSCg0nTvrKMj1kDMboFjLFOojvKWIv+/bgHaocD6PA/PgukqjPH/T5BxvkCbrzhf1N342rUMpqc0WZSEvs57XyP3AiDQVpGbpwvHRJ2leQmdTeN3jcH/BTJDq7jj1H7W/+V
x-ms-traffictypediagnostic: PU1APC01HT056:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AN5wHYwLHym0P13WhMO/PgwEnvI1l/OGhCazB/81hf4rrc7pZbEitWyzpjs6UQXybBO1ABTNpwpIx8LVz12tYzOliAN5zQQ27ndj3I7gtgHVGiU5AQuqKBo/34P4cdBrGEa9mHTujxQdr3yepWYEa8wiw/dOCELrFLLHz+q0AiWU7XnONRK7ECUNUSfSCGwK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A865B4D1DFD0F249AEDA33E259E1FC9C@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5221be0a-eed8-417d-31af-08d768415754
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 13:56:54.7631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT056
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In extend_bridge_window() change "available" parameter name to new_size.
This makes more sense as this parameter represents the new size for the
window.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index bd8231560..728bcea26 100644
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
2.23.0

