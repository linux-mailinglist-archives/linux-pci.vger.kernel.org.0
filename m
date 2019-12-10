Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D397C118E2A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 17:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLJQvJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 11:51:09 -0500
Received: from mail-eopbgr690060.outbound.protection.outlook.com ([40.107.69.60]:40518
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfLJQvI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 11:51:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbnFbPevoPzy29xhPYryC8zqXubNZasBSizqdg14GfvAYjlCv5l+wbZDh98+75OhjNlqccIDGLMSG5y+wvRGY4M7gImKGr8OGdjvT2yKpEo12gFEP6GuvX96GUH5F/2bEnrAwOG8a8zpRey6znVDUwjivEnvyVJYvFrTW0Tcc9sN5XMK7gvAoJj0Y7J6usfABJllZwtksa90xvl319t+WXqdsMCjvLr27ennBGJGEKhAu3EhmxyOdA1oyAkGC4Q0uYJH/k7kwyhjvyqgryfsSFOLPGUkejQUB3+z0PxuZeTFNzl7Zx/jiWBtjO9FFr0pfOavThdz2NRwOIb9+tM3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib7It7TMapuDmJfPqEgMlEXzNkqwRmVP/+Rpm462gkE=;
 b=dD32XXpe70GRW0ryjV4PcmCZvV2WkrttT3/Zq9/0UH5tHMiKQENR28l25qCzzkCZkCgzSCcCWy8nxiIAFOtY9HhFjxJbSk6SomUkGWJlHyusQqK23UhIAG/tSbFWP48hOXVEk6jYw+zu6DGDh6fegBg/W4wmCTrx+9Y6AsUQBODwElfpOqns1CUnmG4LQ1EgxqCREidcjVKay/qZb11tGkG1ZKLtByyPWQeWRMB1zthr+yQ7lh1KfccTtAEWulJSaz6w0od+ykTossEreyaygImoPwh/c+HejMfJILO/J/UkMfK0YeM9mozlVew0kIQpFMiCIeQ/P3cttGDJcnb2Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib7It7TMapuDmJfPqEgMlEXzNkqwRmVP/+Rpm462gkE=;
 b=2rr0xPn+P5ftYiYo3FJcopj1U205sFW/TcrxJPq70GuZG6vY7lR7FLZHzl30MVxIBCMSQSq2PfH3BqXLMqDokOjDpSs7u9EFE9sG+yAlc8R2HSKMhOxrB8aYca3DFen7oHwn8LIyoiWBzwWf/qTu0riJmStPdmcWlm6WM09jNlM=
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1278.namprd12.prod.outlook.com (10.169.205.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Tue, 10 Dec 2019 16:51:04 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2538.012; Tue, 10 Dec 2019
 16:51:04 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     Lukas Wunner <lukas@wunner.de>, Jaroslav Kysela <perex@perex.cz>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] ALSA: hda/hdmi - Fix duplicate unref of pci_dev
Thread-Topic: [PATCH] ALSA: hda/hdmi - Fix duplicate unref of pci_dev
Thread-Index: AQHVr19R5YQIlg2NqEC5WtHx1mfv7qezf2rggAAD6ICAAADTMIAABdcAgAALB6A=
Date:   Tue, 10 Dec 2019 16:51:04 +0000
Message-ID: <MWHPR12MB13584831075C3F8447216FD8F75B0@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
        <77aa6c01aefe1ebc4004e87b0bc714f2759f15c4.1575985006.git.lukas@wunner.de>
        <MWHPR12MB1358AEEBD730A4EDA78894E6F75B0@MWHPR12MB1358.namprd12.prod.outlook.com>
        <20191210154649.o3vsqzrtofhvcjrl@wunner.de>
        <MWHPR12MB1358449C677259C848AAB11EF75B0@MWHPR12MB1358.namprd12.prod.outlook.com>
 <s5h4ky8w48v.wl-tiwai@suse.de>
In-Reply-To: <s5h4ky8w48v.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eee07e04-e453-4c78-86f4-08d77d912558
x-ms-traffictypediagnostic: MWHPR12MB1278:
x-microsoft-antispam-prvs: <MWHPR12MB1278B4F02BA4C79902D25B5AF75B0@MWHPR12MB1278.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(13464003)(189003)(199004)(66556008)(64756008)(66446008)(66476007)(7696005)(6916009)(316002)(53546011)(26005)(186003)(76116006)(66946007)(52536014)(6506007)(4326008)(54906003)(86362001)(478600001)(8936002)(71200400001)(81156014)(9686003)(81166006)(8676002)(33656002)(2906002)(45080400002)(55016002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1278;H:MWHPR12MB1358.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8SpzQX4pRw/Vx3itqarDoP90amj4d7BNstbICKqXBRBPG5F31n2hRU7/oCZwCtLII9n/EWmHQjqfUG4fMReKgl2p9OEnAptB0fMuCHQB8vAjwn1e6FHfVawqW+SsL5XwFHeNTC8Q4jhBBbiKF0sB2EZC/RtgNC5k1pshwyNmgVqrzS1GxwSTIw27TqaMMJ+/RoCZocQ06MvGKhOknm+6+MWqaQZaX/ZnE1bwfFM8XP5p8o5YjcjjOdXYz7u56BwO8ky+3YD0dovxmCjBr6Ig+V3tL0xNRkAW9lhDdTQWBoubBOdKtdpuC13yMKnZYY3S3qZtqL/ufih7uT9qshrJVkxUl3l3cXz0NIn76tpHSPOiz6/o4fBmEUyOPuoXbKi1Dgbkj+eCRfVHsMK0UX/1U0WMZdkWtYFGcsW6KZ5eHq4qTd/s0HaRrVOTqnF0Z+Xd7FO32vIpiK8ey+TaP6Dnga9JQIAPDE0pPiB5kg8cWkCMSOCr00H440mo40FVzSd6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee07e04-e453-4c78-86f4-08d77d912558
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 16:51:04.4713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFiUNmwoaHe0OXUNb47DyqWH9oxcUc2USqA4TU5JNdDnaOzv2CP/37gY52vHWV6IZKYHpgfPPz3hfdGE9gY5JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1278
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Tuesday, December 10, 2019 11:11 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Lukas Wunner <lukas@wunner.de>; Jaroslav Kysela <perex@perex.cz>;
> Mika Westerberg <mika.westerberg@linux.intel.com>; Bjorn Helgaas
> <helgaas@kernel.org>; Nicholas Johnson <nicholas.johnson-
> opensource@outlook.com.au>; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org; linux-pci@vger.kernel.org
> Subject: Re: [PATCH] ALSA: hda/hdmi - Fix duplicate unref of pci_dev
>=20
> On Tue, 10 Dec 2019 16:53:20 +0100,
> Deucher, Alexander wrote:
> >
> > > -----Original Message-----
> > > From: Lukas Wunner <lukas@wunner.de>
> > > Sent: Tuesday, December 10, 2019 10:47 AM
> > > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > Cc: Takashi Iwai <tiwai@suse.de>; Jaroslav Kysela <perex@perex.cz>;
> > > Mika Westerberg <mika.westerberg@linux.intel.com>; Bjorn Helgaas
> > > <helgaas@kernel.org>; Nicholas Johnson <nicholas.johnson-
> > > opensource@outlook.com.au>; alsa-devel@alsa-project.org; linux-
> > > kernel@vger.kernel.org; linux-pci@vger.kernel.org
> > > Subject: Re: [PATCH] ALSA: hda/hdmi - Fix duplicate unref of pci_dev
> > >
> > > On Tue, Dec 10, 2019 at 03:34:27PM +0000, Deucher, Alexander wrote:
> > > > > Nicholas Johnson reports a null pointer deref as well as a
> > > > > refcount underflow upon hot-removal of a Thunderbolt-attached
> AMD eGPU.
> > > > > He's bisected the issue down to commit 586bc4aab878 ("ALSA:
> > > > > hda/hdmi
> > > > > - fix vgaswitcheroo detection for AMD").
> > > > >
> > > > > The commit iterates over PCI devices using pci_get_class() and
> > > > > unreferences each device found, even though pci_get_class()
> > > > > subsequently unreferences the device as well.  Fix it.
> > > >
> > > > The pci_dev_put() a few lines above should probably be dropped as
> well.
> > >
> > > That one looks fine to me.  The refcount is already increased in the
> > > caller
> > > get_bound_vga() via pci_get_domain_bus_and_slot() and it's increased
> > > again in atpx_present() via pci_get_class().  It needs to be
> > > decremented in
> > > atpx_present() to avoid leaking a ref.
> >
> > I'm not following.  This is part of the same loop as the one you remove=
d.  All
> we are doing is checking whether the ATPX method exists or not om the
> platform.  The pdev may not be the same one as the one in
> pci_get_domain_bus_and_slot().  The APTX method in the APU's ACPI
> namespace, not the dGPUs.
>=20
> Well, the tricky part is that pci_get_class() itself does unrefeference t=
he old
> object and reference the new object (if found).
> At the end of the loop, nothing is referenced, so it's fine.
> OTOH, if you go out of the loop in the middle, you're still keeping the p=
dev
> object reference, so you need to manually unreference it.
>=20

Ah, I see what you are saying.  Thanks.  Patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>=20
> Takashi
>=20
> >
> > Alex
> >
> > >
> > > Thanks,
> > >
> > > Lukas
> > >
> > > > > diff --git a/sound/pci/hda/hda_intel.c
> > > > > b/sound/pci/hda/hda_intel.c index 35b4526f0d28..b856b89378ac
> > > > > 100644
> > > > > --- a/sound/pci/hda/hda_intel.c
> > > > > +++ b/sound/pci/hda/hda_intel.c
> > > > > @@ -1419,7 +1419,6 @@ static bool atpx_present(void)
> > > > >  				return true;
> > > > >  			}
> > > > >  		}
> > > > > -		pci_dev_put(pdev);
> > > > >  	}
> > > > >  	return false;
> > > > >  }
> > > > > --
> > > > > 2.24.0
> >
