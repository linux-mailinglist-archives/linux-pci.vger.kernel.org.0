Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0913FE330
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 21:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbhIATmQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 15:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244663AbhIATmL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Sep 2021 15:42:11 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D64C061575
        for <linux-pci@vger.kernel.org>; Wed,  1 Sep 2021 12:41:13 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso1171895otp.1
        for <linux-pci@vger.kernel.org>; Wed, 01 Sep 2021 12:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U/AS3qDXHpFaWx+ZJcvPtCtF+rnLf3zIt76sJF5yEGk=;
        b=NkNxlikZUUM6eXRgFVXiPeq6YkDYPECZQBwyf07ee/u96b9SCgqsgH97bH+bHt18HA
         aO6QTOY7TXnpAhL/AkGdB1ESkCA75/NRsntfNVmdAQVFYrOiMDVqdEXPUqvmabYQ0bu4
         6fwk/eoEvHwqNAicmJQ7QKlfvMHN/EqkPATrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U/AS3qDXHpFaWx+ZJcvPtCtF+rnLf3zIt76sJF5yEGk=;
        b=rLnLaQnZE+tFWTQCF2Upko1U7dvhw7H+mf0d0+p69fmMuWXVLhfRe1HIdA5wLdCRzK
         LLr3b0wX89cQ71aOqnJCyPJhoaWeRr8fI+AIyY0k1ElXHDQ9olA9J7E7jce/m49FOMKn
         Jw4tO45ENwXce68mPQ/hh/NiGg+jlbluGTjyjBUExtdTkvS8FLN2hyXFdzqQ8K8eIQF+
         bUp2MGyZX1jfl+xE56wk00X/RB0OzblPPJAwVD5ZU5rOvkW7Bzac8dBm5sLqs12aAPzW
         DmKguPHlegJj4sB/Yn+9jyP3aAkv5HKVj0zAkvSlxnaxszsMLPk2TE29vhzTWvfoyiLt
         o8ew==
X-Gm-Message-State: AOAM531QyQUzqF3p5Szzsgjrh72HPUF1xpacQ+TE6jCbIfYaI1wRI/Ko
        sraYPoLZ5uQar2jaFnq2jeHKRG8WnugqZw==
X-Google-Smtp-Source: ABdhPJygOhCY+yZJFiZU2D0SXjxYwp39S4LnIla1H2dcC+PW5TT1D5ev74Mb5a6e854djKcorUoGww==
X-Received: by 2002:a9d:2208:: with SMTP id o8mr981092ota.78.1630525272371;
        Wed, 01 Sep 2021 12:41:12 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id p81sm89148oia.48.2021.09.01.12.41.10
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 12:41:10 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id q39so743677oiw.12
        for <linux-pci@vger.kernel.org>; Wed, 01 Sep 2021 12:41:10 -0700 (PDT)
X-Received: by 2002:aca:5344:: with SMTP id h65mr992912oib.117.1630525269918;
 Wed, 01 Sep 2021 12:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210830123704.221494-1-verdre@v0yd.nl> <20210830123704.221494-2-verdre@v0yd.nl>
In-Reply-To: <20210830123704.221494-2-verdre@v0yd.nl>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 1 Sep 2021 12:40:58 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPKZ0i5Bi11Q=qqppY8OCgw=7m0dnPn0s+y+GAvvQodog@mail.gmail.com>
Message-ID: <CA+ASDXPKZ0i5Bi11Q=qqppY8OCgw=7m0dnPn0s+y+GAvvQodog@mail.gmail.com>
Subject: Re: [PATCH 1/2] mwifiex: Use non-posted PCI register writes
To:     =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 30, 2021 at 5:37 AM Jonas Dre=C3=9Fler <verdre@v0yd.nl> wrote:
>
> On the 88W8897 card it's very important the TX ring write pointer is
> updated correctly to its new value before setting the TX ready
> interrupt, otherwise the firmware appears to crash (probably because
> it's trying to DMA-read from the wrong place).
>
> Since PCI uses "posted writes" when writing to a register, it's not
> guaranteed that a write will happen immediately. That means the pointer
> might be outdated when setting the TX ready interrupt, leading to
> firmware crashes especially when ASPM L1 and L1 substates are enabled
> (because of the higher link latency, the write will probably take
> longer).
>
> So fix those firmware crashes by always forcing non-posted writes. We do
> that by simply reading back the register after writing it, just as a lot
> of other drivers do.
>
> There are two reproducers that are fixed with this patch:
>
> 1) During rx/tx traffic and with ASPM L1 substates enabled (the enabled
> substates are platform dependent), the firmware crashes and eventually a
> command timeout appears in the logs. That crash is fixed by using a
> non-posted write in mwifiex_pcie_send_data().
>
> 2) When sending lots of commands to the card, waking it up from sleep in
> very quick intervals, the firmware eventually crashes. That crash
> appears to be fixed by some other non-posted write included here.
>
> Signed-off-by: Jonas Dre=C3=9Fler <verdre@v0yd.nl>

This might be good for many cases, but please read this commit:

https://git.kernel.org/linus/062e008a6e83e7c4da7df0a9c6aefdbc849e2bb3
mwifiex: pcie: use posted write to wake up firmware

It's very much intentional that this is a posted write in some cases.

Without ensuring this doesn't regress, NAK from me.

Brian
