Return-Path: <linux-pci+bounces-38772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E060BBF23E1
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 17:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639CE3B58C4
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D463D279792;
	Mon, 20 Oct 2025 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5jnV09U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E691F30A9;
	Mon, 20 Oct 2025 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975810; cv=none; b=DwPZv/Uuv4tveMeuDUQH5MqylroFYjWsmMkGC3R7KGMQHMqD3stuWRqwLAGvlWroPdQsW895n+gAb2bnl75SRylPNyZqX3efj2HKWOmOOCJMpREak5Y7ko5SslhHejw2bs8mgm9V+4Xy2kL14teowkzSyEpEyREvKmOjLqesJW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975810; c=relaxed/simple;
	bh=WZ4YUk4WU8McD6JGE5J0TWtxlA38dDDDBVKgtRpK7FY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E5r/GhD5j5g+Km7t20JbjcNJJ9GZmSG4rvpirbM55NaXbhjDL47jncnLNRo7ftWiVGwBJVStUscKmWzG97Y5u4nEzjcZH2I3TM2YvmLpF3/xweZEeA4BaTaqb+95xouamKk1+Tub8yLCNV8QifI5/4MlpBacl1ZeJ0BPQrj3oq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5jnV09U; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760975808; x=1792511808;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=WZ4YUk4WU8McD6JGE5J0TWtxlA38dDDDBVKgtRpK7FY=;
  b=c5jnV09UHIMrgrm0Ykw0wC5b18qMSr7gur4j4g7ym93if0SHvKgsKEAf
   RpcuXRsfSDQnZyISowUc3e+OPJ706mbawppzNBpq0cRKdcNBN74Nyih2X
   7FG4Rb2J0nz1+ACh/KS4EqI99DsH3bfkyJsMC90ILYr+UYzBd1orCAq1G
   /zfxbNbWhqSlz6Miatd85NM5lYK7tz89bN/uoWxXv57WjAHON8BsD2U3h
   K7KpzRV/PnIY/XQsiSo3kB/DIL6qM0CozKisb8VW15oqNpw3Z1BLxqRPy
   RDkXUlLKkFTsGZVhVdVSpYiEjA33nwFVey76Y9U//Wi/8R4JjRm4BLVq5
   g==;
X-CSE-ConnectionGUID: Ij9sGUOqSya0CcOPHnh1ug==
X-CSE-MsgGUID: ryfnPa+kR9iPhuieks2OOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="50662745"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="50662745"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 08:56:48 -0700
X-CSE-ConnectionGUID: M1kcM3wpSWGkD4JmczsKcQ==
X-CSE-MsgGUID: NAoIyT/pR1G1rEQE24fCUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="220511818"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.76])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 08:56:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Oct 2025 18:56:41 +0300 (EEST)
To: Brian Norris <briannorris@chromium.org>
cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, 
    "Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
In-Reply-To: <aPKANja_k1gogTAU@google.com>
Message-ID: <08976178-298f-79d9-1d63-cff5a4e56cc3@linux.intel.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid> <aPH_B7SiJ8KnIAwJ@wunner.de> <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com> <aPKANja_k1gogTAU@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1420943740-1760974941=:976"
Content-ID: <a433eea2-38a5-aacf-0723-f8969cd2b3ff@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1420943740-1760974941=:976
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <a1a9a386-1566-03e9-e284-96c6675bae0c@linux.intel.com>

On Fri, 17 Oct 2025, Brian Norris wrote:

> Hi Ilpo and Lukas,
>=20
> I'll reply to both of you inline:

I see you posted v2 but I'm answering here to have the context available.=
=20
Mostly things seem okay after your explanation, I think the only question=
=20
mark is a driver calling pci_resize_resource() directly to resize BARs.

> On Fri, Oct 17, 2025 at 02:49:35PM +0300, Ilpo J=E4rvinen wrote:
> > On Fri, 17 Oct 2025, Lukas Wunner wrote:
> >=20
> > > [cc +=3D Ilpo]
> > >=20
> > > On Thu, Oct 16, 2025 at 03:53:35PM -0700, Brian Norris wrote:
> > > > PCI devices are created via pci_scan_slot() and similar, and are
> > > > promptly configured for runtime PM (pci_pm_init()). They are initia=
lly
> > > > prevented from suspending by way of pm_runtime_forbid(); however, i=
t's
> > > > expected that user space may override this via sysfs [1].
> >=20
> > Is this true as pm_runtime_forbid() also increases PM usage count?
>=20
> Yes it's true. See below.
>=20
> > "void pm_runtime_forbid(struct device *dev);
> >=20
> > unset the power.runtime_auto flag for the device and increase its=20
> > usage counter (used by the /sys/devices/.../power/control interface to=
=20
> > effectively prevent the device from being power managed at run time)"
>=20
> Right, but sysfs `echo auto > .../power/control` performs the inverse --
> pm_runtime_allow() -- which decrements that count.

Fair enough, I didn't check what it does.

IMO, the details about how the usage count behaves should be part of the=20
changelog as that documentation I quoted sounded like user control is=20
prevented when forbidden. I see you've put this part of the explanation=20
into the v2 as well so I suggest you explain the usage count in the change=
=20
so it is recorded in the commit if somebody has to look at this commit=20
years from now.

