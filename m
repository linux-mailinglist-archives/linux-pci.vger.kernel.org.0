Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB3E7BEEA3
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 00:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378968AbjJIW5q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Oct 2023 18:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378961AbjJIW5p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 18:57:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C8BBA
        for <linux-pci@vger.kernel.org>; Mon,  9 Oct 2023 15:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696892263; x=1728428263;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=JsGgaGP5zLiEkv5RpgRszbBppYOocHpm5r4aevWxWZU=;
  b=GrFVzUysqhrL0xFlTZL5pPeR1Qx6clOvvl0tf9meuX2sa1eZ/zvvIzlX
   B4C5E2065svrcMsjrlCh5zpuPhfd9acpLm/5GJm0LCmYFt+YA0rBP5CSR
   yA0bwfbbebF9H/ANrt5KRzTvLd/5km9/MpZjd/c5EMfmJDvpNCly2quK4
   gl4Nw3szZcdKJV8wQtJq9Ad3KunBSvckUrmzVHJUP6GWLw13XNdzXOVPI
   4gZ2Tz16Q22mJ+azzl2wEnV5+aOmxMkX+Ey+RgrLGjGUwx5+7UOxW4Gsf
   uQd9GqkXvGFdFn1ILGXWJ/3ZHO/Cy+p708IFCuoQV/AYbx+A+2xMSlpRX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="448460452"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="448460452"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 15:57:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="753185712"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="753185712"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 15:57:39 -0700
Received: from gwu-mobl.amr.corp.intel.com (unknown [10.209.25.71])
        by linux.intel.com (Postfix) with ESMTP id 2BC345807E2;
        Mon,  9 Oct 2023 15:57:40 -0700 (PDT)
