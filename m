Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACD564DAE6
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 13:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiLOMLz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 07:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLOMLx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 07:11:53 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729F62DAB0;
        Thu, 15 Dec 2022 04:11:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STcN8Bw2OZbZU0MgZlcXaod+zsjJUIrtTqedaDfAjAxJ4wtTIrlrhSt96VPGNWiKuAp8Rq5I3WXASj9dAptLufucmbKQUh5AoEQJllI3Q4IjSPABeK87o1uBPLjldRmwngqOgZcLHVw0BfPGsNorWkQdMetTaXrnbOAaXorGZtemEGNeoOoi6vwXnkS3aRJrUFm+XA7RJ6h24cIYIag9uGMmS6iwPXFjO0+P8Pl5EyVnArDEjYt1yI/BdzOqXdNaBgHWJpb3HAihsys4h+7wssQV48DRCO+bb4gg+2D70GCXqCJTWDmcu5mYZyZnxUjW/Cva9Mg97m/xrSW5adAp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsndCavKSI96k/7Eo/vf+mvMuDb1A1Sfe01DxlpUHB8=;
 b=BWovNZ0QaR1SSRtRA5Z+XCTBDXup11uytOFDD15vPczxO7MCorjgVphywpTgaUT7lKTD6je+VVmPvB43Xipg41e+wCQ1DRQX+M+0YTDc2p2wxhNNVy+os23OiwMOA5GoE2La3uljO5QsozqgjFLZAoied1NdTxds9EE6xtokB79wbc0vOJfDbimNjsNpwjbyO5etTIkQ86DX34fgg7CxZB3+XbM8Qp5nwwszSh3iKU3Y/TLagsrMZyzI6eS6sTupSOW5vU93y+UBkCIrA6XcGJ+qFyiRb/VWRS3dFFwdM/8gYVoCPVjBWiz/7UODAAzAXEbTlL/hlmA8h1hR6czevg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsndCavKSI96k/7Eo/vf+mvMuDb1A1Sfe01DxlpUHB8=;
 b=GTlrq3MA64FuzTkOcsjbcyFOh5nwUeokdVyL2rH0wmO+eK6OW22ncHluwpVGMZVpWs3zhx+DCFI1YJWGtCLULcl87vGSr6BuhXV8ufCFxCIi2gaE6ToNQbBBAZql+DfbcsG+ADCcijC7MbTyQrPB6bHmdzX92qvpjilcTZoBcYaSOCpwP+kMDHdg3iP3aRpRgTc0KbHxXqmw7buliZUWIXj+WQP/qV/tTyW4bpp9pB84WTHHSm9xo8TPPLY3mXcKnGUGV3RU3FIxewG38BxRSN3Bd8vyOX93Fi1C0tN4odUpdnv8IN8S69npY2UsNjR64bF71jfrP5t6gXtG12wSrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.11; Thu, 15 Dec 2022 12:11:50 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::f76a:b86b:c6a:b4c0%8]) with mapi id 15.20.5880.021; Thu, 15 Dec 2022
 12:11:50 +0000
Date:   Thu, 15 Dec 2022 13:11:43 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [GIT PULL] PCI changes for v6.2
Message-ID: <Y5sO/1klSvVCyWNz@orome>
References: <20221213233050.GA218218@bhelgaas>
 <CAHk-=whC3-Q_-gt3NU8cfY4ivs2CsaON8Ci0aiD6qvT1xzVL=g@mail.gmail.com>
 <CAL_Jsq+Y1CN4BMhB-FXFunr1rFs62QEMi_zj3zmvjXrksCQ0sA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hgDTq2pDvGgRVUFl"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+Y1CN4BMhB-FXFunr1rFs62QEMi_zj3zmvjXrksCQ0sA@mail.gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.9 (2022-11-12)
