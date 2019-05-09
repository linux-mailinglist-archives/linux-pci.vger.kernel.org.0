Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C4118F72
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 19:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfEIRmW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 13:42:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36677 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEIRmW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 13:42:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so1573845pgb.3;
        Thu, 09 May 2019 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fEOGAbvInx43YwIyxg7wo5ceer9dojABtC1T6Go3JM=;
        b=P5LIg2P48x2cbRp5A2hjkNNgl6QwI58yHdjDTy5iER1tSajiIhxbkb3WvfDbOkaiem
         AL99DccJ4N5g7m/ctULJzKK7mInjlOEgoz2ZtRwFeLveD8rXJJUgOyUxI0fy4alNzmh4
         4JPyJx6zhH0jM0LmobKtsXKGhD5q3zFRfu2Qd93fWGp4juKjgYp1sP/itq4Gub3qsSDl
         mARfwp5i3xsd4rTWYlhK5XwqCkCHpp22XaBtWoypjztMM46QNvxTdOa9PY99/Nk/Qmq6
         RjrQy4eoT2xx3bvp7pNFNE9DDbisABIaI+VPBbXNoLEgZLcWsprDZQtjE8k4AS23IzFm
         m4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fEOGAbvInx43YwIyxg7wo5ceer9dojABtC1T6Go3JM=;
        b=VzlY3n7z821ySJ0vT2ONzKWDou2T5B6fCOtXaNrdKPMNWhz1VTPk69vvH9ikRPVcNO
         pYwJ/Xohue5/lNBQkVaawstHMEiT4LTMWLMwbopE5D1BqzMkxypPrEQppuVu76YKvQ5D
         M2ZHWy3bAcrtwGfAjep1Eha1Pc56tB86lXZ/YLGg9jdslivBGrGxBcdb5DRJiTGnojhQ
         D+p9yQqQeEGBbzi+vagBAByVDw1WstxQ1+oQ15uugXKqqvVKWm8OH2tWwEhtFTJ2XmJd
         VgPqYPxN1CiTDRvdci3mqKhppDDtIFRMcfRj67EvV08+y5cfAUpNgAz2wqnG/ggEZcZT
         pkeg==
X-Gm-Message-State: APjAAAUAIGIeXAVDfztIFOdE+jmsPGNfE6bYs9a9leT+IrIm69tQ0R9s
        n7RXOxsObSFxjZAC4WPS7bTi+Dc6vXI+S0bqB1CWYMZ6
X-Google-Smtp-Source: APXvYqzbA4A4wY1XN4H36J/UnWtDF7rTJsk21FMXPdMTixrrKCZsHXOVhFxHa7DOKPGePdkoeIcClPZVvZIqjb8RXQc=
X-Received: by 2002:a63:dd58:: with SMTP id g24mr7243223pgj.161.1557423741562;
 Thu, 09 May 2019 10:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190509141456.223614-1-helgaas@kernel.org> <20190509141456.223614-5-helgaas@kernel.org>
In-Reply-To: <20190509141456.223614-5-helgaas@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 May 2019 20:42:10 +0300
Message-ID: <CAHp75Vfk0gftuSMQBzZUgoeBPLeUOUkcdKJFbXKq3-joDgT0fw@mail.gmail.com>
Subject: Re: [PATCH 04/10] PCI/AER: Log messages with pci_dev, not pcie_device
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 9, 2019 at 5:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> Log messages with pci_dev, not pcie_device.  Factor out common message
> prefixes with dev_fmt().
>
> Example output change:
>
>   - aer 0000:00:00.0:pci002: AER enabled with IRQ ...
>   + pcieport 0000:00:00.0: AER: enabled with IRQ ...

> +               pci_err(port, "request AER IRQ %d failed\n",
>                         dev->irq);

Possible to be on one line?

> +                       pci_warn(edev->port,
> +                                "AER service is not initialized\n");

checkpatch won't complain if it would be on one line.

-- 
With Best Regards,
Andy Shevchenko
