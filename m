Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8930639D392
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 05:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFGDn2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 23:43:28 -0400
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com ([40.107.223.64]:14177
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230247AbhFGDn2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Jun 2021 23:43:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5N0wyEn4KxXt1EB91M7uk/C/SfN0KAZw5dMh+21CB6xfRty3N6q+fBPgrQWVH8fL39FWkTDNM23KQX1+KQr4aV/39RORxv2qcLv46nOoVioHqalYr1Jgksv59PSlOciZ9n3OYr7dJKdbTCjnZwwZU8NfhheZd/i1FWpK+Cup3GzBNiN+HIclskdDORPSdvdJLaB88gzcvmEyJy+1AbKq9W1pc3BaJl+M0/yqB/I4NVM6dRy9dATP+mfe0q0Qq8+N5BMjxG5bnpoPZoM6a1LYjBRQpdo11Up1EGet8X2FWAuU950lMZOng0se59pYyEMSgvhRtVGs+nw/YEM+f81ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pre/IDaJHSMP3uuFWl1Dw/ATV0bwfwPbp4QAjWfcc8k=;
 b=PD1kULQN+SIUM3XNLeaNtlSBiQaGvoUIjq+A/06Qq8ldmhcdhLnoT44s/b/USZKdLx51cxYa47pQiAKimoKNPx1G+UTWk96gVxkaHYlOkwJ/N9h0+15x9WT4QFB9le/nqDlepV4tSJewYHKaIL23U/BA2+GqLThhDFxv9YQl8Agvlu9L2x0bUurJUOzhnF+/OE4H/KLZkaSeUfKwpbW4rAuG6YCIXalZ7yaITklkzLGuGlYzNi7ezelmT+4xsHTlso5bSi9VkmqOrZQ14WMKq6ghY+RQtHjNxCb9IeqEeDxmaRRgcGR0YoSaBkwBQi5ucelU7udheYGU+bwvzMFz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pre/IDaJHSMP3uuFWl1Dw/ATV0bwfwPbp4QAjWfcc8k=;
 b=5VUQszJCubr2xo9KDuf+VgPUJ9aquVN2/b9jIAMFveamEVxOCwPPaurYj2ga7Zq36F754eKObIpTeGGpbtbEQNurGhnOvmDuOIjLkV+9rf0zwimyGq2jtrBKe2Xhagsx+LpR0gnbvWsqbSkTirYjbZW90fVTAFnNcn2ufkTcpqA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Mon, 7 Jun 2021 03:41:36 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 03:41:36 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kw@linux.com" <kw@linux.com>
Subject: RE: [PATCH V3] PCI: Add quirk for AMD Navi14 to disable ATS support
Thread-Topic: [PATCH V3] PCI: Add quirk for AMD Navi14 to disable ATS support
Thread-Index: AQHXV1TZTnBXqm8pwkWr7vNuJHZi3KsEWkkAgAOUOuA=
Date:   Mon, 7 Jun 2021 03:41:35 +0000
Message-ID: <DM6PR12MB26193FFC56E703A01CCC382EE4389@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210602021255.939090-1-evan.quan@amd.com>
 <20210604205914.GA2239197@bjorn-Precision-5520>
In-Reply-To: <20210604205914.GA2239197@bjorn-Precision-5520>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-07T03:41:32Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a06cc056-f1fb-42cc-85ea-9c8e1110fb40;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f78bb23-6510-4484-19bd-08d92966269f
x-ms-traffictypediagnostic: DM6PR12MB2892:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB289238741D6A0E4FF14CE341E4389@DM6PR12MB2892.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5I66fEO/gbD9+Jq6sTo2jza5hnhEgvfdvlz/5NKUxZ/YKHHMxByY/JZA0zCltYfaS6y2mZgHN2EV7ztAZU2UW0S/YDohoRQhA95uiBv3qeOSKwCJXxOEP85AP3WWAYLs/8TFwDZxnW1P+Z9h6RXEjbQYyBWUeCRTM6BUPJPjT6lRD8V2lvjEMjjSIUCGdaNgAcoWTOIIFru/35sSS/lJmQ+HtbPSRN936c2TOd9qjc7oFcmPbbEEm1AD425e2H/w8k6LMFztwoAfuNtnVgrXAHLQi6p83QZroCiaJGEWqzgR+sezA4bzAuAP7mN7tCk6vC1/UkccrlxZlzmzBzsMysbIUAtmIhE1rc+4mlGrEQbidUfrgtnhGkR2DitwJ8U6EGpW0QddczQ/aJsSjbeFvkBFU545p6zRr0I5oTMtTIVilGWxt4SEu6TNu2LLxNJe+HRHrocPDNoSFZEEeucv6R89mbSTp+ZGA5nhV0bDs3GDc0ipzxldTRZpyNookGo9aVj8n63RWjpdIR0y7P7lGFOZKTq1nXiJHQscvOjMtt3dMd/ykfJJNAI7NVKMUVMb+7sQ5v0XnZOoBCDMOo0SQFidhV4ZADzeS82RHCA+jczmvHML1b0EWX0M+RIBuT+KfTWX+V2mwPa9VzfOf0CyagdheJMiwt3B7068yFAooElPGqrElqnU02qFERRSXxxruAxAUSOzl2Q348mGXKAchi8hnksHB0360PJUVnyow3U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2619.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(26005)(38100700002)(53546011)(6506007)(4326008)(6636002)(9686003)(186003)(2906002)(110136005)(54906003)(83380400001)(66574015)(8676002)(66476007)(33656002)(71200400001)(66946007)(5660300002)(86362001)(45080400002)(478600001)(76116006)(8936002)(316002)(55016002)(122000001)(7696005)(966005)(66446008)(64756008)(52536014)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?029IY04JXCWy0YbuHaeTCurVPSJGT5F9ftKjqRIq9ckrY7aiZNgSfhWQ+w?=
 =?iso-8859-2?Q?qouX76HJTemShP57F6mfrqIcyF3sa3CNx76dFcG1Le44Z2YkPU7F0759jl?=
 =?iso-8859-2?Q?eQF3wttE2lXQnTEyYzhMjX8eAs8heR9fVkRtiu/j6BSb9TuV/7FOK59OGI?=
 =?iso-8859-2?Q?j3UvgcHW4Qj1rNsJfBZNyPH6TF005Uonyebi6+Ti1KS3GuU75aSzDDVYDB?=
 =?iso-8859-2?Q?VOiGwAt722AewdKci2exK1Hv5Qiso7leMV752A5GZ63WJ7ACx90fPSXw8I?=
 =?iso-8859-2?Q?EADwCg+004NjouwCu8nbgwSDsXBcBLcPKJTeWennv54WgaiAZEEgsHYpMI?=
 =?iso-8859-2?Q?u+KTBofbq1EN73z28FouYitVQdG3B7KItdI009v/Q9uw4qb0dVUvL68gCx?=
 =?iso-8859-2?Q?X1aStdbb2XwVqZ7yzbA3xBdKdMH80Qbm3vMlpMrrjYBJFN7TU3nCg3qt2d?=
 =?iso-8859-2?Q?DUIe9ubCDLYGdncY5h+7dDkZtYINqwN7vySqIhR64rC6GRzRW+sQJuCpeq?=
 =?iso-8859-2?Q?9Ysbz6EwXg38HHqzq7YcaZkNHKqqLBSP9saNiJuD2Vp7bXn+V9KbHraUrD?=
 =?iso-8859-2?Q?Rqh7MX9B+3+/2mxjcdnDHJzwAKXj4WJs8nLigK9TaG1XhUqmMfnqdlFEX4?=
 =?iso-8859-2?Q?/VYpkntxqoZmgYfscG6AcRFUUHWecarl1wFVoyBnyH67S+UHDR3VIIgqVW?=
 =?iso-8859-2?Q?ztx5sA7UIAn0LGXuZ80JnmiqZB0gDT9Em95Bc1zIILa+YB35HqdKPA/Sq1?=
 =?iso-8859-2?Q?mRslsTdlt8M+CAjfGQuLUThYuNSBgQDiNpOolundckWnNtVSqKnDqLx6rO?=
 =?iso-8859-2?Q?GGUjcD7t3w7VtjiZc7wWkMUsM6026L0bm10yd0VnQF9hsqOYbzc1Eu55Q7?=
 =?iso-8859-2?Q?Yyroq+aklYnpOKXGcV/faN+auPo0IARqj0rPuSO6WtBa3eQiIwCpdyNkSU?=
 =?iso-8859-2?Q?IJqDz4CDpL/MCx8Mt/lzvpt1G6WvjFjhQJSivNqgRfA/ITuDYe/HJRWQAy?=
 =?iso-8859-2?Q?8G6EBzwqZjEK5Hn39jF13eAuKaZ5vzy5YGv2aGoT3Mubr9IE1Vxq6t1J7g?=
 =?iso-8859-2?Q?35s0385X2NS+WWz1YpecYFb0Dg8C9r+4UD8lmZDynhPt4BiwOQgfNwGCo1?=
 =?iso-8859-2?Q?IUN8uJC8ZPC5rnYNXEQyY4+Otn/y+WntYQVVkDUgfuv8Q8Exv1o9yCuW3m?=
 =?iso-8859-2?Q?5HBIgkOif/8rHtA7ZPFc6FB0n2XGUIZPTPRDX581PBfqAXeXp8Bq2+LXNx?=
 =?iso-8859-2?Q?zhG8ZkIEHBlpunMqOgYxpU7Wh6yqYsoJECAVc1ZMO5LQDvNVLQnYamk5Qu?=
 =?iso-8859-2?Q?Pkwhefgch/1w6nQIj157FqBkkgteM3oyg8KoNMzUNQUaqw/HAfClWLzUWG?=
 =?iso-8859-2?Q?hdfzUKMBqu?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f78bb23-6510-4484-19bd-08d92966269f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 03:41:35.9050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DVg0csglVAbu2ZdrNzzSzDyTJwR4mun5oruSsXwU/tGMpxFZP81FOc4/S26VxLQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Official Use Only]

