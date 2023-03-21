Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782CB6C3EB2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 00:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCUXkj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 19:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUXki (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 19:40:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAAD15577;
        Tue, 21 Mar 2023 16:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679442037; x=1710978037;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pGF/Owt8sHEYuKKC2m0YqEqvQ9bwrNgtMef7To+3Wc0=;
  b=QKLcpWs4uBugkJmMw9jV3u6qqnSH0hU00RcLnU2Y4GTrYWW9rWqW/dL+
   49sV9s8+PZcmmdn3w0wjeAkBA51WDqt+bWDGNdKfxw2HdkaAznlC+Hfi8
   aYr/ZelDuLXG3NrLjqLyayDkGnKLR7QB4BBZk3OlS2Gp84UbC6rsa/RbZ
   veWRlpK0uHag30vBKQXt9Sfe7rIiSVqjQXd2iOvheB3ZqvYlcGKKJgQMl
   wC+4AJIuO9FEzmJFDUBTXzQiyo5vhWghdKF/O5chJgBbTui1UsaY5PA+C
   QCDQVn+FExdDRrcLLeZDB9vbZQOWZ7GZ/kBsKSUfSUjXGZhPHt+GrgqzK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="341439110"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="341439110"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 16:40:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="927622669"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="927622669"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 21 Mar 2023 16:40:35 -0700
Received: from ejgrimme-mobl1.amr.corp.intel.com (unknown [10.251.1.45])
        by linux.intel.com (Postfix) with ESMTP id 98D25580AA4;
        Tue, 21 Mar 2023 16:40:35 -0700 (PDT)
Message-ID: <4210e5ceccb8206da32e855915bcd4a9c6235fe2.camel@linux.intel.com>
Subject: Re: [PATCH V10 4/4] PCI: vmd: Add quirk to configure PCIe ASPM and
 LTR
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Date:   Tue, 21 Mar 2023 16:40:35 -0700
In-Reply-To: <ZBmlPIU4FIBU7HU1@intel.com>
References: <20230120031522.2304439-1-david.e.box@linux.intel.com>
         <20230120031522.2304439-5-david.e.box@linux.intel.com>
         <ZBjko/ifunIwsK2v@intel.com>
         <8675a80b311443d3c3ed99e09832bd07355bfcc2.camel@linux.intel.com>
         <ZBmlPIU4FIBU7HU1@intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2023-03-21 at 14:38 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> On Mon, Mar 20, 2023 at 07:24:16PM -0700, David E. Box wrote:
> > Hi,
> >=20
> > On Tue, 2023-03-21 at 00:56 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> > > On Thu, Jan 19, 2023 at 07:15:22PM -0800, David E. Box wrote:
> > > > +/*
> > > > + * Enable ASPM and LTR settings on devices that aren't configured =
by
> > > > BIOS.
> > > > + */
> > > > +static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdat=
a)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long features =
=3D *(unsigned long *)userdata;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 ltr =3D VMD_BIOS_PM_=
QUIRK_LTR;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 ltr_reg;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int pos;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(features & VMD_FEA=
T_BIOS_PM_QUIRK))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_enable_link_state(pd=
ev, PCIE_LINK_STATE_ALL);
> >=20
> > We call pci_enable_link_state from a callback that's run during
> > pci_walk_bus()
> > which I see already acquires the semaphore. We've had this patch for we=
ll
> > over a
> > year and I haven't seen this issue before. Is there a particular config
> > needed
> > to reproduce it?
>=20
> Not sure what would affect it, beyond the normal PROVE_LOCKING=3Dy.

Thanks. Did not have this set. I reproduced the issue and have sent a fix.

David

>=20
> This is the .config our CI uses:
> https://gitlab.freedesktop.org/gfx-ci/i915-infra/-/blob/master/kconfig/de=
bug
>=20
> >=20
> > As far as a solution I think we can copy what __pci_disable_link_state(=
)
> > does
> > and add a bool argument so that we only do down/up on the semaphore whe=
n set
> > to
> > true. Since we know we will in be the lock during the bus walk we can s=
et it
> > to
> > false.
> >=20
> > David
> >=20
> > >=20
> > > Hi,
> > >=20
> > > This is tripping lockdep on one our CI ADL machines.
> > >=20
> > > https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_12814/bat-adlp-6/boot=
0.txt
> > >=20
> > > <4>[=C2=A0=C2=A0 13.815380] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > <4>[=C2=A0=C2=A0 13.815382] WARNING: possible recursive locking detec=
ted
> > > <4>[=C2=A0=C2=A0 13.815384] 6.3.0-rc1-CI_DRM_12814-g4753bbc2a817+ #1 =
Not tainted
> > > <4>[=C2=A0=C2=A0 13.815386] -----------------------------------------=
---
> > > <4>[=C2=A0=C2=A0 13.815387] swapper/0/1 is trying to acquire lock:
> > > <4>[=C2=A0=C2=A0 13.815389] ffffffff827ab0b0 (pci_bus_sem){++++}-{3:3=
}, at:
> > > pci_enable_link_state+0x69/0x1d0
> > > <4>[=C2=A0=C2=A0 13.815396]=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 but task is already holding lock:
> > > <4>[=C2=A0=C2=A0 13.815398] ffffffff827ab0b0 (pci_bus_sem){++++}-{3:3=
}, at:
> > > pci_walk_bus+0x24/0x90
> > > <4>[=C2=A0=C2=A0 13.815403]=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other info that might help us debug this:
> > > <4>[=C2=A0=C2=A0 13.815404]=C2=A0 Possible unsafe locking scenario:
> > >=20
> > > <4>[=C2=A0=C2=A0 13.815406]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 CPU0
> > > <4>[=C2=A0=C2=A0 13.815407]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ----
> > > <4>[=C2=A0=C2=A0 13.815408]=C2=A0=C2=A0 lock(pci_bus_sem);
> > > <4>[=C2=A0=C2=A0 13.815410]=C2=A0=C2=A0 lock(pci_bus_sem);
> > > <4>[=C2=A0=C2=A0 13.815411]=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *** DEADLOCK ***
> > >=20
> > > <4>[=C2=A0=C2=A0 13.815413]=C2=A0 May be due to missing lock nesting =
notation
> > >=20
> > > <4>[=C2=A0=C2=A0 13.815414] 2 locks held by swapper/0/1:
> > > <4>[=C2=A0=C2=A0 13.815416]=C2=A0 #0: ffff8881029511b8 (&dev->mutex){=
....}-{3:3}, at:
> > > __driver_attach+0xab/0x180
> > > <4>[=C2=A0=C2=A0 13.815422]=C2=A0 #1: ffffffff827ab0b0 (pci_bus_sem){=
++++}-{3:3}, at:
> > > pci_walk_bus+0x24/0x90
> > > <4>[=C2=A0=C2=A0 13.815426]=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stack backtrace:
> > > <4>[=C2=A0=C2=A0 13.815428] CPU: 0 PID: 1 Comm: swapper/0 Not tainted=
 6.3.0-rc1-
