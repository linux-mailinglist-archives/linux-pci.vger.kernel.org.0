Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A911941A7
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 15:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgCZOhY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 10:37:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33179 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZOhY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Mar 2020 10:37:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id j1so2880714pfe.0;
        Thu, 26 Mar 2020 07:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xcJ9A36qE7fmwILM0GIjQcoBryZ8cQtpU3R/gSX0bfw=;
        b=Hj+GXpttQEF8xznQ2rVTuxma2i7jZmuN8GRAQn6sIWhgC4o4xDnW7wFusMuV8o2LbI
         bay9pVfypJf/YhGlOzXqqT5xjCRnkIuIUkIZnegDauwEobqVXXbuuS6POybxMyvZl4be
         ScLmbSsGBuJNWfiM60rxOUXURna7W/yXDmnthc8oqsqvzSiMWXGv5fUcrpvpz4bC+Oev
         oLhZEwB8u4qNCz/t8D0bfjrMv3fhzNvzjiAwry9NZO8dtYlB/srOL0h6f9GJB6O/d1jZ
         3OQ77yfP4NQ6Z7AlwktCS3ZTyeQpDKHnMBqewIgpL00cuSh78Ut0k9iYl0hOdolwR6P2
         xZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcJ9A36qE7fmwILM0GIjQcoBryZ8cQtpU3R/gSX0bfw=;
        b=d88pJOOfcCfvIuQNqp/3JuPV7vJgkxEzbvtJ9fiWMi9bPBYybTN47l2P3+/pgMrysG
         zjTMdhCDb/NT12iwadTOzoOYqwYQud4fipuyViRIfxYcDawBTEkrWsWlnEeQS2631glb
         MbG63iaTt4VU38zwI2FUxasN/fTYW1S6uL7elyIYrrkRN3vW/3/xNhT4yulqdvgQMPjb
         PNpP/aK1dqqCE7lgr7+yj6zC+ztuV49ZYtY614iabZjqxcbo75q9zYRnICYpBql94FH5
         erVjcb1Pouh+L2rcDGUJvf4RoXQyppUZLSxUdpiO2+X8Yqeru82RmG/rXWcPKNOQX0k6
         XGtw==
X-Gm-Message-State: ANhLgQ2lfDYYciacU0YJ+6y+kB6FOCeBhlSGA8/2PakTCiWnhBvfF1ca
        ROBa9h41SKXd9K9tlm6n8GiOAHdmIlcfHALUxwM=
X-Google-Smtp-Source: ADFU+vsONeD2TN2CDHUgnVhWVwIcnrhd9OmNhte1Zfml9aKMC9gE+W9zgd27TYvKJYDgdxOIM0foGkFZx1J2fO3yIo0=
X-Received: by 2002:aa7:8149:: with SMTP id d9mr9058526pfn.170.1585233442792;
 Thu, 26 Mar 2020 07:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <1585205326-25326-1-git-send-email-srinath.mannam@broadcom.com> <1585205326-25326-3-git-send-email-srinath.mannam@broadcom.com>
In-Reply-To: <1585205326-25326-3-git-send-email-srinath.mannam@broadcom.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 26 Mar 2020 16:37:15 +0200
Message-ID: <CAHp75VfUCwcXN_OF-tq1wuiCFdicMMEpJpWNccQT=6cv0DNnWQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] PCI: iproc: Add INTx support with better modeling
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 26, 2020 at 8:49 AM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
>
> From: Ray Jui <ray.jui@broadcom.com>
>
> Add PCIe legacy interrupt INTx support to the iProc PCIe driver by
> modeling it with its own IRQ domain. All 4 interrupts INTA, INTB, INTC,
> INTD share the same interrupt line connected to the GIC in the system,
> while the status of each INTx can be obtained through the INTX CSR
> register.

...
> +       val &= ~(BIT(irqd_to_hwirq(d)));

Too many parentheses.

...

> +       val |= (BIT(irqd_to_hwirq(d)));

Ditto.

...

> +       /* go through INTx A, B, C, D until all interrupts are handled */
> +       do {
> +               status = iproc_pcie_read_reg(pcie, IPROC_PCIE_INTX_CSR);
> +               for_each_set_bit(bit, &status, PCI_NUM_INTX) {
> +                       virq = irq_find_mapping(pcie->irq_domain, bit);
> +                       if (virq)
> +                               generic_handle_irq(virq);

> +                       else
> +                               dev_err(dev, "unexpected INTx%u\n", bit);

Any guarantee it will be no storm of undesired messages here?

> +               }

> +       } while ((status & SYS_RC_INTX_MASK) != 0);

' != 0' part is not needed.

If there an interrupt storm the handler will never end, right?
Is it the idea by design?

...

> +       node = of_get_compatible_child(dev->of_node, "brcm,iproc-intc");
> +       if (node)
> +               pcie->irq = of_irq_get(node, 0);
> +
> +       if (!node || pcie->irq <= 0)
> +               return 0;

Perhaps
       node = of_get_compatible_child(dev->of_node, "brcm,iproc-intc");
       if (!node)
               return 0;

       pcie->irq = of_irq_get(node, 0);
       if (pcie->irq <= 0)
              return 0;
?

-- 
With Best Regards,
Andy Shevchenko
