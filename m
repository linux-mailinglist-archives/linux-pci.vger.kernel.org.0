Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F80A2D83EA
	for <lists+linux-pci@lfdr.de>; Sat, 12 Dec 2020 03:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405992AbgLLCBW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 21:01:22 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60356 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgLLCBA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2020 21:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607739170; x=1639275170;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Tb8TCCNPqdKxHv539BbiWrlKOyMFuNA9907+rYPZknM=;
  b=iYgpwyJsn+UVI3vXe9E/ouZrQqzp5dE9ozigQIcBnDM8Uhz7RYML5Tgj
   VUtDcn10wmtXQB23/ac2MoP7gT+ZOOwAozYCkqUiIKXYmmB3QdGqH9s4x
   izdlsoapqbytsRD9ERPh4Xms0mZGRQdF/nGSX/nI0qGLqrhr8oiiNqub+
   ejpknS+49zeRqsk/ezVP3wo2Rk4YlPAnYAXWd6WWdj1fb9v84+reflpev
   eRGt9jWjVkEQaIeLnw3DMtdNeW4hncoBzsJNt43kCQcJy86sVwxNYopLZ
   PtT+cRevj8dnHPael+zQeESy1eCzPAn5cj9WK/Da2BvFXIQzLWDasE9f3
   w==;
IronPort-SDR: a5mC0kUragGNpuFf/5Azb/PxDTqSu8qdfy8LB7BVmCP8Ts7x7cjt9o8U3KmoiqZkAhFIb3bF7k
 vlPwMVHWviordKGbb/RTOzQqOG96mlEtWAiSPIx9989Ik6TsM1z5YWUCz9N05dg+/eyNWWHZAa
 hXwHUSi7yXuom32Y3qTCj0221Zha0SbnJZ25a2exjVnj4+rmbDQFLJo/4qaPeETXxlYkKgcsG8
 kJNrqp0DlWO6+KopixQkigTglZsT3P1oiQ0Bka+an5kn1ohyRseK0uBICVKDwWCHZ8kqB8q1TU
 Wzg=
