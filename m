Return-Path: <linux-pci+bounces-4452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5446487075D
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 17:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7811F25CA7
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9034CB46;
	Mon,  4 Mar 2024 16:41:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CAF495E0;
	Mon,  4 Mar 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570494; cv=none; b=p+86ia2yg/R+sGRkAC6JrvxLfl2qVLX6J03kXsOJkL/qPAhJTguUrQW8QBWjhveJbsTioBqnP1uOAtRS9PeuE3cJ0b6R2cnra2NSzhVP2q9wcVr6VA7RzRMaIhD+glLdjGmQycZQ+Prpx5N3JcFFtRK+W+6vyAgBkjCgnbwMpE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570494; c=relaxed/simple;
	bh=WF5yncz6g/9Mh8GpF3BGz7UNGN6nzwG3LAT4Qy6Xaio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4PYu+Unrg6kJj36ZdSpzii4V3I4TTedqaQ2iTDa7Fj36zvY6eleD8oaE4mMXfG9OTcodPqGdWHyfYGjxq0sC5Iwau23y3V6lkS+OA7it/YtqIoAuqBgJwBzl27hhi/j5Ux9mj+wPu53x02rDzh3Ds+ts8+/bmD7hmx+zSRneZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e4ea48972cso349898a34.0;
        Mon, 04 Mar 2024 08:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709570491; x=1710175291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFEvVmR8mpln9PL6OoXoC/Ne2hrqBirmQBmOubPamhM=;
        b=YA2de6ZSTvZXCNhn95podiput1z9VfVru6dewyXCjJJTKfQMfAECOTUeINzhZTt4U1
         5FP/J9ZQ6UQxKCyy/NDcsnAIILkGFYNkilpd1OciNrnKgdc7z0e2TJUaTByFR2NiNguJ
         PnKmOTAg3E9f46JNTV+q8Y65uYxWfhHY0uQ94YoUtPL9yZ/CtG/PZJU61mIxRzkiIcIQ
         mAk4Tf1OEABYnyL9PoP908SBtrIMPJF/OdgqFC2n19YpbM487BXFIje7Up3SF5RCgZc7
         qGAg+Wg4ISceHR1gnotO0g2NutmYiVC/ChjZGLqWlYhUyrFqgAz/2OGxYq935j9ZwdUe
         +KUw==
X-Forwarded-Encrypted: i=1; AJvYcCXReyYU0ENnsYG6Q7gGsk9sQ07/chZauazrMiqemJ97CKYvEQMyB15lMJyKnCoYqN59Le8nNgpI1ASaP4V8bBZRHJGfIW6Cz1rqiPRMZU2NJF6uJE8Iccsh3hXQhaTJBSMxQAbVUQTixUuXbW3a2zkErBsivgzVSxR58FVNDZ7T6jTs2U7n87PMky6ciq7tJjfdvtiv41XQuvrLJF/8
X-Gm-Message-State: AOJu0YwNeLDlRKHDo6L4jb4j2x1F3eu31zUv2msx3XTpG0TbDxq0V8Bm
	Eqq3tbuQ9pMH7LarXVYeCCI+jBUtvVfrtyP9rP4PoXWQROwa3FyoXCs2Yynaw9CcsFjcByzzXQC
	wvWYYSKFdrGnwWw2ogbWVz56sp+k=
X-Google-Smtp-Source: AGHT+IFOLTCVRY6mWwBXwQ8bn84DuU3MLvfAPphMkKwDWG2kShUWWEC/Gh+iRLlPQgqLOSE+Q2+c67uENaJegwa9oW4=
X-Received: by 2002:a05:6870:c69d:b0:220:bd4d:674d with SMTP id
 cv29-20020a056870c69d00b00220bd4d674dmr10062324oab.5.1709570491549; Mon, 04
 Mar 2024 08:41:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0grDNJkEcgw+34SBmNFL7qhSTz8ydC7BSkM7DiCatkKSA@mail.gmail.com>
 <20240304155138.GA482969@bhelgaas>
