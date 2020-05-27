Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84F41E3608
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 05:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgE0DAq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 23:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgE0DAp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 23:00:45 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA26C061A0F;
        Tue, 26 May 2020 20:00:44 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id v11so5221124ilh.1;
        Tue, 26 May 2020 20:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xLWhCgU2S6HH+t1BqREDGsvSaeOzuvQP8Gfjxf/Kt3E=;
        b=huzwxoBgAVypsEtuCEDTwI9YwZPMEBBStD4ROhMIxIMFriWoG8yiwOHEsQqngfmayo
         O5VjtflYEXH0BvmhX+as4qIgMBa9rigWlni+zpnV0ChrHyDRgJNpmGaGLi4Oa+BPFuOu
         lxcCSaT8n2ePCsdjRHWppkhqzj+zytS/YsaIb1QAly4npukjJNsVXrpKe6QNYrfP4uNw
         Z1+O+crziZstJNcFABUal8CU83evVvEgSo9nmJM91pqJzyL2pu3lZIQk+t7JHsi322gg
         2MSptGc3Iz29gFTqTS4kkCmODY8ugm5raiTWVOTCI4wsZlEhkPgutKFuoVu0Zl8Pa1TT
         Y4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xLWhCgU2S6HH+t1BqREDGsvSaeOzuvQP8Gfjxf/Kt3E=;
        b=gCB420t/79bK0x6B1+chM3uYwGUGFFCdivAUF1XA/vnHuhKyTpNu1hRV5/UsevUS0v
         KuxepeWsbZhnn1iD5EMf3BNZEfD7oifCm53d3MeS/JLy+h5NWtSyTG5GbImqWOFdYGgN
         3xV2m6q7bMINvFSlBtcHEPvdEC99yRqLrbaTWTTHMUkVaxsN1AF1q8BBERWsk9iRtDp5
         BFygYMZJk9t8sgNEUNLad1veKmVHw+aVbciNht9qBBGxT4Gww28NDV2bOGuh6XhHTHyc
         8N4a1M4OFUHWx1+w0f4sA5Cdnj7Bd3StwG+IIOddDuCRrRWeItNW14XMwVczDlpKuaPs
         ewbA==
X-Gm-Message-State: AOAM531vR9Fqzxklst3rsfPfp9fmurLP8sDciJwkdHguCd158TQDX7Sj
        5SAZ0/JNU3oCCOs+p5jQBjeje/YdXZdXKA3AigA=
X-Google-Smtp-Source: ABdhPJx9gdtsbAHXbFZYiVWF9TaOJ0gewllmhhZdaoEI8StN7Z/a2OWO6Eiq/i7kZ+oHcibcBGX+ou33o8pu6NnK2eY=
X-Received: by 2002:a92:c94f:: with SMTP id i15mr3759079ilq.185.1590548443615;
 Tue, 26 May 2020 20:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <18609.1588812972@famine> <f4bbacd3af453285271c8fc733652969e11b84f8.1588821160.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <dbb211ba-a5f1-0e4f-64c9-6eb28cd1fb7f@hisilicon.com> <2569c75c-41a6-d0f3-ee34-0d288c4e0b61@linux.intel.com>
 <8dd2233c-a636-59fa-4c6e-5da08556d09e@hisilicon.com> <d59e5312-9f0b-f6b2-042a-363022989b8f@linux.intel.com>
 <d7a392e0-4be0-1afb-b917-efa03e2ea2fb@hisilicon.com> <f9a46300-ef4b-be19-b8cf-bcb876c75d62@linux.intel.com>
In-Reply-To: <f9a46300-ef4b-be19-b8cf-bcb876c75d62@linux.intel.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 27 May 2020 13:00:32 +1000
Message-ID: <CAOSf1CHTUyQ5o_ThkaPUkGjtTSK1UOkxSmKAWY3n3bdrVcjacA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PCI/ERR: Handle fatal error recovery for
 non-hotplug capable devices
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        jay.vosburgh@canonical.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ashok.raj@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 27, 2020 at 12:00 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi,
>
> On 5/21/20 7:56 PM, Yicong Yang wrote:
> >
> >
> > On 2020/5/22 3:31, Kuppuswamy, Sathyanarayanan wrote:
> >>
> > Not exactly. In pci_bus_error_reset(), we call pci_slot_reset() only if it's
> > hotpluggable. But we always call pci_bus_reset() to perform a secondary bus
> > reset for the bridge. That's what I think is unnecessary for a normal link,
> > and that's what reset link indicates us to do. The slot reset is introduced
> > in the process only to solve side effects. (c4eed62a2143, PCI/ERR: Use slot reset if available)
>
> IIUC, pci_bus_reset() will do slot reset if its supported (hot-plug
> capable slots). If its not supported then it will attempt secondary
> bus reset. So secondary bus reset will be attempted only if slot
> reset is not supported.
>
> Since reported_error_detected() requests us to do reset, we will have
> to attempt some kind of reset before we call ->slot_reset() right?

Yes, the driver returns PCI_ERS_RESULT_NEED_RESET from
->error_detected() to indicate that it doesn't know how to recover
from the error. How that reset is performed doesn't really matter, but
it does need to happen.


> > PCI_ERS_RESULT_NEED_RESET indicates that the driver
> > wants a platform-dependent slot reset and its ->slot_reset() method to be called then.
> > I don't think it's same as slot reset mentioned above, which is only for hotpluggable
> > ones.
> What you think is the correct reset implementation ? Is it something
> like this?
>
> if (hotplug capable)
>     try_slot_reset()
> else
>     do_nothing()

Looks broken to me, but all the reset handling is a rat's nest so
maybe I'm missing something. In the case of a DPC trip the link is
disabled which has the side-effect of hot-resetting the downstream
device. Maybe it's fine?

As an aside, why do we have both ->slot_reset() and ->reset_done() in
the error handling callbacks? Seems like their roles are almost
identical.

Oliver
