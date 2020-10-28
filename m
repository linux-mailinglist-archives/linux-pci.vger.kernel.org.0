Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9AC29E1F1
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 03:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgJ2CEn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 22:04:43 -0400
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:53806
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727122AbgJ1VjU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 17:39:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAdrpXFDrigqo834Y5AOs2DS5Tg+kYn+jYI2FanJAgKoNovzt9Akdx8O0EWQ0uXWbI7FEie6NsQYmlqEN91LN4kdF7UcGKx9XpQ0GPO+0wNlyIspaA4lp5KhGmcgWjtXoI/CetM/BHI61MBtX3MyIpdxEuPUzw+Kj1t+Q1IWug3wZJwuY/gErTzkkpEqv225itI3f3i7urX7VomUYrwJInDSefUPc7bSEQU7wqrqZxU/oHTpM1osy8+SxLeeFhAmq390wWOtXQ+gRuAssZjd8CoEquKiZC1Ilg2KtYAhyCnh14tW1hGdeFb6vhzAja9b80siVHlMrRGexlanUgQEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AM28SGWvT0R7/4p29UhuNgrX3RybQcI24etQ5jSDfV4=;
 b=Mxbxqh8XVQoV29AFtCKtGZiwJEnKdxeiCBM4SJjEIWkd0saBQaZq5dUZRhtK9rKF58/6egZFDm9wKdaMgAIIAOHpicr3vNLrej0g6ISu/aIrPMDwWHYOIIfQitN3ahZlUlmTad1qxXuXgumrAV3IibaorjYPV9armHOYj0UmG7ViptK4jJpY+ig3LG1zvWZCefmyaGVXoutIil7NSDMD395lIVWcZR33mQKT36Zztabx/hXF+nbbrSJqD6feDhQoNnUrZTJA2KnP55j0GITptFnPhO4a7C2rKEeGyiMHjAoMkoKcLu8y2UEUjFCSBVWowm1xvGGJljwSapyScT3V2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AM28SGWvT0R7/4p29UhuNgrX3RybQcI24etQ5jSDfV4=;
 b=g+Hu04zpjhOuNLBCQVk9E5EAslswMJI6gyws20mAfDtldJb9j9da+XCKGgEzO/BcTCuoyhH9Gg09aogXv82XKNP3VGj9gTc8Q69cSbwclkb2N38P7Lcgax0uuPBCJvIFmRzyf4HgM5120xqQl2wXujDqRs7KDZ9hWkh8eLclHAA=
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com (2603:10a6:208:c8::16)
 by AM0PR04MB5907.eurprd04.prod.outlook.com (2603:10a6:208:12f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 28 Oct
 2020 06:05:28 +0000
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::2a:11b5:6807:7518]) by AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::2a:11b5:6807:7518%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 06:05:28 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH V5 0/2] Change vring space from nomal memory to dma
 coherent memory
Thread-Topic: [PATCH V5 0/2] Change vring space from nomal memory to dma
 coherent memory
Thread-Index: AQHWrM6hrUxx3H5v+0a5i9aKIfcorqmshSIAgAABZvA=
Date:   Wed, 28 Oct 2020 06:05:28 +0000
Message-ID: <AM0PR04MB4947032368486CC9874C812692170@AM0PR04MB4947.eurprd04.prod.outlook.com>
References: <20201028020305.10593-1-sherry.sun@nxp.com>
 <20201028055836.GA244690@kroah.com>
