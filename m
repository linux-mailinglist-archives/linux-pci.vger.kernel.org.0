Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 800DA13C4EE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 15:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgAOOIH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 09:08:07 -0500
Received: from mail-bn8nam11on2057.outbound.protection.outlook.com ([40.107.236.57]:35265
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726501AbgAOOIG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 09:08:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUoSBEll0IGLZkC+XZgnxbJ7zuWN2r2Hu6ALP9MGKsFklO+vQ2I3ZcPyz0iNUrHsJ0g6JqK+hN2R77caIJIp1eZeKT4GnVzMI2MI7Rj7u1egKxd+EMYGcwS6UCn+nxZ0mMPCO3qD/zc8tc7hjWrJChQ75K0dcYK5jpAqrm81LFQn8PeItqaVeNAXWC72BRzHf7gRcmG5KFWy86MSc0vZTLrLrTHRtc8BGwcCrvI3rnppUCaO0BCkEpS8Tiqo6MyeRI680JNXIJHG+Vmq/KuXONimKysXORkUUkBM+78yXYkh9qK6tETPEHueUPU+7M4fNBqGNyLqjRUJnNyPk7XD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5oIwdf5wwQROJteWmz+7ZHjWICHe0DuH2XoWzMT27M=;
 b=aSQm61z6HUfNVgGdipfSdg5hHRtzU6ybwKDCJWtkKtVaa10f6ri21ab+mKExY+PJOQFv/Qv+hE/swRIMsOG7JYkNul+QZmZ3ab9Se1ZdSM8PntpCOY+sVJTQTemQfM2Gn1FKXVQrl60WhQt57DfALaKTVzsp/0TjKBAqlibuaGOrpYcNdJelP9eAjaHTueHtj/S6kkFQAhgm96Hv2xiQDp7U2IaqZZwqr2ZahmGNU+8zIA1lFzdYi6z3t7AT85URnyW2+2sgXlNxFNGYdXHS4VFb5xD+0msRSGh9R1I7i7JU+x9e0UtJzZJkDdebYEccibnj8JTjsSFulGxvJqVYFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5oIwdf5wwQROJteWmz+7ZHjWICHe0DuH2XoWzMT27M=;
 b=cNJSefpfZY84ebmwG7R5dXbICB/ULCODBQuSuQRLuOwiEEHEvUA6quGPejHjktOqczbL21u6BOdka2YPwX8Qnz4NLw/aEps2PsJvLJyLTwxMTgUyE8nWM4Okp8pvIaZ4tCB3n+0hdyDztN8iYhtxIObXNfBdliCXkvdbFDicI2w=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (52.132.246.86) by
 CH2SPR01MB0010.namprd12.prod.outlook.com (10.141.106.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 15 Jan 2020 14:08:02 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::35e4:f61:8c42:333d]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::35e4:f61:8c42:333d%6]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 14:08:02 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 0/2] Adjust AMD GPU ATS quirks
Thread-Topic: [PATCH 0/2] Adjust AMD GPU ATS quirks
Thread-Index: AQHVyxz5e3deHIakDEi7MiGaUbFZUKfq0iEAgADxxQA=
Date:   Wed, 15 Jan 2020 14:08:02 +0000
Message-ID: <CH2PR12MB39124307C111836194A81A24F7370@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200114205523.1054271-1-alexander.deucher@amd.com>
 <20200114234144.GA56595@google.com>
