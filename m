Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE052D2765
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 10:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgLHJVg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 04:21:36 -0500
Received: from mx0b-00300601.pphosted.com ([148.163.142.35]:58700 "EHLO
        mx0b-00300601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726993AbgLHJVf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 04:21:35 -0500
X-Greylist: delayed 3449 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Dec 2020 04:21:31 EST
Received: from pps.filterd (m0144092.ppops.net [127.0.0.1])
        by mx0b-00300601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B88J8ck036679;
        Tue, 8 Dec 2020 08:23:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0b-00300601.pphosted.com with ESMTP id 359u4eb5by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 08:23:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJQG4QzEvM3+t1C2fBGH84j+A8LcZQr23MKPw0BYXoryvqujVpvuXKTw7qrGLYanCKC4snu29r3p2DUdqjfugnDO5Y02xq7HOxNiuoBJgKG1h5akfBN91+kqhLaQM+UQS16XFmi0ZAExwHjsRSkZ1Mlwm+UE26oKYlnblxy+gKLGD1BDN24bRGUY4awQT8I1aZx81SsSKiOocme2tUHVr7m+jZ8dv0ARteQaTBCErNckw9E30IqGaihzD+FK6ihcUM00WT3NYWhHMaNHLnUxANQj/JZWcn4b3hf73q5c0dUK/GLY7voYpuL2u6dub7YXWfNKEHqCgn1lB7yldDYXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvPaVlp5MYyWBel3BOv+QTbLhlMEI+U4C+cWBNybWrM=;
 b=Pi9J5+VS9Y/ZQB71cVU9aHlMZzBvW6nHiKAH0zOBvDeTkCXmkgvpSIdNqx9HfsWQdyd+KUfHlpclFQ+vgF4jlGtkgwYdypwPNF85kQ2SlRBBBMUT7BJoq+IDE+liCtDYAHzG+aWfZ6DVhWa0ecu33NHmu0FS4ZbTtYIvs5JVoA0W1AYWQIXa1hG1dc2WQVjd0KZpNAcJH6Dwl/FUYZ5DwWkWL4YpC65IauSkF1OAGxIAjGsUYnJ8GoIVvBGzVXcjHH98mPIpPMDZUYwd7vWI3CeJf1op+FqruKEHZTeDNZPmzm4t2KbdTbCADcNSkawDj0mYYfKzMRAFk1EuFxIG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emerson.onmicrosoft.com; s=selector2-emerson-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvPaVlp5MYyWBel3BOv+QTbLhlMEI+U4C+cWBNybWrM=;
 b=vfY9oOHPg55hnmnM6H3ve6d1GfW2Z+Y3uW5l8dEeP4W3vJI9TTMwmeE5v6SKZNou3ElR2zYOMVB0iBZ6RbTJwkQKUNpbJIcg1GtEEAf7zfvEijVdGDDLtOlNqobc+wqZTuWGT9xHItGwXOgwfsHCu3B5zQT+oWWPEnmdlLk56vA=
Received: from MWHPR10MB1310.namprd10.prod.outlook.com (2603:10b6:300:21::18)
 by CO1PR10MB4770.namprd10.prod.outlook.com (2603:10b6:303:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 08:23:10 +0000
Received: from MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e]) by MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e%12]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 08:23:09 +0000
From:   "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
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
Thread-Index: AQHWwdw3n5VLcueYHUSP0T6AMdoDgKnWTbwAgAAE0oCAAIPUgIAACwGQgACBfgCAAPBvUIAAPe5ggAADdOCAAHHKAIAA7wXwgAcWHwCAChlFAIABv+mg
Date:   Tue, 8 Dec 2020 08:23:09 +0000
Message-ID: <MWHPR10MB1310AF36AD6AD5A9857037BA89CD0@MWHPR10MB1310.namprd10.prod.outlook.com>
References: <20201123134410.10648-1-will@kernel.org>
 <MN2PR12MB4488308D26DB50C18EA3BE0FF7FC0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20201123223356.GC12069@willie-the-truck>
 <218017ab-defd-c77d-9055-286bf49bee86@amd.com>
 <20201124064301.GA536919@hr-amd>
 <MWHPR10MB13108B04F4765EA6E278660B89FB0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MN2PR12MB44884857E65E3599DA32D0B2F7FB0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MWHPR10MB13107611C2309BD0AECA685989FA0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <CY4PR10MB13029B38D31936622E4CA62389FA0@CY4PR10MB1302.namprd10.prod.outlook.com>
 <CY4PR10MB13022501A57CC02FF5BC632B89FA0@CY4PR10MB1302.namprd10.prod.outlook.com>
 <MN2PR12MB4488C655936CE25DC0C3EA5EF7FA0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MWHPR10MB13108E26A50D6A92BD9C58F189F90@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MN2PR12MB4488D4E13ACCD11BBB6379C1F7F50@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MWHPR10MB1310103CEF27C69BDCB6F3B689CE0@MWHPR10MB1310.namprd10.prod.outlook.com>
