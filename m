Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121A61CA79D
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 11:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgEHJ6A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 05:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgEHJ57 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 05:57:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A475CC05BD43;
        Fri,  8 May 2020 02:57:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n11so642133pgl.9;
        Fri, 08 May 2020 02:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjZGpQQz1E9D9ntXLHWSOTiEsgDXrE90sF5Lmj5BRhk=;
        b=IG6gEzq/4wkHGOnuFiRCuqpEn/oZQmz9LbjBV+72nxibg+wBRustulpwUu9JcC/8y/
         0Yo9cfi0ODAx6reFBqsva5aHFrBEMYjwSOEc2Y5drUHOubr1pEm4JaGBkZQDNj4QONiw
         GMG47Dryv+hDCR1RpY9sORJoGVLHRGlZmm0hTh63iXlOoLSTlKSRvHO+OU2ml7VSe1rG
         LrPS4fxehkBLT4YEwjGQRYX9cfjbc2qfqLd6i9IrI7pU36R+b1GMMSjNjvFzRkCxxH2n
         /hwC5aUnorfR8LNkoTvkaGhdthhS1ogX8loZhLokbhj/dL+VXcsKUX0BhrW3f5sxtiE2
         ardw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjZGpQQz1E9D9ntXLHWSOTiEsgDXrE90sF5Lmj5BRhk=;
        b=dtoBV5GUymBoudb02Zdgif+qDZBM+YunHkCS3C1Il1rTz3oLxOOgacrzoCXMAjj3jA
         VpKxD/duGuqRfl52PNKzFWNEJnGtQZa8Z69vZte/tbSwwLW8aZdFFZn+9niNQPr+R2xo
         QobLRRNoV3Vn6nH//GJCxiW8csQCpF3i2I6Cxch+gf7T6IywtwttVqCoX3FNHwgf2tTD
         Oiif/pQ+YFdY1h891RvRE7dXw8m2ohoncnje4D5llxlFK4JjCOy1RX2qahW3zqeXjcoT
         VEpZdKxrHJ3L0I6xYLL6TQe9aP06yzrWzYc9WRSxdrvVgSiD4VI7XeQa465w0E0hh4e9
         xK4Q==
X-Gm-Message-State: AGi0PuYqRdOh95Tqo1RpUQmTNZ40z6rwDNMYH0uYZeE4AhhOuhIOUQoF
        k7DPi3+lKTbEm2lxuiYQZ9E7uo2olV89J0N9ywQ=
X-Google-Smtp-Source: APiQypL3/5fd22LIgXmXE3iL/j4DrPu8BdoW+eTHqcCp83dwGfjU04MNFVRjyGB8kNkcgW5FVXV58TrGPdMjdx+5pLY=
X-Received: by 2002:a62:5ec7:: with SMTP id s190mr1978432pfb.130.1588931879077;
 Fri, 08 May 2020 02:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200505013206.11223-1-david.e.box@linux.intel.com> <20200508021844.6911-4-david.e.box@linux.intel.com>
In-Reply-To: <20200508021844.6911-4-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 May 2020 12:57:52 +0300
Message-ID: <CAHp75VcrjFUgUe6Vo8baT969cGzE4MFX6pFL1Vr5HOun=Cm0fA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] platform/x86: Intel PMT Telemetry capability driver
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 8, 2020 at 5:18 AM David E. Box <david.e.box@linux.intel.com> wrote:
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
> regardless of the device exporting them. It creates a pmt_telemetry class
> to manage the list. For each endpoint, sysfs files provide GUID and size
> information as well as a pointer to the parent device the telemetry comes
> from. Software may discover the association between endpoints and devices
> by iterating through the list in sysfs, or by looking for the existence of

ABI needs documentation.

> the class folder under the device of interest.  A device node of the same
> name allows software to then map the telemetry space for direct access.

...

> +config INTEL_PMT_TELEM

TELEMETRY

...

> +obj-$(CONFIG_INTEL_PMT_TELEM)          += intel_pmt_telem.o

telemetry

(Inside the file it's fine to have telem)

...

> +       priv->dvsec = dev_get_platdata(&pdev->dev);
> +       if (!priv->dvsec) {
> +               dev_err(&pdev->dev, "Platform data not found\n");
> +               return -ENODEV;
> +       }

I don't see how is it being used?

--
With Best Regards,
Andy Shevchenko
