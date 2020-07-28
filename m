Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCF8230C89
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 16:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgG1Ohn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 10:37:43 -0400
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:17248
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730391AbgG1Ohn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 10:37:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5k2RJY3CYkrzuavObtlSw8FqGOZESNu7xcEABNHUmY2koC3lcWhGrMTwUy9WEU7eK5TokwZ44Tmnqu/jwesZSpHXO1/h/kml/BJ1lVdhMncDJdpZyFSC5m0Cjbn94VZoYANmeND8cIxRG26w75NQ2Ksq9qFMdExUGTDqPjbSgFogPTaZ15KUNp2Is8g+rXZ4JB/Tk9XZPm9Q1sFg6R6oYCVmsUOp0btcthRew46+2CiYeQtsT/XDYxWL1UdAzRdpJaYPRT0tfUPjYZWnbCLauGEilaTetX90pRx8jk8sHDOywERJ9arXkakXfNIqzV6nNgZfImsxNOL7+lGUSQFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhDnT8WLpIfKzWjUoAiLrYhokyNDSLQXniYCvoA0+MM=;
 b=QdLV2XfxHlmJ4+MghPKrTA/UBDic+E5CNNVNHF6jz5ca/Eqg9cUT0i4smZONgk6Tm6/ZV4dqtxLUKDoTasurj5GXYoRVAJQTu7yZX4VlKEu2RQ5ButSaIyLrzhbVDHCA7xLGtlEwqxwW6arJgyHitmc5vrTQrDD5Ut02Xusz7FK+dDnulsO01Ng19ouZbjUao8/bq9H/LYwq7uTQY6ljp8x5SVsbDQG/szYCxB4Y9/joO3Ly50RJGJvr/6UtxgKMqCdck098z6ImVIIO/qCtYlmBLdbEMauxhSmbZnzoZCW3zN/WnCYkKfwKFK9j+PqAndTnsuXJKgC1xCQ5JRnR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhDnT8WLpIfKzWjUoAiLrYhokyNDSLQXniYCvoA0+MM=;
 b=qF+dNCiqSLBhEuQIQojA520tdB4TtIlZl3s1u6/9W4uEIFX0GTIbGiyIXsbBgJ6KOYCMZDjpCqK4f11xbaVZzAP9NrEWouMIfYcR4RyvwJivLl/12x0/lPAtbL7V+VQTWohVUZKDGcdHAlZss1ndyDF2Udt4eLPm8q9K4oVIk20=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 14:37:40 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b08f:7a26:ea10:c9d4]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b08f:7a26:ea10:c9d4%8]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 14:37:40 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: Mark AMD Navi10 GPU rev 0x00 ATS as broken
