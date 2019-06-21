Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A344E773
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 13:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfFUL5C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 07:57:02 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41277 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfFUL5B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 07:57:01 -0400
Received: by mail-ot1-f66.google.com with SMTP id 43so1214668otf.8;
        Fri, 21 Jun 2019 04:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohNwUBuR+/PQEekWCi0G2CpYBckWHWNiT6da3G910Dk=;
        b=YS89d12VCSB6YcjX9nvwPv0/SPklqd99XcYhPzwRWBa8qiqugAxy+TCulkzhikm7UK
         RvUilA+yWO6YIg6mhpefrSSBYiaOF1z6LQmziCFjEZ6MLAJ/jyTHT0nAUR7R8bh7w3jL
         eDJNLqRo+HaZySaa3Yfu89BIc27SQQis5njIsaTFvXfRIGgoHEzGSCNk+uc8o/lCGuOr
         hxc73MSv8bMfISa9PsWktXTNsyYIU7hGRsSHtV2AlKHOQdRzVaIZ2W+kBlk1uenzjwov
         wW5vUCwTXc7RqMegoTQmVwNh4IRJUQRGtAK/zx/3tMCZ8l4uqev3l1YSkgA+8RiM4e4R
         uLqA==
X-Gm-Message-State: APjAAAX8f35yaLhNF+99ZQMZkqeBOpUAZTwyi9+oXJr290oYJntrI9lB
        H6+qdDv9gpEb/bOYfwqcP9xyewb7JZGowXFlhho=
X-Google-Smtp-Source: APXvYqxKYJUhbugQHSKSoF+Ajd7wHBUZLt3mxEUY4Wojw635PwBuw56F64oak4f+OpbvbOIBqGMuWjOH1oY1Jk3ehzA=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr12461842otp.189.1561118220987;
 Fri, 21 Jun 2019 04:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com> <20190618161858.77834-2-mika.westerberg@linux.intel.com>
In-Reply-To: <20190618161858.77834-2-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Jun 2019 13:56:49 +0200
Message-ID: <CAJZ5v0huw-n1m3mz2fEk9y2ejQuT4XYeP8_a-iR+epSq5Wu6yQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PCI / ACPI: Use cached ACPI device state to get
 PCI device power state
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 6:19 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>

Actually, to start with, you can say that the ACPI power state
returned by acpi_device_get_power() may depend on the configuration of
ACPI power resources in the system which may change at any time after
acpi_device_get_power() has returned, unless the reference counters of
the ACPI power resources in question are set to prevent that from
happening.  Thus it is invalid to use acpi_device_get_power() in
acpi_pci_get_power_state() the way it is done now and the value of the
power.state field in the corresponding struct acpi_device object
(which reflects the ACPI power resources reference counting, among
other things) should be used instead.

Then you can describe the particular issue below as an example.

IMO that would explain the rationale better here.

> Intel Ice Lake has an integrated Thunderbolt controller which means that
> the PCIe topology is extended directly from the two root ports (RP0 and
> RP1). Power management is handled by ACPI power resources that are
> shared between the root ports, Thunderbolt controller (NHI) and xHCI
> controller.
>
> The topology with the power resources (marked with []) looks like:
>
>   Host bridge
>     |
>     +- RP0 ---\
>     +- RP1 ---|--+--> [TBT]
>     +- NHI --/   |
>     |            |
>     |            v
>     +- xHCI --> [D3C]
>
> Here TBT and D3C are the shared ACPI power resources. ACPI _PR3() method
> returns either TBT or D3C or both.
>
> Say we runtime suspend first the root ports RP0 and RP1, then NHI. Now
> since the TBT power resource is still on when the root ports are runtime
> suspended their dev->current_state is set to D3hot. When NHI is runtime
> suspended TBT is finally turned off but state of the root ports remain
> to be D3hot.
>
> If the user now runs lspci for instance, the result is all 1's like in
> the below output (07.0 is the first root port, RP0):
>
> 00:07.0 PCI bridge: Intel Corporation Device 8a1d (rev ff) (prog-if ff)
>     !!! Unknown header type 7f
>     Kernel driver in use: pcieport
>
> I short the hardware state is not in sync with the software state
> anymore. The exact same thing happens with the PME polling thread which
> ends up bringing the root ports back into D0 after they are runtime
> suspended.
>
> ACPI core already sets the device state to be D3cold when it drops its
> references to the power resources returned by _PR3 even if these power
> resources are still physically on (other devices still reference them).
> However, in PCI core we call acpi_device_get_power() to figure out the
> power state and that returns the "real" power state based on the state
> of its power resources.
>
> To make it work with the shared power resources modify
> acpi_pci_get_power_state() so that it reads the ACPI device power state
> that was cached by the ACPI core. This makes the PCI device power state
> match the ACPI device power state regardless of state of the shared
> power resources that may still be on at this point.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pci-acpi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 1897847ceb0c..b782acac26c5 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -685,7 +685,8 @@ static pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
>         if (!adev || !acpi_device_power_manageable(adev))
>                 return PCI_UNKNOWN;
>
> -       if (acpi_device_get_power(adev, &state) || state == ACPI_STATE_UNKNOWN)
> +       state = adev->power.state;
> +       if (state == ACPI_STATE_UNKNOWN)
>                 return PCI_UNKNOWN;
>
>         return state_conv[state];
> --
> 2.20.1
>
