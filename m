Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB28268A
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 23:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbfHEVDG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 17:03:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34564 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730099AbfHEVDF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2019 17:03:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id l12so2723824oil.1;
        Mon, 05 Aug 2019 14:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kebLTDLbZgVx9CRIEFifnp3nP4T6jGcLbwqiEI+M60=;
        b=mDMAWpf3cvP6g1IOMGC+R8Jburoz9GTfsrCNfgUppKDOqqNh9Bigntlh+DNTXS+g0M
         nlYrxwitjtVW9gCwomU6pk9ymz6SkUwUZLev1Wd9NeuOMnwx+FJ8QBcgCV5I7afX7Zor
         Lbu7J+xn9QOlMrXqV7SUfuRJlQeQLWZt0LYY7jNyJ36WYcEiyMJvfWFnLS+giJEjRR4V
         2AqvIdQYH5JVBMLvsVjUrB86lukbxzIC7K6wRPtyhD6hqSbFf9jblVy9xWjpdebcxv0c
         RdUSuBp+ZMBw637fBmyFyq+2qiwHJmHtZMSlQ+wVbmOrR76VY9e3l9d4oIKxalPCRmhT
         abew==
X-Gm-Message-State: APjAAAWIoxgnNrMIyhISLX8SYUgkKHMbv+uu4RhyCRIzRSrHLUs5RueB
        KPNgPsMhQhIbk4S3oWYeY1YOgaokvwMpxw71zVk=
X-Google-Smtp-Source: APXvYqyy2IOINwqkPzlVgA75Km3iPIhI3IbcWChDxGiOH0v5+W+2EaZKdtu+RHBxynsuS3NmZUMn1O300lpCU3qCuyI=
X-Received: by 2002:aca:cdd3:: with SMTP id d202mr193461oig.115.1565038984673;
 Mon, 05 Aug 2019 14:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190805205214.194981-1-helgaas@kernel.org> <20190805205214.194981-4-helgaas@kernel.org>
In-Reply-To: <20190805205214.194981-4-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Aug 2019 23:02:51 +0200
Message-ID: <CAJZ5v0i5oVuZMxFmYiLnYPk=BsFGGiYntez3m1V5xeWgTgA4hg@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI / PM: Check for error when reading PME status
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 5, 2019 at 10:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> pci_check_pme_status() reads the Power Management capability to determine
> whether a device has generated a PME.  The capability is in config space,
> which is accessible in D0, D1, D2, and D3hot, but not in D3cold.
>
> If we call pci_check_pme_status() on a device that's in D3cold, config
> reads fail and return ~0 data, which we erroneously interpreted as "the
> device has generated a PME".
>
> 000dd5316e1c ("PCI: Do not poll for PME if the device is in D3cold")
> avoided many of these problems by avoiding pci_check_pme_status() if we
> think the device is in D3cold.  However, it is not a complete fix because
> the device may go to D3cold after we check its power state but before
> pci_check_pme_status() reads the Power Management Status Register.
>
> Return false ("device has not generated a PME") if we get an error response
> reading the Power Management Status Register.
>
> Fixes: 000dd5316e1c ("PCI: Do not poll for PME if the device is in D3cold")
> Fixes: 71a83bd727cc ("PCI/PM: add runtime PM support to PCIe port")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 984171d40858..af6a97d7012b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2008,6 +2008,9 @@ bool pci_check_pme_status(struct pci_dev *dev)
>
>         pmcsr_pos = dev->pm_cap + PCI_PM_CTRL;
>         pci_read_config_word(dev, pmcsr_pos, &pmcsr);
> +       if (pmcsr == (u16) PCI_ERROR_RESPONSE)
> +               return false;
> +

No, sorry.

We tried that and it didn't work.

pcie_pme_handle_request() depends on this returning "true" for all
bits set, as from its perspective "device is not accessible" may very
well mean "device may have signaled PME".

If you want to make this change, you need to rework
pcie_pme_handle_request() along with it.

>         if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
>                 return false;
