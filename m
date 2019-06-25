Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8BA54E98
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 14:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfFYMPv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 08:15:51 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39191 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbfFYMPv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 08:15:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so17008854otq.6;
        Tue, 25 Jun 2019 05:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIbsH3hp6bu3RzFDqTmIuPsmLwewvALzYa+bQ8UjkUk=;
        b=Gmblsfdjr12+MCQy8qdtztg7mbluhtuOhKqCgBvJBBB+Do8yWxHpuyF9CaDAiPxftK
         ZaEEP8p2pc5Q8WEaMrhgys8SznNFLA+wWefqySKEMKlnPuArZSQVdDK42IQhNuaEaknm
         Y2EKLajkAcAn9MdyPmdJxz2RD4bOTmR7+Pkec0604xQBCDLFJM9vlu94WgxJdeX9U5r2
         2j3Qt0R/ti/YMypOaw5gWTOzYdknjqEpC+FJ8y0xcAQTWf6rszrNnVm1lJ169ebWD8BV
         JpWTvyEw0na1vLiSen6Ef2/QdGH8LFbmLjLm86AkWw01akCyAilwGdE0k9CdFa2zHqTb
         G/WA==
X-Gm-Message-State: APjAAAXMCQJBAeshIaC9As4zIqNlsffSgXX3mns/b6D1zKKKINUbfPy3
        ReZ6nQJc6KB+/7xKvEw7KOgFY52EAThgl+OxPJE=
X-Google-Smtp-Source: APXvYqzFzcCDMo6ZW1+1hQo04s4KJozMrwxv5PnZsQRQ5UqOX2hK5qpnSe4PW7QhVQuWzXsk9nFF2/5WLEhUnNu5PMQ=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr28132910otp.189.1561464950932;
 Tue, 25 Jun 2019 05:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190625102942.27740-1-mika.westerberg@linux.intel.com> <20190625102942.27740-2-mika.westerberg@linux.intel.com>
In-Reply-To: <20190625102942.27740-2-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jun 2019 14:15:39 +0200
Message-ID: <CAJZ5v0g5eZBdtuq94TDOu2Q-znLYczXswWq9cFwc_=iR5apKVQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PCI / ACPI: Use cached ACPI device state to get
 PCI device power state
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Tue, Jun 25, 2019 at 12:30 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> The ACPI power state returned by acpi_device_get_power() may depend on
> the configuration of ACPI power resources in the system which may change
> any time after acpi_device_get_power() has returned, unless the
> reference counters of the ACPI power resources in question are set to
> prevent that from happening. Thus it is invalid to use acpi_device_get_power()
> in acpi_pci_get_power_state() the way it is done now and the value of
> the ->power.state field in the corresponding struct acpi_device objects
> (which reflects the ACPI power resources reference counting, among other
> things) should be used instead.
>
> As an example where this becomes an issue is Intel Ice Lake where the
> Thunderbolt controller (NHI), two PCIe root ports (RP0 and RP1) and xHCI
> all share the same power resources. The following picture with power
> resources marked with [] shows the topology:
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
> of the devices in question returns either TBT or D3C or both.
>
> Say we runtime suspend first the root ports RP0 and RP1, then NHI. Now
> since the TBT power resource is still on when the root ports are runtime
> suspended their dev->current_state is set to D3hot. When NHI is runtime
> suspended TBT is finally turned off but state of the root ports remain
> to be D3hot. Now when the xHCI is runtime suspended D3C gets also turned
> off. PCI core thus has power states of these devices cached in their
> dev->current_state as follows:
>
>   RP0 -> D3hot
>   RP1 -> D3hot
>   NHI -> D3cold
>   xHCI -> D3cold
>
> If the user now runs lspci for instance, the result is all 1's like in
> the below output (00:07.0 is the first root port, RP0):
>
> 00:07.0 PCI bridge: Intel Corporation Device 8a1d (rev ff) (prog-if ff)
>     !!! Unknown header type 7f
>     Kernel driver in use: pcieport
>
> In short the hardware state is not in sync with the software state
> anymore. The exact same thing happens with the PME polling thread which
> ends up bringing the root ports back into D0 after they are runtime
> suspended.
>
> For this reason, modify acpi_pci_get_power_state() so that it uses the
> ACPI device power state that was cached by the ACPI core. This makes the
> PCI device power state match the ACPI device power state regardless of
> state of the shared power resources which may still be on at this point.
>
> Link: https://lore.kernel.org/r/20190618161858.77834-2-mika.westerberg@linux.intel.com
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

Not that there are two additional issues related to the one fixed by
this patch that need to be addressed differently.

For details, see

https://patchwork.kernel.org/patch/11015379/
https://patchwork.kernel.org/patch/11015391/
