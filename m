Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E3A557EB9
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 17:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiFWPh5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 11:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiFWPh4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 11:37:56 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC354C56;
        Thu, 23 Jun 2022 08:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhtRk1G94diDum4O6Ez8b8sYZsg1TZqkjJs30vEn3KxkM6WPyBt1LbDwLphK5DqYqljxQ1hgxMpw7gb3EKmbYdSeVlGz2k7WenvXxBNWj9Bjc9dJdBB18b0odpSZfmiG3MZV8G/KdYvYRtncteDnlBOki7i5fDHdP76KtCTC9NBAG1/eVc4rN+F35Hj9Ba7cmvulp0ptMPzlO8Mml60vEvWcSDRkA8KfGJxOQnvVS6i2/3AATkCEsi9DhqG7mbJHS3CgzUp4+GZc3zKgclbad4tG7hwgcK7fvVYejgOEX68dk+KVvWBL1Pd9bV/N+2VCyrpMRfPj0OtmBv8i7/Z3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWA9BpsEG6ZXtx8AWH4iMW/MgW/yr0hK7jbPRZ3drNs=;
 b=gWs4qSHfLhi3r0qZpPfnzjo9WT/YLPM8gPROGwyZTDhXriICFf1dkEsTxlKmMcsoOSGHxo9E4Ba3zngAke3EOHxDPipDCrRUX5c+nWF8rA5UNwosd/FnkgCjuEzecJlZgfuUoSG8RWPCxDZHIFTq3LTUtPDLCkdvdWs3rdObNmGE5DRAfZqpEq6mOePNoI7LsW8N/B5P8KAase8TpawV8gHPZlkzMpjYJ1299SkgVRz/MiratXD/YQkU8TDZWiRyv9i34RJJdqAmoMh35QP1VIMCugInJ84hv/+6+h5OiPGpkIsNXnv6pqE5m/MFHDACcMBdgU+8gDzt8Ilonbu9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWA9BpsEG6ZXtx8AWH4iMW/MgW/yr0hK7jbPRZ3drNs=;
 b=k5FFY1O2BhFFzXt2EC9RF2q3ZtnO7AeBTo3oXIbHtqe+oq59A7qqdue+WMZ6HOb+0TH2XkXxeTVJWz2NVWsGi2DwWCgs4ogIEGRZU47oYU5khqso7Yh2b7zOBnGinkBoZXQ2F3UMx4VGawfTUbOduoUG5yGl6iizVrN+MBnLa0A=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB3999.eurprd04.prod.outlook.com (2603:10a6:803:48::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 15:37:51 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%7]) with mapi id 15.20.5273.022; Thu, 23 Jun 2022
 15:37:51 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Jon Mason <jdmason@kudzu.us>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH 1/2] Documentation: PCI: Use code-block block for
 scratchpad registers diagram
Thread-Topic: [EXT] [PATCH 1/2] Documentation: PCI: Use code-block block for
 scratchpad registers diagram
Thread-Index: AQHYhh3/IbPhDx+ImEm55rvyaZAGTK1dIgZg
Date:   Thu, 23 Jun 2022 15:37:51 +0000
Message-ID: <PAXPR04MB9186A076FE12F992DAF7E1FD88B59@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220621200235.211b2e32@canb.auug.org.au>
 <20220622095345.27121-1-bagasdotme@gmail.com>
 <20220622095345.27121-2-bagasdotme@gmail.com>
