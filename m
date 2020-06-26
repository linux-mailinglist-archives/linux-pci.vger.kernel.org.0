Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1320AD93
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 09:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgFZHxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jun 2020 03:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgFZHxJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jun 2020 03:53:09 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7936EC08C5C1;
        Fri, 26 Jun 2020 00:53:09 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c75so7675270ila.8;
        Fri, 26 Jun 2020 00:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bny++tBIMk54Yvx2zfPmbf+0Ot1GMKL64TsxDOduJ60=;
        b=pi6qOR8sPj7wZ3XcK4gDbT3e2yS9IRpuNkEBpAAyS6vV2vySKo5Vm4MZOHf5dN9/n6
         rZDPHSot2GRbxX/1REKPttlo+Gzk75IZceDEaIfFmYI8QXZB1LQg8qHLSxJxDsLKnxml
         l0cwdUTYDBeOKmNiN4Q4pARW90E2EoDrX3YkT0CSSeeqdi8A0SGs3Dqcl9ovEFyfi1Yx
         sZGDoFNouIlleCmILazYchvNRfPX6sKs4K/xW6F/9FmIvA1+S+9jyKRggl7PqLJFkorf
         Tag+SsZRh2Zu+9n87emt6epFAkp6mqih/EHD8iJ4U29ckOKIHgwgJgpsK2LVXpMVVvS2
         lXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bny++tBIMk54Yvx2zfPmbf+0Ot1GMKL64TsxDOduJ60=;
        b=Hhzt0zP5r/Kxye18duo+JQp43ScS7S9zmfVj8CYLv81mF/Oj75InOTqI4fQ5WPSnXl
         gKQ52UdqiVXlS8NXxGaajuHUdy0iMuDOMOzdG1Jcq/Yl/XzMn4cIBopypU/Yo0m82Ohp
         UjL5okbooUnjFyurHENxkAKMCaStyDbOl22aUVBnDwd/Ben/d6+UpAD9qpFowwIzVZZA
         xoCIEyQx2WCelSA3b7+STUeQOOCFVUtl3QNunMHOFD5qWIhq5W4/LQpgmzuB8OrlIWbi
         ukJS5w3VWlxSJ6yW/HbU4/volUWiNFCKeCwDc1h3jWcqbPS27A7LDU8Ht3xrvFkInUwH
         CAXA==
X-Gm-Message-State: AOAM531t/dniUs/GEsQZWVQgy4sTo9EMXwgZhnBrQUkJ3AoPd7fAnEm/
        s5mKrbAG+mDn4N9iowRq8Y6W5vgI6fjnwAUOybw=
X-Google-Smtp-Source: ABdhPJxWukgYdKg85VYa/UxfpvGS2QookcbFIPNFv/QZkXY9QvIFnKJ30Qho5lEy3R+IADOlR2rMSdIe2qRRQsQNYrE=
X-Received: by 2002:a92:5e17:: with SMTP id s23mr1766973ilb.149.1593157988638;
 Fri, 26 Jun 2020 00:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200626002710.110200-1-rajatja@google.com> <20200626002710.110200-2-rajatja@google.com>
In-Reply-To: <20200626002710.110200-2-rajatja@google.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 26 Jun 2020 17:52:57 +1000
Message-ID: <CAOSf1CHwj7qD6CdZ+AnY3s1JQXvO0eAG5CgoSHAUBGjtZ6+QfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pci: Add parameter to disable attaching untrusted devices
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 26, 2020 at 10:27 AM Rajat Jain <rajatja@google.com> wrote:
>
> Introduce a PCI parameter that disables the automatic attachment of
> untrusted devices to their drivers.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> Context:
>
>   I set out to implement the approach outlined in
>     https://lkml.org/lkml/2020/6/9/1331
>     https://lkml.org/lkml/2020/6/15/1453
>
>   But to my surprise, I found that the new hotplugged PCI devices
>   were getting automatically attached to drivers even though
>   /sys/bus/pci/drivers_autoprobe was set to 0.
>
>   I realized that the device core's "drivers_autoprobe":
>
>   * only disables the *initial* probe of the device (i.e. from
>     device_add()). If a subsystem calls device_attach() explicitly
>     for its devices like PCI subsystem does, the drivers_autoprobe
>     setting does not matter. The core will attach device to the driver.
>     This looks like correct semantic behavior to me because PCI is
>     explicitly calling device_attach(), which is a way to explicitly
>     ask the core to find and attach a driver for a device.

Right, but we're doing using device_attach() largely because the
driver core doesn't provide any mechanism for deferring the initial
probe. I didn't think there was any deeper reason for it, but while
looking I noticed that the initial probe can be async and
device_attach() forces probing to be synchronous. That has the side
effect of serialising all PCI device probing which might be
intentional to avoid device renaming due to the change in probe order.
Userspace is better at dealing with device names changing now days,
but you might still get some people mad at you for changing it.

>   2) Make the drivers_autoprobe property available to PCI to use
>      (currently it is private to device core). The PCI could use this
>      to determine whether or not to call device_attach(). This still
>      leaves the other problem (of not being able to set
>      drivers_autoprobe via command line open).
>
>   3) I found the pci_dev->match_driver, which seemed similar to what I
>      am trying to do, but can't be controlled from userspace. I considered
>      populating that field based on drivers_autoprobe (still need (2)).
>      But the problem is that there is the AMD IOMMU driver which is setting
>      this independently, so setting the match_driver based on
>      drivers_autoprobe may not be a good idea.

Huh, that's pretty weird. Even with that hack you should be able
trigger the bug they're working around by removing the IOMMU device in
sysfs and doing a rescan. I wouldn't worry much about making
match_device user controllable since you would need to work pretty
hard for it to be an issue.

Oliver
