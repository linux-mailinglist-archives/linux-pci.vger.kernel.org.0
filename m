Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338562BA061
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 03:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgKTC1h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 21:27:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:56518 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgKTC1g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 21:27:36 -0500
IronPort-SDR: L5DmQv0bS2yUl7p+x1jWtfRkiHzmOH36yq9qVHL364+PBjGAxL9W8scJpRgnPiIbCFzT39G7O2
 q8A9lubNCGaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="158439724"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="158439724"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 18:27:35 -0800
IronPort-SDR: GCsNC5324xNn3e1e0l4mzIH43IFqSP0tXJNKZB6tRZny7weAkHSpqzFXuFILmW+YDuKCs66S52
 29aAdeg0cb6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="369017625"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Nov 2020 18:27:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 18:27:34 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 18:27:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Nov 2020 18:27:34 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 19 Nov 2020 18:27:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1Zn92VlADeK07MdH4INS+1WUUKsLprj+vAg64qQ81r+ufAtGhs9iP4RFV2SymXHQfziN2a2xz+WlYLN3vqgV+Oi0CVOg51BXOropt30oC9RT7ui1gxSZ4aLpjoErNu4PFk662ssYb4TqY84femh6uAQqDna5MWKhRmVyNizSnsvx/hR+wDvzvWZQjlWw4UZD/oThO0g7Qf9xnZbeby3MHraVsHEo7/spbXd/fXTDQps7mHBX5335P6jVlkz09bDqfARe0KID4e1eKvaMKlyBAG/HJ51NOtXAjlKeoSMf/7gg1FnYOmPPASbMRq5AarCNvN1kM6oRh9lXKox0JbhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBE13Wm8y4TTqmHf7OwfKBc2nZ64a0LU5e/9BmAelTY=;
 b=fgn4miqEf3CIQ8imA0Woqyr0iOXP2/iNUoqOCRpmp+k/Qy6pY1MUIHe6t2z/KiJ8sWAY2eyPVysLAOXLBHrsl6pQ6t1rPkQ1NZjNhWynkdym9Epko8RXkge7pH+SQUGJ8/yvVnYQ7sncV6tMdsomd+D1Ww4UZsdtEqBEHplIskaMQxjyAENvEWbiLOhrbMuGmwrXN4mV+K/IDLYxOqfz0YeMo+dybOWNL5IPWmW4y1DIsz3X0HwgAcVxpwVIfZ62upYiAgiAeM5wfLl/+lbTsAgD7N4VQbOQJNwpeX43bMfBwvnrb25Za5wftHbb9weLuQK7IDAtAOINsTNZHdDY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBE13Wm8y4TTqmHf7OwfKBc2nZ64a0LU5e/9BmAelTY=;
 b=DNzOjNuGD+t3XsXxNf55SAiiNiTiooVfAtlDQcVfDxBO6DThdUzibIrFyFQ3f2ZHzdS9ub3+gvSeAj9p9a6PtczMutKpcHDCDpvbdeueLwfNpqyzjVa4shj1dl5Ex+cYwZ33JdDZmxS3S9WinEq+7piY9YoEAt6nIk0GW4D6+dw=
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 02:27:30 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d%5]) with mapi id 15.20.3541.028; Fri, 20 Nov 2020
 02:27:30 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI/PM: Do not generate wakeup event when runtime
 resuming bus
Thread-Topic: [PATCH] PCI/PM: Do not generate wakeup event when runtime
 resuming bus
Thread-Index: AQHWrdVjYz1N2Nb9/0q7Dw3u06fJnKnOhgkAgACxEACAAS5pUA==
Date:   Fri, 20 Nov 2020 02:27:30 +0000
Message-ID: <MWHPR11MB0048CB7CB12D12838604C08BA9FF0@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20201029092453.69869-1-mika.westerberg@linux.intel.com>
 <20201118212200.GA80972@bjorn-Precision-5520>
 <20201119075544.GZ2495@lahna.fi.intel.com>