> > > CI_DRM_12814-g4753bbc2a817+ #1
> > > <4>[=C2=A0=C2=A0 13.815431] Hardware name: Intel Corporation Alder La=
ke Client
> > > Platform/AlderLake-P DDR4 RVP, BIOS ADLPFWI1.R00.3135.A00.2203251419
> > > 03/25/2022
> > > <4>[=C2=A0=C2=A0 13.815434] Call Trace:
> > > <4>[=C2=A0=C2=A0 13.815436]=C2=A0 <TASK>
> > > <4>[=C2=A0=C2=A0 13.815437]=C2=A0 dump_stack_lvl+0x64/0xb0
> > > <4>[=C2=A0=C2=A0 13.815443]=C2=A0 __lock_acquire+0x9b5/0x2550
> > > <4>[=C2=A0=C2=A0 13.815461]=C2=A0 lock_acquire+0xd7/0x330
> > > <4>[=C2=A0=C2=A0 13.815463]=C2=A0 ? pci_enable_link_state+0x69/0x1d0
> > > <4>[=C2=A0=C2=A0 13.815466]=C2=A0 down_read+0x3d/0x180
> > > <4>[=C2=A0=C2=A0 13.815480]=C2=A0 ? pci_enable_link_state+0x69/0x1d0
> > > <4>[=C2=A0=C2=A0 13.815482]=C2=A0 pci_enable_link_state+0x69/0x1d0
> > > <4>[=C2=A0=C2=A0 13.815485]=C2=A0 ? __pfx_vmd_pm_enable_quirk+0x10/0x=
10
> > > <4>[=C2=A0=C2=A0 13.815488]=C2=A0 vmd_pm_enable_quirk+0x49/0xb0
> > > <4>[=C2=A0=C2=A0 13.815490]=C2=A0 pci_walk_bus+0x6d/0x90
> > > <4>[=C2=A0=C2=A0 13.815492]=C2=A0 vmd_probe+0x75f/0x9d0
> > > <4>[=C2=A0=C2=A0 13.815495]=C2=A0 pci_device_probe+0x95/0x120
> > > <4>[=C2=A0=C2=A0 13.815498]=C2=A0 really_probe+0x164/0x3c0
> > > <4>[=C2=A0=C2=A0 13.815500]=C2=A0 ? __pfx___driver_attach+0x10/0x10
> > > <4>[=C2=A0=C2=A0 13.815503]=C2=A0 __driver_probe_device+0x73/0x170
> > > <4>[=C2=A0=C2=A0 13.815506]=C2=A0 driver_probe_device+0x19/0xa0
> > > <4>[=C2=A0=C2=A0 13.815508]=C2=A0 __driver_attach+0xb6/0x180
> > > <4>[=C2=A0=C2=A0 13.815511]=C2=A0 ? __pfx___driver_attach+0x10/0x10
> > > <4>[=C2=A0=C2=A0 13.815513]=C2=A0 bus_for_each_dev+0x77/0xd0
> > > <4>[=C2=A0=C2=A0 13.815516]=C2=A0 bus_add_driver+0x114/0x210
> > > <4>[=C2=A0=C2=A0 13.815518]=C2=A0 driver_register+0x5b/0x110
> > > <4>[=C2=A0=C2=A0 13.815520]=C2=A0 ? __pfx_vmd_drv_init+0x10/0x10
> > > <4>[=C2=A0=C2=A0 13.815523]=C2=A0 do_one_initcall+0x57/0x330
> > > <4>[=C2=A0=C2=A0 13.815527]=C2=A0 kernel_init_freeable+0x181/0x3a0
> > > <4>[=C2=A0=C2=A0 13.815529]=C2=A0 ? __pfx_kernel_init+0x10/0x10
> > > <4>[=C2=A0=C2=A0 13.815532]=C2=A0 kernel_init+0x15/0x120
> > > <4>[=C2=A0=C2=A0 13.815534]=C2=A0 ret_from_fork+0x29/0x50
> > > <4>[=C2=A0=C2=A0 13.815537]=C2=A0 </TASK>
> > >=20
>=20

