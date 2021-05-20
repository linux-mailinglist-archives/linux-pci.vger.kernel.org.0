Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54ED38BA63
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 01:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhETX35 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 19:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhETX34 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 19:29:56 -0400
Received: from forward100j.mail.yandex.net (forward100j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625DFC061574;
        Thu, 20 May 2021 16:28:33 -0700 (PDT)
Received: from iva6-26d3dbc69e48.qloud-c.yandex.net (iva6-26d3dbc69e48.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:912f:0:640:26d3:dbc6])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id D621F50E1B88;
        Fri, 21 May 2021 02:28:29 +0300 (MSK)
Received: from iva8-174eb672ffa9.qloud-c.yandex.net (iva8-174eb672ffa9.qloud-c.yandex.net [2a02:6b8:c0c:b995:0:640:174e:b672])
        by iva6-26d3dbc69e48.qloud-c.yandex.net (mxback/Yandex) with ESMTP id ImeQqByjNU-STJ4wFYl;
        Fri, 21 May 2021 02:28:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1621553309;
        bh=WrHAGz3ro9Ohp4J6cItIIGrnoXuDOvp2fj40gFEhLsA=;
        h=In-Reply-To:Cc:To:From:Subject:Message-ID:References:Date;
        b=jtqJbmT+XyAz1z8YIkYUeJy5exYZjF35as1lVHGKAkfSNGLEXZyD9LBe8A3CI/W6E
         iPVzVYFtsZN8SHm+lkWMiwUqPatPp2K+wVcrgNvEZ5tDfBSxRdJTOQIw91EuyhDdQy
         G4cMk0bUkK7lM7/seaCc+bN7wxDcz6e3oWKufUFA=
Authentication-Results: iva6-26d3dbc69e48.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva8-174eb672ffa9.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id TlB44JqxL1-SSLefwCw;
        Fri, 21 May 2021 02:28:29 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <15121b9c3ad1683f0d81ebd44ace60509a9a9e82.camel@yandex.ru>
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
Date:   Fri, 21 May 2021 02:28:28 +0300
In-Reply-To: <20210520194935.GA348608@bjorn-Precision-5520>
References: <20210520194935.GA348608@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thank you very much. Well send then a v2 with the comment in a minute.

On Thu, 2021-05-20 at 14:49 -0500, Bjorn Helgaas wrote:
> On Thu, May 20, 2021 at 01:54:05PM +0200, Rafael J. Wysocki wrote:
> > On Thu, May 20, 2021 at 1:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Wed, May 19, 2021 at 9:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Wed, May 19, 2021 at 09:12:26PM +0200, Rafael J. Wysocki wrote:
> 
> > > > > The problem is related to the fact that in s2idle the platform
> > > > > firmware does not finalize the suspend transition and, consequently,
> > > > > it doesn't initiate the resume transition.  Therefore whatever power
> > > > > state the device was left in during suspend must be dealt with during
> > > > > the subsequent resume.  Hence, if whatever is done by SXIO/SXFP/SXLF
> > > > > in the suspend path cannot be reversed in the resume path by the
> > > > > kernel (because there is no known method to do that), they should not
> > > > > be invoked.  And that's exactly because the platform firmware will not
> > > > > finalize the suspend transition which is indicated by
> > > > > PM_SUSPEND_FLAG_FW_SUSPEND being unset.
> > > > 
> > > > How can we connect "if (!pm_suspend_via_firmware())" in this patch
> > > > with the fact that firmware doesn't finalize suspend (and consequently
> > > > does not reverse things in resume)?
> > > > 
> > > > I don't see any use of pm_suspend_via_firmware() or
> > > > PM_SUSPEND_FLAG_FW_SUSPEND that looks relevant.
> > > 
> > > First of all, there is a kerneldoc comment next to
> > > pm_suspend_via_firmware() which is relevant.  Especially the last
> > > paragraph of that comment applies directly to the case at hand IMV.
> 
> I do read kerneldoc, but I *rely* on the code, and it's nice when I
> can match up the kerneldoc with what the code is doing :)
> 
> Part of my confusion is that "passing control to platform firmware"
> isn't particularly useful in itself because it doesn't give a clue
> about what firmware is *doing*.  Without knowing what it does, we
> can't reason about how kernel's actions interact with firmware's
> actions.
> 
> > BTW, the problem at hand is not that s2idle in particular needs to be
> > treated in a special way (this appears to be the source of all
> > confusion here).  The problem is that the kernel cannot undo the
> > SXIO/SXFP/SXLF magic without passing control to the platform firmware.
> 
> I assume this is really a case of "the kernel doesn't know *what* to
> do, but platform firmware does," so in principle the kernel *could*
> undo the SXIO/SXFP/SXLF magic if it knew what to do.  
> 
> > And "passing control to the platform firmware" doesn't mean "executing
> > some AML" here, because control remains in the kernel when AML is
> > executed.  "Passing control to the platform firmware" means letting
> > some native firmware code (like SMM code) run which happens at the end
> > of S2/S3/S4 suspend transitions and it does not happen during S1
> > (standby) and s2idle suspend transitions.
> > 
> > That's why using SXIO/SXFP/SXLF is only valid during S2/S3/S4 suspend
> > transitions and it is not valid during s2idle and S1 suspend
> > transitions (and yes, S1 is also affected, so s2idle is not special in
> > that respect at all).
> > 
> > IMO the changelog of the patch needs to be rewritten, but the code
> > change made by it is reasonable.
> 
> So IIUC the comment should say something like:
> 
>   SXIO/SXFP/SXLF turns off power to the Thunderbolt controller.  We
>   don't know how to turn it back on again, but firmware does, so we
>   can only use SXIO/SXFP/SXLF if we're suspending via firmware.
> 
> Actually, it sounds like the important thing is that we rely on the
> firmware *resume* path to turn on the power again.
> 
> pm_resume_via_firmware() *sounds* like it would be appropriate, but
> the kerneldoc says that's for use after resume, and it tells us
> whether firmware has *already* handled the wakeup event.  And
> PM_SUSPEND_FLAG_FW_RESUME isn't set until after we've run these
> suspend_late fixups, so it wouldn't work here.
> 
> Bjorn


