Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCA77197D99
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 15:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgC3Nyk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 09:54:40 -0400
Received: from mail-bn7nam10on2063.outbound.protection.outlook.com ([40.107.92.63]:12128
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728682AbgC3Nyj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Mar 2020 09:54:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLhSz83uUsHd4FSCmPfHwRO6zTBSPqQWWMgbkbDtjgc9MtVfu/TC3t5i2Wgz0L8BDcNEe+vBKUS6jx0TYHi1GZrgUyDNJmGujYAYRpXYpkNkSHJ99EnCogIFPzbvGtFscACxeVFN/KdNK+EG6VaeyNd7ssOCylisK+OoXXzVk58jPK9zIZILf1Cn3j1CenpZqfbfX0PvNmJPD1togDS+qxmzIZWzeLMiBCiOxksT/NmVqmtMtMDvM1kSziECTfKn/kHZpMhNOkGPW5GhCAuC61/336mHzIBo9FzK58To4HpIVR8nticgR9Jki2eNW7EMYgP/OTMBjZSc0XaB2gbw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jGjBwBpXrBZNdgOTTyZXtvtR7BmhGbIrwK1Qp8fVVQ=;
 b=LB3BOXuCpMhLzb3g/p1yTPWotXXYqnp/G5XJUsrzl2O8kp5O+5esuprJgYBRi9Vdw3wfT1kbZsY3cgXbimica+pFw9bSOocTwrY7RfafcZ2gs3xwQWhn5bsLmjtjKL4x0E0/XDcGMY4WCoKbKEbm/uJUhMct5183KvP5PLe/6msB0c5XfQnZ613riKc7pqxUe4XR+r1C482p5ye5UKjrr2K152dEwIn0++Y9ag/kbVV/4LLHygxeu7bKCPsPiVMbszvPi4BvSoVdl7VflVIMFHyeQchrgetjvikkctCeJpi9dXUJaxsPC/i566OptSJIvYtmM2gcKU0OsdZryRhMAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jGjBwBpXrBZNdgOTTyZXtvtR7BmhGbIrwK1Qp8fVVQ=;
 b=nsCILOALPBu9auTXBZCoFS027prQjEg+9bjw7ZaEJY5P/8VBJ80qd2XK+tY18SPWlL6VmBxRnFFRc9+Wt2Vo3OqRun5sgTnpNJi5rCdIbi7ZyA++ZqCRy7klkTvILQMN17uOy5CZGZ4lX5i5UzsI2owi6wQuvfb793Q0CzFqviY=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3534.namprd12.prod.outlook.com (2603:10b6:208:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 13:54:34 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 13:54:34 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mikel Rychliski <mikel@mikelr.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ben Skeggs <bskeggs@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v3] PCI: Use ioremap(), not phys_to_virt() for platform
 ROM
Thread-Topic: [PATCH v3] PCI: Use ioremap(), not phys_to_virt() for platform
 ROM
Thread-Index: AQHV/ZSEXa++WpF4G0+TMX6npRIm9qhegQEAgAK44gA=
Date:   Mon, 30 Mar 2020 13:54:33 +0000
Message-ID: <MN2PR12MB4488EE5C6D38690716D658C6F7CB0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200319021623.5426-1-mikel@mikelr.com>
 <20200328201846.GA108818@google.com>
In-Reply-To: <20200328201846.GA108818@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-30T13:53:06Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fb57106f-6fb8-4cd8-a096-000017c3a580;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-03-30T13:54:31Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: aa36f77c-f33e-4839-bc25-0000b22087d1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d85b311a-ef21-4011-91f0-08d7d4b1e0d0
x-ms-traffictypediagnostic: MN2PR12MB3534:|MN2PR12MB3534:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3534CF9615A13FB00F9CEC62F7CB0@MN2PR12MB3534.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(52536014)(54906003)(110136005)(316002)(4326008)(66446008)(478600001)(66946007)(64756008)(55016002)(9686003)(86362001)(66556008)(66476007)(8676002)(81156014)(81166006)(8936002)(71200400001)(33656002)(26005)(53546011)(7696005)(6506007)(76116006)(186003)(5660300002)(2906002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YSq8DUO6Xoj74WMnbmvhmlkl/p7Xgn1CWXnbGOiea4++K14wHaM+H+MQYyqfPvUAoOWkjtN6t5nHQJmkeoVbLsGEF5kmOCGzpjZKnl3Fg74dljQDLeQRBQEvgze/o+5RTs7Dp4y/9kVcnz3GgW0v+wLd3mcBj+1Gy105BBKgmbZyXAoq5iSXjko252YCpGHQFeH3c9NqxB41E5pwddrjH9IbdoO89RyZ2USkAdF8+d6inDrdZiaycCmc+5BOvklV1TIJ/Rm7SY7ck4ZoyOawr51D5ZfOZ7bSmBt/y/Sq5qPuYko9ZAJ7j0tA4jOQUxPB6Tjfvsn81pj1yYnQD8Vm7FlHnlYSsT25K63+68tOV5NtWtnnoDaAs3id2m+nW623BwWirhKq+UB2qZ0v8hs69fBosvj4mMoJYKN3VPCpk0U0DTOoMxDxuOkVZFeulTV/
x-ms-exchange-antispam-messagedata: CXnjfi2p3+8S2UfmpZJWKyv0cFRT93glDQmTex2KmCCrFW/2jQ0/FTM6QTTuFWVukdkl81tPGoTT1IZUMgM2SH9SsyfeNlfGm1Oa94CE1axZhZzELEHojcyV/TqSYNZ6R4HH9abLCts/gtuSoxiPCA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85b311a-ef21-4011-91f0-08d7d4b1e0d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 13:54:34.0298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CxlovOedDOmDuPvYdAX1g9NGoxznCmyYNVnS0eRqeR4wQiKrN9SFU29ExiKQUYQkS0Cq9lYnS5/VDSdhVHKTfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3534
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Saturday, March 28, 2020 4:19 PM
> To: Mikel Rychliski <mikel@mikelr.com>
> Cc: amd-gfx@lists.freedesktop.org; linux-pci@vger.kernel.org;
> nouveau@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> <David1.Zhou@amd.com>; Matthew Garrett
> <matthewgarrett@google.com>; Ben Skeggs <bskeggs@redhat.com>;
> Christoph Hellwig <hch@lst.de>
> Subject: Re: [PATCH v3] PCI: Use ioremap(), not phys_to_virt() for platfo=
rm
> ROM
>=20
> On Wed, Mar 18, 2020 at 10:16:23PM -0400, Mikel Rychliski wrote:
> > On some EFI systems, the video BIOS is provided by the EFI firmware.
> > The boot stub code stores the physical address of the ROM image in pdev=
-
> >rom.
> > Currently we attempt to access this pointer using phys_to_virt(),
> > which doesn't work with CONFIG_HIGHMEM.
> >
> > On these systems, attempting to load the radeon module on a x86_32
> > kernel can result in the following:
> >
> >     BUG: unable to handle page fault for address: 3e8ed03c
> >     #PF: supervisor read access in kernel mode
> >     #PF: error_code(0x0000) - not-present page
> >     *pde =3D 00000000
> >     Oops: 0000 [#1] PREEMPT SMP
> >     CPU: 0 PID: 317 Comm: systemd-udevd Not tainted 5.6.0-rc3-next-
> 20200228 #2
> >     Hardware name: Apple Computer, Inc. MacPro1,1/Mac-F4208DC8, BIOS
> MP11.88Z.005C.B08.0707021221 07/02/07
> >     EIP: radeon_get_bios+0x5ed/0xe50 [radeon]
> >     Code: 00 00 84 c0 0f 85 12 fd ff ff c7 87 64 01 00 00 00 00 00 00 8=
b 47 08 8b
> 55 b0 e8 1e 83 e1 d6 85 c0 74 1a 8b 55 c0 85 d2 74 13 <80> 38 55 75 0e 80=
 78 01
> aa 0f 84 a4 03 00 00 8d 74 26 00 68 dc 06
> >     EAX: 3e8ed03c EBX: 00000000 ECX: 3e8ed03c EDX: 00010000
> >     ESI: 00040000 EDI: eec04000 EBP: eef3fc60 ESP: eef3fbe0
> >     DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010206
> >     CR0: 80050033 CR2: 3e8ed03c CR3: 2ec77000 CR4: 000006d0
> >     Call Trace:
> >      ? register_client+0x34/0xe0
> >      ? register_client+0xab/0xe0
> >      r520_init+0x26/0x240 [radeon]
> >      radeon_device_init+0x533/0xa50 [radeon]
> >      radeon_driver_load_kms+0x80/0x220 [radeon]
> >      drm_dev_register+0xa7/0x180 [drm]
> >      radeon_pci_probe+0x10f/0x1a0 [radeon]
> >      pci_device_probe+0xd4/0x140
> >      really_probe+0x13d/0x3b0
> >      driver_probe_device+0x56/0xd0
> >      device_driver_attach+0x49/0x50
> >      __driver_attach+0x79/0x130
> >      ? device_driver_attach+0x50/0x50
> >      bus_for_each_dev+0x5b/0xa0
> >      driver_attach+0x19/0x20
> >      ? device_driver_attach+0x50/0x50
> >      bus_add_driver+0x117/0x1d0
> >      ? pci_bus_num_vf+0x20/0x20
> >      driver_register+0x66/0xb0
> >      ? 0xf80f4000
> >      __pci_register_driver+0x3d/0x40
> >      radeon_init+0x82/0x1000 [radeon]
> >      do_one_initcall+0x42/0x200
> >      ? kvfree+0x25/0x30
> >      ? __vunmap+0x206/0x230
> >      ? kmem_cache_alloc_trace+0x16f/0x220
> >      ? do_init_module+0x21/0x220
> >      do_init_module+0x50/0x220
> >      load_module+0x1f26/0x2200
> >      sys_init_module+0x12d/0x160
> >      do_fast_syscall_32+0x82/0x250
> >      entry_SYSENTER_32+0xa5/0xf8
> >
> > Fix the issue by updating all drivers which can access a platform
> > provided ROM. Instead of calling the helper function
> > pci_platform_rom() which uses phys_to_virt(), call ioremap() directly o=
n
> the pdev->rom.
> >
> > radeon_read_platform_bios() previously directly accessed an __iomem
> > pointer. Avoid this by calling memcpy_fromio() instead of kmemdup().
> >
> > pci_platform_rom() now has no remaining callers, so remove it.
> >
> > Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
>=20
> I applied this to pci/resource for v5.7.  I would feel better if some of =
the
> graphics guys chimed in, or even applied it via the DRM tree since most o=
f the
> changes are actually in drivers/gpu.

Feel free to take it through the PCI tree.  These areas of radeon and amdgp=
u don't really change much at all so, I'm not too concerned about a conflic=
t.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>=20
> Feel free to add my
>=20
>   Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> and let me know if you do that.
>=20
> > ---
> >
> > Tested on a MacPro 1,1 with a Radeon X1900 XT card and 32-bit kernel.
> >
> > Changes in v3:
> >  - Inline pci_platform_rom()
> >
> > Changes in v2:
> >  - Add iounmap() call in nouveau
> >  - Update function comment for pci_platform_rom()
> >  - Minor changes to commit messages
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           | 31
> +++++++++++++---------
> >  .../gpu/drm/nouveau/nvkm/subdev/bios/shadowpci.c   | 17 ++++++++++-
> -
> >  drivers/gpu/drm/radeon/radeon_bios.c               | 30 +++++++++++++-=
------
> -
> >  drivers/pci/rom.c                                  | 17 ------------
> >  include/linux/pci.h                                |  1 -
> >  5 files changed, 52 insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > index 50dff69a0f6e..b1172d93c99c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > @@ -192,30 +192,35 @@ static bool amdgpu_read_bios_from_rom(struct
> > amdgpu_device *adev)
> >
> >  static bool amdgpu_read_platform_bios(struct amdgpu_device *adev)  {
> > -	uint8_t __iomem *bios;
> > -	size_t size;
> > +	phys_addr_t rom =3D adev->pdev->rom;
> > +	size_t romlen =3D adev->pdev->romlen;
> > +	void __iomem *bios;
> >
> >  	adev->bios =3D NULL;
> >
> > -	bios =3D pci_platform_rom(adev->pdev, &size);
> > -	if (!bios) {
> > +	if (!rom || romlen =3D=3D 0)
> >  		return false;
> > -	}
> >
> > -	adev->bios =3D kzalloc(size, GFP_KERNEL);
> > -	if (adev->bios =3D=3D NULL)
> > +	adev->bios =3D kzalloc(romlen, GFP_KERNEL);
> > +	if (!adev->bios)
> >  		return false;
> >
> > -	memcpy_fromio(adev->bios, bios, size);
> > +	bios =3D ioremap(rom, romlen);
> > +	if (!bios)
> > +		goto free_bios;
> >
> > -	if (!check_atom_bios(adev->bios, size)) {
> > -		kfree(adev->bios);
> > -		return false;
> > -	}
> > +	memcpy_fromio(adev->bios, bios, romlen);
> > +	iounmap(bios);
> >
> > -	adev->bios_size =3D size;
> > +	if (!check_atom_bios(adev->bios, romlen))
> > +		goto free_bios;
> > +
> > +	adev->bios_size =3D romlen;
> >
> >  	return true;
> > +free_bios:
> > +	kfree(adev->bios);
> > +	return false;
> >  }
> >
> >  #ifdef CONFIG_ACPI
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowpci.c
> > b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowpci.c
> > index 9b91da09dc5f..8d9812a51ef6 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowpci.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowpci.c
> > @@ -101,9 +101,13 @@ platform_init(struct nvkm_bios *bios, const char
> *name)
> >  	else
> >  		return ERR_PTR(-ENODEV);
> >
> > +	if (!pdev->rom || pdev->romlen =3D=3D 0)
> > +		return ERR_PTR(-ENODEV);
> > +
> >  	if ((priv =3D kmalloc(sizeof(*priv), GFP_KERNEL))) {
> > +		priv->size =3D pdev->romlen;
> >  		if (ret =3D -ENODEV,
> > -		    (priv->rom =3D pci_platform_rom(pdev, &priv->size)))
> > +		    (priv->rom =3D ioremap(pdev->rom, pdev->romlen)))
> >  			return priv;
> >  		kfree(priv);
> >  	}
> > @@ -111,11 +115,20 @@ platform_init(struct nvkm_bios *bios, const char
> *name)
> >  	return ERR_PTR(ret);
> >  }
> >
> > +static void
> > +platform_fini(void *data)
> > +{
> > +	struct priv *priv =3D data;
> > +
> > +	iounmap(priv->rom);
> > +	kfree(priv);
> > +}
> > +
> >  const struct nvbios_source
> >  nvbios_platform =3D {
> >  	.name =3D "PLATFORM",
> >  	.init =3D platform_init,
> > -	.fini =3D (void(*)(void *))kfree,
> > +	.fini =3D platform_fini,
> >  	.read =3D pcirom_read,
> >  	.rw =3D true,
> >  };
> > diff --git a/drivers/gpu/drm/radeon/radeon_bios.c
> > b/drivers/gpu/drm/radeon/radeon_bios.c
> > index c42f73fad3e3..bb29cf02974d 100644
> > --- a/drivers/gpu/drm/radeon/radeon_bios.c
> > +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> > @@ -108,25 +108,33 @@ static bool radeon_read_bios(struct
> > radeon_device *rdev)
> >
> >  static bool radeon_read_platform_bios(struct radeon_device *rdev)  {
> > -	uint8_t __iomem *bios;
> > -	size_t size;
> > +	phys_addr_t rom =3D rdev->pdev->rom;
> > +	size_t romlen =3D rdev->pdev->romlen;
> > +	void __iomem *bios;
> >
> >  	rdev->bios =3D NULL;
> >
> > -	bios =3D pci_platform_rom(rdev->pdev, &size);
> > -	if (!bios) {
> > +	if (!rom || romlen =3D=3D 0)
> >  		return false;
> > -	}
> >
> > -	if (size =3D=3D 0 || bios[0] !=3D 0x55 || bios[1] !=3D 0xaa) {
> > +	rdev->bios =3D kzalloc(romlen, GFP_KERNEL);
> > +	if (!rdev->bios)
> >  		return false;
> > -	}
> > -	rdev->bios =3D kmemdup(bios, size, GFP_KERNEL);
> > -	if (rdev->bios =3D=3D NULL) {
> > -		return false;
> > -	}
> > +
> > +	bios =3D ioremap(rom, romlen);
> > +	if (!bios)
> > +		goto free_bios;
> > +
> > +	memcpy_fromio(rdev->bios, bios, romlen);
> > +	iounmap(bios);
> > +
> > +	if (rdev->bios[0] !=3D 0x55 || rdev->bios[1] !=3D 0xaa)
> > +		goto free_bios;
> >
> >  	return true;
> > +free_bios:
> > +	kfree(rdev->bios);
> > +	return false;
> >  }
> >
> >  #ifdef CONFIG_ACPI
> > diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c index
> > 137bf0cee897..8fc9a4e911e3 100644
> > --- a/drivers/pci/rom.c
> > +++ b/drivers/pci/rom.c
> > @@ -195,20 +195,3 @@ void pci_unmap_rom(struct pci_dev *pdev, void
> __iomem *rom)
> >  		pci_disable_rom(pdev);
> >  }
> >  EXPORT_SYMBOL(pci_unmap_rom);
> > -
> > -/**
> > - * pci_platform_rom - provides a pointer to any ROM image provided by
> > the
> > - * platform
> > - * @pdev: pointer to pci device struct
> > - * @size: pointer to receive size of pci window over ROM
> > - */
> > -void __iomem *pci_platform_rom(struct pci_dev *pdev, size_t *size) -{
> > -	if (pdev->rom && pdev->romlen) {
> > -		*size =3D pdev->romlen;
> > -		return phys_to_virt((phys_addr_t)pdev->rom);
> > -	}
> > -
> > -	return NULL;
> > -}
> > -EXPORT_SYMBOL(pci_platform_rom);
> > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > 3840a541a9de..7268dcf1f23e 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1214,7 +1214,6 @@ int pci_enable_rom(struct pci_dev *pdev);  void
> > pci_disable_rom(struct pci_dev *pdev);  void __iomem __must_check
> > *pci_map_rom(struct pci_dev *pdev, size_t *size);  void
> > pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom); -void
> __iomem
> > __must_check *pci_platform_rom(struct pci_dev *pdev, size_t *size);
> >
> >  /* Power management related routines */  int pci_save_state(struct
> > pci_dev *dev);
> > --
> > 2.13.7
> >
