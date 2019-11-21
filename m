Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 327E3105891
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 18:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKUR1m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 12:27:42 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46157 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUR1l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 12:27:41 -0500
Received: by mail-qt1-f194.google.com with SMTP id r20so4493914qtp.13;
        Thu, 21 Nov 2019 09:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=qvOc5NJAoRk1lKd0zuGy/QWyPsD19HdntSn8ncY4eh4=;
        b=aEfQVFF8kPbPGpZUlERBXWB7bZh7WT32HFjWd8KOMxJDjLPszbvXq6CbdiTzH6w8IO
         xiqZOJYVifu0viiAOslo4NIdv7wQNjzGufHkUHXR9gX+0uCb9sVajAFV1wk9vQgYHn4C
         7zcdq5q3TvkrqkXKfOynNgbkqvX7fZPKtitppm5qmjXxdDLgE9YmCGIVJaNC0Dz2pB+m
         CqOsXNPuAwp5GuPzL+oM16VKOZSAwumTPm1iZouKVDIA8p67MRmaIUXb5ONenpQw/sic
         AaH9IKIefMkXX/3HL6cEhBteX5Ka+r0bT3R0H2sidefLrAMa5qTA03oBv60ywisLdGvr
         7z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=qvOc5NJAoRk1lKd0zuGy/QWyPsD19HdntSn8ncY4eh4=;
        b=q6+H/emN02GxSU5IRiwpBsjNl/MWzxpw59Dv9ZFBrbPO80AjUK/pYaaqbV2lhMRAz/
         OKtFDp/ShJArcv4VK6xkBn7ZEBAarrQWWUSFP58frlzVgpZSgtA+oStpavANI5tQTnxG
         MZhnebMqksHhiP3zEJIblL9UmQIJnaXtbFdYDi8DxeEtp3Ek3yEY7t36gWSfiYbYlxwb
         UsAk/CbM2Sb4riCATFlRIJxWSGgOtqGws77d5EE1VLZOjn/FH0Z5onxhAFa4ljSEoxSN
         W2z1kLsiFW6NGIcOLvLqkzOV3ananwfKI0lqwU8Xfux1ccGnapdPUsQpJBksQJLJTwXU
         mygA==
X-Gm-Message-State: APjAAAUDa2eR2x1kx1bLy7L+H3H6lFDmJ3j2AF1ydKkVtISiiT+ly8bn
        hxPM7ZIWc74q6L3qkaLs7eMj5EOsn/z6ceetJ/a81Asi
X-Google-Smtp-Source: APXvYqy6sNeofRpjBDv1sls1zFk8YmJyY50xY02dgFXPejbZOer/t4Q5bJKCiUWp0Hjt3MbPceOoj1dOk0uGXzzJr+o=
X-Received: by 2002:ac8:6f25:: with SMTP id i5mr9179307qtv.321.1574357259025;
 Thu, 21 Nov 2019 09:27:39 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2oMhLLaguZMMaescENDUOmNm=WmZLjsO0BjK1-g_ro5AOOMQ@mail.gmail.com>
 <CAJ2oMhJvks=++wMGYpA_Q_+Gytwb0nFz3jieRzM1rrdUJKHYLA@mail.gmail.com>
In-Reply-To: <CAJ2oMhJvks=++wMGYpA_Q_+Gytwb0nFz3jieRzM1rrdUJKHYLA@mail.gmail.com>
From:   Ranran <ranshalit@gmail.com>
Date:   Thu, 21 Nov 2019 19:27:27 +0200
Message-ID: <CAJ2oMhL6fubnCSBMKKH9qsHjJTZhrz2HwgFbG=RgSzmJzeoNWw@mail.gmail.com>
Subject: Re: crash on getting interrupt from uio_generic_pci
To:     linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I have sent the question too early.
Let me give more details:
I use uio_pci_generic, and it catch the interrupts, but does not
deliver them to userspace:

/* Interrupt handler. Read/modify/write the command register to disable
 * the interrupt. */
