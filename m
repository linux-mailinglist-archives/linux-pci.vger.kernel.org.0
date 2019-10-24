Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D66B7E28D9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 05:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392885AbfJXD3M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 23:29:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43993 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390450AbfJXD3M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Oct 2019 23:29:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id t20so35684598qtr.10
        for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2019 20:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CacFV/lTRmHt6F6mhHUKL10O5L8H3YTLLCMha7hrL0Q=;
        b=THz42nOH1jaoEtXaeQaTmQlMy/YfB6LGy17zRJPG1zcWDqtEM7HwK46nnnnGY0fkKD
         BnXyr1jkqA9JCWCblDHeTxOYJ8j4Ysq77YEwm4uZsGgc+ysyqxXbf3Rx2va/es5TnfZk
         wFWj/o0BeRDu3PsghlyiUcBaiojjVUIhMtrRmzpTIHDcui579+6DZhm/qLY1uyJDFEvn
         1xTb1w6F6KYSTI78V0DooalbyVStBl0sk8C3puGcm4i+NjC3yOTqbWtF+KhHYgLx3sFX
         OMBBFR8trx3SRArl8fj2Wm+H2PqJ0AKi/JYGKsTRjOp07bIxYsKFVVdYIbkloV3PW/uX
         V6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CacFV/lTRmHt6F6mhHUKL10O5L8H3YTLLCMha7hrL0Q=;
        b=nhZb7zNuo3D9maj7pLiNkTar1Q+BRtISf7MwUZpHD85D90CGEVROgHBMr1jsJar2zB
         sB6i4VZ2W5xTHtL29wGryPO5udLUXW2DCQ3/2V88F8w1tg6+EOvh9pilL+70+snozXdl
         ZVNTJhPkuNETZOGJcmGfo+5j/iRZsf3kWmflkDqWE+pBoPfz91vMVDpT1TAAnCRDUxD+
         Hg3RJa1RxwAenrqFTYrqJbBvaTNvDxE/XmqZsxu0xCQBrbv4fj62is1o6kr6tRRsaJN6
         9vwyovIzFU2j+UNk4oPj+AMv3MvqJXeQQUhs5BpFu3Z32QclspS60SWvkPcRj9N/U7ER
         NyHQ==
X-Gm-Message-State: APjAAAU7t39iTe0UGIJQ3CokvwK/1R9qOPoB8hGIXCd+fxcs7qNGXOlK
        WQ5RkS99aCRldhMMmfDZqJsgFE19Jt5EP5KiQIkTGA==
X-Google-Smtp-Source: APXvYqyZrz7NqARmFL2eBIDTA+kjbyBSTICNGBsHWH2dyFreIV4B7r6FTsTK1VCom+KCShQPX0OFG3VuirMV5q5t4FQ=
X-Received: by 2002:ac8:c86:: with SMTP id n6mr445293qti.80.1571887750853;
 Wed, 23 Oct 2019 20:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191022093349.GC2819@lahna.fi.intel.com> <20191023224003.GA31692@google.com>
In-Reply-To: <20191023224003.GA31692@google.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 24 Oct 2019 11:28:59 +0800
Message-ID: <CAD8Lp46KZmTzxjYN6T7u1xH0AODr38hFcCgR-COtvduK9ZuANQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 24, 2019 at 6:40 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> I think we need something like the patch below.  We already do
> basically the same thing in pci_pm_reset().
>
> [1] https://gist.github.com/dsd/bd9370b35defdf43680b81ecb34381d5
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e7982af9a5d8..e8702388830f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -883,9 +883,10 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>          * Mandatory power management transition delays; see PCI PM 1.1
>          * 5.6.1 table 18
>          */
> -       if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
> +       if (state == PCI_D3hot || dev->current_state == PCI_D3hot) {
>                 pci_dev_d3_sleep(dev);
> -       else if (state == PCI_D2 || dev->current_state == PCI_D2)
> +               pci_dev_wait(dev, "D3 transition", PCIE_RESET_READY_POLL_MS);
> +       } else if (state == PCI_D2 || dev->current_state == PCI_D2)
>                 udelay(PCI_PM_D2_DELAY);
>
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);

You also need to move the pci_dev_wait function definition higher up
in the file.
Tested and that doesn't help this case unfortunately. pci_dev_wait
doesn't do anything since PCI_COMMAND value at this point is 0x100403
:(

Daniel
