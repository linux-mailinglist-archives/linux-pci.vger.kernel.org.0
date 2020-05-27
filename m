Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8D1E509B
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 23:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgE0Vmk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 17:42:40 -0400
Received: from mail-eopbgr770089.outbound.protection.outlook.com ([40.107.77.89]:30942
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbgE0Vmk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 17:42:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALTr8KdTHq1KawPDODNWnqPEfa7/CGBWdaovm8P64M84OEyAefnavYgIgTjjsyGLRzszGtPeEi5bKmbOn5TNPTWjNRxICGb1B2yssMiagMpI0Ek3slKREkFtpcMJsZxvQN62zBjQb5orpkaNUCGOx9rlkInm3dSf64NvqxF3s2Es5CAdKHg6RWcmTc+X4LJEgsPLVJMbfMLts76S5hW0BT/6qmPybo3lZlYe7iiJ3LpKVETGR1NNizEZ11QiK6u3yKkDwItJft/4rJ5/myZ3Nuk8oe8+idiqEFN94BNSIhe3pSjDoZ6zCMbZHJTG0dfEk3R9lqHi6T1mMjfDd5MV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1d6NJlpQz1UY72DUK1tRw2rZHi24k/lbzXotDZsxUU=;
 b=Ws87JJCnNPx5ezBuSRwfUK/ITiT/u560g/6wy1bKCatgls911tBeq+EQx+W7yaGirprB57l/ymHUk6SqQhJuVDZtD1Exrb3oMV+Qc8WJ5rSGt94jM/CRDbbIgHVA5glwNIYiCzOnh5QHMg2iEDbpMkwizIqb78qI6rhhOhcTdeELMZfNi7DBXsfxO7Wc7qEtwNAo6GHuyDCJG5m/G0V4INq6YdHb51XsAGuKWKncjfxkIi+nSH9s7K90/fOYgOcNYdb012doe2jHduvaEq84oA/f/xvg9WK3ZKA19lYz28/R6lNMhfyl+K79f7xcwgjKOQ+j4A56pe4gibHHp4cZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1d6NJlpQz1UY72DUK1tRw2rZHi24k/lbzXotDZsxUU=;
 b=qe/5w2Ras939deIq7x/vbJS/2a4jxVBpE0+5vCx73MGV0msNHSbzVQ8Cep2v6dpnIPGdjD5mZyQHq8X/jpjGzmmlXY9yrhab3+4GxB2/xnBffOTQQDF7zQQPcZ/V8pblA+bPT0hmlUU/xGr7xXD3NxBxb3n8IeCQQg5RPh8OO8A=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 21:42:37 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%4]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 21:42:36 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kevin Buettner <kevinb@redhat.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
Thread-Topic: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
Thread-Index: AQHWNG42jRTQBk1do0S3m0V1mtJWrqi8dW2A
Date:   Wed, 27 May 2020 21:42:36 +0000
Message-ID: <MN2PR12MB448819B8491290B54E7FABC9F7B10@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200524003529.598434ff@f31-4.lan>
 <20200527213136.GA265655@bjorn-Precision-5520>
