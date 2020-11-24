Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725062C2AD0
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 16:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389026AbgKXPF5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 10:05:57 -0500
Received: from mail-bn8nam11on2085.outbound.protection.outlook.com ([40.107.236.85]:15827
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388908AbgKXPF4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Nov 2020 10:05:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCbruN77pMz0+FN9CbbdJD37Q8wgfArw/SabJWll4Te70VAWnhG6Lnz1hqFhEZFfam9rGUdBzg6KnTsGd+9kE/5yqdbdxz/KwprXM+8iQdKvXBuCXcjK71LnEl8Ak+z9y6ENlYNnOTiY404F11hlNdX8aRt07VOdTRWhmgiMsx0pWQBcppQ/uhCAp3B3Hk51AjXJ09wemnGLT8OTr96s2coJD2b2p3idU+IMo/BKHs+BgtE8psv07YAandkZg4zt8NjTa7sSr2Af9UDU9k/jOIcLje2bDdRsp3n0B3hV/+BO3ELhTf084RZrcCpYavmQcAwQ6iyL5O2hK2oRX84rAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIEZH//ADhdGqajgbZUjGeH5bCpN7VK/a2bt9OoVsjk=;
 b=KiAdOrOd4W7Ovd2j1kPGefh+dqn9nchcre6kJQ6d8Z2D7YaVREmftM7V6RAzE11XJ+sALRcJRJbA5QU6B2pOni7oIEoSYJL+1w8aK8FOXaeSNM6AEEf8z972wgamR6/a1InxECPd64nuPYdHxQycbpCwt3ZU0Uz7ZbfxUxNlG0sz8oFHWSJKDgswpnzvuCfG2aRAOmuG2zECWPJtSoLr8HEUeaKKyxd1WT9j1BFM6AyrYzzp38BsuyQKq02cNa95XZH0hHFPQaak+Lx2GciwmhDCk7lTV2S0Yc8ccscEdMGj7MsFYVVm2ls4DWfcWISdAiaaBgT/Ozom2OFAP4ui2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIEZH//ADhdGqajgbZUjGeH5bCpN7VK/a2bt9OoVsjk=;
 b=ACH+PwlQspCbXNO8pPtxcFP7efOciIZDG6l6QhYUQW9I5/1ybYdMXNggkUJ7jYrQ04PUhLJjWEIfdyoZNb1LjqWhxw/wVz7kCcJuP7vZMDg7Z/FzNHEQGKTdqvZ3AHtw8pZ9zNsQgap4jBYbIfjGSpBblTOW51Np7G0D8MeZqj8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4964.namprd12.prod.outlook.com (2603:10b6:208:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 24 Nov
 2020 15:05:52 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%6]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 15:05:52 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC:     Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Thread-Topic: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Thread-Index: AQHWwZ6+dZH+wAWtiUyhnWNLDE7tj6nWM/hwgAAaPwCAAATSgIAAg9SAgAAMxACAAH6N8A==
Date:   Tue, 24 Nov 2020 15:05:52 +0000
Message-ID: <MN2PR12MB44884857E65E3599DA32D0B2F7FB0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201123134410.10648-1-will@kernel.org>
 <MN2PR12MB4488308D26DB50C18EA3BE0FF7FC0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20201123223356.GC12069@willie-the-truck>
 <218017ab-defd-c77d-9055-286bf49bee86@amd.com>
 <20201124064301.GA536919@hr-amd>
 <MWHPR10MB13108B04F4765EA6E278660B89FB0@MWHPR10MB1310.namprd10.prod.outlook.com>
In-Reply-To: <MWHPR10MB13108B04F4765EA6E278660B89FB0@MWHPR10MB1310.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-24T15:01:54Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=de2f7a10-55c4-48b3-9a56-00005e730a8e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-24T15:05:48Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ff3d2656-43b6-4bfc-be4b-0000269eb159
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: emerson.com; dkim=none (message not signed)
 header.d=none;emerson.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92bc0362-5e8d-4cd3-c65d-08d8908a6fb4
x-ms-traffictypediagnostic: BL0PR12MB4964:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB496445DB950A33416F5D58AAF7FB0@BL0PR12MB4964.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3YN9kceLUWpcKZadB2cX/IJtYpVEIX9mPvWEHyVlIe81sPyJwN0JNGPfB56ALJX6NTL1GAVnZkg2OGUinu66ctMOFu25hydQuZsUn85QJs5KxyEDpJ1BJySWEDr4VCAM4iH5nJ870JViD3gW7UKhN3MhzQHMbyx/cI751Ocky1BMQRMkcxTsoblY6ccbm7y1EErabiha8oc8Pu0JQ60asGUlQZ/P+Bq73X9BlXTg7DYOnjZonVEXs7mNkwNP4dvgqePMpXz6A6pAQ5PCAZtTRVYtmhIDG2PT0onWja7Rl9q4NhpEVa/18yBILp6dpZubvL5vDXV4EYClc3iSs3VWGLOdNyxzVeqzuL2LBc9dGkh+QGh39DOl3D/WG81C1Cqfa6VTmRpBdLriC/e+HNO8wA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(4001150100001)(19627235002)(54906003)(110136005)(53546011)(6506007)(7696005)(6636002)(66946007)(76116006)(26005)(33656002)(71200400001)(66446008)(66556008)(64756008)(66476007)(55016002)(9686003)(83380400001)(45080400002)(5660300002)(316002)(8676002)(2906002)(4326008)(478600001)(186003)(8936002)(86362001)(52536014)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qFF8Ooy6CRilBKGYO20/my1VtqEC4hbAN9s7Gk8rORYTO21gUUBG9HDpYhVzHBXiXi/oEyHyHK+eqD/5bM22EwTNjGLBtMISnPpwS0HWkvBcDPYQcu7/48K0RV9BaavT6sse/BITVxEeXvaMH3cNkKFJUV77G7mqhnoiaZ/siD4Wp3FQnuRLJF3k3zHiNC9ma9/oK/3giJj1hUJtUm/TvzaZE7ovpWVrjyIWfuoUYJvIPoQ/tK2Gf8X0RF2CsrMHfxUauif+MhABg6kxysUODoqYKFkc4v9Uq1iG8FM2+Wyaw88+s4WlYTrG4JMFnp31YRNLLwY3LfZgZ6T8M/taeJZbh915b2zK/3ASHkQPVLjagcrCR5Zn+oRaIiE3p6IChsFQhpEpWqvgZYoYcOkZXNhQavub/UPnlKb009ox/OfWpy4/fxrzEeVGdVSoE2bfNgeM+G7ttJxjzej97k29G/kpeeT86kdvimi2hkirqHITtl3rge0wwOAIgq7ocxS43NGQRWhBuZLHWilH9kxefnJIePTb6w8D/XF0TKtqg8qAAdytQF7SDyR0IJZBeZt5wZRuVAVtLdULe1rGoyM0PT8YGPw4AHYdQtfMzmFimQjyd4GbTjr6cBbAAee6dlLbUQnfZG8DqfNK5gygU6nEO1JzkoQ2+2otBFqlD/q7FhvRaGjIg5aqiSYowTSFKV5YC7BkFLY1lx1yASjc/t7i2wZcE36vdsmQo2xaeiCtiMePzvEwltI3o52qp1ztHL2FeOgHbZnKnSqqHpGpEOqlrV0/Yc/UoCHF9EFECjQ6RSXhVN8qr7SHSXOeEaDtxs+exhINnZi+maXGak8CxKbf+c+2ni/aK0Eb1Qw1Ecuv5F+wBuTMXCKCa+jKlh9Gy48xIp34+9w8j2bpDpbKwVokVQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bc0362-5e8d-4cd3-c65d-08d8908a6fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 15:05:52.5337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQb7uF4LtZ0F+z9POc1y6AV4zRx8hHOppnyRwdxSG1N7HOzTDMVg3fO86hXOriauKJlQfx2GPuvLEjKa76hEKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4964
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> <Edgar.Merger@emerson.com>
> Sent: Tuesday, November 24, 2020 2:29 AM
> To: Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Cc: Will Deacon <will@kernel.org>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn Helgaas
> <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu, Changfeng
> <Changfeng.Zhu@amd.com>
> Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as
> broken
>=20
> Module Version : PiccasoCpu 10
> AGESA Version   : PiccasoPI 100A
>=20
> I did not try to enter the system in any other way (like via ssh) than vi=
a
> Desktop.

You can get this information from the amdgpu driver.  E.g., sudo cat /sys/k=
ernel/debug/dri/0/amdgpu_firmware_info .  Also what is the PCI revision id =
of your chip (from lspci)?  Also are you just seeing this on specific versi=
ons of the sbios?

Thanks,

Alex


>=20
> -----Original Message-----
> From: Huang Rui <ray.huang@amd.com>
> Sent: Dienstag, 24. November 2020 07:43
> To: Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Will Deacon <will@kernel.org>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn Helgaas
> <bhelgaas@google.com>; Merger, Edgar [AUTOSOL/MAS/AUGS]
> <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>;
> Changfeng Zhu <changfeng.zhu@amd.com>
> Subject: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
>=20
> On Tue, Nov 24, 2020 at 06:51:11AM +0800, Kuehling, Felix wrote:
> > On 2020-11-23 5:33 p.m., Will Deacon wrote:
> > > On Mon, Nov 23, 2020 at 09:04:14PM +0000, Deucher, Alexander wrote:
> > >> [AMD Public Use]
> > >>
> > >>> -----Original Message-----
> > >>> From: Will Deacon <will@kernel.org>
> > >>> Sent: Monday, November 23, 2020 8:44 AM
> > >>> To: linux-kernel@vger.kernel.org
> > >>> Cc: linux-pci@vger.kernel.org; iommu@lists.linux-foundation.org;
> > >>> Will Deacon <will@kernel.org>; Bjorn Helgaas
> > >>> <bhelgaas@google.com>; Deucher, Alexander
> > >>> <Alexander.Deucher@amd.com>; Edgar Merger
> > >>> <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>
> > >>> Subject: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
> > >>>
> > >>> Edgar Merger reports that the AMD Raven GPU does not work reliably
> > >>> on his system when the IOMMU is enabled:
> > >>>
> > >>>    | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout,
> > >>> signaled seq=3D1, emitted seq=3D3
> > >>>    | [...]
> > >>>    | amdgpu 0000:0b:00.0: GPU reset begin!
> > >>>    | AMD-Vi: Completion-Wait loop timed out
> > >>>    | iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> > >>> device=3D0b:00.0 address=3D0x38edc0970]
> > >>>
> > >>> This is indicative of a hardware/platform configuration issue so,
> > >>> since disabling ATS has been shown to resolve the problem, add a
> > >>> quirk to match this particular device while Edgar follows-up with A=
MD
> for more information.
> > >>>
> > >>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> > >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> > >>> Reported-by: Edgar Merger <Edgar.Merger@emerson.com>
> > >>> Suggested-by: Joerg Roedel <jroedel@suse.de>
> > >>> Link:
> > >>>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furld
> efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> 3A__lore%26d%3DDwIDAw%26c%3DjOURTkCZzT8tVB5xPEYIm3YJGoxoTaQs
> QPzPKJGaWbo%26r%3DBJxhacqqa4K1PJGm6_-
> 862rdSP13_P6LVp7j_9l1xmg%26m%3DlNXu2xwvyxEZ3PzoVmXMBXXS55jsmf
> DicuQFJqkIOH4%26s%3D_5VDNCRQdA7AhsvvZ3TJJtQZ2iBp9c9tFHIleTYT_ZM
> %26e%3D&amp;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C6d5f
> a241f9634692c03908d8904a942c%7C3dd8961fe4884e608e11a82d994e183d%7
> C0%7C0%7C637417997272974427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100
> 0&amp;sdata=3DOEgYlw%2F1YP0C%2FnWBRQUxwBH56mGOJxYMWSQ%2Fj1Y
> 9f6Q%3D&amp;reserved=3D0 .
> > >>> kernel.org/linux-
> > >>>
> iommu/MWHPR10MB1310F042A30661D4158520B589FC0@MWHPR10M
> > >>> B1310.namprd10.prod.outlook.com
> > >>>
> her%40amd.com%7C1a883fe14d0c408e7d9508d88fb5df4e%7C3dd8961fe488
> > >>>
> 4e608e11a82d994e183d%7C0%7C0%7C637417358593629699%7CUnknown%7
> > >>>
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> > >>>
> LCJXVCI6Mn0%3D%7C1000&amp;sdata=3DTMgKldWzsX8XZ0l7q3%2BszDWXQJJ
> > >>> LOUfX5oGaoLN8n%2B8%3D&amp;reserved=3D0
> > >>> Signed-off-by: Will Deacon <will@kernel.org>
> > >>> ---
> > >>>
> > >>> Hi all,
> > >>>
> > >>> Since Joerg is away at the moment, I'm posting this to try to make
> > >>> some progress with the thread in the Link: tag.
> > >> + Felix
> > >>
> > >> What system is this?  Can you provide more details?  Does a sbios
> > >> update fix this?  Disabling ATS for all Ravens will break GPU
> > >> compute for a lot of people.  I'd prefer to just black list this
> > >> particular system (e.g., just SSIDs or revision) if possible.
> >
> > +Ray
> >
> > There are already many systems where the IOMMU is disabled in the
> > BIOS, or the CRAT table reporting the APU compute capabilities is
> > broken. Ray has been working on a fallback to make APUs behave like
> > dGPUs on such systems. That should also cover this case where ATS is
> > blacklisted. That said, it affects the programming model, because we
> > don't support the unified and coherent memory model on dGPUs like we
> > do on APUs with IOMMUv2. So it would be good to make the conditions
> > for this workaround as narrow as possible.
>=20
> Yes, besides the comments from Alex and Felix, may we get your firmware
> version (SMC firmware which is from SBIOS) and device id?
>=20
> > >>>    | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout,
> > >>> signaled seq=3D1, emitted seq=3D3
>=20
> It looks only gfx ib test passed, and fails to lanuch desktop, am I right=
?
>=20
> We would like to see whether it is Raven, Raven kicker (new Raven), or
> Picasso. In our side, per the internal test result, we didn't see the sim=
iliar
> issue on Raven kicker and Picasso platform.
>=20
> Thanks,
> Ray
>=20
> >
> > These are the relevant changes in KFD and Thunk for reference:
> >
> > ### KFD ###
> >
> > commit 914913ab04dfbcd0226ecb6bc99d276832ea2908
> > Author: Huang Rui <ray.huang@amd.com>
> > Date:=A0=A0 Tue Aug 18 14:54:23 2020 +0800
> >
> >  =A0=A0=A0 drm/amdkfd: implement the dGPU fallback path for apu (v6)
> >
> >  =A0=A0=A0 We still have a few iommu issues which need to address, so f=
orce
> > raven
> >  =A0=A0=A0 as "dgpu" path for the moment.
> >
> >  =A0=A0=A0 This is to add the fallback path to bypass IOMMU if IOMMU v2=
 is
