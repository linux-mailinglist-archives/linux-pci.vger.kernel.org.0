Return-Path: <linux-pci+bounces-38797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1A9BF30A0
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 20:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BF1401DE0
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 18:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE90A2D3A77;
	Mon, 20 Oct 2025 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ejz0yDOo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA5DA926
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986372; cv=none; b=nYZYo+5WuPCD0mlzrGmIQWZEy/wvAw8VozFoCP0C9Ycl/XN0mTr8CyP70YH9atHlMVVTuvEQUE8L4ajcZIO/WpYx1hR6wS0B58xDBgL2SmqseZx2CQL+Z+6Oz6xlzPil5df5ATQuDk8w1kiKXjl3+uKkDff+MeWfjiUm7pyFJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986372; c=relaxed/simple;
	bh=O0Qsp6HTPTxCPWbUjZe0P+yQW8HB8Ku6D+f7nISUFtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoHOMuKUCeteqFx66Ta9Dk7+MNOrb2+exRZ4TaI7n741TbH9yAX3pLfk/Te+grUHkbdshwRrkYv//cMHfXcCvmw8+OLmvBbeniMaOwZrKaSOtmfTsiy46JTTEinjU2VTtUc7yD8oss/KJZ4u30LxlOJsMr+keB5CB/nL3zxkwMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ejz0yDOo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7810289cd4bso4507723b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 11:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760986370; x=1761591170; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SpIynvegjR22Q4YHC5qBxpjjnmowauSfD2NRwQPuzyA=;
        b=ejz0yDOoEikGRESL6lOaBodx478OQLCMlkWwpZEvMxx+fNr6PdoYwaSOlHrYtTBIpI
         OBpzo0QF4XYLWD3U6+XKNFLTic4sdSnyo7whBMz1nwLx9grz7wiwjB91JJrqC9FqNeDk
         Mhf6AlaXf3WxMA+kYA2m1gVbcD0sSqwd4kRY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760986370; x=1761591170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpIynvegjR22Q4YHC5qBxpjjnmowauSfD2NRwQPuzyA=;
        b=tc8aEZkzdVVT8qC9BLLrADnOpktZ5FfEyjiNXE3YvMTZlhhamINh0Ox1hyrvC41PqF
         OgOFGuo4W5421Z5+CqIigmZSSDE4V2o7o4TBjFi5zRq1aPyAsB4oPMVZ6SZWPSEEQse3
         deDJUq4W5k9JRl1S1BT9DeMovuo4RG1OplBAfF4I6dgQP4UpR3qNr5nWaNTcFwtUmQCD
         WdcckcW7evoxo2nqUnRA9aG82R0BCtKvkqCLVCl6mbvRzieGg/7Im3DLxleZlYyi62im
         xGmsH+Jxvc1k/jLxGK1yM1/DpP4juzKT9N2m/P4HWOFlMf/TXvH0Wt6g9JVFlz2ByJeq
         RbcA==
X-Forwarded-Encrypted: i=1; AJvYcCWAFCDu7uEFCPMtqVRPddkdC53eYcnaCjllc0DkZ98zZt1u8NhXVUDzeZ3xQpW4H8E0kDsl/10KuHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb7HSuIlxKNfUnRGGRChaw1k38MCOPM/E4VXP359fV2LAnsroM
	aT16xOZn+Io9yENxLIYiw2+oxz4S2ZxPB7/ymkP/waWe84drqiFrpp/7Rc99D7StlICXPhoNBGi
	+mvQ=
X-Gm-Gg: ASbGncu9EHBuTJJUVDAaLX0K/GSuofyiO+yHoogD9bsScMWJsvNaEeSePwrPZVfxPoc
	u8U77ebHG1wALd7Uzh+cfkei2/7wb82EOLCO2DQo90a2lsBy3IR6bGWT5kN/He8g9VJEqvfu8Wz
	umQ4/NRcTzIocHk0oYNem/oc2Xc1nnqRCHtbK1x3d84oFHNAF2N+jvjbeBX4kJtrS4ZcXjKSYP0
	x+L8wF3H5PYG/eREQWvhiymX/wXRFkcpWRG1crfVWNjGl+R3gwqdjeP2OGkFgNSk1ZOjhqCVwlJ
	CXHw8ZgUX36Ci2gWwdITOVHQK9wPPgoOsENkVByHrwgAc67VgBR2jGSNh++ZXfsLznGDNPhHhCQ
	1YgOjKc6TR0YHYDkaeWDgpRryCOG54I7HUo1MeHpEiKyd4QQvwui5qoxBFm9/U9HGV9tTM6wJI9
	uDwh/947uoky86SC6mCXdVmNRnxHxvS3laAh7XEuQIq7iVcmuShjk/a7Fn4Q==
X-Google-Smtp-Source: AGHT+IHmGLFxBbueM4IopZ6jkRLe8Fz33+8pBqAuMQfkaf78ZCea9ju5GU1cNvCEv+znR85Tq/TVwA==
X-Received: by 2002:a05:6a00:4c83:b0:781:2656:1d6b with SMTP id d2e1a72fcca58-7a220b1eb48mr16934941b3a.24.1760986370446;
        Mon, 20 Oct 2025 11:52:50 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f21:3ecc:2915:f4cb])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7a230121ed6sm8936589b3a.73.2025.10.20.11.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 11:52:49 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:52:48 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
