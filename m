Return-Path: <linux-pci+bounces-37842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED62BCF688
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 16:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 173DB34A40F
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F5A27A12C;
	Sat, 11 Oct 2025 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjUYJ6T8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32520277CA5
	for <linux-pci@vger.kernel.org>; Sat, 11 Oct 2025 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760191936; cv=none; b=bie612Bu3y2XN3495RpgLDYoxGi5S7JwlNTvf3avoBq2P6a2aCsXThbhDOsaI+kaSFa2M/GXPQz1143b+T3XWNK5LIv+qqmmzbw0OuSa3FgBgRGqVRhDSudLol7AjS7SyyOgCMjK+G5vGoem8t50P+wT8iDYEEtIuw5tIJ7iE0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760191936; c=relaxed/simple;
	bh=828/24r+3oGozQbkjVKhRhyLHFaSJW/gnODjqjPHzTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fj0NQ1bt+172YGT+QfgK234GjQUvnjmQw3r7loXk6BretBZ96l7IIrGjNfZgv3cxb4f7GMZSJ/JOOwQXwaO8Vi9RR0hVqNxJXLZkAzvx7BWuweG9Y5tdriFx+f7xGmC7KlVtYOZ3cgHKZhgyoOPl0zqFBWf2lxV52yIyDY7MddM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjUYJ6T8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so2583115a91.1
        for <linux-pci@vger.kernel.org>; Sat, 11 Oct 2025 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760191933; x=1760796733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlRPoIpCiKD+xIdkRW5gsJN1DQ8DGnEvGebOR/ndlHQ=;
        b=FjUYJ6T81I37wRLgLcFKgJo4bt2NUEuGk8IybvbNCuE/BOoGhjJvY6PVsNcAJTkZ6g
         +PzoPJg1ngJINT8zYEzJ+q1xAaOCY7X9P0zo8lHl/1gOxZix0XptOrPtHQc2M64UjFxq
         ZHf1g1/M9GlemLUpm858AI6J3JcLwiW2DqQ12yiBQyRLWUOTMmZxGPaAi6wkyo/ce64R
         RWrpnIRifSSMZkIZdt6OxvVrRnRUeeMmvxwP80uPbSnAxaVJLsUI+lrWA9OHyCjiSTAB
         wmN2iEjWiBZUer8REO4Rt9yYZRhSxowke+yglOAMYHy6C2At3kvxUCDEBKEG8BJwCf33
         a94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760191933; x=1760796733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlRPoIpCiKD+xIdkRW5gsJN1DQ8DGnEvGebOR/ndlHQ=;
        b=MV8jz/eq0I/QiFxlBUQiYg9cUeFcJaTMivbfof/P84iVRc7b3wLmPSG3X0M3Fl9bgS
         TBL9I9xvpU/e4Rt5W82Ibj6Vl9srPGgUoTSWloqnstEuTS7j6Owno2GzuqnEnhrIRRgO
         aim0+t3bs4bPe0yVPuiRZwqIJ16/TYU1fBEqVeMYBMYEYpNWUQKLWKIRbNDc54QTPx16
         1E41BM8RBdwxnjOd2eRn/FYpgp0BfEaxMov78qa6SS/jL7AwAQN5+LHO1DMM+e0ekG5u
         q5Fdi8v/KQNPu2OEF3W2fbMSJrghT+Ua/Sd/PcCLFZYLLzm9+SqVB6R6jhK9Ar8yBMvs
         k88Q==
X-Gm-Message-State: AOJu0YxDrNi+92jMIUQl3892DQsvMkPJsZ3aQQz9WlfKLXsaHs0xQHOc
	cnEPN6SBAeFOv/2kXRKFQ/eWcW5t6FHdQxzzW3wjAnZD4Oh2nyauEdN4P/lpS9wkmKnX6YzkUX1
	Ab5THIjEJJ7G1CwLzPJHyR4w/ChZoyqGab4HBmtPEBg==
X-Gm-Gg: ASbGncupRo+3UVvhqJHpVFq87FsSAT5pyewj3iXCq6pRm43yNYvCgiUpqdz2aWRSYKn
	/VHs/hsrRnVJGxNosUdJugetu7NRMQ4EtWBXOczJD6TrVfO7WP8A7dLuejCaD5jsAP0KiRZTC6c
	02V49cH1H/0CJku/S85Zwcz9gFKsD4931M+i/+gr3FwJ802YKiHBPJtR01MNAosZ09066a4ZInm
	t77lPa7mxeajXXPLzTa8CS336E=