In-Reply-To: <20200527213136.GA265655@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-27T21:42:33Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=857464f6-4d76-4c64-b40f-000046270b78;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-27T21:42:33Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 3a885046-50c9-4214-8ff7-0000c96b33a2
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 144bbf20-9884-405e-ad6c-08d80286df57
x-ms-traffictypediagnostic: MN2PR12MB4318:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB43185CFEE688258DCBE39E0EF7B10@MN2PR12MB4318.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UZJUciB+QRi9pXarGwj+ir769Mu6p4TS2GneahnO0Wu8cIWZ7UxcZmz+4gjWz6li5L70/8JaAfNBjWc7kYtyAORXXh/uvWHRvu9VQLma2E7y25PBWRGbMG3wtwOCbeq4vXi702L+yViheftHAZMLaqVxdCDP0hHX66yeNpNTKFnbmHmbPz/plabptO1hCGLoZsrB3qil8Y4JZ4uJYZ8LVHkVGVWAdzBBihl6fbyDIzn1YQzlZQh1iODTQR0FJwlAE+zH9KMs576yqYt5QvCxzleLFT6oMXwWQplVzgnnQiA4J5x1hJjLqTQBi3u/sUqEY4UVjee/C/L9Pqz/x44oh0a50L5TC08COcBpzssPzqVtknwUUoLWoi+vkIwcxTYl99Lqudja8Q2ShuuwaqMp9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(316002)(8676002)(6636002)(2906002)(966005)(54906003)(5660300002)(66476007)(478600001)(66556008)(66946007)(86362001)(83080400001)(66446008)(64756008)(52536014)(76116006)(55016002)(9686003)(33656002)(8936002)(45080400002)(71200400001)(83380400001)(6506007)(53546011)(110136005)(26005)(186003)(7696005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7LQmMQ3oOTVK6fNwxjZJYm7Pg9Uhd6sv1zjDTeVTt+XHtc79dVlW40gvIsqCdamn6FQrYraogYzrLIBqAuWqoOH3A1/aEU6onEbz9uxo3Qo33/c386hZLvbVHb6Kp6RCK7QrtIedSQqd3y8DX2HYHap+3+mcCTJgSQEue/f8GCd7PGUy7vQNWOmaahMaWKjUzTk/VB9FGrHdYmyyXk6kdgAD1DuZgUdRfuqGeTr2hC3GTt1vYSzey0depG2gto6GDe2o1Bq3lfenF6LygMi1nh1gL0kWJHXYP9++eps38UAODKu94rQGINxO5Uz/aFt0Ta2dgf/rl7PKqlVOtnhVtGcftCKgY4Ovt7limmoETYeoVN/xvYqQLQbKUsy2WlfuZKYGakFRbxftr/hX9eF2VsphbIkxaA0vQPbRaMSAD66qaLkF2euz5BN7cDB/VM+N9Us2piTCH1oPIFPfFdOJcFEfoPOjjfEqr+4AIsogkszoGi9MCDoA/BL5etAIXY0O
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144bbf20-9884-405e-ad6c-08d80286df57
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 21:42:36.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8wkQw2S9R+QTJsnCBFZB6rpDM5eA6QisMpHs/95ISQwnlnJGpq+4khBGWLJCtsBtt4wahdjlzkun97HM+6Szg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Official Use Only - Internal Distribution Only]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, May 27, 2020 5:32 PM
> To: Kevin Buettner <kevinb@redhat.com>
> Cc: linux-pci@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>; Alex
> Williamson <alex.williamson@redhat.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: Re: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
>=20
> [+cc Alex D, Christian -- do you guys have any contacts or insight into w=
hy we
> suddenly have three new AMD devices that advertise FLR support but it
> doesn't work?  Are we doing something wrong in Linux, or are these device=
s
> defective?

+Nehal who handles our USB drivers.

Nehal any ideas about FLR or whether it should be advertised? =20

Alex


>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fr%2F20200524003529.598434ff%40f31-
> 4.lan&amp;data=3D02%7C01%7Calexander.deucher%40amd.com%7Ccb77b56b
> 62ae47f60f8808d802855759%7C3dd8961fe4884e608e11a82d994e183d%7C0%
> 7C0%7C637262119015438912&amp;sdata=3D3z%2Btn%2Bv2pvUl3X0Tzk%2BLoi
> Mk06dLZCmgUOrsGf3kLpY%3D&amp;reserved=3D0
>   AMD Starship USB 3.0 host controller
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fr%2FCAAri2DpkcuQZYbT6XsALhx2e6vRqPHwtbjHYeiH7MNp4z
> mt1RA%40mail.gmail.com&amp;data=3D02%7C01%7Calexander.deucher%40a
> md.com%7Ccb77b56b62ae47f60f8808d802855759%7C3dd8961fe4884e608e11
> a82d994e183d%7C0%7C0%7C637262119015438912&amp;sdata=3D69GsHB0HCp
> 6x0xW0tA%2FrAln0Vy0Yc9I8QSHowebdIxI%3D&amp;reserved=3D0
>   AMD Matisse HD Audio & USB 3.0 host controller ]
>=20
> On Sun, May 24, 2020 at 12:35:29AM -0700, Kevin Buettner wrote:
> > This commit adds an entry to the quirk_no_flr table for the AMD
> > Starship USB 3.0 host controller.
> >
> > Tested on a Micro-Star International Co., Ltd. MS-7C59/Creator TRX40
> > motherboard with an AMD Ryzen Threadripper 3970X.
> >
> > Without this patch, when attempting to assign (pass through) an AMD
> > Starship USB 3.0 host controller to a guest OS, the system becomes
> > increasingly unresponsive over the course of several minutes,
> > eventually requiring a hard reset.
> >
> > Shortly after attempting to start the guest, I see these messages:
> >
> > May 23 22:59:46 mesquite kernel: vfio-pci 0000:05:00.3: not ready
> > 1023ms after FLR; waiting May 23 22:59:48 mesquite kernel: vfio-pci
> > 0000:05:00.3: not ready 2047ms after FLR; waiting May 23 22:59:51
> > mesquite kernel: vfio-pci 0000:05:00.3: not ready 4095ms after FLR;
> > waiting May 23 22:59:56 mesquite kernel: vfio-pci 0000:05:00.3: not
> > ready 8191ms after FLR; waiting
> >
> > And then eventually:
> >
> > May 23 23:01:00 mesquite kernel: vfio-pci 0000:05:00.3: not ready
> > 65535ms after FLR; giving up May 23 23:01:05 mesquite kernel: INFO:
> > NMI handler (perf_event_nmi_handler) took too long to run: 0.000 msecs
> > May 23 23:01:06 mesquite kernel: perf: interrupt took too long (642744
> > > 2500), lowering kernel.perf_event_max_sample_rate to 1000 May 23
> > 23:01:07 mesquite kernel: INFO: NMI handler (perf_event_nmi_handler)
> > took too long to run: 82.270 msecs May 23 23:01:08 mesquite kernel: INF=
O:
> NMI handler (perf_event_nmi_handler) took too long to run: 680.608 msecs
> May 23 23:01:08 mesquite kernel: INFO: NMI handler
> (perf_event_nmi_handler) took too long to run: 100.952 msecs ...
> >  kernel:watchdog: BUG: soft lockup - CPU#3 stuck for 22s!
> > [qemu-system-x86:7487] May 23 23:01:25 mesquite kernel: watchdog:
> BUG:
> > soft lockup - CPU#3 stuck for 22s! [qemu-system-x86:7487]
> >
> > The above log snippets were obtained using the aforementioned hardware
> > running Fedora 32 w/ kernel package kernel-5.6.13-300.fc32.x86_64.  My
> > fix was applied to a local copy of the F32 kernel package, then
> > rebuilt, etc.
> >
> > With this patch in place, the host kernel doesn't exhibit these
> > problems.  The guest OS (also Fedora 32) starts up and works as
> > expected with the passed-through USB host controller.
> >
> > Signed-off-by: Kevin Buettner <kevinb@redhat.com>
>=20
> Applied to pci/virtualization for v5.8, thanks!
>=20
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > 43a0c2ce635e..b1db58d00d2b 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5133,6 +5133,7 @@
> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443,
> quirk_intel_qat_vf_cap);
> >   * FLR may cause the following to devices to hang:
> >   *
> >   * AMD Starship/Matisse HD Audio Controller 0x1487
> > + * AMD Starship USB 3.0 Host Controller 0x148c
> >   * AMD Matisse USB 3.0 Host Controller 0x149c
> >   * Intel 82579LM Gigabit Ethernet Controller 0x1502
> >   * Intel 82579V Gigabit Ethernet Controller 0x1503 @@ -5143,6 +5144,7
> > @@ static void quirk_no_flr(struct pci_dev *dev)
> >  	dev->dev_flags |=3D PCI_DEV_FLAGS_NO_FLR_RESET;  }
> > DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c,
> quirk_no_flr);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c,
> quirk_no_flr);
> > DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502,
> quirk_no_flr);
> > DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503,
> quirk_no_flr);
> >