static irqreturn_t irqhandler(int irq, struct uio_info *info)
{
        struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
<<--- interrupt is catched here
        if (!pci_check_and_mask_intx(gdev->pdev))
                return IRQ_NONE;
<<--- But we never get here
        /* UIO core will signal the user process. */
        return IRQ_HANDLED;
}

Is there any reason why pci_check_and_mask_intx fails ?

Thanks

On Thu, Nov 21, 2019 at 6:04 PM Ranran <ranshalit@gmail.com> wrote:
>
> it's been sent too soon , sorry.
> kernel version:
> 86_64 x86_64 GNU/Linux
> [root@localhost devmem2]# uname -a
> Linux localhost.localdomain 4.18.16 #4 SMP Thu Nov 21 17:10:34 IST
> 2019 x86_64 x86_64 x86_64 GNU/Linux
> [root@localhost devmem2]#
>
> Thank you for any  ideas,
> Ran
>
> On Thu, Nov 21, 2019 at 6:02 PM Ranran <ranshalit@gmail.com> wrote:
> >
> > Hello,
> >
> > I use FPGA with PCIe, and we try to simulate interrupt.
> > uio_generic_pci is the kernel pci driver.
> >
> > On receiving interrupt there is a crash:
> >
> > I get the following exception:
> > What do you want to do today ? [  384.696015] irq 23: nobody cared
> > (try booting with the "irqpoll" option)
> > [  384.703048] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G           OE
> >   4.18.16 #3
> > [  384.710799] Hardware name:  /conga-MA5, BIOS MA50R000 10/30/2019
> > [  384.717083] Call Trace:
> > [  384.719643]  <IRQ>
> > [  384.721761]  dump_stack+0x5c/0x80
> > [  384.725224]  __report_bad_irq+0x35/0xaf
> > [  384.729234]  note_interrupt.cold.9+0xa/0x63
> > [  384.733612]  handle_irq_event_percpu+0x68/0x70
> > [  384.738239]  handle_irq_event+0x37/0x57
> > [  384.742262]  handle_fasteoi_irq+0x97/0x150
> > [  384.746560]  handle_irq+0x1a/0x30
> > [  384.750021]  do_IRQ+0x44/0xd0
> > [  384.753132]  common_interrupt+0xf/0xf
> > [  384.756979]  </IRQ>
> > [  384.759181] RIP: 0010:cpuidle_enter_state+0x7d/0x220
> > [  384.764368] Code: e8 d8 19 45 00 41 89 c4 e8 30 50 b1 ff 65 8b 3d
> > 99 db 85 7e e8 a4 4e b1 ff 31 ff 48 89 c3 e8 4a 61 b1 ff fb 66 0f 1f
> > 44 00 00 <48> b8 ff ff ff ff f3 01 00 00 4c 29 eb ba ff ff ff 7f 48 89
> > d9 48
> > [  384.784119] RSP: 0018:ffffb068c06afea8 EFLAGS: 00000286 ORIG_RAX:
> > ffffffffffffffda
> > [  384.792032] RAX: ffff96977fca14c0 RBX: 0000005991ab33dd RCX: 000000000000001f
> > [  384.799495] RDX: 0000005991ab33dd RSI: 0000000000000000 RDI: 0000000000000000
> > [  384.806955] RBP: ffff96977fcab300 R08: 000000977b372895 R09: 0000000000000006
> > [  384.814446] R10: 00000000ffffffff R11: ffff96977fca05a8 R12: 0000000000000001
> > [  384.821900] R13: 0000005991ab220e R14: 0000000000000001 R15: 0000000000000000
> > [  384.829346]  ? cpuidle_enter_state+0x76/0x220
> > [  384.833886]  do_idle+0x221/0x260
> > [  384.837258]  cpu_startup_entry+0x6a/0x70
> > [  384.841366]  start_secondary+0x1a4/0x1f0
> > [  384.845465]  secondary_startup_64+0xb7/0xc0
> > [  384.849849] handlers:
> > [  384.852233] [<000000007a5bed83>] uio_interrupt
> > [  384.856892] Disabling IRQ #23
> >
> > kernel version:
