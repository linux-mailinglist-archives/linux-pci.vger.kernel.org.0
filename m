Return-Path: <linux-pci+bounces-38504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3D2BEB1B4
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 19:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C9E5E6AAA
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 17:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AED93081B8;
	Fri, 17 Oct 2025 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c1xyhNNP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11F11C6A3
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723003; cv=none; b=n3cXNFfhC0rZi7MyIJOOD2Q0ntvr4V2LCpV2o3SyEQcGAaf3+bdPGNb59sM9ZeOoEu9jZDU4z654octDqoktkhU9WVdv1yVM3JuJvNA9EHbB1Gkal1CtkoxLNHQBGJgGxfmSu1P90E6O5ec6VihJ0nU4mo4wO6eijZ/YObhJzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723003; c=relaxed/simple;
	bh=fNeu3PTzUlSonYkGlDlZUhg3INQX4HKAUUy+rCL2EDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg2X4/tL7qV5OX2pVnCdNOIRcaPmI6QAuD0MH5Xpkqe0wsNkUqBMdbUP/vG4CZJNtZxEdUFoLa0et4U3N65NIqp5bK+CzUCDEGjj86EFDu74Yh48ojYuoeQQfDFn/4ZYRm7OSIHIDhs8LpzQDrcnq9kiO1rd2HwwcH/Kwx2BN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c1xyhNNP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7930132f59aso3053835b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760723001; x=1761327801; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m21nEebS/lDv6RHO5+kxYBjvg2aPuyB4qwGDVVvkyhk=;
        b=c1xyhNNPUoZm3k76fWMUXnMXD9PqPFdPpPeY4VH/bcLa9vhYjLdroB0Sh01OHToY3I
         s71oOxe3v8n25XjQ5qlUiZZ/OU4QMs/PMvAreT9Mm5ZiY5hWHv4Ie8rfiD5W0Ar1VvVs
         HZa4LafUsn+ZcoUeK3L5gCr1Km4OzinETRBA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760723001; x=1761327801;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m21nEebS/lDv6RHO5+kxYBjvg2aPuyB4qwGDVVvkyhk=;
        b=bSYN70VyXZvBb9uMJvtHlJFKm30NYaq+0Fx5GzAfxqq0XggcM4yQxeaynGMID3rBYD
         IKs0Ps8u6jd7vCW+X1NojYn/Sz3j4IVhpyZPKDlRW7hwAsZN4AQKDvdwwaswg7CKSgV3
         ykR/514DM0Y/YzyMopAuijLKt6gv7+1/VCqJxXdCfQp/F1x+hPZ77xraAgsWepe2BrV2
         lTZQOd7N/l6TW2SX7oaBWmi1euCKL1qr+K9r78GW1z2z67sujo/JcHtj2LToVE1OIhYg
         gK+lS/BC8nfv8fStBokWGJkNN4n/VvoIF5+wHfICjfORoO/3JkPyk17ky76wVH1Q/mkL
         NJpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqaT3+u343MUiUkbICdcYnN97/jc1GsL8acwK9kn4jGG4l2rlsz1cMnFl2xOUO8SD0ZaoUmrcC/HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAmXRahwt4ut+25BJKJSTqoyJRSkoqAnI7boPxlUGO+TAKcZ2v
	QxAtf/zStwieYoRQFWUw2iY5pGu+r6dv4B1viN8vrFWD6s6Y4IgzYusmWYiiSGG++g==
