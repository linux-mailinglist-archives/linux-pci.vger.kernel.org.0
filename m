Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0086C2811
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 03:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCUCYW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 22:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCUCYU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 22:24:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A582F28D31;
        Mon, 20 Mar 2023 19:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679365458; x=1710901458;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=wGD34Lsi+DFpGzDmJKkZUVXu8aHEF26e1mtU6ODAncY=;
  b=Y3+/WNquutHlBhr/+oBBhIMZ5JfKHjEMPynDiOInteyyDzzNV1BtPHTU
   l84D7izXK6leVp7VCctER63VAvoMMhO5gVLmEbDbbYSw9u+isPuAwkfz0
   G2Z+uMA65/3iqqxLUBw1JkEB9/Z0mAN8MnKJgh2z/4TVHQUGcR0mqcicb
   MORb87z2Xq7y8IF7QtVo2ubkf4/epDfmeaS/D+QTVvyyN+2kzXmjzxRMf
   aNXuS8gWCAbeoWAjU9e1pYWgHBTQRpNHsLJpwsMarSDaiE5hqjEgSjLhT
   R70IQEzzdf+YBWeLcrreFF+x5nGAeAJvltq4MJ6FbGkpeSUtTfzUvRkOE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="401403700"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="401403700"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 19:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="711620196"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="711620196"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 20 Mar 2023 19:24:17 -0700
Received: from sarkarbi-mobl1.amr.corp.intel.com (unknown [10.251.19.209])
        by linux.intel.com (Postfix) with ESMTP id 1BD5D580677;
        Mon, 20 Mar 2023 19:24:17 -0700 (PDT)
Message-ID: <8675a80b311443d3c3ed99e09832bd07355bfcc2.camel@linux.intel.com>
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
Date:   Mon, 20 Mar 2023 19:24:16 -0700
In-Reply-To: <ZBjko/ifunIwsK2v@intel.com>
References: <20230120031522.2304439-1-david.e.box@linux.intel.com>
         <20230120031522.2304439-5-david.e.box@linux.intel.com>
         <ZBjko/ifunIwsK2v@intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, 2023-03-21 at 00:56 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> On Thu, Jan 19, 2023 at 07:15:22PM -0800, David E. Box wrote:
> > +/*
> > + * Enable ASPM and LTR settings on devices that aren't configured by B=
IOS.
> > + */
> > +static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long features =3D *=
(unsigned long *)userdata;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 ltr =3D VMD_BIOS_PM_QUIR=
K_LTR;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 ltr_reg;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int pos;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(features & VMD_FEAT_BI=
OS_PM_QUIRK))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_enable_link_state(pdev, =
PCIE_LINK_STATE_ALL);

We call pci_enable_link_state from a callback that's run during pci_walk_bu=
s()
which I see already acquires the semaphore. We've had this patch for well o=
ver a
year and I haven't seen this issue before. Is there a particular config nee=
ded
to reproduce it?

As far as a solution I think we can copy what __pci_disable_link_state() do=
es
and add a bool argument so that we only do down/up on the semaphore when se=
t to
true. Since we know we will in be the lock during the bus walk we can set i=
t to
false.

David

