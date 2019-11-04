Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFC8EDC8C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 11:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfKDKaA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 05:30:00 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43279 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfKDK37 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Nov 2019 05:29:59 -0500
Received: by mail-oi1-f194.google.com with SMTP id l20so1543133oie.10;
        Mon, 04 Nov 2019 02:29:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UO9EUdWWESD9xgPlrDXU0HRfG6NVeXbyrNUZEFHoSI=;
        b=IFFD7ZczHXnsLEKLpc5tjOgDoy+cFrs/olGbkiXz9vMccmH4mDiuqqBZRcxPTJje9g
         YiS9lXFGeQu3a2VIOWy+tdmxSVxj9xppWSJGcLjMgwNqr4FIunLsAxmviLURtCoDaClo
         Vp+bWLCojph22WMncj4UMgsfOiCfBf1nKNuuBY2x2I6Us52R2/C/ADxGsCBrdQyftbl8
         l/Hr9dRsL6V9Ktcd8Xp9trI0XerXgQMq5QQnOkRygzaibG5mif9zz1PnyagoW3jN86gL
         YjwFnmHUYfgj/RH98X8Uj3DHSt9Is2FpK4oGMpQcuP3mbKXwbAlzcCemq8v8/bGu2Hxa
         c3CA==
X-Gm-Message-State: APjAAAUQUZuEr+JKMQzGZgYHA/Boy3wV1k6dnpKMD5LWbuwOJbWniDJI
        oK3hlZjg4nzccRiHbie5OijF653UDiYFkRFnV+/VIIwo
X-Google-Smtp-Source: APXvYqxQ6uy9j2rz5onZ2uBoUIz3UguapNZC78Stb8QXeFIDBFybLe08ApFRwWAKFB6Qn/VwlvTBp+59zQ6d+tvwu24=
X-Received: by 2002:aca:1b05:: with SMTP id b5mr16073314oib.103.1572863398943;
 Mon, 04 Nov 2019 02:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20191101204558.210235-1-helgaas@kernel.org> <20191101204558.210235-3-helgaas@kernel.org>
In-Reply-To: <20191101204558.210235-3-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Nov 2019 11:29:47 +0100
Message-ID: <CAJZ5v0iLQsVk2-33VurJYqZKAOk4JZXS9A+fLXYB-tu=HvxyoQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] PCI/PM: Expand PM reset messages to mention D3hot
 (not just D3)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 1, 2019 at 9:46 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> pci_pm_reset() resets a device by putting it in D3hot and bringing it back
> to D0.  Clarify related messages to mention "D3hot" explicitly instead of
> just "D3".
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index cd96874ae76d..a9d3653ef960 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4605,7 +4605,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
>         pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
>         pci_dev_d3_sleep(dev);
>
> -       return pci_dev_wait(dev, "PM D3->D0", PCIE_RESET_READY_POLL_MS);
> +       return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
>  }
>  /**
>   * pcie_wait_for_link - Wait until link is active or inactive
> --
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>
