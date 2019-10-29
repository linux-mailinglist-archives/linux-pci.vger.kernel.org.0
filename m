Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 705FBE8BC9
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 16:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389836AbfJ2P2r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 29 Oct 2019 11:28:47 -0400
Received: from mail-oln040092253020.outbound.protection.outlook.com ([40.92.253.20]:43328
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389809AbfJ2P2r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 11:28:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRISFhHDsgw9+M1LjpEf5S2vSIilPxm6vFnHQNUO8d3llKbhg9TAadaSkFAbVXyDqi1AxGe87nPGAn0oNZexJ5Qi5j5h4OQSJ5/ueroJ1OwolT8M4fWeWHkHRSYPbTUaMbi0eOZvaJbfnVHvO0neJluR+F6pfn9PDyxiRKnYpqMnZUCYHt5IEt4AEpfR+KkhiV7aO2Av2ePbJe/IUPa3cbWyTZSenayYyHw4MWJ6WHGj4LcVROE+TAXHSk8opMnsnXumqU6fzIFTU9+xk10PcV1jPtttlksAXVTnx1OyPeIpEIHqmg+Pz9lkP1pmIonB626vNqs6CjuARaXOt8ISyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nf10+7z0G+EnfjLVUGDq0Q0zMOOydC/Nljww+JKhsqI=;
 b=UXkso3ANj7uc6OIoCU0WpFLN+JU0bm9AAozbCvfe2vQhKSr0O6Nj/EwVDxuPFNN+bR1H+8bjIi0TDUtnyXo4ym/Y3gujclRBFdzD+hozRi2a22ighGUQ/+VDgwYzXF27Q4CzqloNedendUbXytzhFlptlMUx0Etnf9MqwAjg4BUR7jDnva9G79sNqBG6ih91DZ7uQlKNvfho9Efu/oRxi7HYo9uwEw4HC549J1yH7qE+MKvYrJyA3YR1T5RvpAPRKlZ2nBfrO5zJQeAjQ1zUveLXi736DR08AHKKwtpHENMj7VPqYAHVht9nlPHa0UEhn88k4H8SwXhJQs3DwQ+nqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT018.eop-APC01.prod.protection.outlook.com
 (10.152.252.56) by PU1APC01HT139.eop-APC01.prod.protection.outlook.com
 (10.152.253.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20; Tue, 29 Oct
 2019 15:28:41 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.53) by
 PU1APC01FT018.mail.protection.outlook.com (10.152.253.189) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Tue, 29 Oct 2019 15:28:41 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.028; Tue, 29 Oct 2019
 15:28:41 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v9 2/4] PCI: In extend_bridge_window() change available to
 new_size
Thread-Topic: [PATCH v9 2/4] PCI: In extend_bridge_window() change available
 to new_size
Thread-Index: AQHVjm2LLNn/YiZQJ0yULwfg3MhJEA==
Date:   Tue, 29 Oct 2019 15:28:41 +0000
Message-ID: <SL2P216MB018749E9C3DD7F6C2DC2AFB080610@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYXPR01CA0120.ausprd01.prod.outlook.com
 (2603:10c6:0:2d::29) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:9F04E5A710E40A2C0A29EC981344C3B768A3B740FA9051DFBE5036CD06A64C67;UpperCasedChecksum:A0E0CADCC2DF24E05F8A5E625E39AF7AD7890A7468B53E031CD8C8714EF1926A;SizeAsReceived:7506;Count:46
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [RePGtR6Fv6GgIY6BT7CBoANithpt0zuMDa0BaBXJC4mtQCJpU9wJd1BsrAQCUAABrVeSZ6Qz7A8=]
x-microsoft-original-message-id: <20191029152833.GA1916@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 46
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: PU1APC01HT139:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v3zy3rRiLFFdwnouoKMogu/gPf2COlpZXan8Lm1Ckp4QrLu5rEp7oIR0z/L014ncdQP1wqyu1nFDIA16uMYvuGeDVsSlpeVGkQc+i+ECn95o/6bAeeLA5cBX4iHmnVfiZgY2c02ndsnet62eloNv4p0GFoapdXJjTY9rWcDyW2SbI4JR/1TXEtM1KHVD8NT0
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6436F55E4AE2694DB1E142D4B1994B24@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8f22cd-9271-4664-c0c8-08d75c84ad45
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 15:28:41.2970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT139
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

