Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF7C3A1087
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 12:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhFIJtg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 05:49:36 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:20064
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232867AbhFIJtg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jun 2021 05:49:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W90QJeCXcxy+/hVcA2AJyFT2KxKX2tqxvz2Af7lvbHOBI2EeDTeW0YeHKg3GLrMds5ESLpEyjdJTG2uKLwTOtTp9lEJ5NhZkbuVSf5rUNivxC9BcyrrNLqvhRh+/PkqLi3wMfAWH0gdEDtPb9qmFKxDZNjxoYxdOzAgh8T9D5Sfg/bhRNu6BMt7RpR8HZ6p7sXH65kqVPrcRgY7BV+3oe16bQxE7xT34MgxCykG1FqgdTWHKyOYYBb5+iNggrRJlip87N64zzMbh+VBOzagUCSxFGTQFhdWO4UK/2ycUCmk8og0UroZMa8jspTjHTswk4/ClTQ01zuSg/fhvMtmY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ooC6jTm71DwvonShNu3gVaaf/I4QGxB3Sx4Dk4AHMI=;
 b=RbNKq22oCk4n9ekCXoa32BJXCvnSDiX1LWLJNAyfmEi6pHRM1vADAP7uuhc2jzjbPtvQlRjxPXia3XKOg0TLhgR7DM2aMZVb+rj+MSu40H6gwpjKsAXxZOtM+WXAv86x8nbpdwRlgZNHpTiFUPGuGMsBJl+pqf9B/GdzLO9Dp052OywqfZhNfmV+lHMQpRz0wIeawTTumBnBdze6NOmPBxKU+pjwAWVFyyWrz5Z1mbGcus4PNm/lEyh3RwXRLwf6Dc/QX0pvarcEQnnDsK+lt0V/enlsloNatCrIWZ1rme+tssUg5EVXZ8cAkgF7V0tJ1Rwk3C8zRWR/x2/fJ/jkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=synopsys.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ooC6jTm71DwvonShNu3gVaaf/I4QGxB3Sx4Dk4AHMI=;
 b=rLnvhUcaMbE7tJLWnnRBM4gEEj/K+XhV1TU375q1HnEz60L9KvGQadBkObnS5+xjQzrIPj1CExTUqZLDUXCBgw5LKe+Tp4yUCY61DZ9Yecj2RxekA9T+663GuNXwFtDCX1elcgc5ARrEkw+O8vIbTfLjWAkTI4mD15IAIFto4xJx6zMx8h4ftlTBaL+J4EZsug+vESQE7eIvTpN1V+ByLShiZHwNDurf1cUmvZ7AZFUnaBRLbUiNeLGwTGI2k82jqIZML80AZSMRa8SlCBeM3FEqDaEU2mt1kUh6dfcdQPDznWW1EGI3t0eYktTRIDeuSFONpK/2OwALc1NSeMJ5ZA==
