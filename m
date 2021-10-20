Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CA2434D81
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 16:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhJTO0c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 10:26:32 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:37526 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJTO0c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 10:26:32 -0400
Received: by mail-ot1-f48.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso6467245otl.4;
        Wed, 20 Oct 2021 07:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oi4ZFYcM9sTBRBMXr9cttcAIxQGx+R9lkntd5NyWgkk=;
        b=YPXNzh3B2boEoGjL4RbGycPCvV+i1fM2GS1x6T/4yzGD8JSSCZ2XEhSOe1p8bNeh1K
         SAfZ5BuPHgfDayI3XTsPPls8avwjofpO6Ih1RtzlMoSVTUfvc7psCdu01SwrUp6UCzEB
         R5UiaJE8SDy5GswiBl91LbN+/1N+Q/v7ryuvaWS75gJcG0UmNiMkYSPwiG8lXIxwIGld
         XVwEvlBl4ZVz5q6B+UCTcFMIu6DaUkCEJxfQY2x8OS72IdF+eobuTu7tAMQlQnSQQtlv
         vORrD0eh2vHf0QwACP/ziW2K/ULdojZ4WqmOqY8HfMtMdi582F1XvE+tGDW4BiqS5AoP
         5wbw==
X-Gm-Message-State: AOAM531TX1dym/kH9lA8GoOSOCCwosfEeq93uu23h157C6D13XMCJQLt
        9mVirFv/XkDE/BnyboJ3fQGHkuL77/nPA+weowDNLjR9
X-Google-Smtp-Source: ABdhPJysCmLOexnNrgPpcJ5jOvqkzURA8+8jVLhHdf/nx02I9Pc054IZhLdw5fmvnbA0/zd/EAclVnC6ss7KHf5MC2U=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr170775otd.16.1634739857674;
 Wed, 20 Oct 2021 07:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <11844217.O9o76ZdvQC@kreacher>
In-Reply-To: <11844217.O9o76ZdvQC@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Oct 2021 16:24:06 +0200
Message-ID: <CAJZ5v0hC9pKrPgHNasN7YMmJysJymOM++h2ZT-_PQ=4ZFq7Kqw@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Fix ordering of operations in pci_back_from_sleep()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 15, 2021 at 6:46 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The ordering of operations in pci_back_from_sleep() is incorrect,
> because the device may be in D3cold when it runs and pci_enable_wake()
> needs to access the device's configuration space which cannot be
> done in D3cold.
>
> Fix this by calling pci_set_power_state() to put the device into D0
> before calling pci_enable_wake() for it.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If there are no concerns about this one, I will queue it up for 5.16.

> ---
>  drivers/pci/pci.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -2638,8 +2638,13 @@ EXPORT_SYMBOL(pci_prepare_to_sleep);
>   */
>  int pci_back_from_sleep(struct pci_dev *dev)
>  {
> +       int ret = pci_set_power_state(dev, PCI_D0);
> +
> +       if (ret)
> +               return ret;
> +
>         pci_enable_wake(dev, PCI_D0, false);
> -       return pci_set_power_state(dev, PCI_D0);
> +       return 0;
>  }
>  EXPORT_SYMBOL(pci_back_from_sleep);
>
>
>
>
