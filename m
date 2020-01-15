Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A0C13C69C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 15:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgAOOvJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 15 Jan 2020 09:51:09 -0500
Received: from mail-oln040092255024.outbound.protection.outlook.com ([40.92.255.24]:16571
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726474AbgAOOvI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 09:51:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKAIt0ZSeSueBIVz7Vjg4H0e4QYjl3bKSV58YVMP3vyn4g8+Jz5fAE1o25lFeRnd37K3blhBHAjaubzpF762XhesGEutBSATxaXA2oasnw9a7KP+wL/JmmrtYh0O/o/2xPMtdRAVhyj9Z56YRGjXFBV3PPjLGLMZ4XCA6/C+ltbx0Sn3BURBsSA7pbzBLjyEC3MlAUOfDH+wBtrv3bygcshpLGxw/PibzqJzyTVUR1Eoisqld3uySo1WqO+JL4ib5VNoMQREf9SVVKQSKJOOWuEPs5UPnhanxcpHAGAWkROfF3KOILfzYt5EJGQ8FSm7F7YJh+n4Img8kKsoCRNPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U3JgbyhJmKs2VAh9AUmBQLr/JRS1/rQ5w4j1g3lO7w=;
 b=F12+2JQr8wDLHfPtWuTE8sQ9eXBQGDTvnkHaewPmGvNyhu6PO2CXSMv2DCjL8PUf2v8GfhDJNACtYBCxUOPOguko1TiS9IAV81BrRx6mL7iJZlAqS2iJ/NclsK1nIkrgsdBWSS5zHRPltcNKWm3nSkoOLecmi7cx/5Cbc0E4jTaAwZ/OZSx/pzG8zaXk3+0fC57NIUNXqJvmW8a6QtXebcbhIezsLWUzVmbzF4T1ppocAYOceDXIghSfjX4yoKZAUixz07M1ThR/PKKsppxuu7qAf5YzCuYN7dqAJbD+EBTCzK411jjUtrTADUeedIrEd0RzBjNQwYNR2osDuOhFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT048.eop-APC01.prod.protection.outlook.com
 (10.152.250.54) by SG2APC01HT190.eop-APC01.prod.protection.outlook.com
 (10.152.251.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Wed, 15 Jan
 2020 14:51:03 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.55) by
 SG2APC01FT048.mail.protection.outlook.com (10.152.251.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 14:51:03 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2623.018; Wed, 15 Jan
 2020 14:51:03 +0000
Received: from nicholas-dell-linux (49.196.159.155) by ME1PR01CA0108.ausprd01.prod.outlook.com (2603:10c6:200:19::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 14:50:58 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v1 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Topic: [PATCH v1 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Index: AQHVxKivCsNYvp642Ua95PoPKOxpR6ffqm2AgABUMwCACNMsAIADCz8A
Date:   Wed, 15 Jan 2020 14:51:02 +0000
Message-ID: <PSXP216MB043899E598E11CF7D4D9214380370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438D3E2CFE64EBAA32AF691803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200107203435.GA137091@google.com>
 <PSXP216MB043869924730BFD3AA97B0A0803E0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200113162150.GO2838@lahna.fi.intel.com>
In-Reply-To: <20200113162150.GO2838@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME1PR01CA0108.ausprd01.prod.outlook.com
 (2603:10c6:200:19::17) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:10E15FB990E296BF02DCB8E985BAD5363E705FBFF03E2FCB8B35058AACD15F89;UpperCasedChecksum:E8ACB8B7071B22F7309E9487C72B436D797051C4A6D264A41C4DB5683A6D6FD8;SizeAsReceived:8085;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [WjfncAQJ+n//ztLo/bqDQmSi37lvpBxV]
x-microsoft-original-message-id: <20200115145052.GA5860@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 4b77a2a8-1631-41f6-1934-08d799ca567c
x-ms-traffictypediagnostic: SG2APC01HT190:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PV4d0OW/+UGepj/9CT5lmahBp62PspgesMlOHru3YFDmA7euTy20Z+2LsGqa6KG1pjAr7hspp4YkJC2ZEdKuaGRlDI2xzRwTgvOeuR2XxNQj4a+ku45Z9H3GEnGn6svyMay/2hZd7xoSYBgO8CoY5ie8U3UmsFSxbnv4PTvSa+LsmGAARtR6SIQJIMD/nAUM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF16E7B3235D4E40A3545DFAADADA607@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b77a2a8-1631-41f6-1934-08d799ca567c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 14:51:02.8303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT190
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 13, 2020 at 06:21:50PM +0200, Mika Westerberg wrote:
> On Wed, Jan 08, 2020 at 01:36:04AM +0000, Nicholas Johnson wrote:
> > > Where's the patch that changes the caller so "new_size" may be smaller
> > > than "size"?  I guess it must be "[3/3] PCI: Consider alignment of
> > > hot-added bridges ..." because that's the only one that makes a
> > > non-trivial change, right?
> > 
> > As above, there was always a possibility of the new_size being smaller. 
> > For some reason, 1M is assigned to bridges, even if nothing is below 
> > them (for example, unused non hotplug bridges in a Thunderbolt dock). It 
> > may be an edge case if we are low on space, but theoretically it can 
> > happen.
> > 
> > Also, when writing this, Mika was not interested in using hpmemsize, 
> > which, when used, will cause new_size to be smaller than the current 
> > size (actual size and add_size combined).
> 
> Just a small correction here about my motivation. So I'm testing on a
> hardware where the BIOS assigns initial resources to the root/downstream
> ports which is the majority of Thunderbolt capable PC systems nowadays.
> Therefore the user does not need to pass any additional command line
> parameters to get the ports working properly.
> 
> However, I'm of course interested in getting Linux PCI resource
> management as good as possible regardless whether the firmware/BIOS
> assigns them or not ;-)
Sorry, I was not meant to say you were not interested in getting it as 
good as possible. At the time, you had a goal to achieve (which you did) 
and at that point in time, it would not have been feasible to use 
pci=hpmemsize or similar before my patches were applied:

  c13704f5685d ("PCI: Avoid double hpmemsize MMIO window assignment")
  d7b8a217521c ("PCI: Add "pci=hpmmiosize" and "pci=hpmmioprefsize" parameters")

What I was trying to say was not that you were not interested, but more 
that it was not a primary motivation for you at the time. Does this 
sound more accurate? Poor wording on my behalf.
