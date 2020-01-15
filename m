Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1047913CB77
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 18:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAOR4r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 15 Jan 2020 12:56:47 -0500
Received: from mail-oln040092255015.outbound.protection.outlook.com ([40.92.255.15]:6126
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728904AbgAOR4q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 12:56:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAghpwyrYlwrMMGo5GHHm9QDy9ruCwCyj89N+Vtau80OsvDAq++5HSX/mvKOKULmSmKqbjBPnjoWaiy2dTZVXkCeqx2cBRG1kQlab2TssSvEI6VmejXWTq8/fhNHFqKnxDN8TqI/3wIPJqCu637Tc1XRAXWjvtwoRJX+jbk2b/A3f76VpqBFEjHlL6tyjMXsjnPUxG5ewY7ErCwaC/vK6mjR+rhRi/smk63YkQjmfXl9r3jr71An5dU1+CiUv8gPP/6rViuc6RXzZgXmS0ALhzGwCQuN3nKLelqDXFC3n2X0Bt53+U9tu9Xv2nUG1cQSyBZGSMZYUkp7AkBJCWZo6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpJTJZguPK9u+WwGV3fKcp8vjcupVEEM3tez6NCZYs0=;
 b=FYKEGYzx7H8eRC8h0fh25LR16IvGIG5bzSqqD7HDH4yxLI+OwQmVOStqypRmMg82oAngn5I8LE6UlVCQnnb2lRVNmsTR1UbFGL+UDDdjq3YQ6xaxQLdQJK+E189eM11vlXVYhsdDDa2BdBMp9Fkbg7E26HIG1ycDxE6/sCZAlsQPwHGyJvFWtxn69feCyamG7EjOQIgWbtRYtyRBPRzxyNx0bVZlJWCt6q+p2hHIxJm8LnenBg69IZqn9aDFWu9VTOQCVpbmfavhPx+X81OT3tiodu4lkztQR3//WHG4CIm7zAgc6sng1XdXctjsaqFCqnXQSWspUWvoa+EsVB0zRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT115.eop-APC01.prod.protection.outlook.com
 (10.152.252.52) by PU1APC01HT022.eop-APC01.prod.protection.outlook.com
 (10.152.253.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Wed, 15 Jan
 2020 17:56:42 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT115.mail.protection.outlook.com (10.152.252.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 15 Jan 2020 17:56:42 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2623.018; Wed, 15 Jan
 2020 17:56:42 +0000
Received: from nicholas-dell-linux (61.69.138.108) by ME2PR01CA0003.ausprd01.prod.outlook.com (2603:10c6:201:15::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 17:56:40 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 0/4] PCI: Allow Thunderbolt to work with resources from
 pci=hpmemsize
Thread-Topic: [PATCH v2 0/4] PCI: Allow Thunderbolt to work with resources
 from pci=hpmemsize
Thread-Index: AQHVy80k0dy1ycOVHEGXcYzo6foIvQ==
Date:   Wed, 15 Jan 2020 17:56:42 +0000
Message-ID: <PSXP216MB04388C465B8CD6FBEB8FDA3880370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0003.ausprd01.prod.outlook.com
 (2603:10c6:201:15::15) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:0A1C9C73DC3CD87860CB04775845FA647DF2CAD8A61C36EEB68729E200A61607;UpperCasedChecksum:130A13BF628B5BF8C1E7C68569FE4A69490B7677243FDECDA830EA300474B3C5;SizeAsReceived:7793;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [JeAZ4vgSl8cF0SiR25rG16N/pVKOrcL/]
x-microsoft-original-message-id: <20200115175635.GA4512@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: f347ea83-6de9-4244-2ff2-08d799e44704
x-ms-exchange-slblob-mailprops: zswcL9HXbeVV5DRQNiFD0ULmQNyfwccSKEcqpcRYpp0V/11rNdteQfTY83wrLyEVxtgGo2fLqi2fZxMiqaACk3PGKqp6ZrIXznku9tRRI5Y9Tfvm8qaofwLgMX+GjEOROtgGGOLckT4RtLef1gT+Qnir1jdy80ue5LgTPVgw27YyBzq233GVZaQ3l2RN+DneIzoI69g//Dk/+I0Y+G/bla2x/K/ZUqCt732R+Fj6n/O8yooQBMH1tsk3P6IlIphUdG6otQp/CF2ivne1Xr/IfWdgMgGpHPDdgOxfvb34KNtdd5YMZaR8sZ+hgFI03jE/VIY/qJi1XX1ar5OtzK2HOIZwMBbIrjlce5Q996mS6+k4ioZK6u/sO/+VLOKG8Run4BE71AS/yPO7uKNxvai5BxcW+8mTAUYGWI2vmbQshQQqXC+9iqrw8PQoG8oN7Eo4XBKTnxk2fPzEJYqg/Pa2aI4zK8DPGvcyelfzFnEyVslaSIpXb/jQXOgwgxZ6hvvcMghj4WjkbcXb7J2TRRkfvlM82uEAj1AQkhZgP8/lonimpenDa2TNSyFz0i2dyBLdWxfBr4o7krFzoo1tWpVQgUyPTVo25Z8O93EE6gnR3zZL/QUx0mABHTZ/uN5cHOX3pnR03z4HcM6OQDor1/cPgV4WbBJ4stpU6ADB+twBjP5Q9j1uNu8aeD3drIiHRQkvnc+fGgowIP2lEOfsJ/UOLBoMShyQMothO4KztN/Pbv8oEoEJUdAZYlL4GpG3vhYa
x-ms-traffictypediagnostic: PU1APC01HT022:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l86ZNkVJpZFEF1+Pbi/I55psqb094yiVeFNCy9cEdInYRUtwPzgDNJWvmxYWj1KRLhSYd58Yo7A2zlDxiNi2VQIIHezFjF3H9/5cizWXNdmGXcGjgkXwzwtAhIbWACwg0qC72c5JbdYJET7+liKEUwJfUQM0fGusDkjX0mAvVvcRBz4XT5JMQC6ea8//ffxX
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFEA7CD5ADF5FF408B707FA7A19602E3@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f347ea83-6de9-4244-2ff2-08d799e44704
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 17:56:42.3532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT022
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes:
	- Add Mika Westerberg's Reviewed-by: tags that he gave for 1, 2
	- Change commit description slightly in 1
	- Change commit description more substantially in 3, 4
	- Fix indentation in 3, oops. I thought I ran checkpatch.pl on
	  it, clearly I was asleep or missed that one
	- Update 4 to remove usage of reset_resource() which Bjorn says
	  he considers to be depricated.

I have not heard back from Bjorn in a while from my latest replies, so I
am moving ahead with PATCH v2. I have tried to act on his initial
feedback the best I can.

Apply this series after series:
"PCI: Fix failure to assign BARs with alignment >1M with Thunderbolt"

Nicholas Johnson (4):
  PCI: In extend_bridge_window() change available to new_size
  PCI: Rename extend_bridge_window() to adjust_bridge_window()
  PCI: Change extend_bridge_window() to set resource size directly
  PCI: Allow extend_bridge_window() to shrink resource if necessary

 drivers/pci/setup-bus.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

-- 
2.25.0

