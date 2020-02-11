Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F776159189
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 15:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgBKOGO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 09:06:14 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:42770 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbgBKOGO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2020 09:06:14 -0500
Received: by mail-lj1-f180.google.com with SMTP id d10so11706024ljl.9
        for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2020 06:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ffv1ImNg5xaZOr9NJU0d1Cd2bSa64FxyHxnvwn2bOTc=;
        b=OtNW1Gu7bHz2EHBDbS/tgNmCFt+LhEs8HNJmfyZyQpg4Sjp+e+q2tt6bMfkrxD5ReD
         utXuE4kGw9XCMSrYvWm7tutHLQx555l/DZBHbLwlFbaRQjLPcNKmjRAxoLo6KBm0Cu7G
         UZDiYfX2ZDMwCfINRpmaKp9PSSynowjxQ2ugiKWg+E2iCW1PIkbW2RJSJWD4+JZLaMxD
         ZH5NI+NuRaWcp851rxZAB9+xEz2ZwiNi9mVF1QTwsWP849OaQmlW9W4KIi2fORo5BVgR
         K5YDPIoloPBTGn++6RlJyyVzF72sF24DOsrGOLa0IMWqlbFV1wUbOKVtgGxtWW/bvT8H
         WTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ffv1ImNg5xaZOr9NJU0d1Cd2bSa64FxyHxnvwn2bOTc=;
        b=ahYY0mpoubuH4NVxr6JF+4xcZe3+B5H3ZVE/0mXr7FYhEIY9P1R5kZ8nQ/yRsr8tvc
         de0YQFY/h7aJsgc7JavCcgl8vJx8shectHKMPkCby5knjeWzACPQLktcgDohB0Bl3fNT
         liZdVP9yD/Rg+isqK4IKF3CWeE6QrfWWAXqs6ej3bKwJ2UrYDy+Sb7Vr4gzUd3V6FNLb
         VF155eG80uCWsDhdFwR0VVnBCepzMsQg5HTNOQDHd89y0WLGSC9N2PUhOnVhYT4VHgHh
         MZPvMGHPy76s0sLlBOJh0NSvcdIbtrw5bMo/capxDvII685Vwk9nTuLRJDKCZ2MnGzXR
         ulWg==
X-Gm-Message-State: APjAAAWrXQnrfiTP9B5nxtIhnkZZ1zZb4FIuwHfwh9FqsH8SSHSMyRMN
        L2Ww5x+09n1kumiTaOoBJg7HEz6jDpCTMB/ixdzSoXSl
X-Google-Smtp-Source: APXvYqxVx4AAwT5qsKeAzKc2kl4/f/lgMGU2mxCxYgCtQWrE3gMzdSlQ1gDvhK3WqWgYafdtyVr0/zzyM0x5bjCjcKQ=
X-Received: by 2002:a2e:9218:: with SMTP id k24mr4221713ljg.262.1581429972097;
 Tue, 11 Feb 2020 06:06:12 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+j9ukzVia8_V3FisLCpT2GsKbmhWtJpQudtWUJcSAki+w@mail.gmail.com>
 <20200210222834.GA74627@google.com>
In-Reply-To: <20200210222834.GA74627@google.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Tue, 11 Feb 2020 19:36:00 +0530
Message-ID: <CAHhAz+jdEK73ji4MsuV3jsDih8qNG5p9Ywzn_1iuTseGNp2cBQ@mail.gmail.com>
Subject: Re: pcie: kernel log - BAR 15: no space for... BAR 15: failed to assign..
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 11, 2020 at 3:58 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sun, Feb 09, 2020 at 07:59:41AM +0530, Muni Sekhar wrote:
> > Hi all,
> >
> > After rebooting the system following messages are seen in dmesg.
> > Not sure if these indicate a problem. Can some one look at these and
> > confirm if this is problem or can be ignored ?
> >
> > Also any suggestions as to what would cause this?
> >
> > [    1.084728] pci 0000:00:1c.0: BAR 15: no space for [mem size
> > 0x00200000 64bit pref]
> > [    1.084813] pci 0000:00:1c.0: BAR 15: failed to assign [mem size
> > 0x00200000 64bit pref]
> > [    1.084890] pci 0000:00:1c.2: BAR 14: no space for [mem size 0x00200000]
> > [    1.084949] pci 0000:00:1c.2: BAR 14: failed to assign [mem size 0x00200000]
> > [    1.085037] pci 0000:00:1c.2: BAR 15: no space for [mem size
> > 0x00200000 64bit pref]
> > [    1.085108] pci 0000:00:1c.2: BAR 15: failed to assign [mem size
> > 0x00200000 64bit pref]
> > [    1.085199] pci 0000:00:1c.3: BAR 15: no space for [mem size
> > 0x00200000 64bit pref]
> > [    1.085270] pci 0000:00:1c.3: BAR 15: failed to assign [mem size
> > 0x00200000 64bit pref]
> > [    1.085343] pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
> > [    1.085403] pci 0000:00:1c.2: BAR 13: assigned [io  0x2000-0x2fff]
> > [    1.085470] pci 0000:00:1c.3: BAR 15: no space for [mem size
> > 0x00200000 64bit pref]
> > [    1.085540] pci 0000:00:1c.3: BAR 15: failed to assign [mem size
> > 0x00200000 64bit pref]
> > [    1.085613] pci 0000:00:1c.2: BAR 14: no space for [mem size 0x00200000]
> > [    1.085672] pci 0000:00:1c.2: BAR 14: failed to assign [mem size 0x00200000]
> > [    1.085738] pci 0000:00:1c.2: BAR 15: no space for [mem size
> > 0x00200000 64bit pref]
> > [    1.085808] pci 0000:00:1c.2: BAR 15: failed to assign [mem size
> > 0x00200000 64bit pref]
> > [    1.085884] pci 0000:00:1c.0: BAR 15: no space for [mem size
> > 0x00200000 64bit pref]
> > [    1.085954] pci 0000:00:1c.0: BAR 15: failed to assign [mem size
> > 0x00200000 64bit pref]
> > [    1.086026] pci 0000:00:1c.0: PCI bridge to [bus 01]
> > [    1.086083] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> > [    1.086144] pci 0000:00:1c.0:   bridge window [mem 0xd0400000-0xd07fffff]
>
> The "no space" and "failed to assign" messages are all for bridge
> windows (13 is the I/O window, 14 is the MMIO window, 15 is the MMIO
> pref window).  I can't tell if you have any devices below these
> bridges (lspci would show them).  If you don't have any devices below
> these bridges, you can ignore the messages.
I have the devices below these bridges. FPGA endpoint is connected to
'00:1c.0 PCI bridge' and Ethernet controller is connected to '00:1c.3
PCI bridge'.
Does these messages impact the functionality of the connected devices?
If so what kind of impact and is there any solution for this?
Also, I'd like to know why "no space" and "failed to assign" messages displayed?


>
> Bjorn



-- 
Thanks,
Sekhar