X-Gm-Gg: ASbGnctlO8DggkgIphXY/7cqZYHNzg8vru2lHKLENOgK81MJeMqOFJf45Q/YBtQF5WQ
	6I1bZeg+cs4HEP8XbyN0Zf/Zt4ZHov9urMW9XXfMKSX3NHknIZvh28yfKUdBfprmI5cdohHbzj7
	2MEZvCfSppyh3aSrk9CB5Kgwh5NVqzULZnrhulyeug0Qi1hjt4sDegCcuhJ/3fqOv/n+xUfFfGM
	y8QLUK6Ws465NYneKzqUF/U0Lzb7UVfd3pFsb6ggEF9rw5NNtc7dZ0RrPUG88ktw0u2IuRtYiMv
	YUvceSej0LmMRomG34rCxmIXC3/XWRHq/kYR1ttlED/fWLlE/Flgul9EDF7Qq7TBAXrFopHUBhy
	+uNsGTxX1/xBlfI4RHIzd4pnCiUcIp+ibBt93Mp/wyiHft28gLC98CGtZ9eyLaZiJEu4uHkVqLN
	gzo5gbynbLGE90i9+foCWwzomZUEe2sScEXgwqATrGa0P68pRGE/NK7b36IBQ=
X-Google-Smtp-Source: AGHT+IEmKohETn9m2ghQ2ok5r1R0o1KkS97y/E+/L3+8ANZcSoCW1/9ppcCESL9vaPrGruCpstEuoQ==
X-Received: by 2002:a05:6a00:1a87:b0:781:2401:74f5 with SMTP id d2e1a72fcca58-7a220d56e59mr5117972b3a.29.1760723000694;
        Fri, 17 Oct 2025 10:43:20 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5ca9:a8d0:7547:32c6])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7a22ff184basm165783b3a.15.2025.10.17.10.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 10:43:20 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:43:18 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
Message-ID: <aPKANja_k1gogTAU@google.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <aPH_B7SiJ8KnIAwJ@wunner.de>
 <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com>

Hi Ilpo and Lukas,

I'll reply to both of you inline:

On Fri, Oct 17, 2025 at 02:49:35PM +0300, Ilpo Järvinen wrote:
> On Fri, 17 Oct 2025, Lukas Wunner wrote:
> 
> > [cc += Ilpo]
> > 
> > On Thu, Oct 16, 2025 at 03:53:35PM -0700, Brian Norris wrote:
> > > PCI devices are created via pci_scan_slot() and similar, and are
> > > promptly configured for runtime PM (pci_pm_init()). They are initially
> > > prevented from suspending by way of pm_runtime_forbid(); however, it's
> > > expected that user space may override this via sysfs [1].
> 
> Is this true as pm_runtime_forbid() also increases PM usage count?

Yes it's true. See below.

> "void pm_runtime_forbid(struct device *dev);
> 
> unset the power.runtime_auto flag for the device and increase its 
> usage counter (used by the /sys/devices/.../power/control interface to 
> effectively prevent the device from being power managed at run time)"

Right, but sysfs `echo auto > .../power/control` performs the inverse --
pm_runtime_allow() -- which decrements that count.

> > > Now, sometime after initial scan, a PCI device receives its BAR
> > > configuration (pci_assign_unassigned_bus_resources(), etc.).
> > > 
> > > If a PCI device is allowed to suspend between pci_scan_slot() and
> > > pci_assign_unassigned_bus_resources(), then pci-driver.c will
> > > save/restore incorrect BAR configuration for the device, and the device
> > > may cease to function.
> > > 
> > > This behavior races with user space, since user space may enable runtime
> > > PM [1] as soon as it sees the device, which may be before BAR
> > > configuration.
> > > 
> > > Prevent suspending in this intermediate state by holding a runtime PM
> > > reference until the device is fully initialized and ready for probe().
> >
> > Not sure if that is comprehensible by everybody.

Yeah, thanks for trying to clarify. After getting too far into the weeds
on a bug, I sometimes don't spend the appropriate time on writing a
simple problem description. Maybe I can do better on a v2.

> > The point is that
> > unbound devices are left in D0 but are nevertheless allowed to
> > (logically) runtime suspend.  And pci_pm_runtime_suspend() may call
> > pci_save_state() while config space isn't fully initialized yet,
> > or pci_pm_runtime_resume() may call pci_restore_state() (via
> > pci_pm_default_resume_early()) and overwrite initialized config space
> > with uninitialized data.

Ack.