>=20
> Hi,
>=20
> This is tripping lockdep on one our CI ADL machines.
>=20
> https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_12814/bat-adlp-6/boot0.tx=
t
>=20
> <4>[=C2=A0=C2=A0 13.815380] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> <4>[=C2=A0=C2=A0 13.815382] WARNING: possible recursive locking detected
> <4>[=C2=A0=C2=A0 13.815384] 6.3.0-rc1-CI_DRM_12814-g4753bbc2a817+ #1 Not =
tainted
> <4>[=C2=A0=C2=A0 13.815386] --------------------------------------------
> <4>[=C2=A0=C2=A0 13.815387] swapper/0/1 is trying to acquire lock:
> <4>[=C2=A0=C2=A0 13.815389] ffffffff827ab0b0 (pci_bus_sem){++++}-{3:3}, a=
t:
> pci_enable_link_state+0x69/0x1d0
> <4>[=C2=A0=C2=A0 13.815396]=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 but task is already holding lock:
> <4>[=C2=A0=C2=A0 13.815398] ffffffff827ab0b0 (pci_bus_sem){++++}-{3:3}, a=
t:
> pci_walk_bus+0x24/0x90
> <4>[=C2=A0=C2=A0 13.815403]=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other info that might help us debug this:
> <4>[=C2=A0=C2=A0 13.815404]=C2=A0 Possible unsafe locking scenario:
>=20
> <4>[=C2=A0=C2=A0 13.815406]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU=
0
> <4>[=C2=A0=C2=A0 13.815407]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---=
-
> <4>[=C2=A0=C2=A0 13.815408]=C2=A0=C2=A0 lock(pci_bus_sem);
> <4>[=C2=A0=C2=A0 13.815410]=C2=A0=C2=A0 lock(pci_bus_sem);
> <4>[=C2=A0=C2=A0 13.815411]=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *** DEADLOCK ***
>=20
> <4>[=C2=A0=C2=A0 13.815413]=C2=A0 May be due to missing lock nesting nota=
tion
>=20
> <4>[=C2=A0=C2=A0 13.815414] 2 locks held by swapper/0/1:
> <4>[=C2=A0=C2=A0 13.815416]=C2=A0 #0: ffff8881029511b8 (&dev->mutex){....=
}-{3:3}, at:
> __driver_attach+0xab/0x180
> <4>[=C2=A0=C2=A0 13.815422]=C2=A0 #1: ffffffff827ab0b0 (pci_bus_sem){++++=
}-{3:3}, at:
> pci_walk_bus+0x24/0x90
> <4>[=C2=A0=C2=A0 13.815426]=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stack backtrace:
> <4>[=C2=A0=C2=A0 13.815428] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3=
.0-rc1-
> CI_DRM_12814-g4753bbc2a817+ #1
> <4>[=C2=A0=C2=A0 13.815431] Hardware name: Intel Corporation Alder Lake C=
lient
> Platform/AlderLake-P DDR4 RVP, BIOS ADLPFWI1.R00.3135.A00.2203251419
> 03/25/2022
> <4>[=C2=A0=C2=A0 13.815434] Call Trace:
> <4>[=C2=A0=C2=A0 13.815436]=C2=A0 <TASK>
> <4>[=C2=A0=C2=A0 13.815437]=C2=A0 dump_stack_lvl+0x64/0xb0
> <4>[=C2=A0=C2=A0 13.815443]=C2=A0 __lock_acquire+0x9b5/0x2550
> <4>[=C2=A0=C2=A0 13.815461]=C2=A0 lock_acquire+0xd7/0x330
> <4>[=C2=A0=C2=A0 13.815463]=C2=A0 ? pci_enable_link_state+0x69/0x1d0
> <4>[=C2=A0=C2=A0 13.815466]=C2=A0 down_read+0x3d/0x180
> <4>[=C2=A0=C2=A0 13.815480]=C2=A0 ? pci_enable_link_state+0x69/0x1d0
> <4>[=C2=A0=C2=A0 13.815482]=C2=A0 pci_enable_link_state+0x69/0x1d0
> <4>[=C2=A0=C2=A0 13.815485]=C2=A0 ? __pfx_vmd_pm_enable_quirk+0x10/0x10
> <4>[=C2=A0=C2=A0 13.815488]=C2=A0 vmd_pm_enable_quirk+0x49/0xb0
> <4>[=C2=A0=C2=A0 13.815490]=C2=A0 pci_walk_bus+0x6d/0x90
> <4>[=C2=A0=C2=A0 13.815492]=C2=A0 vmd_probe+0x75f/0x9d0
> <4>[=C2=A0=C2=A0 13.815495]=C2=A0 pci_device_probe+0x95/0x120
> <4>[=C2=A0=C2=A0 13.815498]=C2=A0 really_probe+0x164/0x3c0
> <4>[=C2=A0=C2=A0 13.815500]=C2=A0 ? __pfx___driver_attach+0x10/0x10
> <4>[=C2=A0=C2=A0 13.815503]=C2=A0 __driver_probe_device+0x73/0x170
> <4>[=C2=A0=C2=A0 13.815506]=C2=A0 driver_probe_device+0x19/0xa0
> <4>[=C2=A0=C2=A0 13.815508]=C2=A0 __driver_attach+0xb6/0x180
> <4>[=C2=A0=C2=A0 13.815511]=C2=A0 ? __pfx___driver_attach+0x10/0x10
> <4>[=C2=A0=C2=A0 13.815513]=C2=A0 bus_for_each_dev+0x77/0xd0
> <4>[=C2=A0=C2=A0 13.815516]=C2=A0 bus_add_driver+0x114/0x210
> <4>[=C2=A0=C2=A0 13.815518]=C2=A0 driver_register+0x5b/0x110
> <4>[=C2=A0=C2=A0 13.815520]=C2=A0 ? __pfx_vmd_drv_init+0x10/0x10
> <4>[=C2=A0=C2=A0 13.815523]=C2=A0 do_one_initcall+0x57/0x330
> <4>[=C2=A0=C2=A0 13.815527]=C2=A0 kernel_init_freeable+0x181/0x3a0
> <4>[=C2=A0=C2=A0 13.815529]=C2=A0 ? __pfx_kernel_init+0x10/0x10
> <4>[=C2=A0=C2=A0 13.815532]=C2=A0 kernel_init+0x15/0x120
> <4>[=C2=A0=C2=A0 13.815534]=C2=A0 ret_from_fork+0x29/0x50
> <4>[=C2=A0=C2=A0 13.815537]=C2=A0 </TASK>
>=20

