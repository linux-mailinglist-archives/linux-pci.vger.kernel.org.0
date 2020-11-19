Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A55C2B91FC
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 13:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgKSMCG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 07:02:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38051 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgKSMCF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2020 07:02:05 -0500
Received: by mail-ot1-f68.google.com with SMTP id 92so1955653otd.5;
        Thu, 19 Nov 2020 04:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3FCDKE+VCsRM90JSTxE2dzcCsYyWKuHRdMqId4kHQ0=;
        b=ddvSt8bDVXC/a+MI2Ud1pMpK0iOBNtKzDnkSbj8fOr5TCbOy5AOddrzmHKvg9HZG3l
         5axMKW9ODpuwCtZWKZ9lE6EAk6gWM6k9cpQYK08gPy6/1dDAwLVNPSRUUnq5ghdr+Wco
         W8cZlAl4j+LdoKbIlgeVjyviw4AlKRUuCwjF8H2ePsqM3Ad6I8PmrhqcSSsXj+2pWPir
         bL/43ILHm5Ogc1Tk3+EHBPs6H8HKnJ/ESc6DeBJLMZH5xq80estjjnAQ8UpXDzZBaAay
         wVov9cIRV8pJkXxRytQOoWpmVdNSeD1J7aQD+HXi67yCRuGwFd56JM97ZsN0BIAehTyz
         4rww==
X-Gm-Message-State: AOAM530LkUMHQDawZpdQW+vIb0uc8MMsLcmP6gGOXnDPGOU6sL/s4RLS
        dE3ovKvOW5CcFSqChKySWw+5fGAbcO1ZvZE3H4U8/d7XIoo=
X-Google-Smtp-Source: ABdhPJyRp3fyzE1WZZOCwmhxBDBzTTJ0WkBzWa5ibJ9UMkHcMlS1dDyvr3/08rWmlFUd+L+mZ1WkpxWtLlt5+pVs9OQ=
X-Received: by 2002:a9d:222f:: with SMTP id o44mr10096245ota.321.1605787324203;
 Thu, 19 Nov 2020 04:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20201119001822.31617-1-david.e.box@linux.intel.com> <20201119001822.31617-2-david.e.box@linux.intel.com>
In-Reply-To: <20201119001822.31617-2-david.e.box@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Nov 2020 13:01:53 +0100
Message-ID: <CAJZ5v0hGhyPySUdabwW5_LhyAKC3A4zdgj7H=55R=Xk3jvt3Yw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Disable Precision Time Measurement during suspend
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 19, 2020 at 1:17 AM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> On Intel client platforms that support suspend-to-idle, like Ice Lake,
> root ports that have Precision Time Management (PTM) enabled can prevent
> the port from being fully power gated, causing higher power consumption
> while suspended.  To prevent this, after saving the PTM control register,
> disable the feature.  The feature will be returned to its previous state
> during restore.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209361
> Reported-by: Len Brown <len.brown@intel.com>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/pci/pci.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6fd4ae910a88..a2b40497d443 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -21,6 +21,7 @@
>  #include <linux/module.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
> +#include <linux/suspend.h>
>  #include <linux/log2.h>
>  #include <linux/logic_pio.h>
>  #include <linux/pm_wakeup.h>
> @@ -1543,7 +1544,7 @@ static void pci_save_ptm_state(struct pci_dev *dev)
>  {
>         int ptm;
>         struct pci_cap_saved_state *save_state;
> -       u16 *cap;
> +       u16 *cap, ctrl;
>
>         if (!pci_is_pcie(dev))
>                 return;
> @@ -1560,6 +1561,17 @@ static void pci_save_ptm_state(struct pci_dev *dev)
>
>         cap = (u16 *)&save_state->cap.data[0];
>         pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);
> +
> +       /*
> +        * On Intel systems that support suspend-to-idle, additional
> +        * power savings can be gained by disabling PTM on root ports,
> +        * as this allows the port to enter a deeper pm state.

I would say "There are systems (for example, ...) where the power
drawn while suspended can be significantly reduced by disabling PTM on
PCIe root ports, as this allows the port to enter a lower-power PM
state and the SoC to reach a lower-power idle state as a whole".

> +        */
> +       if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE &&

AFAICS the target sleep state doesn't matter here, so I'd skip the
check above, but otherwise it LGTM.

> +           pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
> +               ctrl = *cap & ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
> +               pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
> +       }
>  }
>
>  static void pci_restore_ptm_state(struct pci_dev *dev)
> --