In-Reply-To: <20220622095345.27121-2-bagasdotme@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ffa3c4f-f31e-495f-7fc5-08da552e552a
x-ms-traffictypediagnostic: VI1PR04MB3999:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FqLn6gTmJKXMs3IRnlnrFKKvT4hbdPQp3aTV4mcOuy+Q5Fr/UX7vRvGVjJx8umDjWGo3SCTmxUPLKbYJWdde8ugjcFbQvRSE8Z4ZDXVhGCNM4TAxMhdgP1ENfHsBLVOHcOnWjZY92ZkrN3vMNZkTF1CNTHPIMJHOEFYusgDgjcYp+5096T2E2puwpL6OKs1U6uWrgZasnjTeNPtSN59DTkNNTCtiU3JvJSeEreyriN0rabfI+0SSICRzEpyvsVDNDnmhdqYfd13xwZBDGL7L7YvHSTMH3xCPiXxI82jAepu0uYBrLXG0wYfsdkwVUQLSwPiDawD3+cnYli0xb9Hx6yIJlLQJMjnRClOme8SAMIgqEh1ikSTlLhitpP5SJ2Fc4bp30iaoJyXG2dHNIC6wErtyi9DYfNpsWIZ3L20DkAWTnMSRIR0r5ONndAcJBmdl90cBLPRZNCnkVCMSj4OrwY5HVt/qOOPQ/WWzmm1BobjiL68PDXDfY4Q3DfHz7ZcTHQW6c228smiA12e9yrmyR+vOHlx0wTBea3d8p4qqfCiFZ8sujs44bpATYVnpMqCT2fwniIJlQvo2VqkfbmdPPmiGoH/OyDloM4Uj/4N0QBQplvdFqbV3vUnVpuaFFmlnp+Sa5JOE+b7Ry3H0VgZAgs7omTweE8MCpE6MSkX5COIXd5WUb9oq/rh8q+eS+7TdO2R81aM2bpr6e9jMcunibXVIKHo5D5QiMk+l2+rST8xvvfmj9HbnCctGu7cCLDp9jWZQpvoqdO22n45jW4RRWMQKpDU1Unz++0aDApOWLrHn8zdvr1UU7cGVh2GNPLwP/laOLTyQuF79gdqQDXnjuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(55016003)(52536014)(7416002)(33656002)(5660300002)(2906002)(44832011)(64756008)(8676002)(4326008)(66446008)(66476007)(66556008)(66946007)(76116006)(8936002)(316002)(54906003)(110136005)(966005)(41300700001)(45080400002)(478600001)(71200400001)(55236004)(26005)(9686003)(186003)(6506007)(66574015)(7696005)(38070700005)(86362001)(38100700002)(122000001)(83380400001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?z9uIVTJGz4DZPzrTNTf3qOkL497kCjkC+Igh0b8kt4Uac/2V/4nj5Uu8WL?=
 =?iso-8859-2?Q?m8TI4n/2egsBpD7rZnFoeNiLT3uW+QNRKgP2Y2NXdpQx3DHV39615rDQO4?=
 =?iso-8859-2?Q?bpuBjyxBVGaVNUOJoP8/ya22RGN0rN4+65FXLqsPK6jiT0K9tz7i0J7VJv?=
 =?iso-8859-2?Q?t5ba0zKUJz81AzjzOEDIi4MPCgDPfxfymmPsbGYeQgi9vZGCoOn6655bpu?=
 =?iso-8859-2?Q?1nCd+K6nQrOo5HMAeOnix9Dr56dzmtak/umLHpqJ+lPxlE/46Oj5lEoSab?=
 =?iso-8859-2?Q?OGORid8nbvA5Lv7LqjIrSALqfp4K6/9e9SiGFmLFk4cJ29deCB5m9ag4yT?=
 =?iso-8859-2?Q?pav+lx0Py7R3/fCU1Q3GdckKcfK3SPh/nyJ1mT6z9YH2cTnN7iDZpUhj8G?=
 =?iso-8859-2?Q?Sjwh7IMcEavQvyRYtAIpw8hkJ4kahMsT9tIjVHX95h/J0ihFq9VUioILKg?=
 =?iso-8859-2?Q?mz2NLlXRlh2TttyEQOFnaEJwpXduDxk8Ca3HrHFB/I1R3oy7Q6+8xrVo8j?=
 =?iso-8859-2?Q?5g5e4V8TPthT97jZp51u+t2DrmiKcYcI5uO57G2ktK7VxW9qms9dUEOxlG?=
 =?iso-8859-2?Q?YoQhjnWjwme/hsWr4tScyIAFv2e0tfxem6ROAk7RkZd5BAB81mS7u5uiww?=
 =?iso-8859-2?Q?Rh/A+iYcPUdsaUXfsJ8xYieNd8LXzqAlxeT8qbtyPbDkLu7lcTtUmvh2Wm?=
 =?iso-8859-2?Q?HZwwN8Z9dMEgpwdtP6mJgSTa46yVAB84GYFWZyHTRugv2CK3OOv6Kh/YyN?=
 =?iso-8859-2?Q?fbQtnjqSLVvCYfH40pvi/MVjFBq0SFLS0G7o1Xm4dl2tBGo53QWH7Ewjsc?=
 =?iso-8859-2?Q?kBr3bBTOHw81DeTjfEzD3Zwph74neCyjzjyPYuXh6NOPRiNrLaXyscBiDj?=
 =?iso-8859-2?Q?QuyV1N9huQ0v4aS8gup7Klrw2zmARf16Mn/HpenkK0UEK6QjwOVhSTZRpJ?=
 =?iso-8859-2?Q?YtL2Lx2IyR2GwIc3qib0KQPcSkMXsYcBr5k2FBVl6zartIumQgnNoA1D9R?=
 =?iso-8859-2?Q?u/tH6JPli9iM7QTG+0JAbVunmNbJperXjewMG8B4iVKWXSZF3RMcuB+dOg?=
 =?iso-8859-2?Q?atx933G++B2cw0nm2U3gGkavKGZEUmiKIDaF3krkzDka33aHRTpRffoWzF?=
 =?iso-8859-2?Q?ObmD2SrNT9z+KTFbfb5KlMDBZ8qOrAglk/jQs701VOeo95EjvPI9PHl4TS?=
 =?iso-8859-2?Q?AX0D/e5DyXIdJlrAuUnQqbBFD95tJJGj/fK9mB18sD9bcRpL2S0OimDqNl?=
 =?iso-8859-2?Q?uLUovByCcpCBg2J2XCH/eLdH8swq4x4k6Xywqf4wFobmpXZwAPbt8NEkiT?=
 =?iso-8859-2?Q?uqvRqs1KL+iQ0WMHlMjaJrjt7tYkr91LHipWhYDd1sBM9d/OFDYKzA0+S1?=
 =?iso-8859-2?Q?B3iq1XsBjv7NiJM4nwFFnspPkakUSr1Jb19Gv4ETklAA04wcAAx0ucjcFa?=
 =?iso-8859-2?Q?FH8ex7UbskLgRXDUn+02D43V4zJ0bi1mO2L9K+opF5EZ2J9O2gkwcYC+Es?=
 =?iso-8859-2?Q?OZ5nYcqr5I/xwX9ijrQ1PR+ztdMxiAvFaT2tI2pmLpPe49Raanw7dLBMcO?=
 =?iso-8859-2?Q?irZU0ddZ/5VnDpu6RUbJyw0v6QtMn0SZBTmy/9Q8XKMoNq1w+H1ocxg7su?=
 =?iso-8859-2?Q?r1XC/XgPn7hH8=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffa3c4f-f31e-495f-7fc5-08da552e552a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 15:37:51.1739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5JPJgM+aww2TYNMNHidKmKfx1zYUHa8g7q59VCWvVyFcadLEEeI3Gh+6cP0vXnOGmd01B2l60vXzSl/7dcW7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3999
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bagas Sanjaya <bagasdotme@gmail.com>
> Sent: Wednesday, June 22, 2022 4:54 AM
> To: linux-doc@vger.kernel.org
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>; Stephen Rothwell
> <sfr@canb.auug.org.au>; Kishon Vijay Abraham I <kishon@ti.com>; Lorenzo
> Pieralisi <lpieralisi@kernel.org>; Krzysztof Wilczy=F1ski <kw@linux.com>;=
 Bjorn
> Helgaas <bhelgaas@google.com>; Jonathan Corbet <corbet@lwn.net>; Frank
> Li <frank.li@nxp.com>; Jon Mason <jdmason@kudzu.us>; linux-
> pci@vger.kernel.org; linux-next@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [EXT] [PATCH 1/2] Documentation: PCI: Use code-block block for
> scratchpad registers diagram
>=20
> Caution: EXT Email
>=20
> The diagram in "Scratchpad Registers" isn't formatted inside code block,
> hence triggers indentation warning:
>=20
> Documentation/PCI/endpoint/pci-vntb-function.rst:82: WARNING:
> Unexpected indentation.
>=20
> Fix the warning by using code-block directive to format the diagram
> inside code block, as in other diagrams in Documentation/. While at it,
> unindent the preceeding text.
>=20
> Link:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Flinux-
> next%2F20220621200235.211b2e32%40canb.auug.org.au%2F&amp;data=3D05
> %7C01%7CFrank.Li%40nxp.com%7C36a0e13e10194fda105b08da543520dc%7
> C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637914884407847247
> %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL
> CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DZPulixx
> LoPG65rjdBPo3heIb%2BFhKK7wnWD4js9i5dPI%3D&amp;reserved=3D0
> Fixes: 0c4b285d9636cc ("Documentation: PCI: Add specification for the PCI
> vNTB function device")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczy=F1ski" <kw@linux.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-next@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/PCI/endpoint/pci-vntb-function.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

[Frank Li] Acked.=20

>=20
> diff --git a/Documentation/PCI/endpoint/pci-vntb-function.rst
> b/Documentation/PCI/endpoint/pci-vntb-function.rst
> index cad8013e88390e..0c51f53ab972a0 100644
> --- a/Documentation/PCI/endpoint/pci-vntb-function.rst
> +++ b/Documentation/PCI/endpoint/pci-vntb-function.rst
> @@ -58,7 +58,10 @@ It is same as PCI NTB Function driver
>  Scratchpad Registers:
>  ---------------------
>=20
> -  It is appended after Config region.
> +It is appended after Config region.
> +
> +.. code-block:: text
> +
>=20
>    +--------------------------------------------------+ Base
>    |                                                  |
> --
> An old man doll... just what I always wanted! - Clara

