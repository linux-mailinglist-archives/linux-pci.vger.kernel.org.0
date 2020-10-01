Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C768B280365
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 18:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732360AbgJAQBT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 12:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbgJAQBT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 12:01:19 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C451EC0613D0;
        Thu,  1 Oct 2020 09:01:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 197so4358607pge.8;
        Thu, 01 Oct 2020 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BT+mSaBhy+x60yncvZYPTuqegplR6LX7kQt6UIW6QY=;
        b=uiz+6SVYOhHTocEk07NmkueAfxTx+uEgUcmr/tRlOPSy99Z4WVtmomMXinJOOVzJlw
         U6yjFflYzGXiTAM7X7f4fwsK0/l5PLQA9q7p66i3OcSGGGrfwY7eE5gope/ZKRa7aiYb
         ciaq9GdC9NcxGwdlAEMd2BUa7J4KhmM+Qe2c9AJl24N1I+GNw8Ifgl47ap64Y24TvxT2
         uQsXbpUxCMF2dWEJ5QYNHWiyiEYtLWz82gOP2Ou2XMwfl/vr2qR+TrMNIVjOovHOmC8I
         I6AdpJUBIqk1UfhjZUL8ywpxjDeFLf6HbOPwwaWDexo4JwQdKoOsQCzxtKrBVlG0k0nu
         qFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BT+mSaBhy+x60yncvZYPTuqegplR6LX7kQt6UIW6QY=;
        b=FFX7+ucfnZn04MtyTAIyPF/8vJITM6sfTKMXWZM0Gwi9o6jCAxEDpUjBC3wxilV2N5
         PfGDmoyDInbDl3aqGwTsJeCjgK968ZS9ETerQHSnsmx5yMZ46B/3uGi9ZC5Eynz+a8Se
         oLS8X2QEH31aV6Be+1TH4MU2XNwNnoezyhMQAqFh8q//x2cQQyT13Je56SdWShUT68KL
         7YVU0oiojLkSpMhhNDZbjpaU8NRXaUsSoHlfpQNANI9UN/RkHd+b/CuLC9+olR6cG3Us
         NAIf7x7SrlyIbLc4/jYBatv/cFPn0q6Oy/QG8O0J4sEbl6O+rcEguweD1i+ubUuevKUl
         +ihA==
X-Gm-Message-State: AOAM531U2VA9fvN6QimlpPdhdl7yJ1KcKoQHRLFi4064QPzmT4x1UNcl
        V9mN0arRnmMdGvYkThK1czq5ep+S/Hq/uouGMxM=
X-Google-Smtp-Source: ABdhPJzVMReb2G/hBmJ5iwEAzORaIOh+ApRwc+ssYpSff8yc93mXT/iCELWHcknEK9zsoAQZyDxwLEaDPGVoAVyZ3hE=
X-Received: by 2002:a63:4c1d:: with SMTP id z29mr6847757pga.203.1601568077262;
 Thu, 01 Oct 2020 09:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201001014250.26987-1-david.e.box@linux.intel.com> <20201001014250.26987-5-david.e.box@linux.intel.com>
In-Reply-To: <20201001014250.26987-5-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Oct 2020 19:00:58 +0300
Message-ID: <CAHp75VfcXbedZbbF3KATWYMR1SPXusuaU+vrkvM1zsRpYzDFiA@mail.gmail.com>
Subject: Re: [PATCH V7 4/5] platform/x86: Intel PMT Telemetry capability driver
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alexey.budankov@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 1, 2020 at 4:43 AM David E. Box <david.e.box@linux.intel.com> wrote:
>
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
> PMT Telemetry is a capability of the Intel Platform Monitoring Technology.
> The Telemetry capability provides access to device telemetry metrics that
> provide hardware performance data to users from read-only register spaces.
>
> With this driver present the intel_pmt directory can be populated with
> telem<x> devices. These devices will contain the standard intel_pmt sysfs
> data and a "telem" binary sysfs attribute which can be used to access the
> telemetry data.

...

> +static DEFINE_XARRAY_ALLOC(telem_array);
> +static struct intel_pmt_namespace pmt_telem_ns = {
> +       .name = "telem",
> +       .xa = &telem_array

Leave comma at the end.

> +};
> +
> +/*
> + * driver initialization
> + */

This is a useless comment.

> +       size = offsetof(struct pmt_telem_priv, entry[pdev->num_resources]);
> +       priv = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;

Please, use struct_size() from overflow.h instead of custom approach.

...

> +static struct platform_driver pmt_telem_driver = {
> +       .driver = {
> +               .name   = TELEM_DEV_NAME,

I'm not sure I have interpreted this:
        - Use 'raw' string instead of defines for device names
correctly. Can you elaborate?

> +       },
> +       .remove = pmt_telem_remove,
> +       .probe  = pmt_telem_probe,
> +};

...

> +MODULE_ALIAS("platform:" TELEM_DEV_NAME);

Ditto.

--
With Best Regards,
Andy Shevchenko
