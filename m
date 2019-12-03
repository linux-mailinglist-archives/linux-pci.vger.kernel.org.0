Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 395BF11050C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 20:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLCT1l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 14:27:41 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40969 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfLCT1l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Dec 2019 14:27:41 -0500
Received: by mail-pj1-f66.google.com with SMTP id ca19so1901482pjb.8;
        Tue, 03 Dec 2019 11:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PgT9Sm6MTMXuNLnykZQsd6rodt9b9uQNxM2B4NE8NA=;
        b=DWtDNKTCoDd8AVCIaKWfQfjF6A4gU6y0pXYZm1LWLNrAeN5pJ9Y396tGvuAKw2+hjS
         9I0LbSyqQ7l9MmBlbcleBIcWLxNqWH2bsVLpQ+ej/42KKf0q3gq/rnkxuw6tkqD5Iju4
         MAlpnzmxV8tZ8LLrVN/c+JoRc0dk9pz8WRgp/Y+xcIAGODoylB4pay2xzNuzBhRz2VsS
         95AyBS/cKU80PT2U9kwEHMkM1ATpRNwkmL30hBQckrBKSZq3//5quE+bwi0lOB6eXZMt
         2akPUnbWrXS8XxcfKD5SXmiaP6FvnzlR+5jSGWF7M3GKsCanmAcbZgk34LXmIxqC9Lpv
         2IyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PgT9Sm6MTMXuNLnykZQsd6rodt9b9uQNxM2B4NE8NA=;
        b=lVPPJLKx2uAkeBeV9JvW/RIcaWuIkjlVZnGf5yI6zvI9jjCzvLBCLDCEcPB71D3Kpy
         nByuIoC23mdxSldcTjIeXeap/7F9g9whCJf78haWWtlHO6ImALCo/0aTpMMLXLPwcNSo
         WkqjCVy6yR1m2wItoy43SzdfqmkL1m7erob4epyJwlmkSEgA2t3ofu3LLSKVLBGaIhxy
         DVWCfOOEVsaf7CYdXatnpDb+0wUnZvzpQYLIGhMFAmomrzbtYQigG3TMyVZPBmjYT+BX
         xdsYtn/RdVerN2PfU9HPPszGSPc9fuiUiiHwznmZ+YaLDWrd1MMdrK/9mcCn/+vdaWZC
         kF6w==
X-Gm-Message-State: APjAAAXmp/QKxDq6vRQj+gMWkYcEL9sXP5tC6LNOIwU0fYL095bUbzsF
        CWfE2rDXuppe3er9n6SciygcPp8UCjktsf42w0c=
X-Google-Smtp-Source: APXvYqwc1SheFyTjSmLHWhBW+YXY6ussA8W4aKKbrfYIk26KUHYQylX/y9/Hfdg+UU5PNMTEH5UyuW8U8XCJn2rOjDc=
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr7346216pjb.30.1575401260458;
 Tue, 03 Dec 2019 11:27:40 -0800 (PST)
MIME-Version: 1.0
References: <1575349026-8743-1-git-send-email-srinath.mannam@broadcom.com>
 <1575349026-8743-3-git-send-email-srinath.mannam@broadcom.com> <20191203155514.GE18399@e119886-lin.cambridge.arm.com>
In-Reply-To: <20191203155514.GE18399@e119886-lin.cambridge.arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Dec 2019 21:27:30 +0200
Message-ID: <CAHp75Vf7d=Gw24MTq2q3BKspkLEDDM24GVK4Zh_4zfZEzVuZjw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] PCI: iproc: Add INTx support with better modeling
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
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

On Tue, Dec 3, 2019 at 5:55 PM Andrew Murray <andrew.murray@arm.com> wrote:
> On Tue, Dec 03, 2019 at 10:27:02AM +0530, Srinath Mannam wrote:

> > +     /* go through INTx A, B, C, D until all interrupts are handled */
> > +     do {
> > +             status = iproc_pcie_read_reg(pcie, IPROC_PCIE_INTX_CSR);
>
> By performing this read once and outside of the do/while loop you may improve
> performance. I wonder how probable it is to get another INTx whilst handling
> one?

May I ask how it can be improved?
One read will be needed any way, and so does this code.

> > +             for_each_set_bit(bit, &status, PCI_NUM_INTX) {
> > +                     virq = irq_find_mapping(pcie->irq_domain, bit);
> > +                     if (virq)
> > +                             generic_handle_irq(virq);
> > +                     else
> > +                             dev_err(dev, "unexpected INTx%u\n", bit);
> > +             }
> > +     } while ((status & SYS_RC_INTX_MASK) != 0);

-- 
With Best Regards,
Andy Shevchenko
