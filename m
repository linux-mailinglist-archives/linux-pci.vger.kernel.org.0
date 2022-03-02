Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098414CA94E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 16:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbiCBPnC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 10:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237568AbiCBPm4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 10:42:56 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13757CB64E;
        Wed,  2 Mar 2022 07:42:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/iKRPsHFHt0e82iZBNxCbQSv0b3ET192ze0lovcoR2Zumpdptjs29FzfEuJe/wX18ZPj3e5gkv1rtJrwZKqyjh3/btT9buVo8ibJKsqQ4asRoHFvxfehVkOw5gkVUuTwdJ4zBX2ApAHWBRJ0JhTCC1/IizSVyafo5e+Z7UsuBmjN59QQz8MknEFGErY0UL4XVzZjQWhEg2L78Zp8AhIYq7OC6skTjZfU5qBjFGX7AquwUu/p/cc9BsCP6a7vZZR/3tP4yqwaAomAULAXckiwCM2icd1/JL3bfQrKnMxiO+XMwpbiMfQ+B4g9w0UZDB4pOagJ+U2bzkQCSeFMzytig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN26MHlb9czNQ1bIAn/rZexPvvKt2nxantLMCWJ4cC4=;
 b=TDjL5sC434umDx+mTs6gUT8JykbnCMc2F6VwIsd1vDWofghOFA5ccr21e32Wjtl6DbaseGjSRBP8JmG6t46HUwmalXX5gLkbVFCUtLEOI4LdFmt5pGowCjN3Wmf8xIFch49EBoQSE2V7g4ZowHeRRTn28FB+b+gpSggEzcqfQaHvoT7T9M7edXmjN4jCtyQt4SH56+6z8Vzv2ea/nETobiUJHnbv9YuTPVFg47VdaCP+J+5sPv2ETmSvVyHczz2QRkm1mrEN+XJbsbm3z4ypoliDsQAnt74ntFCUVHpmrN8E4cefm5gSnIZdckwGcx3yebN71GfrDDvxGp42/ZEytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN26MHlb9czNQ1bIAn/rZexPvvKt2nxantLMCWJ4cC4=;
 b=IvAKeNVQVxwg72Xpe35RmAIX2yyyWgjaYNbtscB0V4fX9dVy8Nhhz+BGjLli0NGmSP1821mO0e1kfWD+ATmxEMbI4ywtkclZhQUnWkahLvGpM/2Eg09WE5S8jjo2iaa8SvJ4aSaA5BHfkTWMrtIqOxoZLaCoB+c31doiYt2XuB4=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by HE1PR0401MB2586.eurprd04.prod.outlook.com (2603:10a6:3:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 15:42:07 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%6]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 15:42:06 +0000
From:   Frank Li <frank.li@nxp.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH 0/5] PCIe EPF support for internal DMAC handling and
 driver update for R-Car PCIe EP to support DMAC
Thread-Topic: [RFC PATCH 0/5] PCIe EPF support for internal DMAC handling and
 driver update for R-Car PCIe EP to support DMAC
