Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 097369DF05
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 09:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfH0HsX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 03:48:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45078 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbfH0HsW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 03:48:22 -0400
Received: by mail-oi1-f194.google.com with SMTP id v12so14227049oic.12;
        Tue, 27 Aug 2019 00:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+LbTXEs9PDwLsW5XmuMwFaB6hwKHAJtFwpTGxDpO3I=;
        b=Tn2dUSni7oYLo3pEl6fqA/SUWxVB1SsUAytiCRBrDz81r8xxRSgHfHkM19wIFZFCzY
         R1+NnL1D6tMbc0pg6g6irh9bCGIqvEuiQmc2Vki2ywWVJejxVn5FoqNndHh3iJB8UcH2
         r4myvG6nmTMi5LFhtiHcqz+G09GIviBiUxLDf5H+a2KlixozK27anU2T8d2P4G8MAve8
         1405lDlrTlOVr+L4nbReY/E51zsxbhOTDbP6KI9UHYFbwMKEjb+wFWJ0t9xL28SE8Oer
         s/xhTIWACsNn8wmrjPrM70COG1o2ewKwOYJ07Cz3KETOl1pLzW53eCgxCl8Gg9DcdeTh
         jjtw==
X-Gm-Message-State: APjAAAVfUl+hxeQLOQHtR0XrxfJwXpmdm+KdVI3z+8W9F3uFZWvHQ5Uk
        HJ5LCIkyWBNU9h/LuV4HZN2dtHCWpM+wpvsrK5s=
X-Google-Smtp-Source: APXvYqxaPjgZ655xBHFKruX61PjPaV+V5O0gw/iaUqA2YuETpt+PLdj43KoTeo42jqLv2QjTbfxKrFY/hcRRWKKYx5U=
X-Received: by 2002:aca:4dd8:: with SMTP id a207mr14518973oib.115.1566892100701;
 Tue, 27 Aug 2019 00:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp47Vh69gQjROYG69=waJgL7hs1PwnLonL9+27S_TcRhixA@mail.gmail.com>
 <CAJZ5v0g4T_0VD_oYMF_BF1VM-d1bg-BD8h8=STDrhVBgouPOPg@mail.gmail.com>
 <01cf6be6-9175-87ca-f3ad-78c06b666893@linux.intel.com> <CAD8Lp4658-c=7KabiJ=xuNRCqPwF4BJauMHqh_8WSBfCFHWSSg@mail.gmail.com>
In-Reply-To: <CAD8Lp4658-c=7KabiJ=xuNRCqPwF4BJauMHqh_8WSBfCFHWSSg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Aug 2019 09:48:09 +0200
Message-ID: <CAJZ5v0gouaztf7tcKXBr90gjrVjOvqH70regD=o2r_d+9Bwvqg@mail.gmail.com>
Subject: Re: Ryzen7 3700U xhci fails on resume from sleep
To:     Daniel Drake <drake@endlessm.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 27, 2019 at 4:50 AM Daniel Drake <drake@endlessm.com> wrote:
>
> On Mon, Aug 26, 2019 at 9:32 PM Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
> > On 26.8.2019 12.29, Rafael J. Wysocki wrote:
> > > I wonder if you can reproduce this with the pm-s2idle-rework branch
> > > from linux-pm.git merged in.
> >
> > Root cause looks similar to:
> > https://bugzilla.kernel.org/show_bug.cgi?id=203885
> >
> > Mika wrote a fix for that:
> > https://lore.kernel.org/linux-pci/20190821124519.71594-1-mika.westerberg@linux.intel.com/
>
> Thanks for the suggestions. Mika's patch was already applied then
> reverted, I applied it again but there's no change.
> Also merging in pm-s2idle-rework doesn't make any difference.
>
> Any other ideas? Or comments on my findings so far?
> Given that I can't shift D0-D3-D0 reliably directly with setpci before
> loading the driver, is that indicative of a fundamental problem with
> the platform, or is my test invalid?

That depends on what exactly happens when you try to do the D0-D3-D0
with setpci.  If the device becomes unreachable (or worse) after that,
it indicates a platform issue.  It should not do any harm at the
least.

However, in principle D0-D3-D0 at the PCI level alone may not be
sufficient, because ACPI may need to be involved.

I think that PM-runtime should suspend XHCI controllers without
anything on the bus under them, so I wonder what happens if
".../power/control" is set to "on" and then to "auto" for that device,
with the driver loaded.

> Or in terms of other ways of testing the power transition outside of
> the suspend path, if a PCI dev is runtime suspended with no driver
> loaded, should Linux not be attempting to put it into D3?

PCI devices without drivers cannot be runtime-suspended at all.

Cheers,
Rafael
