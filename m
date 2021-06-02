Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC8397EA3
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 04:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhFBCQ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 22:16:59 -0400
Received: from mail-mw2nam10on2063.outbound.protection.outlook.com ([40.107.94.63]:46817
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230030AbhFBCQ5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jun 2021 22:16:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/X0IQ+fb6alISUxsOQ05Y4MYJYZgihr3Hcmc5Fv8Tju8Nfdpwy3R2l91hA/21q98K2ThDnu6x2/65natck6Iv6vebFAI+LST8CpSZRJxeSvZ1MvUtpYpYXjnuD/+/J5ljRKHvNAs4UXOJc+uGiYMDi1cMYJMGtaTp8HSOJkXUlvyj3saeZiLNjVa+ZB+uWF38g2SvfvoSdIgKre7kZygEtybI8PCWqTbyzXXpazzc1Em5LaKziGw19zDSmNJdcty6M4KtcikU2/OxtlteLPNTtXykDyigg6hwNddJf88kjjcyoGYbGC7NoewFvanGueKttIwoJ0ul0ZLWAr37qFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHH4eDW516ts0//lnqKsziBdezSS1mA+YHQ+LB/cQHw=;
 b=m4H5MbRHWFKAswtAt2eMM/N1KRIGhijgmRA4rsXnHVRFeK5j+psjhp3AfhG2lstGz0AcsZmqYtwFZqriVOpCJ5Rjv1jjXEAVjuNO5+r9S9hYWHIfanMIbiHnRfZoDblqZpRzkeyKlF64UU9+qO/i2sd8fH+x+g1IRUlTd8I+0M7lZBS0q2RZQrLgcMKmdiOg7HXnGVD31P6/gySupztqsMRJwa4Xls7BtNdf3dsc0w6LAf3xBrlqsXkvBaYhIpHXcUKfwmef7tKZRdZ/5OWwbL24p+u8gYSHyndZ6hTaWbUu3U/zxYhFlAbhJZswQhBTj8Qcn+bSn3GPSZ7CR9GY6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHH4eDW516ts0//lnqKsziBdezSS1mA+YHQ+LB/cQHw=;
 b=Bpyufl3aav3A2HpkUfbq3oKyNkNlIGUj8e6WG/6rQCJgqpllIRuYUOuhiHr/LJFKA2+x9DMz6/IxG85LAhXp1lQwmkJwhkuukf7/Q0LL3Gr90cdXGPBzkYsUBcGqmH8Nqe/9QptLsnmcCRea4AhO1V7E4vto0zaJfHCmAeZqCjM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21; Wed, 2 Jun 2021 02:15:14 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 02:15:14 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] PCI: Add quirk for AMD Navi14 to disable ATS support
Thread-Topic: [PATCH] PCI: Add quirk for AMD Navi14 to disable ATS support
Thread-Index: AQHXVpCwT+4tLdxONEmxJXkhEyfZIqr/ITmAgADbl7A=
Date:   Wed, 2 Jun 2021 02:15:14 +0000
Message-ID: <DM6PR12MB261928E4DE8B552FD3172BA6E43D9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210601024835.931947-1-evan.quan@amd.com>
 <20210601130813.GB195120@rocinante.localdomain>
