Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19637E09A6
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 20:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377842AbjKCTvz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 15:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377837AbjKCTvy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 15:51:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B4ED66
        for <linux-pci@vger.kernel.org>; Fri,  3 Nov 2023 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699041112; x=1730577112;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lN+P2JSgF5XKgTVdStqLnIyuxBUc1WfueEahLqdS1Nw=;
  b=brGq2Q0McrEMV61aiLix6YNaZOsMmwOpGibxu2TezFKyvDXAW5axwVA6
   QRnE4V7jP5P1bXQo5ZWgDDCs+V7ChuTSpFB0xgWXmGnsVHxavjNy9mTd4
   E7RTYoZqG87nE4kiphJClU4IOwBYm7QxJeMuBOKwAGWPmt0lox9Pvk3tV
   BzLeS769Eq5weqAwgPk6jkDNDPEAv9Hewu3fi865T1Ad29acGorXEUy01
   9T6A19PK9XvgnQirgvZtt9CW34aKfdb694qnIjih2yTjBbq1JWo3hafAM
   5I/R3FL23HsGq7DYZr92jAspa53QCBua2F08NdGxsh8ppfo0iNFxTegnE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1962771"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="1962771"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 12:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="761719180"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="761719180"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 12:51:50 -0700
Received: from soonmink-mobl.amr.corp.intel.com (unknown [10.209.34.231])
        by linux.intel.com (Postfix) with ESMTP id A02E9580E3D;
        Fri,  3 Nov 2023 12:51:50 -0700 (PDT)
Message-ID: <1de83120625d187ed2d3322cf46a27463eb8ab52.camel@linux.intel.com>
Subject: Re: [PATCH v4] PCI/ASPM: Add back L1 PM Substate save and restore
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Thomas Witt <kernel@witt.link>, Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Koba Ko <koba.ko@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?UTF-8?Q?=E5=90=B3=E6=98=8A=E6=BE=84?= Ricky 
        <ricky_wu@realtek.com>, linux-pci@vger.kernel.org
Date:   Fri, 03 Nov 2023 12:51:50 -0700
In-Reply-To: <923d8df0-1112-aca9-8289-c6e2457298cd@witt.link>
References: <20231005153043.GA746943@bhelgaas>
         <923d8df0-1112-aca9-8289-c6e2457298cd@witt.link>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

I had updated the bugzilla with a request to run some commands to collect m=
ore
information from your system. Are you still able to work on this? Thanks.

https://bugzilla.kernel.org/show_bug.cgi?id=3D216877#c27

David


On Thu, 2023-10-05 at 17:57 +0200, Thomas Witt wrote:
> On 05/10/2023 17:30, Bjorn Helgaas wrote:
> > On Thu, Oct 05, 2023 at 12:02:58PM +0300, Mika Westerberg wrote:
> > > On Wed, Oct 04, 2023 at 05:23:24PM -0500, Bjorn Helgaas wrote:
> > > ...
> >=20
> > > The thing with TUXEDO is that on Thomas's system with mem_sleep=3Ddee=
p
> > > this patch (without denylist) breaks the resume as he describes here:
> > >=20
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D216877
> > >=20
> > > However, on exact same TUXEDO system with the same firmwares Werner i=
s
> > > not able to reproduce the issue with or without the patch. So I'm not
> > > sure what to do and that's why I added denylist that should take effe=
ct
> > > on Thomas' system when mem_sleep=3Ddeep is set but also work on the s=
ame
> > > system without it.
> > >=20
> > > And since we have the denylist, I decided to add the ASUS there to av=
oid
> > > accidentally breaking those too.
> > > ...
> >=20
> > > > I think there's still something we're missing.
> > > >=20
> > > > We restore the LTR config before restoring DEVCTL2 (including the L=
TR
> > > > enable bit) and L1SS state.=C2=A0 I don't think we know the state o=
f ASPM
> > > > and L1SS at that point, do we?=C2=A0 Do you think there could be an=
 issue
> > > > there, too?
> > >=20
> > > AFAICT LTR does not affect until it is explicitly enabled and I don't
> > > think many drivers actually program it (although we have some sort of
> > > API for it at least for Intel LPSS devices).
> >=20
> > I couldn't find anything in the spec that suggests LTR should be an
> > issue.=C2=A0 I'm just grasping at straws here.
> >=20
> > There's obviously *something* we're doing wrong because ASPM worked
> > before suspend, so we should be able to get it to work after resume.
> >=20
> > Could we learn anything by dumping config space of the problem devices
> > before/after the suspend/resume and comparing them?
> >=20
> > If we could figure out a difference between Werner's working TUXEDO
> > and Thomas' non-working TUXEDO, that might be a hint, too.
> >=20
> > > If you have suggestions, I'm all open. If I understand you would like
> > > this to be done like:
> > >=20
> > > =C2=A0=C2=A0 - Drop the denylist
> > > =C2=A0=C2=A0 - Add back the suspend/restore of L1SS
> > > =C2=A0=C2=A0 - Ask everyone in this thread to try it out
> > >=20
> > > I can do that no problem but I guess that for the TUXEDO one (Thomas'=
)
> > > it probably is going to fail still.
> >=20
> > Right, without the denylist, I expect Thomas' TUXEDO to fail, but I
> > still hope we can figure out why.=C2=A0 If we just keep it on the denyl=
ist,
> > that system will suffer from more power consumption than necessary,
> > but only after suspend/resume.
> >=20
> > A denylist seems like the absolute last resort.=C2=A0 In this case we d=
on't
> > know about anything *wrong* with those platforms; all we know is that
> > our resume path doesn't work.=C2=A0 It's likely that it fails on other
> > platforms we haven't heard about, too.
> >=20
> > Bjorn
>=20
> The best guess from Mika and David was a firmware issue, but I run the=
=20
> same Firmware revision as Werner. I even reflashed the Firmware, but=20
> that did not change anything:
>=20
> Quoting David Box:
> =C2=A0> I agree that we should pursue an exception for your system. This =
is
> =C2=A0> looking like a firmware bug. One thing we did notice in the turbo=
stat
> =C2=A0> results is your IRTL (Interrupt Response Time Limit) values are b=
ogus:
> =C2=A0>
> =C2=A0> cpu6: MSR_PKGC3_IRTL: 0x0000884e (valid, 79872 ns)
> =C2=A0> cpu6: MSR_PKGC6_IRTL: 0x00008000 (valid, 0 ns)
> =C2=A0> cpu6: MSR_PKGC7_IRTL: 0x00008000 (valid, 0 ns)
> =C2=A0> cpu6: MSR_PKGC8_IRTL: 0x00008000 (valid, 0 ns)
> =C2=A0> cpu6: MSR_PKGC9_IRTL: 0x00008000 (valid, 0 ns)
> =C2=A0> cpu6: MSR_PKGC10_IRTL: 0x00008000 (valid, 0 ns)
> =C2=A0>
> =C2=A0> This is despite the PKGC configuration register showing that all
> =C2=A0> states are enabled:
> =C2=A0>
> =C2=A0> cpu6: MSR_PKG_CST_CONFIG_CONTROL: 0x1e008008 (UNdemote-C3,=20
> UNdemote-C1, demote-
> C3, demote-C1, locked, pkg-cstate-limit=3D8 (unlimited))
> =C2=A0>
> =C2=A0> Firmware sets this.
>=20
> Since I can't currently flash modified firmware on this computer, can=20
> those values be overridden from userspace?
>=20

