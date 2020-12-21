Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452482DFE18
	for <lists+linux-pci@lfdr.de>; Mon, 21 Dec 2020 17:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgLUQeP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Dec 2020 11:34:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60034 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgLUQeO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Dec 2020 11:34:14 -0500
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1krO7o-0008S9-G1
        for linux-pci@vger.kernel.org; Mon, 21 Dec 2020 16:33:32 +0000
Received: by mail-lf1-f69.google.com with SMTP id q13so11301133lfd.16
        for <linux-pci@vger.kernel.org>; Mon, 21 Dec 2020 08:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DJCzPnkhqRPedetC6f30gfeqZjj9GSnRoXOKXqtenM=;
        b=M2G3PGlo+gnkEG0Wk4f8vZF21Qoqf3iNaQlpryE7yDX7nN6kCPLO+7R246lrSZ50Ci
         iVdk2iZO8cRgi6uqvC0P+y/DRjVDmIX/PfIsRQyKsnI4QtcCC4L4iIHozEmSSz7U58xD
         KfECBVeYzQLer7icVMrhPhKRFnwiPfdC2IoRPp4sXjS+bWPPSEVE9YeKktbKR5OCIM4N
         hrMAvzyyMTbVLqGiZMm1mQuA0Be0xTeYsUXFv5WlXfTvHtgZCpg9XkX85hQPf6PaYHW7
         NgQEo+i+tfQOi+l5UOiRmeUfmMW1X7PVT4vukukKFLIvkHRxxoFz8gRpWtf3eGomJXgu
         15qQ==
X-Gm-Message-State: AOAM530/sbeB1JV7R91ZPJQDJTluAA5+AuJj+fRZq3+cNXoaPGL4EJnV
        Pza3TIl6vi6lLuyQp+tI1KGEDTtafPLIt8ffLPVaFLV86qQFRvtM3YakjaTQoaQY91n9kONaY0k
        TNE6un6JcUYqiqxoTbTp+0HOrtgqUEuhkyjFeVW3cpizFhVSIvhCtVQ==
X-Received: by 2002:a2e:9b8a:: with SMTP id z10mr7354280lji.126.1608568411903;
        Mon, 21 Dec 2020 08:33:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtnLVxc3tdNQMXpGXmxOqiYwSpbFnGFhsFaqolhzWgqF0GoirNF1t7rUczUrKsKTQYUeDw3QVY7adO187jKOU=
X-Received: by 2002:a2e:9b8a:: with SMTP id z10mr7354267lji.126.1608568411594;
 Mon, 21 Dec 2020 08:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20201214060621.1102931-1-kai.heng.feng@canonical.com>
 <20201216124726.2842197-1-kai.heng.feng@canonical.com> <s5h5z51oj12.wl-tiwai@suse.de>
 <CAAd53p6kORC1GsW5zt+=0=J5ki43iriO-OqtFvf5W67LWhyyhA@mail.gmail.com>
 <s5hzh2dn3oa.wl-tiwai@suse.de> <CAAd53p6Ef2zFX_t3y1c6O7BmHnxYGtGSfgzXAMQSom1ainWXzg@mail.gmail.com>
 <s5hsg85n2km.wl-tiwai@suse.de> <s5hmtydn0yg.wl-tiwai@suse.de>
 <CAAd53p6MMFh=HCNF9pyrJc9hVMZWFe7_8MvBcBHVWARqHU_TTA@mail.gmail.com> <s5h7dpfk06y.wl-tiwai@suse.de>
In-Reply-To: <s5h7dpfk06y.wl-tiwai@suse.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 22 Dec 2020 00:33:20 +0800
Message-ID: <CAAd53p53w0H6tsb4JgQtFTkYinniicTYBs2uk7tc=heP2dM_Cw@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda: Continue to probe when codec probe fails
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PCI <linux-pci@vger.kernel.org>,
        nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Cc nouveau]

On Fri, Dec 18, 2020 at 4:06 PM Takashi Iwai <tiwai@suse.de> wrote:
[snip]
> > Quite possibly the system doesn't power up HDA controller when there's
> > no external monitor.
> > So when it's connected to external monitor, it's still needed for HDMI audio.
> > Let me ask the user to confirm this.
>
> Yeah, it's the basic question whether the HD-audio is supposed to work
> on this machine at all.  If yes, the current approach we take makes
> less sense - instead we should rather make the HD-audio controller
> working.

Yea, confirmed that the Nvidia HDA works when HDMI is connected prior boot.

> > > - The second problem is that pci_enable_device() ignores the error
> > >   returned from pci_set_power_state() if it's -EIO.  And the
> > >   inaccessible access error returns -EIO, although it's rather a fatal
> > >   problem.  So the driver believes as the PCI device gets enabled
> > >   properly.
> >
> > This was introduced in 2005, by Alan's 11f3859b1e85 ("[PATCH] PCI: Fix
> > regression in pci_enable_device_bars") to fix UHCI controller.
> >
> > >
> > > - The third problem is that HD-audio driver blindly believes the
> > >   codec_mask read from the register even if it's a read failure as I
> > >   already showed.
> >
> > This approach has least regression risk.
>
> Yes, but it assumes that HD-audio is really non-existent.

I really don't know any good approach to address this.
On Windows, HDA PCI is "hidden" until HDMI cable is plugged, then the
driver will flag the magic bit to make HDA audio appear on the PCI
bus.
IIRC the current approach is to make nouveau and device link work.

Kai-Heng

>
>
> thanks,
>
> Takashi