In-Reply-To: <MWHPR10MB1310103CEF27C69BDCB6F3B689CE0@MWHPR10MB1310.namprd10.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-24T15:01:54Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=de2f7a10-55c4-48b3-9a56-00005e730a8e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=emerson.com;
x-originating-ip: [80.79.80.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 356d52a3-e434-47c8-eada-08d89b527f5f
x-ms-traffictypediagnostic: CO1PR10MB4770:
x-microsoft-antispam-prvs: <CO1PR10MB4770D9CF2A35BC802D8B91CF89CD0@CO1PR10MB4770.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TRl+3YxQqJoaUL2ZjF9J34YPYM4LJ+uYLGY7d8XdLCTRFw1yuLgdTtZDMuXV7J6AX61736F1Z0U2Ao92sjNm/bjkE+Z6ITHBC9fAIsEWAPpkCjU9V4LwYEA8nP9yXkPtAx+nmqse1U+L8jIC1pyl6adYSOwbUFwVONSeBvDwSAQZi9ZZr1dt8DiOdcqz9rb8lR75QtqkeH7wUvA1vsULwO9iYojNlZgN55aDk0iNa81mU8jSsPBl44pUjqE1lRhaM4VjimirZTgdhs4AEgM8FcwkuFurey+nvoHjRyzQ4YYfo8J7pQmX/ub5fGOtXklVvnqskAi1e6jFKDaLO0FbNaIzZ3tueLjITlWuA0S/1z33MpppDPVYug+bOoJLie7GXg+2q2diKYckDVKO4tbDSZ7pP5EsXHRPf63wrffE6LtjkOs+S8WoEw371LfKMZMwNjRYFDhIxUFIVOz1fkdPlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1310.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(5660300002)(83380400001)(76116006)(26005)(186003)(7696005)(99936003)(7416002)(19627235002)(30864003)(71200400001)(52536014)(86362001)(8676002)(4326008)(4001150100001)(45080400002)(33656002)(66476007)(66556008)(2906002)(8936002)(966005)(66946007)(316002)(66576008)(6506007)(66446008)(110136005)(54906003)(478600001)(53546011)(55016002)(64756008)(9686003)(559001)(579004)(505234006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?bM7Lz+eIH6FbaupQWwUv9eVWZdzRSoTiRulLs6mjXVsQLE9mA53TOh9xgI?=
 =?iso-8859-1?Q?tb8JUu4QG1jAeTzGayxRR9NDqnOxqNYi4REri6fWRatm4fZRSCgJ1tmune?=
 =?iso-8859-1?Q?tZ3/wbq+j/0Nz2oqMcDOaMMGAwQDOE0DF4eN+N1KKadST6Z5Aap2tjtX0J?=
 =?iso-8859-1?Q?/TxLzO4tcIlIXWxcUjvGZczYiAlC/Amobk6Ks3HvYl3YR9O3hMnoQWMUoe?=
 =?iso-8859-1?Q?455WZuwtg164AClISIyPlupewHWtCSkhJ96sJxNuZuNbS9sPbrqE0SGnQu?=
 =?iso-8859-1?Q?YEc203jtBdghALO4TNtsHX2wi13FYDkE/DvIXsadCjGLQwNDxj29u+a8TJ?=
 =?iso-8859-1?Q?TFJyT2h1wnprb0v7kGhutrEK/S8P0ldT0QMzJzq8a6s/p4apzZMdUg9dZC?=
 =?iso-8859-1?Q?XfcxupsrVONY9s0vW4I6d9OuKwniRU0XxqB+8qqeawgvr/PZmbkUxWZRXl?=
 =?iso-8859-1?Q?g69HEl11ah7DJAaL+JmYTNBU3NX0EsXOXy4gxfMfmsP51A8xSta90lTXFS?=
 =?iso-8859-1?Q?NtluDfNb7EFwvT5kYw/5I4FELFAJblnqZVxE9Uo3fFrJHxUbZEFfVa0Q/L?=
 =?iso-8859-1?Q?wNu7fLtsUus1XhjLtYAl4T5kz0FmlHfvIHwfsZfJ6JfHVzfkf+B1Cnh4g/?=
 =?iso-8859-1?Q?wxwzuMf5zLWrOOyHNbNAbqV7t4BavQszA5yRGMJh75GfatY+q7Nsj9HgH4?=
 =?iso-8859-1?Q?rYDOfRs4ctWBjERI7MTd5wWcD/TalU85VGmUkJPKDGZEbNUuvh4ULSIo3t?=
 =?iso-8859-1?Q?3FnWkzUecpmmp3e4NMGQXhQYJIkqvvFttG5Gg+NXTRQuBxKrjEj5H6tMgt?=
 =?iso-8859-1?Q?cIAIhl0n8X8kK/GYYF6C7FZogSqjgUxtD1BHjC+gWRE19LsvOWKQFQJfdQ?=
 =?iso-8859-1?Q?uXYtgQ4ZxeobX8qjJNbM7TOIbvCMz+6ldzEZDOKRJeAm+59engp0gu6Xw2?=
 =?iso-8859-1?Q?WkiHtvJq1PKDLpERo2HJfe1MyU9Csk9lC0ATj+kgyWvz1MxXiElGuKdLwD?=
 =?iso-8859-1?Q?2tKevGgouyoQwk5Hc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_003_MWHPR10MB1310AF36AD6AD5A9857037BA89CD0MWHPR10MB1310namp_"
MIME-Version: 1.0
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356d52a3-e434-47c8-eada-08d89b527f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 08:23:09.7662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akuFZBR18zewPGwOBOtcC2IGlV6Mdu1ZprR7qv1IMIYvLYAgrFGMXARJEtBzf43o6eGIHjXGZG4/qXus27ao4+sYwh4Wxz1SYzpC7wtwFLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4770
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_03:2020-12-04,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080052
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--_003_MWHPR10MB1310AF36AD6AD5A9857037BA89CD0MWHPR10MB1310namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Applied the patch as in attachment. Verified that ATS for GPU-Device had be=
en disabled. See attachment "dmesg_ATS.log".

Was running that build over night successfully.

-----Original Message-----
From: Merger, Edgar [AUTOSOL/MAS/AUGS]=20
Sent: Montag, 7. Dezember 2020 05:53
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org; linux-pci@=
vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn Helgaas <bhelgaas@=
google.com>; Joerg Roedel <jroedel@suse.de>; Zhu, Changfeng <Changfeng.Zhu@=
amd.com>
Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken

Hi Alex,

I believe in the patch file, this
+		    (pdev->subsystem_device =3D=3D 0x0c19 ||
+		     pdev->subsystem_device =3D=3D 0x0c10))

Has to be changed to:
+		    (pdev->subsystem_device =3D=3D 0xce19 ||
+		     pdev->subsystem_device =3D=3D 0xcc10))

Because our SSIDs are "ea50:ce19" and "ea50:cc10" respectively and another =
one would "ea50:cc08".=20

I will apply that patch and feedback the results soon plus the patch file t=
hat I actually had applied.


