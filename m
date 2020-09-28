Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCBB27A9E5
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 10:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgI1Iqq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 04:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1Iqq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 04:46:46 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DF4C0613CE;
        Mon, 28 Sep 2020 01:46:46 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e18so270403pgd.4;
        Mon, 28 Sep 2020 01:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=brpxKwQZ9NEyo3kql+ZLUvVmIiQJFbmnCGpOp8iZFjQ=;
        b=gyYGGdnfbz+QxrRGNNYeoI+2JeIwQOuoFC+gx9buN+/94EYOMnCDfuCkPltjirMcxK
         sRNgp+3WDPt3+yOl9vmC4+BYwG5mXkugoglOHDB4+bOWgWXImvclHB74g9dd4SlxK2AS
         gfHMwhc1WTnzMAjzL0wk4zBz6LDLgo3ELNHrxwsH74cg7+ZbVH2j+EfkfuGZ07ezklh1
         DqdGmJN3eQsQhv12HJaD27FstRJoAUCeZQBpCVph849zjKq6r6wAS5GzKTeWKBqHg/4r
         Sl8Y8Upz7KhwbpHirF0BBvbuWnAafaG4X1xrnxlguRFeFY31frpEc+DxUfC5IBq2eovz
         a/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brpxKwQZ9NEyo3kql+ZLUvVmIiQJFbmnCGpOp8iZFjQ=;
        b=tFxTxUVFak0YVeKsfLVjM7OqQFUH6FjxKKTgurzecwA5bKRwjLW2b2mOwhsevPGGWI
         8PQgUvrfUuQyiBMQLCulwNfafnXEIHsxCRk9TQPn1Dai3Kt+vJqszW/38oxFC49xr/vp
         cf9+scMVGred2hIeyFdEKHMEWVAGnmq4vLiuP1KLCYeIBoLDkXNCbvpjLS/htSInhJiR
         Odc3fo/PZQn35GKaGfEiDaIM/OQF82Er8Jw3CgRRVjR3v6AvLSxPA9H2xtXRS937S6J5
         xLEm5Y3lrYIHMilXoYDHKS1FgILT2BbHcil1DxAeEqTwQQlS3h0CQMvyXf8jz8DPW30Z
         7QMA==
X-Gm-Message-State: AOAM5312U4VX/jtcH8EtOrIiRdGRGzShTpHAqUF6E33XOukXSV/oxfge
        Y+dxaKOKvKrrGXXXi8M3vXI9WiuEqlRA5hd2mvE=
X-Google-Smtp-Source: ABdhPJzqvydakke8QnKwmIMy2/RLRfDLr0W6nYT9xLKXIUITflqdugMCBRsVoNQPoA6fqqyOV5kFQaMLWnBm+h3UvcA=
X-Received: by 2002:a17:902:b481:b029:d2:686a:4e1f with SMTP id
 y1-20020a170902b481b02900d2686a4e1fmr610560plr.17.1601282806110; Mon, 28 Sep
 2020 01:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200928040651.24937-1-haifeng.zhao@intel.com> <20200928040651.24937-5-haifeng.zhao@intel.com>
In-Reply-To: <20200928040651.24937-5-haifeng.zhao@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Sep 2020 11:46:27 +0300
Message-ID: <CAHp75VfRaQfdL130xzGXhHjCNfC2hAmH3PM7jKqGPBGTgsK+Aw@mail.gmail.com>
Subject: Re: [PATCH 4/5 V4] PCI: only return true when dev io state is really changed
To:     Ethan Zhao <haifeng.zhao@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 28, 2020 at 7:13 AM Ethan Zhao <haifeng.zhao@intel.com> wrote:
>
> When uncorrectable error happens, AER driver and DPC driver interrupt
> handlers likely call
>
>    pcie_do_recovery()
>    ->pci_walk_bus()
>      ->report_frozen_detected()
>
> with pci_channel_io_frozen the same time.
>    If pci_dev_set_io_state() return true even if the original state is
> pci_channel_io_frozen, that will cause AER or DPC handler re-enter
> the error detecting and recovery procedure one after another.
>    The result is the recovery flow mixed between AER and DPC.
> So simplify the pci_dev_set_io_state() function to only return true
> when dev->error_state is changed.
>

This one looks good (more or less) now.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
> Tested-by: Wen Jin <wen.jin@intel.com>
> Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
> Reviewed-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
> Changnes:
>  V2: revise description and code according to suggestion from Andy.
>  V3: change code to simpler.
>  V4: no change.
>  V5: no change.
>
>  drivers/pci/pci.h | 37 +++++--------------------------------
>  1 file changed, 5 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fa12f7cbc1a0..a2c1c7d5f494 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -359,39 +359,12 @@ struct pci_sriov {
>  static inline bool pci_dev_set_io_state(struct pci_dev *dev,
>                                         pci_channel_state_t new)
>  {
> -       bool changed = false;
> -
>         device_lock_assert(&dev->dev);
> -       switch (new) {
> -       case pci_channel_io_perm_failure:
> -               switch (dev->error_state) {
> -               case pci_channel_io_frozen:
> -               case pci_channel_io_normal:
> -               case pci_channel_io_perm_failure:
> -                       changed = true;
> -                       break;
> -               }
> -               break;
> -       case pci_channel_io_frozen:
> -               switch (dev->error_state) {
> -               case pci_channel_io_frozen:
> -               case pci_channel_io_normal:
> -                       changed = true;
> -                       break;
> -               }
> -               break;
> -       case pci_channel_io_normal:
> -               switch (dev->error_state) {
> -               case pci_channel_io_frozen:
> -               case pci_channel_io_normal:
> -                       changed = true;
> -                       break;
> -               }
> -               break;
> -       }
> -       if (changed)
> -               dev->error_state = new;
> -       return changed;
> +       if (dev->error_state == new)
> +               return false;
> +
> +       dev->error_state = new;
> +       return true;
>  }
>
>  static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> --
> 2.18.4
>


-- 
With Best Regards,
Andy Shevchenko