Message-ID: <aPaFACsVupPOe67G@google.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <aPH_B7SiJ8KnIAwJ@wunner.de>
 <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com>
 <aPKANja_k1gogTAU@google.com>
 <08976178-298f-79d9-1d63-cff5a4e56cc3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08976178-298f-79d9-1d63-cff5a4e56cc3@linux.intel.com>

Hi Ilpo,

On Mon, Oct 20, 2025 at 06:56:41PM +0300, Ilpo Järvinen wrote:
> On Fri, 17 Oct 2025, Brian Norris wrote:
> 
> > Hi Ilpo and Lukas,
> > 
> > I'll reply to both of you inline:
> 
> I see you posted v2 but I'm answering here to have the context available. 

Sure!

> Mostly things seem okay after your explanation, I think the only question 
> mark is a driver calling pci_resize_resource() directly to resize BARs.
> 
> > On Fri, Oct 17, 2025 at 02:49:35PM +0300, Ilpo Järvinen wrote:
> > > On Fri, 17 Oct 2025, Lukas Wunner wrote:
> > > 
> > > > [cc += Ilpo]
> > > > 
> > > > On Thu, Oct 16, 2025 at 03:53:35PM -0700, Brian Norris wrote:
> > > > > PCI devices are created via pci_scan_slot() and similar, and are
> > > > > promptly configured for runtime PM (pci_pm_init()). They are initially
> > > > > prevented from suspending by way of pm_runtime_forbid(); however, it's
> > > > > expected that user space may override this via sysfs [1].
> > > 
> > > Is this true as pm_runtime_forbid() also increases PM usage count?
> > 
> > Yes it's true. See below.
> > 
> > > "void pm_runtime_forbid(struct device *dev);
> > > 
> > > unset the power.runtime_auto flag for the device and increase its 
> > > usage counter (used by the /sys/devices/.../power/control interface to 
> > > effectively prevent the device from being power managed at run time)"

I see this doc line confused you, and I can sympathize.

IIUC, the parenthetical means that sysfs *uses* pm_runtime_forbid() to
"effectively prevent runtime power management"; pm_runtime_forbid() does
not block user space from doing anything.

> > Right, but sysfs `echo auto > .../power/control` performs the inverse --
> > pm_runtime_allow() -- which decrements that count.
> 
> Fair enough, I didn't check what it does.
> 
> IMO, the details about how the usage count behaves should be part of the 
> changelog as that documentation I quoted sounded like user control is 
> prevented when forbidden.

I tried to elaborate on the API doc confusion above. But frankly, I'm
not sure how best to explain runtime PM.

> I see you've put this part of the explanation 
> into the v2 as well so I suggest you explain the usage count in the change 
> so it is recorded in the commit if somebody has to look at this commit 
> years from now.

Both v1 and v2 mention that the sysfs 'power/control' file can override
the kernel calling pm_runtime_forbid(). They don't mention the usage
count, since that's an implementation detail IMO. (To me, the mental
model works best if "usage count" (usually get()/put()) is considered
mostly orthogonal to forbid()/allow()/sysfs, because "forbid()" can be
overridden at any time.)

This is also covered here:

https://docs.kernel.org/power/runtime_pm.html#runtime-pm-initialization-device-probing-and-removal

"In principle, this mechanism may also be used by the driver to
effectively turn off the runtime power management of the device until
the user space turns it on."

