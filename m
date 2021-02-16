Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB831CC21
	for <lists+linux-pci@lfdr.de>; Tue, 16 Feb 2021 15:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhBPOh4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Feb 2021 09:37:56 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:45455 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhBPOgz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2021 09:36:55 -0500
Received: by mail-oi1-f175.google.com with SMTP id q186so7434470oig.12;
        Tue, 16 Feb 2021 06:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFEmgM5nd9X4uA88XvE/RcCvbu2mvzrxdiV7SGrmahM=;
        b=YgKS8/7jlF/U851UY7AKnIQyQH5Al4r8Cyq94mX3oRrLCZGVkIlx/v9QVzRWFtvWsc
         NutUjYAiwBa5Dbox5rA9ZBS9Jkn1h8XAv4V/QOxx/Utx0YR+GifT/l+Jov1v0dU7VVkn
         IrQJ5YA4Q4cCuOuGwkjDEbuESIF83yZMtJvogYYEYSHDuAk4ccPgE5+rBGIkugHOXuok
         FuXnFNT2BrtVydkpqlAe70e/elHsKL+qbh4X/K3pIFexxmovU1k2kTCh0uF0bLL0v22x
         ZQAiRM76w5p6kKkEjH2jh6BaoAmY7J8ikviRSM1yJEVmXBrjUfouSd3gXQKah0dv1j2A
         aBFg==
X-Gm-Message-State: AOAM530z/zyPc1pmZvpIZ/BGMmapBgT626aS6P/nhi6fLlmRzLa9Uv7d
        d089zcqjrYKArGoVUlFcP6YBQJCWwqo3m5infak=
X-Google-Smtp-Source: ABdhPJz+vZ1/ZJ/++ZKkEYu+dbOzGcPsUUw86sHhWktYil+PFvSSrzOk8mxOhbjNoo4ewHFCA4eYYn19xlZ7wilAHRM=
X-Received: by 2002:aca:3d85:: with SMTP id k127mr2769075oia.157.1613486173455;
 Tue, 16 Feb 2021 06:36:13 -0800 (PST)
MIME-Version: 1.0
References: <1613443120-4279-1-git-send-email-chen45464546@163.com>
In-Reply-To: <1613443120-4279-1-git-send-email-chen45464546@163.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Feb 2021 15:36:01 +0100
Message-ID: <CAJZ5v0gORvymCwAFD4aAb23NSVSLqaTp34ujU7dX=WtH0cdXfg@mail.gmail.com>
Subject: Re: [PATCH] PCI: hotplug: Remove unused function pointer typedef acpiphp_callback
To:     Chen Lin <chen45464546@163.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen Lin <chen.lin5@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 16, 2021 at 3:40 AM Chen Lin <chen45464546@163.com> wrote:
>
> From: Chen Lin <chen.lin5@zte.com.cn>
>
> Remove the 'acpiphp_callback' typedef as it is not used.
>
> Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/hotplug/acpiphp.h |    3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
> index a2094c0..a74b274 100644
> --- a/drivers/pci/hotplug/acpiphp.h
> +++ b/drivers/pci/hotplug/acpiphp.h
> @@ -176,9 +176,6 @@ struct acpiphp_attention_info
>  int acpiphp_register_hotplug_slot(struct acpiphp_slot *slot, unsigned int sun);
>  void acpiphp_unregister_hotplug_slot(struct acpiphp_slot *slot);
>
> -/* acpiphp_glue.c */
> -typedef int (*acpiphp_callback)(struct acpiphp_slot *slot, void *data);
> -
>  int acpiphp_enable_slot(struct acpiphp_slot *slot);
>  int acpiphp_disable_slot(struct acpiphp_slot *slot);
>  u8 acpiphp_get_power_status(struct acpiphp_slot *slot);
> --
> 1.7.9.5
>
>
