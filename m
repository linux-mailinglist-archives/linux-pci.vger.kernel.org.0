Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E442C1E0E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 07:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgKXGSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 01:18:32 -0500
Received: from mx0b-00300601.pphosted.com ([148.163.142.35]:10884 "EHLO
        mx0b-00300601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727946AbgKXGSb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 01:18:31 -0500
X-Greylist: delayed 2647 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2020 01:18:29 EST
Received: from pps.filterd (m0144092.ppops.net [127.0.0.1])
        by mx0b-00300601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AO5Rn1h012760;
        Tue, 24 Nov 2020 05:32:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0b-00300601.pphosted.com with ESMTP id 3509dcqc8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 05:32:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEzqsCqv1V7ThAPS/bbUb0I6qC6XI/2kKRokic2Ii/n021/To+i4ZkgQ5KEn4FIzDVLCKH/knHnQnVcmah/21z/p9+BMW9nk9teQTbEkWpQ8Hi5ZpENLUb3qtS3q8bAcEBscJLKfCOuW0STfDaj1UfVvF4Ph3S26h31lWKjwlnRvPNToRpyPvMTuetzMp6goSmDd8beFYrxmSuTLyTavbCV4E3qYNBWqtaPVvbCq1vqKdJoRcBpxwNGY9pgNmo0LThbSSBYoHd80+dDb+3DKiNEV/vWe59gkjLk3RQHYVlYkayRNIO+372jGphsWchevXWucfn4/anrh8N6XxesG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnWxVrkxMjiJ1F35Qg6FnG7Ly85GR8/BJfeA3VoPQrA=;
 b=Uhht0sRdrec/OW8LEQSc2uZ2wWidz5TL6+cHf2h7oh3NcIvQWC+DAG1sm7m8/Rxy+afJ1GOt0LN2ddplnpQMkvJQY5fT1FiAIZYJy9XCvFunWxeeuXQ4GE6hrhUgyQ0S5u0lMPVLDKKCdqH+/NqLdVQcIdnitSSb+eCwj5lyOvQ0nUInT1QuNmAqjN++ZVKhQibF2hDK9U0cppbjJMS7z94J8rcrL8/nUdmeVnCqVkKwPJFBknTXPotGWJPff9VNRXHOyfHBTWyjwtKfuQEGMF6nuqP/McW1d4DQ54veXS3SwnwI07ikGhAJOZHW1FdpWQ6E5EuDo2xMtxAU6QqjTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emerson.onmicrosoft.com; s=selector2-emerson-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnWxVrkxMjiJ1F35Qg6FnG7Ly85GR8/BJfeA3VoPQrA=;
 b=bnNydjDCheMHtUDKQwf0Vcv718WVeinksi5gSfeEwZNDetfCtpG2tgCnXg/W09+GI3+MeVNnwXb9x/M9UeSIoqBJUU+zaiseYtiGbZfm8RP9zWjXCsVm5+hgRjSw/TmRvVfLGwfxtTdlDhHvk1Ze3pmyrzeY0nnqJEhGmwJ1LCM=
Received: from MWHPR10MB1310.namprd10.prod.outlook.com (2603:10b6:300:21::18)
 by CO1PR10MB4481.namprd10.prod.outlook.com (2603:10b6:303:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Tue, 24 Nov
 2020 05:32:12 +0000
Received: from MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e]) by MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e%12]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 05:32:12 +0000
From:   "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>
To:     Will Deacon <will@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Thread-Topic: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Thread-Index: AQHWwdw3n5VLcueYHUSP0T6AMdoDgKnWTbwAgABu3qA=
Date:   Tue, 24 Nov 2020 05:32:12 +0000
Message-ID: <MWHPR10MB1310DE70BAC5A86892D5398B89FB0@MWHPR10MB1310.namprd10.prod.outlook.com>
References: <20201123134410.10648-1-will@kernel.org>
 <MN2PR12MB4488308D26DB50C18EA3BE0FF7FC0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20201123223356.GC12069@willie-the-truck>