But admittedly, I find the runtime PM API surface to be enormous, and
its documentation ... not very helpful to outsiders. It's pretty much
written by and for PM experts. Case in point: you read and quoted the
appropriate docs, but it still misled you quite a bit :(

I'm more tempted to try to improve the runtime PM docs than to try to
make up for them in the commit message, but maybe I can be convinced
otherwise.

> > > > > Now, sometime after initial scan, a PCI device receives its BAR
> > > > > configuration (pci_assign_unassigned_bus_resources(), etc.).
> > > > > 
> > > > > If a PCI device is allowed to suspend between pci_scan_slot() and
> > > > > pci_assign_unassigned_bus_resources(), then pci-driver.c will
> > > > > save/restore incorrect BAR configuration for the device, and the device
> > > > > may cease to function.
> > > > > 
> > > > > This behavior races with user space, since user space may enable runtime
> > > > > PM [1] as soon as it sees the device, which may be before BAR
> > > > > configuration.
> > > > > 
> > > > > Prevent suspending in this intermediate state by holding a runtime PM
> > > > > reference until the device is fully initialized and ready for probe().
> > > >
> > > > Not sure if that is comprehensible by everybody.
> > 
> > Yeah, thanks for trying to clarify. After getting too far into the weeds
> > on a bug, I sometimes don't spend the appropriate time on writing a
> > simple problem description. Maybe I can do better on a v2.
> > 
> > > > The point is that
> > > > unbound devices are left in D0 but are nevertheless allowed to
> > > > (logically) runtime suspend.  And pci_pm_runtime_suspend() may call
> > > > pci_save_state() while config space isn't fully initialized yet,
> > > > or pci_pm_runtime_resume() may call pci_restore_state() (via
> > > > pci_pm_default_resume_early()) and overwrite initialized config space
> > > > with uninitialized data.
> > 
> > Ack.
> > 
> > > > Have you actually seen this happen in practice?
> > 
> > Yes, that's why I spent my time debugging and submitting this patch :)
> 
> Thanks for doing it! :-)
> 
> > > > Normally enumeration
> > > > happens during subsys_initcall time, when user space isn't running yet.
> > > > Hotplug may be an exception though.
> > 
> > Hotplug, rescan (e.g., when pwrctrl is in use, power may be stablished
> > later on, and it triggers a bus rescan; pwrctrl drivers can be modules),
> > or PCI controller drivers built as modules.
> > 
> > I happen to be using both pwrctrl and controller drivers as modules, so
> > I hit it that way.
> > 
> > > Adding that pm_runtime_get_noresume() doesn't look useful given 
> > > pm_runtime_forbid() already increases PM usage count. If this problem is 
> > > actually seen in practice, there could a bug elsewhere where something 
> > > decrements usage count too early so this change "helps" by double 
> > > incrementing the usage count.
> > > 
> > > To find more information what's going on, one could try to trace events 
> > > for the PM usage count (though last time I looked not all paths that 
> > > change PM usage count were covered by the event and adding the 
> > > trace_event() calls into the header turned out too much magic for me to 
> > > figure out so I couldn't solve the problem).
> > 
> > See above. forbid() is not a guaranteed blocker, because user space can
> > undo it.
> > 
> > > > Patch LGTM in principle, but adding Ilpo to cc who is refactoring PCI
> > > > resource allocation and may judge whether this can actually happen.
> > > 
> > > I can see there could be other failure modes besides just saving wrong 
> > > config if devices get suspended underneath the resource assignment 
> > > algorithm.
> > > 
> > > Besides hotplug, also BAR resize does changes the resources and BARs.
> > > This case is not helped by this patch.
> > 
> > Is that the 'resource_N_resize' sysfs attributes? Becuase that holds PM
> > references (pci_config_pm_runtime_{get,put}()) and therefore should not
> > generally have the same problem.
> 
> Okay, seem fine for the PCI core part.
> 
> Driver's can also trigger BAR resize by calling pci_resize_resource() 
> directly but I've no idea how the usage counts behave (TBH, PM isn't my 
> strongest forte even if Lukas pulled me in to comment).

There are only 3 drivers that call pci_resize_resource(). I looked into
them, and it looks like they all hold pm_runtime_* references while
doing this, or are calling it during pci_driver probe(), which docs say
will hold a reference.

https://docs.kernel.org/power/pci.html#device-runtime-power-management

So they should all be OK too.

> > pci-driver.c's runtime suspend will
> > save a new copy of the registers the next time we suspend after resize.
> > 
> > (Now, some drivers could have problems if they try to stash a static
> > copy via pci_store_saved_state()/pci_load_saved_state(), but that
> > invites plenty of its own problems anyway.)
> > 
> > > I also recently learned some DT platforms do the "actual" scan for the bus 
> > > later on Link Up event through irq which could perhaps occur late enough, 
> > > I dunno for sure.
> > 
> > Sure, but that'd be covered by my patch, as those (re)scans would
> > discover new devices in the same scan+add flow.
> 
> Okay, maybe it's fine like the rest. I was mostly trying to think 
> non-subsys_initcall() cases I knew of without contextualizing them back to 
> this patch.

Sure, thanks for the pointers. I'm happy to look into other areas if you
suspect there might similar PM-related bugs.

> > > > I think the code comments you're adding are a little verbose and a simple
> > > > /* acquired in pci_pm_init() */ in pci_bus_add_device() may be sufficient.
> > > 
> > > I'm also not entirely convinced these always pair
> > 
> > That's a very valid question. There are so many variations of scan+add
> > that it's been hard for me to tell.
> 
> I've noticed... unfortunately I find myself often in the same boat. :-/
> 
> > I've studied the code pretty
> > closely, and tested what I could, but I don't have hotplug systems on
> > hand, and I definitely could miss something.
> > 
> > FWIW, Rafael suggested/implied an alternative, where I could simply
> > delay pm_runtime_enable() until pci_bus_add_device(). That would dodge
> > the pairing questions, I think.
> 
> Yes.
> 
> > > or if the pci_dev may 
> > > get removed before pci_bus_add_device(), see e.g., enable_slot() in 
> > > hotplug/acpiphp_glue.c that does acpiphp_sanitize_bus() before 
> > > pci_bus_add_devices() (which could have other bugs too as is).
> > 
> > I believe it should be OK if a device is removed before the
> > pm_runtime_put_noidle() half of the pair. It just means the device gets
> > destroyed with a nonzero PM usage count, which is legal.
> 
> Ah yes, I think I was too attached to the "pairing" thought at that point 
> to see this isn't like e.g. a lock/unlock pair.

Thanks for looking things over.

Brian

