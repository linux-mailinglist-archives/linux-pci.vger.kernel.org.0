Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB6715D536
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2020 11:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgBNKHE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Feb 2020 05:07:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38402 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgBNKHE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Feb 2020 05:07:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so6373188lfm.5
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2020 02:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PF0NRy8tZyvvpgLnBQvTlSYjFAcSskLV9npM91USJ0s=;
        b=wqgfTzWWtdUB2tcvSjtus2pApE3NEoErHGmdjE8uqp7oNfwlkrgb4DdWCFnu72+KUX
         soLifCCg7wB2r6O9j4Hwv64jtw23T/yr8J1zEv5BBFu+LoI8UdhQejWTF6Y++vwfcRJQ
         kdLrBitmeLNwxXRSbLe4UWVQm3i1EbrG/QXzfaEryULXz35DXbF8DTEiE/I5UYOnaqGK
         APHGGSEXLkWjQiDdtnywj+g/mVT0J3K8IFJqC4hdk3/2s5X2dMRC11oStFntUlJ+Yxq5
         JDjHnsxvI1Z2qOAZyn68oFE6RdjCqZDXEA84i4QCQxOj23JytEAaX1cP5mNK2r0+EEC1
         rrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PF0NRy8tZyvvpgLnBQvTlSYjFAcSskLV9npM91USJ0s=;
        b=ALrbhqugSKgGqm6VjGju31lrRZ9/ABCRcrr/XtuTV0qz+GwQytqrdFwlnvSsQ04Zyn
         5zPxTxRhcbO2hQa34yPVvYJdxGSiJpOFbOvH7MXtRFuExuECwDG9hnAo0CRppC5dR6k1
         lANQ1e/ribD8rmEUNw1JEql3i2rco4dRJItbTr9XEHTHdoVegar2fvPWZGYw+DF1w+Go
         u5mL79AT0wItnNYZDLRubtRKUc88Iua1pjMa6jutGjws8d12gQ6Q43Ys8CvOIWLFib29
         hEdPm3pA77c0dRMqGykX/zF7cGlSmOlHnVXu/D0tqYYWPc6su/zEoI5F0sWT2/Hb9Jfw
         LTDA==
X-Gm-Message-State: APjAAAWjVI80G7rnGn4q9ztk7e4wQ2IUe+f3wlyh7a1qn0l+vdKs22Mj
        N4Mzn022/40e4u7KL2V1KIzuSyJzdLieFoIZbT6+CQ==
X-Google-Smtp-Source: APXvYqwE618D6QwS2Ce8nucFnlwDx6s7EvaNXbOiSXAXTaOfY+ikeQ/Ec+btsxjmHTDjr3We9CqYZ1Swq0N8vcABlGI=
X-Received: by 2002:ac2:5499:: with SMTP id t25mr1304752lfk.194.1581674822115;
 Fri, 14 Feb 2020 02:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20200213025930.27943-1-jaedon.shin@gmail.com> <20200213025930.27943-3-jaedon.shin@gmail.com>
In-Reply-To: <20200213025930.27943-3-jaedon.shin@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Feb 2020 11:06:51 +0100
Message-ID: <CACRpkdZ9A_SJzxQ__f0oani+A97N3yLT3=oJ8z3vNJ5Ucyo8vA@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: brcmstb: Add regulator support
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jaedon,

thanks for your patch!

On Thu, Feb 13, 2020 at 3:59 AM Jaedon Shin <jaedon.shin@gmail.com> wrote:

> +#ifdef CONFIG_REGULATOR
> +       int                     num_regs;
> +       struct regulator        **regs;
> +#endif

Is this #ifdef:in necessary? Since the regulator framework provides
stubs if compiled out, I think you can just include all code
unconditionally and it will work fine anyway.

> +static void brcm_pcie_regulator_enable(struct brcm_pcie *pcie)
> +static void brcm_pcie_regulator_disable(struct brcm_pcie *pcie)
> +static void brcm_pcie_regulator_init(struct brcm_pcie *pcie)

I would replace the word "regulator" with "power" here to indicate
what it is about (easier to read).

> +       struct device_node *np = pcie->dev->of_node;
> +       struct device *dev = pcie->dev;
> +       const char *name;
> +       struct regulator *reg;
> +       int i;
> +
> +       pcie->num_regs = of_property_count_strings(np, "supply-names");
> +       if (pcie->num_regs <= 0) {
> +               pcie->num_regs = 0;
> +               return;
> +       }
> +
> +       pcie->regs = devm_kcalloc(dev, pcie->num_regs, sizeof(pcie->regs[0]),
> +                                 GFP_KERNEL);
> +       if (!pcie->regs) {
> +               pcie->num_regs = 0;
> +               return;
> +       }
> +
> +       for (i = 0; i < pcie->num_regs; i++) {
> +               if (of_property_read_string_index(np, "supply-names", i, &name))
> +                       continue;
> +
> +               reg = devm_regulator_get_optional(dev, name);
> +               if (IS_ERR(reg))
> +                       continue;
> +
> +               pcie->regs[i] = reg;
> +       }
> +}

So what this does is just grab any regulators, no matter what they are
named, and enable them? The swiss army knife used is the raw
of_* parsing functions.

I don't think that is very good practice.

First define very cleanly what regulators exist in the device tree bindings.
If the set of regulators differ between variants, then key that with the
compatible value.

Then explicitly grab the resources by name, using the
regulator_bulk_get() API, which will transparently grab the
regulators for you from the device tree.

Then use regulator_bulk_[enable|disable]
 to enable/disable the regulators.

git grep in the kernel tree for good examples!

Also involve the regulator maintainer in the review. (I added
him on the To: line.)

Yours,
Linus Walleij
