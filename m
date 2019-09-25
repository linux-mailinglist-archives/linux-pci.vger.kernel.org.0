Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64FE4BD7C9
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2019 07:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411717AbfIYFgh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Sep 2019 01:36:37 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:34964 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404277AbfIYFgh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Sep 2019 01:36:37 -0400
Received: by mail-qk1-f179.google.com with SMTP id w2so4252175qkf.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2019 22:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4OkSaLpNdi0uLSUNENiAT5o+G4P+NMR/tdptF66Z3I=;
        b=iyRFlBzIrYvGOOWlhqn+rRjFHWu51+wz+sFp2keLvkfA0dK+gopgYcrOdsln3IhuQ5
         8nzIWwdWs+TJPFwKG3GcFtlkEm+VFC3pjouCpuh5Y7AxL8LWrtxWiuUFCfDzXoTQsAu2
         aIzdol6kPQ2BeOJehaa89K1/y4awNETENu/sq6nwhr17MUzaMGJ4M/hXNFLhug98AqQ5
         RelGTWy2nJ4L7H4wXVThA2cfYqlBAwKK0aItnAcRHCyNMrsejG/ZPAtBriIO61FkE9z3
         dwqlKiSTP+N/pOi4jSe4O8rHlg4LZBhNU2L4uG4I3/ukUbrL4FQiu9O082CaP0oDgyUp
         qgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4OkSaLpNdi0uLSUNENiAT5o+G4P+NMR/tdptF66Z3I=;
        b=f2+eHXfuFDtu4a9KSzz4q5sBPCtKrfbz5U1Ebp9HJMpOROzs2XJJU2F5OU1pXDjagi
         zcNLTHnXUVQeLk8kJRWh9ebZV2eAkcrYVHXIJzkQrKhvfRsrkYZ9ei8xAFV5J50AlrDC
         gxQsh0xUVHa42lOcFFcxZsSPejJIXdLYpyZDVcqhhZEMC7Xx5pE1fmGiCBzIDEgJI2Eo
         /tI9KB4A/M5azo5KX+eCzjHdSdKjOqB7/eRXWZfSgB8GKtHfqDLWomP8weRDNUkK4mUs
         Bdpq11eS8yz+y+5IbJV19PwLiiFvARbUOo71I9Y3ucECIelDF6QCqZy5P0dGVi4PWm0g
         6Qig==
X-Gm-Message-State: APjAAAXJV6bMl894BpUvB7h8erNpiMBGcq+7gPPhhLU/1txWEqdYqAd5
        8CgBphRM7sTzxOLgpnYFdehtjOqWC3lmlWRL6YOjgw==
X-Google-Smtp-Source: APXvYqxaFV8T/oCBkaikYDBW2cR0TU7jGiBrlEWX4Aqh8n7slYKD1Ubm6p+Bq8NxOtSYcKrxsZn5aRN73s43tyULGPY=
X-Received: by 2002:a37:a7c5:: with SMTP id q188mr1749753qke.445.1569389796371;
 Tue, 24 Sep 2019 22:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp47Vh69gQjROYG69=waJgL7hs1PwnLonL9+27S_TcRhixA@mail.gmail.com>
 <CAJZ5v0g4T_0VD_oYMF_BF1VM-d1bg-BD8h8=STDrhVBgouPOPg@mail.gmail.com>
 <01cf6be6-9175-87ca-f3ad-78c06b666893@linux.intel.com> <CAD8Lp4658-c=7KabiJ=xuNRCqPwF4BJauMHqh_8WSBfCFHWSSg@mail.gmail.com>
 <CAJZ5v0gouaztf7tcKXBr90gjrVjOvqH70regD=o2r_d+9Bwvqg@mail.gmail.com>
 <CAD8Lp47oNJb5N5i4oUQfN5b=xCtUc1Lt852pnXxhNq0vyWj=yg@mail.gmail.com>
 <CAJZ5v0j=x4HHOsJ6fCX-xOr29-4BMRzjR5H5UaoWW9v-Ci8ODQ@mail.gmail.com> <CAD8Lp47qSte0C6sUFBkXVAHa755R5PnNUSvjRYD=JehYJ2R0pQ@mail.gmail.com>
