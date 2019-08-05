Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E18826AB
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 23:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfHEVP0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 17:15:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42587 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHEVP0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2019 17:15:26 -0400
Received: by mail-oi1-f194.google.com with SMTP id s184so63418287oie.9;
        Mon, 05 Aug 2019 14:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fX0uLeu4WyBXdgrz/XI2vSyMGlamTcEZJr5vMDYwpvE=;
        b=DK2t3PvZajPjOjcnnm8uK3XCVYmZK4RMkaqj03optfVNfkSOsjD6RfG6/4AEcArdab
         FMuFsYjj1lcmFpsym9CU/z3CnrHpj3kbrGX7a0WHNUz3SVuNeC34V+l7o2AxH4baKmdH
         YHl6fEhjbM6rQZ/0mucVSHVnFfTKoO945AqsXqSs0MjBzqVOP53K+3Mzb07WmLJa38P1
         2ZduJWfdJGNAqI1Kw7v8Tsmajo5G9JC6YtcHKG/YLYdc3SNIDZK5pJLbxI8M2DlSuWtI
         X2yYQ2nOB2UCBMkxZSreLih2niZFnNbKypHQRU1bj+hAQIL2xnQkXgt9gH6tRhVQdv81
         WRNQ==
X-Gm-Message-State: APjAAAWeRe+9BFSGEUB4rgBvMQcduThFgLGPF+SLgjWGgUp4QEzbOLTn
        /i5WYUxwmpd6FJHZLhvRsBxa8PH3fpgSa3cGEck=
X-Google-Smtp-Source: APXvYqzxQdPHKAU8EvAofP903jPi7ejUZMMYbWg4JQHntbAQayhsorKwS0WljKzlHdSuvsZpv28j28exZINzhQdVTXw=
X-Received: by 2002:aca:5a41:: with SMTP id o62mr280998oib.110.1565039725652;
 Mon, 05 Aug 2019 14:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190805205214.194981-1-helgaas@kernel.org> <20190805205214.194981-3-helgaas@kernel.org>
In-Reply-To: <20190805205214.194981-3-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Aug 2019 23:15:13 +0200
Message-ID: <CAJZ5v0gN+r+6UiUFGWmqzudGDqn=oWg0sRg-8jjX2HMJwLdxAg@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI / PM: Return error when changing power state from D3cold
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 5, 2019 at 10:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> pci_raw_set_power_state() uses the Power Management capability to change a
> device's power state.  The capability is in config space, which is
> accessible in D0, D1, D2, and D3hot, but not in D3cold.
>
> If we call pci_raw_set_power_state() on a device that's in D3cold, config
> reads fail and return ~0 data, which we erroneously interpreted as "the
> device is in D3hot", leading to messages like this:
>
>   pcieport 0000:03:00.0: Refused to change power state, currently in D3
>
> The PCI_PM_CTRL has several RsvdP fields, so ~0 is never a valid register
> value.  Notice if we get that data, print a more informative message, and
> return an error.
>
> Changing the power state of a device from D3cold must be done by a platform
> power management method or some other non-config space mechanism.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bfc739dc6ada..984171d40858 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -851,6 +851,11 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>                 return -EIO;
>
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +       if (pmcsr == (u16) PCI_ERROR_RESPONSE) {
> +               pci_err(dev, "device not responding; can't change to power state D%d\n",
> +                       state);
> +               return -EIO;
> +       }
>
>         /*
>          * If we're (effectively) in D3, force entire word to 0.
> --
> 2.22.0.770.g0f2c4a37fd-goog
>
