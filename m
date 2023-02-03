Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DD8689F86
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 17:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjBCQqD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 11:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjBCQqB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 11:46:01 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2088.outbound.protection.outlook.com [40.107.15.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7E4A2A75;
        Fri,  3 Feb 2023 08:45:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7ysdW0p1xaVvS7yh7ASS7uomVnwt0vMb660Rbe0tdiVKaprdWUop5sfePJjQif0fhXlFoHIBEmudHq6sXyDRqctqbn9PLsUPnU5xQx9BKPah3KsGI6nRwI2dtuNgKP4cRvLyEQXOGe2G96CsB2q6weBGXnOoXqSDQPg+fjtBhRHy0/uT5SOaQoVBFiLl5PZ3K8BQbhCprS/YZMJUV1IkApGkq7IdA2cnjBYX/vsmjodtL6FDD6/6Dy6mIX7EzRNZ7lwlznP+VuTt5Pgs+60XP0kzveIggy0/OmdHZqlRWZ8uJmHdsuZMVz6dnORhQod4FVUh2ZFIREz/jKRpsmsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NCKNHhy0IaOa8QnDFETg0u+xORmH0I5WwhSzkkb0Jo=;
 b=fHopNClAPxS6tRviXrdl5lZg9ipcmdrcfZ/uwQuwcFjtBzMhx3ZKgE+xYReCs417LzLsy6lh9hI7injTkY1jhmQoVvsLh+PIL7gDSfv54IMzn8smFdyRgX46kiXjKxmMwF2n9csWSGzduY4kIiZl+DyCiX94QG6CKGmWpZ7/uwGlbQNLQJGggdGqJ+I9/bshy80yCDHSudb0ZADew9h1cUoX/YD4fIUtnEQaYT8A655sj5nN2p5Hsiyf1K4+xQHQf+GRgDVlCJLNDHv2yWb7ax4mLQIVXVpRktkQAtcxWQrhv0KdAL8kIBgofDEVu0uNCXdEIhmIwyyGVhMia2+mYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NCKNHhy0IaOa8QnDFETg0u+xORmH0I5WwhSzkkb0Jo=;
 b=KrhTrvrgd0RW5rZLOMFLX4FIzK33JOOtUy9XF+2QEmdjj+2ScSgVGdrYfED5uwSL5j1LDavc/rZEeOWVRlvwLsl2l7hhxis0nR/4j4kyVEiurgGtXxIsYMz+aKrqxdvWqW8Pl8D4lj4804SENDYeyMVvtM7+1QEJlJCFkAvSAPE=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB8038.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.30; Fri, 3 Feb
 2023 16:45:53 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::ca48:3816:f0b6:3fcd%6]) with mapi id 15.20.6043.038; Fri, 3 Feb 2023
 16:45:52 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Shunsuke Mie <mie@igel.co.jp>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
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
Thread-Index: AQHZN7bpBm+5RmnRNEW5Iyx9WPW3za69bfSA
Date:   Fri, 3 Feb 2023 16:45:52 +0000
Message-ID: <HE1PR0401MB2331EAFF5684D60EC565433688D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20230203100418.2981144-1-mie@igel.co.jp>
In-Reply-To: <20230203100418.2981144-1-mie@igel.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|AS8PR04MB8038:EE_
x-ms-office365-filtering-correlation-id: 78ae892e-453c-449a-b4c1-08db06061cf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BGP2qrXYyCPchI7CKloqBxSjUi7JwedX9PckfNEPSnfJ3WT/vm1K+iWBhIBv8V7N3MK68e6/cS7/4qBH3rj5pqYz2+IJp6/MLDhTOSylrMg3Dmtzl/nzVSh6lYmW4Tqr58hGgh6JAYZP6pDDqWt9W/S39PQLqzZtNxKiBw3C4Kwse2NVY0BWOIl6yvJaUJ6y+wwwpjQHYQ74BOledBmXn6zzUlxsl30r5TGQS+oyvmtL2DD1V890EyvACErHMhtyNjz01yaB++d2YHq4/r5u6eT4jsXm47SFRB1lzk5SGL0uVbBa423zeFWFP/eKVZZ8CRez5yjo7Wheqtwjxex3iY0S5XM4ZwZBgHBQUsXxcIwLNih6jrXlFAUsKU+6rob5w/dlpY2Y+u66JWJIUzjHEE+Ygc3mF4nkgldvQMQDeCp2LMEzHMHS41IGVfRclHJ+gw+5fFMXcQExWB323kklmanxPIQn1RSUlfkmltgZQfQB7RY5+GwluOT+v4TTFXZ2FZ82ugLkG5MVupYi2F6loD1bqiAYs6UPhe1uC+hP+tQ07Q0EXAB2cWKBuDl02sNQi3NMxQjq2+5xRitZU8gIG90Mdp++TDsnCOT347WND1yKTyLDbWjjvKLZxQGwNZcC88ssIjkKKCo5+cI02SCN8HAgVDPJZs8pGFhlP4sUepBAExd5Zp2yHTIbpr7ukwrifaVsymaJ0pINfjzlzYX/8Vx2X9drNrqTLp/MqW81dp8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199018)(54906003)(110136005)(316002)(71200400001)(45080400002)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(4326008)(8676002)(83380400001)(186003)(9686003)(26005)(6506007)(53546011)(55236004)(66574015)(478600001)(7696005)(966005)(86362001)(33656002)(38070700005)(55016003)(7416002)(5660300002)(44832011)(8936002)(41300700001)(52536014)(122000001)(38100700002)(2906002)(66899018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?kYbrvmwTOEvi4SfYde+9tDrRyC8xcdiEUg9GGTRZ34dJHMHXhp8QF5W0d2?=
 =?iso-8859-2?Q?zCA55VhhWfSSyonZTTZqXvyxnhkAk1rL8yjnY120q9MgxljffbI3gxvR63?=
 =?iso-8859-2?Q?Z5DFtxeSQ1+6gX89fuiCHXl+Arxo+hXsemH+/pIp3rLbgkkDS6fHjs0lTs?=
 =?iso-8859-2?Q?2AZI3oEmoX2kqzh+esYLbwbwsWehTxTIsOTLVJvgF50Z3JsByzgw6scCD+?=
 =?iso-8859-2?Q?hvOw9Lz+M+Ptn5vD08HSoBzqvcLI8SCyI2BYDWLuaX63C34axq1FpR8nYz?=
 =?iso-8859-2?Q?cnep/njNLQR38x1mQE3eWRFTHW0+Zb9w24BPD0FihBfesDALyvzE0zdvKP?=
 =?iso-8859-2?Q?sDcBZBJxJjT+5HBZ3d5zSjzM9ZgShmzKXaISGzPLy7DdeNjniOxi2Hy9Yp?=
 =?iso-8859-2?Q?OTOo1haSgfIFnKjgvojaca9HcKWeBiRitwm/O6l0MyxBVdd6iBb5bM9zJs?=
 =?iso-8859-2?Q?x1Fwn/2KwmS2D1US54q/fdnwcsnVHXJhTVm21GDwb846CJyW5BrDakqpwp?=
 =?iso-8859-2?Q?Lo/qwajrr07soao7ue0nCT7n1Oy2l6D0AwTp45mV1cLB5LADQNAd6XDWca?=
 =?iso-8859-2?Q?bIG/l3Mv5se0WgJkHmoDfNwks7DUngCkMmiMJExFSgZPiOrZ/jbaEMK3S0?=
 =?iso-8859-2?Q?brbANJRBvgwrDigfebUl+UrqBh6T+ItevyJFinDLQMLJK1Ld28JuTE2ZsE?=
 =?iso-8859-2?Q?NqX6zNJM90zjzyYPRfAh1dgBkcb41BiFX9EfrEILad/rVysqZUqn7E2k00?=
 =?iso-8859-2?Q?1/SFzY9h3POSyQELr3Msuuv2dM8Kj3X9INqOIpGvndNdb/A12ey5MFZ2VK?=
 =?iso-8859-2?Q?ghKWj0MqF9mI+BKnlMOfD48tiJDFhwueACjf4uyJEYwcqRcR0bXEWe3Tol?=
 =?iso-8859-2?Q?s028qjOS3IZ3U+dooHSIcoLFpCP/atN6jYb7zPN7ibr3z8y2z09G2gpdAO?=
 =?iso-8859-2?Q?5w437ovsGenCrQqaD1ZqPwcl9jQf0LHqHTaEXQWyeEJWdJvBbhDIYGtgvQ?=
 =?iso-8859-2?Q?smx9ei/tLAeMFh/bujZS5qwXbxdZ3wM9G8D3X95mbaM3H9kS9D/TOcUmIp?=
 =?iso-8859-2?Q?85x4YIQghj9aywYB/WDN7S2LdHnRdRw6iu4Osr3bpmzamnXcwZ0KpA7DV1?=
 =?iso-8859-2?Q?+RF2OIMd7DQ8s+Rl7jNYX4a8nLjJfGwdOVsZcvL6mpg0rM7ABfjpXWdM3A?=
 =?iso-8859-2?Q?7OV4Sp3Xqj8uOScUBWuRHmEZQG86b1ESjKWB8DNCsB1E8L8GYJqqcpUmEg?=
 =?iso-8859-2?Q?cI/w+JxMmDV3V8I3akDoYKqcBKLHkEtFuPuwMn28HIcO6Fup1vA37yPsaL?=
 =?iso-8859-2?Q?4rs8v3/wnniJYCy4YgkqeT5RoLOpsch9VeP9wBPUGY/tpLRKAdVxFpiBsO?=
 =?iso-8859-2?Q?CPaAJ1Wa9Urwg+w+P2bHSXKI7CME8z2uLH4xDS0QqF9aVec5EsrJVqD2ps?=
 =?iso-8859-2?Q?O2E+CJdiO97MV7hPxye8a3wALKaPFjJAFMwCeR3eEpJSwE51U1JuBYHbDy?=
 =?iso-8859-2?Q?b0PG8ZD7Hr6OIity7YlQkv/gLzBNGSv4DQocuciRYkncmViRudSMOn4pyo?=
 =?iso-8859-2?Q?BjwnSaU2tKM0CcG77CpF/mctRORTLcMzr0FR2WhoNw3+yC/Y5qQRxEHh82?=
 =?iso-8859-2?Q?rLAAE7tCOpUMI=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ae892e-453c-449a-b4c1-08db06061cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 16:45:52.8023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a43noGIblr6cFx3lYvOrWRpXa87WDRrNLBDAHhUCAVtqSKZ21LPDCeGDlrrUYCTsnVYz1CZnqxFFQlxSBF5DiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Shunsuke Mie <mie@igel.co.jp>
> Sent: Friday, February 3, 2023 4:04 AM
> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Krzysztof Wilczy=F1ski <kw@linux.com>; Manivannan Sadhasivam
> <mani@kernel.org>; Kishon Vijay Abraham I <kishon@kernel.org>; Bjorn
> Helgaas <bhelgaas@google.com>; Michael S. Tsirkin <mst@redhat.com>;
> Jason Wang <jasowang@redhat.com>; Shunsuke Mie <mie@igel.co.jp>;
> Frank Li <frank.li@nxp.com>; Jon Mason <jdmason@kudzu.us>; Ren Zhijie
> <renzhijie2@huawei.com>; Takanari Hayama <taki@igel.co.jp>; linux-
> kernel@vger.kernel.org; linux-pci@vger.kernel.org; virtualization@lists.l=
inux-
> foundation.org
> Subject: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
> function
>=20
> Caution: EXT Email
>=20
> This patchset introduce a virtio-net EP device function. It provides a
> new option to communiate between PCIe host and endpoint over IP.
> Advantage of this option is that the driver fully uses a PCIe embedded DM=
A.
> It is used to transport data between virtio ring directly each other. It
> can be expected to better throughput.

Thanks, basic that's what I want.  I am trying use RDMA.=20
But I think virtio-net still be good solution.=20

Frank Li=20

>=20
> To realize the function, this patchset has few changes and introduces a
> new APIs to PCI EP framework related to virtio. Furthermore, it device
> depends on the some patchtes that is discussing. Those depended patchset
> are following:
> - [PATCH 1/2] dmaengine: dw-edma: Fix to change for continuous transfer
> link:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Fdmaengine%2F20221223022608.550697-1-
> mie%40igel.co.jp%2F&data=3D05%7C01%7CFrank.Li%40nxp.com%7Cac57a62d4
> 10b458a5ba408db05ce0a4e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C638110154722945380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
> C%7C%7C&sdata=3DtIn0MHzEvrdxaC4KKTvTRvYXBzQ6MyrFa2GXpa3ePv0%3D&
> reserved=3D0
> - [RFC PATCH 0/3] Deal with alignment restriction on EP side
> link:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Flinux-pci%2F20230113090350.1103494-1-
> mie%40igel.co.jp%2F&data=3D05%7C01%7CFrank.Li%40nxp.com%7Cac57a62d4
> 10b458a5ba408db05ce0a4e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C638110154722945380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
> C%7C%7C&sdata=3DRLpnDiLwfqQd5QMXdiQyPVCkfOj8q2AyVeZOwWHvlsM%3
> D&reserved=3D0
> - [RFC PATCH v2 0/7] Introduce a vringh accessor for IO memory
> link:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Fvirtualization%2F20230202090934.549556-1-
> mie%40igel.co.jp%2F&data=3D05%7C01%7CFrank.Li%40nxp.com%7Cac57a62d4
> 10b458a5ba408db05ce0a4e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C638110154722945380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
> C%7C%7C&sdata=3D6jgY76BMSbvamb%2Fl3Urjt4Gcizeqon%2BZE5nPssc2kDA%
> 3D&reserved=3D0
>=20
> About this patchset has 4 patches. The first of two patch is little chang=
es
> to virtio. The third patch add APIs to easily access virtio data structur=
e
> on PCIe Host side memory. The last one introduce a virtio-net EP device
> function. Details are in commit respectively.
>=20
> Currently those network devices are testd using ping only. I'll add a
> result of performance evaluation using iperf and etc to the future versio=
n
> of this patchset.
>=20
> Shunsuke Mie (4):
>   virtio_pci: add a definition of queue flag in ISR
>   virtio_ring: remove const from vring getter
>   PCI: endpoint: Introduce virtio library for EP functions
>   PCI: endpoint: function: Add EP function driver to provide virtio net
>     device
>=20
>  drivers/pci/endpoint/Kconfig                  |   7 +
>  drivers/pci/endpoint/Makefile                 |   1 +
>  drivers/pci/endpoint/functions/Kconfig        |  12 +
>  drivers/pci/endpoint/functions/Makefile       |   1 +
>  .../pci/endpoint/functions/pci-epf-vnet-ep.c  | 343 ++++++++++
>  .../pci/endpoint/functions/pci-epf-vnet-rc.c  | 635 ++++++++++++++++++
>  drivers/pci/endpoint/functions/pci-epf-vnet.c | 387 +++++++++++
>  drivers/pci/endpoint/functions/pci-epf-vnet.h |  62 ++
>  drivers/pci/endpoint/pci-epf-virtio.c         | 113 ++++
>  drivers/virtio/virtio_ring.c                  |   2 +-
>  include/linux/pci-epf-virtio.h                |  25 +
>  include/linux/virtio.h                        |   2 +-
>  include/uapi/linux/virtio_pci.h               |   2 +
>  13 files changed, 1590 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-ep.c
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-rc.c
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.c
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.h
>  create mode 100644 drivers/pci/endpoint/pci-epf-virtio.c
>  create mode 100644 include/linux/pci-epf-virtio.h
>=20
> --
> 2.25.1

