Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE152A5D7A
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 23:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfIBVUL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 17:20:11 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34608 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfIBVUK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 17:20:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id g128so11281214oib.1;
        Mon, 02 Sep 2019 14:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+lpVdJyYQZ7LkgNkMVrzaDCTE1l3PZ7/Lcu/MbmwZUI=;
        b=n1gbMIZvQhdc8KkN89ingFIug7M/vLOSmZLTZtW8bj/LNfCwIrXmTOYWIxux+HwjpO
         jYAAF5JXwMo4heOWckHITtHHgvCm0joaxBMraHd44X4pMzMn8Hd7SlFfpvm6mYzSbrhD
         W0BWdBXoGGNJhzZ9oxsihO3Pc8bKxo7S8WdSaJWRFIJ9HHrmWDx16KC76Aqzc1oWzeXs
         kKl63VXDcdq+nZL1uA6LVqK2SMYC3euzX6ZVOcE50TcbGgZdT5XaleCvoR0uLvfsDNkI
         9i0QUQ4t3ZkxS/ijjhCgUBEBPMx4KVOcYwRj/ljvQYsTjPF6Ud0U23lrw+HTYQTzaIpc
         ZyBA==
X-Gm-Message-State: APjAAAWeWPHThHj0TFdMIky4boNfLrLdFC2GVoaSjEJNzL+ynn7DLQj6
        YJKkSdeChZWmGvrVaDu+Ks1CZ9LyZ5zFzuyBRDQ=
X-Google-Smtp-Source: APXvYqwGCGf60riIo4v+fCFvupHhE0kAak7ebOC0RWF/EbO4OMDuyX8HFStQAA9Yx0Dxupl7HJV8ug6sWt7FA5L1hys=
X-Received: by 2002:aca:b808:: with SMTP id i8mr19471537oif.68.1567459209611;
 Mon, 02 Sep 2019 14:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <1566359059-4844-1-git-send-email-wenwen@cs.uga.edu>
In-Reply-To: <1566359059-4844-1-git-send-email-wenwen@cs.uga.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Sep 2019 23:19:58 +0200
Message-ID: <CAJZ5v0gm3Mv0-6fVe+7v4Kd49xG6W=TXcxfTJthpe9o46n4EEQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / PCI: fix acpi_pci_irq_enable() memory leak
To:     Wenwen Wang <wenwen@cs.uga.edu>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 21, 2019 at 5:44 AM Wenwen Wang <wenwen@cs.uga.edu> wrote:
>
> In acpi_pci_irq_enable(), 'entry' is allocated by kzalloc() in
> acpi_pci_irq_check_entry() (invoked from acpi_pci_irq_lookup()). However,
> it is not deallocated if acpi_pci_irq_valid() returns false, leading to a
> memory leak. To fix this issue, free 'entry' before returning 0.
>
> Fixes: e237a5518425 ("x86/ACPI/PCI: Recognize that Interrupt Line 255 means
> "not connected"")
>
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Bjorn, any more comments?

> ---
>  drivers/acpi/pci_irq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index d2549ae..dea8a60 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -449,8 +449,10 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>                  * No IRQ known to the ACPI subsystem - maybe the BIOS /
>                  * driver reported one, then use it. Exit in any case.
>                  */
> -               if (!acpi_pci_irq_valid(dev, pin))
> +               if (!acpi_pci_irq_valid(dev, pin)) {
> +                       kfree(entry);
>                         return 0;
> +               }
>
>                 if (acpi_isa_register_gsi(dev))
>                         dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
> --
> 2.7.4
>