Thread-Topic: [PATCH] PCI: Mark AMD Navi10 GPU rev 0x00 ATS as broken
Thread-Index: AQHWZMxMAafWMs3FREKZkC6ipKIXjKkdDpCg
Date:   Tue, 28 Jul 2020 14:37:40 +0000
Message-ID: <MN2PR12MB4488EEF653047300F2D68892F7730@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200728104554.28927-1-kai.heng.feng@canonical.com>
In-Reply-To: <20200728104554.28927-1-kai.heng.feng@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-28T14:33:43Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=07642590-b2dc-4537-b2f1-0000f2cb59a1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-28T14:37:36Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d78dd8dc-a7e1-42b7-8a71-0000c2273f39
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf873e88-cad0-4934-1ed6-08d83303c7db
x-ms-traffictypediagnostic: MN2PR12MB4189:
x-microsoft-antispam-prvs: <MN2PR12MB4189565BB553E30F0D8E1AF7F7730@MN2PR12MB4189.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QAwAqavHjpu2l9Tq68JtdDdHIhzYeQ8T8jpRRh52xt4Jk53S0TYyDHZtGLhO8g0k/l2eHDIigb2TQ5gRlOFpQepLwv82YV8UHcVE7MIX7ClevluFVA5PZOsI8dCL+hzNXzM6rcUGmTHyVloyeeHqU37vajgPb0WGn4SL5ZhGp66H8yh9A2ggq4ixVJrbActpFLg5WW4n94kclW+3GmVx3WRyPk0m0n6onXMJfSjpMrhMxEy3ZBbQy7NZhh/8VsWWsuo0eXM8rVQt2R0Wfkp5WS0zWppv9vm7+pgG+I784Pvu7bjkA1Qn2Qi0qlYz2auckMAjn9/dzBDsdrJb59UTZHi62aqjPopxcOwbEbMclo5kVKFnuCP89RP2VBQwJ3p8UsXoGTO1UU3CAaRdPUhsGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(83380400001)(45080400002)(86362001)(83080400001)(316002)(966005)(478600001)(53546011)(6506007)(9686003)(7696005)(8936002)(8676002)(26005)(5660300002)(55016002)(186003)(66946007)(64756008)(2906002)(110136005)(33656002)(71200400001)(4326008)(66446008)(76116006)(54906003)(66476007)(66556008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qIrN7hXdOuOqMisbQwd2/yJfmIAOTwcQDdOVsqxLkbK7fQqmBGIBnMOGY+YQQpkKeRTXKjen+EN4yJgo29FZiTEMIb4fwHD7a/H/dT+nggEnB7erRQi6vnc3yYvM96pPBd+3F8dFCrgWHbSf2yFuHz4nNkAPPTiGdBFwmSQBiFfJAOsw7xxRMPO1+azaFCjf0bbflXGT4PpeLmHHKWbWCoxtS4IV8buRKtY5j6kmAh27Q10vdVh8FkB26IQdZX5Wm4puBkLpsgr7k+Cm1y8Mk7PYQ1c3+yXnMXMvqhD3abfrvaLAcehcs6Xa9EoiiUZ0UiMyrl5Dtog1/nna99ZmDhIu1I/Pl9iDcAcNItgBoh+gNF5Y4r3+x0wrcj9dltGPsi2msoXC0TbR6IZ6XtGrcpIX7fAGcOF/14IOOSC7S8V4XFVwWOBgk1q1cNvaz4JqIXmYTbTQ1E7f9z04tXsg30/IHAwMQ52SZTpLzhN4/Een3gz2tp+8SD2m1GX1zTUu
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf873e88-cad0-4934-1ed6-08d83303c7db
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 14:37:40.2814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKPG/bsneCGXua5tlinbvur7yc+gWXdjhe5iPXBN92OKSH3E60r+4sp7lrrLRzyuy8ni4OoD16ensVpjsypxUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Tuesday, July 28, 2020 6:46 AM
> To: bhelgaas@google.com
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; open list:PCI SUBSYSTEM <linux-
> pci@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: [PATCH] PCI: Mark AMD Navi10 GPU rev 0x00 ATS as broken
>=20
> We are seeing AMD Radeon Pro W5700 doesn't work when IOMMU is
> enabled:
> [    3.375841] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> device=3D63:00.0 address=3D0x42b5b01a0]
> [    3.375845] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> device=3D63:00.0 address=3D0x42b5b01c0]
>=20
> The error also makes graphics driver fail to probe the device.
>=20
> It appears to be the same issue as commit 5e89cd303e3a ("PCI: Mark AMD
> Navi14 GPU rev 0xc5 ATS as broken") addresses, and indeed the same ATS
> quirk can workaround the issue.
>=20
> Bugzilla:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D208725&amp;data=3D02%7C01%7Cal
> exander.deucher%40amd.com%7Cbb49d8e71c29459d631a08d832e36d56%7
> C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637315299664339358&
> amp;sdata=3DSUAXEIoIJfgTm54FmgwUCMUI%2Bk2qWNcvSpvpU09Ak5k%3D&
> amp;reserved=3D0
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

This was fixed in the vbios, but apparently that didn't make it out to ever=
yone.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/pci/quirks.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> 812bfc32ecb8..052efeb9f053 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5192,7 +5192,8 @@
> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422,
> quirk_no_ext_tags);
>   */
>  static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)  {
> -	if (pdev->device =3D=3D 0x7340 && pdev->revision !=3D 0xc5)
> +	if ((pdev->device =3D=3D 0x7312 && pdev->revision !=3D 0x00) ||
> +	    (pdev->device =3D=3D 0x7340 && pdev->revision !=3D 0xc5))
>  		return;
>=20
>  	pci_info(pdev, "disabling ATS\n");
> @@ -5203,6 +5204,8 @@ static void quirk_amd_harvest_no_ats(struct
> pci_dev *pdev)  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4,
> quirk_amd_harvest_no_ats);
>  /* AMD Iceland dGPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900,
> quirk_amd_harvest_no_ats);
> +/* AMD Navi10 dGPU */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312,
> +quirk_amd_harvest_no_ats);
>  /* AMD Navi14 dGPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340,
> quirk_amd_harvest_no_ats);  #endif /* CONFIG_PCI_ATS */
> --
> 2.17.1