In-Reply-To: <20201123223356.GC12069@willie-the-truck>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=emerson.com;
x-originating-ip: [2a00:79c0:797:6b00:2523:54e2:cc0f:eaa4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2734ff5f-f7fd-4cf1-9117-08d8903a4be5
x-ms-traffictypediagnostic: CO1PR10MB4481:
x-microsoft-antispam-prvs: <CO1PR10MB448144FF01B40462171508A889FB0@CO1PR10MB4481.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fpLIHYoGImsQLFN0cPHQkVyg1ZwA0yTuN+WbxIQjQZfvtJEtRRyGfe2igLj1wo/89OFT/vM4Pzq1Jk8k/HpwjGoftyRm+svKtINr/pXWYIa4MbUf3yTph2+eg/AjLyWamzjWcRkc0WJ7Q7w2/6Njoyx4VWNIHVodcqF/IVwyoqhs4JMixgpGAwGfDQfPe0OVg10q50rQKHl/gjMu4kV9e0mNaL9eE4mAHtsrbcDbcw/Zf8I5j/u+JVVt3pBuL1LCnYSXnLuj4mj7S7xClRswIjSFq0heVGyuWiDRAWg2OMvwUOhuzAm5+pcmFxKo1BlNjFoGKaRuiL1Dyx8IpGPPSXCv3aqb6Bc18wsIZvWBEpw9ypVU/4TDKTliCdQX+wGzfWPdL3twk7l4X2DVCnVZUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1310.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(366004)(39860400002)(52536014)(83380400001)(5660300002)(8676002)(186003)(110136005)(316002)(966005)(7696005)(45080400002)(64756008)(86362001)(8936002)(53546011)(478600001)(6506007)(66446008)(4326008)(9686003)(66946007)(66476007)(76116006)(33656002)(2906002)(71200400001)(54906003)(66556008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?zSNctf8RFHXkmgKsI55TFdNKCZasVoS8tX1qCIC0zTLhlpizyVmh/M3XS+?=
 =?iso-8859-1?Q?vEjg06yYYXPwbMs+WkHdN6jJtdxYlXWqXfCYVXHvCPfITkfXxetTH01l2e?=
 =?iso-8859-1?Q?g6kaxQzEbOaGUN9bYleiu5FBklw32xDyhEC97OqJZK2LLOxyyN+xC7VZKy?=
 =?iso-8859-1?Q?bmGOELZafbKaIp3oO/WhdiA9l4/CxDrZcgRcd2dYcaDK+c9XU3ZyHE9nN2?=
 =?iso-8859-1?Q?TEI+vi+9WO9sfMIM/uLS/38s6yenRRBDDAznQu9RbgiP5lFlW77Pa8rLJ6?=
 =?iso-8859-1?Q?qNrsJL14UBgelMQeAdfw9jD6+6drDTXuAKWNlszXRZQ8nqAsOjcjjlqCM7?=
 =?iso-8859-1?Q?qGIwsnXqrhOL/c7aSIt1kjPjwWpn34prg+2owgc1PS0c5Ziy75zF5i6qGX?=
 =?iso-8859-1?Q?HM4InQ+LZ1GtuNKe1+aY4AkZnluBvee1B2F6r4BjcZ+8ayuu2fxbhc/JAF?=
 =?iso-8859-1?Q?uYFJEe/Q/GvfUbn7+pCgYZcHiKx3vp/6dzeH/sJY8Kya4u86mZeDwOQphK?=
 =?iso-8859-1?Q?6paEfUNLjUA/Wrh1tiC78NpY7ypbCC6xoXBhx8gTgfi0t3f7/UBBvmoreZ?=
 =?iso-8859-1?Q?QqpZKZ6/2M7HYdYRqypQvQr/2PInJuOFQ7fFq5SVZci7AfUFmtH5IZE6DR?=
 =?iso-8859-1?Q?IkK33QuTzEZMODKR2U+gSn2SuwIoHSQU5UIWsZpCIYmPqFKGhQ38CYka5W?=
 =?iso-8859-1?Q?l4WJvwKzG3iZnkBht1h9bDXQw9NUyEvpgdg0mjqbfBbitm8GZX0Astr2Ot?=
 =?iso-8859-1?Q?9zWo8WKi2QdGxtt3oFTGtL3nmARUsw9ePmcdQySUEW99iwbMHzkpBefLCK?=
 =?iso-8859-1?Q?AKNXvPI6d5h3SL+hZBOgKslqTx7TXsujvQN3c09d1jIJTvwVQ+Z4Hp97y3?=
 =?iso-8859-1?Q?C2jNglpCeP5oTUSnKzk4kQL2/EFhrJhazK18mPyrDJbZRUk3TGmd/XVKwE?=
 =?iso-8859-1?Q?G9YdAyX+DsVZPJvnmJqwSn19fl7KqS8nCGm+h5QW925wHvghuzcxpQ=3D?=
 =?iso-8859-1?Q?=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2734ff5f-f7fd-4cf1-9117-08d8903a4be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 05:32:12.6964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPWT7WqPMLiJAhyM2YlKECuyXBmorS1f9S/10DozyGK+11lwF3XCM2wrY88sLChIGhKZMaTgXGWGlUBY4FogkO3C4DhiKvBItZU1DJzJCzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4481
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_01:2020-11-24,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1011
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240032
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a board developed by my company.
Subsystem-ID is ea50:0c19 or ea50:cc10 (depending on which particular carri=
er board the compute module is attached to), however we haven=B4t managed y=
et to enter this Subsystem-ID to every PCI-Device in the system, because of=
 missing means to do that by our UEFI-FW. This might will change if we upda=
te to latest AGESA version.=20

-----Original Message-----
From: Will Deacon <will@kernel.org>=20
Sent: Montag, 23. November 2020 23:34
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; iommu@lists.li=
nux-foundation.org; Bjorn Helgaas <bhelgaas@google.com>; Merger, Edgar [AUT=
OSOL/MAS/AUGS] <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>; =
Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken

On Mon, Nov 23, 2020 at 09:04:14PM +0000, Deucher, Alexander wrote:
> [AMD Public Use]
>=20
> > -----Original Message-----
> > From: Will Deacon <will@kernel.org>
> > Sent: Monday, November 23, 2020 8:44 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org; iommu@lists.linux-foundation.org;=20
> > Will Deacon <will@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;=20
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Edgar Merger=20
> > <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>
> > Subject: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
> >=20
> > Edgar Merger reports that the AMD Raven GPU does not work reliably=20
> > on his system when the IOMMU is enabled:
> >=20
> >   | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout,=20
> > signaled seq=3D1, emitted seq=3D3
> >   | [...]
> >   | amdgpu 0000:0b:00.0: GPU reset begin!
> >   | AMD-Vi: Completion-Wait loop timed out
> >   | iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> > device=3D0b:00.0 address=3D0x38edc0970]
> >=20
> > This is indicative of a hardware/platform configuration issue so,=20
> > since disabling ATS has been shown to resolve the problem, add a=20
> > quirk to match this particular device while Edgar follows-up with AMD f=
or more information.
> >=20
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Reported-by: Edgar Merger <Edgar.Merger@emerson.com>
> > Suggested-by: Joerg Roedel <jroedel@suse.de>
> > Link:
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__nam11.safelinks.=
protection.outlook.com_-3Furl-3Dhttps-253A-252F-252Flore&d=3DDwIBAg&c=3DjOU=
RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-862rdSP13_P=
6LVp7j_9l1xmg&m=3DWjiRGepDgI7voSyaAJcvnvZb6gsvZ1fvcnR2tm6bGXg&s=3DO1nU-RafB=
XMAS7Mao5Gtu6o1Xkuj8fg4oHQs74TssuA&e=3D .
> > kernel.org%2Flinux-
> > iommu%2FMWHPR10MB1310F042A30661D4158520B589FC0%40MWHPR10M
> > B1310.namprd10.prod.outlook.com&amp;data=3D04%7C01%7Calexander.deuc
> > her%40amd.com%7C1a883fe14d0c408e7d9508d88fb5df4e%7C3dd8961fe488
> > 4e608e11a82d994e183d%7C0%7C0%7C637417358593629699%7CUnknown%7
> > CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> > LCJXVCI6Mn0%3D%7C1000&amp;sdata=3DTMgKldWzsX8XZ0l7q3%2BszDWXQJJ
> > LOUfX5oGaoLN8n%2B8%3D&amp;reserved=3D0
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >=20
> > Hi all,
> >=20
> > Since Joerg is away at the moment, I'm posting this to try to make=20
> > some progress with the thread in the Link: tag.
>=20
> + Felix
>=20
> What system is this?  Can you provide more details?  Does a sbios=20
> update fix this?  Disabling ATS for all Ravens will break GPU compute=20
> for a lot of people.  I'd prefer to just black list this particular=20
> system (e.g., just SSIDs or revision) if possible.

Cheers, Alex. I'll have to defer to Edgar for the details, as my understand=
ing from the original thread over at:

https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_linu=
x-2Diommu_MWHPR10MB1310CDB6829DDCF5EA84A14689150-40MWHPR10MB1310.namprd10.p=
rod.outlook.com_&d=3DDwIBAg&c=3DjOURTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo=
&r=3DBJxhacqqa4K1PJGm6_-862rdSP13_P6LVp7j_9l1xmg&m=3DWjiRGepDgI7voSyaAJcvnv=
Zb6gsvZ1fvcnR2tm6bGXg&s=3D9qyuCqHeOGaY1sKjkzNN5A6ks6PNF7V2M2PPckHyFKk&e=3D=
=20

is that this is a board developed by his company.

Edgar -- please can you answer Alex's questions?

Will