> > > > Now, sometime after initial scan, a PCI device receives its BAR
> > > > configuration (pci_assign_unassigned_bus_resources(), etc.).
> > > >=20
> > > > If a PCI device is allowed to suspend between pci_scan_slot() and
> > > > pci_assign_unassigned_bus_resources(), then pci-driver.c will
> > > > save/restore incorrect BAR configuration for the device, and the de=
vice
> > > > may cease to function.
> > > >=20
> > > > This behavior races with user space, since user space may enable ru=
ntime
> > > > PM [1] as soon as it sees the device, which may be before BAR
> > > > configuration.
> > > >=20
> > > > Prevent suspending in this intermediate state by holding a runtime =
PM
> > > > reference until the device is fully initialized and ready for probe=
().
> > >
> > > Not sure if that is comprehensible by everybody.
>=20
> Yeah, thanks for trying to clarify. After getting too far into the weeds
> on a bug, I sometimes don't spend the appropriate time on writing a
> simple problem description. Maybe I can do better on a v2.
>=20
> > > The point is that
> > > unbound devices are left in D0 but are nevertheless allowed to
> > > (logically) runtime suspend.  And pci_pm_runtime_suspend() may call
> > > pci_save_state() while config space isn't fully initialized yet,
> > > or pci_pm_runtime_resume() may call pci_restore_state() (via
> > > pci_pm_default_resume_early()) and overwrite initialized config space
> > > with uninitialized data.
>=20
> Ack.
>=20
> > > Have you actually seen this happen in practice?
>=20
> Yes, that's why I spent my time debugging and submitting this patch :)

Thanks for doing it! :-)

> > > Normally enumeration
> > > happens during subsys_initcall time, when user space isn't running ye=
t.
> > > Hotplug may be an exception though.
>=20
> Hotplug, rescan (e.g., when pwrctrl is in use, power may be stablished
> later on, and it triggers a bus rescan; pwrctrl drivers can be modules),
> or PCI controller drivers built as modules.
>=20
> I happen to be using both pwrctrl and controller drivers as modules, so
> I hit it that way.
>=20
> > Adding that pm_runtime_get_noresume() doesn't look useful given=20
> > pm_runtime_forbid() already increases PM usage count. If this problem i=
s=20
> > actually seen in practice, there could a bug elsewhere where something=
=20
> > decrements usage count too early so this change "helps" by double=20
> > incrementing the usage count.
> >=20
> > To find more information what's going on, one could try to trace events=
=20
> > for the PM usage count (though last time I looked not all paths that=20
> > change PM usage count were covered by the event and adding the=20
> > trace_event() calls into the header turned out too much magic for me to=
=20
> > figure out so I couldn't solve the problem).
>=20
> See above. forbid() is not a guaranteed blocker, because user space can
> undo it.
>=20
> > > Patch LGTM in principle, but adding Ilpo to cc who is refactoring PCI
> > > resource allocation and may judge whether this can actually happen.
> >=20
> > I can see there could be other failure modes besides just saving wrong=
=20
> > config if devices get suspended underneath the resource assignment=20
> > algorithm.
> >=20
> > Besides hotplug, also BAR resize does changes the resources and BARs.
> > This case is not helped by this patch.
>=20
> Is that the 'resource_N_resize' sysfs attributes? Becuase that holds PM
> references (pci_config_pm_runtime_{get,put}()) and therefore should not
> generally have the same problem.

Okay, seem fine for the PCI core part.

Driver's can also trigger BAR resize by calling pci_resize_resource()=20
directly but I've no idea how the usage counts behave (TBH, PM isn't my=20
strongest forte even if Lukas pulled me in to comment).

> pci-driver.c's runtime suspend will
> save a new copy of the registers the next time we suspend after resize.
>=20
> (Now, some drivers could have problems if they try to stash a static
> copy via pci_store_saved_state()/pci_load_saved_state(), but that
> invites plenty of its own problems anyway.)
>=20
> > I also recently learned some DT platforms do the "actual" scan for the =
bus=20
> > later on Link Up event through irq which could perhaps occur late enoug=
h,=20
> > I dunno for sure.
>=20
> Sure, but that'd be covered by my patch, as those (re)scans would
> discover new devices in the same scan+add flow.

Okay, maybe it's fine like the rest. I was mostly trying to think=20
non-subsys_initcall() cases I knew of without contextualizing them back to=
=20
this patch.

> > > I think the code comments you're adding are a little verbose and a si=
mple
> > > /* acquired in pci_pm_init() */ in pci_bus_add_device() may be suffic=
ient.
> >=20
> > I'm also not entirely convinced these always pair
>=20
> That's a very valid question. There are so many variations of scan+add
> that it's been hard for me to tell.

I've noticed... unfortunately I find myself often in the same boat. :-/

> I've studied the code pretty
> closely, and tested what I could, but I don't have hotplug systems on
> hand, and I definitely could miss something.
>=20
> FWIW, Rafael suggested/implied an alternative, where I could simply
> delay pm_runtime_enable() until pci_bus_add_device(). That would dodge
> the pairing questions, I think.

Yes.

> > or if the pci_dev may=20
> > get removed before pci_bus_add_device(), see e.g., enable_slot() in=20
> > hotplug/acpiphp_glue.c that does acpiphp_sanitize_bus() before=20
> > pci_bus_add_devices() (which could have other bugs too as is).
>=20
> I believe it should be OK if a device is removed before the
> pm_runtime_put_noidle() half of the pair. It just means the device gets
> destroyed with a nonzero PM usage count, which is legal.

Ah yes, I think I was too attached to the "pairing" thought at that point=
=20
to see this isn't like e.g. a lock/unlock pair.


--=20
 i.
--8323328-1420943740-1760974941=:976--