-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Montag, 30. November 2020 19:36
To: Merger, Edgar [AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>; Huang, Ray=
 <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org; linux-pci@=
vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn Helgaas <bhelgaas@=
google.com>; Joerg Roedel <jroedel@suse.de>; Zhu, Changfeng <Changfeng.Zhu@=
amd.com>
Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken

[AMD Public Use]

> -----Original Message-----
> From: Merger, Edgar [AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>
> Sent: Thursday, November 26, 2020 4:24 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray=20
> <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn=20
> Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu,=20
> Changfeng <Changfeng.Zhu@amd.com>
> Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as=20
> broken
>=20
> Alex,
>=20
> This is pretty much the same patch as what I have received from Joerg=20
> previously, except that it is tied to the particular Emerson platform=20
> and its derivatives (listed with Subsystem IDs).

Right.  As per my original point, I don't want to disable ATS on all Picass=
o chips because doing so would break GPU compute on them, so I'd like to ap=
ply this quirk as narrowly as possible.

>=20
> Below patch was what Joerg provided me and I successfully tested.
>=20
> This diff to the kernel should do that:
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index=20
> f70692ac79c5..3911b0ec57ba 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5176,6 +5176,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,
> 0x6900, quirk_amd_harvest_no_ats);
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312,=20
> quirk_amd_harvest_no_ats);
>  /* AMD Navi14 dGPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340,=20
> quirk_amd_harvest_no_ats);
> +/* AMD Raven platform iGPU */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8,=20
> +quirk_amd_harvest_no_ats);
>  #endif /* CONFIG_PCI_ATS */
>=20
>  /* Freescale PCIe doesn't support MSI in RC mode */
>=20
> So far I have seen this issue on two instances of this chip, but I=20
> must admit that I did test only two of them to this extent, so I guess=20
> it is not a bad chip in particular, but the chips we use are from the=20
> same production lot, so it might be a systematical problem of that produc=
tion lot?
>=20
> UEFI-Setup shows:
> Processor Family: 17h
> Procossor Model: 20h - 2Fh
> CPUID: 00820F01
> Microcode Patch Level: 8200103
>=20
> Looking at the chip-die I found that this is a fully qualified IP=20
> Silicon (according to Ryzen Embedded R1000 SOC Interlock).
> YE1305C9T20FG
> BI2015SUY
> 9JB6496P00123
> 2016 AMD
> DIFFUSED IN USA
> MADE IN CHINA
>=20
> Currently used SBIOS is a branch from "EmbeddedPI-FP5 1.2.0.3RC3".
>=20
> In the future our SBIOS might merge with EmbeddedPI-FP5_1.2.0.5RC3.
>=20

I think it's more likely an sbios issue, so hopefully the new release fixes=
 it.

Alex

