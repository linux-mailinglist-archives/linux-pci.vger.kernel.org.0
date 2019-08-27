Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31CA9F70E
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 01:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfH0Xtz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 19:49:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42713 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfH0Xtz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 19:49:55 -0400
Received: by mail-io1-f65.google.com with SMTP id e20so2107260iob.9;
        Tue, 27 Aug 2019 16:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XBFwuMKfumEhxRWqgIeR0uvd9esOyws4MEYWvL7oIW8=;
        b=OiWOyyjtMAR91TWRb1eDNamRNVNreeIIamMyH6N1NauOVAC2Neqf++DG7DOjmbtzDY
         SeTz8LOCuDvllOOnGHMXLa7MATVs4oN+L5qN+fuCSr0fp9lzACVdS6jgd7HMaAtQN+/b
         EY2D6FkLLzHsYz8B8OYcjh25dH4+K8Jrb38nGje1dkxwCN9q3vHm/paLAbPyWM4BcYKy
         AFIo1ERmcmF6RG1tDIE9BxkU1fOtpyYirg49nmCNUk/r7GXWuSeU9xkpbrECV88bZok/
         oQXA8qN1jqP0ePXubCgaN7igWMJunH1TYvz1fZb/Y7SyFaOU6ZMTZP9BlyjLzwDLpsn6
         vcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XBFwuMKfumEhxRWqgIeR0uvd9esOyws4MEYWvL7oIW8=;
        b=DorldATJLdhqusRDrSNVg38OmOROUoeuCQsQ2xR3FaV50Acp37CebZCtxjbFkhwXu/
         FoWg0WCUzH8kVtFSTE4zY/vJx1DiLeV0FApa0FbPYQBdOsXxcpSjd5w3l6TNiLMlH9IU
         9NKf+/AlwkRxnTo32vuxwIL4w6GQxS1PEVaPaSKh4bGaYKqsTUv/vmU+RP98an8/pp0u
         l8UxP5AzWhYrOeZLp7+wABlR4EMUUF6/A2xjE3q3WkVfE4aHMotGiAgMYSf0MgTruL8b
         HZk9MeFre+tlkVZb+DOUyall0TGnxInlgJzG+wBJ+16EQS+x4thDb0kTYsfMQui/KH+a
         CPSg==
X-Gm-Message-State: APjAAAWA3ZyS+J3ZGwTLZRYL8P+dqassbzc7exXTN72ca4mLu+szDz6V
        f8dnW40y9Ap2CizCstVpXfj1xojY+H+Fe2c2xnXUXbFW
X-Google-Smtp-Source: APXvYqwT/z7EyqXsu9ad6rpgahJJ6Moy7n0m6yeh1ch5RhJiMCakDiIhBX4R4KjEO2KJBKf0kRp8HcFaCRpZJHfBq/4=
X-Received: by 2002:a02:9a12:: with SMTP id b18mr1592753jal.70.1566949794676;
 Tue, 27 Aug 2019 16:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190819160643.27998-1-efremov@linux.com> <20190819160643.27998-5-efremov@linux.com>
In-Reply-To: <20190819160643.27998-5-efremov@linux.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 28 Aug 2019 09:49:43 +1000
Message-ID: <CAOSf1CFoEaeZ4xVpEUtNCp1i7O6ebfUotZeNJRep_+zRSoVziw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] PCI: pciehp: Remove pciehp_green_led_{on,off,blink}()
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 2:09 AM Denis Efremov <efremov@linux.com> wrote:
>
> Remove pciehp_green_led_{on,off,blink}() and use pciehp_set_indicators()
> instead, since the code is mostly the same.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  drivers/pci/hotplug/pciehp.h      |  3 ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 12 ++++++++---
>  drivers/pci/hotplug/pciehp_hpc.c  | 36 -------------------------------
>  3 files changed, 9 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index acda513f37d7..da429345cf70 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -170,9 +170,6 @@ void pciehp_get_power_status(struct controller *ctrl, u8 *status);
>  void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
>  void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
>  int pciehp_query_power_fault(struct controller *ctrl);
> -void pciehp_green_led_on(struct controller *ctrl);
> -void pciehp_green_led_off(struct controller *ctrl);
> -void pciehp_green_led_blink(struct controller *ctrl);
>  bool pciehp_card_present(struct controller *ctrl);
>  bool pciehp_card_present_or_link_active(struct controller *ctrl);
>  int pciehp_check_link_status(struct controller *ctrl);
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 232f7bfcfce9..862fe86e87cc 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -65,7 +65,9 @@ static int board_added(struct controller *ctrl)
>                         return retval;
>         }
>
> -       pciehp_green_led_blink(ctrl);
> +       pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
> +                             PCI_EXP_SLTCTL_ATTN_IND_NONE);

I think it woud be good if you provided a helper macro for setting one
of the indicators rather than open coding the _NONE constant. e.g.

#define set_power_indicator(ctrl, x) pciehp_set_indicators(ctrl, (x),
PCI_EXP_SLTCTL_ATTN_IND_NONE);

then you can do:

set_power_indicator(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK);

which is a bit nicer to read.