X-IronPort-AV: E=Sophos;i="5.78,413,1599494400"; 
   d="scan'208";a="258715737"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2020 10:11:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OizKkXgh9RMAqCAUldk+RLga1VrQMrL775tMewk7QYjKa5PhR03ixuiWa5K2vj3rNm18M/kWnbx9dlO7sGyUhZCwj5yNYotkIt3dkpIERy+bB2pCnLx6gl/tGk1kSymAgqL7hm4tgSlHXrfydcoPM2RaNsfon/GzkFO76j1yKSczXcqUWksBTjPf8elHAIx+g4bCT7lj4GFhFw7U051f9F8CMU346hy0Adj454jTGNQTKtYvlMWLM0vXHFhxoddMDdQL+Vi5D+2NeDWZ/PVGVrj0e+1l4O1iYPB2dL605eW464OspVkgS+CbgxuyotnRljKOdDU+CDTgtME7EsJSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzVEETSfVwXU01vTCHdpir03tZq2RljQ3psqb8tzYRo=;
 b=PHHF3u0owYSjZO67yv5LN7rV7kxQCrY59QUpx0nKpFTCscXzacHNlGwTl3SEQ0cOvVbmm0x6HI4RNIRDKS2eYmIYMlBJUAbPeXcqFtv0FqAZCOqeBPvHO2viZFkHoJcHcmDbjRSEGUw3o64nqfGOxmpw/X1PzO837VLuzlzgdRrfZ9mYVreDZAp3jMmXcNp1IWIOXbxVIq6nwSHxBLR/PJYqwxC9xS5BhTkkjGMgAcWI+o7EubMWhoIws6qB8kRcHvDuRSXMg9irf109tFumw+hDErg4qL539kpTXZMZz2pwI24x47Clx5a+Upm8S2hCmOBOKe2jYA9K7tOre3+DTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzVEETSfVwXU01vTCHdpir03tZq2RljQ3psqb8tzYRo=;
 b=vS/0Npb8DzqAS1DJM91FIcKkOGmZ0AA6lsPkSOKHvaiGNYgRwby1EQx0lilnOAungAF8ATNc3Uxt0oKNHcypa3jzPwLHWALohETdBjchloyJ1t3m+oIqPosOHHrQk43ASTKevhP2lVD5D4SoabTIHsfOjue2meN9us4EhNEDE2g=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6422.namprd04.prod.outlook.com (2603:10b6:a03:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Sat, 12 Dec
 2020 01:59:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3632.025; Sat, 12 Dec 2020
 01:59:51 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Puranjay Mohan <puranjay12@gmail.com>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: block: skd: remove skd_pci_info()
Thread-Topic: [PATCH] drivers: block: skd: remove skd_pci_info()
Thread-Index: AQHWz9z+X41O+6EQc0KJnRIciprIXQ==
Date:   Sat, 12 Dec 2020 01:59:51 +0000
Message-ID: <BYAPR04MB49650922C1631E8BEF425AA486C90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201211224151.GA113093@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca1db589-5da1-4edd-8c3e-08d89e419cbf
x-ms-traffictypediagnostic: BY5PR04MB6422:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB642230B8693804DC17016A1086C90@BY5PR04MB6422.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oRe9uIk0F6b4WjDibjPDLcwqzihbzTFkKSECSmGMi5FSIO6TzcIOfueP1gChBUBTR6MBKAGab03KOYrRv3+WDKG/UWgmZiqsUF7GnZ4SokBnRAtruDKSfDE1w3OBYSQ1gs6V5tshFtB68kPAUcKwCwt29Ud4EJrI8UbXFV8f9qzEOZivydfk+RjcT5Q/Em9dIBxXj+JVycxV1HactG01K5/Ar80z+vBCXmcfvIMg7l4+Q7yPe5mRsJOu812+MoubzjMJXBibt2PYUtpgsPf5tJ/nyVeweDqTuX1/jKVYmtkDIX2NzYkkhwirqZ7wnbWBIroRObiLB+oiujDy/BP3UA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(86362001)(8676002)(7696005)(9686003)(54906003)(6506007)(6916009)(33656002)(71200400001)(8936002)(76116006)(66556008)(26005)(66946007)(4326008)(64756008)(52536014)(55016002)(5660300002)(53546011)(2906002)(508600001)(66446008)(186003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RdSnfzg0x6vTJiie/uXaUPGxE0bXLNZzhAIKNNpLPQYKMqp62Re0muT98ekU?=
 =?us-ascii?Q?1n0RqbbEN37wCS62Db38gduJBS8L0ojuPvIEwIk5RMfbpx05F7v+dSuTpWh8?=
 =?us-ascii?Q?W1rk7j2YEwQHb6I1KNBpgdTyKwCKhFDG+zJvcmQQtWSxPhbY0qwYNJZrmI8D?=
 =?us-ascii?Q?wi7O+eAHQP7I7k0ZW9CPZqNiO1Cf4oDJY4tYdJuzewEr2nNdRJjBw93kysYi?=
 =?us-ascii?Q?VrE9qhZXuHa+AqPpvHySDl8cH+0UFVMEQkYSGaXzjgqxO4kTw6kFMSe/a0Cf?=
 =?us-ascii?Q?3iH0DdvDFoC6sTHDNIBizlGPwGhALUugvJz5Lucom+iL5DynlFCDLyBrfVX4?=
 =?us-ascii?Q?51Rt58fPlHZ6gApf4USLdfV3FG7Dhi9lk+oUNUXgOuXnBCbA4DhnN/gI/Tg6?=
 =?us-ascii?Q?TUaFvlQI2LxBQkWBYkGjLylgkHtGHKNfBFkkO2NEpWRR+hAxAOn0DPsjXbZG?=
 =?us-ascii?Q?hp1ANJo3rRjQXFs2oPbffD6kvwuXEFUFmFyBH4dUThqWm/PIma6cYTEiGzjF?=
 =?us-ascii?Q?StAzB2sc20yPrNmheR56oW5Qpfz8+5NLQfB2Gw5jqVZCbhSFuV1qzbtUMh2U?=
 =?us-ascii?Q?YLpOivsBhaewBBdUFxGZ0pM16ClzBZZm8RBbkzMwners92OysAXM4+7pDDhb?=
 =?us-ascii?Q?d+FsQ/IdKC3Qo/or/8WkldO7qlJNyF2DlByOdS9zbxGeO2jJFNPwgEJPMkr9?=
 =?us-ascii?Q?iDIagnUGid3FPyeGDpwSpxoHDzcO7uPVHYXZqjlh6XLd9nfiqA4VHYTxinz1?=
 =?us-ascii?Q?xAVx5xSM1BTdQ/CD2iSqYM5be3vmCwFw5VUbFeLRrF6xeG+uzyDnrpIvOHLi?=
 =?us-ascii?Q?BuFliK75euAAQ7iX0ouFmfp4NyzFwj/Mwz+qld20Crr0h42hbAHiz3x8O9OS?=
 =?us-ascii?Q?3b8UUkpN09yZYq854JUng7AyPXGuRFrQ1i74yEfDRoTlJeJIJZdibxml0Ntd?=
 =?us-ascii?Q?G9sswIudnS0pJfXycSszQOLHuBJqxpZVfJ+GjHPpo2fB0MyF6Sk2ItWCh7P+?=
 =?us-ascii?Q?Swch?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1db589-5da1-4edd-8c3e-08d89e419cbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2020 01:59:51.1137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8wl8/rSPC6TvsSA81mXS6oT49nf7MbLExGXzB1YK2dKsF6wGAcRwNmShFvKmkUPfszDsdAouHd7tzBN4Ag3AW3/3GsTcB2XZQ4nmMl8tSNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6422
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/11/20 14:41, Bjorn Helgaas wrote:=0A=
>> The skd driver prints unknown if the speed is not "2.5GT/s" or "5.0GT/s"=
.=0A=
>> __pcie_print_link_status()  prints "unknown" only if speed=0A=
>> value >=3D ARRAY_SIZE(speed_strings).=0A=
>>=0A=
>> If a buggy skd card returns value that is not !=3D ("2.5GT/s" or "5.0GT/=
s")=0A=
>> && value < ARRAY_SIZE(speed_strings) then it will not print the unknown =
but=0A=
>> the value from speed string array.=0A=
>>=0A=
>> Which breaks the current behavior. Please correct me if I'm wrong.=0A=
> I think you're right, but I don't think it actually *breaks* anything.=0A=
>=0A=
> For skd devices that work correctly, there should be no problem, and=0A=
> if there ever were an skd device that operated at a speed greater than=0A=
> 5GT/s, the PCI core would print that speed correctly instead of having=0A=
> the driver print "<unknown>".=0A=
That is the scenario I'm not aware why it prints unknown to start with=0A=
and I couldn't find any documentation also, that is why the concern.=0A=
> I don't think it's a good idea to have a driver artificially constrain=0A=
> the speed a device operates at.  And the existing code doesn't=0A=
> actually constrain anything; it only prints "<unknown>" if it doesn't=0A=
> recognize it.  The probe still succeeds.  I don't see much value in=0A=
> that "<unknown>".=0A=
>=0A=
> Or am I missing an actual problem this patch causes?=0A=
You are not, I'm just not sure without any documentation why does=0A=
it print "unknown" and I attributed that to probable firmware issue=0A=
(since we all knowhow creative firmware can get ;)).=0A=
=0A=
That makes it the problem with original code more so than with this patch.=
=0A=
In that case I was proposing just keep the original behavior.=0A=
=0A=
But maybe we should apply patch and if any user(s) comes up with the proble=
m=0A=
then we can deal with it.=0A=
=0A=
Whoever is going to apply they can add :-=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