> > Have you actually seen this happen in practice?

Yes, that's why I spent my time debugging and submitting this patch :)

> > Normally enumeration
> > happens during subsys_initcall time, when user space isn't running yet.
> > Hotplug may be an exception though.

Hotplug, rescan (e.g., when pwrctrl is in use, power may be stablished
later on, and it triggers a bus rescan; pwrctrl drivers can be modules),
or PCI controller drivers built as modules.

I happen to be using both pwrctrl and controller drivers as modules, so
I hit it that way.

> Adding that pm_runtime_get_noresume() doesn't look useful given 
> pm_runtime_forbid() already increases PM usage count. If this problem is 
> actually seen in practice, there could a bug elsewhere where something 
> decrements usage count too early so this change "helps" by double 
> incrementing the usage count.
> 
> To find more information what's going on, one could try to trace events 
> for the PM usage count (though last time I looked not all paths that 
> change PM usage count were covered by the event and adding the 
> trace_event() calls into the header turned out too much magic for me to 
> figure out so I couldn't solve the problem).

See above. forbid() is not a guaranteed blocker, because user space can
undo it.

> > Patch LGTM in principle, but adding Ilpo to cc who is refactoring PCI
> > resource allocation and may judge whether this can actually happen.
> 
> I can see there could be other failure modes besides just saving wrong 
> config if devices get suspended underneath the resource assignment 
> algorithm.
> 
> Besides hotplug, also BAR resize does changes the resources and BARs.
> This case is not helped by this patch.

Is that the 'resource_N_resize' sysfs attributes? Becuase that holds PM
references (pci_config_pm_runtime_{get,put}()) and therefore should not
generally have the same problem. pci-driver.c's runtime suspend will
save a new copy of the registers the next time we suspend after resize.

(Now, some drivers could have problems if they try to stash a static
copy via pci_store_saved_state()/pci_load_saved_state(), but that
invites plenty of its own problems anyway.)

> I also recently learned some DT platforms do the "actual" scan for the bus 
> later on Link Up event through irq which could perhaps occur late enough, 
> I dunno for sure.

Sure, but that'd be covered by my patch, as those (re)scans would
discover new devices in the same scan+add flow.

> > I think the code comments you're adding are a little verbose and a simple
> > /* acquired in pci_pm_init() */ in pci_bus_add_device() may be sufficient.
> 
> I'm also not entirely convinced these always pair

That's a very valid question. There are so many variations of scan+add
that it's been hard for me to tell. I've studied the code pretty
closely, and tested what I could, but I don't have hotplug systems on
hand, and I definitely could miss something.

FWIW, Rafael suggested/implied an alternative, where I could simply
delay pm_runtime_enable() until pci_bus_add_device(). That would dodge
the pairing questions, I think.

> or if the pci_dev may 
> get removed before pci_bus_add_device(), see e.g., enable_slot() in 
> hotplug/acpiphp_glue.c that does acpiphp_sanitize_bus() before 
> pci_bus_add_devices() (which could have other bugs too as is).

I believe it should be OK if a device is removed before the
pm_runtime_put_noidle() half of the pair. It just means the device gets
destroyed with a nonzero PM usage count, which is legal.

> > Also, I think it is neither necessary nor useful to actually cc the e-mail
> > to stable@vger.kernel.org if you include a stable designation in the
> > patch.  I believe stable maintainers only pick up backports from that list,
> > not patches intended for upstream.
> 
> Probably some tool will auto-insert the Cc: tags as receipients so it 
> might be non-trivial to get rid of it.

Yeah, git-send-email applies "Cc:" lines automatically, so I expect it's
very common for people to do that. I use U-Boot's patman, which wraps
git-send-email. I just assume stable@ folks expect that or are at least
used to it, because ... well, "Cc:" usually means "copy this on the
email" ...

git-send-email has --suppress-cc, and maybe I can convince my tools to
do that. (e.g., `git config sendemail.suppresscc cc`)

Brian

