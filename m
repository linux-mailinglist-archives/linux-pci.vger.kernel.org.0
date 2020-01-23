Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C14F01474FC
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 00:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgAWXrZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 18:47:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41216 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgAWXrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2020 18:47:25 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iumBy-0001hK-2a; Fri, 24 Jan 2020 00:47:18 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7A542100490; Fri, 24 Jan 2020 00:47:17 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Evan Green <evgreen@chromium.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH] PCI/MSI: Avoid torn updates to MSI pairs
In-Reply-To: <CAE=gft77xmkc6-4+h3WAp_4C7ra8XKSxcsqrVkBrYgXE0JPeSw@mail.gmail.com>
References: <20200116133102.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid> <20200122172816.GA139285@google.com> <CAE=gft6hvO7G2OrxFGXeSDctz-21ryiu8JSBWT0g2fRFss-pxA@mail.gmail.com> <875zh3ukoy.fsf@nanos.tec.linutronix.de> <CAE=gft7ukQOxHmJT_tkWzA3u2cecmV0Jiq-ukAu-1OR+sPnTtg@mail.gmail.com> <871rrqva0t.fsf@nanos.tec.linutronix.de> <CAE=gft77xmkc6-4+h3WAp_4C7ra8XKSxcsqrVkBrYgXE0JPeSw@mail.gmail.com>
Date:   Fri, 24 Jan 2020 00:47:17 +0100
Message-ID: <87sgk520sa.fsf@nanos.tec.linutronix.de>
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
> On Thu, Jan 23, 2020 at 12:42 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Hrm:
>>
>>         Capabilities: [80] MSI-X: Enable+ Count=16 Masked-
>>
>> So this is weird. We mask it before moving it, so the tear issue should
>> not happen on MSI-X. So the tearing might be just a red herring.
>
> Mmm... sorry what? This is the complete entry for xhci:
>
> 00:14.0 USB controller: Intel Corporation Device 02ed (prog-if 30 [XHCI])
>         Subsystem: Intel Corporation Device 7270
>         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 124
>         Region 0: Memory at d1200000 (64-bit, non-prefetchable) [size=64K]
>         Capabilities: [70] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                 Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
>         Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
>                 Address: 00000000fee10004  Data: 402a
>         Capabilities: [90] Vendor Specific Information: Len=14 <?>
>         Kernel driver in use: xhci_hcd

Bah. I was looking at the WIFI for whatever reason.

Thanks,

        tglx
