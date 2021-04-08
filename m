Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AE635880D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 17:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhDHPTO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 11:19:14 -0400
Received: from mail-oo1-f46.google.com ([209.85.161.46]:46624 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbhDHPTI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 11:19:08 -0400
Received: by mail-oo1-f46.google.com with SMTP id 125-20020a4a1a830000b02901b6a144a417so578695oof.13;
        Thu, 08 Apr 2021 08:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBesEj2fSrr43l9kt9D4AtU33PrnTTnDZIAdB81qk+I=;
        b=B3qsHKK2TooeVj9GZujny0vQo3dEiZ/gZz3nC9nzTfA6UVO6gZ+yKe6uHvv4EnvwyD
         gXdSTrIN5WEjyTM7Rx9DMFPyiyXoG47kyeB9nSdSri2Vmhh5Qn5mUTMDMvjVtWxswdLS
         kG46vCHxPRuJMcl3aYlWoE8vaLTIv/5WmuAIxKz2r1BjjqlcCfKiilA44AYKcCfv80Ns
         m1lFtL2avxe/f0SysLxToEi/mtD07ueJY6dvxwqHv4dsQV8ohzfSQ1OFLHZIAKz4l/LH
         RGuJtcXcG66IbKMf1X1FYhupa2lQzwWWq4S1I5+usuK6H8nd14b2poTzmVJysOwxe3Rg
         P7MQ==
X-Gm-Message-State: AOAM531OQMHU5I+jptwEeTjSZYhLCiW+r5B/oKeo2Y2rNUmVExmSpxQH
        Pix5H/ZsoI6D55sLx/lNEJiEetLujcAkQG9ltPG1l7HF
X-Google-Smtp-Source: ABdhPJwVEMJhK8+sgSmB9cm72hb4M6W0oHnJovlQTNy7RP187o2yTsTnPnRWXrah2/JAZTIkhMHC1ggeWpqDECdKj+o=
X-Received: by 2002:a4a:d48b:: with SMTP id o11mr7919111oos.2.1617895137220;
 Thu, 08 Apr 2021 08:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <b411af88-5049-a1c6-83ac-d104a1f429be@huawei.com>
In-Reply-To: <b411af88-5049-a1c6-83ac-d104a1f429be@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 17:18:46 +0200
Message-ID: <CAJZ5v0j2a803ye6KYzM9dZ_inCTqiwmN7UvAdYeynk+A9F97Fg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / hotplug / PCI: fix memory leak in enable_slot()
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 25, 2021 at 8:27 AM Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
>
> From: Feilong Lin <linfeilong@huawei.com>
>
> In enable_slot() in drivers/pci/hotplug/acpiphp_glue.c, if pci_get_slot()
> will return NULL, we will do not set SLOT_ENABLED flag of slot. if one
> device is found by calling pci_get_slot(), its reference count will be
> increased. In this case, we did not call pci_dev_put() to decrement the
> its reference count, the memory of the device (struct pci_dev type) will
> leak.
>
> Fix it by calling pci_dev_put() to decrement its reference count after that
> pci_get_slot() returns a PCI device.
>
> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> --
> v2: rewrite subject and commit log as suggested by Bjorn Helgaas.

The fix is correct AFAICS, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Bjorn, has this been applied already?  If not, do you want me to take
it or are you going to queue it up yourself?

> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 3365c93abf0e..f031302ad401 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -533,6 +533,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>                         slot->flags &= ~SLOT_ENABLED;
>                         continue;
>                 }
> +               pci_dev_put(dev);
>         }
>  }
>
> --
> 2.19.1
>
