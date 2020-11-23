Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECEB2C1730
	for <lists+linux-pci@lfdr.de>; Mon, 23 Nov 2020 22:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgKWVES (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Nov 2020 16:04:18 -0500
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:20832
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727847AbgKWVER (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Nov 2020 16:04:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD/ij7now6ki1oIzUtdHsiXB++Szp2Ps7ROOvxfGY+q883b03zMLoS8B8q3wN7sOyiY6surGxMdn1FqVaGt7PQvHYTZsqx76Hlde+lGo3S3oLmEN2Hzu7WglwBwOGeE3jbccNMl4qTBSgVvJCIx7yeEQNMnfPs+x30SS/iqfYbLE4HtukkdGmHO34AAFGTU+29sqRarc+EiiNgNc1YdEkcrEbbRrpkS13jbXakE63rg7Swo6cD2uqPwYuEm4BFIYUvFgUMCygC7IdhgNjKf4AzdWhklAJRQRwMM8yrT0JuAZGAObPiiSI1bWgQEPJRySOL/xF4PfE5nPaJ4MewmRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnwQ/N+t+0CBDMWOY2zVCf6A7r2abgcuhd0m6rX5oL0=;
 b=IY96jZr7od22mTdQ+pKDYFabmZvGdKMEpmSMoRzOE/EUeJlpTuAeWSwNhQRO3RNB8ls3/g8ZfiXq/6AKfpDMnPkIrnQ40GisOfr8Xuh74vHyW9EPNKtSIf9BbES11xYVjBDjiJRO+7jYZH5Donw9iXp2zcjO13K4e7pw0CX8iv8ticW3YcOA5ks513pImh/wn0xUpcHmIMnr4hB7Ylz8dryBIvWqL32fhf7LZN3wI2IXF5R1Tel6t77zz7bCaig5tG09xr/+hZg8Vhgql0yvG/fP/oSFt4wGqfW9Wnb5/k2or6A0fKWM7UOKOyHjhHFqmkhNDgNjooOL5bVE4JTiRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnwQ/N+t+0CBDMWOY2zVCf6A7r2abgcuhd0m6rX5oL0=;
 b=gRIB2FphSBRp5vYN4b3bUmop8mGfiDo9CXwJF9IbR56eLBkoCLx+QtNkOTMarAeEQZQpznzB45+XvskPzECNBjrqDa/uJlJRrvuwGp3Y9d43J1iaT3bUfJect0PtqCbzayyuO222/nU4tpK7CuT6V6F7SvK/GqsTyBFFZaY5iCc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4584.namprd12.prod.outlook.com (2603:10b6:208:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Mon, 23 Nov
 2020 21:04:14 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%6]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 21:04:14 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Edgar Merger <Edgar.Merger@emerson.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Thread-Topic: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Thread-Index: AQHWwZ6+dZH+wAWtiUyhnWNLDE7tj6nWM/hw
Date:   Mon, 23 Nov 2020 21:04:14 +0000
Message-ID: <MN2PR12MB4488308D26DB50C18EA3BE0FF7FC0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201123134410.10648-1-will@kernel.org>
In-Reply-To: <20201123134410.10648-1-will@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-23T21:03:38Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=db3d5d7e-64b8-444f-8adc-0000f44ba9f6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-23T21:03:31Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5ea545a5-4adc-4408-aa01-0000d82026bd
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-23T21:04:10Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 604a5609-a6ee-47a5-9dc6-00005a2d8991
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab02af1e-2539-43f7-2867-08d88ff3557b
x-ms-traffictypediagnostic: MN2PR12MB4584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB45843C0B4F6B7B39E6D36F20F7FC0@MN2PR12MB4584.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OibVyQKJ/N2yBzn3btTNiQDgcv9mYy9/iXpe3+2ty4f5gHJadqiR8rrSHNC9ckuOgjWVIgSnGURy/7ip+q/80fcIhsZqZZkW4N9bsCUEhV7bLQlNRXxfeAom9hSXtWBuylQL30YZEsCPdHKOkajkcdz2WOy2P1OFwoOMYBN5tgIjLSzUH/LoVBpWGPw8gkV1T0MqnYIwJ8nPhZxKxeQ5d7daZYbiZFmZ4Zjwtk4P9YK5qwg/FDIOFfQ4pF4qoxBvr/Dq+0OYPos9S1dKzSUHmXvjYqYO7w3putktfZEXD5wcdHl04cPpYGJX5u7AB1Xj06lPYVL/jnx8j7TYJ1a8FAtPKB7xMCdGfPKa6dHKog9QALoRnH6m/aEGkCV+xf1CCbRDyrsYf795GweeCSPr4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(53546011)(186003)(26005)(2906002)(4326008)(8936002)(8676002)(71200400001)(478600001)(45080400002)(52536014)(55016002)(86362001)(9686003)(83380400001)(966005)(7696005)(110136005)(33656002)(66946007)(54906003)(66476007)(66556008)(66446008)(64756008)(76116006)(316002)(5660300002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VpN0SwX+J2CWoCO9zgqxMezJv0RPgB06mU/JARvCUkUT0aV4v21EdZLENpJt5VPW2O6V+yLQyoWY9K++qfcmLEYRZIuiJruyrGRbfgxyVCGXQUpIFEn3q4OZmeY2CLRMUSR9U2Euw8kTtPyM1k1ASNjpOAxDLb6cVwmmUApia88Qe/7KOO6rfRCS/pFwRk6uGcawmN8ne1W49Bq1Vpi6m5yxBYpYlwwbOncnDw4f7c1/BinO69GdxXMHJSUHBMJTzt3K46U6oJoKi+LVQjWTnUL68LZl7MF6tmTpAUUNyrJWZpymJfO9Io4KY91wM3XfmxU9qepT+Un4JSighSDgP61y9YTvxKTzwoVsi274reNuQLPmxxTytYIWZLwOWuzRXyIU3na4P+3hPzm2/IbG8aRksS82PTlqfJSXJCfgDC7sia84yhNGCjNt7GGTsd1CbrOsMleczqMEDpGsUH6BrOAEhd0Wz1DId7PJ1E6lJmXLt8WDuRnvqbA4myC7+tzhQILx/D9PSYsD7MmBTPD/8Ag78ZxrOdNuiPLaxBorhKk3dtyhP99AbhsZIa/1VwmOzwE0t+aYcPA2BdIw8TyfVfSrQxfpBJ2nltPAQ/gxttiDhWYRTeRHj+a9MyF8xSGodOsPSjXK/0N/gnoPh+6rOt285Enkm1Rl7KfThnP4Grznq4sw+PhLbiYWXL0DCrSx0FNl7NEY01bOZWdKAmivvkaQPEyxHvj6RdEeKvejtHeOMONLSY8pXGoE7qKPNH3XD2QYG1J32dYosrtmAKpJnCkoCK3G36y9bT8OxzmOoarqIRWm/XFiWsQdSDiF6bilL7VptaRUqCNfJxXCXnufPxEtOjA7qpfKHHs+lTbN5gb36z+ZTywnvve0u74t09F8Yv9OHyi41LULVrYgpQJhnw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab02af1e-2539-43f7-2867-08d88ff3557b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 21:04:14.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlQDhOupKDQUxrOfB4sLk/9/UZxSpe8DEpnEKcleFXLlEUWmzzDtEGpT34R1O5OYDZky1T9O1rbG2pK2vKEwZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4584
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: Monday, November 23, 2020 8:44 AM
> To: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org; iommu@lists.linux-foundation.org; Will
> Deacon <will@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Edgar Merger
> <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>
> Subject: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
>=20
> Edgar Merger reports that the AMD Raven GPU does not work reliably on his
> system when the IOMMU is enabled:
>=20
>   | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout,
> signaled seq=3D1, emitted seq=3D3
>   | [...]
>   | amdgpu 0000:0b:00.0: GPU reset begin!
>   | AMD-Vi: Completion-Wait loop timed out
>   | iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> device=3D0b:00.0 address=3D0x38edc0970]
>=20
> This is indicative of a hardware/platform configuration issue so, since
> disabling ATS has been shown to resolve the problem, add a quirk to match
> this particular device while Edgar follows-up with AMD for more informati=
on.
>=20
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reported-by: Edgar Merger <Edgar.Merger@emerson.com>
> Suggested-by: Joerg Roedel <jroedel@suse.de>
> Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Flinux-
> iommu%2FMWHPR10MB1310F042A30661D4158520B589FC0%40MWHPR10M
> B1310.namprd10.prod.outlook.com&amp;data=3D04%7C01%7Calexander.deuc
> her%40amd.com%7C1a883fe14d0c408e7d9508d88fb5df4e%7C3dd8961fe488
> 4e608e11a82d994e183d%7C0%7C0%7C637417358593629699%7CUnknown%7
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> LCJXVCI6Mn0%3D%7C1000&amp;sdata=3DTMgKldWzsX8XZ0l7q3%2BszDWXQJJ
> LOUfX5oGaoLN8n%2B8%3D&amp;reserved=3D0
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>=20
> Hi all,
>=20
> Since Joerg is away at the moment, I'm posting this to try to make some
> progress with the thread in the Link: tag.

+ Felix

What system is this?  Can you provide more details?  Does a sbios update fi=
x this?  Disabling ATS for all Ravens will break GPU compute for a lot of p=
eople.  I'd prefer to just black list this particular system (e.g., just SS=
IDs or revision) if possible.

Alex

>=20
> Cheers,
>=20
> Will
>=20
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> f70692ac79c5..3911b0ec57ba 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5176,6 +5176,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,
> 0x6900, quirk_amd_harvest_no_ats);
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312,
> quirk_amd_harvest_no_ats);
>  /* AMD Navi14 dGPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340,
> quirk_amd_harvest_no_ats);
> +/* AMD Raven platform iGPU */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8,
> +quirk_amd_harvest_no_ats);
>  #endif /* CONFIG_PCI_ATS */
>=20
>  /* Freescale PCIe doesn't support MSI in RC mode */
> --
> 2.29.2.454.gaff20da3a2-goog