In-Reply-To: <20201028055836.GA244690@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f74875b-f687-4b86-5c13-08d87b07780d
x-ms-traffictypediagnostic: AM0PR04MB5907:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5907C1A30587F1926E91373A92170@AM0PR04MB5907.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: deW9XBB+yUJimmJMe4HYIB943FoLrgpCsp1WR7Q3MQYVv3Qh29Hbc10lA49WX3Dfld6Ff9JWDH9zM9HO8ZhCeZ54I7qwBuC3SNUl+Ax1CCafVzRoS4IJkZ8gbvEskuCavqvnwLZovZxgxxRskDS9z4Y9Q9hzY0onv0QHhE0aXd6EsdUqZxEaD0+9wa+hk3X3KwXznrIaH/6ryOXt1d/25zyZjIott+4pslvhAgdGUS9R85GqzuBsFXuBEVqQFN4I4aMraNArRmcam0eLzBHa61hga1vLFxjmP6ZZAGOmVw6344m4FKYN7d1VoghfBqb6UPISXlrqpoT5SvpovR6H2Qud8lG0jWU7Yx9gO4p5vUfkyckzByn/cgdvMrQT+q6agNatjEmVsZCoGw5ysGiFUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(8676002)(6506007)(7416002)(186003)(83380400001)(6916009)(76116006)(66476007)(5660300002)(64756008)(66556008)(66446008)(52536014)(71200400001)(4326008)(86362001)(316002)(7696005)(2906002)(66946007)(33656002)(966005)(8936002)(54906003)(55016002)(9686003)(26005)(478600001)(44832011)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ZrLf33yo3vRTVWnpUt3KZZ7m4DN3LKglOuXVzhfkcyh49N3ti2WkYLuGQ6AIRgyPPw3LrKZYMfqAU+CGYuWNmfvnEnJ3F51JNEheaUKQ9WZLmWu0mpuGmkNMX6yetk2pQw4BH+nredhgvhfDZvXnORVsN5L3klGXbSMlDvyNOOtXpUsel/AxWKEN2sYepEnLyRGnQQyEPhPJKTtK5+I23/T2R/WAxwy9Aom2hDYrBbn9ShcGOvvapv9DKCc6UYmp3k6gvfSDFInF5nLhZzoTSyRcZ4Sjh8C1Z/8Yzb2PMmWlcTiyjgQzS3MwTi215M/QzchoBTCAe8Ys1/yVFgbxr99XbhTUH7ql8K/RAWA3sOyQNIVY3ATtJKETDlNIdfG9/8Dje1WSMUndORkmczXuubD+mBOVEseTQgndLRPJTJRDZ9oXv8NxvLUO6ps1Pp7PLid07cUD8hvacbCtD5WFcQQAN4qGirv+35CtCOXbE2NahmwvoOC6k7f1w1Zty2yW5SoHZoNOiO27C/fZoinTKsIQhXoh4l+LyMu1W23nDMGuAj/vR+Wc+GIZgs9bs1AyBzaY0IeQo6S87Mg1JWsNE4qA2hKYh7SoacTR2VdDxxlhib3+cVPfPK091iiXwQonP3cR0UjBNPwWCROhJizK1w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4947.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f74875b-f687-4b86-5c13-08d87b07780d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 06:05:28.1204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Jgt98CL0m3DvIcMk+TwSz3ckvWu3Wk2jE0zE+00/OAZdcGBr6t9rHlk5JNX3AVcbhJweYqUHqY5VXbWWuIeQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5907
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Greg,

> Subject: Re: [PATCH V5 0/2] Change vring space from nomal memory to dma
> coherent memory
>=20
> On Wed, Oct 28, 2020 at 10:03:03AM +0800, Sherry Sun wrote:
> > Changes in V5:
> > 1. Reorganize the vop_mmap function code in patch 1, which is done by
> Christoph.
> > 2. Completely remove the unnecessary code related to reassign the used
> > ring for card in patch 2.
> >
> > The original vop driver only supports dma coherent device, as it
> > allocates and maps vring by _get_free_pages and dma_map_single, but
> > not use dma_sync_single_for_cpu/device to sync the updates of
> > device_page/vring between EP and RC, which will cause memory
> > synchronization problem for device don't support hardware dma coherent.
> >
> > And allocate vrings use dma_alloc_coherent is a common way in kernel,
> > as the memory interacted between two systems should use consistent
> > memory to avoid caching effects. So here add noncoherent platform
> support for vop driver.
> > Also add some related dma changes to make sure noncoherent platform
> > works well.
> >
> > Sherry Sun (2):
> >   misc: vop: change the way of allocating vrings and device page
> >   misc: vop: do not allocate and reassign the used ring
> >
> >  drivers/misc/mic/bus/vop_bus.h     |   2 +
> >  drivers/misc/mic/host/mic_boot.c   |   9 ++
> >  drivers/misc/mic/host/mic_main.c   |  43 ++------
> >  drivers/misc/mic/vop/vop_debugfs.c |   4 -
> >  drivers/misc/mic/vop/vop_main.c    |  70 +-----------
> >  drivers/misc/mic/vop/vop_vringh.c  | 166 ++++++++++-------------------
> >  include/uapi/linux/mic_common.h    |   9 +-
> >  7 files changed, 85 insertions(+), 218 deletions(-)
>=20
> Have you all seen:
> 	https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%
> 2Flore.kernel.org%2Fr%2F8c1443136563de34699d2c084df478181c205db4.16
> 03854416.git.sudeep.dutt%40intel.com&amp;data=3D04%7C01%7Csherry.sun%
> 40nxp.com%7Cc19c987667434969847e08d87b0685e8%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C637394615238940323%7CUnknown%7CTW
> FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6Mn0%3D%7C1000&amp;sdata=3DZq%2FtHWTq%2BuIVBYXFGoeBmq0JJzYd
> 9zDyv4NVN4TpC%2FU%3D&amp;reserved=3D0
>=20
> Looks like this code is asking to just be deleted, is that ok with you?

Yes, I saw that patch. I'm ok with it.

Best regards
Sherry

>=20
> thanks,
>=20
> greg k-h
