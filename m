Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F4434AE50
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 19:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCZSNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 14:13:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230196AbhCZSNW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 14:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616782401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pap7BptUHGKykCeFu/8MT0qbOtaTjDcy9qwuilzOGIw=;
        b=Lvrg18vE91uCsfFdRV6peot03xajV/DUtnt+SZa+XSbLxlyfsYQNEdk+AS+tdHE2ilN7aE
        w7AzzrSIQPtzqG/Wfo8RmM3qYa1ah2nx8p0E97cx9p1NJK4k+IM0162mA8BoUTc3JU1aft
        X1+wU9Kdhzk0lNv+9CdFG6yJMZinrX4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-wnntg5OdN9C2ix40XVyYkQ-1; Fri, 26 Mar 2021 14:13:18 -0400
X-MC-Unique: wnntg5OdN9C2ix40XVyYkQ-1
Received: by mail-ed1-f70.google.com with SMTP id r19so4846058edv.3
        for <linux-pci@vger.kernel.org>; Fri, 26 Mar 2021 11:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pap7BptUHGKykCeFu/8MT0qbOtaTjDcy9qwuilzOGIw=;
        b=YX74CSm7XUabBISVLxGp2uJdyJOTAfjYYvkuzAqXr1+ssrxtwt5pLw+sIvMYQKjeVi
         flAg7KDtdDpjdgeVqLXaKjDtK9PwEHw53GgZHsI4xE3pkYpmb8toDRjQv+X21ex+NIh+
         FnQ/dSpuNHjRUwIf1Y5BaZN722qfW4TKOq71fzGVcvqE15EGjTc0/IT5/ahtgR0c32IO
         rSi3qHf43msOt62VyfiKrFL9nCLS8m/HfPXvNJbJsZsXtNTpZiZFl70Wk5i1vqfarHKF
         k+Alkn0/eK0hMpgPrVp4So1W7lE2ifIzlYdXmCY2eXKI5VHl6aNqaXsFnBCAl7EFNswV
         swxA==
X-Gm-Message-State: AOAM532ESXFWav1ofylMD+bhDyo1D5sKJobhfOPtizB1QZiPBKO2U0KA
        DI9A7SNrGAbv9XgEZYS+osFw1tEZLq031jiLXZ1f+wXWtBGX2QQ2ytOwGWlkV9qMDtO9zBLGCMA
        lZIb3/Enz+yeLHUUEhBU5
X-Received: by 2002:a17:906:1386:: with SMTP id f6mr16596260ejc.45.1616782397372;
        Fri, 26 Mar 2021 11:13:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvc3mTnPMkhQBDrVBxW5/RWmuM3jHJDelx7UJ+pb/VP1j+SOnbQqRjHmOXJgwr+aDlkaxn3g==
X-Received: by 2002:a17:906:1386:: with SMTP id f6mr16596244ejc.45.1616782397225;
        Fri, 26 Mar 2021 11:13:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f16sm4141390ejb.3.2021.03.26.11.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 11:13:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D32FA1801A3; Fri, 26 Mar 2021 19:13:15 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Cc:     vtolkm@gmail.com, Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Disallow retraining link for Atheros QCA98xx chips
 on non-Gen1 PCIe bridges
In-Reply-To: <20210326124326.21163-1-pali@kernel.org>
References: <20210326124326.21163-1-pali@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 26 Mar 2021 19:13:15 +0100
Message-ID: <87a6qpbx6s.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> Atheros QCA9880 and QCA9890 chips do not behave after a bus reset and also
> after retrain link when PCIe bridge is not in GEN1 mode at 2.5 GT/s speed.
> The device will throw a Link Down error and config space is not accessible
> again. Retrain link can be called only when using GEN1 PCIe bridge or when
> PCIe bridge has forced link speed to 2.5 GT/s via PCI_EXP_LNKCTL2 registe=
r.
>
> This issue was reproduced with more Compex WLE900VX cards (QCA9880 based)
> on Armada 385 with pci-mvebu.c driver and also on Armada 3720 with
> pci-aardvark.c driver. Also this issue was reproduced with some "noname"
> card with QCA9890 WiFi chip on Armada 3720. All problematic cards with
> these QCA chips have PCI device id 0x003c.
>
> Tests showed that other WiFi cards based on AR93xx (PCI device id 0x0030)
> and AR9287 (PCI device id 0x002e) chips do not have these problems.
>
> To workaround this issue, this change introduces a new PCI quirk called
> PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1 for PCI device id 0x003c.
>
> When this quirk is set then kernel disallows triggering PCI_EXP_LNKCTL_RL
> bit in config space of PCIe Bridge in case PCIe Bridge is capable of high=
er
> speed than 2.5 GT/s and higher speed is already allowed. When PCIe Bridge
> has accessible LNKCTL2 register then kernel tries to force target link
> speed via PCI_EXP_LNKCTL2_TLS* bits to 2.5 GT/s. After this change it is
> possible to trigger PCI_EXP_LNKCTL_RL bit without causing issues on
> problematic Atheros QCA98xx cards.
>
> Currently only PCIe ASPM kernel code triggers this PCI_EXP_LNKCTL_RL bit,
> so quirk check is added only into pcie/aspm.c file.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Reported-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Tested-by: Marek Beh=C3=BAn <kabel@kernel.org>
> Link: https://lore.kernel.org/linux-pci/87h7l8axqp.fsf@toke.dk/
> Cc: stable@vger.kernel.org # c80851f6ce63a ("PCI: Add
> PCI_EXP_LNKCTL2_TLS* macros")

Thanks!

Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

