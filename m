Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C842B2D589E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 11:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgLJKwT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 05:52:19 -0500
Received: from mx0b-00300601.pphosted.com ([148.163.142.35]:14622 "EHLO
        mx0b-00300601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729145AbgLJKwT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 05:52:19 -0500
Received: from pps.filterd (m0144092.ppops.net [127.0.0.1])
        by mx0b-00300601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BAApHhO110511;
        Thu, 10 Dec 2020 10:51:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0b-00300601.pphosted.com with ESMTP id 35bj6pr1hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Dec 2020 10:51:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ibp0xR1is2rZU54f4lniZnR1lfq33FOZxJi0arA961jBl02XoOX4JvZIAI60Ckrv7hBv/h1I4QcoGG4HV6UvMQuGIS0LiuCtVx/0w6meD+n+LcqtR5bbujmb0kl/RtxgWToa6wN7WRl9hkFRz0LIh70yBY6/BPnZADQXBouFXY11DdJXoSemdKl8xEcIiGxlUwp9q7r85/8O/mIKgAr+Fegfm/rosj3BECxFNON+DYVlxZw44wtXXzUDTIhpXVWzLfXPB6XuhSb+mb4QHDknbX1GKZ08e5VmrCTtd0b9Mz1AM/OIWII4XE+Ro8wYIMLqKhdV0RmhnqDVCXwjgdUj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/BShjSzqgcipdaEXEtDjPFNUIz2rIZXn7F5XH86Bi8=;
 b=fSQv8qMWyplh4FCKOgmc6J79Bz3Hpdy5N+8QY9MJbEzMFWhMWFA5oF5znjNPDfz5kdIq0LNyG+sni/Wr34iNnNUMKd3hw8AvQlaFmZTui2PDNV94A6QPa6pDlA25NBxJVkUUvWX+hfyg82pXMLeupxTh/pApwx+Xa8amXLcs0CQrMzl87pT6+ZfYQJG+tTvwKKsuOxCUuDQDURYLhPicg+5t4tjcUILY3ZcMBLzDi0rZ4JBa9MEaOIESkgp6OgNo5RFbEgwMFwpZpSXMZdbrso2AZgVUfaRkjb0VgTCq1nCwjk/da5LhzPdo3XyqgXT8b0SBmGcKmScshAyqGHcx6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emerson.onmicrosoft.com; s=selector2-emerson-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/BShjSzqgcipdaEXEtDjPFNUIz2rIZXn7F5XH86Bi8=;
 b=iAW98gmyeYEZgaSI8iXXzczsHnrF7uu9tGcSQpHSyncnRozoXBArVdliZ8+O+LOLCrD+UdrPk0IpZpEWQ4rnOMe/ka2Vq83psm2WZmN8dxjCKlGfcigavaUATEGEwjlARonhc2HlrKStOpmu4AoVpLOV07Xpkg8T9WkmXGWf0Ww=
Received: from MWHPR10MB1310.namprd10.prod.outlook.com (2603:10b6:300:21::18)
 by MWHPR1001MB2301.namprd10.prod.outlook.com (2603:10b6:301:2d::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Thu, 10 Dec
 2020 10:48:06 +0000
Received: from MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e]) by MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e%12]) with mapi id 15.20.3632.021; Thu, 10 Dec 2020
 10:48:06 +0000
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
Thread-Index: AQHWwdw3n5VLcueYHUSP0T6AMdoDgKnWTbwAgAAE0oCAAIPUgIAACwGQgACBfgCAAPBvUIAAPe5ggAADdOCAAHHKAIAA7wXwgAcWHwCAChlFAIABv+mggAGZikCAAGvGgIABUzAQ
Date:   Thu, 10 Dec 2020 10:48:06 +0000
Message-ID: <MWHPR10MB131082779A86BE4CCCF190B789CB0@MWHPR10MB1310.namprd10.prod.outlook.com>
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
 <MWHPR10MB1310AF36AD6AD5A9857037BA89CD0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB1310571ED57F73DD12A61A4B89CC0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MN2PR12MB4488A289F1483503AA4F7587F7CC0@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4488A289F1483503AA4F7587F7CC0@MN2PR12MB4488.namprd12.prod.outlook.com>
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
x-originating-ip: [2a00:79c0:795:4f00:6866:1150:7e93:4960]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3baef66-c468-4bff-0926-08d89cf913d6
x-ms-traffictypediagnostic: MWHPR1001MB2301:
x-microsoft-antispam-prvs: <MWHPR1001MB2301DAE0D67E22EAEB23A01889CB0@MWHPR1001MB2301.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0il3FXWnKoweNDWUDe68E23GvLQ0LeIx3VhyNDkfo994adrCeA2+8LJpUJA0lLO5hOnJ6xyLp5ijwRaZNZsKlekKQOVG/Pc2Emwlm6JnZlJJ9IUCrAL4MFwrWOHw6NWNOrvLK/oXi5dFI6BSPtPNPOQwiVXBIqpepzKm9KHy+qYgWPDVNqyr8d4Da3EVA08mSoY7nTVZQKH/xgUahWzb7vQqK2y0dlWptcGdetm1fLXPgAt6UGosS6I2dks7bUzmtnlPISGolChnWaiLmRC/2H5SYQkpt6rAVH6HD7f8jae7asgiZS+ppATGPy7NA+1jYboRfxzS7i2Vrd3IWRfz92aoP3xtvNMDQO3/GR0lYH1aY9VrC5or9wZvxIBUYXMdb79I3ONcs6ggaUJYFhYARWvDEZQ0FZKw0HMvFt272TxBpo2b4NgGrBLDyroazOPnZQR+f7DRJSdnnshDobP8OA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1310.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(346002)(53546011)(52536014)(186003)(99936003)(66616009)(30864003)(5660300002)(71200400001)(54906003)(33656002)(83380400001)(4001150100001)(8936002)(110136005)(45080400002)(6506007)(55016002)(66556008)(66476007)(66446008)(508600001)(86362001)(66946007)(64756008)(4326008)(9686003)(8676002)(7416002)(2906002)(7696005)(76116006)(966005)(19627235002)(579004)(559001)(505234006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?k8qaQvGOhWm2IxHjJCLRYKYxs1yExqL9dPlJ5Ie5u6iHWitOMfxbAG21ye?=
 =?iso-8859-1?Q?FlicQGSwBZzYkl9MOftvY0agHSn/hXI3YmIcIOBMHRPaxkM7p7oOdWMUih?=
 =?iso-8859-1?Q?VHYpd1m00hH6nV1Qs1ueEAlQKBzHuNIOcI32UI4/Pw1KGFgOsisQVFBAv9?=
 =?iso-8859-1?Q?tdew89scV6w9kPNuauwf8iIdQOo3g04Cz2ba8F7bNSJACCUXQcm2QWmLW1?=
 =?iso-8859-1?Q?O927mqmAzWzectmVV2Pvv5vWvR6XHxm974bO5K6aHNjxeXvcFw1L97Yddl?=
 =?iso-8859-1?Q?cfO6CHDHlZS08/clepi0PFpMM/EYUYGSQKx2FzrjOaXwps4RD7d/FVj0Gc?=
 =?iso-8859-1?Q?gIdHHY1fws0vDl3/MPHHhJ9EDRi9ruWiciGnfy9defXjlAbf2qcWGfnQRr?=
 =?iso-8859-1?Q?imeDRLJKyRwlIv+uhxy685ALYu4GAPb+2SfG5MB5MuztRRe+AjYTa+SeBG?=
 =?iso-8859-1?Q?7YN2+zOviM88WmB/KwgqIczRqQWkOWwHD5wwXLnnuIOgcFH8NAz9+aD1J5?=
 =?iso-8859-1?Q?XBRxHbHP/Al4iBYMbmkQxTce0bypoVrT5U+2WNN7tlERVfEJXYFTnOSlgc?=
 =?iso-8859-1?Q?kVbQK+0GYZZPOehnTe8+qyJ8lbk4zpjgi9q1blo1xArkONVG57yAfZYOtB?=
 =?iso-8859-1?Q?mqVX8XbcMZTOZOKIQ0ubSvmFp79oSahTiTECaVuxGKaT780OnzwNTjLQEV?=
 =?iso-8859-1?Q?/ub+8OssDAcTfqrwuwrIWOltwgLly7tE+BCMYmjtiL/7o1nuEzc6ODhNeo?=
 =?iso-8859-1?Q?kSTwhnu1xhr6tQIaPC/8d5Z5A9lKAYMt1/cCMX9cv85TDCaY4eb1TFc0sB?=
 =?iso-8859-1?Q?x0zDkii04InvewA81OXAZ+4li2gMivUdsjBkcnvwUIdSgfqniFsjbVh3Bu?=
 =?iso-8859-1?Q?eHLmrYEKkM4WP+gXhxaFgqzNOm5yYrfh1Ps9lXFda4xPSz6ZQpPx0i70AC?=
 =?iso-8859-1?Q?wm72AR/kKN9xLuGAtFDz5LnB/XF+5tk5BBbqkVjJGwC7Kg05C+al1DcAQd?=
 =?iso-8859-1?Q?pGzkmBie9eGKogUAFkPkVaSPomlOzxxrOWze4uMNVKIzixnO3VJ55B8d5D?=
 =?iso-8859-1?Q?xwBiYJKQxtCiIwhhcr6tymo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_002_MWHPR10MB131082779A86BE4CCCF190B789CB0MWHPR10MB1310namp_"
MIME-Version: 1.0
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3baef66-c468-4bff-0926-08d89cf913d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 10:48:06.5309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: plRoR+K5EZk/ZK5biNsG4ook5o0J+7n7IXbybmd6YWV9GaPUOD5PAAZaLGk/pV1UrHZsKc1qabwOC3ngUu1Ze2SSxp6pMvCROljWg9BzkDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2301
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-10_03:2020-12-09,2020-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100072
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--_002_MWHPR10MB131082779A86BE4CCCF190B789CB0MWHPR10MB1310namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Alright. Done that.=20
This should be it finally I believe.
Which will be the initial kernel-version that incorporates that?

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>=20
Sent: Mittwoch, 9. Dezember 2020 15:24
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
> Sent: Wednesday, December 9, 2020 2:59 AM
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
> I had to revise the patch. Please see attachment. It is actually two=20
> more SSIDs affected to that.

Other than some minor whitespace issues, the patch looks fine to me.  Pleas=
e align the subsystem_device lines and put the closing parenthesis on the s=
ame line as the last check.

Thanks!

Alex

>=20
> Best regards,
> Edgar
>=20
> -----Original Message-----
> From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> Sent: Dienstag, 8. Dezember 2020 09:23
> To: 'Deucher, Alexander' <Alexander.Deucher@amd.com>; 'Huang, Ray'
> <Ray.Huang@amd.com>; 'Kuehling, Felix' <Felix.Kuehling@amd.com>
> Cc: 'Will Deacon' <will@kernel.org>; 'linux-kernel@vger.kernel.org'=20
> <linux- kernel@vger.kernel.org>; 'linux-pci@vger.kernel.org' <linux-=20
> pci@vger.kernel.org>; 'iommu@lists.linux-foundation.org'
> <iommu@lists.linux-foundation.org>; 'Bjorn Helgaas'
> <bhelgaas@google.com>; 'Joerg Roedel' <jroedel@suse.de>; 'Zhu,=20
> Changfeng' <Changfeng.Zhu@amd.com>
> Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as=20
> broken
>=20
> Applied the patch as in attachment. Verified that ATS for GPU-Device=20
> had been disabled. See attachment "dmesg_ATS.log".
>=20
> Was running that build over night successfully.
>=20
> -----Original Message-----
> From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> Sent: Montag, 7. Dezember 2020 05:53
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray=20
> <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn=20
> Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu,=20
> Changfeng <Changfeng.Zhu@amd.com>
> Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as=20
> broken
>=20
> Hi Alex,
>=20
> I believe in the patch file, this
> +		    (pdev->subsystem_device =3D=3D 0x0c19 ||
> +		     pdev->subsystem_device =3D=3D 0x0c10))
>=20
> Has to be changed to:
> +		    (pdev->subsystem_device =3D=3D 0xce19 ||
> +		     pdev->subsystem_device =3D=3D 0xcc10))
>=20
> Because our SSIDs are "ea50:ce19" and "ea50:cc10" respectively and=20
> another one would "ea50:cc08".
>=20
> I will apply that patch and feedback the results soon plus the patch=20
> file that I actually had applied.
>=20
>=20
> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Montag, 30. November 2020 19:36
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
> > Sent: Thursday, November 26, 2020 4:24 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray=20
> > <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn=20
> > Helgaas <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu,=20
> > Changfeng <Changfeng.Zhu@amd.com>
> > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as=20
> > broken
> >
> > Alex,
> >
> > This is pretty much the same patch as what I have received from=20
> > Joerg previously, except that it is tied to the particular Emerson=20
> > platform and its derivatives (listed with Subsystem IDs).
>=20
> Right.  As per my original point, I don't want to disable ATS on all=20
> Picasso chips because doing so would break GPU compute on them, so I'd=20
> like to apply this quirk as narrowly as possible.
>=20
> >
> > Below patch was what Joerg provided me and I successfully tested.
> >
> > This diff to the kernel should do that:
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index=20
> > f70692ac79c5..3911b0ec57ba 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5176,6 +5176,8 @@
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,
> > 0x6900, quirk_amd_harvest_no_ats);
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312,=20
> > quirk_amd_harvest_no_ats);
> >  /* AMD Navi14 dGPU */
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340,=20
> > quirk_amd_harvest_no_ats);
> > +/* AMD Raven platform iGPU */
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8,=20
> > +quirk_amd_harvest_no_ats);
> >  #endif /* CONFIG_PCI_ATS */
> >
> >  /* Freescale PCIe doesn't support MSI in RC mode */
> >
> > So far I have seen this issue on two instances of this chip, but I=20
> > must admit that I did test only two of them to this extent, so I=20
> > guess it is not a bad chip in particular, but the chips we use are=20
> > from the same production lot, so it might be a systematical problem=20
> > of that
> production lot?
> >
> > UEFI-Setup shows:
> > Processor Family: 17h
> > Procossor Model: 20h - 2Fh
> > CPUID: 00820F01
> > Microcode Patch Level: 8200103
> >
> > Looking at the chip-die I found that this is a fully qualified IP=20
> > Silicon (according to Ryzen Embedded R1000 SOC Interlock).
> > YE1305C9T20FG
> > BI2015SUY
> > 9JB6496P00123
> > 2016 AMD
> > DIFFUSED IN USA
> > MADE IN CHINA
> >
> > Currently used SBIOS is a branch from "EmbeddedPI-FP5 1.2.0.3RC3".
> >
> > In the future our SBIOS might merge with EmbeddedPI-FP5_1.2.0.5RC3.
> >
>=20
> I think it's more likely an sbios issue, so hopefully the new release fix=
es it.
>=20
> Alex
>=20
> >
> >
> >
> > -----Original Message-----
> > From: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Sent: Mittwoch, 25. November 2020 17:08
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
> > > Sent: Wednesday, November 25, 2020 5:04 AM
> > > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray=20
> > > <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> > > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> > > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org;=20
> > > Bjorn Helgaas <bhelgaas@google.com>; Joerg Roedel=20
> > > <jroedel@suse.de>; Zhu, Changfeng <Changfeng.Zhu@amd.com>
> > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS=20
> > > as broken
> > >
> > > I do have also other problems with this unit, when IOMMU is=20
> > > enabled and pci=3Dnoats is not set as kernel parameter.
> > >
> > > [ 2004.265906] amdgpu 0000:0b:00.0: [drm:amdgpu_ib_ring_tests=20
> > > [amdgpu]]
> > > *ERROR* IB test failed on gfx (-110).
> > > [ 2004.266024] [drm:amdgpu_device_delayed_init_work_handler
> > [amdgpu]]
> > > *ERROR* ib ring test failed (-110).
> > >
> >
> > Is this seen on all instances of this chip or only specific silicon?
> > I.e., could this be a bad chip?  Would it be possible to test a=20
> > newer sbios?  I think the attached patch should work if we can't get=20
> > it fixed on the platform side.  It should only enable the quirk on=20
> > your
> particular platform.
> >
> > Alex
> >
> >
> > > -----Original Message-----
> > > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > > Sent: Mittwoch, 25. November 2020 10:16
> > > To: 'Deucher, Alexander' <Alexander.Deucher@amd.com>; 'Huang, Ray'
> > > <Ray.Huang@amd.com>; 'Kuehling, Felix' <Felix.Kuehling@amd.com>
> > > Cc: 'Will Deacon' <will@kernel.org>; 'linux-kernel@vger.kernel.org'
> > > <linux- kernel@vger.kernel.org>; 'linux-pci@vger.kernel.org'=20
> > > <linux- pci@vger.kernel.org>; 'iommu@lists.linux-foundation.org'
> > > <iommu@lists.linux-foundation.org>; 'Bjorn Helgaas'
> > > <bhelgaas@google.com>; 'Joerg Roedel' <jroedel@suse.de>; 'Zhu,=20
> > > Changfeng' <Changfeng.Zhu@amd.com>
> > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS=20
> > > as broken
> > >
> > > Remark:
> > >
> > > Systems with R1305G APU (which show the issue) have the following
> > > VGA-
> > > Controller:
> > > 0b:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > > [AMD/ATI] Picasso (rev cf)
> > >
> > > Systems with V1404I APU (which do not show the issue) have the=20
> > > following
> > > VGA-Controller:
> > > 0b:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > > [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile=20
> > > Series] (rev 83)
> > >
> > > "rev cf" vs. "ref 83" is probably what you where referring to with=20
> > > PCI Revision ID.
> > >
> > > -----Original Message-----
> > > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > > Sent: Mittwoch, 25. November 2020 07:05
> > > To: 'Deucher, Alexander' <Alexander.Deucher@amd.com>; Huang, Ray=20
> > > <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> > > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> > > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org;=20
> > > Bjorn Helgaas <bhelgaas@google.com>; Joerg Roedel=20
> > > <jroedel@suse.de>; Zhu, Changfeng <Changfeng.Zhu@amd.com>
> > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS=20
> > > as broken
> > >
> > > I see that problem only on systems that use a R1305G APU
> > >
> > > sudo cat /sys/kernel/debug/dri/0/amdgpu_firmware_info
> > >
> > > shows
> > >
> > > VCE feature version: 0, firmware version: 0x00000000 UVD feature
> > > version: 0, firmware version: 0x00000000 MC feature version: 0,=20
> > > firmware
> > version:
> > > 0x00000000 ME feature version: 50, firmware version: 0x000000a3=20
> > > PFP feature version: 50, firmware version: 0x000000bb CE feature vers=
ion:
> > > 50, firmware version: 0x0000004f RLC feature version: 1, firmware
> version:
> > > 0x00000049 RLC SRLC feature version: 1, firmware version:=20
> > > 0x00000001 RLC SRLG feature version: 1, firmware version:=20
> > > 0x00000001 RLC SRLS feature
> > > version: 1, firmware version: 0x00000001 MEC feature version: 50,=20
> > > firmware
> > > version: 0x000001b5
> > > MEC2 feature version: 50, firmware version: 0x000001b5 SOS feature
> > version:
> > > 0, firmware version: 0x00000000 ASD feature version: 0, firmware
> version:
> > > 0x21000030 TA XGMI feature version: 0, firmware version:=20
> > > 0x00000000 TA RAS feature version: 0, firmware version: 0x00000000=20
> > > SMC feature
> > > version: 0, firmware version: 0x00002527
> > > SDMA0 feature version: 41, firmware version: 0x000000a9 VCN=20
> > > feature
> > > version: 0, firmware version: 0x0110901c DMCU feature version: 0,=20
> > > firmware
> > > version: 0x00000001 VBIOS version: 113-RAVEN2-117
> > >
> > > We are also using V1404I APU on the same boards and I haven=B4t seen=
=20
> > > the issue on those boards
> > >
> > > These boards give me slightly different info: sudo cat=20
> > > /sys/kernel/debug/dri/0/amdgpu_firmware_info
> > >
> > > VCE feature version: 0, firmware version: 0x00000000 UVD feature
> > > version: 0, firmware version: 0x00000000 MC feature version: 0,=20
> > > firmware
> > version:
> > > 0x00000000 ME feature version: 47, firmware version: 0x000000a2=20
> > > PFP feature version: 47, firmware version: 0x000000b9 CE feature vers=
ion:
> > > 47, firmware version: 0x0000004e RLC feature version: 1, firmware
> version:
> > > 0x00000213 RLC SRLC feature version: 1, firmware version:=20
> > > 0x00000001 RLC SRLG feature version: 1, firmware version:=20
> > > 0x00000001 RLC SRLS feature
> > > version: 1, firmware version: 0x00000001 MEC feature version: 47,=20
> > > firmware
> > > version: 0x000001ab
> > > MEC2 feature version: 47, firmware version: 0x000001ab SOS feature
> > version:
> > > 0, firmware version: 0x00000000 ASD feature version: 0, firmware
> version:
> > > 0x21000013 TA XGMI feature version: 0, firmware version:=20
> > > 0x00000000 TA RAS feature version: 0, firmware version: 0x00000000=20
> > > SMC feature
> > > version: 0, firmware version: 0x00001e5b
> > > SDMA0 feature version: 41, firmware version: 0x000000a9 VCN=20
> > > feature
> > > version: 0, firmware version: 0x0110901c DMCU feature version: 0,=20
> > > firmware
> > > version: 0x00000000 VBIOS version: 113-RAVEN-116
> > >
> > >
> > >
> > >
> > > 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > Raven/Raven2 Root Complex
> > > 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raven/Raven2
> > IOMMU
> > > 00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h=20
> > > (Models
> > > 00h-1fh) PCIe Dummy Host Bridge
> > > 00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD]
> > > Raven/Raven2 PCIe GPP Bridge [6:0]
> > > 00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Zeppelin=20
> > > Switch Upstream (PCIE SW.US)
> > > 00:01.4 PCI bridge: Advanced Micro Devices, Inc. [AMD]
> > > Raven/Raven2 PCIe GPP Bridge [6:0]
> > > 00:01.5 PCI bridge: Advanced Micro Devices, Inc. [AMD] Zeppelin=20
> > > Switch Upstream (PCIE SW.US)
> > > 00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h=20
> > > (Models
> > > 00h-1fh) PCIe Dummy Host Bridge
> > > 00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD]
> > > Raven/Raven2 Internal PCIe GPP Bridge 0 to Bus A
> > > 00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD]
> > > Raven/Raven2 Internal PCIe GPP Bridge 0 to Bus B
> > > 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus=20
> > > Controller (rev 61)
> > > 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC=20
> > > Bridge (rev
> > > 51)
> > > 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > Raven/Raven2 Device 24: Function 0
> > > 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > Raven/Raven2 Device 24: Function 1
> > > 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > Raven/Raven2 Device 24: Function 2
> > > 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > Raven/Raven2 Device 24: Function 3
> > > 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > Raven/Raven2 Device 24: Function 4
> > > 00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > Raven/Raven2 Device 24: Function 5
> > > 00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > Raven/Raven2 Device 24: Function 6
> > > 00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD]
> > > Raven/Raven2 Device 24: Function 7
> > > 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > > RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0e)
> > > 01:00.1 Serial controller: Realtek Semiconductor Co., Ltd. Device=20
> > > 816a (rev 0e)
> > > 01:00.2 Serial controller: Realtek Semiconductor Co., Ltd. Device=20
> > > 816b (rev 0e)
> > > 01:00.3 IPMI Interface: Realtek Semiconductor Co., Ltd. Device=20
> > > 816c (rev 0e)
> > > 01:00.4 USB controller: Realtek Semiconductor Co., Ltd. Device=20
> > > 816d (rev 0e)
> > > 02:00.0 Ethernet controller: Intel Corporation I210 Gigabit=20
> > > Network Connection (rev 03)
> > > 03:00.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > > 6-Port/8- Lane Packet Switch
> > > 04:01.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > > 6-Port/8- Lane Packet Switch
> > > 04:02.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > > 6-Port/8- Lane Packet Switch
> > > 04:03.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > > 6-Port/8- Lane Packet Switch
> > > 04:04.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > > 6-Port/8- Lane Packet Switch
> > > 04:05.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2
> > > 6-Port/8- Lane Packet Switch
> > > 06:00.0 Serial controller: Asix Electronics Corporation Device
> > > 9100
> > > 06:00.1 Serial controller: Asix Electronics Corporation Device
> > > 9100
> > > 07:00.0 Ethernet controller: Intel Corporation I210 Gigabit=20
> > > Network Connection (rev 03)
> > > 0a:00.0 Ethernet controller: Intel Corporation I210 Gigabit=20
> > > Network Connection (rev 03)
> > > 0b:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > > [AMD/ATI] Picasso (rev cf)
> > > 0b:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI]=20
> > > Raven/Raven2/Fenghuang HDMI/DP Audio Controller
> > > 0b:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD]=20
> > > Family 17h (Models 10h-1fh) Platform Security Processor
> > > 0b:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raven2=20
> > > USB
> > > 3.1
> > > 0b:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]=20
> > > Raven/Raven2/FireFlight/Renoir Audio Processor
> > > 0b:00.7 Non-VGA unclassified device: Advanced Micro Devices, Inc.
> > > [AMD] Raven/Raven2/Renoir Non-Sensor Fusion Hub KMDF driver
> > > 0c:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH=20
> > > SATA Controller [AHCI mode] (rev 61)
> > >
> > > PCI Revision ID is 06 I believe. Got that from this lspci -xx
> > >
> > > 00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Zeppelin=20
> > > Switch Upstream (PCIE SW.US)
> > > 00: 22 10 5d 14 07 04 10 00 00 00 04 06 10 00 81 00
> > > 10: 00 00 00 00 00 00 00 00 00 02 02 00 f1 01 00 00
> > > 20: e0 fc e0 fc f1 ff 01 00 00 00 00 00 00 00 00 00
> > > 30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 12 00
> > > 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 50: 01 58 03 c8 00 00 00 00 10 a0 42 01 22 80 00 00
> > > 60: 1f 29 00 00 13 38 73 03 42 00 11 30 00 00 04 00
> > > 70: 00 00 40 01 18 00 01 00 00 00 00 00 bf 01 70 00
> > > 80: 06 00 00 00 0e 00 00 00 03 00 01 00 00 00 00 00
> > > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > a0: 05 c0 81 00 00 00 e0 fe 00 00 00 00 00 00 00 00
> > > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > c0: 0d c8 00 00 22 10 34 12 08 00 03 a8 00 00 00 00
> > > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > e0: 00 00 00 00 4c 8a 05 00 00 00 00 00 00 00 00 00
> > > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >
> > > -----Original Message-----
> > > From: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > Sent: Dienstag, 24. November 2020 16:06
> > > To: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > <Edgar.Merger@emerson.com>;
> > > Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix=20
> > > <Felix.Kuehling@amd.com>
> > > Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org;
> > > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org;=20
> > > Bjorn Helgaas <bhelgaas@google.com>; Joerg Roedel=20
> > > <jroedel@suse.de>; Zhu, Changfeng <Changfeng.Zhu@amd.com>
> > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS=20
> > > as broken
> > >
> > > [AMD Public Use]
> > >
> > > > -----Original Message-----
> > > > From: Merger, Edgar [AUTOSOL/MAS/AUGS]
> > > <Edgar.Merger@emerson.com>
> > > > Sent: Tuesday, November 24, 2020 2:29 AM
> > > > To: Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix=20
> > > > <Felix.Kuehling@amd.com>
> > > > Cc: Will Deacon <will@kernel.org>; Deucher, Alexander=20
> > > > <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org;
> > > > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org;=20
> > > > Bjorn Helgaas <bhelgaas@google.com>; Joerg Roedel=20
> > > > <jroedel@suse.de>; Zhu,
> > > Changfeng
> > > > <Changfeng.Zhu@amd.com>
> > > > Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS=20
> > > > as broken
> > > >
> > > > Module Version : PiccasoCpu 10
> > > > AGESA Version   : PiccasoPI 100A
> > > >
> > > > I did not try to enter the system in any other way (like via
> > > > ssh) than via Desktop.
> > >
> > > You can get this information from the amdgpu driver.  E.g., sudo=20
> > > cat /sys/kernel/debug/dri/0/amdgpu_firmware_info .  Also what is=20
> > > the PCI revision id of your chip (from lspci)?  Also are you just=20
> > > seeing this on specific versions of the sbios?
> > >
> > > Thanks,
> > >
> > > Alex
> > >
> > >
> > > >
> > > > -----Original Message-----
> > > > From: Huang Rui <ray.huang@amd.com>
> > > > Sent: Dienstag, 24. November 2020 07:43
> > > > To: Kuehling, Felix <Felix.Kuehling@amd.com>
> > > > Cc: Will Deacon <will@kernel.org>; Deucher, Alexander=20
> > > > <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org;
> > > > linux- pci@vger.kernel.org; iommu@lists.linux-foundation.org;=20
> > > > Bjorn Helgaas <bhelgaas@google.com>; Merger, Edgar
> [AUTOSOL/MAS/AUGS]
> > > > <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>;
> > > Changfeng
> > > > Zhu <changfeng.zhu@amd.com>
> > > > Subject: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as
> > > broken
> > > >
> > > > On Tue, Nov 24, 2020 at 06:51:11AM +0800, Kuehling, Felix wrote:
> > > > > On 2020-11-23 5:33 p.m., Will Deacon wrote:
> > > > > > On Mon, Nov 23, 2020 at 09:04:14PM +0000, Deucher, Alexander
> > wrote:
> > > > > >> [AMD Public Use]
> > > > > >>
> > > > > >>> -----Original Message-----
> > > > > >>> From: Will Deacon <will@kernel.org>
> > > > > >>> Sent: Monday, November 23, 2020 8:44 AM
> > > > > >>> To: linux-kernel@vger.kernel.org
> > > > > >>> Cc: linux-pci@vger.kernel.org;=20
> > > > > >>> iommu@lists.linux-foundation.org; Will Deacon=20
> > > > > >>> <will@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;=20
> > > > > >>> Deucher, Alexander <Alexander.Deucher@amd.com>; Edgar
> > Merger
> > > > > >>> <Edgar.Merger@emerson.com>; Joerg Roedel
> <jroedel@suse.de>
> > > > > >>> Subject: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
> > > > > >>>
> > > > > >>> Edgar Merger reports that the AMD Raven GPU does not work=20
> > > > > >>> reliably on his system when the IOMMU is enabled:
> > > > > >>>
> > > > > >>>    | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx=20
> > > > > >>> timeout, signaled seq=3D1, emitted seq=3D3
> > > > > >>>    | [...]
> > > > > >>>    | amdgpu 0000:0b:00.0: GPU reset begin!
> > > > > >>>    | AMD-Vi: Completion-Wait loop timed out
> > > > > >>>    | iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> > > > > >>> device=3D0b:00.0 address=3D0x38edc0970]
> > > > > >>>
> > > > > >>> This is indicative of a hardware/platform configuration=20
> > > > > >>> issue so, since disabling ATS has been shown to resolve=20
> > > > > >>> the problem, add a quirk to match this particular device=20
> > > > > >>> while Edgar follows-up with AMD
> > > > for more information.
> > > > > >>>
> > > > > >>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > >>> Reported-by: Edgar Merger <Edgar.Merger@emerson.com>
> > > > > >>> Suggested-by: Joerg Roedel <jroedel@suse.de>
> > > > > >>> Link:
> > > > > >>>
> > > >
> > >
> >
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__nam11.safelinks.p
> rotection.outlook.com_-3Furl-3Dhttps-253A-252F-252Furld&d=3DDwIFAw&c=3DjO=
U
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-862rdSP1
> 3_P6LVp7j_9l1xmg&m=3DYkX6enlEevcTFbwL9p9WtRZLfFv4yrkYWGWII8q_ZSo&s=3Dn3lC=
5
> O0SPjN4j09x39L4oAOOQBED0Rc2xBoAmYeK7_o&e=3D
> > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> 3A__nam11.safelinks.p&amp
> >
> ;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7Cb29c13165c224c3794
> 2208d8
> >
> 9c185604%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430975
> 6442408
> >
> 26%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIiLCJBTiI
> >
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D2uB%2FmMkuxi%2Bc2Xb
> MD%2FhKpcw
> > QUxH49QfbCShTd227RDw%3D&amp;reserved=3D0
> > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> 252Furld&d=3DDwIFAw&c=3DjOU
> >
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> 862rdSP1
> >
> 3_P6LVp7j_9l1xmg&m=3DBIpm40CYGVSJNrmoqPI4DeIayU0tYU2D5NpRwfbkZv
> A&s=3DtmsZ3
> > ihrSXZ3g6wdJ2maxU9mJ1TGcRxd91z9IQTP00A&e=3D
> > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> >
> 3A__nam11.safelinks.p&amp;data=3D04%7C01%7CAlexander.Deucher%40amd
> >
> .com%7C9194a443d95c4ffcb7f708d891ed0889%7C3dd8961fe4884e608e11a82
> >
> d994e183d%7C0%7C1%7C637419794843309283%7CUnknown%7CTWFpbGZsb
> >
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> >
> %3D%7C1000&amp;sdata=3D4JGSwn7au4u%2FBB69mmq0%2BrWfVG12sEyd5H
> > oBUeiut9o%3D&amp;reserved=3D0
> > > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> > 252Furld&d=3DDwIFAw&c=3DjOU
> > >
> >
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> > 862rdSP1
> > > 3_P6LVp7j_9l1xmg&m=3DZhN0Jau6oCc4cnz64IhGK2-
> > XDiD5D_6vW6ZYbifWYF0&s=3DndvE-
> > > ezxTBweMMUjyMWdiCyPB6GDIS_eWs0kmZwqtpY&e=3D
> > > > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > > 3A__nam11.safelinks.p&amp
> > > >
> > >
> >
> ;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C1d797071822d47ce6
> > > c9808d8
> > > >
> > >
> >
> 9129698f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637418954
> > > 3633797
> > > >
> > >
> >
> 99%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> > > zIiLCJBTiI
> > > >
> > >
> >
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DVLlzQtS3KWZqQslcJKZYrG
> > > sj6eMk3
> > > > VWaE%2BXhbNdRx80%3D&amp;reserved=3D0
> > > > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> > > 252Furld&d=3DDwIFAw&c=3DjOU
> > > >
> > >
> >
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> > > 862rdSP1
> > > > 3_P6LVp7j_9l1xmg&m=3DMMI_EgCqeOX4EvIftpL7agRxJ-
> > > udp1CLokf2QWuzFgE&s=3DZLdz6
> > > > OgavzNn2vSzsgyL1IB6MbK7hPKavOYwbLhyTPU&e=3D
> > > > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > > >
> > >
> >
> 3A__lore%26d%3DDwIDAw%26c%3DjOURTkCZzT8tVB5xPEYIm3YJGoxoTaQs
> > > > QPzPKJGaWbo%26r%3DBJxhacqqa4K1PJGm6_-
> > > >
> > >
> >
> 862rdSP13_P6LVp7j_9l1xmg%26m%3DlNXu2xwvyxEZ3PzoVmXMBXXS55jsmf
> > > >
> > >
> >
> DicuQFJqkIOH4%26s%3D_5VDNCRQdA7AhsvvZ3TJJtQZ2iBp9c9tFHIleTYT_ZM
> > > >
> > >
> >
> %26e%3D&amp;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C6d5f
> > > >
> > >
> >
> a241f9634692c03908d8904a942c%7C3dd8961fe4884e608e11a82d994e183d%7
> > > >
> > >
> >
> C0%7C0%7C637417997272974427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> > > >
> > >
> >
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100
> > > >
> > >
> >
> 0&amp;sdata=3DOEgYlw%2F1YP0C%2FnWBRQUxwBH56mGOJxYMWSQ%2Fj1Y
> > > > 9f6Q%3D&amp;reserved=3D0 .
> > > > > >>> kernel.org/linux-
> > > > > >>>
> > > > iommu/MWHPR10MB1310F042A30661D4158520B589FC0@MWHPR10M
> > > > > >>> B1310.namprd10.prod.outlook.com
> > > > > >>>
> > > >
> > >
> >
> her%40amd.com%7C1a883fe14d0c408e7d9508d88fb5df4e%7C3dd8961fe488
> > > > > >>>
> > > >
> > >
> >
> 4e608e11a82d994e183d%7C0%7C0%7C637417358593629699%7CUnknown%7
> > > > > >>>
> > > >
> > >
> >
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> > > > > >>>
> > > >
> > >
> >
> LCJXVCI6Mn0%3D%7C1000&amp;sdata=3DTMgKldWzsX8XZ0l7q3%2BszDWXQJJ
> > > > > >>> LOUfX5oGaoLN8n%2B8%3D&amp;reserved=3D0
> > > > > >>> Signed-off-by: Will Deacon <will@kernel.org>
> > > > > >>> ---
> > > > > >>>
> > > > > >>> Hi all,
> > > > > >>>
> > > > > >>> Since Joerg is away at the moment, I'm posting this to try=20
> > > > > >>> to make some progress with the thread in the Link: tag.
> > > > > >> + Felix
> > > > > >>
> > > > > >> What system is this?  Can you provide more details?  Does a=20
> > > > > >> sbios update fix this?  Disabling ATS for all Ravens will=20
> > > > > >> break GPU compute for a lot of people.  I'd prefer to just=20
> > > > > >> black list this particular system (e.g., just SSIDs or
> > > > > >> revision) if
> possible.
> > > > >
> > > > > +Ray
> > > > >
> > > > > There are already many systems where the IOMMU is disabled in=20
> > > > > the BIOS, or the CRAT table reporting the APU compute=20
> > > > > capabilities is broken. Ray has been working on a fallback to=20
> > > > > make APUs behave like dGPUs on such systems. That should also=20
> > > > > cover this case where ATS is blacklisted. That said, it=20
> > > > > affects the programming model, because we don't support the=20
> > > > > unified and coherent memory model on dGPUs like we do on APUs=20
> > > > > with
> IOMMUv2.
> > > > > So it would be good to
> > make
> > > > > the conditions for this workaround as narrow as possible.
> > > >
> > > > Yes, besides the comments from Alex and Felix, may we get your=20
> > > > firmware version (SMC firmware which is from SBIOS) and device id?
> > > >
> > > > > >>>    | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx=20
> > > > > >>> timeout, signaled seq=3D1, emitted seq=3D3
> > > >
> > > > It looks only gfx ib test passed, and fails to lanuch desktop, am I=
 right?
