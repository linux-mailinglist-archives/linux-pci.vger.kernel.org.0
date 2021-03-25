Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AEC34980B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 18:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCYRah (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 13:30:37 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:41746 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhCYRaZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 13:30:25 -0400
Received: by mail-oi1-f178.google.com with SMTP id z15so2898121oic.8;
        Thu, 25 Mar 2021 10:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MClPgIyJWfzB8v7uHNHe9wccdA+LIzruu+7HvqWMVsk=;
        b=UkwNXC3itudIhbppfev4oZtlF9EiPQdppo8rTHO83N3bI0Nz4TgOPQL1KWG99Y+xGW
         iEly2M9rbf001bYYpdE9jY3RWexmzAtOuKV7DNj4vGrk9f6AfQ24HDC71bhvDSgzOo0M
         f3c+RS455jHD5eDLARckoeCKUZvnCVnwBuMyRPh+NKOOuHNJ0oOU6sFCd5uDNlc4AvHO
         PsbZWML8vLtWqEcyFqbix+gU9yJPYiKjSYXHHArL5AQYxQ/Nd/UdRlr2ZJmiooZ3aLx6
         5JCBspGJxJrwVwvD2HylHhTAeNMgfJOv2aAgEKSnD8dVAbLFFPEHb4+78iFLLuF0eO5y
         vNfg==
X-Gm-Message-State: AOAM530jJ6s/ZZfKjVWA4/ZeFMg0SFKKpDYNYkxg3J1uGlFv6b4lEjyj
        SInb75eR+UeuQw/+HGMR7XNRTa0q4bjpzjkEzlJRBYrA
X-Google-Smtp-Source: ABdhPJxE/C6eSPVaf4dimAwiP+yujmKc/6HUQkkVJAv4EIoqxpsA/VZIQFj8Yw/bmnJ0HCb7cdnS9sPLknm+8tN0ODM=
X-Received: by 2002:aca:c4c5:: with SMTP id u188mr7020325oif.71.1616693425185;
 Thu, 25 Mar 2021 10:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210325075144.180030-1-wangxiongfeng2@huawei.com> <20210325075144.180030-3-wangxiongfeng2@huawei.com>
In-Reply-To: <20210325075144.180030-3-wangxiongfeng2@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Mar 2021 18:30:14 +0100
Message-ID: <CAJZ5v0hgsuv8NwuhtK4CrdjPT_VMz1Dp4bDeYtEQs3qeJN_Uhg@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI/AER: Correct function names in the header
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, ruscur@russell.cc,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 25, 2021 at 8:50 AM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/pci/pcie/aer.c:138: warning: expecting prototype for enable_ercr_checking(). Prototype was for enable_ecrc_checking() instead
>  drivers/pci/pcie/aer.c:162: warning: expecting prototype for disable_ercr_checking(). Prototype was for disable_ecrc_checking() instead
>  drivers/pci/pcie/aer.c:1450: warning: expecting prototype for aer_service_init(). Prototype was for pcie_aer_init() instead
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

The subject is somewhat inaccurate, because you're fixing function
names in kerneldoc comments.

If you say "a header", people may think that this is about a header file.

> ---
>  drivers/pci/pcie/aer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ba22388342d1..ec943cee5ecc 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -129,7 +129,7 @@ static const char * const ecrc_policy_str[] = {
>  };
>
>  /**
> - * enable_ercr_checking - enable PCIe ECRC checking for a device
> + * enable_ecrc_checking - enable PCIe ECRC checking for a device
>   * @dev: the PCI device
>   *
>   * Returns 0 on success, or negative on failure.
> @@ -153,7 +153,7 @@ static int enable_ecrc_checking(struct pci_dev *dev)
>  }
>
>  /**
> - * disable_ercr_checking - disables PCIe ECRC checking for a device
> + * disable_ecrc_checking - disables PCIe ECRC checking for a device
>   * @dev: the PCI device
>   *
>   * Returns 0 on success, or negative on failure.
> @@ -1442,7 +1442,7 @@ static struct pcie_port_service_driver aerdriver = {
>  };
>
>  /**
> - * aer_service_init - register AER root service driver
> + * pcie_aer_init - register AER root service driver
>   *
>   * Invoked when AER root service driver is loaded.
>   */
> --
> 2.20.1
>