X-ClientProxiedBy: FR3P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::18) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d76a2a-db9d-42e3-9380-08dade958b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C48GfSmZoUBZmFdZYtM4kq5UDfESjaRjEq8/+Aq6DhkNfDI5gOQtTLYCvTojzjX9TJeUu0uEX/yhdFueyQ/zC2TURiDY50Mpx5N8fUSTaaGkUJr8GW+QT3RAzhfwhvE3S/yDmgdN+u/xaw9l8jQFFLwmVQ81rZv0svTShx5UOe/bHdGkq6t2uktmGRicOluI66iKQtY1QwmHqmLMBKUugm0vNW3N90qIu9z4du/Ph3aV+mY7X36QTXv8PHRbAhjdsgwJUhUwFdMl/IYywZpXBs1Rkz4kY78z+1yDQdg5umwLowSzv8YL0eoYCZn6F9ONeWgThqm+RfdkOfbC2yRQxbSBwBb33IZ6Vme3WBVSn68OAksAI3ACwFgxazhzLqrCiDswTOMODQ1Rs1LI+4ppUtSqABhI3H/TX9SiQhTDIQe1MzL+M0PvdEghvyG6/Qehn5A+it7lcBn9Ao7VdND97c67RpWxMBXgc8Co+bSBoMBdR6N124kiRLES4Knl1TZ+QANHTukTCJkbYttqS6wSxUYnEeezFEPy9joRP7JznezN7wIjkA7dTLRZeBfP5dUN/K3kdsbeqHat152jGi/Uiv0y6RXC10xGd+Us8KyqUTipJlGkQgf13bTGa2JoeMNnQQBa32MNiRg2IwsUj0i0tqavHppLOjpLAPgNg472tfJD7t9dDEUtB8Q3RVEuLu1CXkA7WgyVlGeUWyG4VD1UFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199015)(38100700002)(41300700001)(44144004)(86362001)(6666004)(33716001)(53546011)(6486002)(478600001)(5660300002)(54906003)(6512007)(4326008)(8676002)(6916009)(66556008)(66476007)(66946007)(83380400001)(2906002)(21480400003)(9686003)(8936002)(186003)(6506007)(316002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0V9M14On2hCigOnt4rpJCCWmBS5tQjkeClVWg+nVBW9/H3dlbqmUprF20UfY?=
 =?us-ascii?Q?ZTeJ0xEWn5s05KwqXChhcop40lpbgNk15+61lvZYrnYRAjSk5R+2ObprfUaV?=
 =?us-ascii?Q?1lil36DAkggRTQvTfXKxzB5x1SBt+CNOYXxT1ZwhwCPLgEkh+DHXDeddEdDh?=
 =?us-ascii?Q?FsMx5ST8LbrAePWn76b+SnwWGcefUGBw+WT6ZW4iLm/ZP1fjUwT5LNnKkG94?=
 =?us-ascii?Q?ww24afiOO6neyuWl6sV6G3zUjKbFC/Nb4AKmfi3SfoAXT+pNHi+YZijU4k7M?=
 =?us-ascii?Q?6EXiUoO61bbjkS+e8uhMNTMNjx3YrkY8NqMN1S6ZCl24phbq/6un+KQ333dq?=
 =?us-ascii?Q?THEUcyXaTnLq9oqNTMSChPg5vdrV7f9jmcIGpwr2e0cbgvkZ+o60r1mWPz/3?=
 =?us-ascii?Q?1TZW8oE6E3RwiO1ioSruORpYyvKNnvs9y3MIBCesYbeinFl+14hdxcqASdor?=
 =?us-ascii?Q?LvgFtdTntQ+QKPL0yIHNM61CJLrF7/Z+mpXqvvAfvvLTr7MO34L1oKqXrKJC?=
 =?us-ascii?Q?mPSylD+wkTNSicgm4vxvAn8m073MOc2L6ELCDcfoTMCxC2F2YR7fupkQrzas?=
 =?us-ascii?Q?0yNzct/lGAcRoa4RA/hESsAhtvudOn22n8EGzvRMPg8ECaGP6GSDsG3DNd8E?=
 =?us-ascii?Q?dsI7reyeuBTEESVtKSSr8fXIQ/jJcla91iq2qm1pMGGVCut2/c8GgmfCxQZk?=
 =?us-ascii?Q?aHoS9Z93jLMpH82lQLXVt1yFGCoYYD57pWQLqLGBH9Kqr51/R+9Poc3c7SMA?=
 =?us-ascii?Q?jDRRIgb+xxBvrUvfRTWMKm8xml92fmKd9hlrFI/P4FgSzdQdNbHwVwkWoVvw?=
 =?us-ascii?Q?WOltB1juqu/jEL/JFkGYBV+fsI8umg5U1s+t+mnZXR8fse49q9LaK3GBS+mR?=
 =?us-ascii?Q?phkRXJfOXJLrDnUJ+jH16hU6cz+efiJyixGMy9mllgedMyk3qrFXGj6WJ4Zr?=
 =?us-ascii?Q?S5kwlCupIfBox1RS/bXCVF1qXRpPkWI/PRagYK2SW/KJ6NwGs6M+JDvXGLrb?=
 =?us-ascii?Q?RNdTOWhvnas3vIuYRKkB/qEjtg3R02H3wtIFwGKjxIesYbxHrv0rnkNRfbUu?=
 =?us-ascii?Q?hqqGCPF0Yw3GNqDVSdiThdRd/o7AK1tXRjeovzu3vqhQXlE8yzkcKWCgWJrB?=
 =?us-ascii?Q?Wjiq9R+2f6CTfIqvPu6fhn7MCuAs7OlDcdKGWiJ0N+zYAgH0KjtZEzZGPVrx?=
 =?us-ascii?Q?VQpGAkoUY1L3BWIVnbb+f2kfarz8KAekW/QYgtBLdbkIdP3QyTm6ljxhPmPR?=
 =?us-ascii?Q?xTVjqLv02f3poLeNzWt5bSONomtPrY28kVzTjrKPYGnkU400IrGW2tmiXHmC?=
 =?us-ascii?Q?Nzgh7hgEGr8PnqJ5Y0w+jOxQn6rnlI/PXY5VpF1oXUlB+b6hRdsheYcpjXm5?=
 =?us-ascii?Q?pk9MJtD5pnT8imnnGG+AqII/B4+u+Ntr8Q8dEoqx4l3IK8R4fYxQoYaBjKXn?=
 =?us-ascii?Q?xoDv/cdhvXKwEZhmHiMDRuBiPIT/lA8PaVUzfXGysnmUZEurV5iC3yTLKQ4i?=
 =?us-ascii?Q?150XgLjYmayw0FEBj3jgvjS3DJ6zpEdSlFSVTYV3q2Eb9i6LHuOuew9Aqcke?=
 =?us-ascii?Q?rbzqTxllQLRdcwGpG9wmwpP1D4Wapyb2Hs5IVZ8OGhP5waZSwA/d2SR+OC0L?=
 =?us-ascii?Q?j/5UQw2na4Rq9XNQI7i2gAblWOPsOHoGBcZ1ZudYnlkw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d76a2a-db9d-42e3-9380-08dade958b72
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 12:11:50.0037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVlhpB32OlSAyKFVANlFVe7tHQW+uSR23qDdI54ZlnIKhq+QklpEWd+uNB5xJ7El+14q4Yu/wiZhnqA2bmmozg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--hgDTq2pDvGgRVUFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2022 at 06:22:27PM -0600, Rob Herring wrote:
> On Wed, Dec 14, 2022 at 12:01 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, Dec 13, 2022 at 3:30 PM Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
> > >
> > > You will see a merge conflict in
> > > Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml between these:
> > >
> > >   5c3741492d2e ("dt-bindings: PCI: tegra234: Add ECAM support")
> > >   4cc13eedb892 ("dt-bindings: PCI: dwc: Add reg/reg-names common prop=
erties")
> > >
> > > 5c3741492d2e is already in your tree via arm-soc, and 4cc13eedb892 is=
 in
> > > this pull request.  The resolution I suggest is to use 4cc13eedb892, =
which
> > > means we'll lose the addition of "ecam" from 5c3741492d2e.
> >
> > Heh. I only read this part once I had already resolved that thing diffe=
rently.
> >
> > I dunno, I used my own - possibly bad - judgment to add a case for
> > that 'ecam' thing under the vendor-specific list.
> >
> > That was very much a "monkey see, monkey do" resolution, so some DT
> > person should check it out and possibly make fun of me and my dubious
> > ancestry. Rob? Thierry?
>=20
> Good job writing valid json-schema! :) It's close enough and better
> than just dropping which caused warnings. It is Tegra only ATM, but
> anyone else that sets up an ECAM region should use the same name.

Yeah, seems fine as-is for now. We can always move this out of the
vendor-specific list once others start using it.

Thierry

--hgDTq2pDvGgRVUFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmObDv8ACgkQ3SOs138+
s6GjlA//R1oPZBKqjFryCQyGPu46yvcnXknqc4kBtloCx4Ctgl2Ohdvqyn8GqbjE
oPWxmfV2ig36ZzQS6DwPZorQbXoaOeWGHdrRtnC6i8Fuzu0fwnY3gVFKG65Tzr8p
eaaXFvumdq2PjGmv8Zh8LGwOrYu8VlOgSGubZS6/JzKiXDd5Q8myJBYvs/PUNKhv
QHMW1GK5li6SsBteY8tv9BwUN5IZZ5atcwT8lWTN5YUmYmRnOBAKaWigjKmFfxiL
GIPymrnHMoIZsQMT/Jdm16v4tZKeFGFnPOjlfue9N4vKAA9e5eK7Vdd5ajuDe2Ol
wHzznA1RQGvN8xMklJNhUFfQ8OFjuQBSFmQ6bUsXeMe7RS5t57qQ1TDRSpiPDwXW
ad0CDLnCUbFGvyPz22VqOdZLisO5GqxRMgfK9FX7K3deprvzmYgSqVFa0ry4L57Z
70KD+gK0CfziQbqy6TX+fvcTCIxC0eTCToMHDVoyTtcGnly0fbS09EkcAOHXLzIp
UrXg2jf6xCtW6y4jkmIPJFFyw7fuuTZPteRojeXMI6NO40O57Qcgs6jqNaNm2xZK
fsj0NwlafxWQNJzsVHBW28Ics/Mbfuwt8qC+JXutLvJaVpoSXtsuwCGiDlcFPz+k
j5jzFZkt4R0uFuoZSEJUqB7g8KFKcMAx11bFlS6olozwEi8RPuE=
=hy94
-----END PGP SIGNATURE-----

--hgDTq2pDvGgRVUFl--