>=20
>=20
>=20
> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Mittwoch, 25. November 2020 17:08
> To: Merger, Edgar [AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>;=20
> Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix=20
> <Felix.Kuehling@amd.com>
> Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn=20
> Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu,=20
> Changfeng <Changfeng.Zhu@amd.com>
> Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as=20
> broken
>=20
> [AMD Public Use]
>=20
> > -----Original Message-----
> > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> <Edgar.Merger@emerson.com>
> > Sent: Wednesday, November 25, 2020 5:04 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray=20
> > <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn=20
> > Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu,=20
> > Changfeng <Changfeng.Zhu@amd.com>
> > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as=20
> > broken
> >
> > I do have also other problems with this unit, when IOMMU is enabled=20
> > and pci=3Dnoats is not set as kernel parameter.
> >
> > [ 2004.265906] amdgpu 0000:0b:00.0: [drm:amdgpu_ib_ring_tests=20
> > [amdgpu]]
> > *ERROR* IB test failed on gfx (-110).
> > [ 2004.266024] [drm:amdgpu_device_delayed_init_work_handler
> [amdgpu]]
> > *ERROR* ib ring test failed (-110).
> >
>=20
> Is this seen on all instances of this chip or only specific silicon? =20
> I.e., could this be a bad chip?  Would it be possible to test a newer=20
> sbios?  I think the attached patch should work if we can't get it=20
> fixed on the platform side.  It should only enable the quirk on your part=
icular platform.
>=20
> Alex
>=20
>=20
> > -----Original Message-----
> > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > Sent: Mittwoch, 25. November 2020 10:16
> > To: 'Deucher, Alexander' <Alexander.Deucher@amd.com>; 'Huang, Ray'
> > <Ray.Huang@amd.com>; 'Kuehling, Felix' <Felix.Kuehling@amd.com>
> > Cc: 'Will Deacon' <will@kernel.org>; 'linux-kernel@vger.kernel.org'
> > <linux- kernel@vger.kernel.org>; 'linux-pci@vger.kernel.org' <linux-=20
> > pci@vger.kernel.org>; 'iommu@lists.linux-foundation.org'
> > <iommu@lists.linux-foundation.org>; 'Bjorn Helgaas'
> > <bhelgaas@google.com>; 'Joerg Roedel' <jroedel@suse.de>; 'Zhu,=20
> > Changfeng' <Changfeng.Zhu@amd.com>
> > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as=20
> > broken
> >
> > Remark:
> >
> > Systems with R1305G APU (which show the issue) have the following
> > VGA-
> > Controller:
> > 0b:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > [AMD/ATI] Picasso (rev cf)
> >
> > Systems with V1404I APU (which do not show the issue) have the=20
> > following
> > VGA-Controller:
> > 0b:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile=20
> > Series] (rev 83)
> >
> > "rev cf" vs. "ref 83" is probably what you where referring to with=20
> > PCI Revision ID.
> >
> > -----Original Message-----
> > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > Sent: Mittwoch, 25. November 2020 07:05
> > To: 'Deucher, Alexander' <Alexander.Deucher@amd.com>; Huang, Ray=20
> > <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn=20
> > Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu,=20
> > Changfeng <Changfeng.Zhu@amd.com>
> > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as=20
> > broken
> >
> > I see that problem only on systems that use a R1305G APU
> >
> > sudo cat /sys/kernel/debug/dri/0/amdgpu_firmware_info
> >
> > shows
> >
> > VCE feature version: 0, firmware version: 0x00000000 UVD feature
> > version: 0, firmware version: 0x00000000 MC feature version: 0,=20
> > firmware
> version:
> > 0x00000000 ME feature version: 50, firmware version: 0x000000a3 PFP=20
> > feature version: 50, firmware version: 0x000000bb CE feature version:
> > 50, firmware version: 0x0000004f RLC feature version: 1, firmware versi=
on:
> > 0x00000049 RLC SRLC feature version: 1, firmware version: 0x00000001=20
> > RLC SRLG feature version: 1, firmware version: 0x00000001 RLC SRLS=20
> > feature
> > version: 1, firmware version: 0x00000001 MEC feature version: 50,=20
> > firmware
> > version: 0x000001b5
> > MEC2 feature version: 50, firmware version: 0x000001b5 SOS feature
> version:
> > 0, firmware version: 0x00000000 ASD feature version: 0, firmware versio=
n:
> > 0x21000030 TA XGMI feature version: 0, firmware version: 0x00000000=20
> > TA RAS feature version: 0, firmware version: 0x00000000 SMC feature
> > version: 0, firmware version: 0x00002527
> > SDMA0 feature version: 41, firmware version: 0x000000a9 VCN feature
> > version: 0, firmware version: 0x0110901c DMCU feature version: 0,=20
> > firmware
> > version: 0x00000001 VBIOS version: 113-RAVEN2-117
> >
> > We are also using V1404I APU on the same boards and I haven=B4t seen=20
> > the issue on those boards
> >
> > These boards give me slightly different info: sudo cat=20
> > /sys/kernel/debug/dri/0/amdgpu_firmware_info
> >
> > VCE feature version: 0, firmware version: 0x00000000 UVD feature
> > version: 0, firmware version: 0x00000000 MC feature version: 0,=20
> > firmware
> version:
> > 0x00000000 ME feature version: 47, firmware version: 0x000000a2 PFP=20
> > feature version: 47, firmware version: 0x000000b9 CE feature version:
> > 47, firmware version: 0x0000004e RLC feature version: 1, firmware versi=
on:
> > 0x00000213 RLC SRLC feature version: 1, firmware version: 0x00000001=20
> > RLC SRLG feature version: 1, firmware version: 0x00000001 RLC SRLS=20
> > feature
> > version: 1, firmware version: 0x00000001 MEC feature version: 47,=20
> > firmware
> > version: 0x000001ab
> > MEC2 feature version: 47, firmware version: 0x000001ab SOS feature
> version:
> > 0, firmware version: 0x00000000 ASD feature version: 0, firmware versio=
n:
> > 0x21000013 TA XGMI feature version: 0, firmware version: 0x00000000=20
> > TA RAS feature version: 0, firmware version: 0x00000000 SMC feature
> > version: 0, firmware version: 0x00001e5b
> > SDMA0 feature version: 41, firmware version: 0x000000a9 VCN feature
> > version: 0, firmware version: 0x0110901c DMCU feature version: 0,=20
> > firmware
> > version: 0x00000000 VBIOS version: 113-RAVEN-116
> >
> >
> >
> >
> > 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2=20
> > Root Complex
> > 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raven/Raven2
> IOMMU
> > 00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h=20
> > (Models
> > 00h-1fh) PCIe Dummy Host Bridge
> > 00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2=20
> > PCIe GPP Bridge [6:0]
> > 00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Zeppelin=20
> > Switch Upstream (PCIE SW.US)
> > 00:01.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2=20
> > PCIe GPP Bridge [6:0]
> > 00:01.5 PCI bridge: Advanced Micro Devices, Inc. [AMD] Zeppelin=20
> > Switch Upstream (PCIE SW.US)
> > 00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h=20
> > (Models
> > 00h-1fh) PCIe Dummy Host Bridge
> > 00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2=20
> > Internal PCIe GPP Bridge 0 to Bus A
> > 00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2=20
> > Internal PCIe GPP Bridge 0 to Bus B
> > 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus=20
> > Controller (rev 61)
> > 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC=20
> > Bridge (rev
> > 51)
> > 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2=20
> > Device 24: Function 0
> > 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2=20
> > Device 24: Function 1
> > 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2=20
> > Device 24: Function 2
> > 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2=20
> > Device 24: Function 3
> > 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2=20
> > Device 24: Function 4
> > 00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2=20
> > Device 24: Function 5
> > 00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2=20
> > Device 24: Function 6
> > 00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2=20
> > Device 24: Function 7
> > 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0e)
> > 01:00.1 Serial controller: Realtek Semiconductor Co., Ltd. Device=20
> > 816a (rev 0e)
> > 01:00.2 Serial controller: Realtek Semiconductor Co., Ltd. Device=20
> > 816b (rev 0e)
> > 01:00.3 IPMI Interface: Realtek Semiconductor Co., Ltd. Device 816c=20
> > (rev 0e)
> > 01:00.4 USB controller: Realtek Semiconductor Co., Ltd. Device 816d=20
> > (rev 0e)
> > 02:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network=20
> > Connection (rev 03)
> > 03:00.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > 6-Port/8- Lane Packet Switch
> > 04:01.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > 6-Port/8- Lane Packet Switch
> > 04:02.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > 6-Port/8- Lane Packet Switch
> > 04:03.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > 6-Port/8- Lane Packet Switch
> > 04:04.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > 6-Port/8- Lane Packet Switch
> > 04:05.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > 6-Port/8- Lane Packet Switch
> > 06:00.0 Serial controller: Asix Electronics Corporation Device 9100
> > 06:00.1 Serial controller: Asix Electronics Corporation Device 9100
> > 07:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network=20
> > Connection (rev 03)
> > 0a:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network=20
> > Connection (rev 03)
> > 0b:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > [AMD/ATI] Picasso (rev cf)
> > 0b:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI]=20
> > Raven/Raven2/Fenghuang HDMI/DP Audio Controller
> > 0b:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD]=20
> > Family 17h (Models 10h-1fh) Platform Security Processor
> > 0b:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raven2=20
> > USB
> > 3.1
> > 0b:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]=20
> > Raven/Raven2/FireFlight/Renoir Audio Processor
> > 0b:00.7 Non-VGA unclassified device: Advanced Micro Devices, Inc.
> > [AMD] Raven/Raven2/Renoir Non-Sensor Fusion Hub KMDF driver
> > 0c:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA=20
> > Controller [AHCI mode] (rev 61)
> >
> > PCI Revision ID is 06 I believe. Got that from this lspci -xx
> >
> > 00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Zeppelin=20
> > Switch Upstream (PCIE SW.US)
> > 00: 22 10 5d 14 07 04 10 00 00 00 04 06 10 00 81 00
> > 10: 00 00 00 00 00 00 00 00 00 02 02 00 f1 01 00 00
> > 20: e0 fc e0 fc f1 ff 01 00 00 00 00 00 00 00 00 00
> > 30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 12 00
> > 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 50: 01 58 03 c8 00 00 00 00 10 a0 42 01 22 80 00 00
> > 60: 1f 29 00 00 13 38 73 03 42 00 11 30 00 00 04 00
> > 70: 00 00 40 01 18 00 01 00 00 00 00 00 bf 01 70 00
> > 80: 06 00 00 00 0e 00 00 00 03 00 01 00 00 00 00 00
> > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > a0: 05 c0 81 00 00 00 e0 fe 00 00 00 00 00 00 00 00
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > c0: 0d c8 00 00 22 10 34 12 08 00 03 a8 00 00 00 00
> > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > e0: 00 00 00 00 4c 8a 05 00 00 00 00 00 00 00 00 00
> > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >
> > -----Original Message-----
> > From: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Sent: Dienstag, 24. November 2020 16:06
> > To: Merger, Edgar [AUTOSOL/MAS/AUGS]
> <Edgar.Merger@emerson.com>;
> > Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix=20
> > <Felix.Kuehling@amd.com>
> > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn=20
> > Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu,=20
> > Changfeng <Changfeng.Zhu@amd.com>
> > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as=20
> > broken
> >
> > [AMD Public Use]
> >
> > > -----Original Message-----
> > > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > <Edgar.Merger@emerson.com>
> > > Sent: Tuesday, November 24, 2020 2:29 AM
> > > To: Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix=20
> > > <Felix.Kuehling@amd.com>
> > > Cc: Will Deacon <will@kernel.org>; Deucher, Alexander=20
> > > <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org; linux-=20
> > > pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn=20
> > > Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>;=20
> > > Zhu,
> > Changfeng
> > > <Changfeng.Zhu@amd.com>
> > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS=20
> > > as broken
> > >
> > > Module Version : PiccasoCpu 10
> > > AGESA Version   : PiccasoPI 100A
> > >
> > > I did not try to enter the system in any other way (like via ssh)=20
> > > than via Desktop.
> >
> > You can get this information from the amdgpu driver.  E.g., sudo cat=20
> > /sys/kernel/debug/dri/0/amdgpu_firmware_info .  Also what is the PCI=20
> > revision id of your chip (from lspci)?  Also are you just seeing=20
> > this on specific versions of the sbios?
> >
> > Thanks,
> >
> > Alex
> >
> >
> > >
> > > -----Original Message-----
> > > From: Huang Rui <ray.huang@amd.com>
> > > Sent: Dienstag, 24. November 2020 07:43
> > > To: Kuehling, Felix <Felix.Kuehling@amd.com>
> > > Cc: Will Deacon <will@kernel.org>; Deucher, Alexander=20
> > > <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org; linux-=20
> > > pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn=20
> > > Helgaas <bhelgaas@google.com>; Merger, Edgar [AUTOSOL/MAS/AUGS]=20
> > > <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>;
> > Changfeng
> > > Zhu <changfeng.zhu@amd.com>
> > > Subject: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as
> > broken
> > >
> > > On Tue, Nov 24, 2020 at 06:51:11AM +0800, Kuehling, Felix wrote:
> > > > On 2020-11-23 5:33 p.m., Will Deacon wrote:
> > > > > On Mon, Nov 23, 2020 at 09:04:14PM +0000, Deucher, Alexander
> wrote:
> > > > >> [AMD Public Use]
> > > > >>
> > > > >>> -----Original Message-----
> > > > >>> From: Will Deacon <will@kernel.org>
> > > > >>> Sent: Monday, November 23, 2020 8:44 AM
> > > > >>> To: linux-kernel@vger.kernel.org
> > > > >>> Cc: linux-pci@vger.kernel.org;=20
> > > > >>> iommu@lists.linux-foundation.org; Will Deacon=20
> > > > >>> <will@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;=20
> > > > >>> Deucher, Alexander <Alexander.Deucher@amd.com>; Edgar
> Merger
> > > > >>> <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>
> > > > >>> Subject: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
> > > > >>>
> > > > >>> Edgar Merger reports that the AMD Raven GPU does not work=20
> > > > >>> reliably on his system when the IOMMU is enabled:
> > > > >>>
> > > > >>>    | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx=20
> > > > >>> timeout, signaled seq=3D1, emitted seq=3D3
> > > > >>>    | [...]
> > > > >>>    | amdgpu 0000:0b:00.0: GPU reset begin!
> > > > >>>    | AMD-Vi: Completion-Wait loop timed out
> > > > >>>    | iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> > > > >>> device=3D0b:00.0 address=3D0x38edc0970]
> > > > >>>
> > > > >>> This is indicative of a hardware/platform configuration=20
> > > > >>> issue so, since disabling ATS has been shown to resolve the=20
> > > > >>> problem, add a quirk to match this particular device while=20
> > > > >>> Edgar follows-up with AMD
> > > for more information.
> > > > >>>
> > > > >>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > >>> Reported-by: Edgar Merger <Edgar.Merger@emerson.com>
> > > > >>> Suggested-by: Joerg Roedel <jroedel@suse.de>
> > > > >>> Link:
> > > > >>>
> > >
> >
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__nam11.safelinks.p
> rotection.outlook.com_-3Furl-3Dhttps-253A-252F-252Furld&d=3DDwIFAw&c=3DjO=
U
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-862rdSP1
> 3_P6LVp7j_9l1xmg&m=3DBIpm40CYGVSJNrmoqPI4DeIayU0tYU2D5NpRwfbkZvA&s=3DtmsZ=
3
> ihrSXZ3g6wdJ2maxU9mJ1TGcRxd91z9IQTP00A&e=3D
> efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> 3A__nam11.safelinks.p&amp;data=3D04%7C01%7CAlexander.Deucher%40amd
> .com%7C9194a443d95c4ffcb7f708d891ed0889%7C3dd8961fe4884e608e11a82
> d994e183d%7C0%7C1%7C637419794843309283%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C1000&amp;sdata=3D4JGSwn7au4u%2FBB69mmq0%2BrWfVG12sEyd5H
> oBUeiut9o%3D&amp;reserved=3D0
> > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> 252Furld&d=3DDwIFAw&c=3DjOU
> >
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> 862rdSP1
> > 3_P6LVp7j_9l1xmg&m=3DZhN0Jau6oCc4cnz64IhGK2-
> XDiD5D_6vW6ZYbifWYF0&s=3DndvE-
> > ezxTBweMMUjyMWdiCyPB6GDIS_eWs0kmZwqtpY&e=3D
> > > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > 3A__nam11.safelinks.p&amp
> > >
> >
> ;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C1d797071822d47ce6
> > c9808d8
> > >
> >
> 9129698f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637418954
> > 3633797
> > >
> >
> 99%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> > zIiLCJBTiI
> > >
> >
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DVLlzQtS3KWZqQslcJKZYrG
> > sj6eMk3
> > > VWaE%2BXhbNdRx80%3D&amp;reserved=3D0
> > > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> > 252Furld&d=3DDwIFAw&c=3DjOU
> > >
> >
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> > 862rdSP1
> > > 3_P6LVp7j_9l1xmg&m=3DMMI_EgCqeOX4EvIftpL7agRxJ-
> > udp1CLokf2QWuzFgE&s=3DZLdz6
> > > OgavzNn2vSzsgyL1IB6MbK7hPKavOYwbLhyTPU&e=3D
> > > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > >
> >
> 3A__lore%26d%3DDwIDAw%26c%3DjOURTkCZzT8tVB5xPEYIm3YJGoxoTaQs
> > > QPzPKJGaWbo%26r%3DBJxhacqqa4K1PJGm6_-
> > >
> >
> 862rdSP13_P6LVp7j_9l1xmg%26m%3DlNXu2xwvyxEZ3PzoVmXMBXXS55jsmf
> > >
> >
> DicuQFJqkIOH4%26s%3D_5VDNCRQdA7AhsvvZ3TJJtQZ2iBp9c9tFHIleTYT_ZM
> > >
> >
> %26e%3D&amp;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C6d5f
> > >
> >
> a241f9634692c03908d8904a942c%7C3dd8961fe4884e608e11a82d994e183d%7
> > >
> >
> C0%7C0%7C637417997272974427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> > >
> >
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100
> > >
> >
> 0&amp;sdata=3DOEgYlw%2F1YP0C%2FnWBRQUxwBH56mGOJxYMWSQ%2Fj1Y
> > > 9f6Q%3D&amp;reserved=3D0 .
> > > > >>> kernel.org/linux-
> > > > >>>
> > > iommu/MWHPR10MB1310F042A30661D4158520B589FC0@MWHPR10M
> > > > >>> B1310.namprd10.prod.outlook.com
> > > > >>>
> > >
> >
> her%40amd.com%7C1a883fe14d0c408e7d9508d88fb5df4e%7C3dd8961fe488
> > > > >>>
> > >
> >
> 4e608e11a82d994e183d%7C0%7C0%7C637417358593629699%7CUnknown%7
> > > > >>>
> > >
> >
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> > > > >>>
> > >
> >
> LCJXVCI6Mn0%3D%7C1000&amp;sdata=3DTMgKldWzsX8XZ0l7q3%2BszDWXQJJ
> > > > >>> LOUfX5oGaoLN8n%2B8%3D&amp;reserved=3D0
> > > > >>> Signed-off-by: Will Deacon <will@kernel.org>
> > > > >>> ---
> > > > >>>
> > > > >>> Hi all,
> > > > >>>
> > > > >>> Since Joerg is away at the moment, I'm posting this to try=20
> > > > >>> to make some progress with the thread in the Link: tag.
> > > > >> + Felix
> > > > >>
> > > > >> What system is this?  Can you provide more details?  Does a=20
> > > > >> sbios update fix this?  Disabling ATS for all Ravens will=20
> > > > >> break GPU compute for a lot of people.  I'd prefer to just=20
> > > > >> black list this particular system (e.g., just SSIDs or revision)=
 if possible.
