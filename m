Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D3EE78BB
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 19:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfJ1Ssl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 14:48:41 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43928 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfJ1Ssl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 14:48:41 -0400
Received: by mail-il1-f194.google.com with SMTP id t5so9093619ilh.10
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2019 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=JzznFmMEa3nFhvxe+SOFTdMG2gV9oPstf2fpvnaa9D4=;
        b=uCIX07k0jxYfdS8cesyG3Cx0ZgY1wALLkO7L/vDFkNntci0aSzna4tnpXkvUnMRijQ
         hZ+6gVQ5/nR/qkZEmqEpvUmhB/tf5a/bUW3mo12xgbgFMbe8EOPU8st1zTf+wUWLSbIR
         37mz5+/RWf0/TEIOKwoiSXCXWmqr8JP/3g0HpGbwCkVBahoZWI3G9aeZjxsjGCvm1Ilc
         c5UK3nzhbxA9wBV8eBleqzjeOo/H1tYpKR0kiAK8Q+OofJH7B7Ut8c6sOAAux6S34qrN
         I9coPjmB5zelqMhs9OWsPeu5Uk5ZhA3EqWHH/KKHDln/4dPpabgwni/M9YSXx+GjVRIj
         Uhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=JzznFmMEa3nFhvxe+SOFTdMG2gV9oPstf2fpvnaa9D4=;
        b=clWk+9uYb0Vbyc/i/9TrS5s0b59ukmyUi1pHBK5kKeIc/wElt5G5Rcw46u5lki0C5n
         joQ5qqdccNtR0gc/H9/5eHpka+ThQ7WYNTUa91FHdQrE1ooDgV+VVvy1oOsqu30CqOvC
         EPeMhgokDDBs44DXp8wBRmM79EW543VksrQ/MvdMOIj7GllsK6C0UsQM2fjt+FKtFDtb
         kNAXM1HqKN90KfCVOuhTeA/1/pAbd2p4TWSX4SUjf/mNpATh+byb4NktkPzWPZjc1lyT
         1dhSTswHiOdNDuPbjDh4SE4vsmJCY+4MCw0szvazmtJ7GVyJncp3/L2ndlZtNi0PBrSp
         ZLhQ==
X-Gm-Message-State: APjAAAWmmTNHVA16+24Q5AOUIGDFZNfnrjdUByvHcnXCrRwSQnJdZeBK
        ef//ByoW8fsRILyclYAstJ9rUqGvY5gk6XiKFYkLng==
X-Google-Smtp-Source: APXvYqy24kthtQbHRgAaJalrWfOL9ZBmyHXN/FOgCMnK3+blCx4uUWhP7PRzNHBaDTtgSxiHSteMfNBggdRYp42H5r8=
X-Received: by 2002:a92:297:: with SMTP id 145mr21964677ilc.85.1572288520436;
 Mon, 28 Oct 2019 11:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QBN9C_o8HanAzXpDUN410g2o5+xfx64pbX3_VHVDKcj5N3kA@mail.gmail.com>
 <20191028171329.GA104845@google.com> <CA+QBN9DZyFynoUt+7sS_AcC-Wio-McJKCz8-RYfDWV0jv8iCzw@mail.gmail.com>
In-Reply-To: <CA+QBN9DZyFynoUt+7sS_AcC-Wio-McJKCz8-RYfDWV0jv8iCzw@mail.gmail.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Mon, 28 Oct 2019 13:48:27 -0500
Message-ID: <CABhMZUXADeHV+iUgFyDF+3BcQRFKDkMbwdkDAvBuYLd2XY=HCw@mail.gmail.com>
Subject: Re: Oxford Semiconductor Ltd OX16PCI954 - weird dmesg
To:     Carlo Pisani <carlojpisani@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 28, 2019 at 12:37 PM Carlo Pisani <carlojpisani@gmail.com> wrote:
>
> > > > These resources are supplied to the PCI core, probably from DT.  A
> > > > complete dmesg log would show more.
>
> The rb532 does not have device tree support, so the answer is no.
> I am using a common vanilla kernel without any extra patch.

What's your .config file?  The knowledge about the host bridge windows
must be compiled in somewhere.

> 00:02.0 Ethernet controller: VIA Technologies, Inc. VT6105/VT6106S
> [Rhine-III] (rev 86)
>         Subsystem: AST Research Inc Device 086c
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B- DisINTx-

> 00:05.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad
> 16950 UART) function 0 (Uart) (rev 01) (prog-if 06 [16950])
>         Subsystem: Oxford Semiconductor Ltd Device 0000
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-

> > If those UARTs are capable of DMA, it's conceivable they could corrupt
> something.
>
> yes, it looks like something corrupts the memory.

The UARTs do not have DMA enabled (BusMaster-) in the lspci output, so
they shouldn't be able to corrupt memory.  The NICs *do* have DMA
enabled.  Does the problem still happen if you turn off the NIC
drivers (via-rhine and ath9k, it looks like)?