X-Google-Smtp-Source: AGHT+IEO3jIpOAqiJ/0pYjOlr9HJbriuENn7ZAZCb3PCgtfuek0UZA+WdBGIWHbhvCNGoX0jS84xwK6kZ1paj548rEw=
X-Received: by 2002:a17:90b:1c81:b0:330:7a11:f111 with SMTP id
 98e67ed59e1d1-33b513be2c9mr22205277a91.35.1760191933233; Sat, 11 Oct 2025
 07:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN95MYEaO8QYYL=5cN19nv_qDGuuP5QOD17pD_ed6a7UqFVZ-g@mail.gmail.com>
 <9254be77-46ea-992f-a1bd-98bea3943520@linux.intel.com> <f743efbe-56b7-ad85-f278-743af9385f10@linux.intel.com>
 <82ac5594-61c0-fece-1d9c-7c10316df384@linux.intel.com> <CAN95MYHpdz0u6-J_=7_enxq-TMzRJJJntfjYxBRgrG8UYbhQ1A@mail.gmail.com>
 <eb70b817-175c-7a34-d2bf-9472019afa47@linux.intel.com> <0263ea7c-8df9-1dba-f797-f18e253b3f30@linux.intel.com>
In-Reply-To: <0263ea7c-8df9-1dba-f797-f18e253b3f30@linux.intel.com>
From: Steve Oswald <stevepeter.oswald@gmail.com>
Date: Sat, 11 Oct 2025 17:12:01 +0300
X-Gm-Features: AS18NWBKy5XPjRC9GL-FRK0sg7iXO-2gV0d-NR7RrQ6feQLetjXQhxF90Jpsr0M
Message-ID: <CAN95MYG_hRKrLWVLD9+BFeikOy7W5GN1px3kG8mE0p-DO0aAGA@mail.gmail.com>
Subject: Re: [BUG] Thunderbolt eGPU PCI BARs incorrectly assigned, fails to
 assign memory
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,
sorry for the late reply. It took me quite a while.
The patch you sent was probably not based off of
f6d41443f54856ceece0d5b584f47f681513bde4, because I used the
linux-stable git and there was no pci_resource_num.
I used git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
@ f6d41443f548 added the missing function from the mainline repo.

Hotplugging works now, it still crashes the gpu driver on unplugging
at runtime though, might still be related or just a driver bug.
Here is the dmesg output:
https://gist.githubusercontent.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af=
/raw/048752be295efe536c4f453938aac6e47e2429a3/patched%2520kernel

Thanks for the fix!

Best
Steve

