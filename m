Return-Path: <linux-pci+bounces-38934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89285BF8069
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 20:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC65407BF3
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 18:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F0A35028A;
	Tue, 21 Oct 2025 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZLxj3aNU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87DB355815
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761070440; cv=none; b=Qoo20lofGeyzlhN69w6sYZNJbdzcNC7sBR6dIOgq3OH++AFwVaWb/ZjZO4tjloLhQwbLDvi0M4pLto9Z3B61nPRa/JuEd/ID8+qlF3WO0ULb4DNBcqahKk69tSe1RUNQKcnhOZQOujZ634q4U95ncwIYFNIM1uQyY4PSUywplZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761070440; c=relaxed/simple;
	bh=Zq04AkN31S/Vd/+enVMShPXlGIzgsAtiFZPsYWEkVcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzOUyMW+kfHukxU7ke5X1pKxbBzxHJZ13zpsXilQdmgmWI4rDAPz1Csw26yCTic85VYNuSvwfSKCOW7o/fV+OvgekHGR5+gzZ7rZaaL2CCpR0+lZ4X4+Xrn2TS+xt0CJWeuWjtlF4A5aKAF8zoM3qw5iWCrmJmx7vWfGIEUx9s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZLxj3aNU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso5308300b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761070438; x=1761675238; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P0P9b8dHpGC6G96k5OASd/8FiZ7xJrpHI2jZPuc5OpM=;
        b=ZLxj3aNUmltt7roVVVvtnzE5+xuVXEfSL5H5IYUvZ3jiN0LVqIV5vWLesTterOs1xc
         DV2j2VOkjviuocZaYaCOMrnyjDnHGZ8Fp8ffcXfnSRNnWKE8dEttBUX1VhkqzDyalqCs
         LKkApsp2ZTVJjpE4HBtRnsL8t5IAUQTtvUEZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761070438; x=1761675238;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0P9b8dHpGC6G96k5OASd/8FiZ7xJrpHI2jZPuc5OpM=;
        b=KU6oINUBgmYjwm/C6DWyYLph5Uw+y8o46csTM5TqClMnYpyvLncNChVbr6kbAbD+rG
         yIwAgInyZWGISTh/LFHqC/nGCs+HFY7ZfjLpl5qPdG+yzhqGS9NHhlPVq+iF+m/7JRKK
         gzO1asHMaNSZmxTovft6z+vh11Fm/SVfXFkylvpqFzfjCrJEHrfa/K3e+FWvpOcmRdB6
         pt2/qi4yjNaRCi1qod1GlGBHchxSrrq+TBd1IHP8NIYk1lr3FFURnp0pvoTdZPoxkJFq
         lRHPVOJI6rb9UVOQH766FG+mJmFdfW6K0DEuckNTWmUXiQDIICylKoJ9Qh74AW3Jn0bh
         p7Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUlnWrSDlRLl5K/xpLpC5esptCwyz/baOl9BSvkvDMkJMnDMzFiYaiK/HWCGxiUNfcf6ZAIyh/oBP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwyMOWggQUSTuzn0wi4Nz+jNK/9Qtyki+Nfgw9xCe7jLA18I4m
	AMDJ+jSoVZPRTmbU+bz1uwsgAjnDN4uxjdK9ATnnbcKrgL89bRq4E0dJehwuOFDWqg==
X-Gm-Gg: ASbGncvIoCGMAYtrwQuWZ/5OVrehk65xb1Ko76G87J1Q/FlLYtz1gvJUOvJZDLcOsWE
	vfgPkOTCXqT+0YrgNm2c+5ZL5fPZgM1p0gVVPTO0osEXnpicxR9PIbENxAcbwDOIrd+VagZtoaW
	f3IPRMc3AfWfwCrBxdeUtx1sCH5gNalACJBtw72SN3fby5NaVAq2Z2lY3uVut9JFVcVYrulhdA0
	X13ZKDAniWH6p8mAscbYsg1R9fdWEr7vFx4pvE45u5/v8KKSIhcy58JP2lyOcfQxY+8qpJ9UpRn
	MmLO+zkB3LNEUze8VOzdGSm5tw35/zkoy+nzs9Q+SH0KoBwQ11f/Txyz3tt3pD8FxDt4zGYBxag
	PS4RFA6tuwPybFtur0HQhA4KIL8S2BvJW5cln9g32LGNGguveGP9k64UnNVyQ7avGJ0CiNDTGnx
	lEZmptPFXjJDVaHLUfvLjAQC6eBBUOxbSbGkbuy5qmuQdFR3Tm
