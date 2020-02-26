Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D416B16F748
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 06:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgBZFb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 00:31:29 -0500
Received: from mail.overt.org ([157.230.92.47]:35773 "EHLO mail.overt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgBZFb3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Feb 2020 00:31:29 -0500
X-Greylist: delayed 629 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Feb 2020 00:31:29 EST
Received: from authenticated-user (mail.overt.org [157.230.92.47])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.overt.org (Postfix) with ESMTPSA id D93143F238;
        Tue, 25 Feb 2020 23:20:57 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=overt.org; s=mail;
        t=1582694459; bh=C+e4OY6fqGpnhwj+M3QG7h7Pf1ust5yrvgiTKuv00PU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oDyZJcbcIXMAl7hujRYzIBL4H6q0qjXBNlWMtFPBgoL+iz0DUd6w+AyZQydyFkLVX
         KH/3myFgK+rukTN1Ouf70dt6iBFOfbz3NkrXM2tQaT1QUKatcJ0Oy47cYyVsXdG1lc
         D3q01JpRSD6BsaFbmKjSKNZVRMbdJaBdEcS9auNLQPDC71mzTHAuhsRHReicBi2dzx
         DZ1KAGe8Wcm2W5j7XiLJUE4N0a+LYUsqSTXh+scQhQ8ipVabCo6+TgoXxG+FeMEiX/
         jsO2WKStydNbFOysvUlRExvhmSWjK9DZEb4XYpKDG7sv5psP0bBOtQ/GHEIuc2ayx6
         8oDGiHfD5JkgA==
Date:   Tue, 25 Feb 2020 21:20:54 -0800
From:   Philip Langdale <philipl@overt.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Trevor Jacobs <trevor_jacobs@aol.com>,
        "Michael ." <keltoiboy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>,
        Morgan Klym <moklym@gmail.com>,
        Pierre Ossman <pierre@ossman.eu>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not
 working on Panasonic Toughbook CF-29]
Message-ID: <20200225212054.09865e0b@fido6>
In-Reply-To: <20200226045104.GA2191053@rani.riverdale.lan>
References: <20191029170250.GA43972@google.com>
        <20200222165617.GA207731@google.com>
        <CAPDyKFq_exHufHyibFCjS78PTZ7duS9ZSt3vi18CNM6+jMmwnw@mail.gmail.com>
        <20200226011310.GA2116625@rani.riverdale.lan>
        <CAFjuqNg_NW7hcssWmMTtt=ioY143qn76ooT7GRhxEEe9ZVCqeQ@mail.gmail.com>
        <6e9db1f6-60c4-872b-c7c8-96ee411aa3ca@aol.com>
        <20200226045104.GA2191053@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Feb 2020 23:51:05 -0500
Arvind Sankar <nivedita@alum.mit.edu> wrote:

> On Tue, Feb 25, 2020 at 09:12:48PM -0600, Trevor Jacobs wrote:
> > That's correct, I tested a bunch of the old distros including
> > slackware, and 2.6.32 is where the problem began.
> > 
> > Also, the Panasonic Toughbook CF-29s effected that we tested are
> > the later marks, MK4 and MK5 for certain. The MK2 CF-29 worked just
> > fine because it has different hardware supporting the PCMCIA slots.
> > I have not tested a MK3 but suspect it would work ok as it also
> > uses the older hardware.
> > 
> > Thanks for your help guys!
> > Trevor
> > 
> 
> Right, the distros probably all enabled MMC_RICOH_MMC earlier than
> upstream. Can you test a custom kernel based off your distro kernel
> but just disabling that config option? That's probably the easiest fix
> currently, even though not ideal. Perhaps there should be a command
> line option to disable specific pci quirks to make this easier.
> 
> An ideal fix is I feel hard, given this quirk is based on undocumented
> config registers -- it worked on Dell machines (that's where the
> original authors seem to have gotten their info from), perhaps they
> had only one Cardbus slot, but the code ends up disabling your second
> Cardbus slot instead of disabling the MMC controller.

Keeping in mind that this was 12+ years ago, you can at least still
read the original discussion in the archives. My original Dell laptop
(XPS m1330) had no cardbus slots at all, and used the r5c832
controller. There was a subsequent change that I was not involved with
which added support for the rl5c476, which is the problematic device in
this thread.

As a hypothesis, based on the observed behaviour, the quirk (keeping in
mind that these are magic configuration register values that are not
documented) probably disabled function 1, regardless of what it is, and
the original example that motivated adding the rl5c476 quirk probably
had one cardbus slot and the card reader functions were all moved up
one, or something along those lines.

Truly making this smart would then involve having the code enumerate
the pci functions and identify the one that is the unwanted mmc
controller, based on function ID or class or whatever, and then
disabling that (assuming the magic can be reverse engineered: eg, the
current magic ORs the disable flag with 0x02 - chances are, that's the
index of the function: 0x01 would be the 0th function, 0x04 would be
the 2nd function, etc). Someone with access to real hardware could
easily experiment with changing that magic value and seeing if it
changes which function is disabled.

Good luck.

--phil