> > > >
> > > > +Ray
> > > >
> > > > There are already many systems where the IOMMU is disabled in=20
> > > > the BIOS, or the CRAT table reporting the APU compute=20
> > > > capabilities is broken. Ray has been working on a fallback to=20
> > > > make APUs behave like dGPUs on such systems. That should also=20
> > > > cover this case where ATS is blacklisted. That said, it affects=20
> > > > the programming model, because we don't support the unified and=20
> > > > coherent memory model on dGPUs like we do on APUs with IOMMUv2.
> > > > So it would be good to
> make
> > > > the conditions for this workaround as narrow as possible.
> > >
> > > Yes, besides the comments from Alex and Felix, may we get your=20
> > > firmware version (SMC firmware which is from SBIOS) and device id?
> > >
> > > > >>>    | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx=20
> > > > >>> timeout, signaled seq=3D1, emitted seq=3D3
> > >
> > > It looks only gfx ib test passed, and fails to lanuch desktop, am I r=
ight?
> > >
> > > We would like to see whether it is Raven, Raven kicker (new=20
> > > Raven), or Picasso. In our side, per the internal test result, we=20
> > > didn't see the similiar issue on Raven kicker and Picasso platform.
> > >
> > > Thanks,
> > > Ray
> > >
> > > >
> > > > These are the relevant changes in KFD and Thunk for reference:
> > > >
> > > > ### KFD ###
> > > >
> > > > commit 914913ab04dfbcd0226ecb6bc99d276832ea2908
> > > > Author: Huang Rui <ray.huang@amd.com>
> > > > Date:=A0=A0 Tue Aug 18 14:54:23 2020 +0800
> > > >
> > > >  =A0=A0=A0 drm/amdkfd: implement the dGPU fallback path for apu (v6=
)
> > > >
> > > >  =A0=A0=A0 We still have a few iommu issues which need to address, =
so=20
> > > > force raven
> > > >  =A0=A0=A0 as "dgpu" path for the moment.
> > > >
> > > >  =A0=A0=A0 This is to add the fallback path to bypass IOMMU if IOMM=
U
> > > > v2 is disabled
> > > >  =A0=A0=A0 or ACPI CRAT table not correct.
> > > >
> > > >  =A0=A0=A0 v2: Use ignore_crat parameter to decide whether it will =
go=20
> > > > with IOMMUv2.
> > > >  =A0=A0=A0 v3: Align with existed thunk, don't change the way of=20
> > > > raven, only renoir
> > > >  =A0=A0=A0=A0=A0=A0=A0 will use "dgpu" path by default.
> > > >  =A0=A0=A0 v4: don't update global ignore_crat in the driver, and=20
> > > > revise fallback
> > > >  =A0=A0=A0=A0=A0=A0=A0 function if CRAT is broken.
> > > >  =A0=A0=A0 v5: refine acpi crat good but no iommu support case, and=
=20
> > > > rename the
> > > >  =A0=A0=A0=A0=A0=A0=A0 title.
> > > >  =A0=A0=A0 v6: fix the issue of dGPU initialized firstly, just modi=
fy=20
> > > > the report
> > > >  =A0=A0=A0=A0=A0=A0=A0 value in the node_show().
> > > >
> > > >  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > >  =A0=A0=A0 Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > > >  =A0=A0=A0 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > >
> > > > ### Thunk ###
> > > >
> > > > commit e32482fa4b9ca398c8bdc303920abfd672592764
> > > > Author: Huang Rui <ray.huang@amd.com>
> > > > Date:=A0=A0 Tue Aug 18 18:54:05 2020 +0800
> > > >
> > > >  =A0=A0=A0 libhsakmt: remove is_dgpu flag in the hsa_gfxip_table
> > > >
> > > >  =A0=A0=A0 Whether use dgpu path will check the props which exposed=
=20
> > > > from
> > kernel.
> > > >  =A0=A0=A0 We won't need hard code in the ASIC table.
> > > >
> > > >  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > >  =A0=A0=A0 Change-Id: I0c018a26b219914a41197ff36dbec7a75945d452
> > > >
> > > > commit 7c60f6d912034aa67ed27b47a29221422423f5cc
> > > > Author: Huang Rui <ray.huang@amd.com>
> > > > Date:=A0=A0 Thu Jul 30 10:22:23 2020 +0800
> > > >
> > > >  =A0=A0=A0 libhsakmt: implement the method that using flag which=20
> > > > exposed by kfd to configure is_dgpu
> > > >
> > > >  =A0=A0=A0 KFD already implemented the fallback path for APU. Thunk=
=20
> > > > will use flag
> > > >  =A0=A0=A0 which exposed by kfd to configure is_dgpu instead of=20
> > > > hardcode
> > before.
> > > >
> > > >  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > >  =A0=A0=A0 Change-Id: I445f6cf668f9484dd06cd9ae1bb3cfe7428ec7eb
> > > >
> > > > Regards,
> > > >  =A0 Felix
> > > >
> > > >
> > > > > Cheers, Alex. I'll have to defer to Edgar for the details, as=20
> > > > > my understanding from the original thread over at:
> > > > >
> > > > >
> > >
> >
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__nam11.safelinks.p
> rotection.outlook.com_-3Furl-3Dhttps-253A-252F-252Furld&d=3DDwIFAw&c=3DjO=
U
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-862rdSP1
> 3_P6LVp7j_9l1xmg&m=3DBIpm40CYGVSJNrmoqPI4DeIayU0tYU2D5NpRwfbkZvA&s=3DtmsZ=
3
> ihrSXZ3g6wdJ2maxU9mJ1TGcRxd91z9IQTP00A&e=3D
> efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> 3A__nam11.safelinks.p&amp;data=3D04%7C01%7CAlexander.Deucher%40amd
> .com%7C9194a443d95c4ffcb7f708d891ed0889%7C3dd8961fe4884e608e11a82
> d994e183d%7C0%7C1%7C637419794843309283%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C1000&amp;sdata=3D4JGSwn7au4u%2FBB69mmq0%2BrWfVG12sEyd5H
> oBUeiut9o%3D&amp;reserved=3D0
> > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> 252Furld&d=3DDwIFAw&c=3DjOU
> >
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> 862rdSP1
> > 3_P6LVp7j_9l1xmg&m=3DZhN0Jau6oCc4cnz64IhGK2-
> XDiD5D_6vW6ZYbifWYF0&s=3DndvE-
> > ezxTBweMMUjyMWdiCyPB6GDIS_eWs0kmZwqtpY&e=3D
> > > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > 3A__nam11.safelinks.p&amp
> > >
> >
> ;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C1d797071822d47ce6
> > c9808d8
> > >
> >
> 9129698f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637418954
> > 3633797
> > >
> >
> 99%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> > zIiLCJBTiI
> > >
> >
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DVLlzQtS3KWZqQslcJKZYrG
> > sj6eMk3
> > > VWaE%2BXhbNdRx80%3D&amp;reserved=3D0
> > > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> > 252Fur&d=3DDwIFAw&c=3DjOURT
> > >
> kCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> > 862rdSP13_
> > > P6LVp7j_9l1xmg&m=3DMMI_EgCqeOX4EvIftpL7agRxJ-
> > udp1CLokf2QWuzFgE&s=3DIPZRolk
> > > y3TYlbWPsOkY37MbDdzwhc1b_LaE6JkaOkOo&e=3D
> > > > > ldefense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > > 3A__lore.kernel.org&a
> > > > >
> > >
> >
> mp;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C6d5fa241f963469
> > > 2c039
> > > > >
> > >
> >
> 08d8904a942c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63741
> > > 79972
> > > > >
> > >
> >
> 72974427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > > V2luMzI
> > > > >
> > >
> >
> iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DiKTPucGQqcRXET
> > > QZiQz
> > > > > j90WdJeCYDytdZHJ1ZiUyR%2FM%3D&amp;reserved=3D0
> > > > > _linux-2Diommu_MWHPR10MB1310CDB6829DDCF5EA84A14689150-
> > > 40MWHPR10MB131
> > > > >
> > >
> >
> 0.namprd10.prod.outlook.com_&d=3DDwIDAw&c=3DjOURTkCZzT8tVB5xPEYIm3Y
> > > JGoxo
> > > > > TaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> > > 862rdSP13_P6LVp7j_9l1xmg&m=3DlNXu
> > > > >
> > >
> >
> 2xwvyxEZ3PzoVmXMBXXS55jsmfDicuQFJqkIOH4&s=3DdsAVVJbD7gJIj3ctZpnnU
> > > 60y21
> > > > > ijWZmZ8xmOK1cO_O0&e=3D
> > > > >
> > > > > is that this is a board developed by his company.
> > > > >
> > > > > Edgar -- please can you answer Alex's questions?
> > > > >
> > > > > Will

