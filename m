Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3977ADE70
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2019 10:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfD2Ix5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Apr 2019 04:53:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44260 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfD2Ixw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Apr 2019 04:53:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id d14so1305630qkl.11
        for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2019 01:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIfW/+4U6pm/qHClHwco8fXWHPOvzXVyki8YHnCJ7Oo=;
        b=G0ifwilbgQvCCurE40ozOh++dlQ6TwsJVSepvncCE3vIT8eMGzWeKot1biFvA9U2ii
         Gr23sIAhYIjtAJhqYzHxXXrCmRpqH+wRQUxqit7lgjO5H/QukG7C6LLy03z6jchimJrH
         1JDDOsqi866K8ykuktAnQnWUkWxK9tdKEmTNuv4FofQlrUIsJlcWcrIfv6N6gyA8h5i8
         /HdMP0F3PpgSTbr9eidt6zUsoFKfJ+cgKGaSXy66/jbfTws2NgmjYTFOsIkvkHkV9iLi
         C006y3itN2124L9jvaWDJsnFCnI2aDc+EIDVSmAC4JRXlmmkIoDgGNQ7Oz4cIhRkc/Pt
         icpQ==
X-Gm-Message-State: APjAAAXfUujd3wcQHh25dJaihVEMvxKcK7BCRcZjMQYoA/i+1E2wKNFF
        1I9EcYEhWw5UVrRHNnFj7z5T4fHUr14Lacd4WqTBig==
X-Google-Smtp-Source: APXvYqzcMZ5FKoxrkfqxkrmVt6Of2QI47wB27cMM6qBuRjYdorVZD7CdMBEG1ydWTC6gW6JJMxnjrTp1/W9zsWKPAi4=
X-Received: by 2002:ae9:e418:: with SMTP id q24mr16707653qkc.134.1556528031629;
 Mon, 29 Apr 2019 01:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190422130814.GJ173520@google.com> <3a1139ef-10ed-6923-73c5-30fbf0c065c3@linux.intel.com>
 <CAO-hwJKvXO6L7m0g1D6wycFP=Wu_qLDyLXTtmm0TkpxT5Z8ygw@mail.gmail.com> <e96a7220-974f-1df6-70ee-695ee815057f@linux.intel.com>
In-Reply-To: <e96a7220-974f-1df6-70ee-695ee815057f@linux.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 29 Apr 2019 10:53:40 +0200
Message-ID: <CAO-hwJLCPd-KfoK7OnSpEWG4B5cYfsH3J0tYAxJeVMqHyJEN1A@mail.gmail.com>
Subject: Re: [Bug 203297] Synaptics touchpad TM-3127 functionality broken by
 PCI runtime power management patch on 4.20.2
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keijo Vaara <ferdasyn@rocketmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 29, 2019 at 10:38 AM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> On 4/29/19 10:45 AM, Benjamin Tissoires wrote:
> >> I would like to ask help from input subsystem experts what kind of SMBus
> >> power state dependency Synaptics RMI4 SMBus devices have since it cease
> >> to work if SMBus controllers idles between transfers and how this is
> >> best to fix?
> >
> > Hmm, I am not sure there is such an existing architecture you could
> > use in a simple patch.
> >
> > rmi-driver.c does indeed create an input device we could use to toggle
> > on/off the PM state, but those callbacks are not wired to the
> > transport driver (rmi_smbus.c), so it would required a little bit of
> > extra work. And then, there are other RMI4 functions (firmware
> > upgrade) that would not be happy if PM is in suspend while there is no
> > open input node.
> >
> I see.
>
> I got another thought about this. I noticed these input drivers need
> SMBus Host Notify, maybe that explain the PM dependency? If that's the
> only dependency then we could prevent the controller suspend if there is
> a client needing host notify mechanism. IMHO that's less hack than the
> patch to rmi_smbus.c.

So currently, AFAIK, only Synaptics (rmi4) and Elantech are using
SMBus Host Notify.
So this patch would prevent the same bugs for those 2 vendors, which is good.

It took me some time to understand why this would be less than a hack.
And indeed, given that Host Notify relies on the I2C connection to be
ready for the IRQ, we can not put the controller in suspend like we do
for others where the IRQ controller is still ready.

So yes, that could work from me. Not sure what Wolfram and Jean would
say though.

>
> Keijo: care to test does this idea would fix the issue (without the
> previous patch)? I also attached the diff.
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 38af18645133..d54eafad7727 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -327,6 +327,8 @@ static int i2c_device_probe(struct device *dev)
>
>                 if (client->flags & I2C_CLIENT_HOST_NOTIFY) {
>                         dev_dbg(dev, "Using Host Notify IRQ\n");
> +                       /* Adapter should not suspend for Host Notify */
> +                       pm_runtime_get_sync(&client->adapter->dev);
>                         irq = i2c_smbus_host_notify_to_irq(client);
>                 } else if (dev->of_node) {
>                         irq = of_irq_get_byname(dev->of_node, "irq");
> @@ -431,6 +433,8 @@ static int i2c_device_remove(struct device *dev)
>         device_init_wakeup(&client->dev, false);
>
>         client->irq = client->init_irq;
> +       if (client->flags & I2C_CLIENT_HOST_NOTIFY)
> +               pm_runtime_put(&client->adapter->dev);
>
>         return status;
>   }
>
> > So I think this "hack" (with Mika's comments addressed) should go in
> > until someone starts propagating the PM states correctly.
> >
> I guess you mean the Rafael's pm_runtime_get_sync() comment?

Oops, yes, that one, sorry :)

Cheers,
Benjamin
