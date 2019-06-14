Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7073345FB0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 15:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfFNN4o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 09:56:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46341 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfFNN4o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jun 2019 09:56:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id v9so1581627pgr.13;
        Fri, 14 Jun 2019 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F91alA3rwkHuXFHUA9txhLC2FZTSDigq7H39cSQacFY=;
        b=lWrBsnrKs7L9tfO2+xrpNN67yN3QG659YMGg3gC+E3rgEjxXhy+lJGHKIPe6AIfCoc
         VXCkJb59QbHbWa6Ta302mtRCsPLJDt1NzwmCzUVQzEzGJJsgLY39v8rmUsU96GWrrGHL
         +K2i3UxcYPqnBrlXg2Hwfc1cOwI/sRlXNp4c3MRB5CfV7C1iYP8Wf3FaPT0iBSxH9iIt
         LbtYtUMGg2XOHrok95ufbs+j/vIAf8GTZCEoVmCqoeHSxbcCHo11vMg9s5A1mO0WL3/l
         vRNONeqpHxIXQBvp/h9Lr8I6gXPjbPA0bQy00DIXRjr6vJ6r9L9HhTAs40CjN/3VH6lT
         WbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F91alA3rwkHuXFHUA9txhLC2FZTSDigq7H39cSQacFY=;
        b=lNNaVS+Jhn2/YG9aGnFBhfk1Ro7kSjYSGbcIS2VxCB7oTNGnSoWYWEzvMd3uCRWAtG
         xVU9IPLdVzaONY4zPSQk5vIBgrTIRExz8p+MEr0XP/WcAhZfdNmGRr7mKNkze4QpwWlB
         3dgvngpy9G+2i5OksgOMIQI7CSaICqwfQCd/IpEKwzoFaCiL4dLW88o7xxEEevqzegh8
         WYTWbpjzlDPnRRnD1P/+QBFVACkSTHvdkKzRriqUCqhxiYtoqk4a7vE2laR7KHpTziV8
         nG4NoEmOJDrcfPI51UkrUXrdsI3mqBcv4uH4Yr8r4NZybcOpNlcajdETF+Ulp/TNMyH3
         N7aQ==
X-Gm-Message-State: APjAAAVV+ApZY0fV264n22lT+zVTN7t/OeqMfqVnepQ2ciz0S+JKVdGf
        xM9pYwqN2A/kvBnmfFGPObTuN+fQcfKf/DyZYyDXIU/B
X-Google-Smtp-Source: APXvYqwemQ+inytAjigoA5rMw/ySmmfF6sH9Nkw1f68mO3cFGYho8raaFj6pvN53H/GgxFLNDtK1rHox0uOsPxmJ2jg=
X-Received: by 2002:a62:e20a:: with SMTP id a10mr13800745pfi.64.1560520603563;
 Fri, 14 Jun 2019 06:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <1560516085-3101-1-git-send-email-92siuyang@gmail.com>
In-Reply-To: <1560516085-3101-1-git-send-email-92siuyang@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 14 Jun 2019 16:56:32 +0300
Message-ID: <CAHp75VcnqpQPTEFsG_bDmAJa4EHucgwoGvyw_XukC6vntdDhow@mail.gmail.com>
Subject: Re: [PATCH] PCI/hotplug: fix potential null pointer deference
To:     Young Xiao <92siuyang@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 3:40 PM Young Xiao <92siuyang@gmail.com> wrote:
>
> There is otherwise a risk of a null pointer dereference.

Had you analyze the code?
How come that prevnode can become NULL?

> Signed-off-by: Young Xiao <92siuyang@gmail.com>
> ---
>  drivers/pci/hotplug/cpqphp_ctrl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
> index b7f4e1f..3c8399f 100644
> --- a/drivers/pci/hotplug/cpqphp_ctrl.c
> +++ b/drivers/pci/hotplug/cpqphp_ctrl.c
> @@ -598,10 +598,11 @@ static struct pci_resource *get_io_resource(struct pci_resource **head, u32 size
>                         *head = node->next;
>                 } else {
>                         prevnode = *head;
> -                       while (prevnode->next != node)
> +                       while (prevnode && prevnode->next != node)
>                                 prevnode = prevnode->next;
>
> -                       prevnode->next = node->next;
> +                       if (prevnode)
> +                               prevnode->next = node->next;
>                 }
>                 node->next = NULL;
>                 break;
> @@ -788,10 +789,11 @@ static struct pci_resource *get_resource(struct pci_resource **head, u32 size)
>                         *head = node->next;
>                 } else {
>                         prevnode = *head;
> -                       while (prevnode->next != node)
> +                       while (prevnode && prevnode->next != node)
>                                 prevnode = prevnode->next;
>
> -                       prevnode->next = node->next;
> +                       if (prevnode)
> +                               prevnode->next = node->next;
>                 }
>                 node->next = NULL;
>                 break;
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
