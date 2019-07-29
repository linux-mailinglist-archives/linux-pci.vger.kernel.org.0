Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 463E67936E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2019 20:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfG2Syh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jul 2019 14:54:37 -0400
Received: from mail-eopbgr770091.outbound.protection.outlook.com ([40.107.77.91]:43333
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbfG2Syh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jul 2019 14:54:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO8c6ilg8bNSNOz6v1csDVhupiIOP0/txyDP1GGD8V8fu8PgyrkgaJuC6TxZjbIY75zLKnx5kwb1IeWDCCJcwl+kMyIeCDGnjJY+dUTf88m1NqmEYfQyzJx8CR+IN87CLAohv+7YS9jvnUqjfbguZO02RlYSiZkHdtbbMi4cmsb+JDVHPMPUIf6Fc2NdUI0kEEp+lGdrqq34uYVCsemxdiB8mHEZ2M66Gxu9CuAiXE2UE0TiEyU6AWE0TyHsLI8Qz0qGHC/r85eOtKtwOR/W43DhyiuXVOBE0SPDw/fHYsE7xfBfrRnQyRlFIdkFwgaSMlCM6x1yeQb6qW0sGgwAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sXfKELTri+1mkeudoYRVryh82yXK9dKsepaYugaOR0=;
 b=ESmmrAjQlXObUn5uMlOi6lxPISwcrB/UavBXo6JSfbfjo2fyryA1v0tegCcwT+6fter+igdDbH7T8yWwK4OQiHFqJc2Kanwj5rAwPWy4GRFem3wHHp3V4gq4FY1YP8CeiyJ0QEhbQUzqVWTni6VTNwmOlsrVDxI8fVikI5sSFeD5RBviI/RWKHGQwOTLGPXDUjOX5juIx9lwHDvMAoW671pJJLgIXjaS0UlOWThF4II2KT91qPc03HoTIZ5rff9a21Th/ZYaw8y54u/aaKMeO1V94kWc4x6IFk7VZ96BmQy/zXzWtnKos8NNUXWv1dqxx9KeK5NRBI+B8AY5oDhBmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=mips.com;dkim=pass header.d=mips.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sXfKELTri+1mkeudoYRVryh82yXK9dKsepaYugaOR0=;
 b=GqaV6USw1LTvs1vMcj1XeZODlCjaz1X+K1yZ473vyXObHEjbIvemYKtCl3EvTm1Nxegyac54HYt/bFC8kshWKUGuLeXv3j74CYfYQDiHQ2cEYFgh+u3lxqYBxFxBwB5j+WR4M18CrPypcHFYU1bgC9T1fCMVrgxs3EOxZnCs2TA=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1101.namprd22.prod.outlook.com (10.174.169.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Mon, 29 Jul 2019 18:54:33 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf%4]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 18:54:33 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Denis Efremov <efremov@linux.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] mips/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
Thread-Topic: [PATCH v2 3/5] mips/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
Thread-Index: AQHVRj8PoH/jSXBO80Gm27CoRgrYsw==
Date:   Mon, 29 Jul 2019 18:54:33 +0000
Message-ID: <20190729185432.q73kptotpe5ku24z@pburton-laptop>
References: <20190729101401.28068-1-efremov@linux.com>
 <20190729101401.28068-4-efremov@linux.com>
In-Reply-To: <20190729101401.28068-4-efremov@linux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0063.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::40) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c9ead6c-533d-4b39-5630-08d714563200
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1101;
x-ms-traffictypediagnostic: MWHPR2201MB1101:
x-microsoft-antispam-prvs: <MWHPR2201MB11012B3D55F5CF95AB4AB18BC1DD0@MWHPR2201MB1101.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(366004)(39840400004)(396003)(136003)(199004)(189003)(76176011)(26005)(6506007)(386003)(8936002)(44832011)(66066001)(33716001)(14444005)(256004)(2906002)(71200400001)(71190400001)(478600001)(476003)(3846002)(99286004)(446003)(186003)(68736007)(4744005)(6916009)(102836004)(486006)(81166006)(81156014)(14454004)(8676002)(6116002)(52116002)(11346002)(7736002)(6436002)(6512007)(9686003)(53936002)(66556008)(66446008)(66946007)(66476007)(64756008)(4326008)(54906003)(6486002)(6246003)(305945005)(5660300002)(58126008)(229853002)(25786009)(42882007)(316002)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1101;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DQtND6T5RRV2q+xKYmUVcnOWritMjW82FUOFn7TRr67/m16FGY6J2ICyGrDnrl1Db5nwSSOmKchCW8zsCsReVrUGu+UHP7glVEnT13Zawtj8UMbOm3daYCSkfywsivNfnQyYmnFrWQUJcsb1ts/KjjqQGBhkXMnOBpHjspmZZ8pQ5y6J46eRLKojvTCt+HVz1LTo3ozLbfVip/fGzaFXUSJP+Yx12wvEsvXwPeLtJmowtfdcW8bxofk42J32gHoN73O0cLQqBiKd/56kAS6GBg4BhwkiKqrg+ZEpG1sdVmmf38FYh8yv48CX/EdtOTW0Mtpz1ViEij334UQSDKgmIQBBmn2DMrmjqsCc8fKSmZKT0dYY1NjIKPe+zhViUpa1gBONQUs7O53tjlpZYi46f/FyT4VyX7VsI7TxGqSRxfU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F65EFE02558FA4A93E58013D0F50ADD@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9ead6c-533d-4b39-5630-08d714563200
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 18:54:33.8333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pburton@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1101
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Denis,

On Mon, Jul 29, 2019 at 01:13:59PM +0300, Denis Efremov wrote:
> The function pci_resource_to_user() was turned to a weak one. Thus,
> mips-specific version will automatically override the generic one
> and the HAVE_ARCH_PCI_RESOURCE_TO_USER macro should be removed.
>=20
> Signed-off-by: Denis Efremov <efremov@linux.com>

Assuming this is the way Bjorn wants to go:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

> ---
>  arch/mips/include/asm/pci.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> index 436099883022..6f48649201c5 100644
> --- a/arch/mips/include/asm/pci.h
> +++ b/arch/mips/include/asm/pci.h
> @@ -108,7 +108,6 @@ extern unsigned long PCIBIOS_MIN_MEM;
> =20
>  #define HAVE_PCI_MMAP
>  #define ARCH_GENERIC_PCI_MMAP_RESOURCE
> -#define HAVE_ARCH_PCI_RESOURCE_TO_USER
> =20
>  /*
>   * Dynamic DMA mapping stuff.
> --=20
> 2.21.0
>=20
