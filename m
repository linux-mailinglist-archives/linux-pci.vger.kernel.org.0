Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FA4421593
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 19:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhJDRyP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 13:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhJDRyO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 13:54:14 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145E5C061745
        for <linux-pci@vger.kernel.org>; Mon,  4 Oct 2021 10:52:25 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bd28so67831409edb.9
        for <linux-pci@vger.kernel.org>; Mon, 04 Oct 2021 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SVy+42avAMDVs9YXx1N0MW72e1XqpRIo0we4Jey6TgQ=;
        b=USZyRilZz6erOG49DFYjzZ7yWgjOF6KTPmH52T4Gemm+QUM3Fsk9hCPuO1ae+CsKMy
         5cxbMWN0+QWJ7TNvMS+xMUWtoLMWb5t6Z7EiTWRxNQI0EeXpbmWGUY7HPhtaBMFPRnN1
         tyqo3akeIm/LNXB/Hnk8xMZ2sGRkMTJTjJrVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SVy+42avAMDVs9YXx1N0MW72e1XqpRIo0we4Jey6TgQ=;
        b=pNRlLnnyoqJqYxwgMV56aM5XH3eaQjwGoKYSi0dfIzrr470ik9op/WjqyR/NZbT45D
         73LYqPCy/D9UuT85oClXh2Q1JHVPpvzypw12GicKCDMXQlOUlXnmnYn8Z1pcmyuoXuB8
         qoLz3cmtnnbepUWJ2FkJB8mh2oqNrjOI0GUm0O7Jw9OJOHp5y+t3zwBGWNYpYbTeZIio
         rpIrJ+VEMJ0A29zQbkM1dVngEdNYOeYKU20WKGmfhN2trPZy05Q9Qf0gab7RwFeZQEFK
         /Thzmd8bVy/jZlQFA0l1DaBuYnUzvTXO2qY+lOG0WYLpAZ6knn5mU7KCQtra3kNWsugJ
         KS+A==
X-Gm-Message-State: AOAM533u3kNXu2rBAjuhjVmoMk5/5nPGc+LkSyfCwmRjgGn6usVqUw5x
        0qEqTooE4pfIRaWDYspvotPdlAlWRuCULq84KHdnoA==
X-Google-Smtp-Source: ABdhPJw473yRin1rcK/LShFHmhtAKymPp2Nzjft1z63Ov1VE3CPb6pN7T9mMOt0Y7yINQAzbdd9Z9LQmL/AJ4fFVqJE=
X-Received: by 2002:a17:906:60c7:: with SMTP id f7mr18468620ejk.57.1633369942391;
 Mon, 04 Oct 2021 10:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210914114813.15404-1-verdre@v0yd.nl> <20210914114813.15404-3-verdre@v0yd.nl>
 <5f0b52be-8b9c-b015-6c5a-f2f470e37058@v0yd.nl>
In-Reply-To: <5f0b52be-8b9c-b015-6c5a-f2f470e37058@v0yd.nl>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 4 Oct 2021 10:52:11 -0700
Message-ID: <CAOFLbXbK5LmZbLcEs5e-0twoSkxkyKy8S6ZJVsz9Ap_a_iGZPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mwifiex: Try waking the firmware until we get an interrupt
To:     =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "# 9798ac6d32c1 mfd : cros_ec : Add cros_ec_cmd_xfer_status helper" 
        <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Sun, Oct 3, 2021 at 2:18 AM Jonas Dre=C3=9Fler <verdre@v0yd.nl> wrote:
> So I think I have another solution that might be a lot more elegant, how
> about this:
>
> try_again:
>         n_tries++;
>
>         mwifiex_write_reg(adapter, reg->fw_status, FIRMWARE_READY_PCIE);
>
>         if (wait_event_interruptible_timeout(adapter->card_wakeup_wait_q,
>                                              READ_ONCE(adapter->int_statu=
s) !=3D 0,
>                                              WAKEUP_TRY_AGAIN_TIMEOUT) =
=3D=3D 0 &&
>             n_tries < MAX_N_WAKEUP_TRIES) {
>                 goto try_again;
>         }

Isn't wait_event_interruptible_timeout()'s timeout in jiffies, which
is not necessarily that predictable, and also a lot more
coarse-grained than we want? (As in, if HZ=3D100, we're looking at
precision on the order of 10ms, whereas the expected wakeup latency is
~6ms.) That would be OK for well-behaved PCI cases, where we never
miss a write, but it could ~double your latency for your bad systems
that will need more than one run of the loop.

Also, feels like a do/while could be cleaner, but that's a lesser detail.

> and then call wake_up_interruptible() in the mwifiex_interrupt_status()
> interrupt handler.
>
> This solution should make sure we always keep wakeup latency to a minimum
> and can still retry the register write if things didn't work.

Brian
