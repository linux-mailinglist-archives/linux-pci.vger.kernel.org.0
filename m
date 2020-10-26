Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E152985C9
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 04:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421709AbgJZDEt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Oct 2020 23:04:49 -0400
Received: from mail-am6eur05on2046.outbound.protection.outlook.com ([40.107.22.46]:33377
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389734AbgJZDEt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 25 Oct 2020 23:04:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qleq/lNcOlBsInp1HKRsi6L6wqwfiVVOMkh2et8snwVEwoTsCbjRJQJVUBP5aaGCkf09Xz2dfsKBD1Pg3RVcMsNZlrq8g8oQzdPfWceKMvw26PcR40aQ84vWhWqMtOKTg8ZSaV7ZlkIoOtmxquSrn4Y+cJSK06G4a8nURZ4gnpoINAr4B9sRcJGdTm2Mz7t28VxHjuaLnmnHpSuluUwbW2iVRQs836BH2o9PP362h6BW53YTYrJ4CHm396/bXTkBhNVtXyehujVxQ40zBoRT3TDmBMizRDPzSdMfvXN4Uy0b+uYn/234qutHTaSOfzT/oJR5h0KGFD+8tdPgTrcF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CModFF+3CHHkPUIVC5O0/qKArBt5qw+Uy59yH4vbmr4=;
 b=Rn7ydBFLyuVqVjETMuL/wgp7KeA4pvA6djimd/rxDJvOztPotk+b0UbtFrpsl14fLY5LFaw274QZ0s0W83gBbH8c+K9uPDLpYU3HcMn/9LFHlgzE68SzU0n5SVAiF+ZIXvK+qDi85nZ4fuQQsGxawYBqOAzVfSfc97NnwnsOgq6DW8tZOmb1u732Ofp9CZrniSymO9V3xpkbkwqAq2eNTdc4qvxTPlL1MyoBUFXlRiOba541+KbOVSBZWAvn8woF3SLQ4BZ2ed10/TcapPaOukjbgS/D4ckT8f3nNwK10ubal5Az4K2zojZdt7HgLXLRrm4N4JdQfAvUL5vP0XgHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CModFF+3CHHkPUIVC5O0/qKArBt5qw+Uy59yH4vbmr4=;
 b=mUvd2gN6C2zj1mY7+DaGq5R4iiIvlDVSbEtt8/J40vaoN4ZQOMA46x5r2/oM/ANOTVG86LlpZFGRwWQK5fHcdIvAI/FSTJmkk3lApYQ1iuJDCPX/SorKAZ6o1n+1vUj3oY/iWgHyca5SXv7m7j20O4pDGRVsGH6E0+iXJU9oYtY=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VE1PR04MB7280.eurprd04.prod.outlook.com (2603:10a6:800:1af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 03:04:45 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 03:04:45 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Thread-Topic: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Thread-Index: AQHWqDFSEBaTQE/ZZ0S8iz1mc9AwNqmk7OMAgARJc3A=
Date:   Mon, 26 Oct 2020 03:04:45 +0000
Message-ID: <VI1PR04MB4960E9ECD7310B8CA1E053DC92190@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
 <20201022050638.29641-3-sherry.sun@nxp.com>
 <20201023092650.GB29066@infradead.org>
In-Reply-To: <20201023092650.GB29066@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: gregkh@linuxfoundation.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a4a9257-1412-48e2-15b1-08d8795be44a
x-ms-traffictypediagnostic: VE1PR04MB7280:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB72807B07C4F90FAFE14C21B092190@VE1PR04MB7280.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xg/aBknpGqz/7T7XsynBANexq1VBMhVfSXnLcGg4mNnCpb5j08dGSsg6YFcyLsni8Aeeq1BI1TQrNQ3MGkSFCXdjQFB4nYjvC86NiPFAQw/hmy0cULKwcwJ7TMhapTFo4Xy7fpfMJ+mme2Tt37BVRwcOENowhbBv37VoMg6ClXmaXCsGBtJTlZ633RUULhulnbRrLtCTPmeXEg9dCoFBVENJ0+r7Cvq5VlHr1doFbErN8CWRgirOzjKI9cq/A0nl1AsxyZcGbRw6AelhmqKm6PNfoFQ2Rj96v2/7A9muMxSJWepC3cyDgRoCDf6QkHkxG3OMgS781RrFHweJp9AohQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(4326008)(8676002)(66446008)(186003)(55016002)(2906002)(7696005)(478600001)(26005)(6506007)(8936002)(44832011)(66946007)(86362001)(66556008)(9686003)(71200400001)(66476007)(76116006)(33656002)(316002)(110136005)(54906003)(5660300002)(64756008)(52536014)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MiLiIoWBrFyWpFSicKQfDHPrPnP9No1D/M4pfc7Sqm8sNR9KrNl4SYYV4ZnHnfZKckBlgZEKU1MezkCWi3Tc8EeatyI8KIN+SFfRvNBJCI4Y82iyE+ox7hafIIX1vZhTJPCTDMi5WWiwTSnau75xwn/SSDLocR4MvP79KDsbmAp7jyeXtNa8CrgYk5/bxlXBHtbCe+fStrJroIMD9H/sWDzYHmDUUWa22WWCyQrpD0gfS44sTpCsoIWAMWYoq8dXh+eXrTrOfDQLHeJyiZX2gF6I0ECwzG7314g49m2o1UFvn1vhqby5r3sugHwBM2veSmJuUUytAfYCnQXJoF2pXe3VXEp9HYWfs1/Mo2ddAhPqK07vKlV5kw4ZhlTVpiqTnZeySA+SHkFb9e0LC//6kFN8kxjpTRp2MyH1tv2nQK9oiJ8nCxslO9J0Jp+HPEoASaDT1OuUU6QvR86qP6/8S8NJ2DuTDn3mzjuoMdxtAXmFiRBLDw6Nosuwwj1ZGu8BMbsjczBWavbv3FXAGsLZ2PE09pI5rocc1S8A4LWRw2GviMhwRiuDzYGQpAPTDxDLlh8GrWPhai6NROJfsjHRTWICAtfB2Rd2lXpT2GBFrOUm4YiPoN/Ftu63JNH1YIX0NKFuCHvmOg/k3Bk0VMzUhg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4a9257-1412-48e2-15b1-08d8795be44a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 03:04:45.0811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1CPkgwKxX1OqJAdMfPmjCQ2V2x78IuotA9vzlh691g5YfcvT5n17JfQ/1dlUbwVJSSthBmJyNOnsTHwRh44h2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7280
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Greg & Christoph,

> Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the u=
sed
> ring
>=20
> On Thu, Oct 22, 2020 at 01:06:36PM +0800, Sherry Sun wrote:
> > We don't need to allocate and reassign the used ring here and remove
> > the used_address_updated flag.Since RC has allocated the entire vring,
> > including the used ring. Simply add the corresponding offset can get
> > the used ring address.
>=20
> Someone needs to verify this vs the existing intel implementations.

Hi Greg, @gregkh@linuxfoundation.org, sorry I don't have the Intel MIC devi=
ces so cannot test it, do you know anyone who can help test this patch chan=
ges on the Intel MIC platform? Thanks.

>=20
> > -	used =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> > -					get_order(vdev->used_size[index]));
> > +	used =3D va + PAGE_ALIGN(sizeof(struct vring_desc) *
> > +le16_to_cpu(config.num) +
>=20
> This adds an over 80 char line.

Hi Christoph, will fix it in V4, thanks.

>=20
> > +	vdev->used[index] =3D config.address + PAGE_ALIGN(sizeof(struct
> > +vring_desc) * le16_to_cpu(config.num) +
>=20
> Again.

Best regards
Sherry
