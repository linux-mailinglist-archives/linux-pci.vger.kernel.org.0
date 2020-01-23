Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51E7A1463DC
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 09:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgAWItS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 03:49:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39449 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWItS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2020 03:49:18 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iuYAs-0004XP-GY; Thu, 23 Jan 2020 09:49:14 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C70011008DD; Thu, 23 Jan 2020 09:49:13 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Evan Green <evgreen@chromium.org>, Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
In-Reply-To: <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid> <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com> <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
Date:   Thu, 23 Jan 2020 09:49:13 +0100
Message-ID: <87y2tytv5i.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Evan Green <evgreen@chromium.org> writes:
> In my experiments, the driver no longer misses the interrupt. XHCI is
> particularly sensitive to this, if it misses one interrupt it seems to
> completely wedge the driver.

That does not make the approach more correct.

> I think in my case the device pends the interrupts until MSIs are
> re-enabled, because I don't see anything other than MSI for xhci in
> /proc/interrupts. But I'm not sure if other devices may fall back to
> line-based interrupts for a moment, and if that's a problem.

Yes they can according to standard and it _IS_ a problem.

> Although, I already see we call pci_msi_set_enable(0) whenever we set
> up MSIs, presumably for this same reason of avoiding torn MSIs.

Please stop making random assumptions. This as absolutely nothing to do
with torn MSIs. The way how MSI setup works requires this. And this is
happening on init _before_ any interrupt can be requested on the device.
Different reason, different context.

> So my fix is really just doing the same thing for an additional
> case.

No, it's absolutely not the same. Your device is active and not in
reset/init state.

> And if getting stuck in a never-to-be-handled line based interrupt
> were a problem, you'd think it would also be a problem in
> pci_restore_msi_state(), where the same thing is done.

Again. I told you already it's not the same thing.

> Maybe my fix is at the wrong level, and should be up in
> pci_msi_domain_write_msg() instead? Though I see a lot of callers to
> pci_write_msi_msg() that I worry have the same problem.

This is not yet debugged fully and as this is happening on MSI-X I'm not
really convinced yet that your 'torn write' theory holds.

Thanks,

        tglx