> > disabled
> >  =A0=A0=A0 or ACPI CRAT table not correct.
> >
> >  =A0=A0=A0 v2: Use ignore_crat parameter to decide whether it will go w=
ith
> > IOMMUv2.
> >  =A0=A0=A0 v3: Align with existed thunk, don't change the way of raven,=
 only
> > renoir
> >  =A0=A0=A0=A0=A0=A0=A0 will use "dgpu" path by default.
> >  =A0=A0=A0 v4: don't update global ignore_crat in the driver, and revis=
e
> > fallback
> >  =A0=A0=A0=A0=A0=A0=A0 function if CRAT is broken.
> >  =A0=A0=A0 v5: refine acpi crat good but no iommu support case, and ren=
ame
> > the
> >  =A0=A0=A0=A0=A0=A0=A0 title.
> >  =A0=A0=A0 v6: fix the issue of dGPU initialized firstly, just modify t=
he
> > report
> >  =A0=A0=A0=A0=A0=A0=A0 value in the node_show().
> >
> >  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
> >  =A0=A0=A0 Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> >  =A0=A0=A0 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > ### Thunk ###
> >
> > commit e32482fa4b9ca398c8bdc303920abfd672592764
> > Author: Huang Rui <ray.huang@amd.com>
> > Date:=A0=A0 Tue Aug 18 18:54:05 2020 +0800
> >
> >  =A0=A0=A0 libhsakmt: remove is_dgpu flag in the hsa_gfxip_table
> >
> >  =A0=A0=A0 Whether use dgpu path will check the props which exposed fro=
m kernel.
> >  =A0=A0=A0 We won't need hard code in the ASIC table.
> >
> >  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
> >  =A0=A0=A0 Change-Id: I0c018a26b219914a41197ff36dbec7a75945d452
> >
> > commit 7c60f6d912034aa67ed27b47a29221422423f5cc
> > Author: Huang Rui <ray.huang@amd.com>
> > Date:=A0=A0 Thu Jul 30 10:22:23 2020 +0800
> >
> >  =A0=A0=A0 libhsakmt: implement the method that using flag which expose=
d by
> > kfd to configure is_dgpu
> >
> >  =A0=A0=A0 KFD already implemented the fallback path for APU. Thunk wil=
l use
> > flag
> >  =A0=A0=A0 which exposed by kfd to configure is_dgpu instead of hardcod=
e before.
> >
> >  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
> >  =A0=A0=A0 Change-Id: I445f6cf668f9484dd06cd9ae1bb3cfe7428ec7eb
> >
> > Regards,
> >  =A0 Felix
> >
> >
> > > Cheers, Alex. I'll have to defer to Edgar for the details, as my
> > > understanding from the original thread over at:
> > >
> > >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fur
> > > ldefense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> 3A__lore.kernel.org&a
> > >
> mp;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C6d5fa241f963469
> 2c039
> > >
> 08d8904a942c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63741
> 79972
> > >
> 72974427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzI
> > >
> iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DiKTPucGQqcRXET
> QZiQz
> > > j90WdJeCYDytdZHJ1ZiUyR%2FM%3D&amp;reserved=3D0
> > > _linux-2Diommu_MWHPR10MB1310CDB6829DDCF5EA84A14689150-
> 40MWHPR10MB131
> > >
> 0.namprd10.prod.outlook.com_&d=3DDwIDAw&c=3DjOURTkCZzT8tVB5xPEYIm3Y
> JGoxo
> > > TaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> 862rdSP13_P6LVp7j_9l1xmg&m=3DlNXu
> > >
> 2xwvyxEZ3PzoVmXMBXXS55jsmfDicuQFJqkIOH4&s=3DdsAVVJbD7gJIj3ctZpnnU
> 60y21
> > > ijWZmZ8xmOK1cO_O0&e=3D
> > >
> > > is that this is a board developed by his company.
> > >
> > > Edgar -- please can you answer Alex's questions?
> > >
> > > Will
