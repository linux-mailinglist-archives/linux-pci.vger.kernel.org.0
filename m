Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C0910689C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 10:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfKVJHR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 04:07:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44512 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfKVJHR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 04:07:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id c19so5533675otr.11;
        Fri, 22 Nov 2019 01:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40cp6sbp1LXK6FgVw9DtfWmsQFXcIol/9unXXqPvBWE=;
        b=P8pegOdZpnZNV2y/Wo/3oFCP9BS211Sn13jJFDja3JjXIaa+dlwg0ThbbjQD85K1Za
         Qo48Kpsby1SCmcrCKNsiFECZc8JdgZyfMqmhY+Qj3HD8tKdGWz23in2SQFwIUyng3uP5
         Y4HHYETMG7kMppt4l5lNhce/PCMMG05bsp0+pXU1bHvHAOW0g7jgR3v8lfk9F0ww5Okz
         7kxT8hZ2rWoru0dVigvCO4RFHEruUGY81QrbXSuRpBa5bklGFLBe8Qk4dfGz0RYPtU9W
         Agj3QtzWAyn/M9Z3bckWolQlh2kim6Eha3Bcz8+1zNLLTt1l0Zbi7m1WPtK/xxKCdS1C
         td7Q==
X-Gm-Message-State: APjAAAXXDyF1ANYAC0Ru/NWogBFaYzImmA5B+uJLTQ8cZiiPrDXZ8pNt
        5aiHJPnfYxCiZV62BbgLBdUlXlgz7PQmd8RCwkV0gZcc
X-Google-Smtp-Source: APXvYqzd0eIxmN800CobU7Ca6/eY+fxOdyQYM0rOLFzFsNXb7tETIPDcTZ5muyZROiFWKVaDqLPhAwIk5Kw3TbBmlQw=
X-Received: by 2002:a9d:7d01:: with SMTP id v1mr9451324otn.167.1574413636386;
 Fri, 22 Nov 2019 01:07:16 -0800 (PST)
MIME-Version: 1.0
References: <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
 <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <20191121125236.GX11621@lahna.fi.intel.com>
 <CAJZ5v0iMwhudB7O0hR-6KfRfa+_iGOY=t0Zzeh6+9OiTzeYJfA@mail.gmail.com>
 <20191121194942.GY11621@lahna.fi.intel.com> <CAJZ5v0gyna0b135uxBVfNXgB9v-U9-93EYe0uzsr2BukJ9OtuA@mail.gmail.com>
 <CACO55tvFeTFo3gGdL02gnWMMk+AHPPb=hntkre0ZcA6WvKcV1A@mail.gmail.com> <CACO55tvkQyYYnCs71_nJuNFm4f8kkvBqje8WeZGph7X+2zO3aA@mail.gmail.com>
In-Reply-To: <CACO55tvkQyYYnCs71_nJuNFm4f8kkvBqje8WeZGph7X+2zO3aA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Nov 2019 10:07:04 +0100
Message-ID: <CAJZ5v0jNq77xPXxeYeq_JJBCfekVPVPOye1mZwpQi=+=MKSS7w@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Karol Herbst <kherbst@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@intel.com>,
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

On Fri, Nov 22, 2019 at 1:13 AM Karol Herbst <kherbst@redhat.com> wrote:
>
> so while trying to test with d3cold disabled, I noticed that I run
> into the exact same error.

Does this mean that you disabled d3cold on the GPU via sysfs (the
"d3cold_allowed" attribute was 0) and the original problem still
occurred in that configuration?

> And I verified that the
> \_SB.PCI0.PEG0.PG00._STA returns 1, which indicates it should still be
> turned on.

I don't really understand this comment, so can you explain it a bit to
me, please?
