Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E6C1F4AE9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 03:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgFJBeV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 21:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgFJBeU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 21:34:20 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2BAC05BD1E;
        Tue,  9 Jun 2020 18:34:20 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d5so358064ios.9;
        Tue, 09 Jun 2020 18:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4aH15SSO22KRv//RjmrlnG6X17+Svv1DvzlLOVYd3o=;
        b=ngW+kKhf6SJziSfTZxxL1vNqjFom7hR4s8X5dKIgSrGLPkxXs6wCdBfRQGBtTVRK36
         zYnUTutj8F0hMquKcz4NFDLCE78ekqy1E3wyRLtad+MT1uFKqrBmrxObe906H2J2xaLB
         bGhShr7/lQ8d93ms4GpqM55lPr8iGTNBFovmwJuNAO4nkLXsXCl74MBFcX7cQ6JdDZuq
         eLYVcam3zXwvINE2GUyUM31tmZm+M7KEqNWgIyq4CdRAPtMJmyTUwNeynK6QuDzRdid6
         TRs1If3lM8Mv3gBb5Fk9t4qCDo4qhHvOGj6gBaRYHxfJsnFUyqRJA7fbDZqYlNlMvReh
         pFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4aH15SSO22KRv//RjmrlnG6X17+Svv1DvzlLOVYd3o=;
        b=t+RQ8dJ7+gxpsCdwmAbIdFUFqS0CrUNPo/GnkqqmWG0HzjIHYbabe/4mKBi6D03PUz
         kCc/55ZPCk43yOlEm2K+gMEzUXZd8YIczxISMZbSbIfomo1rjEIQ6873tCAOaIlOmK45
         Ay/xuFBMhtPqgfNLBBo0vRihtJM4pyFFsX9RlUQdLNBgGaK9gvOF2CSZ7mWNIPmWDYxs
         N37NahaUgbN9ColtHtt8wRML+kQlCJIns6d5aZ2h+f9WqNx7XyoPpkiZt2wTUzW4aIs6
         89Iuewk8U7LXdGZDEqHO+n6F1SaNxvWfOVRdF1VWuTdxdR3jtUfcMcS5ymR8cK08QwBp
         O6IA==
X-Gm-Message-State: AOAM531EBru0nKYye4RaOgGg2wqQGKyaXq6By80ypJamzk+VkB364Pk6
        WrtQefgNpZYHRvEYhoG/lZFZ0uwo5gcd7XlznLk=
X-Google-Smtp-Source: ABdhPJwEMTnnLXlPXBnlrmuAt383evVY9uUlUpumRO3Nas7YGaGR+fO7L1y902PECLdfkFXgVneS4zHjpxOHXTP6mVE=
X-Received: by 2002:a05:6602:1647:: with SMTP id y7mr977606iow.75.1591752859010;
 Tue, 09 Jun 2020 18:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200607113632.GA49147@kroah.com> <20200609210400.GA1461839@bjorn-Precision-5520>
In-Reply-To: <20200609210400.GA1461839@bjorn-Precision-5520>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 10 Jun 2020 11:34:06 +1000
Message-ID: <CAOSf1CGMwHGSn18MeKYr2BESfLwq3Q8_0fC6yhiQRrAXeSosqQ@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 10, 2020 at 7:04 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> To sketch this out, my understanding of how this would work is:
>
>   - Expose the PCI pdev->untrusted bit in sysfs.  We don't expose this
>     today, but doing so would be trivial.  I think I would prefer a
>     sysfs name like "external" so it's more descriptive and less of a
>     judgment.
>
>     This comes from either the DT "external-facing" property or the
>     ACPI "ExternalFacingPort" property.

I don't think internal / external is the right distinction to be
making. We have a similar trust issue with the BMC in servers even
though they're internal devices. They're typically network accessible
and infrequently updated so treating them as trustworthy isn't a great
idea. We have been slowly de-privileging the BMC over the last few
years, but the PCIe interface isn't locked down enough for my liking
since the SoCs we use do allow software to set the VDID and perform
arbitrary DMAs (thankfully limited to 32bit). If we're going to add in
infrastructure for handling possibly untrustworthy PCI devices then
I'd like to use that for BMCs too.

>   - All devices present at boot are enumerated.  Any statically built
>     drivers will bind to them before any userspace code runs.
>
>     If you want to keep statically built drivers from binding, you'd
>     need to invent some mechanism so pci_driver_init() could clear
>     drivers_autoprobe after registering pci_bus_type.
>
>   - Early userspace code prevents modular drivers from automatically
>     binding to PCI devices:
>
>       echo 0 > /sys/bus/pci/drivers_autoprobe
>
>     This prevents modular drivers from binding to all devices, whether
>     present at boot or hot-added.

I don't see why this is preferable to just disabling autoprobe for
untrusted devices. That would dovetail nicely with Rajat's whitelist
idea if we want to go down that route and I think we might want to.
The BMC usually provides some form of VGA console and we'd like that
to continue working out-of-the-box without too much user (or distro)
intervention.

Oliver
