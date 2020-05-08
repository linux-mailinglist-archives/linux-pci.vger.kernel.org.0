Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265421CA6E0
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 11:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgEHJPb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 05:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgEHJPa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 05:15:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6B6C05BD43;
        Fri,  8 May 2020 02:15:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h12so5012469pjz.1;
        Fri, 08 May 2020 02:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKkhrk4E3z/J/HnHCF+SvfVo/ybkk/5bCJ0Ex8N1MvU=;
        b=fhKmMGbVL5IEtAFU/YkO2oimO/cRAHn6wTWXCQ0mGA2e7ztddgwBAdtlgaxkRHSxWL
         xCWrCWW7lJVp/58LIr+Rm86UxKPBoFpVlrt+kXuAyq8JV1l4UBy0GUCe918PbhQgtkz+
         1yHlkxms/5j9t2FTgkg/OwaaGEe2SwUEQ/vLyJFvZnKDOgh27pM0pBEBp46zRCsexsbN
         JhU39a3nbvt/dU1cN6XEQi5xS3EqmuybwNBzyZdyO9R7Z5vzBI17urZ777ADjYM8ey0j
         Y0T1wMEH7vxKappxfKGywd/lNlfMQ65xFCG7FSw2ymM1qneljIyMBKvX9/qThPyUgrIW
         /NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKkhrk4E3z/J/HnHCF+SvfVo/ybkk/5bCJ0Ex8N1MvU=;
        b=pqJctcST/92XUUnC3DtBkjsjrDFmdBYDAjLaj1+P3lKX8GWAvNYBX4XMVq2mtQNXNO
         S1/F7klVKYEx18QSew8hBpRLwOWExetjGpN/ZMLxReinuh+v7n3HJlD1xDBy8ms1uBix
         xTdv7Fb4YmZK1FMUQZ47SWIdZVCRSFUT3+rP8xMyeWFGCugckSk666Dueaa0e8rcfVe0
         M/08AjyehPyj1bTmsWYNlYC5o8dqbO+ljrOZNHEVmtJybHLhTJGH8XCd9jmL6pwdsjpp
         t1gAK894MGvYFcbCigykVboWSAuz3O9/YadrI3Swh9HQ4wG6E/XiP52z+AhU7iinR4Xa
         +2HA==
X-Gm-Message-State: AGi0Puabln7FMQh/rC7nE3Ne+udwJqTe3mLzwiOXlBxZSr+MwBx6RcC3
        ej0na464x3UG2N7mQF8rzMBIMBQcRZOFR/7ir5tuKjto
X-Google-Smtp-Source: APiQypKpSxKXrTzyvk2KxnwclHCHT/1cEx9yoOzaFS1C2ETvpqiB6XHhII+kyjQVi+6e4b/JoeAtZSdZ8XXV4y7eWlg=
X-Received: by 2002:a17:90b:94a:: with SMTP id dw10mr5133773pjb.228.1588929329467;
 Fri, 08 May 2020 02:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200505013206.11223-1-david.e.box@linux.intel.com> <20200508021844.6911-3-david.e.box@linux.intel.com>
In-Reply-To: <20200508021844.6911-3-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 May 2020 12:15:22 +0300
Message-ID: <CAHp75VfSUFh5rtieJZnfjTJCTpmONHGu3R_T0xU3CnuFv80x7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mfd: Intel Platform Monitoring Technology support
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
> Intel Platform Monitoring Technology (PMT) is an architecture for
> enumerating and accessing hardware monitoring facilities. PMT supports
> multiple types of monitoring capabilities. This driver creates platform
> devices for each type so that they may be managed by capability specific
> drivers (to be introduced). Capabilities are discovered using PCIe DVSEC
> ids. Support is included for the 3 current capability types, Telemetry,
> Watcher, and Crashlog. The features are available on new Intel platforms
> starting from Tiger Lake for which support is added. Tiger Lake however
> will not support Watcher and Crashlog even though the capabilities appear
> on the device. So add a quirk facility and use it to disable them.

Thank you for an update.
Some nitpicks below.

...

> +       case DVSEC_INTEL_ID_TELEM:

Is this from the spec? Or can we also spell TELEMETRY ?

> +               name = TELEM_DEV_NAME;

Ditto for all occurrences.

> +               break;

...

> +       cell = devm_kcalloc(&pdev->dev, header->num_entries,
> +                           sizeof(*cell), GFP_KERNEL);

I think if you use temporary
  struct device *dev = &pdev->dev;
you may squeeze this to one line and make others smaller as well.

> +       if (!cell)
> +               return -ENOMEM;

...

> +               res->start = pdev->resource[header->tbir].start +
> +                            header->offset +
> +                            (i * (INTEL_DVSEC_ENTRY_SIZE << 2));

Outer parentheses are redundant. And perhaps last two lines can be one.

...

> +static int
> +pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +       u16 vid;
> +       u32 table;

> +       int ret, pos = 0, last_pos = 0;

Redundant assignment of pos.

> +       while ((pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC))) {
> +               pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vid);
> +               if (vid != PCI_VENDOR_ID_INTEL)
> +                       continue;
> +

> +               last_pos = pos;

Can we simple use a boolean flag?

> +       }
> +
> +       if (!last_pos) {
> +               dev_err(&pdev->dev, "No supported PMT capabilities found.\n");
> +               return -ENODEV;
> +       }

> +}

...

> +};

> +

Extra blank line.

> +module_pci_driver(pmt_pci_driver);

...

+ bits.h since GENMASK() is in use.

> +#include <linux/types.h>

...

> +enum pmt_quirks {
> +       /* Watcher capability not supported */
> +       PMT_QUIRK_NO_WATCHER    = (1 << 0),

BIT() ?

> +
> +       /* Crashlog capability not supported */
> +       PMT_QUIRK_NO_CRASHLOG   = (1 << 1),

BIT() ?

> +};

-- 
With Best Regards,
Andy Shevchenko