Thanks Bjorn.
@Deucher, Alexander can you advise whether this is needed for stable kernel=
 branches and which branches if yes?

BR
Evan
> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Saturday, June 5, 2021 4:59 AM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: linux-pci@vger.kernel.org; kw@linux.com; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH V3] PCI: Add quirk for AMD Navi14 to disable ATS
> support
>=20
> On Wed, Jun 02, 2021 at 10:12:55AM +0800, Evan Quan wrote:
> > Unexpected GPU hang was observed during runpm stress test on 0x7341
> > rev 0x00. Further debugging shows broken ATS is related. Thus as a
> > followup of commit 5e89cd303e3a ("PCI:
> > Mark AMD Navi14 GPU rev 0xc5 ATS as broken"), we disable the ATS for
> > the specific SKU also.
> >
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > Reviewed-by: Krzysztof Wilczy=F1ski <kw@linux.com>
>=20
> Applied to pci/virtualization for v5.14, thanks.
>=20
> I updated the commit log like this:
>=20
>     PCI: Mark AMD Navi14 GPU ATS as broken
>=20
>     Observed unexpected GPU hang during runpm stress test on 0x7341 rev
> 0x00.
>     Further debugging shows broken ATS is related.
>=20
>     Disable ATS on this part.  Similar issues on other devices:
>=20
>       a2da5d8cc0b0 ("PCI: Mark AMD Raven iGPU ATS as broken in some
> platforms")
>       45beb31d3afb ("PCI: Mark AMD Navi10 GPU rev 0x00 ATS as broken")
>       5e89cd303e3a ("PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken")
>=20
>     Suggested-by: Alex Deucher <alexander.deucher@amd.com>
>     Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fr%2F20210602021255.939090-1-
> evan.quan%40amd.com&amp;data=3D04%7C01%7Cevan.quan%40amd.com%7
> C2999a40d134142c2fdd608d9279b9ddb%7C3dd8961fe4884e608e11a82d994e
> 183d%7C0%7C0%7C637584371596788532%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C1000&amp;sdata=3D%2BgYq6SPJNCgqj%2By%2BLzkAGjmm5TONhApdYlze%
> 2FFz%2FiUM%3D&amp;reserved=3D0
>     Signed-off-by: Evan Quan <evan.quan@amd.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Krzysztof Wilczy=F1ski <kw@linux.com>
>=20
> > ---
> > ChangeLog v2->v3:
> > - further update for description part(suggested by Krzysztof)
> > ChangeLog v1->v2:
> > - cosmetic fix for description part(suggested by Krzysztof)
> > ---
> >  drivers/pci/quirks.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > b7e19bbb901a..70803ad6d2ac 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5176,7 +5176,8 @@
> > DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422,
> > quirk_no_ext_tags);  static void quirk_amd_harvest_no_ats(struct pci_de=
v
> *pdev)  {
> >  	if ((pdev->device =3D=3D 0x7312 && pdev->revision !=3D 0x00) ||
> > -	    (pdev->device =3D=3D 0x7340 && pdev->revision !=3D 0xc5))
> > +	    (pdev->device =3D=3D 0x7340 && pdev->revision !=3D 0xc5) ||
> > +	    (pdev->device =3D=3D 0x7341 && pdev->revision !=3D 0x00))
> >  		return;
> >
> >  	if (pdev->device =3D=3D 0x15d8) {
> > @@ -5203,6 +5204,7 @@
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,
> > 0x6900, quirk_amd_harvest_no_ats);
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312,
> > quirk_amd_harvest_no_ats);
> >  /* AMD Navi14 dGPU */
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340,
> > quirk_amd_harvest_no_ats);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341,
> > +quirk_amd_harvest_no_ats);
> >  /* AMD Raven platform iGPU */
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8,
> > quirk_amd_harvest_no_ats);  #endif /* CONFIG_PCI_ATS */
> > --
> > 2.29.0
> >
