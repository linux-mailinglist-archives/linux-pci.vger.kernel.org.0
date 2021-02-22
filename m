Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E5F321093
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 06:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhBVF5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Feb 2021 00:57:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51739 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhBVF5I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Feb 2021 00:57:08 -0500
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lE4Cn-0001T1-Kb
        for linux-pci@vger.kernel.org; Mon, 22 Feb 2021 05:56:25 +0000
Received: by mail-lj1-f199.google.com with SMTP id q13so12057359ljp.23
        for <linux-pci@vger.kernel.org>; Sun, 21 Feb 2021 21:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09TBSZdzgSpuE3f9Hl1jIn/cAfTfLAwweu2DXussM2s=;
        b=K3N+/6pSxYlMrHyiOZZaHsTHkpekDvfCdYf/c0NY0b5rk1sqJq2GVlXDn2dVYL1OA5
         dyW0PB0u/2vuoUtXkdlNHggBgjMhBEpXQ01Pv1cUADls4KGxnuQ/vCEoDh9vSzVzf2XM
         a8bix+y1UTzp8HpnVIngEoPj0rd6hf+sPDwKSyXdGFWoECrMCwaXwMby0KjwlhMKU62s
         S8IRooA+Tar1WHCXSkRcLWsPvu7R4xSiWHwaLMVytfKXqariRZ+qguK4qc0dHlB4dPq6
         hsuVA4VolvvfNucY9/JaUfPd7j+WjIdimim1kde/YgXXRF2D1Srbf7NQ4QqlyxX3KbUx
         CEbw==
X-Gm-Message-State: AOAM533JUdohuznvBfx/JWnnw9D4Smqhy4TA7L8l4JDbDEqgVTolTCxa
        ROt5wuxHNeUnY/VNFl1zna3NZQ/FcQaPkOONBAFfgzeBQQUm6drSlLy0bU0tqeV9ARb8+dkI/vy
        AkEOcBVD7F1JGLrb63jFzlzmsjq9uoQZQQOBBZpnSTEMBYzjL8FmCrw==
X-Received: by 2002:a2e:9a96:: with SMTP id p22mr13528697lji.403.1613973385071;
        Sun, 21 Feb 2021 21:56:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWNeNRC/yWtaEtvz78Am2bIIhPnfcUtPdVQVFyvqNtuGwayp0LN0mDZLTOW9y0RnEATPXJUlTFbSkkllKQi+c=
X-Received: by 2002:a2e:9a96:: with SMTP id p22mr13528679lji.403.1613973384871;
 Sun, 21 Feb 2021 21:56:24 -0800 (PST)
MIME-Version: 1.0
References: <20210204051850.64857-1-aaron.ma@canonical.com>
 <CAAd53p4euFiw7pfDnD2H8oMVeeTqQ_c+wOFDLM2xPccn5MewiA@mail.gmail.com>
 <cd4595e6-67da-885c-1a67-6dfd71425b8c@canonical.com> <CAAd53p4z1ydFi5pwOZJnsrBDPNVLKU0ygqa0+kdZdXWYocPLgQ@mail.gmail.com>
 <YCJJrVp2DvCzigCw@kroah.com> <00de6927-3fa6-a9a3-2d65-2b4d4e8f0012@linux.intel.com>
 <YCUoBP4GUrGL0J3J@kroah.com> <a93e3039-c910-4bf5-0e8a-ffdd74b983d0@canonical.com>
In-Reply-To: <a93e3039-c910-4bf5-0e8a-ffdd74b983d0@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 22 Feb 2021 13:56:13 +0800
Message-ID: <CAAd53p7Zzcny277JQe2oZ3R5xwm=dyUtY6bdoEesRycbFh_hbg@mail.gmail.com>
Subject: Re: [PATCH] xhci-pci: Set AMD Renoir USB controller to D3 when shutdown
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>, peter.chen@nxp.com,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 19, 2021 at 4:07 PM Aaron Ma <aaron.ma@canonical.com> wrote:
>
>
>
> On 2/11/21 8:50 PM, Greg Kroah-Hartman wrote:
> > On Wed, Feb 10, 2021 at 03:13:30PM +0200, Mathias Nyman wrote:
> >> On 9.2.2021 10.37, Greg Kroah-Hartman wrote:
> >>> On Fri, Feb 05, 2021 at 02:50:15PM +0800, Kai-Heng Feng wrote:
> >>>> On Fri, Feb 5, 2021 at 2:45 PM Aaron Ma <aaron.ma@canonical.com> wrote:
> >>>>>
> >>>>>
> >>>>> On 2/5/21 12:27 PM, Kai-Heng Feng wrote:
> >>>>>> Can you please test the following patch, which should address the root cause:
> >>>>>> https://lore.kernel.org/linux-acpi/20201201213019.1558738-1-furquan@google.com/
> >>>>>>
> >>>>>> It also helps another AMD laptop on S5:
> >>>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1912935
> >>>>>>
> >>>>>
> >>>>> No, this patch doesn't help on ThinkPad AMD platform.
> >>>>
> >>>> Thanks for the confirmation!
> >>>>
> >>>> Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>>
> >>> Mathias, want me to take this in my tree now, or are you going to send
> >>> me more patches for 5.12-rc1?
> >>>
> >>
> >> Nothing more for 5.12-rc1 from me.
> >>
> >> Could this be a PCI quirk instead of xhci?
> >> Maybe there is some PCI flag for this already, haven't checked yet.
> >>
> >> We want a specific PCI device to go to PCI D3cold at PCI shutdown...
> >
> > There probably is.  Kay-Heng, can you look into doing that instead?
> >
>
> There is no such PCI quirk, usually it calls driver to shutdown.

Let me work on it. There are other devices need to be in D3 for
shutdown, a generic approach across all devices will be better.

Kai-Heng

>
> Regards,
> Aaron
>
> > thanks,
> >
> > greg k-h
> >
