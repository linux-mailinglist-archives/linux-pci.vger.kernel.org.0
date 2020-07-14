Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE2321EBE3
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgGNIvi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 04:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgGNIvh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 04:51:37 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CD5C061755;
        Tue, 14 Jul 2020 01:51:37 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gc15so849267pjb.0;
        Tue, 14 Jul 2020 01:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xjw4ARtfNtUX/6OkUQ1RIaj9M4+QsmA2dgmi/P58o5o=;
        b=NkIg4XsR5nVcpy39XZ4T/BXz8U7st1zkK0LFOOgho1IiDJHZyrnBFMFdxH9MiqxnIM
         esw76UvNr1LP6pQXcxbhTVNbQWP4KWIPbUoOPzMjYb+uJR24Uf42AsrGFy7l+Z1oYpgg
         qBShjfjhWuf4TCKFgXBxZh7YMoR/UgVCYvdj/z5JF+9PcSX+a+MD3gs/7qoT6Ko5++2L
         2pbI57+HOSZ4h73IAe3KXq1IDMSK5fRkado4j1/DmE1YDXvD6tHUSfCh6NPJkXb43eG8
         VtSbMCaMjsg2sBOXGfmQossSbwiUpSCAkXpuX+5trLIsgiHhNxwle5MFn9R6hhqjpc68
         2C+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xjw4ARtfNtUX/6OkUQ1RIaj9M4+QsmA2dgmi/P58o5o=;
        b=DqIBPusRNyBixgiv8XAPvN5FDp1kLuUkCNPxPfATzOGZyn8TaGxZhOud0PYR4+KeNL
         /WOnqp3ywvU7Gkj/T9zIinBb3NhcvtUXMbYcv7aoMnYrQI944YOd0Tb9VrpFpzj1isZU
         QP62kyPeXwxQi77ZRrMTxbhcwr/wpd2xo7Kh1Jmj3n8ZRpFr9Z38Sg4UXeF7DVEeVTy4
         i5RbqqxMXBmTyKXAkZZNlW7ev8uuaWMtM8RXb98dE2tK5zY7MnMCmWKWIzHpOxHieQXW
         aIOaVj1/x6imLMyERpO19snxL5C5h3nZMOR4RZCXslWFdhT9OuwoOkufKS/5yZLgkry8
         hCGw==
X-Gm-Message-State: AOAM530ESkLLWLfGSViVyQrgnPVOziPPV83+nO7NnM1yedvBi6QffOa+
        A03cxGqmPv3YJFwOFUnVP4LiKoiwdQynlm+ojgM=
X-Google-Smtp-Source: ABdhPJz+U1xrPVMoU1USOz4l4EBn6EDe0LPwWgU9/7mbn/wsc8HtkjzMF0rTv8a85pPLg8q5H1dHIDQhDgyudGGaMa8=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr3631808pjp.228.1594716697098;
 Tue, 14 Jul 2020 01:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200508021844.6911-1-david.e.box@linux.intel.com> <20200714062323.19990-4-david.e.box@linux.intel.com>
In-Reply-To: <20200714062323.19990-4-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jul 2020 11:51:20 +0300
Message-ID: <CAHp75VeueLvou3SEtR=EcTi0x+0qpLz7_cvE2KBXHXa_crS8cA@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] platform/x86: Intel PMT Telemetry capability driver
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 14, 2020 at 9:22 AM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> PMT Telemetry is a capability of the Intel Platform Monitoring Technology.
> The Telemetry capability provides access to device telemetry metrics that
> provide hardware performance data to users from continuous, memory mapped,
> read-only register spaces.
>
> Register mappings are not provided by the driver. Instead, a GUID is read
> from a header for each endpoint. The GUID identifies the device and is to
> be used with an XML, provided by the vendor, to discover the available set
> of metrics and their register mapping.  This allows firmware updates to
> modify the register space without needing to update the driver every time
> with new mappings. Firmware writes a new GUID in this case to specify the
> new mapping.  Software tools with access to the associated XML file can
> then interpret the changes.
>
> This module manages access to all PMT Telemetry endpoints on a system,
> independent of the device exporting them. It creates a pmt_telemetry class
> to manage the devices. For each telemetry endpoint, sysfs files provide
> GUID and size information as well as a pointer to the parent device the
> telemetry came from. Software may discover the association between
> endpoints and devices by iterating through the list in sysfs, or by looking
> for the existence of the class folder under the device of interest.  A
> device node of the same name allows software to then map the telemetry
> space for direct access.
>
> This patch also creates an pci device id list for early telemetry hardware
> that requires workarounds for known issues.

Some more style issues, after addressing feel free to add
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Since you are submitting this the order of the above SoB chain is a
bit strange. I think something like

SoB: Alexander
Co-developed-by: Alexander
SoB: David

is expected (same for patch 2).

...

> +Contact:       David Box <david.e.box@linux.intel.com>
> +Description:
> +               The telem<x> directory contains files describing an instance of
> +               a PMT telemetry device that exposes hardware telemetry. Each
> +               telem<x> directory has an associated /dev/telem<x> node. This
> +               node may be opened and mapped to access the telemetry space of
> +               the device. The register layout of the telemetry space is
> +               determined from an XML file that matches the pci device id and

PCI

> +               guid for the device.

GUID

Same for all code where it appears.

...

> +       psize = (PFN_UP(entry->base_addr + entry->header.size) - pfn) *
> +               PAGE_SIZE;

I wouldn't mind having this on one line.

...

> +static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
> +                        char *buf)

Ditto.

...

> +static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
> +                          char *buf)

Ditto.

...

> +static bool pmt_telem_is_early_client_hw(struct device *dev)
> +{

> +       struct pci_dev *parent;
> +
> +       parent = to_pci_dev(dev->parent);

Can be one line.

> +       return !!pci_match_id(pmt_telem_early_client_pci_ids, parent);
> +}

...

> +               entry->header_res = platform_get_resource(pdev, IORESOURCE_MEM,
> +                                                         i);

One line, please.

-- 
With Best Regards,
Andy Shevchenko