X-Google-Smtp-Source: AGHT+IG1npocCe1PQWfvS5usY720dFg7m3XEzLBCBUNg6tqxpkSJ0HqVY+vQVt2jEKAPs99a69hTqg==
X-Received: by 2002:a05:6a00:b8d:b0:781:15b0:bed9 with SMTP id d2e1a72fcca58-7a220ab6c38mr22831377b3a.17.1761070437918;
        Tue, 21 Oct 2025 11:13:57 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:e63a:4ad2:c410:7d7e])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7a22ff184basm12063539b3a.15.2025.10.21.11.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 11:13:57 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:13:55 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
Message-ID: <aPfNY9Yig2cR-Fua@google.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <aPH_B7SiJ8KnIAwJ@wunner.de>
 <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com>
 <aPKANja_k1gogTAU@google.com>
 <08976178-298f-79d9-1d63-cff5a4e56cc3@linux.intel.com>
 <aPaFACsVupPOe67G@google.com>
 <06cd0121-819d-652d-afa7-eece15bf82a2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06cd0121-819d-652d-afa7-eece15bf82a2@linux.intel.com>

Hi Ilpo,

On Tue, Oct 21, 2025 at 02:27:09PM +0300, Ilpo Järvinen wrote:
> On Mon, 20 Oct 2025, Brian Norris wrote:
> > On Mon, Oct 20, 2025 at 06:56:41PM +0300, Ilpo Järvinen wrote:
> > > On Fri, 17 Oct 2025, Brian Norris wrote:
> > > > On Fri, Oct 17, 2025 at 02:49:35PM +0300, Ilpo Järvinen wrote:
> > > > > On Fri, 17 Oct 2025, Lukas Wunner wrote:
> > > > > > On Thu, Oct 16, 2025 at 03:53:35PM -0700, Brian Norris wrote:
> > > > > > > PCI devices are created via pci_scan_slot() and similar, and are
> > > > > > > promptly configured for runtime PM (pci_pm_init()). They are initially
> > > > > > > prevented from suspending by way of pm_runtime_forbid(); however, it's
> > > > > > > expected that user space may override this via sysfs [1].
> > > > > 
> > > > > Is this true as pm_runtime_forbid() also increases PM usage count?
> > > > 
> > > > Yes it's true. See below.
> > > > 
> > > > > "void pm_runtime_forbid(struct device *dev);
> > > > > 
> > > > > unset the power.runtime_auto flag for the device and increase its 
> > > > > usage counter (used by the /sys/devices/.../power/control interface to 
> > > > > effectively prevent the device from being power managed at run time)"
> > 
> > I see this doc line confused you, and I can sympathize.
> > 
> > IIUC, the parenthetical means that sysfs *uses* pm_runtime_forbid() to
> > "effectively prevent runtime power management"; pm_runtime_forbid() does
> > not block user space from doing anything.
> >
> > > > Right, but sysfs `echo auto > .../power/control` performs the inverse --
> > > > pm_runtime_allow() -- which decrements that count.
> > > 
> > > Fair enough, I didn't check what it does.
> > > 
> > > IMO, the details about how the usage count behaves should be part of the 
> > > changelog as that documentation I quoted sounded like user control is 
> > > prevented when forbidden.
> > 
> > I tried to elaborate on the API doc confusion above. But frankly, I'm
> > not sure how best to explain runtime PM.
> > 
> > > I see you've put this part of the explanation 
> > > into the v2 as well so I suggest you explain the usage count in the change 
> > > so it is recorded in the commit if somebody has to look at this commit 
> > > years from now.
> > 
> > Both v1 and v2 mention that the sysfs 'power/control' file can override
> > the kernel calling pm_runtime_forbid(). They don't mention the usage
> > count, since that's an implementation detail IMO. (To me, the mental
> > model works best if "usage count" (usually get()/put()) is considered
> > mostly orthogonal to forbid()/allow()/sysfs, because "forbid()" can be
> > overridden at any time.)
> > 
> > This is also covered here:
> > 
> > https://docs.kernel.org/power/runtime_pm.html#runtime-pm-initialization-device-probing-and-removal
> > 
> > "In principle, this mechanism may also be used by the driver to
> > effectively turn off the runtime power management of the device until
> > the user space turns it on."
> 
> The problem is already rooted into the function name, when a function is 
> called "forbid", anyone unfamiliar will think it really forbids 
> something. The docs just further reinforced the idea and the fact that it 
> also increments usage count.
> 
> It is quite unexpected and feels quite illogical (for non-PM person like 
> me) that user interface then goes to reverse that usage count increase, 
> what would be the logical reason why there now are less users for it when 
> user wants to turn on PM? (I understand things are done that way, no need 
> to explain that further, but there are quite a few misleading things in 
> this entire scenario, not just that parenthesis part of the docs.)

