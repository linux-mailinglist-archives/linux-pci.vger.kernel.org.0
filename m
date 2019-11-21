Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11AFA1050FD
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 12:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfKULEG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 06:04:06 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46437 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKULEG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 06:04:06 -0500
Received: by mail-ot1-f65.google.com with SMTP id n23so2492336otr.13;
        Thu, 21 Nov 2019 03:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dh9d0dUVp1CFrTbKfXBJy2XPGIAj+Ygua+R35GCU6hA=;
        b=tUl5MeBMWi8lIKOooBW6my3CAqmw4755zjI1vZNFBSqF2gXqDTYFT/3HonRyKc1VYD
         o0thiy8JdVCAbXP13Ky/+KxI8L03rXnd2CUSR0lOq9iTw/AcMUMLeXWQ1zp/F0I74sfr
         OM/VVdrNObzps2ys7mZRXMa1VIJU3Nb+bCcgu+sQtwb9wg9aZzzjEoiZDEYGQHxVkDTh
         SlDRMFi4edHvlgDnd+cu/GefvpYekYYAEDl63KT0pbbW9e0xbsAAr6P51JjbKqpW22OZ
         RR99VUoj/f2Z0epLymu8XzyS3cFtnrNU9rl9i3RrxktGizq9Joat2IZW/r+ClfFzQzeH
         gseQ==
X-Gm-Message-State: APjAAAVmpKDi/ubtNtmucVuS1flrN49gprAAdCkdg5pUP2cBygmlhi1e
        wngF0/wc0ppAyfpH5JzVOjdqQHIdXJuYAIuQwN8C0A==
X-Google-Smtp-Source: APXvYqxFx3DFSmzLCJ7ozSiCIihOvli+a1PB/uoGzpaXFKpQWnkJxSiM2BLoRgZ+7H45DsO/f1Iw3wvPYrdDHoAhYOQ=
X-Received: by 2002:a9d:6b91:: with SMTP id b17mr5820414otq.189.1574334243469;
 Thu, 21 Nov 2019 03:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20191120115127.GD11621@lahna.fi.intel.com> <CACO55tsfNOdtu5SZ-4HzO4Ji6gQtafvZ7Rm19nkPcJAgwUBFMw@mail.gmail.com>
 <CACO55tscD_96jUVts+MTAUsCt-fZx4O5kyhRKoo4mKoC84io8A@mail.gmail.com>
 <20191120120913.GE11621@lahna.fi.intel.com> <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com> <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <20191120162306.GM11621@lahna.fi.intel.com>
 <CACO55tsvTG2E7_3nn1sTdPQXzxaZA96k+gmSBBXjPvei6v=kxg@mail.gmail.com> <20191121101423.GQ11621@lahna.fi.intel.com>
In-Reply-To: <20191121101423.GQ11621@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Nov 2019 12:03:52 +0100
Message-ID: <CAJZ5v0hAgz4Fu=83AJE2PYUsi+Jk=Lrr4MNp5ySA9yY=3wr5rg@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 11:14 AM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 10:36:31PM +0100, Karol Herbst wrote:
> > with the branch and patch applied:
> > https://gist.githubusercontent.com/karolherbst/03c4c8141b0fa292d781badfa186479e/raw/5c62640afbc57d6e69ea924c338bd2836e770d02/gistfile1.txt
>
> Thanks for testing. Too bad it did not help :( I suppose there is no
> change if you increase the delay to say 1s?

Well, look at the original patch in this thread.

What it does is to prevent the device (GPU in this particular case)
from going into a PCI low-power state before invoking AML to power it
down (the AML is still invoked after this patch AFAICS), so why would
that have anything to do with the delays?

The only reason would be the AML running too early, but that doesn't
seem likely.  IMO more likely is that the AML does something which
cannot be done to a device in a PCI low-power state.
