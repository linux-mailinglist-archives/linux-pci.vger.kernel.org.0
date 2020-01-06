Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99FEA131515
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 16:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgAFPrK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 6 Jan 2020 10:47:10 -0500
Received: from mail-oln040092253066.outbound.protection.outlook.com ([40.92.253.66]:62976
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbgAFPrK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 10:47:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htoa0SWg5LQ44ux/F0j5bXOntu43ujhZ7tiQu3KF+nEuPjMAmnNyjIGSK8n+VvApiHSG0kMn16LpuYlAteY5GYz4mGL2lHyVS4Z7hCMKfcBSx8oMFGGzzYwxlsggt93wpCaHUN3Lx4r8fC2lpFZb28248TFT+HrkXCSbrFHKCTfIa5b9CyuflR1W1biVlMt19Zu3iUc358Bl/FpjKveMey0faTZcdD+oj03D9uRSJbnCGyroMdchQwfMcx/3IiDJ2yOzxeF83/FsF84x/Jf7U4Dn4WITMb2Jd8SFEeqoVG1i8sB2QzEu8yVvnvHWnlJ+fT1TwZ0xsIhYu6uto8iIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACbULg1bckVj/Hjp+C12t3lJhpsYpPrCgwOttmUOnZQ=;
 b=fywBUe0uCCuXxMK4+dFDGG+RmxaDZcODlTnWyx222nuZk1JYscNCbcJmUlI6MNo8FZ1hYk884CX/nKsK+L6vzxDOP0x0tn2wkKbxfOSPG09s7WvKmLc3WgRS51VWtijUJRy5CypNYASaxuH+LYHYAEgQsPAcDYnAoRfGvlETLz5GswS8DW4DhEluM17NsnqIfo7StejU9L1bsAJCHTup5gtWo9z2KH8UjAVR5dC4XX6N2f+jhU1ct3P7LLqySUrAQ6K8/3K02/JIV8w/wF6s8dcKgkYVXJM0tvVPtcZuLc3/laTo4/5NNzFdLt+BJT4u68GPyv+VTAxW0Z5dcyDc2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.53) by PU1APC01HT215.eop-APC01.prod.protection.outlook.com
 (10.152.253.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 15:47:05 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.59) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 15:47:05 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2602.016; Mon, 6 Jan 2020
 15:47:05 +0000
Received: from nicholas-dell-linux (49.196.2.242) by ME2PR01CA0091.ausprd01.prod.outlook.com (2603:10c6:201:2d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 15:47:03 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v1 1/4] PCI: In extend_bridge_window() change available to
 new_size
Thread-Topic: [PATCH v1 1/4] PCI: In extend_bridge_window() change available
 to new_size
Thread-Index: AQHVxKiLa1++WKJEpU2RFfQl7JVJSw==
Date:   Mon, 6 Jan 2020 15:47:05 +0000
Message-ID: <PSXP216MB043853617ECA4118C472A417803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0091.ausprd01.prod.outlook.com
 (2603:10c6:201:2d::31) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:66F1D0BCF42455C3B74D8EA6123FD11B87D0A9CEAC0DB669B2A1CDE782D11847;UpperCasedChecksum:302C6865E10ECCFED3DEB8BB9C0CB96DBA7C36485D9CF7CD35B5C6BBE0F8F7D5;SizeAsReceived:7776;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [5/AwRT8mb+3UqtGAlAVE2r5q+sAtXIV9]
x-microsoft-original-message-id: <20200106154656.GA2550@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: fc7e52e5-0789-4f41-d609-08d792bfae0b
x-ms-exchange-slblob-mailprops: mBy7Mai7yE6pvqwJQ6Mx8ls6+U3+cSxqYFVpPuB4DUD/ERuR7JHpcMBtrf2TV/gVFzAA3THUGHIkwV/Z4bhOx9vKrGXvQQTCK22djaWQTyXCdhOR/ll+4b6wdPxnC1dMSDeic81IDQzD1JfHnCgLy+HNkI+Y7U0IEfNcUjuTBK6xkM1flrRJCAkzb08o0/utkWtMQmLiSqa4zA7b5XLoON2uG2uTTOpzfy0IsCVjH63YeHRPgPJ3tXleVFaPhLwLPvINhEe91js7/UIbYJ87JHrmK4lB2jBhwA34Y98c3qP9YGs2TxBMlZ5+1Bg6RmQuLSy5pyRv2D2pafpdRFAAkcxRXC4qBWu6IfSV7fLBtGyDVzL2m6KzgTBFTobB5pe2xMsJ3g4aQOo6aUKIqntwocdQ6iP6v1Yu78ZjdSAz7VvCHT+zYNqNzjbvSc5aW8X+idu+wNf1qomLQ2pofdQeXRlS1Ri57+Fytw989Uu6x2SSCXouJ3KHhGQsXNmN3eWM9BVgxCsaAtnnFnlgD8UwCkrG9J55Bc+03V3vOUV3+wR+mbJ8sVXxSTKSLaJe1Perw9JfBwwUaXSm2AOSn+bkl4UbOWwBztWAWRw/AWQ2icFcMp7bGsp55BOclNQvMLXmImnHf/ubdtx3NvUVZOmip6aoJlIfqE4uIFb7vY06gkccK8TEaO+d5XpUJtlzbNU51ZfxN2j9ORVt7UTl7Ug8+C79qnl/B9XC
x-ms-traffictypediagnostic: PU1APC01HT215:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rQEy2dhBqwT5FVSNQIAPLrLzAn+NpAA4KYWglPEdzsvRs2GvAit65G1Y0ytXOflTvqNT321qP6qC2K/YjSQfAhayg4CGfaI/3fBCqPfYriut/d6TgUKJMwUcfQeQKdN5E4MzqVgbx9+zOMaUVbaZ7eBCuFXPJkLnX4tpYf33ozyyYPFgLU4bN10+CllJfPe6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FBF0FE68131134085982169092BE7B5@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7e52e5-0789-4f41-d609-08d792bfae0b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 15:47:05.5903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT215
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
index 8b39b9ebb..ed5055ef7 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1834,14 +1834,14 @@ void __init pci_assign_unassigned_resources(void)
 
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
@@ -1849,10 +1849,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
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
2.24.1

