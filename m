Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908A3557F27
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 17:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiFWP6l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 11:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiFWP6i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 11:58:38 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4A2DEB3;
        Thu, 23 Jun 2022 08:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMdMcIrKJ9HY+nkwErCM1vjwKOG4N9uFxgwIIveJ0jAm51mmCbXfHlje8fTCEyjSwop8pCiQRO2ND9WznDDO8utfz0zIrITKNjz5JQ/qMc6v2xbSy3kgLLfiLOQndgnqDHR7ad0sQD6C2karaZ551Ltkea9+GfZOXR44qQIJVQPBJatb9m5LI3Bj582aJDdKHIVTEJ1w2qB3S6mVMo1oiiM/vGVmcOvN6jAK2/kakBOOk+QfpVr4OJ7MB7QRZvZ5DWPZHxziBIh8a4yffJ7EW6XF5m/Pdza95bdPgSDfqoEmXkYZC2W8kJiht3j9H9amlkZbbR8EqZhMZwNVfcTmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6gNfrZl6th6rwsShrKQeR920cume+XlwzHhQZB/FDk=;
 b=X4rPSsi/5Rpo6dyDk88n4k/My/YHS/PNJoNEW0zuNJhYbRgqy62w6QiWYRpBuNgtj8hFdAvnGpUg0iXoS2zzXoRcX8BXChhsxO085S6FFOjvmGtI6rClo9t3cVtVxT4JqkyPTiMoSYqcBY+0ecNfRD3C8fRNloOtqkpW8fT6k7BG3LWzh4yNiQW9/mi5JXy5MVSLJ+2Iqt+7S9oRunQDGZHbALJuxi3TEbEQRo+aNjCCUIHIkx0WxlKH4LM1oj7xzRmmOqfcT/57+vRYtyUDwBDNW3VAyYbSNeE0jQsXQLnRx5r3ak9Tt/Oh3B5mGub8FE+93xlQs1n/vwwP1pK7cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6gNfrZl6th6rwsShrKQeR920cume+XlwzHhQZB/FDk=;
 b=kO94VXnvEWwJSnHChC2aRSqIcYrO1LejpKcPyJtIwvCto2Pe/FG42j3HsxAgaD/larRQf81uklpyBEF92tzFxBro7NR/R0AotzZt7VEy44mKMltRvC4rG8jnfVg8MnSh066d+1XN5UZM/canjBcVdpj/wm/o28rpoJ4wFlZgXjY=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB5645.eurprd04.prod.outlook.com (2603:10a6:803:df::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Thu, 23 Jun
 2022 15:58:33 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%7]) with mapi id 15.20.5273.022; Thu, 23 Jun 2022
 15:58:33 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Ren Zhijie <renzhijie2@huawei.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH -next] NTB: EPF: Fix Kconfig dependency
