Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49B841DB38
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 15:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351206AbhI3Niq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 09:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351488AbhI3NiM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 09:38:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1253C06176F
        for <linux-pci@vger.kernel.org>; Thu, 30 Sep 2021 06:36:29 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id bb10so4038473plb.2
        for <linux-pci@vger.kernel.org>; Thu, 30 Sep 2021 06:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IhpYyYMkI0XeCNTdHlGSDJ81bcd7IFryeGArrY+szTQ=;
        b=tzWjBg/nHXskXvXdSbdUAWirx10WGMvuJ25QnMqWGEKVu117WsUQDqo4BXxwBZM4Vy
         iMml9XLmdFezpL9PbFm884VgwXYcmMmqEdsqZo/9avYsPncDNWceavMqHTp7IFuX5Fiv
         v1r1F93OnXI9jmqpBVM3KAPk4tWkBhXozrofq6QyHPWA5TQdjsNkKSQVf8j8CwL26cu0
         X1L7FlxzkkWZnmbRFR9XxQuyeFhA5I/9zP6wcOvF0wUweSJoIYAs5Q4vf/0C2jEdhC6w
         ywbhSEggIflJxp6X9N1danfTLv6L8n3TWRtAzZkKsVJ10omi+3CgBK5+GJa6KgGcSdJq
         KKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhpYyYMkI0XeCNTdHlGSDJ81bcd7IFryeGArrY+szTQ=;
        b=GxFNoc31495uVtuc7uh16nzy+cxlAc4YaOq0U0ltya0P7WP1mqYcaj0xJkV3jNp7Nw
         RxKgWjS/Ljez1h9x5KVMtzc/Q5lEhUSiA7ont1GE4dOQdFxfJ6xk4smLe3Y8JXpo/3JM
         Em0arQH7pcVkGHIduxlgYNxARHqfLEz0B3sN/FL/BOnUMgo/6AH46LAKMRexuvbPnpCU
         QjhHt2SGn7EihjIjVkS/GX+4zsyj3R0yW9u+SNCfi567Z0rWQpbpv1obbtvI3NxsMkI8
         ZKZ3ak8D01D29cVcK59DVegZYfS+ZQNz3BQavDXXejj5BlGTRRIfk0P2vXr+jT/uwFwV
         MHrQ==
X-Gm-Message-State: AOAM531qPoSLcL/O2vSVnBdPo2ZHa9rx4njz+qr2nPtvL0SvC8J+UVlG
        nIYqVdEPJyAIetW2A8OINVNsUl/71kG1BVIMQWaQ0Q==
X-Google-Smtp-Source: ABdhPJx9Xs+gNqlcxbnlbCdHKqDDoKF331LGbfaO4gqbfJsLmZV5ogqMQNLLtD+mtDfBhXnpfvjX8RedejWnYxnG7hg=
X-Received: by 2002:a17:90b:3ec3:: with SMTP id rm3mr5619607pjb.93.1633008989101;
 Thu, 30 Sep 2021 06:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com> <20210930065953-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210930065953-mutt-send-email-mst@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 30 Sep 2021 06:36:18 -0700
Message-ID: <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 4:03 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Sep 29, 2021 at 06:05:09PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > Confidential guest platforms like TDX have a requirement to allow
> > only trusted devices. By default the confidential-guest core will
> > arrange for all devices to default to unauthorized (via
> > dev_default_authorization) in device_initialize(). Since virtio
> > driver is already hardened against the attack from the un-trusted host,
> > override the confidential computing default unauthorized state
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Architecturally this all looks backwards. IIUC nothing about virtio
> makes it authorized or trusted. The driver is hardened,
> true, but this should be set at the driver not the device level.

That's was my initial reaction to this proposal as well, and I ended
up leading Sathya astray from what Greg wanted. Greg rightly points
out that the "authorized" attribute from USB and Thunderbolt already
exists [1] [2]. So the choice is find an awkward way to mix driver
trust with existing bus-local "authorized" mechanisms, or promote the
authorized capability to the driver-core. This patch set implements
the latter to keep the momentum on the already shipping design scheme
to not add to the driver-core maintenance burden.

[1]: https://lore.kernel.org/all/YQuaJ78y8j1UmBoz@kroah.com/
[2]: https://lore.kernel.org/all/YQzF%2FutgrJfbZuHh@kroah.com/

> And in particular, not all virtio drivers are hardened -
> I think at this point blk and scsi drivers have been hardened - so
> treating them all the same looks wrong.

My understanding was that they have been audited, Sathya?
