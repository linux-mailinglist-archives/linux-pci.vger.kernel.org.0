Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD5968DD7F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 17:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjBGQCG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 11:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjBGQCF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 11:02:05 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FD87ED8;
        Tue,  7 Feb 2023 08:02:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WclhgZNy5g9yH7fT1H8dNP/txQxfH25FLx10I/plOF+6FaC3pmWbKMa8Uit8ZoK7jjYVMPCC8CJesWfBjd9mKsxWV/tNpVKP2xpWbHF1R3c01WTwo+Gmz8Ig4Ty5d19oEdETN3Pixn7O4UwWEcSsnKkxzggxa46yRmZW4FHd+oopnDJhPZB1WUKzliR2oTZRbiS40FyLprf4t2ml64pvjBQE0AagxKExCQZZcArRldzbj2yM1oyvz4zqEP2FHUEDcAVv7CN3ol9sTY1j9aC1ml0TfYBMTD2R81RQOLmnwbV3V7FR2/HLltbnpKJhoHqM5+cMDh8VqgvSTDVWp+v2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trT7AQ4Yo7vjDhhkx3QMLqILs5SqkIMo53Zb0bJ+9dU=;
 b=kTVhQOXEFY/hLbAJJ38/vDI+QyR7WucHgfVH5coQKha4LERMRfynpXoxuzU80kMAxv7Vg6CgrpHoal3J5stSDzBRbof5jl8MQ/Mbc1vCGfnoQt7Vo+udRIu9PR0rZ/X54TJcz09yr8+rySW0EFvedqrzDRanuJuS3TEF87ms7DQribDAzh6OSpqu6hDcj1Fe+SWdMcKkw6roAxvJljcmKxQvmGbvSuN9rckKvnCoCxrxl+4KuWzvt9qF5oHPYakv60o+3IQIgM3lxl4NNpVPxw7hmsV47f0fDHn25YgPKzhmqGnn5zgeHiyPVh4umirD5r0D7FrUSqNi1154ROa9aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trT7AQ4Yo7vjDhhkx3QMLqILs5SqkIMo53Zb0bJ+9dU=;
 b=TzesTbmEEzGGFDbqEl8X00qgNIZe/9ETerPEpI/IXLmsDqHhK6UR8pZ8elwdEzZoj6WBvb2I441KOepVfVSH0zOJU/mJygLC9lxRPmutSHxJg9dxdCS68HiZlsntV6+xBRXx48Vd2zewI96ByVE8q2c1lZLk4JxhmSgYwgDKJAU=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB8641.eurprd04.prod.outlook.com (2603:10a6:20b:428::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 16:02:01 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 16:02:01 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Shunsuke Mie <mie@igel.co.jp>
CC:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: RE: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
 function
Thread-Topic: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
 function
Thread-Index: AQHZN7bpBm+5RmnRNEW5Iyx9WPW3za69bfSAgAXgoQCAAFlCIA==
Date:   Tue, 7 Feb 2023 16:02:01 +0000
Message-ID: <HE1PR0401MB2331A8D5C791C34D9C39A62688DB9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <HE1PR0401MB2331EAFF5684D60EC565433688D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5qjDDEK0NB=BWh00-HGU-p+sC=8TyP-oPdccnZxKxZt9w@mail.gmail.com>
In-Reply-To: <CANXvt5qjDDEK0NB=BWh00-HGU-p+sC=8TyP-oPdccnZxKxZt9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|AS8PR04MB8641:EE_
x-ms-office365-filtering-correlation-id: 2239fe51-85ec-45ef-2bb3-08db0924a61a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ov3R+njDm1Otj3EXXWb2dSjI9D1inVPghcEyhBXLIVVxDpjWmF3qX9i3z/nGgDVAPHJkPju2BQx40xrvXppzVChGvfQCA8/nBveSJmCb2/b2y3+lFFxW3Kfcs8KZPu8Ev5fo6LaIIR5XQmxMU5xmzMA+j3KNtiZt3jZKQulRWEkCFbb49CzPoUX8xZV8+X6KCJWEJ6M1LCvDg7ZJMwvrRs83I1KATHTN3I7e2GwvKwBXMNPvx3cq1eNtR9rZBT3QJkXg84UoMHPm1rrWraTmliUB1s55rEp0Ux8drON0/+oJX3/SMfR1qHjwnwmb5Kzm0nqXmU6t9QZBrOKs/Krm0tn7sk9ESWs1vwv0jS75FWsvukM9tQflrcxdHiOytzDsjZZt+ydapkjdHH1mdgJCId1MXaHRuz8HtbFJz6YISKkjA+IUbwYeoWt2NDlm2c5OMOa6MbK9TLpF4TnsnlfTaFPncOgXiW7xKI1gEyreiOqqYIdy2oPLJCTTPw3XRyw0ior2hl+PpAy0oJ/nbeIXU0w6Mk3jFxcd3qh58JJPWvq9ds+OnmR5MgtXvKzWoxdSVPwnslQJfWnKynhNBs7gZLIHCMHcA/aoUgt8BG0qBfgqHm5nf8DcZWBjRZU1cJu6X8OAv2YNbH9m5XXqybqLcVtKtmJjxVEVmzlI4euN0gh9WUTsRtE2hiXw/nyns6mZcR19gTI2xS0QgGDr7avHURIaocTz0P69lub9Yi7MjiizJlGB9nCxZuFKN1yh0PuSadbRNGXnRAQXZ6fSB06fCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199018)(66899018)(4326008)(41300700001)(6916009)(38100700002)(66476007)(66556008)(66446008)(76116006)(64756008)(66946007)(52536014)(54906003)(8676002)(8936002)(33656002)(38070700005)(86362001)(122000001)(186003)(55236004)(9686003)(6506007)(966005)(26005)(316002)(45080400002)(7416002)(44832011)(55016003)(5660300002)(2906002)(478600001)(71200400001)(7696005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Ic4Pdi6TsWinAC2pq+e08wFTPSkbUwbQlFgQXh4Ocz/i9a2VIHwpBD0ILe?=
 =?iso-8859-2?Q?0331OA6eJRry/n/xOipfTnAFL+e3Ys7m5Uo2ls9u+R3SynPbKkUbCDHbMa?=
 =?iso-8859-2?Q?G8zWITIGi8a5SvPQxaXbNnsOthChjnMJAjNoRWE1AwlyrOVa8pLHZcEajj?=
 =?iso-8859-2?Q?/1C2A6OjbMtSNSJJnoiOh8UJZ3UFCSSEbS7WcahPDG9UpM7lybxQ/UfVXL?=
 =?iso-8859-2?Q?xHOIBp5kVstvX/gX79jE6c2rAAgF45PEb98kMa57ix6PBh17fYeTTLBhvF?=
 =?iso-8859-2?Q?xe2anp4S221uehQbES9N44UPzg4hiGjJ8d/U+4l8fBITrHQSBQu54+FHV2?=
 =?iso-8859-2?Q?9dqYuhJhDE/8mvZWHYwIwtZFzR2iH4lOiGns4IPstgff9i8HC4FRVugaS3?=
 =?iso-8859-2?Q?cRmKHZ6i05zhCMj15HEOuN9hACR3eJ3JNG84j4bZKpyxJKDqnw7Ni0bay9?=
 =?iso-8859-2?Q?t10W510vuwvSNmqL5i3ti8jdLOS1yjQ+RMmZLgVh7oPB/3aWc8CwX+CRaY?=
 =?iso-8859-2?Q?nZBtGHpiCc/Ukgc4RPOlO/uTnd+xC2cGg1Ny0y8FPvX1uoO48JTY6jc23H?=
 =?iso-8859-2?Q?w5QPlwWY8LclZgdShQe0UDEiOovyakrbMa6bAJ39Zdzd80gh42jA+9Up8F?=
 =?iso-8859-2?Q?qMoErcn+gEkv/AkyhMEoRH3wj8KftL/V+fktHmyRvBwnwDpq40gASaFsoW?=
 =?iso-8859-2?Q?qh6WTM9Te4DMCJHLTcJm5iQLudhEtvOY/lOPx79EfvWusgg7LDyLUALY/V?=
 =?iso-8859-2?Q?a4kiKOycHn+WoQTDEHLXJKLRGiSlGR7/ZewCuGCqoz7wU6nBIuqUP5hfsX?=
 =?iso-8859-2?Q?VBcibco8sJutW7DGQ213EWbp05OrgPO3XstbwwrXTHOk6WPN96AjaNIsOu?=
 =?iso-8859-2?Q?HPXiHUFkFtJecSO4E0xFWgoEb8BdEy+Hp7KWJKe1iBUOCjni7pzSspydSC?=
 =?iso-8859-2?Q?tG+TmH7KLXERZiADWCoGn701ZHHZPdi+DTaRHt5iOG1OrHey9JC/+qvEwJ?=
 =?iso-8859-2?Q?Hqyl7dfxkeA8Gi6PQ3n52wqWz+y94ZcFLS0Xu8p1zWr92fGPkHmotgVwPT?=
 =?iso-8859-2?Q?LmBLuVgKzGm1vkrtz/66pJbfEeQahOA1xoo+T3LCvajhEimP+hZ0UXZ+LQ?=
 =?iso-8859-2?Q?ale74HtlwleSquQj4MCCKSM5xHoRu0/zVU5vSvOkMesuP8YJ4zNSd4yfOG?=
 =?iso-8859-2?Q?CdDau7/iwSNRc1lEBtaxEcF8xwhREX/ei1ykyY87y0d3wjv37Ze0vV+24e?=
 =?iso-8859-2?Q?YBsx8JyySueona7x2wXUmvJ50vnplVtJwAV3buvpFsLBOmis2ARaWnUxGY?=
 =?iso-8859-2?Q?uQahZfZaRfDvCYctzslkaQYe5nv+0kNOpTC8KrqoCbjKPTkP7tTjK3dNhm?=
 =?iso-8859-2?Q?KVM4Qi9V/Jf76i+9N0FdNHxiwyfOJxVhR4fvnr9SWrfv4Bg1TdoV1G1ztA?=
 =?iso-8859-2?Q?taVZJuGD9W76nVMTnB3mD14cmS2i+zxslQKHNgc3kcQ7zIQGweXZzMFH8v?=
 =?iso-8859-2?Q?51j0m4x3ytIF5LmEznKAexdzY4VCtNxCVgsm5Nfi/BhfuRmcJRU9I/gwW+?=
 =?iso-8859-2?Q?j50IBoOtHTuE0b93HPwjddWpJ/iisPMqiZlml9CUrHqKy64sQDxU1vAfgc?=
 =?iso-8859-2?Q?9TalzzKgEKfRQ=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2239fe51-85ec-45ef-2bb3-08db0924a61a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 16:02:01.2794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EM6+Rwe4KLXbBcATIKo4ldxDVn4IHvaHky4Tx4s6HEWMKrT8LpT/f8/cJ+Yk63D+A1MLEG74X0L1wN1k6UmEZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8641
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> We project extending this module to support RDMA. The plan is based on
> virtio-rdma[1].
> It extends the virtio-net and we are plan to implement the proposed
> spec based on this patch.
> [1] virtio-rdma
> - proposal:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Fall%2F20220511095900.343-1-
> xieyongji%40bytedance.com%2FT%2F&data=3D05%7C01%7Cfrank.li%40nxp.co
> m%7C0ef2bd62eda945c413be08db08f62ba3%7C686ea1d3bc2b4c6fa92cd99c5
> c301635%7C0%7C0%7C638113625610341574%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C3000%7C%7C%7C&sdata=3DHyhpRTG8MNx%2BtfmWn6x3srmdBjHcZAo
> 2qbxL9USph9o%3D&reserved=3D0
> - presentation on kvm forum:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fyout
> u.be%2FQrhv6hC_YK4&data=3D05%7C01%7Cfrank.li%40nxp.com%7C0ef2bd62
> eda945c413be08db08f62ba3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C638113625610341574%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
> C%7C%7C&sdata=3DucOsGR1letTjxf0gKN6uls5y951CXaIspZtLGnASEC8%3D&res
> erved=3D0
>=20

Sorry for our outlook client always change link.  This previous discussion.=
=20
https://lore.kernel.org/imx/d098a631-9930-26d3-48f3-8f95386c8e50@ti.com/T/#=
t

Look like Endpoint maintainer Kishon like endpoint side work as vhost.
Previous  Haotian Wang submit similar patches, which just not use eDMA, jus=
t use memcpy.
But overall idea is the same.=20

I think your and haotian's method is more reasonable for PCI-RC EP connecti=
on.

Kishon is not active recently.   Maybe need Lorenzo Pieralisi and Bjorn hel=
gass's comments
for overall directions.=20

Frank Li=20

> Please feel free to comment and suggest.
> > Frank Li
> >
> > >
> > > To realize the function, this patchset has few changes and introduces=
 a
> > > new APIs to PCI EP framework related to virtio. Furthermore, it devic=
e
> > > depends on the some patchtes that is discussing. Those depended
> patchset
> > > are following:
> > > - [PATCH 1/2] dmaengine: dw-edma: Fix to change for continuous
> transfer
> > > link:
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> %2F&data=3D05%7C01%7Cfrank.li%40nxp.com%7C0ef2bd62eda945c413be08db
> 08f62ba3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6381136256
> 10341574%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Dd
> VZMaheX3eR1xA2wQtecmT857h2%2BFtUbhDSHXwgvsEY%3D&reserved=3D0
> > > ernel.org%2Fdmaengine%2F20221223022608.550697-1-
> > >
> mie%40igel.co.jp%2F&data=3D05%7C01%7CFrank.Li%40nxp.com%7Cac57a62d4
> > > 10b458a5ba408db05ce0a4e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> > >
> 7C0%7C638110154722945380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> > >
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
> > >
> C%7C%7C&sdata=3DtIn0MHzEvrdxaC4KKTvTRvYXBzQ6MyrFa2GXpa3ePv0%3D&
> > > reserved=3D0
> > > - [RFC PATCH 0/3] Deal with alignment restriction on EP side
> > > link:
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> %2F&data=3D05%7C01%7Cfrank.li%40nxp.com%7C0ef2bd62eda945c413be08db
> 08f62ba3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6381136256
> 10341574%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Dd
> VZMaheX3eR1xA2wQtecmT857h2%2BFtUbhDSHXwgvsEY%3D&reserved=3D0
> > > ernel.org%2Flinux-pci%2F20230113090350.1103494-1-
> > >
> mie%40igel.co.jp%2F&data=3D05%7C01%7CFrank.Li%40nxp.com%7Cac57a62d4
> > > 10b458a5ba408db05ce0a4e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> > >
> 7C0%7C638110154722945380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> > >
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
> > >
> C%7C%7C&sdata=3DRLpnDiLwfqQd5QMXdiQyPVCkfOj8q2AyVeZOwWHvlsM%3
> > > D&reserved=3D0
> > > - [RFC PATCH v2 0/7] Introduce a vringh accessor for IO memory
> > > link:
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> %2F&data=3D05%7C01%7Cfrank.li%40nxp.com%7C0ef2bd62eda945c413be08db
> 08f62ba3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6381136256
> 10341574%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Dd
> VZMaheX3eR1xA2wQtecmT857h2%2BFtUbhDSHXwgvsEY%3D&reserved=3D0
> > > ernel.org%2Fvirtualization%2F20230202090934.549556-1-
> > >
> mie%40igel.co.jp%2F&data=3D05%7C01%7CFrank.Li%40nxp.com%7Cac57a62d4
> > > 10b458a5ba408db05ce0a4e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> > >
> 7C0%7C638110154722945380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> > >
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
> > >
> C%7C%7C&sdata=3D6jgY76BMSbvamb%2Fl3Urjt4Gcizeqon%2BZE5nPssc2kDA%
> > > 3D&reserved=3D0
> > >
> > > About this patchset has 4 patches. The first of two patch is little c=
hanges
> > > to virtio. The third patch add APIs to easily access virtio data stru=
cture
> > > on PCIe Host side memory. The last one introduce a virtio-net EP devi=
ce
> > > function. Details are in commit respectively.
> > >
> > > Currently those network devices are testd using ping only. I'll add a
> > > result of performance evaluation using iperf and etc to the future ve=
rsion
> > > of this patchset.
> > >
> > > Shunsuke Mie (4):
> > >   virtio_pci: add a definition of queue flag in ISR
> > >   virtio_ring: remove const from vring getter
> > >   PCI: endpoint: Introduce virtio library for EP functions
> > >   PCI: endpoint: function: Add EP function driver to provide virtio n=
et
> > >     device
> > >
> > >  drivers/pci/endpoint/Kconfig                  |   7 +
> > >  drivers/pci/endpoint/Makefile                 |   1 +
> > >  drivers/pci/endpoint/functions/Kconfig        |  12 +
> > >  drivers/pci/endpoint/functions/Makefile       |   1 +
> > >  .../pci/endpoint/functions/pci-epf-vnet-ep.c  | 343 ++++++++++
> > >  .../pci/endpoint/functions/pci-epf-vnet-rc.c  | 635
> ++++++++++++++++++
> > >  drivers/pci/endpoint/functions/pci-epf-vnet.c | 387 +++++++++++
> > >  drivers/pci/endpoint/functions/pci-epf-vnet.h |  62 ++
> > >  drivers/pci/endpoint/pci-epf-virtio.c         | 113 ++++
> > >  drivers/virtio/virtio_ring.c                  |   2 +-
> > >  include/linux/pci-epf-virtio.h                |  25 +
> > >  include/linux/virtio.h                        |   2 +-
> > >  include/uapi/linux/virtio_pci.h               |   2 +
> > >  13 files changed, 1590 insertions(+), 2 deletions(-)
> > >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-ep.c
> > >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-rc.c
> > >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.c
> > >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.h
> > >  create mode 100644 drivers/pci/endpoint/pci-epf-virtio.c
> > >  create mode 100644 include/linux/pci-epf-virtio.h
> > >
> > > --
> > > 2.25.1
> >
> Best,
> Shunsuke
