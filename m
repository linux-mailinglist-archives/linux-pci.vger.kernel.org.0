Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E31278DD8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 18:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgIYQPo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 12:15:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40989 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgIYQPn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 12:15:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id x69so3313519oia.8;
        Fri, 25 Sep 2020 09:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOXpo4MBWIKdAj2YTS1Md9BASeJ0w+Pyx3kKYD3oYVQ=;
        b=oIBIWsKlvXr13iovSxmFyUothUNUKa+aN9mxZ8WdVu/DOcpRDCG0X2Jox8rTGmoOAi
         cZDI4KHXpZF5X49SLNKv3KEfPZYEO46pyuFUPf390CakNXwYswpgiT+i8dSR6tLDd0pV
         rQeqvTSLukpAVPCea4nQNh/LA2dcbHLsNbk4uLHoJrEWpYVu+41S+SSnSFps/BR4NQId
         K17nhgRC4DYmkGYkszbGWxgj4j9Y1+piwxn0KdPy9RQSI0P95YmD3B+DMojk9+5+KCvl
         U5zBQBYaJad5/oyeQtGQOBHKYUZMwKyH9cdjLzHo6MPlgBnhua1Mr8YvokkSGewt83Ta
         gQiw==
X-Gm-Message-State: AOAM533cRvHanJkmIEjDzLHsqYWTUv8qtDZfjp7YKcT2HBX6AokguDcJ
        0Tid4JqopLKJC5LjXhVxCbnuA9CmMt4n0VdF+VY=
X-Google-Smtp-Source: ABdhPJx5UX7kity3V2dBJf1+PFCSGCK75p12z6fHS8h4OPobc46h2wvFxrM4n5apwd0CUZgZ6ut5dIiUc75C7RxTtY8=
X-Received: by 2002:aca:5b09:: with SMTP id p9mr68445oib.68.1601050542827;
 Fri, 25 Sep 2020 09:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <1600741945-38474-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1600741945-38474-1-git-send-email-tiantao6@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 18:15:31 +0200
Message-ID: <CAJZ5v0jGyX=51HvTQ6SF1y-YE=nd0uf-W6n59Etp8K8gkk6nCg@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: update kernel-doc line comments
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 4:35 AM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> Update kernel-doc line comments to fix warnings reported by make W=1.
> drivers/acpi/pci_root.c:71: warning: Function parameter or
> member 'handle' not described in 'acpi_is_root_bridge'
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/acpi/pci_root.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index f90e841..8b81280 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -62,7 +62,7 @@ static DEFINE_MUTEX(osc_lock);
>
>  /**
>   * acpi_is_root_bridge - determine whether an ACPI CA node is a PCI root bridge
> - * @handle - the ACPI CA node in question.
> + * @handle:  the ACPI CA node in question.
>   *
>   * Note: we could make this API take a struct acpi_device * instead, but
>   * for now, it's more convenient to operate on an acpi_handle.
> --

Applied as 5.10 material with minor edits in the subject and changelog, thanks!
