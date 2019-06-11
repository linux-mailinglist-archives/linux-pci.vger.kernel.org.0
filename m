Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5824D3C6EB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2019 11:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbfFKJED (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 05:04:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46787 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404888AbfFKJEC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2019 05:04:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id z23so11112990ote.13;
        Tue, 11 Jun 2019 02:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xkpqu797JcU12g0w5NFxA6TZH8kiWDktgPOouyK6wz8=;
        b=C+EbnsL/kQjqKyFGDmAo1aleTlSOQ7t70okNXqw8S7sJMEnD1gtnciQZSqDrF94q5+
         3WPpVmxc06aCNzjwuRkrtailazG5H/BFiqwic4Eu2VnQ0z5hIf4kgrQRbjUSVtcyc21U
         bpc+4ySo4tvmb2xQgpZ8/eGQwN99V93OzXgwd9ZbaePjunE9uHSnX5yaBLHPzIzMTVmg
         Obk3mHKcUjoTKJtS8MKTxl3WRJjhNf9E8qGEKHI3cG48NcpjvjsrcC0c2sa84M09jERE
         lGbAbNk+9Ja5rdS5Ft9lt40TZeS2J0XlpKXXm2rn52oATMBD8eL7z7rqmzElJ8XddVsa
         +D8Q==
X-Gm-Message-State: APjAAAU0x2G9aDGME9nhjqeWRleplcmWuOznPAROraosO6qzfYau1bZT
        gIxD8oo9Pd1GNT2OmbkaB3hpEskHGnheVJzwWvI=
X-Google-Smtp-Source: APXvYqzMpd9gFQQP34IDqVnyXu1aDZgXkGeVajlJkHf91wpXSYY3EvG0zd5ShGu4bud2vV4CcyiyzQkKfPKMO8yc7GE=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr196495otp.189.1560243841137;
 Tue, 11 Jun 2019 02:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <2315917.ZGeXE6pBFC@kreacher> <10983642.dUqMSvAAlD@kreacher> <527F9B70-68AC-4CD4-A3C2-576EA09187DD@canonical.com>
In-Reply-To: <527F9B70-68AC-4CD4-A3C2-576EA09187DD@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Jun 2019 11:03:49 +0200
Message-ID: <CAJZ5v0j-=ByjSMjr+MKDQGg_07s5-ZWKeCZR_-+trNoAA1nodw@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Avoid possible suspend-to-idle issue
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 11, 2019 at 10:39 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Rafael,
>
> at 19:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> > On Friday, May 17, 2019 11:08:50 AM CEST Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> If a PCI driver leaves the device handled by it in D0 and calls
> >> pci_save_state() on the device in its ->suspend() or ->suspend_late()
> >> callback, it can expect the device to stay in D0 over the whole
> >> s2idle cycle.  However, that may not be the case if there is a
> >> spurious wakeup while the system is suspended, because in that case
> >> pci_pm_suspend_noirq() will run again after pci_pm_resume_noirq()
> >> which calls pci_restore_state(), via pci_pm_default_resume_early(),
> >> so state_saved is cleared and the second iteration of
> >> pci_pm_suspend_noirq() will invoke pci_prepare_to_sleep() which
> >> may change the power state of the device.
> >>
> >> To avoid that, add a new internal flag, skip_bus_pm, that will be set
> >> by pci_pm_suspend_noirq() when it runs for the first time during the
> >> given system suspend-resume cycle if the state of the device has
> >> been saved already and the device is still in D0.  Setting that flag
> >> will cause the next iterations of pci_pm_suspend_noirq() to set
> >> state_saved for pci_pm_resume_noirq(), so that it always restores the
> >> device state from the originally saved data, and avoid calling
> >> pci_prepare_to_sleep() for the device.
> >>
> >> Fixes: 33e4f80ee69b ("ACPI / PM: Ignore spurious SCI wakeups from
> >> suspend-to-idle")
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> I just found out this patch has a chance to freeze or reboot the system
> during suspend cycles.
> What information do you need to debug?

It would be good to narrow down the failure to a particular
transition, for example.

In particular, if that happens during the dpm_noirq_resume_devices()
called from s2idle_loop(), it may be necessary to also skip
pci_pm_default_resume_early() for the devices with skip_bus_pm set.

How many devices on the affected system end up with skip_bus_pm set,
for that matter?