> > > >
> > > > We would like to see whether it is Raven, Raven kicker (new=20
> > > > Raven), or Picasso. In our side, per the internal test result,=20
> > > > we didn't see the similiar issue on Raven kicker and Picasso platfo=
rm.
> > > >
> > > > Thanks,
> > > > Ray
> > > >
> > > > >
> > > > > These are the relevant changes in KFD and Thunk for reference:
> > > > >
> > > > > ### KFD ###
> > > > >
> > > > > commit 914913ab04dfbcd0226ecb6bc99d276832ea2908
> > > > > Author: Huang Rui <ray.huang@amd.com>
> > > > > Date:=A0=A0 Tue Aug 18 14:54:23 2020 +0800
> > > > >
> > > > >  =A0=A0=A0 drm/amdkfd: implement the dGPU fallback path for apu (=
v6)
> > > > >
> > > > >  =A0=A0=A0 We still have a few iommu issues which need to address=
,=20
> > > > > so force raven
> > > > >  =A0=A0=A0 as "dgpu" path for the moment.
> > > > >
> > > > >  =A0=A0=A0 This is to add the fallback path to bypass IOMMU if IO=
MMU
> > > > > v2 is disabled
> > > > >  =A0=A0=A0 or ACPI CRAT table not correct.
> > > > >
> > > > >  =A0=A0=A0 v2: Use ignore_crat parameter to decide whether it wil=
l=20
> > > > > go with IOMMUv2.
> > > > >  =A0=A0=A0 v3: Align with existed thunk, don't change the way of=
=20
> > > > > raven, only renoir
> > > > >  =A0=A0=A0=A0=A0=A0=A0 will use "dgpu" path by default.
> > > > >  =A0=A0=A0 v4: don't update global ignore_crat in the driver, and=
=20
> > > > > revise fallback
> > > > >  =A0=A0=A0=A0=A0=A0=A0 function if CRAT is broken.
> > > > >  =A0=A0=A0 v5: refine acpi crat good but no iommu support case, a=
nd=20
> > > > > rename the
> > > > >  =A0=A0=A0=A0=A0=A0=A0 title.
> > > > >  =A0=A0=A0 v6: fix the issue of dGPU initialized firstly, just=20
> > > > > modify the report
> > > > >  =A0=A0=A0=A0=A0=A0=A0 value in the node_show().
> > > > >
> > > > >  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > > >  =A0=A0=A0 Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > > > >  =A0=A0=A0 Signed-off-by: Alex Deucher <alexander.deucher@amd.com=
>
> > > > >
> > > > > ### Thunk ###
> > > > >
> > > > > commit e32482fa4b9ca398c8bdc303920abfd672592764
> > > > > Author: Huang Rui <ray.huang@amd.com>
> > > > > Date:=A0=A0 Tue Aug 18 18:54:05 2020 +0800
> > > > >
> > > > >  =A0=A0=A0 libhsakmt: remove is_dgpu flag in the hsa_gfxip_table
> > > > >
> > > > >  =A0=A0=A0 Whether use dgpu path will check the props which expos=
ed=20
> > > > > from
> > > kernel.
> > > > >  =A0=A0=A0 We won't need hard code in the ASIC table.
> > > > >
> > > > >  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > > >  =A0=A0=A0 Change-Id: I0c018a26b219914a41197ff36dbec7a75945d452
> > > > >
> > > > > commit 7c60f6d912034aa67ed27b47a29221422423f5cc
> > > > > Author: Huang Rui <ray.huang@amd.com>
> > > > > Date:=A0=A0 Thu Jul 30 10:22:23 2020 +0800
> > > > >
> > > > >  =A0=A0=A0 libhsakmt: implement the method that using flag which=
=20
> > > > > exposed by kfd to configure is_dgpu
> > > > >
> > > > >  =A0=A0=A0 KFD already implemented the fallback path for APU. Thu=
nk=20
> > > > > will use flag
> > > > >  =A0=A0=A0 which exposed by kfd to configure is_dgpu instead of=20
> > > > > hardcode
> > > before.
> > > > >
> > > > >  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > > >  =A0=A0=A0 Change-Id: I445f6cf668f9484dd06cd9ae1bb3cfe7428ec7eb
> > > > >
> > > > > Regards,
> > > > >  =A0 Felix
> > > > >
> > > > >
> > > > > > Cheers, Alex. I'll have to defer to Edgar for the details,=20
> > > > > > as my understanding from the original thread over at:
> > > > > >
> > > > > >
> > > >
> > >
> >
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__nam11.safelinks.p
> rotection.outlook.com_-3Furl-3Dhttps-253A-252F-252Furld&d=3DDwIFAw&c=3DjO=
U
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-862rdSP1
> 3_P6LVp7j_9l1xmg&m=3DYkX6enlEevcTFbwL9p9WtRZLfFv4yrkYWGWII8q_ZSo&s=3Dn3lC=
5
> O0SPjN4j09x39L4oAOOQBED0Rc2xBoAmYeK7_o&e=3D
> > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> 3A__nam11.safelinks.p&amp
> >
> ;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7Cb29c13165c224c3794
> 2208d8
> >
> 9c185604%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430975
> 6442408
> >
> 26%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIiLCJBTiI
> >
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D2uB%2FmMkuxi%2Bc2Xb
> MD%2FhKpcw
> > QUxH49QfbCShTd227RDw%3D&amp;reserved=3D0
> > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> 252Furld&d=3DDwIFAw&c=3DjOU
> >
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> 862rdSP1
> >
> 3_P6LVp7j_9l1xmg&m=3DBIpm40CYGVSJNrmoqPI4DeIayU0tYU2D5NpRwfbkZv
> A&s=3DtmsZ3
> > ihrSXZ3g6wdJ2maxU9mJ1TGcRxd91z9IQTP00A&e=3D
> > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> >
> 3A__nam11.safelinks.p&amp;data=3D04%7C01%7CAlexander.Deucher%40amd
> >
> .com%7C9194a443d95c4ffcb7f708d891ed0889%7C3dd8961fe4884e608e11a82
> >
> d994e183d%7C0%7C1%7C637419794843309283%7CUnknown%7CTWFpbGZsb
> >
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> >
> %3D%7C1000&amp;sdata=3D4JGSwn7au4u%2FBB69mmq0%2BrWfVG12sEyd5H
> > oBUeiut9o%3D&amp;reserved=3D0
> > > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> > 252Furld&d=3DDwIFAw&c=3DjOU
> > >
> >
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> > 862rdSP1
> > > 3_P6LVp7j_9l1xmg&m=3DZhN0Jau6oCc4cnz64IhGK2-
> > XDiD5D_6vW6ZYbifWYF0&s=3DndvE-
> > > ezxTBweMMUjyMWdiCyPB6GDIS_eWs0kmZwqtpY&e=3D
> > > > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > > 3A__nam11.safelinks.p&amp
> > > >
> > >
> >
> ;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C1d797071822d47ce6
> > > c9808d8
> > > >
> > >
> >
> 9129698f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637418954
> > > 3633797
> > > >
> > >
> >
> 99%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> > > zIiLCJBTiI
> > > >
> > >
> >
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DVLlzQtS3KWZqQslcJKZYrG
> > > sj6eMk3
> > > > VWaE%2BXhbNdRx80%3D&amp;reserved=3D0
> > > > rotection.outlook.com_-3Furl-3Dhttps-253A-252F-
> > > 252Fur&d=3DDwIFAw&c=3DjOURT
> > > >
> > kCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> > > 862rdSP13_
> > > > P6LVp7j_9l1xmg&m=3DMMI_EgCqeOX4EvIftpL7agRxJ-
> > > udp1CLokf2QWuzFgE&s=3DIPZRolk
> > > > y3TYlbWPsOkY37MbDdzwhc1b_LaE6JkaOkOo&e=3D
> > > > > > ldefense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> > > > 3A__lore.kernel.org&a
> > > > > >
> > > >
> > >
> >
> mp;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C6d5fa241f963469
> > > > 2c039
> > > > > >
> > > >
> > >
> >
> 08d8904a942c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63741
> > > > 79972
> > > > > >
> > > >
> > >
> >
> 72974427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > > > V2luMzI
> > > > > >
> > > >
> > >
> >
> iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DiKTPucGQqcRXET
> > > > QZiQz
> > > > > > j90WdJeCYDytdZHJ1ZiUyR%2FM%3D&amp;reserved=3D0
> > > > > > _linux-
> 2Diommu_MWHPR10MB1310CDB6829DDCF5EA84A14689150-
> > > > 40MWHPR10MB131
> > > > > >
> > > >
> > >
> >
> 0.namprd10.prod.outlook.com_&d=3DDwIDAw&c=3DjOURTkCZzT8tVB5xPEYIm3Y
> > > > JGoxo
> > > > > > TaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> > > > 862rdSP13_P6LVp7j_9l1xmg&m=3DlNXu
> > > > > >
> > > >
> > >
> >
> 2xwvyxEZ3PzoVmXMBXXS55jsmfDicuQFJqkIOH4&s=3DdsAVVJbD7gJIj3ctZpnnU
> > > > 60y21
> > > > > > ijWZmZ8xmOK1cO_O0&e=3D
> > > > > >
> > > > > > is that this is a board developed by his company.
> > > > > >
> > > > > > Edgar -- please can you answer Alex's questions?
> > > > > >
> > > > > > Will

