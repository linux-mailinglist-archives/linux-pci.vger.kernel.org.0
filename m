Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF9A2C1EDF
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 08:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgKXH24 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 02:28:56 -0500
Received: from mx0b-00300601.pphosted.com ([148.163.142.35]:11558 "EHLO
        mx0b-00300601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730114AbgKXH2z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 02:28:55 -0500
Received: from pps.filterd (m0144091.ppops.net [127.0.0.1])
        by mx0b-00300601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AO7OWnj070514;
        Tue, 24 Nov 2020 07:28:45 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2050.outbound.protection.outlook.com [104.47.37.50])
        by mx0b-00300601.pphosted.com with ESMTP id 350d3j5g57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 07:28:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgxYVmswK9R7gOT3fg9ykwbPOI8A+e4H/Jj6YvTz2pnyyug2vyrmvCwVcI8fwxBl9bFQ3ABS/exDzYRsVHjuiZQYWo5M13zlt7Po+s3SJjorXxNHXynto6UP84QsvurE4R2bsUgKdZJYZ58XdqtXCCGbLSbrWBUZJeFyqVlVszjLI11WGbS03ufdMASSxSb/wXCaCr6s8lOTyatBTDIRWujvUg5o30Zoq5jiee0Il8uojeaOli/UZW03eZlwVG/jOs3ezQfdHgCxIWABCkSYrwILBmQ0fPq8YpoDc68FUy+9eUCflFMRk2pG1Mtk/tDHZB06Y1cGkM0CJ3PLXJPsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98GhN7NKItt7BT7qvj8Krkie1KvF/Lfffpszgs/CabE=;
 b=IRxoelEEXcV86nHp2cPxO7rbZza6BG6o8rLturOx0nLo0Wz6ZnVSqx0IdwiNmjnOy7kal/2R8pEtonciBm4Iiqduhf+ALS2vaMheYjIvtZj7Rop2t/yNpbnowPftQ64Njp0RJ+abXRMcRWsv6F+0L1pp5ySkQBtto0IuFyz8mtN4EQRSsEeJKkwDo/jrg0xpKs73dJH6xtpHc1z2mM6JGoXX0Xm6DkQxEpWaPWsca+2UHay+kjcwutsaRpN8oEf8iNz5kXK06UDvXdQiejntwXvmn3i+Xfdb7IBGFJhUFjMkTSYfwuDJGfrsuZAp2C4Pwose16aCPqc9wnbRu7SknA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emerson.onmicrosoft.com; s=selector2-emerson-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98GhN7NKItt7BT7qvj8Krkie1KvF/Lfffpszgs/CabE=;
 b=nl6sQ+xvfUTnAUVvfmcoJVWDsnIjCZ4OxanFlESOl+KIgTmhG1SouNl1ZVwtWLqiI6XxLkDWiyuGP69mwse+iznQBY1+HEgFFE96Sb6knX5vGm10QtOii0VztTZJgx5dUm+pfiiLN1qAvJe6287CVu0QIzdZOxIkd/k1OGienw0=
Received: from MWHPR10MB1310.namprd10.prod.outlook.com (2603:10b6:300:21::18)
 by MWHPR1001MB2191.namprd10.prod.outlook.com (2603:10b6:301:2c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 24 Nov
 2020 07:28:43 +0000
Received: from MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e]) by MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e%12]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 07:28:43 +0000
From:   "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>
To:     Huang Rui <ray.huang@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC:     Will Deacon <will@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Changfeng Zhu <changfeng.zhu@amd.com>
Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Thread-Topic: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Thread-Index: AQHWwdw3n5VLcueYHUSP0T6AMdoDgKnWTbwAgAAE0oCAAIPUgIAACwGQ
Date:   Tue, 24 Nov 2020 07:28:42 +0000
Message-ID: <MWHPR10MB13108B04F4765EA6E278660B89FB0@MWHPR10MB1310.namprd10.prod.outlook.com>
References: <20201123134410.10648-1-will@kernel.org>
 <MN2PR12MB4488308D26DB50C18EA3BE0FF7FC0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20201123223356.GC12069@willie-the-truck>
 <218017ab-defd-c77d-9055-286bf49bee86@amd.com>
 <20201124064301.GA536919@hr-amd>
