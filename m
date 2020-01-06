Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E49EE131508
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 16:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgAFPpP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 6 Jan 2020 10:45:15 -0500
Received: from mail-oln040092253075.outbound.protection.outlook.com ([40.92.253.75]:8794
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbgAFPpP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 10:45:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf9bV80HX2QbDpdD9LX758To8BR98+k+b7shiu1/rLdUYV4z0L3lp5vpNJ84S1dvSqkb/kWBy8R1hXo7syA1UFhgY1YRLsADtNFPle6XUTu+z2zy9g+e9mRPF9xV7OWLT5g+PkmhXbD67OgLgA9ydZdPjO+s65sfnPfOjjJmlBZe1QdoYPv/50BOFfM036hS8AsLR4zxX91Zz5cHltiJDhY+8wyYqBbie1wrM0vHV4I37uLI7YPPnAfA+vk4ou+hEQ2PVBkGLdZSoKruKQdwkqAl5kBd81Wsu1Ge+4nMBuk0FupHBVlmo1ql6VH6MbmrjJqystZebCFNsy11jqX2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKDubXA6Sg025IVngblb4O44qlE8KhMdjYMIimhHQjg=;
 b=jp8IENSkW+Xl/TsdoxzWVVwWD3n802ZdV2N5NYXi9E2p6DItv+pnvKScteKJlhoyjGiJ3LGn78LQ3OiqaWod9VpO/PPzZUp6NFJwttY4clVnorwGiIZ25Srs1K44sVe+DjJ7baNHa6dahovC96l99HrdbSHihUMpLT1UgOk605Mh/obopXXifnItv2C7/MLKfcp5Vg0x50jEz8pCJcRX2XnQWeUTq1ILHHIJcAcsTogzsJgd5k7cuJyM5Tb3KzLw2quTYPOwa5Gbs9fjhNGdgtYL1syWKFJXPmvS4t2hrcH3wbv169tmELgMLKorEWaNbpwiwv4NPolgXFN3XMNvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.51) by PU1APC01HT219.eop-APC01.prod.protection.outlook.com
 (10.152.252.246) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 15:45:09 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.59) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 15:45:09 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2602.016; Mon, 6 Jan 2020
 15:45:09 +0000
Received: from nicholas-dell-linux (49.196.2.242) by MEAPR01CA0028.ausprd01.prod.outlook.com (2603:10c6:201::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 15:45:06 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v1 0/3] PCI: Fix failure to assign BARs with alignment >1M
 with Thunderbolt
Thread-Topic: [PATCH v1 0/3] PCI: Fix failure to assign BARs with alignment
 >1M with Thunderbolt
Thread-Index: AQHVxKhGWS2XwdDU4U2HcIog9dsExg==
Date:   Mon, 6 Jan 2020 15:45:09 +0000
Message-ID: <PSXP216MB0438243F9C310CC98AF402F3803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEAPR01CA0028.ausprd01.prod.outlook.com (2603:10c6:201::16)
 To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:FDFB42B970A8271B242C951796C0EBBFDFC6733A826CCFD291DCED4F2FCFE433;UpperCasedChecksum:0F13D60B2A99D00E2766A97605161B49D2C5592A849023BCEFE8C52F4980A52B;SizeAsReceived:7781;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [21lwpAr0pbM1aScAyduhkTboquPuk8GV]
