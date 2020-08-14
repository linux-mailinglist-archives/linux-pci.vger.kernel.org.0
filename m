Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93550244BB0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHNPMH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 11:12:07 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:42518 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHNPMH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Aug 2020 11:12:07 -0400
Received: by mail-oo1-f65.google.com with SMTP id a6so1981558oog.9;
        Fri, 14 Aug 2020 08:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xPEAyT242zCqpQsFiRlqT2H2KPu1pwTh4cJkknKvJo=;
        b=TDfPqN6VEp41+6LRMTYu0gsknxFNgfWTO1u4d+DDNYPOinGgi1GqLCX5mShe/WKLC2
         yODzDC1uVp/8jXTq3HpIoplvFDma9L+JlKrDod+/KHOKlXvDP1l5rCd8e17WMC9UKUza
         XBImU/xN7NKdpkDl18LaLRB91BTvHYLSNZqYgwP3JQ5XVfhOmc5RtKlrQS/FhUxZxkhd
         8MhWxT1pwT7Ql/pETP4QEt1wZQMgr6+ledd018GzwdZE+No7qA/5hxEfqG1BAK50/h+3
         kcnt2ii4Tp3mhbezyQUfAmoAcKJzoQ6JlZPv3YpOVThcKvu63Nolf7Fsn1EkfZFDA7Pd
         Wwzw==
X-Gm-Message-State: AOAM530lXmUAMXtD5LffmuljeMCnx7VAdXs5+3Sn2CG+L3h1uucjobja
        d1N+SrxqTQHAWTt4ixrwxeZBkxOqnDf23OHwLvSnZCe8
X-Google-Smtp-Source: ABdhPJzUnUyMUuc78wHJRnppNRf7GRRhxiD8yRQWkcXfslxn48kqwUjq4RU5a8Hmj0iwneqjfluc9gw7xGk4gUKHlQk=
X-Received: by 2002:a4a:4201:: with SMTP id h1mr2020303ooj.1.1597417926225;
 Fri, 14 Aug 2020 08:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com> <20200813175729.15088-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200813175729.15088-6-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Aug 2020 17:11:55 +0200
Message-ID: <CAJZ5v0jquT7TLLO4yJqyxgfJJ77hLQ+RtmLXVj6JATWXJxqkUQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] PCI/ACPI: Fix description of @handle for acpi_is_root_bridge()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 13, 2020 at 7:57 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Fix description of handle parameter in documentation of acpi_is_root_bridge().
> Otherwise we get the following warning:
>
>   CHECK   drivers/acpi/pci_root.c
>   drivers/acpi/pci_root.c:71: warning: Function parameter or member 'handle' not described in 'acpi_is_root_bridge'

I'm not sure why this patch doesn't go by itself.  It appears to be
immediately applicable.

I'll apply it next week if Bjorn doesn't object.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/acpi/pci_root.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 2a6a741896de..f723679954d7 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -62,7 +62,7 @@ static DEFINE_MUTEX(osc_lock);
>
>  /**
>   * acpi_is_root_bridge - determine whether an ACPI CA node is a PCI root bridge
> - * @handle - the ACPI CA node in question.
> + * @handle: the ACPI CA node in question.
>   *
>   * Note: we could make this API take a struct acpi_device * instead, but
>   * for now, it's more convenient to operate on an acpi_handle.
> --
> 2.28.0
>