Ack. I'm definitely not defending the API names or the docs. I'm
frustrated by the same, by how long it took me to figure out what
everything really means, and by how the same footguns hit everyone I
work with, and we have to write these essays to explain it every time.

> > But admittedly, I find the runtime PM API surface to be enormous, and
> > its documentation ... not very helpful to outsiders. It's pretty much
> > written by and for PM experts. Case in point: you read and quoted the
> > appropriate docs, but it still misled you quite a bit :(
> > 
> > I'm more tempted to try to improve the runtime PM docs than to try to
> > make up for them in the commit message, but maybe I can be convinced
> > otherwise.
> 
> My personal approach is that if something comes up during review, it 
> likely is something also the next person to look at this change (from 
> history, maybe years from now) could similarly stumbles on when trying to 
> understand the change. Thus, it often is worth to mention such things in 
> the changelog too.

Yes, I like that approach too. Unfortunately in this case, it feels like
most of the confusion stems from the existing API and docs, and not from
anything in the description. I never even mentioned the usage count,
because frankly, I don't think it's relevant to the forbid()/allow()
topic. In fact, the whole bug is because forbid() does *not* guarantee
anything from the kernel's point of view -- it doesn't really hold a
"usage count" for functional correctness in the way get()/put() do.

Regardless, I can try to insert some language. Here's an attempt at yet
another footnote for a v3:

"""
[**] The relationship between pm_runtime_forbid(), pm_runtime_allow(),
/sys/.../power/control, and the runtime PM usage counter can be subtle.
It appears that the intention of pm_runtime_forbid() /
pm_runtime_allow() is twofold:

1. Allow the user to disable runtime_pm (force device to always be
   powered on) through sysfs.
2. Allow the driver to start with runtime_pm disabled (device forced
   on) and user space could later enable runtime_pm.

This conclusion comes from reading `Documentation/power/runtime_pm.rst`,
specifically the section starting "The user space can effectively
disallow".

This means that while pm_runtime_forbid() does technically increase the
runtime PM usage counter, this usage counter is not a guarantee of
functional correctness from the kernel's point of view, because user
space can decrease that count again via sysfs.
"""

Let me know what you think. Or feel free to tweak my v2 message and send
a rewrite back to me (seriously! I'd like to see an outsider's view on
what would explain it best).

(And if that footnote is useful: I think part of that could belong in
the actual docs.)

> While I'm definitely not against improvements to docs too, the changelog 
> for any patch should help to understand why the change was made. And 
> IMO, this unexpected "internal detail" related to usage count which is 
> quite significant here, if user interface wouldn't lower it, runtime PM 
> would remain forbidden as forbid() promised.

I think improving the docs would reap rewards. Like I said, this is by
far not the first time that developers have had significant problems due
to API confusion.

Brian

