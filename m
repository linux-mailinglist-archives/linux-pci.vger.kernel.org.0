Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C4645CD3D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 20:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351187AbhKXTer (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 14:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351245AbhKXTeR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 14:34:17 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4ECC06174A
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 11:31:07 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g18so3625714pfk.5
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 11:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vI7SzUj5UovgtfMb+fdADiLIwlcQ1wWC4aPy4AKa9sw=;
        b=0bLuuQ/jE+gTjDQ7ciBE/07ddYj2uqOteQnZLi85uA8MFu8jSoIUYqqJCccGABtrTF
         A78/mVgvstS02fSGtc8JEl33phPEac/WZZL7AmRbJxiWgXhlevV+smf69rNbhc9RoY4L
         OdMXMQpGDvQ1a9+DKKGEyPvaBuy2/gNYEkqQ8m5CtKGOyxog3YkFzqDWpSz+I7i9ZJj9
         8vLtEE+lnvfb/0/3ccZUw9Utcz2RzvdJSyirxLeiHsNBoblVFWtxy0EmtfEs5ixviCGf
         ntc2dts22JJo5BbzkzJhTxcHYc661w25eCwPiOJ5PK8YOuQNmEBR/7RQNLQ7ux9FijIg
         9ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vI7SzUj5UovgtfMb+fdADiLIwlcQ1wWC4aPy4AKa9sw=;
        b=4cMddfePKnfER3dND+a2gavgKC/BVXYPk917tKPg+yhKXtgTktMZNodeHlWDAVSxx4
         7mP7wFChR9SJCcTutKatsw6Qq5SQDMYdHUtgheP/XusSr1r8lYw8GojJo0MO+iW8CXGP
         pb2qV/XrosHbkIpsbo531t37rEUYK9laOBZQsyBTlTlMxDYuMOX7r3E9e+MUdE5blyPH
         B+ekppd+P7i9sb80zyMFPMOfl2DCyiiXetOw674IM+wYG3C2QItx/HMQ4DrHcOcbEqpP
         +0lFcOKXUM2sgnZ8rcz18Gu8zbHOScgk7JppTg91EathOJK6GxUPddEVKocEc2TEQ7i7
         xnig==
X-Gm-Message-State: AOAM531wHKtLbJTua0rlSRvNPs2xDkcwqlfANJvOYQcf00Zv2FZoBDDQ
        3FvBnmR7Q6MALdd5C33gXuRW3rntKTpWs0Wnzr02yw==
X-Google-Smtp-Source: ABdhPJwu4BzXwUzPTOx3eZyuEmi1g/2RqUwz46ZVZuCSxJm6PakajWT8pRAEysCQkiHfpnoiaOBdmQLapQccbnY/QTM=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr8535703pfu.61.1637782266311; Wed, 24
 Nov 2021 11:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com> <20211120000250.1663391-4-ben.widawsky@intel.com>
In-Reply-To: <20211120000250.1663391-4-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 11:30:56 -0800
Message-ID: <CAPcyv4ic827h-WPxU2e1aKu1mVo78aNdNo82skcLW6hqnOnSEQ@mail.gmail.com>
Subject: Re: [PATCH 03/23] cxl/pci: Extract device status check
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 4:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> The Memory Device Status register is inspected in the same way for at
> least two flows in the CXL Type 3 Memory Device Software Guide
> (Revision: 1.0): 2.13.9 Device discovery and mailbox ready sequence,
> and 2.13.10 Media ready sequence. Extract this common functionality for
> use by both.

Can you translate this into CXL specification terms? See below for the
rationale...

>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
> This patch did not exist in RFCv2
> ---
>  drivers/cxl/pci.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index a6ea9811a05b..6c8d09fb3a17 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -182,6 +182,27 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>         return 0;
>  }
>
> +/*
> + * Implements roughly the bottom half of Figure 42 of the CXL Type 3 Memory
> + * Device Software Guide

I do appreciate that document for working through some of the concerns
that system software might have for various CXL flows, but at the same
time it's not authoritative. I.e. it is not a specification itself and
it depends on the CXL specification as the "source of truth". So for
Linux commentary I would translate the guide's recommendations back
into the base truth from the CXL specification.

There will be places where Linux goes a different direction than the
software guide so I do not want to set any expectations that those
excursions are a bug, or otherwise require someone to consult a
specific hardware vendor's software guide.

Especially in this case when the logic is simply "check a couple fatal
status flags", the base specification is sufficient and the original
code made no reference to the guide.

> + */
> +static int check_device_status(struct cxl_dev_state *cxlds)
> +{
> +       const u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +
> +       if (md_status & CXLMDEV_DEV_FATAL) {
> +               dev_err(cxlds->dev, "Fatal: replace device\n");

The specification says "replace device", I disagree that the kernel
should be recommending that the device by replaced. Just report what
the driver does, and that's probably easier if the error messages are
left to the caller.

        const u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);

        if (md_status & (CXLMDEV_DEV_FATAL | CXLMDEV_FW_HALT)) {
                dev_err(dev, "mbox: failed to acquire, device state:%s%s\n",
                        md_status & CXLMDEV_DEV_FATAL ? " fatal" : "",
                        md_status & CXLMDEV_FW_HALT ? " firmware-halt" : "");
                return -EIO;
        }

...i.e. it's not clear to me the helper helps.

> +               return -EIO;
> +       }
> +
> +       if (md_status & CXLMDEV_FW_HALT) {
> +               dev_err(cxlds->dev, "FWHalt: reset or replace device\n");
> +               return -EBUSY;
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * cxl_pci_mbox_get() - Acquire exclusive access to the mailbox.
>   * @cxlds: The device state to gain access to.
> @@ -231,17 +252,13 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
>          * Hardware shouldn't allow a ready status but also have failure bits
>          * set. Spit out an error, this should be a bug report
>          */
> -       rc = -EFAULT;
> -       if (md_status & CXLMDEV_DEV_FATAL) {
> -               dev_err(dev, "mbox: reported ready, but fatal\n");
> +       rc = check_device_status(cxlds);
> +       if (rc)
>                 goto out;
> -       }
> -       if (md_status & CXLMDEV_FW_HALT) {
> -               dev_err(dev, "mbox: reported ready, but halted\n");
> -               goto out;
> -       }
> +
>         if (CXLMDEV_RESET_NEEDED(md_status)) {

I think this check needs to go. If the reset is needed because of one
of the above failure statuses then the function will have already
error exited. If the reset is needed because media is disabled that
should not be fatal for mailbox operations. It could be useful to do
some interrogation of *why* media is disabled.

>                 dev_err(dev, "mbox: reported ready, but reset needed\n");
> +               rc = -EFAULT;
>                 goto out;
>         }
>
> --
> 2.34.0
>
