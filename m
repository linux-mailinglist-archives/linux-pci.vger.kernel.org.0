Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6C7244C12
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 17:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHNP1M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 11:27:12 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:43215 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHNP1L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Aug 2020 11:27:11 -0400
Received: by mail-oo1-f67.google.com with SMTP id z10so1982989ooi.10;
        Fri, 14 Aug 2020 08:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AR2vjh3UpjcMGH0kCnD6EsK8SKt3wIhYT8SgdJ9mnkk=;
        b=fyXSkOfXy06CUPL9NkwpQBpc33HFAgF7YHrBZ5+8v/wj86SGZsEDIJX1usK/x6BPZm
         /ZieUKpRwIYNZK8BH1FhIrhMIUvyun4Kinu0JyvuhqEqpENK4itofdSyXrFivgYn6zVC
         cbUMP/1kDCzRQaUHFZBvitAmZtj2eN+tVJgUSZiDSweYRdpT9KBhQ64VAMG+cdPg5noV
         /uu/kfedmeUs1sfJo6VoBdJESiXS+jpZMCeGABcfQljYHeFGG4Hv+2uHVSljQY1hX52i
         etOS2s1R41gZAArIWbLPrpl5iDQLvHzBflAVMOokHiD1a0EaA6onMX8FkPPZAK5Ypd7U
         e0AA==
X-Gm-Message-State: AOAM531OfiGXUnzN+g4hu4a96oDVgz4kVX2OxdmONhOb0drqyEknBaM7
        oNCSxqMIBcNaUVSALM3dHZ53eQbVMWpOPrpXFFjORWE3
X-Google-Smtp-Source: ABdhPJzzAVEoq3ESxvkVWjiDgWgrr2M2X/ahFvjTCi5ARt7WCNNYUolh/NxN3kHRoSeHAAOO0MPmsK369JOdkEhHL44=
X-Received: by 2002:a4a:d62c:: with SMTP id n12mr2093505oon.38.1597418830664;
 Fri, 14 Aug 2020 08:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com> <20200813175729.15088-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200813175729.15088-5-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Aug 2020 17:26:59 +0200
Message-ID: <CAJZ5v0jyshOjj2cPeWC6-1NhQNuv8wnK883x7RQ1U5FTwwkhEA@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] PCI/ACPI: Replace open coded variant of resource_union()
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
> Since we have resource_union() helper, let's utilize it here.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/pci_root.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index f90e841c59f5..2a6a741896de 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -724,9 +724,7 @@ static void acpi_pci_root_validate_resources(struct device *dev,
>                          * our resources no longer match the ACPI _CRS, but
>                          * the kernel resource tree doesn't allow overlaps.
>                          */
> -                       if (resource_overlaps(res1, res2)) {
> -                               res2->start = min(res1->start, res2->start);
> -                               res2->end = max(res1->end, res2->end);
> +                       if (resource_union(res1, res2, res2)) {
>                                 dev_info(dev, "host bridge window expanded to %pR; %pR ignored\n",
>                                          res2, res1);
>                                 free = true;
> --
> 2.28.0
>