--_003_MWHPR10MB1310AF36AD6AD5A9857037BA89CD0MWHPR10MB1310namp_
Content-Type: application/octet-stream; name="dmesg_ATS.log"
Content-Description: dmesg_ATS.log
Content-Disposition: attachment; filename="dmesg_ATS.log"; size=84;
	creation-date="Tue, 08 Dec 2020 08:19:05 GMT";
	modification-date="Tue, 08 Dec 2020 08:19:05 GMT"
Content-Transfer-Encoding: base64

WyAgICAwLjAwMDAwMF0gUENJZTogQVRTIGlzIGRpc2FibGVkClsgICAgMC41MzgyMjldIHBjaSAw
MDAwOjBiOjAwLjA6IGRpc2FibGluZyBBVFMK

--_003_MWHPR10MB1310AF36AD6AD5A9857037BA89CD0MWHPR10MB1310namp_
Content-Type: application/octet-stream;
	name="0001-PCI-quirks-Add-an-ATS-quirk-for-a-Picasso-APU_customized.patch"
Content-Description: 
 0001-PCI-quirks-Add-an-ATS-quirk-for-a-Picasso-APU_customized.patch
Content-Disposition: attachment;
	filename="0001-PCI-quirks-Add-an-ATS-quirk-for-a-Picasso-APU_customized.patch";
	size=1572; creation-date="Tue, 08 Dec 2020 08:22:02 GMT";
	modification-date="Tue, 08 Dec 2020 08:21:49 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0ZTllODAxNTBkYzRkNzM2YjgzMzEzN2Q1NThlMTI2ZjQ0MTE1OTA1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMjUgTm92IDIwMjAgMTA6NTc6MTUgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBQQ0k6IHF1aXJrczogQWRkIGFuIEFUUyBxdWlyayBmb3IgYSBQaWNhc3NvIEFQVQoKVGhpcyBp
