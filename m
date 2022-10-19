Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB99604D65
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 18:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJSQ2s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 12:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJSQ2r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 12:28:47 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169A91C882C;
        Wed, 19 Oct 2022 09:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IO9zipE4GqXEVcx9XW177YvRRwF8f1gxJp6GPdrlfcXQy7vE+GE+XBr5gaWcuSmutN/qtnJaNsz6anM+kwiVNPMB9TIpYYo4+j0gSdCM/UkGJz/bO4q4NylyTbuw3lMNStOcDpQiZ+5b6s3QhPCQeKGiUHjts6m0Be8pPYgHmihenXWsqSPdlvEUiO1Sn92SYQ1GdOiTjcXdXwiSQLPQJCt8884+E4wdfZD+niJhSRHoy/ZjNSpWP/lY9xhV71KKJRUm9pNZAj4ib6OL9Rom6Otgj66ySYqhzZVw17g/DU/lYVMEavdRuWsF7ZWFdEDC34tAw6S1gfNePQOgfz/TLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOpQlPe5EbIz+naIrdmFCcHQZCwgwHBDMJku3UY5ySQ=;
 b=DAGJ2XKVBotIszZJyVju/yM3rliabdV/VRupIOvnlKMtT4dSQrsCjMnsVyUZpWRdNhGmsdUrWomrfTdrIWi5bhLVV+8EphK/0U0Za07GpUbiclZHW/CfBq8PRUuhhTDhD0N+gTSe0MvTDCNlT+RspKuUAnoYZwneM+tAOpLQB1yHKXW86UGgJqsDQ5p/gXWlLSFwS14cZS9r/2d52xp+j1n7Y0JCrCwhqAn7nEJdO43XqVQJWwKBWpDgXWWdHWN9tm2hgAyfZmTXNuT1KNKETODsf99jsm0HqZ594+8m8aa3nYLHraRkgaFlAJWHnGmIO1y3IXrxU4RFQZh/jK1VXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOpQlPe5EbIz+naIrdmFCcHQZCwgwHBDMJku3UY5ySQ=;
 b=rM/ePz0LGfQVosnCauZTRcD8kjSDnG6c0aDGq5gf43nEbTTDYX/WzdH5X45njDEKq8Nr2JlHSNSTkvv2N13+LQP3Z4L66FnR5at8xe5Is66oW1OEdXwSZdpP92PuD4pLEA7r/ycPEgvKIwjzvhQtoS9MywiQm/cKqM4CyVtYd3A=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DBAPR04MB7254.eurprd04.prod.outlook.com (2603:10a6:10:1a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 16:28:44 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5%10]) with mapi id 15.20.5723.034; Wed, 19 Oct
 2022 16:28:43 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
        "open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v13 1/6] PCI: endpoint: pci-epf-vntb: Clean up
 kernel_doc warning
Thread-Topic: [EXT] Re: [PATCH v13 1/6] PCI: endpoint: pci-epf-vntb: Clean up
 kernel_doc warning
Thread-Index: AQHY2oD4qq+oUIXVdEWBXF1BfLJvx64V+esAgAAAatA=
Date:   Wed, 19 Oct 2022 16:28:43 +0000
Message-ID: <HE1PR0401MB23315F0383B451ACF4D238ED882B9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221007191326.193079-3-Frank.Li@nxp.com>
 <20221019162556.GA20373@bhelgaas>