Thread-Index: AdguS7LYnJjb3WdWSa+29EVG6gHCPg==
Date:   Wed, 2 Mar 2022 15:42:06 +0000
Message-ID: <PAXPR04MB9186D7B361F9FFE56A0AE69C88039@PAXPR04MB9186.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adf4f8a2-3a2f-411b-b25a-08d9fc6334e8
x-ms-traffictypediagnostic: HE1PR0401MB2586:EE_
x-microsoft-antispam-prvs: <HE1PR0401MB25864A97C451EE520AA4217388039@HE1PR0401MB2586.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EjVXmA+OgqBaXHPrq2K8gaFQXVIXVCVJmPzrXXUVWFG9OTQ+LknYkH8GMUmLH9fAaPzR5B1ORiWdLgNI6tpoUI0Ubs6or0J6sUz9eW6BWV7MYlvcy54emqHY3IsK3V13eBBYAS3r6Qk5nwYz6h9kFXIG4RLiNRl6+PBLh93y2jsgLFOdm212mYl6xHUKkwf3+VR41maNFJrSSscurPNk7jzhqRW8AD6UBDWpuBm1oNSDpdgSpgOcAhL4jOc/+9PXjYkhDowVmBxmPZ5JsN8NLx2Eao0Hss1l1xtvW5cxflGUh0UjFmG05Ixknifhes2oMgyp/48FEOAzLlHP3VJew69RMEO+HmkFmTE+86UYs6IAA2wH+WMbZ/HeCYbreC9NEw/a+lxpFajhMqNFit9nL5dpJaF4oU5Fl1P+emu14woB4sIym0rDbZpISRkRngmEI8I3V3eQQo8ghHZuSdpjaxSrGKQaoG/hSQJewYDFZCcLJ8+POUb1i3KgLbJjJo84hBOY0MahnVotgD2OhA/j2/VMtjYteTAjQ+dXl5hLIma2oGE44cUXujRAiLot5zLJEauNu4Bp14PyMbVFUaZHq5qDeQYigaNsWrFGHjEzX+lY8OvwcYkSD2vMXMDCSDWM3EJ0d24MHyHLsfFxBre30BPaGYrFneABgpqlj7Y9QWvhZfyAWk39y7HRVd3eMOfnNuqVlpK60UGY9uj1Xcf2JKJQt0LuAqRBwr+q149f16GB5i0glpYrR5c8G2+1gizwA5Hoqll8azf4t+4hJZdY/kdiVu1XCrv7cGpZoJLfC98=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(498600001)(54906003)(122000001)(52536014)(5660300002)(86362001)(44832011)(38100700002)(83380400001)(45080400002)(64756008)(8676002)(4326008)(66946007)(966005)(76116006)(66556008)(55016003)(186003)(7696005)(66574015)(26005)(9686003)(15650500001)(6506007)(66446008)(66476007)(71200400001)(33656002)(38070700005)(8936002)(2906002)(53546011)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?HSqjbXiNBxUb3JqDpB+pSKf+Zagc+Xia9n+g2muT9Ra0JBUGraxpCW8P96?=
 =?iso-8859-2?Q?RFVnzdX/aDK/d1/sgGxyyQhjKNrUreVZzW7LHGCI7BPJLJJdyoLxtqlnK8?=
 =?iso-8859-2?Q?+M/wHhOZyArVrrQQWdslSWuhS9P9vC43fmHELwLG3hMxUv2PHfzedbqrae?=
 =?iso-8859-2?Q?/Jk0pNJIChSZyEiWav8ceG3Fwf5IdS3U++kbUXY2diuA8+HaeMujUdc90J?=
 =?iso-8859-2?Q?mKOH5SRN+WT9gFb8qepxR8/0YMoNpDoJMWtrw9fIBJhOj/Ogvj8p4hwbyW?=
 =?iso-8859-2?Q?JdCY3ec7lxMSg8ib3IUF8ZsclN2EwSZOQLlEzyriyrfV9MspbeD5CTZ5Ql?=
 =?iso-8859-2?Q?wG4wyhDZf4O31cKUCStrxtD6X51rqW0xClebODbIwjVnvdzzShRvnqMKZA?=
 =?iso-8859-2?Q?iiwyfUFrGEZc+ocmY6gSnN1RGM0GNcS2YfAeucvFmzqyZKOrYNo2gPqHWr?=
 =?iso-8859-2?Q?WWB6aSJr/CtUlQZWKLGeKiIEdl1DrFPOWWFaFlB+qVlmmQfgcEf85l1w7V?=
 =?iso-8859-2?Q?Gznef6HLVZ8kCTWtuYwik9jUjY5ENPBaU/Qv22IT6WJAfuOmWg+0cfO+bq?=
 =?iso-8859-2?Q?ZA9U5igj1+k5LlJQvaSEzIz+XosdRy9lG26Cd3cfaqulVuZLeu/F/sONQB?=
 =?iso-8859-2?Q?/GDdNuKXZnOX5R6ZcgPvuJx/zU6kl+dpVLSK1/hCTwtHygMpAMl43rgEWy?=
 =?iso-8859-2?Q?kJG1kh79GNGgCvSQH9Rwqmt6k34qF9WXdwcikeKW35ECLVysI5aQszp33v?=
 =?iso-8859-2?Q?08Wrb47rqVGLa8e8B5k+859j2ZrNHdjxe78a6KLtLLCt2/MrOb79MVVKCg?=
 =?iso-8859-2?Q?DxYIHmanvBP0hZC7yfci1UcTbMy/I0+AJWzGoNvjmNKGIY3F85Lv0ffRnG?=
 =?iso-8859-2?Q?jS8duZ89tI+PENAHO8kJtQ1T1k357P74Hqkd7ZoWu8dPkP8hKs4UiVaWcb?=
 =?iso-8859-2?Q?6og/cCw8iPJqh0yI9ZTCRBZzttodXo4dknwERiRItnKkGqWX3AFMHK2D5d?=
 =?iso-8859-2?Q?C5SunkKh4MgwePCWog7TcMob0ZmJbFgtWXKZK7KUeAen3/TTpECTqBKoh6?=
 =?iso-8859-2?Q?5mHcQurkMyQMs6NDex2tEK29IXgcEK8W99wH2P4uTTkZCwAu0b0q/LB9bN?=
 =?iso-8859-2?Q?LPtJ2cP5rBAj445qE59+3B9HTm+Pp+/N5g72Ner8G4+Rj4LJUssUYHGPsa?=
 =?iso-8859-2?Q?TbOVmFLrfA9Z6qSvXqpEt1ctALxSD8fvPK3+QiATdShos9U+Ii2LZ4D55A?=
 =?iso-8859-2?Q?pDZQaFc0pd08YYsA9TqFWyI4bWyGs6jrAzq/6kJ3go5m1xgtiAZ3YKrPXm?=
 =?iso-8859-2?Q?haqVyhXi3Kpwehk8ngAXbyeFbZidY3Q92IHZ+WfapNo4fUbWY5v0oegezd?=
 =?iso-8859-2?Q?HtlV7m5tk9Bkb1OjfVXN2qNlC6ilrcI4+VRRLK8gGSSEnr7sHUQ+6gAIEO?=
 =?iso-8859-2?Q?N0OdI+74/yVrK7ujuh5kdxpAqcKBotLl8zvOWipoN+SgYKUtJEBMq6DF4B?=
 =?iso-8859-2?Q?dIi6ffuiwRG8+y0AWbpKB715cyD5+wnBjrYI9rYpSwcRPA5XdkZZ1BDKyN?=
 =?iso-8859-2?Q?YRzfdmC1pK3TpKM5n/3izPsikxm92M3Gj+VhIraqg3zFpI/oJY6XWqtbqJ?=
 =?iso-8859-2?Q?L9exDEJbDDRpkqT5HzzExvPWGqKGOFUDOE4ETX8YNBpKrMJnuBghfeIA?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf4f8a2-3a2f-411b-b25a-08d9fc6334e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 15:42:06.8638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOhK6bbiS24/t16yfE3cXd/Z86CLhLQVDyb6exaZ4Q/cB7joUqa9Opf7pqs7iQCtd2WdT5EVOaTHb2YGQhKTjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2586
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
> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> Sent: Thursday, February 10, 2022 3:24 AM
> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>; Kishon Vijay
> Abraham I <kishon@ti.com>; Bjorn Helgaas <bhelgaas@google.com>; Lorenzo
> Pieralisi <lorenzo.pieralisi@arm.com>; Krzysztof Wilczy=F1ski <kw@linux.c=
om>;
> Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Marek Vasut <marek.vasut+renesas@gmail.com>=
;
> Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>; Rob Herring
> <robh@kernel.org>; linux-pci <linux-pci@vger.kernel.org>; Linux-Renesas
> <linux-renesas-soc@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>;
> Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [EXT] Re: [RFC PATCH 0/5] PCIe EPF support for internal DMAC
> handling and driver update for R-Car PCIe EP to support DMAC

