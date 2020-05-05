Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54BD1C517B
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 11:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgEEJDH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 05:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgEEJDH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 05:03:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282E3C061A0F;
        Tue,  5 May 2020 02:03:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so758006pjw.0;
        Tue, 05 May 2020 02:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mInlraXI6UiuC8jn95iMV/BmULi+g5IjWHS/6IJojzM=;
        b=IY78RnDbIb4vIJKDi/PLt66/Dh6V695zA5RvX6bWp3b/B9B7khhwf0c6SQE21bFn00
         Qs3wubU2MZ7Kxw27FkQj7ZC2AWz4aCnAjcEAGJeVGpzwzCHh2Dx+pSQ9DzBwSFOdRapM
         9fE4FeTJzYHqpcBnQ3S1lM7tjNquUaX/TVZHYhLdXdsfLSsX8YqcZphvOHZ6lY7YAp1G
         A0brcLbn+86QUjcC0KoEXv7Lmwvq0KiMnEEWk5DxNQn2IgeaWNU2bPjhIAuTK/l6Sq1F
         orrUG/yYIkTjlMyUawIRZ6QiEKhEr5/wMTg4nFFkUF/jaAICGCYA0oJtv10M8K2CUzsi
         KApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mInlraXI6UiuC8jn95iMV/BmULi+g5IjWHS/6IJojzM=;
        b=IYKpm81B7WxFcMMCoJXs5p/DPSDbHeUfFk2JOSFrrYdHR9m/ZFuhcCf49CS3b6Xa0b
         bEBffHKmIYh8n4rMVs0lr/enV6+Bfr4evMQ0bK8BVHnRoX2V36jXV3Cv+xYMvrlEpOeX
         zxeZSCqPfuIpcojQaNRLsL2eHUBNN3aaLSFqRVRSEAVrCf5PEI0YhhOo5Xm/C8jIRJAt
         Lyp+mz5em9vXp8+/ZHGy6uNPwIubNKkX8exM8PYMqCCLYKJHeGsq3+apmKasUAjsMjTv
         ovnsRfkfrQO0ftZA5upNlJQbSA3ci+ERQfHAC1NGgFeV9ydDl2Ire5BY1BiB2Kg3dpDN
         UUvQ==
X-Gm-Message-State: AGi0PubAsDXpv3vHklePhnEMcZ72aaS3Gn1wEkQRolFiMaPWFzpXjlIL
        VgimRiL5obUo+UM4eeIWBW0nTvxpoqnDjGYTcrpmZqxW
X-Google-Smtp-Source: APiQypITF/w0OxPtiTL9eJELTK6RfwZPh/h3K8y5+ZC/W+OkZjaBXRq9bYDioiI7rfJPMY51Pd1aRH7pP5lK6p4/mSM=
X-Received: by 2002:a17:90a:224b:: with SMTP id c69mr1767854pje.8.1588669386016;
 Tue, 05 May 2020 02:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200505013206.11223-1-david.e.box@linux.intel.com> <20200505023149.11630-1-david.e.box@linux.intel.com>
In-Reply-To: <20200505023149.11630-1-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 May 2020 12:02:54 +0300
Message-ID: <CAHp75VcX=W3RGZpDVMDot+yfXH-N=gE=Ny7wSTdk33u8MUPjsg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mfd: Intel Platform Monitoring Technology support
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy@infradead.org>,
        alexander.h.duyck@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 5, 2020 at 5:32 AM David E. Box <david.e.box@linux.intel.com> wrote:
>
> Intel Platform Monitoring Technology (PMT) is an architecture for
> enumerating and accessing hardware monitoring facilities. PMT supports
> multiple types of monitoring capabilities. Capabilities are discovered
> using PCIe DVSEC with the Intel VID. Each capability is discovered as a
> separate DVSEC instance in a device's config space. This driver uses MFD to
> manage the creation of platform devices for each type so that they may be
> controlled by their own drivers (to be introduced).  Support is included
> for the 3 current capability types, Telemetry, Watcher, and Crashlog. The
> features are available on new Intel platforms starting from Tiger Lake for
> which support is added. Tiger Lake however will not support Watcher and
> Crashlog even though the capabilities appear on the device. So add a quirk
> facility and use it to disable them.

...

>  include/linux/intel-dvsec.h |  44 +++++++++

I guess it's no go for a such header, since we may end up with tons of
a such. Perhaps simple pcie-dvsec.h ?

...

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8783,6 +8783,11 @@ S:       Maintained
>  F:     arch/x86/include/asm/intel_telemetry.h
>  F:     drivers/platform/x86/intel_telemetry*
>
> +INTEL PMT DRIVER
> +M:     "David E. Box" <david.e.box@linux.intel.com>
> +S:     Maintained
> +F:     drivers/mfd/intel_pmt.c

I believe you forgot to run parse-maintainers.pl --order
--input=MAINTAINERS --output=MAINTAINERS

...

> +       info = devm_kmemdup(&pdev->dev, (void *)id->driver_data, sizeof(*info),
> +                           GFP_KERNEL);

> +

Extra blank line.

> +       if (!info)
> +               return -ENOMEM;
> +
> +       while ((pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC))) {
> +               pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vid);
> +               if (vid != PCI_VENDOR_ID_INTEL)
> +                       continue;

Perhaps a candidate for for_each_vendor_cap() macro in pcie-dvsec.h.
Or how is it done for the rest of capabilities?

> +       }

...

> +static const struct pci_device_id pmt_pci_ids[] = {
> +       /* TGL */

> +       { PCI_VDEVICE(INTEL, 0x9a0d), (kernel_ulong_t)&tgl_info },

PCI_DEVICE_DATA()?

> +       { }
> +};

-- 
With Best Regards,
Andy Shevchenko