In-Reply-To: <20201119075544.GZ2495@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9993a5b9-f83d-4ab4-0982-08d88cfbd4c5
x-ms-traffictypediagnostic: CO1PR11MB4961:
x-microsoft-antispam-prvs: <CO1PR11MB4961DACCFC8D25202D34B907A9FF0@CO1PR11MB4961.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gc1OwGb5OpEEuxqUetXXCG62EDyQfozXOalwDTkrfV/5sP0TmkV3jhZpa8LFpJX3nW6uxN674xQl19bq5ko2CH5hoEC2pkF4J3OX3preUaSRwTju+Q1tA+9GpcU8hjQlHAUQibR2qbYRlF10SJ4o3Q5An9d4Gmt7CbwBdOqQr1vszgVfcR4lor1DUmytJxQATT6xAKNJeRdB3JViRmSyGp9fsLjU/DJQtw0qUkaJAdlBMITAfwfcycZGvzrwQ2ugOPeWO/sY3UZsNwqVeZd6x2FOJEf/QAsHOOCPognnh3PlgbGIrKlO4/6HNPeRCpyuX/mdUjElB9K7q4iSNIpDWXlnKdmbzoYICcWpHN18YuRJmPrj1baobF34fZdYQjIY/TgrsD+0kQ4j4bq3DHGNsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(54906003)(66556008)(83380400001)(2906002)(53546011)(66476007)(76116006)(26005)(86362001)(5660300002)(64756008)(7416002)(186003)(66946007)(4326008)(71200400001)(478600001)(66446008)(9686003)(110136005)(7696005)(55016002)(316002)(52536014)(6506007)(8936002)(33656002)(966005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Xp+OkIlQUwG+4p/+ZSTfb9w0fQwUD9JVt+Fp5K+YUpUGCZM4fVWfka0TCRH2HjmtZtrym6CltskZlKyCAmheRDWlrL47ZUVFzkm7r+q/SCZGZPGeXcNjFpLdR9vjLEdL1g0hi2Qimc9LptEfVb/9PhupUriZyp7G2KUK2wbpmefn48IxDxBPZI7fWdOYkXBVwbYbU9ssPWqmrL43bElMkmceEPfMDqYQzweRkv4Af2Il1qGBjKmvHi9OnBgUDsj8k1QCj2TGQHrL3XesBS0rC2yP44SMn4Ucd3rOVruejq8URFZq24N6lkkZePto5y+gfnUuSfsizQEoVZPL0zqJ4/jWGRAREu7PhiiCDPjtIA+ls2ZMD86S2qxLi8Cm/mWmxlSi5/HVk6LNWvpvbv68/jtFyOipfOZw8SW7BmZLcOgRHB+t1jVI9CtZmdLmXXjXcxPykdsKUPz2r60bZ8FCbhd0a6h6ULT1Udw28pRkw5S0iVpnNuXFL0ZILI3mb0lVRTQoilnuTXFvbvrPYYsiPuoZipGKazjYP9esW07a/nlRj+oUZmn9ZJx3tSLpjafZRk8x7sQT0WoMj+J5pjONh3zpV+RfrdOB9Nfy2WE8hxqdO7l2/Kqg88OGoB4lUz94VQnA+howrpbF+wc46xgS7aKc8Q5Jk6jYTGfORzDFruyXXxAJpgLwTiP7vB29/cRq18KSaR9JpXB08HBL4Fn75TdAS3ApEpvur9IU5ZbBpCc9+EjHt0S7nH4AhE4FY0qKyGK+0IvJlkIrBEfjVZuwuP0hvoSsGjhh8JWpn526aUNpOLEuvrKqVM/R9VcmIHWFM6GCG8VcA0sHh0qzREWW13NFcQipm/i65izkE50TUv6SnLQZC0QF52gjNbuYUATsJ+fFi7tuK7q0Cp/8WK7mGw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9993a5b9-f83d-4ab4-0982-08d88cfbd4c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 02:27:30.6318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j0khKKFlk8yAopCTN82U8zVBT8bO/PXNYcOAdzhuztFvOONL4Hy6/VtqO7h+8O8NZmGlOWljwqtasYJNMFUuPqvbzTZ+rc5iYsRu0ysocZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mika and Bjorn,

> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Wednesday, November 18, 2020 11:56 PM
> To: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Rafael J. Wysocki
> <rjw@rjwysocki.net>; Lukas Wunner <lukas@wunner.de>; David Airlie
> <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Patel, Utkarsh H
> <utkarsh.h.patel@intel.com>; Maarten Lankhorst
> <maarten.lankhorst@linux.intel.com>; Maxime Ripard <mripard@kernel.org>;
> Thomas Zimmermann <tzimmermann@suse.de>; linux-pci@vger.kernel.org
> Subject: Re: [PATCH] PCI/PM: Do not generate wakeup event when runtime
> resuming bus
>=20
> Hi Bjorn,
>=20
> On Wed, Nov 18, 2020 at 03:22:00PM -0600, Bjorn Helgaas wrote:
> > On Thu, Oct 29, 2020 at 12:24:53PM +0300, Mika Westerberg wrote:
> > > When a PCI bridge is runtime resumed from D3cold the underlying bus
> > > is walked and the attached devices are runtime resumed as well.
> > > However, in addition to that we also generate a wakeup event for
> > > these devices even though this actually is not a real wakeup event
> > > coming from the hardware.
> > >
> > > Normally this does not cause problems but when combined with
> > > /sys/power/wakeup_count like using the steps below:
> > >
> > >   # count=3D$(cat /sys/power/wakeup_count)
> > >   # echo $count > /sys/power/wakeup_count
> > >   # echo mem > /sys/power/state
> > >
> > > The system suspend cycle might get aborted at this point if a PCI
> > > bridge that was runtime suspended (D3cold) was runtime resumed for an=
y
> reason.
> > > The runtime resume calls pci_wakeup_bus() and that generates wakeup
> > > event increasing wakeup_count.
> > >
> > > Since this is not a real wakeup event we can prevent the above from
> > > happening by removing the call to pci_wakeup_event() in
> > > pci_wakeup_bus(). While there rename pci_wakeup_bus() to
> > > pci_resume_bus() to better reflect what it does.
> > >
> > > Reported-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> >
> > Is there a URL to a report on a mailing list or a bugzilla that we can
> > include here?  What was the actual user-visible issue?  If we can
> > mention it here, it may be useful to others who encounter the same
> > issue.  I guess maybe a system suspend fails?
>=20
> I'm not sure if there is bugzilla entry about this. There might be a Goog=
le
> partner bug but not sure if it is public.
>=20
> @Utkarsh, if there is one can you share that link with Bjorn?

This is reported only Google partner bug which is private and I am not sure=
 if I can share the link here.=20

>=20
> There are two user visible issues, first is that if you do the above step=
s
> manually the suspend gets aborted (as the above commit log tries to expla=
in).
>=20
> The second "user visible" issue is that the ChromeOS suspend stress test
> script below fails (as it does the same steps):
>=20
>=20
> https://chromium.googlesource.com/chromiumos/platform/power_manager/
> +/refs/heads/master/tools/suspend_stress_test
>=20
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > ---
> > >  drivers/gpu/vga/vga_switcheroo.c |  2 +-
> > >  drivers/pci/pci.c                | 16 +++++-----------
> > >  include/linux/pci.h              |  2 +-
> > >  3 files changed, 7 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/gpu/vga/vga_switcheroo.c
> > > b/drivers/gpu/vga/vga_switcheroo.c
> > > index 087304b1a5d7..8843b078ad4e 100644
> > > --- a/drivers/gpu/vga/vga_switcheroo.c
> > > +++ b/drivers/gpu/vga/vga_switcheroo.c
> > > @@ -1039,7 +1039,7 @@ static int
> vga_switcheroo_runtime_resume(struct device *dev)
> > >  	mutex_lock(&vgasr_mutex);
> > >  	vga_switcheroo_power_switch(pdev, VGA_SWITCHEROO_ON);
> > >  	mutex_unlock(&vgasr_mutex);
> > > -	pci_wakeup_bus(pdev->bus);
> > > +	pci_resume_bus(pdev->bus);
> > >  	ret =3D dev->bus->pm->runtime_resume(dev);
> > >  	if (ret)
> > >  		return ret;
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index
> > > 6d4d5a2f923d..b25dfa63eeb9 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -1174,26 +1174,20 @@ int pci_platform_power_transition(struct
> > > pci_dev *dev, pci_power_t state)  }
> > > EXPORT_SYMBOL_GPL(pci_platform_power_transition);
> > >
> > > -/**
> > > - * pci_wakeup - Wake up a PCI device
> > > - * @pci_dev: Device to handle.
> > > - * @ign: ignored parameter
> > > - */
> > > -static int pci_wakeup(struct pci_dev *pci_dev, void *ign)
> > > +static int pci_resume_one(struct pci_dev *pci_dev, void *ign)
> > >  {
> > > -	pci_wakeup_event(pci_dev);
> >
> > IIUC this is the critical change, and all the rest of this patch is
> > no-op renames.  Can you split this into two patches so the important
> > change is more obvious?
>=20
> Sure.
>=20
> > Then the obvious questions will be why it is safe to remove this, and
> > where the desired call for the real wakeup is.
>=20
> This is only called on runtime resume path to turn on devices below this =
one.
> However, wakeup is only relevant on system sleep path.
>=20
> For ACPI backed devices the real wakeup is handled in the
> pci_acpi_wake_dev() and in case of PME it is pcie_pme_handle_request().
> And then there is the pme_poll thread as well.

Sincerely,
Utkarsh Patel.=20
