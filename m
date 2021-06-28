Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DF43B5B6B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 11:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhF1Jfn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 05:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhF1Jfi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 05:35:38 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642EEC061574
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 02:33:12 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h2so21403693iob.11
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 02:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+aiQ2ukdg8u/BSZcOQu5XL5M5ZLzOE5atR65oy5RQY=;
        b=BnJfwtF/4KSMo1DL7VYVTosxzJB3HAxJogjj+E+dGsfKYDfyYTf4stNq4ACHlYGtrv
         Xw4IFHkEDz+4rrIgExzV9aKaftXyLJ36Qeskq4ScrzS3AF/Tkc3+IauFj7Dwz7bM/iR+
         XRh6H8PNssM4hHrAt4X6pOzoeKkQdQWdH0zpzRFc5uWMBiWGhWxegQOoLGONMgPAcYVU
         wqlimvYnHnFdOT9pJQAALdSBknW3Ge3owpCmgnorbUjV270ed/ENqj/4qwKbBcxOf8EI
         q1p742gJcUNwPFczXRBxdeVB0+u37ddk4ZZuy+vN8IfuUYqvHVkLGTA6wwxHuJFLd7Rh
         KTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+aiQ2ukdg8u/BSZcOQu5XL5M5ZLzOE5atR65oy5RQY=;
        b=SZzuwq2F/IzwRCWRUc5DfggutfKm7OXpesKserk+26c3C3VQi4V3fG22MPW2+XUBk4
         rI6CQHW1/Ej4ZfFRNef0UDLarqWgp2nLLpX5bq3HoyXv72LBjOMeu2av4/4AE/eQ5kIT
         zFa+C7fG/WOlTQElSbObq/C/IhULi1BjlSI3VHFHWIXjydgTdFQoaSIrQSYILo5V7Bgt
         Kcgzrqw1yqRhSNu/Gk+6S6xV+PmMesafj+UyRWgsILaWAbA3TE6q6m95U/0JG5aBDBPP
         Sv+YxTnbOp0Z8CuDB3xXsOpQvmTvzeD2lLiJDkWTg4DJQgcZ0vemZz0ez5tDt7Hexg2/
         OkAg==
X-Gm-Message-State: AOAM533iTNr9pOHqX2skxDzGwpEFex7ScltdvIVj2o4pGjTgyYnL0tQz
        3PZVAHIwoMFBRO8vwunZ/phBgj7N1Ottn9uc3zo=
X-Google-Smtp-Source: ABdhPJyehWg5QNf6rK3e+L7cVe+Ah/VBk1jioGWeNUlqNOGB0DQ2FCcLYd5wA22SWqwTQJX/5Ae+BD/uHY7ydWnmQBc=
X-Received: by 2002:a05:6638:d4b:: with SMTP id d11mr21824814jak.112.1624872791722;
 Mon, 28 Jun 2021 02:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210625093030.3698570-2-chenhuacai@loongson.cn> <20210625204556.GA3656680@bjorn-Precision-5520>
In-Reply-To: <20210625204556.GA3656680@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 28 Jun 2021 17:32:59 +0800
Message-ID: <CAAhV-H54S3bAw8muCHeaEYn7T6z-um-iLB098HE3es_1gR7-gA@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] PCI/portdrv: Don't disable device during shutdown
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Sinan Kaya <okaya@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Sat, Jun 26, 2021 at 4:45 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jun 25, 2021 at 05:30:27PM +0800, Huacai Chen wrote:
> > Use separate remove()/shutdown() callback, and don't disable PCI device
> > during shutdown. This can avoid some poweroff/reboot failures.
> >
> > The poweroff/reboot failures could easily be reproduced on Loongson
> > platforms. I think this is not a Loongson-specific problem, instead, is
> > a problem related to some specific PCI hosts. On some x86 platforms,
> > radeon/amdgpu devices can cause the same problem [1][2], and commit
> > faefba95c9e8ca3a ("drm/amdgpu: just suspend the hw on pci shutdown")
> > can resolve it.
> >
> > As Tiezhu said, this occasionally shutdown or reboot failure is due to
> > clear PCI_COMMAND_MASTER on the device in do_pci_disable_device() [3].
> >
> > static void do_pci_disable_device(struct pci_dev *dev)
> > {
> >         u16 pci_command;
> >
> >         pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> >         if (pci_command & PCI_COMMAND_MASTER) {
> >                 pci_command &= ~PCI_COMMAND_MASTER;
> >                 pci_write_config_word(dev, PCI_COMMAND, pci_command);
> >         }
> >
> >         pcibios_disable_device(dev);
> > }
> >
> > When remove "pci_command &= ~PCI_COMMAND_MASTER;", it can work well when
> > shutdown or reboot. The root cause on Loongson platform is that CPU is
> > still writing data to framebuffer while poweroff/reboot, and if we clear
> > Bus Master Bit at this time, CPU will wait ack from device, but never
> > return, so a hardware deadlock happens.
>
> Doesn't make sense yet.  Bus Master enables the *device* to do DMA.  A
> CPU can do MMIO to a device, e.g., to write data to a framebuffer,
> regardless of the state of Bus Master Enable.  Also, those MMIO writes
> done by a CPU are Memory Write transactions on PCIe, which are
> "Posted" Requests, which means they do not receive acks.  So this
> cannot be the root cause.
For LS7A, if we disable Bus Master bit when CPU is still accessing
PCIe devices, the PCIe controller doesn't forward requests to
downstream devices, and also doesn't send TIMEOUT to CPU, which causes
CPU wait forever (hardware lockup). This behavior is a PCIe protocol
violation, and will be fixed in new revision of hardware (add timeout
mechanism for CPU read request).

Huacai
>
> Bjorn
