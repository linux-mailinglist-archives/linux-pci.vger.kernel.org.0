Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A45145B8B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2020 19:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgAVS1P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jan 2020 13:27:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35443 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgAVS1P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jan 2020 13:27:15 -0500
Received: by mail-lj1-f195.google.com with SMTP id j1so141397lja.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2020 10:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBMN4EhSOng7OnOM0rFt2rQoKyMKqooeWsHDlQ/9cwM=;
        b=l0BjLgYLS21obPxMv7d6xqzMaOed/W5XTPs9Jiy2R5BcIFcoPH/KAbR0zP72cJuPhM
         6fni2+ohfrz9SGtbVkxchp8s/haS3M73YZjtu7djO8sq/aDCiz60GbWTYw2kbyOsKIHo
         SWbU9PtSdm2UWgu/bArY2QGZaEjTux8sunsCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBMN4EhSOng7OnOM0rFt2rQoKyMKqooeWsHDlQ/9cwM=;
        b=oihlGIkiRrEhQ/i3Ewm7n3rMJmusIG3SyqQDmJcvzBa1XNopofj5OkgkLmvb0rUstO
         UDXSapLKQsD0MCB1cwxvffaFt5lUg6zyq8Wsm/hJdgWE7qgWJlP1Zl3Xsd9zqTgm0t+8
         0n55T/ELS5lPC6bXzPeRZH7TEpS23rHXAR/XFLC/NnWcdHEwsdyCaH4mvreNX/XGAtbx
         W6mboY7b86mEPozitZbUC7lR0SBbsW9mYPhPe+P+ocK8bw3XMHvvKa0d4sjE+Oi3rUdk
         DLNNPku5FnKmbfnSeqxOH91t9k9m79FVdc8TbndVR2uy/ACd55xfzd/QzHCfAPPYVt1d
         Kcig==
X-Gm-Message-State: APjAAAWeFQCn1RVDGArp5ocOuL1eyid/O2/C9WKz9aDz/EO5dhEGLYxx
        Apa0+Lq9Fep+AKveLjj59Ysg8h2hshY=
X-Google-Smtp-Source: APXvYqwKfWrF5EaSlsK8eEMXzaCSu7fzJuBD95465NrC+spWcO6fk1xkVrWy65s3/2/JgQWrK70sVg==
X-Received: by 2002:a2e:9613:: with SMTP id v19mr6480760ljh.47.1579717633300;
        Wed, 22 Jan 2020 10:27:13 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id y14sm20543940ljk.46.2020.01.22.10.27.11
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 10:27:12 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id 203so312274lfa.12
        for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2020 10:27:11 -0800 (PST)
X-Received: by 2002:a05:6512:2035:: with SMTP id s21mr2260437lfs.99.1579717631192;
 Wed, 22 Jan 2020 10:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20200116133102.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <20200122172816.GA139285@google.com>
In-Reply-To: <20200122172816.GA139285@google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 22 Jan 2020 10:26:34 -0800
X-Gmail-Original-Message-ID: <CAE=gft6hvO7G2OrxFGXeSDctz-21ryiu8JSBWT0g2fRFss-pxA@mail.gmail.com>
Message-ID: <CAE=gft6hvO7G2OrxFGXeSDctz-21ryiu8JSBWT0g2fRFss-pxA@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: Avoid torn updates to MSI pairs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 22, 2020 at 9:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Thomas, Marc, Christoph, Rajat]
>
> On Thu, Jan 16, 2020 at 01:31:28PM -0800, Evan Green wrote:
> > __pci_write_msi_msg() updates three registers in the device: address
> > high, address low, and data. On x86 systems, address low contains
> > CPU targeting info, and data contains the vector. The order of writes
> > is address, then data.
> >
> > This is problematic if an interrupt comes in after address has
> > been written, but before data is updated, and the SMP affinity of
> > the interrupt is changing. In this case, the interrupt targets the
> > wrong vector on the new CPU.
> >
> > This case is pretty easy to stumble into using xhci and CPU hotplugging.
> > Create a script that targets interrupts at a set of cores and then
> > offlines those cores. Put some stress on USB, and then watch xhci lose
> > an interrupt and die.
> >
> > Avoid this by disabling MSIs during the update.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> >
> >
> > Bjorn,
> > I was unsure whether disabling MSIs temporarily is actually an okay
> > thing to do. I considered using the mask bit, but got the impression
> > that not all devices support the mask bit. Let me know if this going to
> > cause problems or there's a better way. I can include the repro
> > script I used to cause mayhem if needed.
>
> I suspect this *is* a problem because I think disabling MSI doesn't
> disable interrupts; it just means the device will interrupt using INTx
> instead of MSI.  And the driver is probably not prepared to handle
> INTx.
>
> PCIe r5.0, sec 7.7.1.2, seems relevant: "If MSI and MSI-X are both
> disabled, the Function requests servicing using INTx interrupts (if
> supported)."
>
> Maybe the IRQ guys have ideas about how to solve this?
>

But don't we already do this in __pci_restore_msi_state():
        pci_intx_for_msi(dev, 0);
        pci_msi_set_enable(dev, 0);
        arch_restore_msi_irqs(dev);

I'd think if there were a chance for a line-based interrupt to get in
and wedge itself, it would already be happening there.

One other way you could avoid torn MSI writes would be to ensure that
if you migrate IRQs across cores, you keep the same x86 vector number.
That way the address portion would be updated, and data doesn't
change, so there's no window. But that may not actually be feasible.

-Evan