In-Reply-To: <20201124064301.GA536919@hr-amd>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=emerson.com;
x-originating-ip: [2a00:79c0:797:6b00:2523:54e2:cc0f:eaa4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea24b056-987e-4250-562e-08d8904a925d
x-ms-traffictypediagnostic: MWHPR1001MB2191:
x-microsoft-antispam-prvs: <MWHPR1001MB219109184C768CD33909F0FE89FB0@MWHPR1001MB2191.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mpp1hEEbdKkTPDFPSi4sb/hqm0I/2CxgFrGKpht7QE3V633vrScLRhWuwm21rgX5Qr7fTXzRhTUx42whhcpnoUN61WS9rSmr3yPh588+azT5t226T1UHKW+4OVcvf9pUm3zdlQl+QGTnTPRY+sRbNUoJCDHSlOGLMx1Um7/g34HaWw2zFJEcQUFEuGCuQYNOlMGcxOcp6TB+br+ZfpHJf65erWMDEeI/aAUS+FaJ6Hxjx5VX13CRjSxmA6NvisVvAMFoHhdYiy2C8CP/+ilF4oeGMJ2u2MWH8xbycTBOcBmIIjPpjMgdp502uDjz5liutbgs09neesDtRDX2Yuh9FUBj8Q/sy3p82ORWiLIiHBvTEkIRK4de9Rx/pc8ZiFZxu+vHH9H9OsFwxe4tRJgvBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1310.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(366004)(346002)(66446008)(66946007)(478600001)(186003)(2906002)(66476007)(52536014)(8676002)(76116006)(83380400001)(4001150100001)(45080400002)(6506007)(33656002)(7696005)(53546011)(110136005)(7416002)(54906003)(19627235002)(64756008)(8936002)(316002)(86362001)(71200400001)(5660300002)(66556008)(4326008)(55016002)(9686003)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?3SPf5EG0Mqvun9OEy9kya25km2kr390nisxS5FSJRXXofRZYEuOaBpJ3hl?=
 =?iso-8859-1?Q?p8tQLTMSQO6Onr+eHUEt4y91cJBGmkZ1sB6WUUmZ0kXd/fhQvqNDFIGSLA?=
 =?iso-8859-1?Q?VnsCiCjI8gVADJxvPhwT9xvbDPLq+3868xZchm3Zu1eB61Equ6vMPECxtf?=
 =?iso-8859-1?Q?zOOLJxc0q0fobSwRZ5zN0PqnJ56y/IZ+HvuIT831aT5VvYo+u2L9i4dTZN?=
 =?iso-8859-1?Q?tnMJ3AyKToK4AJViMCYdWU3qJn6l3BvaPfpn6oV0I6wT+kaQjblHsPCaK8?=
 =?iso-8859-1?Q?eGE7vkwVx0aKnGwZga9i7FsoZBMOj5SZp/wPhXPmXlCCTdzdcVBRCT6oVQ?=
 =?iso-8859-1?Q?/muWwZUjxBb28o8xK/K9R8q7s9bt/h0+jQrh8zIFuQ86g0j/Y76TA1TDea?=
 =?iso-8859-1?Q?kKjD5wLZXxqyfnQgnJ7dHjm4Yhp60CW9tHj16mUqdSN6I5C+BrDg9xxNfq?=
 =?iso-8859-1?Q?mAYFY3vA8ui8b1zrOy3yhoOuJalbIJy/EpYZvkdcG9/36U49SDZ6mdP/JM?=
 =?iso-8859-1?Q?SqAlXQj3d827JSO89vyCwfWqKN9tkJ3VaPvaDJp7O5z0jmZfiPGzo8BDlf?=
 =?iso-8859-1?Q?CkqnKnWLBamFM9g3FxUB+v7Epqul2JZV3OrAD4xkSXmYTzZOicDicvRTnZ?=
 =?iso-8859-1?Q?5TG4odsknHNWIB/3X7kY5y9ujBr7Ya5V1Co7gAnrLvFjPjh7uw3WJabell?=
 =?iso-8859-1?Q?9M0fVf+GfdicNDxe+x1yLFCacq/+7ZFVwnxxVe+z7wU3tgq0BfKk7c0gwY?=
 =?iso-8859-1?Q?wToDI+SY/hPzmo77s65qOvKLPn9K4mqO22UuYV1WiIHqVovA8cd21+NBWH?=
 =?iso-8859-1?Q?58ARngse7qY4OeEfo5rMNmlXd/RS3UTSxYIqz2ELGMiLXRs89zggdpTkSa?=
 =?iso-8859-1?Q?Tk0ru2iuBAqDzKb0qqkTc7o15lNQWA2wWdJvkMk+ZlNh3D+JwFYHLkIQis?=
 =?iso-8859-1?Q?03pSFFlcZsVyva2mLTl3pU9IBtsuh9R4zZNqZQutpBzkirObdwT3TA=3D?=
 =?iso-8859-1?Q?=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea24b056-987e-4250-562e-08d8904a925d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 07:28:42.9565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihVWXgbDbRnVG77/qHST27LLIUBQ2C9Noun7d8zhQFw6cg2b4yLgN4yfkBAaai6GKlBKfMv5IwcaPeCRB/rUZSCvVYfoHnbTn5iBYYtLepw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2191
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_03:2020-11-24,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240043
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Module Version : PiccasoCpu 10=20
AGESA Version   : PiccasoPI 100A

I did not try to enter the system in any other way (like via ssh) than via =
Desktop.

-----Original Message-----
From: Huang Rui <ray.huang@amd.com>=20
Sent: Dienstag, 24. November 2020 07:43
To: Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Will Deacon <will@kernel.org>; Deucher, Alexander <Alexander.Deucher@am=
d.com>; linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; iommu@list=
s.linux-foundation.org; Bjorn Helgaas <bhelgaas@google.com>; Merger, Edgar =
[AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.d=
e>; Changfeng Zhu <changfeng.zhu@amd.com>
Subject: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken

On Tue, Nov 24, 2020 at 06:51:11AM +0800, Kuehling, Felix wrote:
> On 2020-11-23 5:33 p.m., Will Deacon wrote:
> > On Mon, Nov 23, 2020 at 09:04:14PM +0000, Deucher, Alexander wrote:
> >> [AMD Public Use]
> >>
> >>> -----Original Message-----
> >>> From: Will Deacon <will@kernel.org>
> >>> Sent: Monday, November 23, 2020 8:44 AM
> >>> To: linux-kernel@vger.kernel.org
> >>> Cc: linux-pci@vger.kernel.org; iommu@lists.linux-foundation.org;=20
> >>> Will Deacon <will@kernel.org>; Bjorn Helgaas=20
> >>> <bhelgaas@google.com>; Deucher, Alexander=20
> >>> <Alexander.Deucher@amd.com>; Edgar Merger=20
> >>> <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>
> >>> Subject: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
> >>>
> >>> Edgar Merger reports that the AMD Raven GPU does not work reliably=20
> >>> on his system when the IOMMU is enabled:
> >>>
> >>>    | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout,=20
> >>> signaled seq=3D1, emitted seq=3D3
> >>>    | [...]
> >>>    | amdgpu 0000:0b:00.0: GPU reset begin!
> >>>    | AMD-Vi: Completion-Wait loop timed out
> >>>    | iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> >>> device=3D0b:00.0 address=3D0x38edc0970]
> >>>
> >>> This is indicative of a hardware/platform configuration issue so,=20
> >>> since disabling ATS has been shown to resolve the problem, add a=20
> >>> quirk to match this particular device while Edgar follows-up with AMD=
 for more information.
> >>>
> >>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>> Reported-by: Edgar Merger <Edgar.Merger@emerson.com>
> >>> Suggested-by: Joerg Roedel <jroedel@suse.de>
> >>> Link:
> >>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore&d=3DDwIDA=
w&c=3DjOURTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-86=
2rdSP13_P6LVp7j_9l1xmg&m=3DlNXu2xwvyxEZ3PzoVmXMBXXS55jsmfDicuQFJqkIOH4&s=3D=
_5VDNCRQdA7AhsvvZ3TJJtQZ2iBp9c9tFHIleTYT_ZM&e=3D .
> >>> kernel.org/linux-
> >>> iommu/MWHPR10MB1310F042A30661D4158520B589FC0@MWHPR10M
> >>> B1310.namprd10.prod.outlook.com
> >>> her%40amd.com%7C1a883fe14d0c408e7d9508d88fb5df4e%7C3dd8961fe488
> >>> 4e608e11a82d994e183d%7C0%7C0%7C637417358593629699%7CUnknown%7
> >>> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> >>> LCJXVCI6Mn0%3D%7C1000&amp;sdata=3DTMgKldWzsX8XZ0l7q3%2BszDWXQJJ
> >>> LOUfX5oGaoLN8n%2B8%3D&amp;reserved=3D0
> >>> Signed-off-by: Will Deacon <will@kernel.org>
> >>> ---
> >>>
> >>> Hi all,
> >>>
> >>> Since Joerg is away at the moment, I'm posting this to try to make=20
> >>> some progress with the thread in the Link: tag.
> >> + Felix
> >>
> >> What system is this?  Can you provide more details?  Does a sbios=20
> >> update fix this?  Disabling ATS for all Ravens will break GPU=20
> >> compute for a lot of people.  I'd prefer to just black list this=20
> >> particular system (e.g., just SSIDs or revision) if possible.
>=20
> +Ray
>=20
> There are already many systems where the IOMMU is disabled in the=20
> BIOS, or the CRAT table reporting the APU compute capabilities is=20
> broken. Ray has been working on a fallback to make APUs behave like=20
> dGPUs on such systems. That should also cover this case where ATS is=20
> blacklisted. That said, it affects the programming model, because we=20
> don't support the unified and coherent memory model on dGPUs like we=20
> do on APUs with IOMMUv2. So it would be good to make the conditions=20
> for this workaround as narrow as possible.

Yes, besides the comments from Alex and Felix, may we get your firmware ver=
sion (SMC firmware which is from SBIOS) and device id?

> >>>    | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout,=20
> >>> signaled seq=3D1, emitted seq=3D3

It looks only gfx ib test passed, and fails to lanuch desktop, am I right?

We would like to see whether it is Raven, Raven kicker (new Raven), or Pica=
sso. In our side, per the internal test result, we didn't see the similiar =
issue on Raven kicker and Picasso platform.

Thanks,
Ray

>=20
> These are the relevant changes in KFD and Thunk for reference:
>=20
> ### KFD ###
>=20
> commit 914913ab04dfbcd0226ecb6bc99d276832ea2908
> Author: Huang Rui <ray.huang@amd.com>
> Date:=A0=A0 Tue Aug 18 14:54:23 2020 +0800
>=20
>  =A0=A0=A0 drm/amdkfd: implement the dGPU fallback path for apu (v6)
>=20
>  =A0=A0=A0 We still have a few iommu issues which need to address, so for=
ce=20
> raven
>  =A0=A0=A0 as "dgpu" path for the moment.
>=20
>  =A0=A0=A0 This is to add the fallback path to bypass IOMMU if IOMMU v2 i=
s=20
> disabled
>  =A0=A0=A0 or ACPI CRAT table not correct.
>=20
>  =A0=A0=A0 v2: Use ignore_crat parameter to decide whether it will go wit=
h=20
> IOMMUv2.
>  =A0=A0=A0 v3: Align with existed thunk, don't change the way of raven, o=
nly=20
> renoir
>  =A0=A0=A0=A0=A0=A0=A0 will use "dgpu" path by default.
>  =A0=A0=A0 v4: don't update global ignore_crat in the driver, and revise=
=20
> fallback
>  =A0=A0=A0=A0=A0=A0=A0 function if CRAT is broken.
>  =A0=A0=A0 v5: refine acpi crat good but no iommu support case, and renam=
e=20
> the
>  =A0=A0=A0=A0=A0=A0=A0 title.
>  =A0=A0=A0 v6: fix the issue of dGPU initialized firstly, just modify the=
=20
> report
>  =A0=A0=A0=A0=A0=A0=A0 value in the node_show().
>=20
>  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
>  =A0=A0=A0 Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>  =A0=A0=A0 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>=20
> ### Thunk ###
>=20
> commit e32482fa4b9ca398c8bdc303920abfd672592764
> Author: Huang Rui <ray.huang@amd.com>
> Date:=A0=A0 Tue Aug 18 18:54:05 2020 +0800
>=20
>  =A0=A0=A0 libhsakmt: remove is_dgpu flag in the hsa_gfxip_table
>=20
>  =A0=A0=A0 Whether use dgpu path will check the props which exposed from =
kernel.
>  =A0=A0=A0 We won't need hard code in the ASIC table.
>=20
>  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
>  =A0=A0=A0 Change-Id: I0c018a26b219914a41197ff36dbec7a75945d452
>=20
> commit 7c60f6d912034aa67ed27b47a29221422423f5cc
> Author: Huang Rui <ray.huang@amd.com>
> Date:=A0=A0 Thu Jul 30 10:22:23 2020 +0800
>=20
>  =A0=A0=A0 libhsakmt: implement the method that using flag which exposed =
by=20
> kfd to configure is_dgpu
>=20
>  =A0=A0=A0 KFD already implemented the fallback path for APU. Thunk will =
use=20
> flag
>  =A0=A0=A0 which exposed by kfd to configure is_dgpu instead of hardcode =
before.
>=20
>  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
>  =A0=A0=A0 Change-Id: I445f6cf668f9484dd06cd9ae1bb3cfe7428ec7eb
>=20
> Regards,
>  =A0 Felix
>=20
>=20
> > Cheers, Alex. I'll have to defer to Edgar for the details, as my=20
> > understanding from the original thread over at:
> >
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org
> > _linux-2Diommu_MWHPR10MB1310CDB6829DDCF5EA84A14689150-40MWHPR10MB131
> > 0.namprd10.prod.outlook.com_&d=3DDwIDAw&c=3DjOURTkCZzT8tVB5xPEYIm3YJGox=
o
> > TaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-862rdSP13_P6LVp7j_9l1xmg&m=3DlNX=
u
> > 2xwvyxEZ3PzoVmXMBXXS55jsmfDicuQFJqkIOH4&s=3DdsAVVJbD7gJIj3ctZpnnU60y21
> > ijWZmZ8xmOK1cO_O0&e=3D
> >
> > is that this is a board developed by his company.
> >
> > Edgar -- please can you answer Alex's questions?
> >
> > Will
