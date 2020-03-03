Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 576A61782A8
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 20:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgCCS5p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 13:57:45 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42935 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCS5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 13:57:44 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so4108636otd.9;
        Tue, 03 Mar 2020 10:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+50iwvf4+BPG6fbK1bhnsWbshJjC8gjUIQgfu0Tu/c=;
        b=VPwG1w6Y3RwLAyhoUFaxn2nsDDxm3FYDNHzLELvaVAyPnVdsbsbz8NfICCacZ/Ec4l
         kx7D6XVOUnL3HM7McBsz42Bo4byLx2mtYjj4C/uPqM5kySpoBCSCmOj1xsIdqrhTLkK+
         ZMxVvY0EJ6xAlpWIPDPRn03ES+0lWU4l8NqWfKq1dIxX7k45gGwh8z/fOG/PUH1dA/Im
         akQio/nh/3eFQbo6bn7ZdBzlXDBJ8veuCfCov8FtgmRQ3SC+1OfZQeo4GQf3JfYVAeKq
         +YIXZkV/XAois8ywr1JmBq0c4zF8StC58NjNbfOd5oYSSwWFfEtp+9ZE1/H/ci+jyNRz
         R0QA==
X-Gm-Message-State: ANhLgQ1FlJrDVzwSpVwvvSx4zTNmDXZgTwobi9ImKDK+hub4bjrnvOKY
        Pe1qbW8sPBuNwmZfMm+3jEz0TvZ/XXQvhl4Ejzc=
X-Google-Smtp-Source: ADFU+vs1JBo5ZgHvPapYTkntqLLq0Hjz1ls0WxGg/KjxAFJVv4Lvf+XSgXQWepTFh6rRzt+hV4o5zOrwBTSRyKFhju8=
X-Received: by 2002:a9d:6b04:: with SMTP id g4mr4175051otp.167.1583261862784;
 Tue, 03 Mar 2020 10:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20200303132852.13184-1-stanspas@amazon.com> <20200303132852.13184-5-stanspas@amazon.com>
In-Reply-To: <20200303132852.13184-5-stanspas@amazon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Mar 2020 19:57:31 +0100
Message-ID: <CAJZ5v0hVFGqWsZbHwYu2uJrdwzVp1m-HDaTCS+A-+qpw5FwuQQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/17] PCI: Do not override delay for D0->D3hot transition
To:     Stanislav Spassov <stanspas@amazon.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Stanislav Spassov <stanspas@amazon.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?SmFuIEggLiBTY2jDtm5oZXJy?= <jschoenh@amazon.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>, Rajat Jain <rajatja@google.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 3, 2020 at 2:30 PM Stanislav Spassov <stanspas@amazon.com> wrote:
>
> From: Stanislav Spassov <stanspas@amazon.de>
>
> Both specifications that document mechanisms for overriding the
> D3hot->D0 waiting time only speak of this specific direction.
> Nothing is mentioned about the opposite (D*->D3hot) except for
> the default value of 10ms in PCI Express Base Specification
> r5.0 (May 22, 2019), Section 5.9 "State Transition Recovery Time
> Requirements".

Unless you have a specific example of a system on which the current
code doesn't work (and which should be mentioned here), I don't think
that it is a good idea to make this change.

There are systems in which it would make a measurable difference in
things like the time it takes to suspend the system.

> Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c1a866f733e9..03103bb15b42 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4589,7 +4589,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
>         csr &= ~PCI_PM_CTRL_STATE_MASK;
>         csr |= PCI_D3hot;
>         pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
> -       pci_dev_d3_sleep(dev);
> +       msleep(PCI_PM_D3_WAIT);
>
>         csr &= ~PCI_PM_CTRL_STATE_MASK;
>         csr |= PCI_D0;
> --
> 2.25.1
>
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
>
