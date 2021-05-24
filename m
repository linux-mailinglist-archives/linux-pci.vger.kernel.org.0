Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D1838E141
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 08:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhEXHAh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 03:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhEXHAg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 03:00:36 -0400
Received: from forward103j.mail.yandex.net (forward103j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92204C061574;
        Sun, 23 May 2021 23:59:08 -0700 (PDT)
Received: from forward100q.mail.yandex.net (forward100q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb97])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 247B6674176D;
        Mon, 24 May 2021 09:59:05 +0300 (MSK)
Received: from vla5-fcb6daabdc9a.qloud-c.yandex.net (vla5-fcb6daabdc9a.qloud-c.yandex.net [IPv6:2a02:6b8:c18:3521:0:640:fcb6:daab])
        by forward100q.mail.yandex.net (Yandex) with ESMTP id 1EBD3708000A;
        Mon, 24 May 2021 09:59:05 +0300 (MSK)
Received: from vla5-3832771863b8.qloud-c.yandex.net (vla5-3832771863b8.qloud-c.yandex.net [2a02:6b8:c18:3417:0:640:3832:7718])
        by vla5-fcb6daabdc9a.qloud-c.yandex.net (mxback/Yandex) with ESMTP id mVoIHMI1XR-x4JCIHHC;
        Mon, 24 May 2021 09:59:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1621839545;
        bh=GeX7MbASwVmRQF/6cg6/8VzJI+hPsGVhRXfV3rlutDc=;
        h=In-Reply-To:Cc:To:From:Subject:Message-ID:References:Date;
        b=MPSZ4arVgGZA+Fijh+uSq+PcjVZCXRgGZ61BRSmK8Z0Li9Y9nZ/igXf0nAOR3nufS
         SKQF6HaGSp5BoAQWQOp/LlufyJSVQDoHuKXV7y1L6txYcuOgA60iRY89VdzFJhSq+Y
         pdVFECZE22MWjiKcUP//sAVLO7W7XuH3JCr5Nl74=
Authentication-Results: vla5-fcb6daabdc9a.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla5-3832771863b8.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id tXTFGdnQFQ-x4Lqr9mf;
        Mon, 24 May 2021 09:59:04 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <0ea9febfe707c1bdb7bdac1d918209afb7d2c8a8.camel@yandex.ru>
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on
 s2idle
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Mon, 24 May 2021 09:59:03 +0300
In-Reply-To: <15121b9c3ad1683f0d81ebd44ace60509a9a9e82.camel@yandex.ru>
References: <20210520194935.GA348608@bjorn-Precision-5520>
         <15121b9c3ad1683f0d81ebd44ace60509a9a9e82.camel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

FTR, the patch is on `linux-pci` with all the CCs except `linux-pm`. I changed
the title a bit based on the discussions here, it is:

	[PATCH v2] PCI: don't call firmware hooks on suspend unless it's fw-
controlled

On Fri, 2021-05-21 at 02:28 +0300, Konstantin Kharlamov wrote:
> Thank you very much. Well send then a v2 with the comment in a minute.
> 
> On Thu, 2021-05-20 at 14:49 -0500, Bjorn Helgaas wrote:
> > On Thu, May 20, 2021 at 01:54:05PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, May 20, 2021 at 1:27 PM Rafael J. Wysocki <rafael@kernel.org>
> > > wrote:
> > > > On Wed, May 19, 2021 at 9:48 PM Bjorn Helgaas <helgaas@kernel.org>
> > > > wrote:
> > > > > On Wed, May 19, 2021 at 09:12:26PM +0200, Rafael J. Wysocki wrote:
> > 
> > > > > > The problem is related to the fact that in s2idle the platform
> > > > > > firmware does not finalize the suspend transition and, consequently,
> > > > > > it doesn't initiate the resume transition.  Therefore whatever power
> > > > > > state the device was left in during suspend must be dealt with
> > > > > > during
> > > > > > the subsequent resume.  Hence, if whatever is done by SXIO/SXFP/SXLF
> > > > > > in the suspend path cannot be reversed in the resume path by the
> > > > > > kernel (because there is no known method to do that), they should
> > > > > > not
> > > > > > be invoked.  And that's exactly because the platform firmware will
> > > > > > not
> > > > > > finalize the suspend transition which is indicated by
> > > > > > PM_SUSPEND_FLAG_FW_SUSPEND being unset.
> > > > > 
> > > > > How can we connect "if (!pm_suspend_via_firmware())" in this patch
> > > > > with the fact that firmware doesn't finalize suspend (and consequently
> > > > > does not reverse things in resume)?
> > > > > 
> > > > > I don't see any use of pm_suspend_via_firmware() or
> > > > > PM_SUSPEND_FLAG_FW_SUSPEND that looks relevant.
> > > > 
> > > > First of all, there is a kerneldoc comment next to
> > > > pm_suspend_via_firmware() which is relevant.  Especially the last
> > > > paragraph of that comment applies directly to the case at hand IMV.
> > 
> > I do read kerneldoc, but I *rely* on the code, and it's nice when I
> > can match up the kerneldoc with what the code is doing :)
> > 
> > Part of my confusion is that "passing control to platform firmware"
> > isn't particularly useful in itself because it doesn't give a clue
> > about what firmware is *doing*.  Without knowing what it does, we
> > can't reason about how kernel's actions interact with firmware's
> > actions.
> > 
> > > BTW, the problem at hand is not that s2idle in particular needs to be
> > > treated in a special way (this appears to be the source of all
> > > confusion here).  The problem is that the kernel cannot undo the
> > > SXIO/SXFP/SXLF magic without passing control to the platform firmware.
> > 
> > I assume this is really a case of "the kernel doesn't know *what* to
> > do, but platform firmware does," so in principle the kernel *could*
> > undo the SXIO/SXFP/SXLF magic if it knew what to do.  
> > 
> > > And "passing control to the platform firmware" doesn't mean "executing
> > > some AML" here, because control remains in the kernel when AML is
> > > executed.  "Passing control to the platform firmware" means letting
> > > some native firmware code (like SMM code) run which happens at the end
> > > of S2/S3/S4 suspend transitions and it does not happen during S1
> > > (standby) and s2idle suspend transitions.
> > > 
> > > That's why using SXIO/SXFP/SXLF is only valid during S2/S3/S4 suspend
> > > transitions and it is not valid during s2idle and S1 suspend
> > > transitions (and yes, S1 is also affected, so s2idle is not special in
> > > that respect at all).
> > > 
> > > IMO the changelog of the patch needs to be rewritten, but the code
> > > change made by it is reasonable.
> > 
> > So IIUC the comment should say something like:
> > 
> >   SXIO/SXFP/SXLF turns off power to the Thunderbolt controller.  We
> >   don't know how to turn it back on again, but firmware does, so we
> >   can only use SXIO/SXFP/SXLF if we're suspending via firmware.
> > 
> > Actually, it sounds like the important thing is that we rely on the
> > firmware *resume* path to turn on the power again.
> > 
> > pm_resume_via_firmware() *sounds* like it would be appropriate, but
> > the kerneldoc says that's for use after resume, and it tells us
> > whether firmware has *already* handled the wakeup event.  And
> > PM_SUSPEND_FLAG_FW_RESUME isn't set until after we've run these
> > suspend_late fixups, so it wouldn't work here.
> > 
> > Bjorn
> 
> 


