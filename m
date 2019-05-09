Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6576E18F44
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 19:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEIRg3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 13:36:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38800 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEIRg3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 13:36:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so1564218pgl.5;
        Thu, 09 May 2019 10:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fm/Yx4WlkdFkzJYcjEnD/dd0EBFK33lb3Y6Zhd2dmmo=;
        b=n+DkPo2Wn6se53eSBGHwiyCJckhtHBjNob8IoMYkYeCfIsIxOFbeQz5ZOOj4O0GycI
         20CaxEAZLScyslugWCcRWRPZRwT3pYt/Lg5Ms0kDwntJ7YfHkA+bgSetBORLeA7xrv0s
         o5iifv81W0CuE7LhiWh0Yo+V/94Drd/BIH/h5fd0WUbK0yggDyPZnUgQDxbbTlyv8sxj
         cIrrSH0skGlLoIP/0qPfEf2KNGvw6CIKmKYcqIk5a+ruLbHFJ+etyGTp8jrMPFG8JfS7
         MEix7ZOqva0CwZ4uuiS+Qrg7N0TuWh2wLCyUdBXYmpvH2nd4jZKK0B2aKfxoPS0flEZY
         IRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fm/Yx4WlkdFkzJYcjEnD/dd0EBFK33lb3Y6Zhd2dmmo=;
        b=WuxAjC4MLnlWdIaFKzRmvHQwnMQSPXyHRSTZU+aMWbYIjyrX/JeTGgA+WKsKHHfnsB
         5efhDUa+Yy8gN0bB4Z0GnicKHcV6pa5dZfigLrCRRl4PYVKv5wF+poANLzikDkaHs47D
         NIXoypZBoEziVUxrNZ8Y91XZRe6X57nyyJjYkkCwy/bez5/Du8bNZIRpmgWG+37tP/94
         Zn70O8U19d0wAuuIMwCrfMo3+nAX6HyCsqtH84h20ZqN2jZMOo49xiOVlkBzr6qtxUMI
         rkYH8AR3oA9aLeOegUYPRs2xn7Zs5AFq4r7So7zFjWdw3iC/ktAJmt+SayXayHHPqlnS
         b/8Q==
X-Gm-Message-State: APjAAAXuj/5eGwlqs3JSRpYjIFjJ4L0kOpGM8Ez2qsAKdTo3PfA8+E5+
        7xzZnf0Uv69S3bYJrmRZVUTd2NxViJnVSvvpkq8=
X-Google-Smtp-Source: APXvYqyQBj0be6yZUsdhV/FaLQE4dE9UbIMdQUscEX9Vtv0rdrB086A6j3O5qennG3h3d9XE8kTPBmlaCG8eRscTZ6A=
X-Received: by 2002:a63:42:: with SMTP id 63mr7231179pga.337.1557423387477;
 Thu, 09 May 2019 10:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190509141456.223614-1-helgaas@kernel.org> <20190509141456.223614-2-helgaas@kernel.org>
In-Reply-To: <20190509141456.223614-2-helgaas@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 May 2019 20:36:16 +0300
Message-ID: <CAHp75VfbVvpMaKdeKKTs_zF6CcJf5==oV8PR+YF+RTAtZrtRfg@mail.gmail.com>
Subject: Re: [PATCH 01/10] PCI/AER: Replace dev_printk(KERN_DEBUG) with dev_info()
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

On Thu, May 9, 2019 at 5:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Frederick Lawler <fred@fredlawl.com>
>
> Replace dev_printk(KERN_DEBUG) with dev_info() or dev_err() to be more
> consistent with other logging.
>
> These could be converted to dev_dbg(), but that depends on
> CONFIG_DYNAMIC_DEBUG and DEBUG, and we want most of these messages to
> *always* be in the dmesg log.
>
> Also remove a redundant kzalloc() failure message.

> +               pci_info(parent, "can't find device of ID%04x\n",
> +                        e_info->id);

Would it be a chance to take them one line instead of two?

> +               dev_err(device, "request AER IRQ %d failed\n",
> +                       dev->irq);

Ditto.

-- 
With Best Regards,
Andy Shevchenko