x-microsoft-original-message-id: <20200106154500.GA2535@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 8f00a8bc-7a9e-4a98-329f-08d792bf689d
x-ms-exchange-slblob-mailprops: =?us-ascii?Q?In1fGN/mPIaOd14rbxEmcaQRHn+nmPfUBJpUXYqcl2RWvB9el2hmar3g+2Yr?=
 =?us-ascii?Q?ctSIgkoUc9ehGzHvYRK2YSqo1VvfLrHD2/SaOAdnl2T0Wh4soBrO9GqFYrgr?=
 =?us-ascii?Q?AGAOUjddyDM00dIvUr7UbxzIiifzdLS3SOEP2pDCVFgYzGbFMDTxjqHEOvrJ?=
 =?us-ascii?Q?rc74cCRZIi3bUXO0dG9zmSdRuLFYlHfmAI10lmCNhybZKqWZdXn6l4ZqNZ5Q?=
 =?us-ascii?Q?d795urGprtYF5Rnu9SegbZx3r64jFwafwwaftG5axW2dl0eojlgki2hmio8i?=
 =?us-ascii?Q?zzWDT2DYDYyIpemwBjxhUIfRqtYcFW2ce9u7e275EXnEJO72oN3Pxme9tYb3?=
 =?us-ascii?Q?+Qh1eY2BWiAZ9XVfAPwEPA7aqwpVZ97a8eoD3JRMvIQZ1MCLAykGfKgCMSYS?=
 =?us-ascii?Q?9FVxjnGVyg7kmp63PT1rIq0rBcHWofrPTAi+kfn8MOHv8gVnkvZFan5oafVs?=
 =?us-ascii?Q?aWpo/LID4f2g++hEFVfHrmK8U5r7g0DnCp2vOmgoAbGlSWE7l6Y1xiMLCopQ?=
 =?us-ascii?Q?owE9d4Y2nIf7VkhLNNoX97kk5s4k4iGacILHTrQclz9DKBU8PGBhTnqjZCgB?=
 =?us-ascii?Q?g4UhhlzgeUWk3ailR/bbLsPV9vhlPhSB/qY5DG/Ry9YLL6apTpGVPBXAKCvZ?=
 =?us-ascii?Q?kPsuFGgrkgo3rP6YAuo7gqF4D49+8gO+9YLudLqg2/UDzhGehqnxffL0Y//C?=
 =?us-ascii?Q?8D35cXFfPWeIgZlCLyX38D7UTKLunnymPmF/b2wzKpglrN0y0JCxxY5LbeeH?=
 =?us-ascii?Q?uPdUtpLlrmEbHjxkpei/ic47G9tuFxuaz2bdg95gggF0kZvV8I+usA0cXdCF?=
 =?us-ascii?Q?OxnoS7Tmg1EzqrLL+kIHfPoyDeRWBPYZ/auzR9qZNYFeVoCEkEa+vYhsvKr/?=
 =?us-ascii?Q?ml6d9KMCOam8yTD9KN3z5TNZYruiMNP5tOsM/jYXl7rseBe5Xb2ujrnAhwFu?=
 =?us-ascii?Q?56aSp0M0GKWx2EUGgm7R2tmZsPic6PZMv/lOC95Hg+hh9l9KQSCWSmS/foTu?=
 =?us-ascii?Q?Q0KgvhED/Si/gkc=3D?=
x-ms-traffictypediagnostic: PU1APC01HT219:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1FOrf1duEWijaSuulRp/N7IestAb2ADy7kycxTn0xCUtFZ3DhOD6hpzX4tv8TCcbdDn6UbWJi23RyW7wE4OfnvsDSisjhPVF7Fuf3/7ki4BagGTzUNyZW9Qhwf+nE6aJnAynTIvUnlDvyaWEh/YlniONemhMRvdZ2782768fOrjG29xX3PGlj6frr0Mvdjf8
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59597A65FEF1894E84A88B2735CAF4FF@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f00a8bc-7a9e-4a98-329f-08d792bf689d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 15:45:09.3583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT219
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series is split from from [0] to make sign-off easier.

I have found a way to change the arguments of 
pci_bus_distribute_available_resources() without making any functional 
changes. I think it turned out very well. I hope everybody agrees.

I have tested and looked over for mistakes for several days, but there 
could still be mistakes. I have also changed the commit messages and 
might not be clear enough yet.

Best to get it out there and get feedback or it will never happen.

Removed Reviewed-by tags from Mika Westerberg because some things have 
changed.

[0]
https://lore.kernel.org/lkml/PSXP216MB043892C04178AB333F7AF08C80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM/

Nicholas Johnson (3):
  PCI: Remove redundant brackets in
    pci_bus_distribute_available_resources()
  PCI: Change pci_bus_distribute_available_resources() args to struct
    resource
  PCI: Consider alignment of hot-added bridges when distributing
    available resources

 drivers/pci/setup-bus.c | 106 +++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 45 deletions(-)

-- 
2.24.1

