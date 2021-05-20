Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAF438B7D5
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 21:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239933AbhETTvC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 15:51:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233763AbhETTu7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 May 2021 15:50:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2C2D611AD;
        Thu, 20 May 2021 19:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621540176;
        bh=97fLkXaRXbIzFmiUBJDONZE1n333yTBG4/J5BpES84Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pbEkkgYOYECkv0AtU0sDakfXoQC9enojNibG9QJLUF+r93fKyg9kxAjieyzx82Gs6
         e4pHF9POvLBe9sA6DUbs1gDtNX3QcJREMe7wtRw0aPSe+5HGntYGd+DKrbu68vqaFu
         GI2y1nC0wT9ucwMXK9cFQVnzuDhi5vvuAC0/ly7TU4W4ANcjnRHMdzdzf9IKNWVx3U
         iOWGWurmOVZoAXEFE+Bm96reOvhS7exkUo2zdy8yuJTIL/jgt6Ui10aGCAHCjwukmk
         Zsuv4PkFv9E9QluTTssmx+ncdmV7C3J/d8MXjz7GAofVrcqc/xyIgCFjqwJ7j0LbOX
         PBGrl0XIcoCZg==
Date:   Thu, 20 May 2021 14:49:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Konstantin Kharlamov <hi-angel@yandex.ru>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on
 s2idle
Message-ID: <20210520194935.GA348608@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hLkEDgPstGkigMztUpiDyPzgjraaqtYs=SPzg8JWgVow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 20, 2021 at 01:54:05PM +0200, Rafael J. Wysocki wrote:
> On Thu, May 20, 2021 at 1:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Wed, May 19, 2021 at 9:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, May 19, 2021 at 09:12:26PM +0200, Rafael J. Wysocki wrote:

> > > > The problem is related to the fact that in s2idle the platform
> > > > firmware does not finalize the suspend transition and, consequently,
> > > > it doesn't initiate the resume transition.  Therefore whatever power
> > > > state the device was left in during suspend must be dealt with during
> > > > the subsequent resume.  Hence, if whatever is done by SXIO/SXFP/SXLF
> > > > in the suspend path cannot be reversed in the resume path by the
> > > > kernel (because there is no known method to do that), they should not
> > > > be invoked.  And that's exactly because the platform firmware will not
> > > > finalize the suspend transition which is indicated by
> > > > PM_SUSPEND_FLAG_FW_SUSPEND being unset.
> > >
> > > How can we connect "if (!pm_suspend_via_firmware())" in this patch
> > > with the fact that firmware doesn't finalize suspend (and consequently
> > > does not reverse things in resume)?
> > >
> > > I don't see any use of pm_suspend_via_firmware() or
> > > PM_SUSPEND_FLAG_FW_SUSPEND that looks relevant.
> >
> > First of all, there is a kerneldoc comment next to
> > pm_suspend_via_firmware() which is relevant.  Especially the last
> > paragraph of that comment applies directly to the case at hand IMV.

I do read kerneldoc, but I *rely* on the code, and it's nice when I
can match up the kerneldoc with what the code is doing :)

Part of my confusion is that "passing control to platform firmware"
isn't particularly useful in itself because it doesn't give a clue
about what firmware is *doing*.  Without knowing what it does, we
can't reason about how kernel's actions interact with firmware's
actions.

> BTW, the problem at hand is not that s2idle in particular needs to be
> treated in a special way (this appears to be the source of all
> confusion here).  The problem is that the kernel cannot undo the
> SXIO/SXFP/SXLF magic without passing control to the platform firmware.

I assume this is really a case of "the kernel doesn't know *what* to
do, but platform firmware does," so in principle the kernel *could*
undo the SXIO/SXFP/SXLF magic if it knew what to do.  

> And "passing control to the platform firmware" doesn't mean "executing
> some AML" here, because control remains in the kernel when AML is
> executed.  "Passing control to the platform firmware" means letting
> some native firmware code (like SMM code) run which happens at the end
> of S2/S3/S4 suspend transitions and it does not happen during S1
> (standby) and s2idle suspend transitions.
> 
> That's why using SXIO/SXFP/SXLF is only valid during S2/S3/S4 suspend
> transitions and it is not valid during s2idle and S1 suspend
> transitions (and yes, S1 is also affected, so s2idle is not special in
> that respect at all).
> 
> IMO the changelog of the patch needs to be rewritten, but the code
> change made by it is reasonable.

So IIUC the comment should say something like:

  SXIO/SXFP/SXLF turns off power to the Thunderbolt controller.  We
  don't know how to turn it back on again, but firmware does, so we
  can only use SXIO/SXFP/SXLF if we're suspending via firmware.

Actually, it sounds like the important thing is that we rely on the
firmware *resume* path to turn on the power again.

pm_resume_via_firmware() *sounds* like it would be appropriate, but
the kerneldoc says that's for use after resume, and it tells us
whether firmware has *already* handled the wakeup event.  And
PM_SUSPEND_FLAG_FW_RESUME isn't set until after we've run these
suspend_late fixups, so it wouldn't work here.

Bjorn