In-Reply-To: <CAD8Lp47qSte0C6sUFBkXVAHa755R5PnNUSvjRYD=JehYJ2R0pQ@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 25 Sep 2019 13:36:25 +0800
Message-ID: <CAD8Lp4574C4QCA3mBb9iC_3hBj7pZ3kJi-fkg7dONQPjWcF8bQ@mail.gmail.com>
Subject: Re: Ryzen7 3700U xhci fails on resume from sleep
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 23, 2019 at 5:10 PM Daniel Drake <drake@endlessm.com> wrote:
> Unfortunately it's not quite as simple as quirking d3_delay though,
> because the problem still happens upon resume from s2idle. In that
> case, pci_dev_d3_sleep() is not called at all.
>
>     if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
>         pci_dev_d3_sleep(dev);
>
> In the runtime resume case, dev->current_state == PCI_D3hot here (even
> though pci_set_power_state had been called to put it into D3cold), so
> the msleep happens.
> But in the system sleep (s2idle) case, dev->current_state ==
> PCI_D3cold here, so no sleep happens.
> That is strangely inconsistent - is it a bug?

In more detail:

During runtime suspend:

pci_set_power_state() is called with state=D3cold
 - This calls pci_raw_set_power_state() with state=D3hot
 -- After transitioning to D3hot, dev->current_state is updated to
D3hot based on pmcsr readback

acpi_device_set_power() is called with state=D3cold
 - acpi_power_transition() is called with state=D3cold, updates
adev->power.state to D3cold
 - adev->power.state is updated (again) to D0

pci_update_current_state() is called
 - platform_pci_get_power_state() returns D3cold
 - dev->current_state is updated to D3cold

Observations: everything seems to be in order


During runtime resume:

pci_update_current_state() is called
 - platform_pci_get_power_state() returns D3cold
 - dev->current_state is updated to D3cold

pci_set_power_state() is called with state=D0
 - Calls pci_platform_power_transition
 -- Calls acpi_pci_set_power_state -> acpi_device_set_power with state=D0 :
 --- acpi_power_transition() updates adev->power.state to D0
 --- adev->power.state is updated (again) to D0
 -- Calls pci_update_current_state
 --- platform_pci_get_power_state() returns D0 (so this is ignored)
 --- dev->current_state is updated to D3 via pmcsr read
 - D3cold delay happens (good)
 - Calls pci_raw_set_power_state() with state=D0
 -- current_state is D3 so the D3 delay happens (good) (I quirked this
delay to 20ms)
 -- device is transitioned to D0 and dev->current_state is updated to
D0 from pmcsr read

Observations: everything seems to be in order, USB is working after resume


During s2idle suspend:

Exactly the same as runtime suspend above. Device transitions into
D3cold and dev->current_state ends up as D3cold. Everything seems to
be in order.


During s2idle resume:

acpi_device_set_power() is called with state=D0
 - acpi_power_transition() is called with state=D0, updates
adev->power.state to D0
 - adev->power.state is updated (again) to D0

pci_raw_set_power_state() is calld with state=D0
 -- dev->current_state is D3cold so no D3 delay happens ***
 -- device fails to transitioned to D0, pmcsr read indicates it's still in D3.

Observations: that's a pretty clear difference between the s2idle
resume and runtime resume paths.
The s2idle resume path is arrived at via pci_pm_default_resume_early()
--> pci_power_up().


Should the s2idle resume path be modified to call into
pci_update_current_state() to change the current_state to D3hot based
on pmcsr (like the runtime resume path does)?
Or should pci_raw_set_power_state() be modified to also apply the
d3_delay when transitioning from D3cold to D0?

Thanks
Daniel
