Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E7C2D8291
	for <lists+linux-pci@lfdr.de>; Sat, 12 Dec 2020 00:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394148AbgLKXDv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 18:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407107AbgLKXC7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2020 18:02:59 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8AFC0613CF;
        Fri, 11 Dec 2020 15:02:19 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id y17so10561804wrr.10;
        Fri, 11 Dec 2020 15:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LTxPPsztZTl4FGNOxgLF76+yr/h5WOwv1BKw/jgT64Y=;
        b=JHbQfFUwMwpHTgG0mvCHMZ8xprAK+Wde4tRb8oqqrXhmu6eOF9V5xR5uOiFhGzxnEB
         UKeYc6mVNA2dN3k3pgqEGD/36SSAQe/vpZrIoZlt5tfvyA4kVFZV03N1920n798cQ+RA
         WmERuLHr9lmy+qkXwiLkJmxeULkQmlFk0/GQYBxO1SyiAWO4Z+CY27neNHJpGbaLACQT
         u4gLY/+x31XW4LJ+07FCZuysBsJxaYzc7gyProA0x+ZyKK+Cu4VSTuVVNoXwgsaP24tq
         WCnscP0ocLPx8z+Td3h27+8ElcS+LHwhkDTD4ts8TVgbuHSQvv+umTKn5a3LtNCsu1sR
         SLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LTxPPsztZTl4FGNOxgLF76+yr/h5WOwv1BKw/jgT64Y=;
        b=kyoC6kBzrUQdv+HHkLnAQ0h+VFBzTfSUBVfPdltOCDbGNSJ4+AgxYqbdXNNyct7d3t
         Z3PvzypPgWlzRYN/FfLg4lVYvvn07Rco+n7S0qDb7+QDuC+LFWBaSgeyvtZzd9kP7Ez6
         S+3R+Doy3W53VTXGSbxVHqIY0MX6RoLeAeJ0nrUlZMhXWWW8gMNpXDr4y/b8JslkzgtF
         knbTZVHtdBE2uZWqvP1C0xyFoqRnJFMHW1ZdLwMrRwCimwDwW1H1M5XMv5MFoqrRdwTD
         tQZ2WSjbUu5rmpxuxWqCmNJ6j8p1aR1G01EOYMBPoxlrxHKn31Ei2ljVp1gmLeqdfJE3
         lAIA==
X-Gm-Message-State: AOAM5328OKav+CGMS/l8dbaRqbxKHtMSAsJjsrxHVHYKJ436beaxACXA
        sgvWjqYVmUjKN/0gBv3jq3g=
X-Google-Smtp-Source: ABdhPJy98MsLCOKGUUX/bPz1hEDiErl/lR9gHqtfBXCimMRPjP6TgHfV6WgiPPseaOl//TnenPUIYQ==
X-Received: by 2002:a5d:4f82:: with SMTP id d2mr12081017wru.87.1607727738346;
        Fri, 11 Dec 2020 15:02:18 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id z64sm16027874wme.10.2020.12.11.15.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 15:02:17 -0800 (PST)
Subject: Re: [PATCH] PCI: ACPI: Fix up ACPI companion lookup for device 0 on
 the root bus
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <4673285.9aE2nYKHPr@kreacher>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <235b2ffd-0142-76e7-6967-e5e0aa9afbfd@gmail.com>
Date:   Fri, 11 Dec 2020 23:02:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4673285.9aE2nYKHPr@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/12/2020 20:17, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> In some cases acpi_pci_find_companion() returns an incorrect device
> object as the ACPI companion for device 0 on the root bus (bus 0).
>
> On the affected systems that device is the PCI interface to the
> host bridge and the "ACPI companion" returned for it corresponds
> to a non-PCI device located in the SoC (e.g. a sensor on an I2C
> bus).  As a result of this, the ACPI device object "attached"
> to PCI device 00:00.0 cannot be used for enumerating the device
> that is really represented by it which (of course) is problematic.
>
> Address that issue by preventing acpi_pci_find_companion() from
> returning a device object with a valid _HID (which by the spec
> should not be present uder ACPI device objects corresponding to
> PCI devices) for PCI device 00:00.0.
>
> Link: https://lore.kernel.org/linux-acpi/1409ba0c-1580-dc09-e6fe-a0c9bcda6462@gmail.com/
> Reported-by: Daniel Scally <djrscally@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Tested and confirmed working on my devices - thanks.


Tested-by: Daniel Scally <djrscally@gmail.com>

Reviewed-by: Daniel Scally <djrscally@gmail.com>


> ---
>  drivers/pci/pci-acpi.c |   20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -1162,14 +1162,32 @@ void acpi_pci_remove_bus(struct pci_bus
>  static struct acpi_device *acpi_pci_find_companion(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	struct acpi_device *adev;
>  	bool check_children;
>  	u64 addr;
>  
>  	check_children = pci_is_bridge(pci_dev);
>  	/* Please ref to ACPI spec for the syntax of _ADR */
>  	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
> -	return acpi_find_child_device(ACPI_COMPANION(dev->parent), addr,
> +	adev = acpi_find_child_device(ACPI_COMPANION(dev->parent), addr,
>  				      check_children);
> +	/*
> +	 * There may be ACPI device objects in the ACPI namespace that are
> +	 * children of the device object representing the host bridge, but don't
> +	 * represent PCI devices.  Both _HID and _ADR may be present for them,
> +	 * even though that is against the specification (for example, see
> +	 * Section 6.1 of ACPI 6.3), but in many cases the _ADR returns 0 which
> +	 * appears to indicate that they should not be taken into consideration
> +	 * as potential companions of PCI devices on the root bus.
> +	 *
> +	 * To catch this special case, disregard the returned device object if
> +	 * it has a valid _HID, addr is 0 and the PCI device at hand is on the
> +	 * root bus.
> +	 */
> +	if (adev && adev->pnp.type.platform_id && !addr && !pci_dev->bus->parent)
> +		return NULL;
> +
> +	return adev;
>  }
>  
>  /**
>
>
>