Message-ID: <03af547bb8abad1afc5fde396a9a6fa73c54e890.camel@linux.intel.com>
Subject: Re: [PATCH v4] PCI/ASPM: Add back L1 PM Substate save and restore
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Thomas Witt <kernel@witt.link>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Date:   Mon, 09 Oct 2023 15:57:40 -0700
In-Reply-To: <20231009163421.GA938492@bhelgaas>
References: <20231009163421.GA938492@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2023-10-09 at 11:34 -0500, Bjorn Helgaas wrote:
> On Mon, Oct 09, 2023 at 11:34:34AM +0300, Mika Westerberg wrote:
> > On Thu, Oct 05, 2023 at 12:22:26PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Oct 05, 2023 at 05:57:52PM +0200, Thomas Witt wrote:
> > > > On 05/10/2023 17:30, Bjorn Helgaas wrote:
> > > > ...
> > >=20
> > > > > Right, without the denylist, I expect Thomas' TUXEDO to fail,
> > > > > but I still hope we can figure out why.=C2=A0 If we just keep it =
on
> > > > > the denylist, that system will suffer from more power
> > > > > consumption than necessary, but only after suspend/resume.
> > > > >=20
> > > > > A denylist seems like the absolute last resort.=C2=A0 In this cas=
e
> > > > > we don't know about anything *wrong* with those platforms; all
> > > > > we know is that our resume path doesn't work.=C2=A0 It's likely
> > > > > that it fails on other platforms we haven't heard about, too.
> > > >=20
> > > > The best guess from Mika and David was a firmware issue, but I
> > > > run the same Firmware revision as Werner. I even reflashed the
> > > > Firmware, but that did not change anything:
> > >=20
> > > Possibly a BIOS settings difference?
> > >=20
> > > > Quoting David Box:
> > > > > I agree that we should pursue an exception for your system.
> > > > > This is looking like a firmware bug. One thing we did notice
> > > > > in the turbostat results is your IRTL (Interrupt Response Time
> > > > > Limit) values are bogus:
> > > > >=20
> > > > > cpu6: MSR_PKGC3_IRTL: 0x0000884e (valid, 79872 ns)
> > > > > cpu6: MSR_PKGC6_IRTL: 0x00008000 (valid, 0 ns)
> > > > > cpu6: MSR_PKGC7_IRTL: 0x00008000 (valid, 0 ns)
> > > > > cpu6: MSR_PKGC8_IRTL: 0x00008000 (valid, 0 ns)
> > > > > cpu6: MSR_PKGC9_IRTL: 0x00008000 (valid, 0 ns)
> > > > > cpu6: MSR_PKGC10_IRTL: 0x00008000 (valid, 0 ns)
> > > > >=20
> > > > > This is despite the PKGC configuration register showing that all
> > > > > states are enabled:
> > > > >=20
> > > > > cpu6: MSR_PKG_CST_CONFIG_CONTROL: 0x1e008008 (UNdemote-C3, UNdemo=
te-
> > > > > C1,
> > > > demote-
> > > > C3, demote-C1, locked, pkg-cstate-limit=3D8 (unlimited))
> > > > >=20
> > > > > Firmware sets this.
> > >=20
> > > I can't find this discussion, but if there's a firmware issue related
> > > to IRTL MSRs, I would want the workaround in intel-idle.c or whatever
> > > code deals with the MSRs, not in the ASPM code.
> >=20
> > Unfortunately that discussion never ended up on the mailing list. But i=
n
> > summary that particular system seems to run pretty hot (if I understand
> > correctly what David concluded). This is the reason Thomas has the
> > pm_sleep=3Ddeep in the command line and this is why the L1 SS restore t=
hen
> > causes the failure on resume. Without this it works fine but consumes
> > lot of energy in s2idle.
> >=20
> > Can you suggest what we should do with this now?
> >=20
> > We got report from Tasev Nikola on
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D216782=C2=A0that even if =
the Asus
> > system is removed from the denylist it works so that we can do. However=
,
> > with the Thomas' system I'm not sure. If we leave it like this:
> >=20
> > static int aspm_l1ss_suspend_via_firmware(const struct dmi_system_id
> > *not_used)
> > {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return pm_suspend_via_firmwa=
re();
> > }
> >=20
> > static const struct dmi_system_id aspm_l1ss_denylist[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * https://bugzilla.kernel.org/show_bug.cgi?id=
=3D216877
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This system needs to use suspend to mem inste=
ad of its=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * default (suspend to idle) to avoid draining t=
he battery.=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * However, the BIOS gets confused if we try to =
restore the
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * L1SS registers so avoid doing that if the use=
r forced
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * suspend to mem. The default suspend to idle o=
n the other
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * hand needs restoring L1SS to allow the CPU to=
 enter low
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * power states. This entry should handle both.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .callback =3D aspm_l1ss_suspend_via_firmware,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .ident =3D "TUXEDO InfinityBook S 14 v5",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .matches =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_M=
ATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_M=
ATCH(DMI_BOARD_NAME, "L140CU"),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 },
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { }
> > };
> >=20
> > Then it should work with Thomas' system (defaults to deep), and TUXEDO
> > with default settings (defaults to s2idle), and with the rest of the
> > world (I hope at least, fingers crossed). Or you want to pursue a
> > solution without the denylist still? I'm out of ideas what could be
> > wrong except that when the pm_sleep=3Ddeep it means the BIOS is involve=
d
> > in the suspend/restore of the devices and it may not expect the OS to
> > touch these registers or something along those lines.
>=20
> [I think this refers to "mem_sleep_default=3Ddeep" (not pm_sleep)]
>=20
> I assume everything was fine before suspend, and it only runs hot
> after resume.

The system was running hot even before suspend. After boot it could not exi=
t
Package C0. At that level it's usually some compute element that is blockin=
g,
and not caused by a device's LTR. A cause for this was not found, only sign=
s
that BIOS did not configure the system correctly (bogus IRTL values).

That issue does appear to be why Thomas needs to use deep since his system
cannot use s2idle since it cannot even idle while running. There's no relat=
ion I
can see between that issue and the PCI device failure after L1 substate
restore.=C2=A0

But to your point, those PCI devices were working upon boot, with L1 config=
ured,
and not working after resume when restored on that system.

> =C2=A0 And the platform granted control of the PCIe Capability
> and the LTR Capability to OSPM via _OSC?

Need to confirm this.

>=20
> If so, I think we should try to find out what the difference is, e.g.,
> compare config space before/after the suspend/resume.=C2=A0 Maybe that's
> already been tried?=C2=A0 (I did check the archives but couldn't find
> details.)

I'll take a look again at the information we got from Thomas and check for
config space differences.

David