In-Reply-To: <20210601130813.GB195120@rocinante.localdomain>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-02T02:15:12Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bc0fedf6-6a80-42c1-9ab9-23ae794b832e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf3f57ae-4dac-4d52-16cc-08d9256c41ed
x-ms-traffictypediagnostic: DM6PR12MB4484:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB44841A367EBEC391D4047956E43D9@DM6PR12MB4484.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dEwX9i+PlvH/SdqZUH4bGjBN7MHVFveJEmkA3KSq1VNKpqNtacS6+xcjd+mSWb2Ds9GhlHR05cKMqzxd4qwXQfaPFmOvANIDXMJcJY9zoLkrxcMraSw2OwBOaPe01ls8bkitEHhUGLRJQGZBrJBfwqp56OwUPegOXiih5NaIEm6Hy6egR90DULlo+euqH2aTnea7kdefb0Ket27NsZcTDhcVgwVEyR/UOA/MDRXtD3tlA0B2YXqnv07qj8YLqtQkjZ0ug5x7y9RCGrJlRs7C0WHt1SEeYqTprSaAiwmlWzU3OUfHxcP9h9LFjaUQTuC9RDVWNH/QMO5Kx0UKvlLf4uC6e+bCtgmneBo2hLGk4S2BR3GET+qOoba/6Xjb2PbgsrsI1IEhiF+oSaoFvrXq+6YKxs/vr7pLx+t8o4P4pNAphN1zhXDFyAB9M3xluPDH/WLdmL8XSm2UjSAx8/IMRDmQ7EwGttfEM1ohlWG0CP4nveuYgfJCdJvThTzoWurvy7cRsAnNtdwBP7TTp3tPdovpvAOktkjuJUx0MyYOxxlubtaN2zjMhzYu5yhj7O1R3fcovzCaT0m3epCFlh3cgi4joufO2/Vra62jO3UsgUcLaBbEHMlks7s1EV2dALLpXeDiAQaGX0E+/SdJloJHHc3gXx2lW8VeVlA85uKKpE/VmtZa4VC6LOyWiWamgz6Pz67Ptj1a22ayVslV9/Q4eUnMz6U7CRk1y86fRozL/xk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2619.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(45080400002)(966005)(8936002)(53546011)(54906003)(86362001)(478600001)(64756008)(66446008)(66476007)(66556008)(5660300002)(2906002)(76116006)(316002)(6506007)(71200400001)(7696005)(38100700002)(122000001)(4326008)(66946007)(55016002)(26005)(6916009)(9686003)(83380400001)(52536014)(186003)(66574015)(8676002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?sbEOFfNmo5qzFGcuEhFBeoxLrVD7908umGUrs/XN7k6nIZBxMB8hfmnQJX?=
 =?iso-8859-2?Q?mWQFwGvK3qYzVdpvo+F0ej7i5yK4BZhPavMFbsebrknWasOaTBGqBWRK+n?=
 =?iso-8859-2?Q?yojdorlLGiXXdSpUMslOorFaWofELzXtUQqGblGzhGN69VzHgne8V6Z5W0?=
 =?iso-8859-2?Q?/0o1EGQs7e7syqU7/hDEvdZLDm1ZggISvKh1k1xj+LqPgDW0Rkas04Lkme?=
 =?iso-8859-2?Q?O20kRzO9R1KyW/hygZqd+hXNFkW7OI8QFFUR6Yy4CY3pBemb1hAeKpeqWd?=
 =?iso-8859-2?Q?Z014U5RmrRaKm1809yziN+K9MpDwLLd/xRpimCqyIcsczdK5NpkY6w5J7O?=
 =?iso-8859-2?Q?Sf+IooT0lg2aTSC+k8QIY2kN5Yd9UFkax9RFrI2UvOY0dB4CCTxZnKJeAg?=
 =?iso-8859-2?Q?T2Atu2TecFZAYJKOSEHagEfpX4904A21xdSvdUc86Rra2yEIWsR9XRDZ/Q?=
 =?iso-8859-2?Q?Lio6Hth3N+Na2HhQ+GkaU6IxuxPQTLdX6YEdvaB5rPZ/oqFDGhAIfWwjsU?=
 =?iso-8859-2?Q?lHg8fqrVOMICn1zx0K+WUayJOdrU4ySiQmpIUZGJZ7qF5QGeulVDxJ5ZNY?=
 =?iso-8859-2?Q?u6r/SVhKzlca32kzDFK9HMGZ4mfEh7dg0i5eyq4+ANNfDDMDYX9EmPFGDo?=
 =?iso-8859-2?Q?FCl0yF+MkEWpfsr8XiVIDoo/O3nF3dGK+0f64dOvm8ftsAwhPYjNHkbtaC?=
 =?iso-8859-2?Q?jwcMnLDRrsu3GRWfCxAfLKHJO9oXrvgoLYcWxHw/2FRY8k7iWBQN8R8oVW?=
 =?iso-8859-2?Q?jEl4dCOsytNnVfYtonFNq7/PJY44GUU5lHjxcjpRmYLRypgoK3cAGTd9di?=
 =?iso-8859-2?Q?fJQY1ahS0CtY1+oDwCs1c077O4UfBEzQvuNu9YC0KFGcwwRPf+z/mBneKn?=
 =?iso-8859-2?Q?BVgbzjpKcq6BNWA+m2Zdf6rjznzLk7AWju3QXVe45tYifwzYDMlWTXZr8A?=
 =?iso-8859-2?Q?FY4H5O9DP1Wf9UvogJBF21U9yO6P4xeANLP+KSOweNSQHh2jQJcYNfCsn3?=
 =?iso-8859-2?Q?hBFiqBnWLkxmYZ5pZOcoc3WLnsufGlwV9BEGhVT1xqE7pBHkFauSY8qSyf?=
 =?iso-8859-2?Q?smXy0tl1cDlo7VG+feXXb1dO+sWzyOEUi0fhxwRECHgqiHwyR5Uq4gEqam?=
 =?iso-8859-2?Q?BhNdOeWCvv5Wn5F8Y7NH4AFvWbE5cew4zoRHNlT5iPfZNnFPynohPyNW9D?=
 =?iso-8859-2?Q?4lYNxNODQL/Jgm8A86yC4taweSQ60u7ykIKOkdVXtZWW/CNh8zxv4zPpIr?=
 =?iso-8859-2?Q?EnOKNoLY/iP5yWtBD9xBemeW+ziC1s21Cbub1RYHGPWpqGGhW1dW4krM9j?=
 =?iso-8859-2?Q?ipDQaPxqNSs9u0XAAIPDRyep9YX/YviHLyPN1nZxT0aLeUatMxIIAhUaAW?=
 =?iso-8859-2?Q?MD2ZvEBWJN?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3f57ae-4dac-4d52-16cc-08d9256c41ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 02:15:14.1458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2DEousO2q+1w7vVaGmLEJJNi7gFlvWfQBGXbHoYVFi8TrbNp9cYw82+5fiwilgnc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Official Use Only]