Received: from MWHPR03CA0011.namprd03.prod.outlook.com (2603:10b6:300:117::21)
 by BN8PR12MB3331.namprd12.prod.outlook.com (2603:10b6:408:45::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 09:47:39 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::b8) by MWHPR03CA0011.outlook.office365.com
 (2603:10b6:300:117::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Wed, 9 Jun 2021 09:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Wed, 9 Jun 2021 09:47:39 +0000
Received: from localhost (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Jun
 2021 09:47:38 +0000
Date:   Wed, 9 Jun 2021 11:49:20 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Vidya Sagar <vidyas@nvidia.com>
CC:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Query regarding the use of pcie-designware-plat.c file
Message-ID: <YMCOoGzE2uGxabqF@orome.fritz.box>
References: <34650ed1-6567-3c8f-fe29-8816f0fd74f2@nvidia.com>
 <DM5PR12MB18351813A8F94B0D18E6B505DA379@DM5PR12MB1835.namprd12.prod.outlook.com>
 <d142b6be-f006-1edf-8780-da72ff4f20e3@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRn0FFzKJbdSi9sg"
Content-Disposition: inline
In-Reply-To: <d142b6be-f006-1edf-8780-da72ff4f20e3@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ab78106-5ce5-4b2b-d21c-08d92b2b9e87
X-MS-TrafficTypeDiagnostic: BN8PR12MB3331:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3331050A0D4931412BA72646CF369@BN8PR12MB3331.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 061u1w7y9doF6tM3MmK7dPrF+EkItH0OmklcEurbQYbqT7hwZLSlVhkQW3RvMd7hGYFJlKuFoHoYlM/dMcmW7BJX9pkFZ4DblgSAThQWOCuITao7fyZU879ngyMRrSHv1rC4WtXXwK+g15vSED1m7I51JvaSgNU4c+KC/ZSQ1n/CCmDjYCfE3LuIfXhCTgQfE3jop1WNbpLOHrNEQUZ3HNV9TNw4ELz/Umte+jeDE60VP+/42TWhAYTKIybLuxHZw8s37MGwwqXnEgoosj+D+ZdDqwZXvfFlisTThGssmHIiERCg/ygLxo1HBJXPjbLRNS7KV5cL+UmWJOs68ql+joSePv2jWEscUA6wYjnKnQi0Jwmn8iqunX4d84+UdeifjklNmp7YYqN7XnLUB+PPRD0am/WjtJ4aTpDncFQw2sLAeMG+NUXIEwUeZCSvrk38Mw0/gI3auW6bfo1tDsWKKtlxmNfenh+Mjq8MH5rorrxolpx38grCKFlxr5ZDGlBLApRZkrXaS1oK4MDrwqXjho03aP6lwFwqlOsOopm27kt95wXRM5qYOMplgwBdBh9md8i82GqN37RG7ZpbTn0cf4IQH++R/iJYXH7pvcVxTASZSzWyw2xqOen7M0D5JWvQmV+FHJ44BCGdaIGWuXWcpRpM67f2ch4A6Y06UED7HYwzZqQmNQb/4yqGIyKj4YQR
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(36840700001)(70586007)(6636002)(5660300002)(82310400003)(6666004)(9686003)(70206006)(2906002)(7636003)(82740400003)(47076005)(356005)(6862004)(86362001)(8936002)(36906005)(54906003)(21480400003)(8676002)(4326008)(316002)(426003)(478600001)(16526019)(26005)(186003)(336012)(36860700001)(44144004)(53546011)(2700100001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 09:47:39.1705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab78106-5ce5-4b2b-d21c-08d92b2b9e87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3331
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--wRn0FFzKJbdSi9sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 10:56:48AM +0530, Vidya Sagar wrote:
>=20
>=20
> On 6/9/2021 2:47 AM, Gustavo Pimentel wrote:
> > External email: Use caution opening links or attachments
> >=20
> >=20
> > Hi Vidya,
> >=20
> > The pcie-designware-plat.c is the driver for the Synopsys PCIe RC IP
> > prototype.
> Thanks for the info Gustavo.
> But, I don't see any DT file having only "snps,dw-pcie" compatibility
> string. All the DT files that have "snps,dw-pci" compatibility string also
> have their platform specific compatibility string and their respective ho=
st
> controller drivers. Also, it is the platform specific compatibility string
> that is used for binding purpose with their respective drivers and not the
> "snps,dw-pcie". So, wondering when will pcie-designware-plat.c be used as
> there is not DT file which has only "snps,dw-pcie" as the compatibility
> string.

Sounds to me like we have two options:

  1. If there's indeed real hardware that's identified by the existing
     "snps,dw-pcie" compatible string, then it's wrong for other devices
     to list that in their compatible string because they are likely not
     compatible with that (i.e. they might be from a register point of
     view, but at least from an integration point of view they usually
     differ).

  2. If "snps,dw-pcie" is meant to describe the fact that these are all
     based off the same IP but may be differently integrated, then there
     should be no driver matching on that compatible string.

Option 2 is not very robust because somebody could easily add a matching
driver at some point in the future. Also, if we don't match on a
compatible string there's not a lot of use in listing it in DT in the
first place.

So I think option 1 would be preferred.

Thierry

--wRn0FFzKJbdSi9sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDAjp4ACgkQ3SOs138+
s6G1hw/+N2tk/slpSl+GaiMhQXUQgDwRw5V5XiELwX1vLqgGKWwJsiQn+LD6TvMa
kCgRrLw1rIKjqG/EUKLsrM/7ftAcwArO7DGMzKQQ8AcuSHRY6R0QjGDzYyJVO0VJ
696kNW7CvfnxJDOpnQn1BionbkyY0MHlElOYRhOW+IZNfPAJRc4oWao6zV/vdzE9
1sKSi/5GWACo/2zhLIa9bu1llWbFcDaNlENpDbkulI5OjcR2aB8NSmKzRLUbpoeE
QXRDQkvAnnOidjA5UggZ8q6mNhsqcsnkX+AEDxhqb3j/VuHUhtLfWQhKkTBgjwxc
Pdie+wYq6IRcXW2JXOdGoFw4SNG92FV4oCVFRjtPKhlnwZBet6U3OjWtNcskm6w8
UUjVH2tsWlpWUMABPtqxb+LeYEFpUIPjXXo82lCWn9ObORy6VICpZmt0IHlapeQv
jJr6rUbZdsaDUcAJ6OOteNOmaOpY5CNfSLs06Ub4rlpwYLABFSp/UHvuaIwZvMfC
i4ZXFSG/8EtyHO0DOMk31oxMFVKiGF81aCk5kBG4zhXaBMxyZrABmFVuWdSIE3Q9
pFtNIq7Lrg0KLGYTxFrONLDJUEarubfvR5RPb+e/MbSAwkoqmWNEOg72dHgCRzwi
6Rm+TKEG5rx1WuW1/UPP6sFoj8IUvsEtphSQ6cE6Zl9rufzVxdw=
=DHEE
-----END PGP SIGNATURE-----

--wRn0FFzKJbdSi9sg--
