Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3985F145B45
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2020 19:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgAVSBj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jan 2020 13:01:39 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41595 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVSBj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jan 2020 13:01:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so280928lfp.8
        for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2020 10:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ve6hAdMotmeqWUy7rZgNLYw8FBj8creK8SvepbZVV/4=;
        b=cljBKZe/KhdmnH6JgB6QD1OQKOXQmzpc+CIplxIB1wb6JuPEscasAxY1yPfh3nBF+E
         ei/5n4BhrxodchC7RX+Y9yEo+HlIgvwB8IM/XmSIIelWMBvSoeBKa0+Lb3kydKEZCie6
         J2orWaCGI/gMymrkpVBPNFKM4eGakuSWSQQVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ve6hAdMotmeqWUy7rZgNLYw8FBj8creK8SvepbZVV/4=;
        b=afn0+nK2/gx7bVeCxhkzVbuTVKy2EzBqmQRDHucWwkqN8lWpaaP1PPuCcPC9zl5Ffi
         e7wRIDKJyGLSZpZUT/HIHmhJyejCkXTaMRkUn+bbhBbC7UXuiRDzUdR2csPA7E7Z0YCi
         04I9//I16iieVk9oDZZJ0VQYkrhJMRlr6U/slJRi/pdCyoGvRYsDuCYE11BTkgtjVnzI
         nuXr8eVNhTvud+8Q2BS7/N2Ygf9ZwwVia3BxEzxpIrULHfUNhSIMQiynP+jc4oyKbRza
         ol5AKE1+7HwiMDsyx0hPn0vDPbyPwlPqiNSYa7FAhmmHq4Ti52uZ5O45Bw+hy49VDCcn
         pnpw==
X-Gm-Message-State: APjAAAVGT+NAfWmoXGtiaXUHMx1PxJQrd76+KGNIbV68BWu85nvIhk1l
        RFU0VzhGFthZiuZpd/6fvnIqmNdPFns=
X-Google-Smtp-Source: APXvYqzQACIBmkG0dZFvV0qy3qIw/zBKtaH8A7n+8U1NfQHu150H/o55fqAbjeB63PfVLtCtfX7BVg==
X-Received: by 2002:a19:7401:: with SMTP id v1mr2489516lfe.129.1579716096503;
        Wed, 22 Jan 2020 10:01:36 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id z3sm20786345ljh.83.2020.01.22.10.01.35
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 10:01:35 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id y1so289679lfb.6
        for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2020 10:01:35 -0800 (PST)
X-Received: by 2002:a05:6512:2035:: with SMTP id s21mr2211453lfs.99.1579716095165;
 Wed, 22 Jan 2020 10:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com>
In-Reply-To: <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 22 Jan 2020 10:00:59 -0800
X-Gmail-Original-Message-ID: <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
Message-ID: <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 22, 2020 at 3:26 AM Rajat Jain <rajatja@google.com> wrote:
>
> On Fri, Jan 17, 2020 at 4:26 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > __pci_write_msi_msg() updates three registers in the device: address
> > high, address low, and data. On x86 systems, address low contains
> > CPU targeting info, and data contains the vector. The order of writes
> > is address, then data.
> >
> > This is problematic if an interrupt comes in after address has
> > been written, but before data is updated, and both the SMP affinity
> > and target vector are being changed. In this case, the interrupt targets
> > the wrong vector on the new CPU.
> >
> > This case is pretty easy to stumble into using xhci and CPU hotplugging.
> > Create a script that repeatedly targets interrupts at a set of cores and
> > then offlines those cores. Put some stress on USB, and then watch xhci
> > lose an interrupt and die.
>
> Do I understand it right, that even with this patch, the driver might
> still miss the same interrupt (because we are disabling the interrupt
> for that time) -  the improvement this patch brings is that it will at
> least not be delivered to the wrong CPU or via a wrong vector?

In my experiments, the driver no longer misses the interrupt. XHCI is
particularly sensitive to this, if it misses one interrupt it seems to
completely wedge the driver.

I think in my case the device pends the interrupts until MSIs are
re-enabled, because I don't see anything other than MSI for xhci in
/proc/interrupts. But I'm not sure if other devices may fall back to
line-based interrupts for a moment, and if that's a problem.

Although, I already see we call pci_msi_set_enable(0) whenever we set
up MSIs, presumably for this same reason of avoiding torn MSIs. So my
fix is really just doing the same thing for an additional case. And if
getting stuck in a never-to-be-handled line based interrupt were a
problem, you'd think it would also be a problem in
pci_restore_msi_state(), where the same thing is done.

Maybe my fix is at the wrong level, and should be up in
pci_msi_domain_write_msg() instead? Though I see a lot of callers to
pci_write_msi_msg() that I worry have the same problem.
-Evan