In-Reply-To: <20240304155138.GA482969@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Mar 2024 17:41:19 +0100
Message-ID: <CAJZ5v0jS_x7=joXkHuuqQhO-FqkhGi44o-Nq-1FGhPQ5-1VhnQ@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Cancel scheduled pm_runtime_idle() on
 device removal
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	gregkh@linuxfoundation.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ricky Wu <ricky_wu@realtek.com>, 
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 4:51=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Mon, Mar 04, 2024 at 03:38:38PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Feb 29, 2024 at 7:23=E2=80=AFAM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > When inserting an SD7.0 card to Realtek card reader, the card reader
> > > unplugs itself and morph into a NVMe device. The slot Link down on ho=
t
> > > unplugged can cause the following error:
> > >
> > > pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> > > BUG: unable to handle page fault for address: ffffb24d403e5010
> > > PGD 100000067 P4D 100000067 PUD 1001fe067 PMD 100d97067 PTE 0
> > > Oops: 0000 [#1] PREEMPT SMP PTI
> > > CPU: 3 PID: 534 Comm: kworker/3:10 Not tainted 6.4.0 #6
> > > Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./H370M Pr=
o4, BIOS P3.40 10/25/2018
> > > Workqueue: pm pm_runtime_work
> > > RIP: 0010:ioread32+0x2e/0x70
> > ...
> > > Call Trace:
> > >  <TASK>
> > >  ? show_regs+0x68/0x70
> > >  ? __die_body+0x20/0x70
> > >  ? __die+0x2b/0x40
> > >  ? page_fault_oops+0x160/0x480
> > >  ? search_bpf_extables+0x63/0x90
> > >  ? ioread32+0x2e/0x70
> > >  ? search_exception_tables+0x5f/0x70
> > >  ? kernelmode_fixup_or_oops+0xa2/0x120
> > >  ? __bad_area_nosemaphore+0x179/0x230
> > >  ? bad_area_nosemaphore+0x16/0x20
> > >  ? do_kern_addr_fault+0x8b/0xa0
> > >  ? exc_page_fault+0xe5/0x180
> > >  ? asm_exc_page_fault+0x27/0x30
> > >  ? ioread32+0x2e/0x70
> > >  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
> > >  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
> > >  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
> > >  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
> > >  ? __pfx_pci_pm_runtime_idle+0x10/0x10
> > >  pci_pm_runtime_idle+0x34/0x70
> > >  rpm_idle+0xc4/0x2b0
> > >  pm_runtime_work+0x93/0xc0
> > >  process_one_work+0x21a/0x430
> > >  worker_thread+0x4a/0x3c0
> > ...
>
> > > This happens because scheduled pm_runtime_idle() is not cancelled.
> >
> > But rpm_resume() changes dev->power.request to RPM_REQ_NONE and if
> > pm_runtime_work() sees this, it will not run rpm_idle().
> >
> > However, rpm_resume() doesn't deactivate the autosuspend timer if it
> > is running (see the comment in rpm_resume() regarding this), so it may
> > queue up a runtime PM work later.
> >
> > If this is not desirable, you need to stop the autosuspend timer
> > explicitly in addition to calling pm_runtime_get_sync().
>
> I don't quite follow all this.  I think the race is between
> rtsx_pci_remove() (not resume) and rtsx_pci_runtime_idle().

I think so too and the latter is not expected to run.

>   rtsx_pci_remove()
>   {
>     pm_runtime_get_sync()
>     pm_runtime_forbid()
>     ...
>
> If this is an rtsx bug, what exactly should be added to
> rtsx_pci_remove()?
>
> Is there ever a case where we want any runtime PM work to happen
> during or after a driver .remove()?  If not, maybe the driver core
> should prevent that, which I think is basically what this patch does.

No, it is not, because it doesn't actually prevent the race from
occurring, it just narrows the window quite a bit.

It would be better to call pm_runtime_dont_use_autosuspend() instead
of pm_runtime_barrier().

> If this is an rtsx driver bug, I'm concerned there may be many other
> drivers with a similar issue.  rtsx exercises this path more than most
> because the device switches between card reader and NVMe SSD using
> hotplug add/remove based on whether an SD card is inserted (see [1]).

This is a valid concern, so it is mostly a matter of where to disable
autosuspend.

It may be the driver core in principle, but note that it calls
->remove() after invoking pm_runtime_put_sync(), so why would it
disable autosuspend when it allows runtime PM to race with device
removal in general?

Another way might be to add a pm_runtime_dont_use_autosuspend() call
at the beginning of pci_device_remove().

Or just remove the optimization in question from rpm_resume() which is
quite confusing and causes people to make assumptions that lead to
incorrect behavior in this particular case.

So this (modulo GMail-induced whitespace breakage):

---
 drivers/base/power/runtime.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -782,15 +782,8 @@ static int rpm_resume(struct device *dev
     if (retval)
         goto out;

-    /*
-     * Other scheduled or pending requests need to be canceled.  Small
-     * optimization: If an autosuspend timer is running, leave it running
-     * rather than cancelling it now only to restart it again in the near
-     * future.
-     */
     dev->power.request =3D RPM_REQ_NONE;
-    if (!dev->power.timer_autosuspends)
-        pm_runtime_deactivate_timer(dev);
+    pm_runtime_deactivate_timer(dev);

     if (dev->power.runtime_status =3D=3D RPM_ACTIVE) {
         retval =3D 1;