--_002_MWHPR10MB131082779A86BE4CCCF190B789CB0MWHPR10MB1310namp_
Content-Type: application/octet-stream;
	name="0001-PCI-quirks-Add-an-ATS-quirk-for-a-Picasso-APU_customized_nr3.patch"
Content-Description: 
 0001-PCI-quirks-Add-an-ATS-quirk-for-a-Picasso-APU_customized_nr3.patch
Content-Disposition: attachment;
	filename="0001-PCI-quirks-Add-an-ATS-quirk-for-a-Picasso-APU_customized_nr3.patch";
	size=1660; creation-date="Thu, 10 Dec 2020 10:39:00 GMT";
	modification-date="Thu, 10 Dec 2020 10:39:00 GMT"
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
fHwKKwkJICAgICBwZGV2LT5zdWJzeXN0ZW1fZGV2aWNlID09IDB4Y2MxMCB8fA0KKwkJICAgICBw
ZGV2LT5zdWJzeXN0ZW1fZGV2aWNlID09IDB4Y2MwOCkpCisJCQlnb3RvIG5vX2F0czsKKwkJZWxz
ZQorCQkJcmV0dXJuOworCX0KKworbm9fYXRzOgogCXBjaV9pbmZvKHBkZXYsICJkaXNhYmxpbmcg
QVRTXG4iKTsKIAlwZGV2LT5hdHNfY2FwID0gMDsKIH0KQEAgLTUxNzYsNiArNTE4Nyw4IEBAIERF
Q0xBUkVfUENJX0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfQVRJLCAweDY5MDAsIHF1aXJrX2Ft
ZF9oYXJ2ZXN0X25vX2F0cyk7CiBERUNMQVJFX1BDSV9GSVhVUF9GSU5BTChQQ0lfVkVORE9SX0lE
X0FUSSwgMHg3MzEyLCBxdWlya19hbWRfaGFydmVzdF9ub19hdHMpOwogLyogQU1EIE5hdmkxNCBk
R1BVICovCiBERUNMQVJFX1BDSV9GSVhVUF9GSU5BTChQQ0lfVkVORE9SX0lEX0FUSSwgMHg3MzQw
LCBxdWlya19hbWRfaGFydmVzdF9ub19hdHMpOworLyogQU1EIFJhdmVuIHBsYXRmb3JtIGlHUFUg
Ki8KK0RFQ0xBUkVfUENJX0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfQVRJLCAweDE1ZDgsIHF1
aXJrX2FtZF9oYXJ2ZXN0X25vX2F0cyk7CiAjZW5kaWYgLyogQ09ORklHX1BDSV9BVFMgKi8KIAog
LyogRnJlZXNjYWxlIFBDSWUgZG9lc24ndCBzdXBwb3J0IE1TSSBpbiBSQyBtb2RlICovCi0tIAoy
LjI1LjQKCg==

--_002_MWHPR10MB131082779A86BE4CCCF190B789CB0MWHPR10MB1310namp_--