I use standard DMA engine API to implement Designware PCIE EP embedded DMA =
support.
Please check https://lore.kernel.org/all/20220302032646.3793-3-Frank.Li@nxp=
.com/T/

Best regards
Frank Li

>=20
> Caution: EXT Email
>=20
> Hi,
>=20
> On Thu, Feb 10, 2022 at 8:40 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Hi,
> >
> > On Wed, Jan 26, 2022 at 07:50:38PM +0000, Lad Prabhakar wrote:
> > > Hi All,
> > >
> > > The current PCIe EPF framework supports DMA data transfers using
> external
> > > DMA only, this patch series aims to add support for platforms
> supporting
> > > internal DMAC on PCIe for data transfers.
> > >
> > > R-Car PCIe supports internal DMAC to transfer data between Internal B=
us
> to
> > > PCI Express and vice versa. Last patch fills up the required flags an=
d
> ops
> > > to support internal DMAC.
> > >
> > > Patches 1-3 are for PCIe EPF core to support internal DMAC handling,
> patch
> > > 4/5 is to fix test cases based on the conversation [1].
> > >
> >
> > This looks similar to the Synopsys eDMA IP [1] that goes with the
> Synopsys PCIe
> > endpoint IP. Why can't you represent it as a dmaengine driver and use t=
he
> > existing DMA support?
> >
> Let me have a look. Could you please share a link to the Synopsys PCIe
> endpoint HW manual (the driver doesn't have a binding doc).
>=20
> Cheers,
> Prabhakar
>=20
> > [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
erne
> l.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ftree%2F=
dr
> ivers%2Fdma%2Fdw-
> edma&amp;data=3D04%7C01%7Cfrank.li%40nxp.com%7C95a5831aac544de2211508d9ec=
772f
> 9a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637800819106821404%7CUnkn=
ow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI
> 6Mn0%3D%7C3000&amp;sdata=3DyG39L2YBN9blGxTcXyVQwIXol8%2FCo%2FZ3GbGPIlqz6M=
g%3D
> &amp;reserved=3D0
> >
> > > Patches are based on top of [1] next branch.
> > >
> > > [0]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.s=
pini
> cs.net%2Flists%2Flinux-
> pci%2Fmsg92385.html&amp;data=3D04%7C01%7Cfrank.li%40nxp.com%7C95a5831aac5=
44de
> 2211508d9ec772f9a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6378008191=
06
> 821404%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi=
I6
> Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DieX2gSSHFDumc1k2iWoOfMyHg236aJT=
E7UZ
> 5D74D9KM%3D&amp;reserved=3D0
> > > [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
erne
> l.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fhelgaas%2Fpci.git&amp;data=3D0=
4%7C
> 01%7Cfrank.li%40nxp.com%7C95a5831aac544de2211508d9ec772f9a%7C686ea1d3bc2b=
4c
> 6fa92cd99c5c301635%7C0%7C0%7C637800819106821404%7CUnknown%7CTWFpbGZsb3d8e=
yJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am=
p;
> sdata=3DQc5cW6y5OrxprDjFQ1dNMZ4ZUc656I3FZqClaUMLx%2FM%3D&amp;reserved=3D0
> > >
> > > Cheers,
> > > Prabhakar
> > >
> > > Lad Prabhakar (5):
> > >   PCI: endpoint: Add ops and flag to support internal DMAC
> > >   PCI: endpoint: Add support to data transfer using internal dmac
> > >   misc: pci_endpoint_test: Add driver data for Renesas RZ/G2{EHMN}
> > >   misc: pci_endpoint_test: Add support to pass flags for buffer
> > >     allocation
> > >   PCI: rcar-ep: Add support for DMAC
> > >
> > >  drivers/misc/pci_endpoint_test.c              |  56 ++++-
> > >  drivers/pci/controller/pcie-rcar-ep.c         | 227 ++++++++++++++++=
++
> > >  drivers/pci/controller/pcie-rcar.h            |  23 ++
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 184 ++++++++++----
> > >  drivers/pci/endpoint/pci-epf-core.c           |  32 +++
> > >  include/linux/pci-epc.h                       |   8 +
> > >  include/linux/pci-epf.h                       |   7 +
> > >  7 files changed, 483 insertions(+), 54 deletions(-)
> > >
> > > --
> > > 2.25.1
> > >