cyB2ZXJ5IHNwZWNpZmljIHRvIGEgcGFydGljdWxhciBwbGF0Zm9ybSwgYmVjYXVzZQpBVFMgaXMg
cmVxdWlyZWQgZm9yIEdQVSBjb21wdXRlIGFuZCB0aGlzIGlzIG5vdCBrbm93bgp0byBiZSBhbiBp
c3N1ZSBvbiBhbnkgb3RoZXIgUGljYXNzbyBwbGF0Zm9ybXMuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9wY2kvcXVp
cmtzLmMgfCAxMyArKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3F1aXJrcy5jIGIvZHJpdmVycy9wY2kvcXVpcmtz
LmMKaW5kZXggZjcwNjkyYWM3OWM1Li5kNmUzODQ1ZDVkMDQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
cGNpL3F1aXJrcy5jCisrKyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jCkBAIC01MTY0LDYgKzUxNjQs
MTcgQEAgc3RhdGljIHZvaWQgcXVpcmtfYW1kX2hhcnZlc3Rfbm9fYXRzKHN0cnVjdCBwY2lfZGV2
ICpwZGV2KQogCSAgICAocGRldi0+ZGV2aWNlID09IDB4NzM0MCAmJiBwZGV2LT5yZXZpc2lvbiAh
PSAweGM1KSkKIAkJcmV0dXJuOwogCisJaWYgKHBkZXYtPmRldmljZSA9PSAweDE1ZDgpIHsKKwkJ
aWYgKHBkZXYtPnJldmlzaW9uID09IDB4Y2YgJiYKKwkJICAgIHBkZXYtPnN1YnN5c3RlbV92ZW5k
b3IgPT0gMHhlYTUwICYmCisJCSAgICAocGRldi0+c3Vic3lzdGVtX2RldmljZSA9PSAweGNlMTkg
KSkKKwkJCWdvdG8gbm9fYXRzOworCQllbHNlCisJCQlyZXR1cm47CisJfQorCitub19hdHM6CiAJ
cGNpX2luZm8ocGRldiwgImRpc2FibGluZyBBVFNcbiIpOwogCXBkZXYtPmF0c19jYXAgPSAwOwog
fQpAQCAtNTE3Niw2ICs1MTg3LDggQEAgREVDTEFSRV9QQ0lfRklYVVBfRklOQUwoUENJX1ZFTkRP
Ul9JRF9BVEksIDB4NjkwMCwgcXVpcmtfYW1kX2hhcnZlc3Rfbm9fYXRzKTsKIERFQ0xBUkVfUENJ
X0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfQVRJLCAweDczMTIsIHF1aXJrX2FtZF9oYXJ2ZXN0
X25vX2F0cyk7CiAvKiBBTUQgTmF2aTE0IGRHUFUgKi8KIERFQ0xBUkVfUENJX0ZJWFVQX0ZJTkFM
KFBDSV9WRU5ET1JfSURfQVRJLCAweDczNDAsIHF1aXJrX2FtZF9oYXJ2ZXN0X25vX2F0cyk7Cisv
KiBBTUQgUmF2ZW4gcGxhdGZvcm0gaUdQVSAqLworREVDTEFSRV9QQ0lfRklYVVBfRklOQUwoUENJ
X1ZFTkRPUl9JRF9BVEksIDB4MTVkOCwgcXVpcmtfYW1kX2hhcnZlc3Rfbm9fYXRzKTsKICNlbmRp
ZiAvKiBDT05GSUdfUENJX0FUUyAqLwogCiAvKiBGcmVlc2NhbGUgUENJZSBkb2Vzbid0IHN1cHBv
cnQgTVNJIGluIFJDIG1vZGUgKi8KLS0gCjIuMjUuNAoK

--_003_MWHPR10MB1310AF36AD6AD5A9857037BA89CD0MWHPR10MB1310namp_--