In-Reply-To: <20200114234144.GA56595@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-15T14:07:07Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=18597a2d-2cd7-48ac-8a7d-000016ca9683;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-15T14:07:59Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 587b2447-fb88-497e-a2bc-00009b2cf3c9
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 950ef82c-b24b-4acc-a9ee-08d799c455b6
x-ms-traffictypediagnostic: CH2SPR01MB0010:
x-microsoft-antispam-prvs: <CH2SPR01MB0010A9BE041B81FBB97E0F0BF7370@CH2SPR01MB0010.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(366004)(189003)(199004)(498600001)(6506007)(53546011)(4326008)(966005)(8936002)(2906002)(45080400002)(76116006)(186003)(66946007)(110136005)(7696005)(8676002)(71200400001)(86362001)(5660300002)(66556008)(64756008)(55016002)(9686003)(81156014)(52536014)(81166006)(33656002)(54906003)(26005)(66446008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2SPR01MB0010;H:CH2PR12MB3912.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ht4D3EEZSdtsLSCU6Y11Enl6B3xHbm+0hfz2qcnPvEMG6xc0AvkheX2/Yz9taRy0yCWPiOeAL9mLXDg91zLo3wg4NFgWBaUhIZNe4fODEO0yfa4zlabgY3COeoo600cP0SCisrl7OwbDL9PeG/ajawIDpBI6h3YZVi/EE9urHMBUKvwY7GoW+T+mBmFvonY/T5oyQEL3G7oFnWu9jKmf/cQN3kChLkZ+AlBWiLJzl8SDN65rdnBWqLPw+csQbCDUJoNjkWWUXWMxK4Taa7cID/XUrfBzXM66/YxXN02L0mUcn95IkUxBCJhD6zPfyVBrOSn4F8Yd1/X1BYBd6FDDt15z69g9LRXJiCTBJtsubVy5DxRf/6HK6IFtRW4/ZX++9kpiDGZdP0Z+0MRT2F4YiJqJQ5tVuQKViQU9R7cXcvxMyHQBILJyPRV8zyBkbEAOk15jiDgANjO2iJyGSJ53IuPxACyhr3zQZXHo1Ql24eIUMpc+v6KE6up7EtAiQYzjJRldZVCRwGwHQvNmDJe5AuZmLJWjiBKC4tEeyVGjYhZ2IyEmKHZ7spDzGPP62PfDMpC5M4ZqIMuaxOrILD+RHw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950ef82c-b24b-4acc-a9ee-08d799c455b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 14:08:02.5239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJhxdxb0hFXcL+gLH0VPB+f4H2RtjxCHQP0H65Tmf4r6Fm9tcp7jbfSvjPAF+tIFVAM3B4iJ/g60TiG2PFY/fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2SPR01MB0010
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, January 14, 2020 6:42 PM
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org; linux-pci@vger.kernel.org; Deucher,
> Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 0/2] Adjust AMD GPU ATS quirks
>=20
> On Tue, Jan 14, 2020 at 03:55:21PM -0500, Alex Deucher wrote:
> > We've root caused the issue and clarified the quirk.
> > This also adds a new quirk for a new GPU.
> >
> > Alex Deucher (2):
> >   pci: Clarify ATS quirk
> >   pci: add ATS quirk for navi14 board (v2)
> >
> >  drivers/pci/quirks.c | 32 +++++++++++++++++++++++++-------
> >  1 file changed, 25 insertions(+), 7 deletions(-)
>=20
> I propose the following, which I intend to be functionally identical.
> It just doesn't repeat the pci_info() and pdev->ats_cap =3D 0.
>=20

Works for me.  Thanks!

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> commit 998c4f7975b0 ("PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Jan 14 17:09:28 2020 -0600
>=20
>     PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken
>=20
>     To account for parts of the chip that are "harvested" (disabled) due =
to
>     silicon flaws, caches on some AMD GPUs must be initialized before ATS=
 is
>     enabled.
>=20
>     ATS is normally enabled by the IOMMU driver before the GPU driver loa=
ds,
> so
>     this cache initialization would have to be done in a quirk, but that'=
s too
>     complex to be practical.
>=20
>     For Navi14 (device ID 0x7340), this initialization is done by the VBI=
OS,
>     but apparently some boards went to production with an older VBIOS tha=
t
>     doesn't do it.  Disable ATS for those boards.
>=20
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fr%2F20200114205523.1054271-3-
> alexander.deucher%40amd.com&amp;data=3D02%7C01%7Calexander.deucher
> %40amd.com%7C7bbf2f086ba64a68891e08d7994b5216%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637146421098328112&amp;sdata=3DaLaNuiJ
> pB4dYatxvBJuC%2Blk90Dhl4qd5jvLp75ZUDns%3D&amp;reserved=3D0
>     Bug:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2Fissues%2F1015&amp;data=3D02%7C01%
> 7Calexander.deucher%40amd.com%7C7bbf2f086ba64a68891e08d7994b5216
> %7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63714642109832811
> 2&amp;sdata=3DQgCFuWKp8Dg3lpQhXCb2z4qmukdqkiX0e3%2BRz%2FcPkg0%3
> D&amp;reserved=3D0
>     See-also: d28ca864c493 ("PCI: Mark AMD Stoney Radeon R7 GPU ATS as
> broken")
>     See-also: 9b44b0b09dec ("PCI: Mark AMD Stoney GPU ATS as broken")
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> 4937a088d7d8..fbeb9f73ef28 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5074,18 +5074,25 @@
> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422,
> quirk_no_ext_tags);
>=20
>  #ifdef CONFIG_PCI_ATS
>  /*
> - * Some devices have a broken ATS implementation causing IOMMU stalls.
> - * Don't use ATS for those devices.
> + * Some devices require additional driver setup to enable ATS.  Don't
> + use
> + * ATS for those devices as ATS will be enabled before the driver has
> + had a
> + * chance to load and configure the device.
>   */
> -static void quirk_no_ats(struct pci_dev *pdev)
> +static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
>  {
> -	pci_info(pdev, "disabling ATS (broken on this device)\n");
> +	if (pdev->device =3D=3D 0x7340 && pdev->revision !=3D 0xc5)
> +		return;
> +
> +	pci_info(pdev, "disabling ATS\n");
>  	pdev->ats_cap =3D 0;
>  }
>=20
>  /* AMD Stoney platform GPU */
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats); -
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4,
> +quirk_amd_harvest_no_ats);
> +/* AMD Iceland dGPU */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900,
> +quirk_amd_harvest_no_ats);
> +/* AMD Navi14 dGPU */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340,
> +quirk_amd_harvest_no_ats);
>  #endif /* CONFIG_PCI_ATS */
>=20
>  /* Freescale PCIe doesn't support MSI in RC mode */
