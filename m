Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC2B3765C1
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 15:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhEGNI0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 09:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232140AbhEGNIZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 09:08:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A140B61354;
        Fri,  7 May 2021 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620392846;
        bh=cfmQ82mbu7g8SnBzjSfHSuqMwfninIbCyY6KTIlwpwc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Z7/YjErVbgOV4Qkg+bWN8hambevnKAkm0efYBwJQtHpTFARTu9WrNanDUcorcgWF6
         8CH81qsxHqcehkyuntA7F471pYbjdOHMpMHDxK9lT11gU1xs63rzfX3wvja87RpyVy
         FSceV4019USbKLRuWhLt8a7jVHslVisiYAr0Vu0OL17eiTdeLz1eCRkwWDOK7ck6am
         eosXO0QDg6ZaGxbRfq8eCjzIsuzmlrSRfvshpY8lckK5Ye3I2ce6EZ6YE/Rse+IiUE
         1GOjoAR77aVaEzU7Szw8asnDpwWNYZmcq5gVOlaDuLzAws3Q4xfzlyi66hOdM9WyrL
         WFIMXylu4lPIQ==
Date:   Fri, 7 May 2021 08:07:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pm@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on
 s2idle
Message-ID: <20210507130724.GA1499364@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb09cf4f31ea2833b6f6cdc309f256f7ad105b26.camel@yandex.ru>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas]

On Fri, May 07, 2021 at 12:32:20PM +0300, Konstantin Kharlamov wrote:
> On Thu, 2021-05-06 at 16:48 -0500, Bjorn Helgaas wrote:
> > [+cc Rafael, Andreas, linux-pm]
> > 
> > On Thu, May 06, 2021 at 08:38:20PM +0300, Konstantin Kharlamov wrote:
> > > On Macbook 2013 resuming from s2idle results in external monitor no
> > > longer being detected, and dmesg having errors like:
> > > 
> > >     pcieport 0000:06:00.0: can't change power state from D3hot to D0 (config
> > > space inaccessible)
> > > 
> > > and a stacktrace. The reason turned out that the hw that the quirk
> > > powers off does not get powered on back on resume.
> > 
> > quirk_apple_poweroff_thunderbolt() was added in 2014 by 1df5172c5c25
> > ("PCI: Suspend/resume quirks for Apple thunderbolt").  It claims
> > "power is automatically restored before resume," so there must be
> > something special about s2idle that prevents the power-on.
> > 
> > IIUC this change will reduce the s2idle power savings.  I would feel
> > better about this if we understood what the difference was.  
> > 
> > > Thus, add a check for s2idle to the quirk, and do nothing if the suspend
> > > mode is s2idle.
> > 
> > Obviously the *hardware* hasn't changed since 1df5172c5c25.  Is s2idle
> > something that wasn't tested back then, or is this problem connected
> > to an s2idle change since then?  Can we identify a commit that
> > introduced this problem?  That would help with backporting or stable
> > tags.
> > 
> > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212767
> > 
> > Thanks for this!  Would you mind attaching the output of
> > "sudo lspci -vvv"?  If you attach any other dmesg, could you
> > use "dmesg --color=never" so the log doesn't include all the
> > escape characters?
> 
> Thank you! So, just to be clear: in lieu of Lukas Wunner's reply, do
> you still want `lspci` and `dmesg` outputs, or are you okay with the
> information Lukas provided?

Yes, please attach at least lspci output.  It helps understand the
topology and may be useful in the future.  I wish we had a similar
bugzilla with more information about the original 1df5172c5c25.

> And while on it, an unrelated question to you as a maintainer: I
> never contributed to the kernel before: in case you are okay with
> the patch, what happens now that I got R-b, should I resend a v2 of
> it with the R-b added?

You don't need to resend a patch if the only change is to add
reviewed-by, acked-by, or similar tags.

Bjorn