Thread-Topic: [EXT] Re: [PATCH -next] NTB: EPF: Fix Kconfig dependency
Thread-Index: AQHYht4N8aJP5oM9M0SulvdK/o1soq1dIDMQgAAFXQCAAAChcA==
Date:   Thu, 23 Jun 2022 15:58:33 +0000
Message-ID: <PAXPR04MB91865EE1D156F47DB8D9EE4B88B59@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <PAXPR04MB91861EE0E20E9EC71F4C494288B59@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <20220623155524.GA1452766@bhelgaas>
In-Reply-To: <20220623155524.GA1452766@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ffb7822-f8c5-43f3-ae05-08da553139a7
x-ms-traffictypediagnostic: VI1PR04MB5645:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LItvbKpl45Qfneb9qKMbzEXCOAoQ8HhK31Tz75Wy0pgPXzefhFQMbJ428UX2UQmVrOAfIvVDZNSgKpT4AgVGghvNn3ZgmOXnuo5BZK9KYxyca9Y0etW0TMkUw5jtw6KAYen3ZguZ5wM47BbniBgB+hEQt4Z8BOGmIZtkWTkwOAL1SsBjRK9P98hDon11loLVyHGXzXF2XMu+Pp1EajKtBieFV8VDxGYme8vyodmLsz6RqBFQM2FyqxScSwWvpGgtcIjFNbbo+IH1aGJGVBb0H/UjUCN9aOC2VbXyOXZJH6t5WXogXbOthPcmr9zW/1Dbnjs7iWeDW8DKEfWWYoH3+hNMTRrumQPegCuLYxs7MHxOPklxlc5CamuQw+C+Y8OOGdlHlQbiX8yqO69gNfcH8ia2PPgC6ZE0Hut8fTlAWt7ZsZskCkXAEBHPBA/ncucYCMBm7OwhYkMciVTC+IKFWt7jeIlR4cAccCuTtsooKYQ58uR9FDe7fnIf738sRzWRoedvpwgY2ZnP+rVkSTGwrIcwsyl2wBs1HIrlwbw2TRtCN0rvDJRTShGSJGn5sI8KmgUeiNH2p0QEAt24xiLoqxqe9kdih4IFdbCn2qSHwPEx/+QlPFgLW858fu8WV6I+kgA7bAZKjJRye+ExQoQKXDM4XcRyEZvMeXBP52vonrGfwAIviYSPHfgc9cbFt+SS2pg5muLgVX9GngszbHzei9Ib2y7LTzjsDbYY7AJZV8+KuqYLkMM8+pyORbzY3tMgSqJs5A8BdVw3fjG08+B3RS0XNcLWTnWh2iUbPkwOxrg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(6506007)(55236004)(38100700002)(55016003)(83380400001)(7696005)(71200400001)(54906003)(316002)(478600001)(26005)(76116006)(53546011)(8676002)(6916009)(8936002)(66946007)(66556008)(4326008)(186003)(66446008)(52536014)(2906002)(9686003)(41300700001)(44832011)(38070700005)(66476007)(33656002)(64756008)(5660300002)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e0Y8TEoNRQdHGC04giifF8/HpLTcHxsOWzfYm9Y/8NBJEJPf2/aQ6XcS6DpR?=
 =?us-ascii?Q?pBmJUByJXkS4dh65A9Z6/yUdMkb0KUNCz2yufRMUatIiZbKmhAfyCPixJhgw?=
 =?us-ascii?Q?vTa4HyVEn7zzAa8VLBM+73g48uU70aFUClKLbxKHQo2t7P4FfRvm7oZqGATW?=
 =?us-ascii?Q?DVBZj8ymFq1TcR2JYZUU0RVmAO/DYiSl182VTJIXQafEHtGGDNZhelReby/5?=
 =?us-ascii?Q?4cr5DnWXS6QVplUla1a1BisDQuFCX3EGNdSnKftQHPLtd0pGw9tKNqwAtreF?=
 =?us-ascii?Q?/A6z91Ck/5pJk4qpCDjOGA82i+Sozxs0jFjs7fNlSqSaJsAvVIxQR330KqBU?=
 =?us-ascii?Q?rUBqb8+ceHRDPodPE7uXedR+50MDq4bXjZRWpEhm4bjaeF6KOMFnlmjPq1oJ?=
 =?us-ascii?Q?jBZChAhSmQVG2l0TocM4xfV4Qdq4KnUO9Zlc1fNcMBoSzpVE/DKqqrAuV0ry?=
 =?us-ascii?Q?Kmlr4bwjst6W7QDnsRSHnFz0HWdDCpHBqoeRJvprUU5ffnnnQeM1xpooVQ+n?=
 =?us-ascii?Q?sMC0BC3M0DiniLMt6WIUbX5X1eihDYL00qLF2Z70KMDspAbElv0GjBnr1zfR?=
 =?us-ascii?Q?4zaqke0Q+r8dWj/acxqE/wNn08Ay1+CKVWp9ZLIRu6dbiLb2E2zCxqtWNe14?=
 =?us-ascii?Q?iSi4s49HIyMgGP3D1tluRtmkkw5/huoNArS7MygnUIbTI22kr1Z/pZTeyGY0?=
 =?us-ascii?Q?uFUqdBSyvGhKX9MpFgNm3xXnjkmPBvvweee5EPdmJ0r0QuHBezXNQjrNEpR3?=
 =?us-ascii?Q?1v1pFnRZwIcQ0amud4BxkH4LsZ9h0AI6goaVlSMbPlFgv+KAbVMoLwefbL9E?=
 =?us-ascii?Q?Hts370klP0UEpjnlo1G09qPqWMd1vFfpHfPY0T0G+PrmhlHkU2hiyWSrlI5A?=
 =?us-ascii?Q?XSH3kA0p1tnFC3bB9RgxsjDXkW4YnluQ5v6S+fCXFGBIISI39EwxhrBzjs5m?=
 =?us-ascii?Q?M5RuGr8EcA/RVg7xLsN+8yUoCrcdJ6eCXLj1/uGYzygPMHvb5wi3FrIlHGCt?=
 =?us-ascii?Q?E1YFRzXL7zHdY34MwMkhMVRyCx1zg5/hVj500mKSKf2vxvKXMCwse+9zYUb+?=
 =?us-ascii?Q?jVpGGl+lubVe/ee8ldjW28Wq3rkS4zaIKkn+5oBjlz8zCMnw3PKMU294+DYD?=
 =?us-ascii?Q?t25CHp0xZHfO79BJA0kvp+oMkGGVVYCMnNYQSPGRPsW+I/gN5azZ9JhYvROH?=
 =?us-ascii?Q?VgcD9UMPvMUkEwwwncSgO3vBimZpJmYW8IssFH2Ni6IVCdHRhHsQHWXt5b8Z?=
 =?us-ascii?Q?X/rEPIO8pHazcdUWhrsl5p/K27A37IaWeTzUsCsYyjUA2XY95hPq0uihhLwI?=
 =?us-ascii?Q?Trwn90/a0Mxnc8WAmvfkA5vwvjIzV2Uk5VtDCExfzaFOjW15NgcaiqgiCF9S?=
 =?us-ascii?Q?l4nNSj2lT8RGpro92nKQ0GXA7IoOkWh+95aK38zpAlTQgM4GScFa/rHi0+wj?=
 =?us-ascii?Q?8UAs0K7df7x4Uzq0AuVSl3p+gN+yFAkHBXPycDKAqrfv8F0mGyjrttmygL0/?=
 =?us-ascii?Q?4W7RkaBoG1lDRfJX8ZqxIU+GObUWhmZgwVGvl9jzoiSzM/Ltl4EJQBEWsT+z?=
 =?us-ascii?Q?NFHS6rRnxtPHywwHazY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffb7822-f8c5-43f3-ae05-08da553139a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 15:58:33.5239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w4VB/Wr2QeUzCNrvGOD6d8mTDVev+vAAdhWeUtbYj9lq6bmJNLUENEibZRsIXiH+vUoAiMZB+p4K7PqC+Y2yog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5645
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
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, June 23, 2022 10:55 AM
> To: Frank Li <frank.li@nxp.com>
> Cc: Ren Zhijie <renzhijie2@huawei.com>; kishon@ti.com;
> lpieralisi@kernel.org; kw@linux.com; bhelgaas@google.com;
> jdmason@kudzu.us; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH -next] NTB: EPF: Fix Kconfig dependency
>=20
> Caution: EXT Email
>=20
> On Thu, Jun 23, 2022 at 03:36:38PM +0000, Frank Li wrote:
> > > -----Original Message-----
> > > From: Ren Zhijie <renzhijie2@huawei.com>
> > > Sent: Thursday, June 23, 2022 3:46 AM
> > > To: kishon@ti.com; lpieralisi@kernel.org; kw@linux.com;
> > > bhelgaas@google.com; jdmason@kudzu.us; Frank Li <frank.li@nxp.com>
> > > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Ren Zhij=
ie
> > > <renzhijie2@huawei.com>
> > > Subject: [PATCH -next] NTB: EPF: Fix Kconfig dependency
>=20
> @Ren, please use a typical subject line for the file, e.g.,
>=20
>   PCI: endpoint: ...
>=20
> > > If CONFIG_NTB is not set and CONFIG_PCI_EPF_VNTB is y.
> > >
> > > make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu-, will be failed,
> like
> > > this:
> > >
> > > drivers/pci/endpoint/functions/pci-epf-vntb.o: In function
> > > `epf_ntb_cmd_handler':
> > > pci-epf-vntb.c:(.text+0x95e): undefined reference to `ntb_db_event'
> > > pci-epf-vntb.c:(.text+0xa1f): undefined reference to `ntb_link_event'
> > > pci-epf-vntb.c:(.text+0xa42): undefined reference to `ntb_link_event'
> > > drivers/pci/endpoint/functions/pci-epf-vntb.o: In function
> `pci_vntb_probe':
> > > pci-epf-vntb.c:(.text+0x1250): undefined reference to
> `ntb_register_device'
> > >
> > > The functions ntb_*() are defined in drivers/ntb/core.c, which need
> > > CONFIG_NTB setting y to be build-in.
> > > To fix this build error, add depends on NTB.
> > >
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Fixes: ff32fac00d97("NTB: EPF: support NTB transfer between PCI RC an=
d
> EP
> > > connection")
> > > Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> > > ---
> > [Frank Li] Acked
>=20
> @Frank: if you use the conventional style, e.g.,
> "Acked-by: Frank Li <frank.li@nxp.com>", tooling like b4 will
> automatically pick it up.  Just saying "Acked" is likely to get missed
> or ignored.

Thanks.=20
Acked-by: Frank Li <frank.li@nxp.com>

> >
> > >  drivers/pci/endpoint/functions/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pci/endpoint/functions/Kconfig
> > > b/drivers/pci/endpoint/functions/Kconfig
> > > index 362555b024e8..9beee4f0f4ee 100644
> > > --- a/drivers/pci/endpoint/functions/Kconfig
> > > +++ b/drivers/pci/endpoint/functions/Kconfig
> > > @@ -29,6 +29,7 @@ config PCI_EPF_NTB
> > >  config PCI_EPF_VNTB
> > >          tristate "PCI Endpoint NTB driver"
> > >          depends on PCI_ENDPOINT
> > > +        depends on NTB
> > >          select CONFIGFS_FS
> > >          help
> > >            Select this configuration option to enable the Non-Transpa=
rent
> > > --
> > > 2.17.1
> >