> -----Original Message-----
> From: Krzysztof Wilczy=F1ski <kw@linux.com>
> Sent: Tuesday, June 1, 2021 9:08 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: linux-pci@vger.kernel.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] PCI: Add quirk for AMD Navi14 to disable ATS support
>=20
> Hi Evan,
>=20
> Thank you for sending updated version!
>=20
> [...]
> > V2: cosmetic fix for description part(suggested by Krzysztof)
>=20
> For future reference: as this is v2, then remember to update the subject =
link
> to [PATCH v2] so that everyone looking at incoming patches would be
> immediately made aware that this is a new version (also, some of our
> automation such as Patchwork uses this when parsing subject lines).
>=20
> Additionally, the changelog would customary be included under the "---"
> lines so that it would automatically be removed alongside commit related
> details from Git, see the following as an example:
>=20
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Flinux-pci%2F20210601114301.2685875-1-
> linus.walleij%40linaro.org%2F&amp;data=3D04%7C01%7Cevan.quan%40amd.co
> m%7Cc7b07f31831247233f3408d924fe51da%7C3dd8961fe4884e608e11a82d9
> 94e183d%7C0%7C0%7C637581496992050423%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C1000&amp;sdata=3DK0LqWlNS1JhuFxuOmat%2F0f2NYOLJUa8auWybrmi
> XHXQ%3D&amp;reserved=3D0
>=20
> Having said that, I am not sure if this warrants sending v3, as this coul=
d be
> easily fixed here by either Bjorn or Lorenzo when this patch will be merg=
ed, if
> they don't mind, of course.
[Quan, Evan] Thanks Krzysztof. Just sent out a V3 with these updated.

BR
Evan
>=20
> [...]
> > @@ -5176,7 +5176,8 @@
> > DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422,
> > quirk_no_ext_tags);  static void quirk_amd_harvest_no_ats(struct pci_de=
v
> *pdev)  {
> >  	if ((pdev->device =3D=3D 0x7312 && pdev->revision !=3D 0x00) ||
> > -	    (pdev->device =3D=3D 0x7340 && pdev->revision !=3D 0xc5))
> > +	    (pdev->device =3D=3D 0x7340 && pdev->revision !=3D 0xc5) ||
> > +	    (pdev->device =3D=3D 0x7341 && pdev->revision !=3D 0x00))
> [...]
> >  /* AMD Navi14 dGPU */
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340,
> > quirk_amd_harvest_no_ats);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341,
> > +quirk_amd_harvest_no_ats);
> [...]
>=20
> Thank you!
>=20
> Reviewed-by: Krzysztof Wilczy=F1ski <kw@linux.com>
>=20
> 	Krzysztof
