Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B79C3762F1
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 11:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbhEGJie (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 05:38:34 -0400
Received: from forward101o.mail.yandex.net ([37.140.190.181]:46726 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234536AbhEGJie (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 May 2021 05:38:34 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 May 2021 05:38:33 EDT
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id E0C7E3C01CF3;
        Fri,  7 May 2021 12:32:21 +0300 (MSK)
Received: from vla5-04352cd868be.qloud-c.yandex.net (vla5-04352cd868be.qloud-c.yandex.net [IPv6:2a02:6b8:c18:3411:0:640:435:2cd8])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id DC664CF40023;
        Fri,  7 May 2021 12:32:21 +0300 (MSK)
Received: from vla1-62318bfe5573.qloud-c.yandex.net (vla1-62318bfe5573.qloud-c.yandex.net [2a02:6b8:c0d:3819:0:640:6231:8bfe])
        by vla5-04352cd868be.qloud-c.yandex.net (mxback/Yandex) with ESMTP id c3xWZ66Tmq-WLIep920;
        Fri, 07 May 2021 12:32:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1620379941;
        bh=cK6I76Yoos3rjd1DiTpMFrQ2xKCG7ieKKp7kVmltyzU=;
        h=In-Reply-To:Cc:To:From:Subject:Message-ID:References:Date;
        b=ifU95PoP1+SXeUtbz4MCszXgGcpc8wS4pH7WWx3DRRlOloffQgl+DP4cPbCdK2RyL
         PmewvT1vFDLvoMnlI3N368cgY5OTPDZx0sTeZNS2/ynm8z/UyNnBjwXQ47q24Ae+M9
         BBhOs42udbmhaduiHNO+UOzgneUjASqjGkvXec7I=
Authentication-Results: vla5-04352cd868be.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-62318bfe5573.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id ZzQpaJLAY4-WLLGC7X4;
        Fri, 07 May 2021 12:32:21 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <eb09cf4f31ea2833b6f6cdc309f256f7ad105b26.camel@yandex.ru>
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on
 s2idle
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pm@vger.kernel.org
Date:   Fri, 07 May 2021 12:32:20 +0300
In-Reply-To: <20210506214842.GA1436993@bjorn-Precision-5520>
References: <20210506214842.GA1436993@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2021-05-06 at 16:48 -0500, Bjorn Helgaas wrote:
> [+cc Rafael, Andreas, linux-pm]
> 
> On Thu, May 06, 2021 at 08:38:20PM +0300, Konstantin Kharlamov wrote:
> > On Macbook 2013 resuming from s2idle results in external monitor no
> > longer being detected, and dmesg having errors like:
> > 
> >     pcieport 0000:06:00.0: can't change power state from D3hot to D0 (config
> > space inaccessible)
> > 
> > and a stacktrace. The reason turned out that the hw that the quirk
> > powers off does not get powered on back on resume.
> 
> quirk_apple_poweroff_thunderbolt() was added in 2014 by 1df5172c5c25
> ("PCI: Suspend/resume quirks for Apple thunderbolt").  It claims
> "power is automatically restored before resume," so there must be
> something special about s2idle that prevents the power-on.
> 
> IIUC this change will reduce the s2idle power savings.  I would feel
> better about this if we understood what the difference was.  
> 
> > Thus, add a check for s2idle to the quirk, and do nothing if the suspend
> > mode is s2idle.
> 
> Obviously the *hardware* hasn't changed since 1df5172c5c25.  Is s2idle
> something that wasn't tested back then, or is this problem connected
> to an s2idle change since then?  Can we identify a commit that
> introduced this problem?  That would help with backporting or stable
> tags.
> 
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212767
> 
> Thanks for this!  Would you mind attaching the output of
> "sudo lspci -vvv"?  If you attach any other dmesg, could you
> use "dmesg --color=never" so the log doesn't include all the
> escape characters?

Thank you! So, just to be clear: in lieu of Lukas Wunner's reply, do you still want `lspci` and `dmesg` outputs, or are you okay with the information Lukas provided?

And while on it, an unrelated question to you as a maintainer: I never contributed to the kernel before: in case you are okay with the patch, what happens now that I got R-b, should I resend a v2 of it with the R-b added?