Am Mi., 8. Okt. 2025 um 13:43 Uhr schrieb Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com>:
>
> On Wed, 3 Sep 2025, Ilpo J=C3=A4rvinen wrote:
>
> > On Mon, 1 Sep 2025, Steve Oswald wrote:
> >
> > > I've added the dmesg output fordyndbg=3D"file drivers/pci/*. I wasn't
> > > sure if I added it with the escaped quotes correctly.
> > > https://gist.github.com/stepeos/cd060c7d66ab195f51ab4d5675b4e4af/raw/=
9cf5fc3a8c4f13588a33d61865f804f85e50470a/dmesg_linux_6.11.0_dyndbg.log
> >
> > Hi again,
> >
> > I think the patch below should solve your issue. If you manage to get i=
t
> > tested and are confident enough it fixed your issue, you may provide yo=
ur
> > Tested-by tag so I can include it into the official submission of the f=
ix.
>
> Hi Steve,
>
> Did you manage to test this patch?
>
> --
>  i.
>
> >
> >
> > From 1c8ef31c6ac6616869b447a473e879b233df62db Mon Sep 17 00:00:00 2001
> > From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.i=
ntel.com>
> > Date: Wed, 3 Sep 2025 15:53:48 +0300
> > Subject: [PATCH 1/1] PCI: Prevent shrinking bridge window from its requ=
ired
> >  size
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=3DUTF-8
> > Content-Transfer-Encoding: 8bit
> >
> > pci_bridge_distribute_available_resources() -> ... ->
> > adjust_bridge_window() is called in between __pci_bus_size_bridges()
> > and assigning the resources. Since the commit 948675736a77 ("PCI: Allow
> > adjust_bridge_window() to shrink resource if necessary")
> > adjust_bridge_window() can also shrink the bridge window to force it to
> > a smaller size. The shrunken size, however, conflicts what
> > __pci_bus_size_bridges() -> pbus_size_mem() calculated as the required
> > bridge window size. By shrinking the resource size,
> > adjust_bridge_window() prevents rest of the resource fitting algorithm
> > working as intended. Resource fitting logic is expecting assignment
> > failures when bridge windows need resizing, but there are cases where
> > failures are no longer happening after the commit 948675736a77 ("PCI:
> > Allow adjust_bridge_window() to shrink resource if necessary").
> >
> > The commit 948675736a77 ("PCI: Allow adjust_bridge_window() to shrink
> > resource if necessary") justifies the change by the extra reservation
> > made due to hpmemsize parameter, however, the kernel code contradicts
> > with that statement. (For simplicity, finer-grained hpmmiosize and
> > hpmmiopref parameters that can be used to the same effect as hpmemsize
> > are ignored in this description.)
> >
> > pbus_size_mem() calls calculate_memsize() twice. First with add_size=3D=
0
> > to find out the minimal required resource size. The second call occurs
> > with add_size=3Dhpmemsize (effectively) but the result does not directl=
y
> > affect the resource size only resulting in an entry on the realloc_head
> > list (a.k.a. add_list). Yet, adjust_bridge_window() directly changes
> > the resource size which does not include what is reserved due to
> > hpmemsize. Also, if the required size for the bridge window exceeds
> > hpmemsize, the parameter does not have any effect even on the second
> > size calculcation made by pbus_size_mem(); from calculate_memsize():
> >
> >   size =3D max(size, add_size) + children_add_size;
> >
> > The commit ae4611f1d7e9 ("PCI: Set resource size directly in
> > adjust_bridge_window()") that precedes the commit 948675736a77 ("PCI:
> > Allow adjust_bridge_window() to shrink resource if necessary") is also
> > related to causing this problem. Its changelog explicitly states
> > adjust_bridge_window() wants to "guarantee" allocation success.
> > Guaranteed allocations, however, are incompatible with how the other
> > parts of the resource fitting algorithm work. The given justification
> > fails to explain why guaranteed allocations at this stage are required
> > nor why forcing window to a smaller value than what was calculated by
> > pbus_size_mem() is correct. The the change might have worked by chance
> > in some test scenario, too small bridge window does not "guarantee"
> > success from the point of view of the endpoint device resource
> > assignments. No issue is mentioned within the changelog so it's unclear
> > if the change was made to fix some observed issue nor and what that
> > issue was.
> >
> > The unwanted shrinking of a bridge window occurs, e.g., when a device
> > with large BARs such as eGPU is attached using Thunderbolt and the Root
> > Port holds less than enough resource space for the eGPU. The GPU
> > resources are in order of GBs and the default hotplug allocation is
> > mere 2M (DEFAULT_HOTPLUG_MMIO_PREF_SIZE). The problem is illustrated by
> > this log (filtered to the relevant content only):
> >
> > pci 0000:00:07.0: PCI bridge to [bus 03-2c]
> > pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bffffff 64bit =
pref]
> > pci 0000:03:00.0: PCI bridge to [bus 00]
> > pci 0000:03:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref=
]
> > pci 0000:03:00.0: bridge configuration invalid ([bus 00-00]), reconfigu=
ring
> > pci 0000:03:00.0: PCI bridge to [bus 04-2c]
> > pcieport 0000:00:07.0: Assigned bridge window [mem 0x6000000000-0x601bf=
fffff 64bit pref] to [bus 03-2c] cannot fit 0xc00000000 required for 0000:0=
3:00.0 bridging to [bus 04-2c]
> > pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit pre=
f] to [bus 04-2c] add_size 100000 add_align 100000
> > pcieport 0000:00:07.0: distributing available resources
> > pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit pre=
f] shrunken by 0x00000007e4400000
> > pci 0000:03:00.0: bridge window [mem 0x6000000000-0x601bffffff 64bit pr=
ef]: assigned
> >
> > The initial size of the Root Port's window is 448MB (0x601bffffff -
> > 0x6000000000). __pci_bus_size_bridges() -> pbus_size_mem() calculates
> > the required size to be 32772 MB (0x10003fffff - 0x800000000) which
> > would fit the eGPU resources. adjust_bridge_window() then shrinks the
> > bridge window down to what is guaranteed to fit into the Root Port's
> > bridge window. The bridge window for 03:00.0 is also eliminated from
> > the add_list (a.k.a. realloc_head) list by adjust_bridge_window().
> >
> > After adjustment, the resources are assigned and as the bridge window
> > for 03:00.0 is assigned successfully, no failure is recorded. Without a
> > failure, no attempt to resize the window of the Root Port is required.
> > The end result is eGPU not having large enough resources to work.
> >
> > The commit 948675736a77 ("PCI: Allow adjust_bridge_window() to shrink
> > resource if necessary") also claims nested bridge windows are sized the
> > same, which is false. pbus_size_mem() calculates the size for the
> > parent bridge window by summing all the downstream resources so the
> > resource fitting calculates larger bridge window for the parent to
> > accomodate the childen. That is, hpmemsize does not result the same
> > size for the case where there are nested bridge windows.
> >
> > In order to fix the most immediate problem, don't shrink the resource
> > size as hpmemsize had nothing to do with it. When considering add_size,
> > only reduce it up to what is added due to hpmemsize (if required size
> > is larger than hpmemsize, the parameter has no impact, see
> > calculate_memsize()).
> >
> > This is not exactly a revert of the commits e4611f1d7e9 ("PCI: Set
> > resource size directly in adjust_bridge_window()") and 948675736a77
> > ("PCI: Allow adjust_bridge_window() to shrink resource if necessary")
> > as shrinking still remains in place but is implemented differently,
> > and the end result behaves very differently.
> >
> > It is possible that those two commits fixed some other issue that is
> > not described with enough detail in the changelog and undoing parts of
> > them results in another regression due to behavioral change.
> > Nonetheless, as described above, the solution by those two commits was
> > flawed and the issue, if one exists, should be solved in a way that is
> > compatible with the rest of the resource fitting algorithm instead of
> > working against it.
> >
> > Besides shrinking, the case where adjust_bridge_window() expands the
> > bridge window is likely somewhat wrong as well because it removes the
> > entry from add_list (a.k.a. realloc_head), but it is less damaging as
> > that only impacts optional resources and may have no impact if
> > expanding by hpmemsize is larger than what add_size was. Fixing it is
> > left as further work.
> >
> > Reported-by: Steve Oswald <stevepeter.oswald@gmail.com>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/setup-bus.c | 42 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 40 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 23082bc0ca37..4dd618bc4196 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1828,6 +1828,7 @@ static void adjust_bridge_window(struct pci_dev *=
bridge, struct resource *res,
> >                                resource_size_t new_size)
> >  {
> >       resource_size_t add_size, size =3D resource_size(res);
> > +     struct pci_dev_resource *dev_res;
> >
> >       if (res->parent)
> >               return;
> > @@ -1840,9 +1841,46 @@ static void adjust_bridge_window(struct pci_dev =
*bridge, struct resource *res,
> >               pci_dbg(bridge, "bridge window %pR extended by %pa\n", re=
s,
> >                       &add_size);
> >       } else if (new_size < size) {
> > +             int idx =3D pci_resource_num(bridge, res);
> > +
> > +             /*
> > +              * hpio/mmio/mmioprefsize hasn't been included at all? Se=
e the
> > +              * add_size param at the callsites of calculate_memsize()=
.
> > +              */
> > +             if (!add_list)
> > +                     return;
> > +
> > +             /* Only shrink if the hotplug extra relates to window siz=
e. */
> > +             switch (idx) {
> > +                     case PCI_BRIDGE_IO_WINDOW:
> > +                             if (size > pci_hotplug_io_size)
> > +                                     return;
> > +                             break;
> > +                     case PCI_BRIDGE_MEM_WINDOW:
> > +                             if (size > pci_hotplug_mmio_size)
> > +                                     return;
> > +                             break;
> > +                     case PCI_BRIDGE_PREF_MEM_WINDOW:
> > +                             if (size > pci_hotplug_mmio_pref_size)
> > +                                     return;
> > +                             break;
> > +                     default:
> > +                             break;
> > +             }
> > +
> > +             dev_res =3D res_to_dev_res(add_list, res);
> >               add_size =3D size - new_size;
> > -             pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", re=
s,
> > -                     &add_size);
> > +             if (add_size < dev_res->add_size) {
> > +                     dev_res->add_size -=3D add_size;
> > +                     pci_dbg(bridge, "bridge window %pR optional size =
shrunken by %pa\n",
> > +                             res, &add_size);
> > +             } else {
> > +                     pci_dbg(bridge, "bridge window %pR optional size =
removed\n",
> > +                             res);
> > +                     remove_from_list(add_list, res);
> > +             }
> > +             return;
> > +
> >       } else {
> >               return;
> >       }
> >
> > base-commit: f6d41443f54856ceece0d5b584f47f681513bde4
> >

