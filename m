Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E711124F5
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2019 09:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfLDIaD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Dec 2019 03:30:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42929 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfLDIaC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Dec 2019 03:30:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id l22so3261071pff.9;
        Wed, 04 Dec 2019 00:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26Svodx2iKimpEDX28qyUXASc5gWZTuY5LBcruAtYsQ=;
        b=KKZ+O0qQLp376LkvoLp+WaBAY1gCrMaSJqGMWi4S6126B1TeH6x48Xb8ngBRJIQc4F
         3QAbr2qXsqfgY6bBbrmVpx7DJZh3AcAVN/OhQxB1W9OpHyvXnlWafkDYFUJUuaxE3lvU
         cCh1rAALzHNb1CE+yvUyA6ql7xgTnsB+XrmeqJYTLh20JxMAm75L8JIRGzvgUrbCsv4e
         B+eaNcCE0NqBZmMcBWbN5onY15Vdj7MydB5ggqh2P+2Y0fQ5o710inQhwTl9o9xz/8ih
         tsaHh/wyC4jr98DqSeZCNAG4QxH/ZlWbuwQ3Nsp25rlkIpeZteEX1q1eLvBFWoliSr0W
         BSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26Svodx2iKimpEDX28qyUXASc5gWZTuY5LBcruAtYsQ=;
        b=Ns26/PsTPjJzt/P2VXQrg2CGAsHaRo7OToaT+9cdKrKErVTlH5OqgCRbOcj5TjF+zE
         K5/YmS+PbO0uyTmFh02umssSp5gk62a3/dU5AHOLbsFJexGZXY6SRatF4kHpPAn2gvvA
         11J/kSDnXppLDw/7qglm6Bi84kU/aJgGcAPLcO9AsIOxbZcixqEtiweXYMLhr/AT32CB
         LyXcOycaAFlnkJSUTn56um3heq22REdu4YruhaeDIDhDtamA8d/jP8Xt0QKYeTr0GryO
         amSbWaKousD2N0B6Xn/2uIGKHs929jXzwMW04ocCwjQqphqrBLi+SdJ3v6wqOM7HVNA9
         +IVA==
X-Gm-Message-State: APjAAAWqaE+EhPsXZRdv8SLNaum1W4ame4Zettqc4TxEnqSWPPORp46o
        qXCuLEn/Rt8SYOZUBoGQpSzh0RfY//malxBn5dA=
X-Google-Smtp-Source: APXvYqzjAZ0vAhPhJSIR2kF3EuRKWdrEJY88vgQI+LDDt1kDWp6YChc0yxSHIbzB8zqEI/D6eXIErZ/TdjfYIfEZpgM=
X-Received: by 2002:a62:1a09:: with SMTP id a9mr2343166pfa.64.1575448202017;
 Wed, 04 Dec 2019 00:30:02 -0800 (PST)
MIME-Version: 1.0
References: <1575349026-8743-1-git-send-email-srinath.mannam@broadcom.com>
 <1575349026-8743-3-git-send-email-srinath.mannam@broadcom.com>
 <20191203155514.GE18399@e119886-lin.cambridge.arm.com> <CAHp75Vf7d=Gw24MTq2q3BKspkLEDDM24GVK4Zh_4zfZEzVuZjw@mail.gmail.com>
 <40fffa66-4b06-a851-84c2-4de36d5c6777@broadcom.com>
In-Reply-To: <40fffa66-4b06-a851-84c2-4de36d5c6777@broadcom.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Dec 2019 10:29:51 +0200
Message-ID: <CAHp75VfyKAg4OhzUa4swGXOGTvJ5fVO8mhGSG=5HAUP__M-URQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] PCI: iproc: Add INTx support with better modeling
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 4, 2019 at 12:09 AM Ray Jui <ray.jui@broadcom.com> wrote:
> On 12/3/19 11:27 AM, Andy Shevchenko wrote:
> > On Tue, Dec 3, 2019 at 5:55 PM Andrew Murray <andrew.murray@arm.com> wrote:
> >> On Tue, Dec 03, 2019 at 10:27:02AM +0530, Srinath Mannam wrote:
> >
> >>> +     /* go through INTx A, B, C, D until all interrupts are handled */
> >>> +     do {
> >>> +             status = iproc_pcie_read_reg(pcie, IPROC_PCIE_INTX_CSR);
> >>
> >> By performing this read once and outside of the do/while loop you may improve
> >> performance. I wonder how probable it is to get another INTx whilst handling
> >> one?
> >
> > May I ask how it can be improved?
> > One read will be needed any way, and so does this code.
> >
>
> I guess the current code will cause the IPROC_PCIE_INTX_CSR register to
> be read TWICE, if it's ever set to start with.
>
> But then if we do it outside of the while loop, if we ever receive an
> interrupt while servicing one, the interrupt will still need to be
> serviced, and in this case, it will cause additional context switch
> overhead by going out and back in the interrupt context.
>
> My take is that it's probably more ideal to leave this portion of code
> as it is.

Can't we simple drop a do-while completely and leave only
for_each_set_bit() loop?

>
> >>> +             for_each_set_bit(bit, &status, PCI_NUM_INTX) {
> >>> +                     virq = irq_find_mapping(pcie->irq_domain, bit);
> >>> +                     if (virq)
> >>> +                             generic_handle_irq(virq);
> >>> +                     else
> >>> +                             dev_err(dev, "unexpected INTx%u\n", bit);
> >>> +             }
> >>> +     } while ((status & SYS_RC_INTX_MASK) != 0);
> >



-- 
With Best Regards,
Andy Shevchenko
