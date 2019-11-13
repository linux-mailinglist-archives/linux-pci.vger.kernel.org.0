Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B496FB227
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 15:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfKMOII convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Nov 2019 09:08:08 -0500
Received: from mail-oln040092255066.outbound.protection.outlook.com ([40.92.255.66]:1472
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfKMOII (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 09:08:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlfdVQL+9kdNPxiy11iF9LvoITCKayRilIDEYGJcaeOrplJ8vaAb9bmi/kIQLaijzQ01IPiXjNsMdVFfvXGQRWmhRw8xnilfkDiVdeGzvWvvAIKRwOJbFOXwR+rmGAg4OpydZj6KTXW8GpJFmiWZ5Z4O1Xm1C+kQn0PoTPxgq20rR2aDu8RBIBqSSJguujJVbv0YxDL8JGifwTVbNUrkGGwvT8KtOiSPLx9+SIiXbCokP9xx/WPZNNHYojel3+5EsO8UbxgwSWXVI8Y2A/74dKISnL3tV79BJHqkV8m5yKEYDlYI9R7wXacHqnyLvuLnTTmjXNkh1RhUVgqkI1IrgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=016AO4EuJoE4zJCm1DfO5/6UliGdpqvionRCS7AOw/c=;
 b=bwGOdMqVyKLqcGMPhOrd8bS9aZ0i+qVPXnKblYeZ/z+yctqGCP1j/LPF9RyyGtqa/uPeZjeAwDIZEpU8c1Ig6txhPTWcpaDE9J9NOQHHYYumKXzTecTmR6G8uK2SxP5UTihVUrPF3Qh6ifJeIKImZhDKczyymJc8LyCfFC9jE/81I49MGvI/xAfNmJY38d4sTHlfKKvB5hNXtuLkk1xcncv/GKPMRd3ZQGkYrtBgIpMdgeasRE4oyqYoYoTlIMwFe2i3DMoKqc+iXBjSxXgLqsTEiQ181ml1h+yaBV2LFhergrhFWUQ5aHeHja6tdDsgpH8XnndKfOUiUTqJIZW5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT025.eop-APC01.prod.protection.outlook.com
 (10.152.250.58) by SG2APC01HT007.eop-APC01.prod.protection.outlook.com
 (10.152.250.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22; Wed, 13 Nov
 2019 14:08:02 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.250.51) by
 SG2APC01FT025.mail.protection.outlook.com (10.152.250.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22 via Frontend Transport; Wed, 13 Nov 2019 14:08:02 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 14:08:02 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v11 2/4] PCI: In extend_bridge_window() change available to
 new_size
Thread-Topic: [PATCH v11 2/4] PCI: In extend_bridge_window() change available
 to new_size
Thread-Index: AQHVmivDZMzVZlyS60a00vuWxO1dbQ==
Date:   Wed, 13 Nov 2019 14:08:02 +0000
Message-ID: <PS2P216MB0755FBD0B98220C3228B292280760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0157.ausprd01.prod.outlook.com
 (2603:10c6:10:d::25) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:3E69BFB4D77E8FFD48B2E4B62E5755CAFB473E8D85D7DA810F879EA8A0DA7F29;UpperCasedChecksum:932E01EB8ADC9D641D1ABCE0D1E3FD2C8A4FD2FBB4F18AD4E90D4ABFE6E406B0;SizeAsReceived:7666;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [XklBoeGfCqSFwNJvWCGiFOxWIEYpjrifOTzwh8SWvnxpzpvpr/5boIWFaoz0bBuiddeVhMrUPN8=]
x-microsoft-original-message-id: <20191113140753.GA3828@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: e20bf969-db4f-471e-fd10-08d76842e550
x-ms-exchange-slblob-mailprops: dEG5jEBie8mlFL0Oe7sWpdK/rFF0vM+sqBFUTfSN3SgvpNJ620J+upS+ZENs3ZH3LtMrPWrWmJhE7HrQ2Poghh4acENQbI8mL8RUgppNfHomZrxr4PEAnsllDR5TjjJNpYFF0RxOPoQaDKHheQMARxWVrjryz2JIkHwVH4jOsJVLKPWZu5JJnHb+jabuUj4jxUKyFd9g4JBb9nX9Lr+CO4+MJhMUlAUtp3D6OaFR7mzuHgGZZX1fJS4Ilt0YNh6KGtKvxzhPCQNX67N9vYB+yerPiVxJ27imj3ODab2F4QRQHOz76RfLHlJYoFq4dEZAVdGbIbXqUHqwbnAGXefr05rGSAL/goObDe/k0LXTNMMKB/9P1Lyy03F3dGqjfmOqXj9NftxETitwUWel0PyqxP2DuErD0NaWHaMQ62j1H7NKM3t0AS9Udttpatu/wDGzjeM7JfPt/1ubrXy4MB9Uac0HWcAblDBrYGqJ/brT8lLwSQE5DTmNu8SL8D5QjfUWfbey5if6aJgJ3DepNcN0GHdheMIgz2YX9pS64dlbqUefo/Vwjpvi/mwcE8ytC/6EtXWFJNcn1TUGV+HxdHt0mtPlVPH/EZQrKWrJQVw4CXbQWCQ8CJsE8RMHkic3f/Xta6mtuGjhNsO9J63pIySI05vm2D4OAH0sLoATBZ1xTedxZVM2uhdHiQ==
x-ms-traffictypediagnostic: SG2APC01HT007:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1vfORs9sjOMT+wNWmBP4AtQBKJBAfpOq1KdZftJ636TqCJh0mraGe+2/Pio3g+xyjbAeKoXxF3zLL2/+TeCrFzsvRMloheVMdzmTO2HVWDbtixWLhM2KzcTDlTb3BsKw7AEYeZnB3YlFj1Ob2pIPjl/8a6lebHxUzb6FX4UxY95ERUiYLCc648ufEYRqxuat
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <765D4060D2797C43AA3B54A7C9195922@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e20bf969-db4f-471e-fd10-08d76842e550
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 14:08:02.3873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT007
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
index 2e71efccc..3f5021f75 100644
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
2.24.0

