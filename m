Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2ABEDC83
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 11:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfKDK3R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 05:29:17 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40149 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKDK3R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Nov 2019 05:29:17 -0500
Received: by mail-oi1-f194.google.com with SMTP id r27so13610195oij.7;
        Mon, 04 Nov 2019 02:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMaIK5rI7m/XaGA7nbAfirt41zqNOSaQ5u4JanEnkug=;
        b=BYetKR2HRiOchQmzTF7hw1EeVCQSvJaafGLuWrzhQjiRXSyU5E8ZTEfOHJSpSzrgVa
         WHv3i4hEPNa7TN2Bt0HHBc1SYCaSbsu8yfmg3paUGLGNPBtn39QHDiA448eHK7Z6VJEM
         dDdUT82I5itLJJC4J1qnzyWD6OGAuviyRjnBiiJ5MXboWORNYkFQc02cW7qvbTjk97jR
         zhBAwhHH4tvfLh6KholtORK7KDI8cK4Z2riRB5cbaGTaO1evhz3FgelExIoHG1adAYnq
         SQNFxr0DYJSW25NvuWztfXc0jtoU/+ArVmXTlxHixKKL6bliQVX6fEOm5bHq6NSbtaT+
         azvw==
X-Gm-Message-State: APjAAAXUKoQMynYHi1mxBVzxxbZhDmmZMwjWLd8uG0eFVUy8168lNe+j
        STcZl8iPGeh4YkcHzgW0WsqjCyiVwBYV9wBotfm90Q==
X-Google-Smtp-Source: APXvYqxQUk0WYQBzPpqoGAwgt5HqYDWNnE/GxSDuAM84IjirBT0shkbB8HKRCkoo58R/wbA9vlSePjd7Oefh6i5mh4g=
X-Received: by 2002:aca:fdd8:: with SMTP id b207mr8222796oii.57.1572863354723;
 Mon, 04 Nov 2019 02:29:14 -0800 (PST)
MIME-Version: 1.0
References: <20191101204558.210235-1-helgaas@kernel.org> <20191101204558.210235-2-helgaas@kernel.org>
In-Reply-To: <20191101204558.210235-2-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Nov 2019 11:29:03 +0100
Message-ID: <CAJZ5v0ihZTc_e7ORcAWFOYvLdc9keO2evRYxr9qz-w8WkQtEhQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] PCI/PM: Apply D2 delay as milliseconds, not microseconds
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
> PCI_PM_D2_DELAY is defined as 200, which is milliseconds, but previously we
> used udelay(), which only waited for 200 microseconds.  Use msleep()
> instead so we wait the correct amount of time.  See PCIe r5.0, sec 5.9.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e7982af9a5d8..cd96874ae76d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -886,7 +886,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>         if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
>                 pci_dev_d3_sleep(dev);
>         else if (state == PCI_D2 || dev->current_state == PCI_D2)
> -               udelay(PCI_PM_D2_DELAY);
> +               msleep(PCI_PM_D2_DELAY);
>
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>         dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> --
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>