In-Reply-To: <20221019162556.GA20373@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|DBAPR04MB7254:EE_
x-ms-office365-filtering-correlation-id: a680740f-999f-475a-9079-08dab1eefd66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GZKsbOYCvKvXcUBMVI2zrLf2UZVjWg3HaOIU0yRsdUxyaFfgxtfQfmAYKeSihHwisl39XXEJODyvGayeUP06KympdDovrNEdMjOxd35CSbFc7xFWmL4pGiBwVFgPt2NLCNdObiFG70o4Y7AZT+elotVdF1sxAXadbZrGuPsxmHIioEv3XnDd1p7xIG/hM3QOpwMDyuRDQLQZQVQEhp6a7UmPfnCBVQCm++fVgX2z0kLUD9JlntYFo3r5xWjHMxBK05fffJV4SQ+mZ1ZeP3Z3Cwt3zPyeqNCei2A8Oq+ErPYFejtzEckQv60exWY8pme9D04IMgM8nxgac4+WRQmGzLy3jO7wtI1NB+foFK2AxV84waSHdeOXT5ZIvJ+sDbYN+9YtoaI+ZosA4JWCPkZ4u3NZ1Op/VmBxPn0KG/PaxXjQ3JU09mrhUNwYvTXfg9Rd4zaL2XCasMsScda7cS4pphN5jNgohLn/5sIBPi46DXFlFao8UlC5dRsO2bwxCsOdTe8tXfI9GF+97VKScR+tuphB9sUMrt/TxkkdJ8Y6Wiy2KJEZAYB11SlrRskHw71rjXpZc0U/o5nBxCHPQmBSMLvZUi2fUWc8PBvyX1mDJyR6JackJ0akstQpRkxLzDO+oaZZyxMlj8VeVwDBdQKiQxz48W7ZjxNk8ZilFGerm7YXH+GWx8Teq2p5uN9dpX4s0fdZZY1DNdKgBRelkg/qifYi1IuTW7Hf5L0rfXynSt0XU6hrdZmZU0enfdux45O97HZ+5VXNJMw+ZgF3xAIUXcQgNMUcu+GmDBR+M3qMFmE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(5660300002)(52536014)(6916009)(54906003)(41300700001)(2906002)(7416002)(44832011)(8936002)(66556008)(66946007)(33656002)(76116006)(66476007)(66446008)(316002)(64756008)(26005)(4326008)(8676002)(71200400001)(45080400002)(55016003)(38100700002)(38070700005)(83380400001)(66574015)(122000001)(55236004)(7696005)(86362001)(966005)(6506007)(53546011)(478600001)(186003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?a0wrU0GO7Zat+0YhJM6GSWH5R/7h8aGcpfL9DFIQ+6uCKfmJG8SoqcDBOQ?=
 =?iso-8859-2?Q?u4GvCXZ+HH5zNMa6FacwtZohYJw7Jr4s913YLiIELjfDkO2zap04RI0OGZ?=
 =?iso-8859-2?Q?TjqvgZ9K5MtwuCwrbzLIYHqc3p8h/8hAlMr9/UFsgk2iePV+4YbRAW7qgS?=
 =?iso-8859-2?Q?fE0ijh73IuZLqhjtNTRAKyFUVEIZUtp4MB+2AM3dL0RTT/c8quZ51Z847m?=
 =?iso-8859-2?Q?ks4jTpcMpN1aDcXJf08IxJ9f4wGCug+u+nAOjGTGE5E3iVYDR1RfegINsI?=
 =?iso-8859-2?Q?1VPeODRW2G3z4AR9u/Xqfi4HGwhrHFFTDxp8pVGRdHUrGaGhfBL/s+12g6?=
 =?iso-8859-2?Q?50kJ8YfSW719fxz6YtW1KHEpUZh1qYPdfcJW0l+CqeC3Lz0JER/XD4dbrS?=
 =?iso-8859-2?Q?gMH8BnDCQH7C9XKbVEkVMtmTJIgiChJDyPJ52++e+eWPGnJ0yKzDRTCIJM?=
 =?iso-8859-2?Q?dnHA/dO0AfVu5p34543RUIkcuHTpJ1LEiyCF37sNt9XFT21dg5Eut/yHft?=
 =?iso-8859-2?Q?HXzV3cb2kaGfnXdkNpowkC6D/4oNEK39PsIqcaOkzEoT3D+UuYLbmZ6D/U?=
 =?iso-8859-2?Q?p9GEFPu/YRpr7TGSwHD8vplA1SliHM8vgyBZ8awnL8zyrFBISnmhdEaNme?=
 =?iso-8859-2?Q?xw9suOCO2WtU9Pf5glKgz8zQf6HTz42hOkf97NEAQi3bZroNk57K94pcZD?=
 =?iso-8859-2?Q?Xn1ZchsoCauobKyUlp2ASNS6iSLKZ1kNoQr611hnCBTPvuoaNvGX5nwk3V?=
 =?iso-8859-2?Q?QZyDbQb7O56aioSYJVxxCfsSuh0/2EE0ZcATx+vH5zvYBUMZRKVSYV2jmj?=
 =?iso-8859-2?Q?+Xer6KF7kCemHBhF55OeE0OlkapywZa4xF7gih7ipoj0FaWTcPscXHgSZw?=
 =?iso-8859-2?Q?AGwd4QUIN3Vu9IJ6bIijTPqEl54qJBKxTe1NLv9BX4snad87WXwmy7VF3l?=
 =?iso-8859-2?Q?kj54jVf8hUNQGIIpcLN2rhxMd3aaGrJJls+ENjyyzHsdkEjnbogOhGKm3g?=
 =?iso-8859-2?Q?XHeq9WXV2lC8cpGKxIhajdV+ezTXDIe87Oe7vgiQZgZmHDS7aDGmAh3j2J?=
 =?iso-8859-2?Q?cFLhy6FEf5E0mskkGlj7sWIpUT02ZJCSbWwJqYMDaItF+44AP2rHtggmuc?=
 =?iso-8859-2?Q?VwYWeVkjWsZoMpXKD7+CU0J8nVq5E8uF9pb2HvpvYQIzLy2z0Oblj6XWYw?=
 =?iso-8859-2?Q?A1RrYbUYw1Hc/wC7wnrYkP5/DAnRmeuynN2JUvHE+OcDBQdGRQ/36gHuhy?=
 =?iso-8859-2?Q?96p8G/yuTFN7vTIrkB4nczbkUNOTLv0Q2X0v/HE5KI5nSSUyPskTOHg4U7?=
 =?iso-8859-2?Q?feieWAoFV7GBwlZievSAdbDn/RsUQdTu0ZNJq76KSwqIv9KbD/CQsvl2TL?=
 =?iso-8859-2?Q?fy3VbJuBbNFxd52nNIvg4g3T8somVSK7y+987z9tdtVOd8iv6SZJiIHuWA?=
 =?iso-8859-2?Q?uWme0lFyw1fk0wmFZIqe17/1sUSxpQhTVLvhoPZ5kTZNrAfa9OSx2KMeym?=
 =?iso-8859-2?Q?G8GVut7HkiGYmgPRhBQ1orQr1aOXG9oZlrbAUnK5ZVloTiMlRbDUFvkEtA?=
 =?iso-8859-2?Q?IapmjyzFDdsJN1xni7Y9oGYGeuTiwDvBvmVDL83EU8us+v/b0oZEhdjoiI?=
 =?iso-8859-2?Q?vfIaDVlEnh/hw=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a680740f-999f-475a-9079-08dab1eefd66
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 16:28:43.7724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLblZIVyORqp5/bF6XOIWfNmeuqZVsAdMGdowziOZk7STGrdOE/4ikRk3xF514RhW+SPmKFyS/+CWWJCsMrFAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7254
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, October 19, 2022 11:26 AM
> To: Frank Li <frank.li@nxp.com>
> Cc: imx@lists.linux.dev; Jon Mason <jdmason@kudzu.us>; Dave Jiang
> <dave.jiang@intel.com>; Allen Hubbe <allenbh@gmail.com>; Kishon Vijay
> Abraham I <kishon@ti.com>; Lorenzo Pieralisi <lpieralisi@kernel.org>;
> Krzysztof Wilczy=F1ski <kw@linux.com>; Manivannan Sadhasivam
> <mani@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; open list:NTB
> DRIVER CORE <ntb@lists.linux.dev>; open list:PCI ENDPOINT SUBSYSTEM
> <linux-pci@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: [EXT] Re: [PATCH v13 1/6] PCI: endpoint: pci-epf-vntb: Clean up
> kernel_doc warning
>=20
> Caution: EXT Email
>=20
> On Fri, Oct 07, 2022 at 03:13:21PM -0400, Frank Li wrote:
> > From: Frank Li <frank.li@nxp.com>
> >
> > Cleanup warning found by scripts/kernel-doc
> > Consolidate term
> >     host, host1 to HOST
> >     vhost, vHost, Vhost, VHOST2 to VHOST
>=20
> When you post a series of several patches, it's nice if you include a
> [0/n] cover letter to tie them all together.  Regrettably, this is not
> very well covered in the documentation, but here's a pointer:

[Frank Li] Strange, cover letter missed in PCI mail list.  Let me repost it=
.

>=20
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
er
> nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2F
> tree%2FDocumentation%2Fprocess%2F5.Posting.rst%3Fid%3Dv6.0%23n334&
> amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7C02ecb68ec2024b8ad43208d
> ab1ee9c8d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6380179
> 35642690987%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;
> sdata=3D%2BgCDqyYli65%2FVW7eUAC8ZrSAprNVa2QhqcCChsZCF0w%3D&amp
> ;reserved=3D0
>=20
> And if you look at the archives, you'll see lots of examples:
>=20
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Flinux-
> pci%2F&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7C02ecb68ec2024b8a
> d43208dab1ee9c8d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C
> 638017935642690987%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7
> C&amp;sdata=3DFG4SbxNVF66T8ka82DJdB2JmyOeQbyAIstINr%2Bp8UQg%3D&
> amp;reserved=3D0
