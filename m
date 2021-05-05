Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70E737340E
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 05:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhEED54 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 23:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhEED5z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 May 2021 23:57:55 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C83C061574;
        Tue,  4 May 2021 20:56:58 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i67so381853qkc.4;
        Tue, 04 May 2021 20:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=raPVEE+POqvqWKpHqKk8/hWTNW82CsKc6mZrTESP9RA=;
        b=nqvka04ZEshde8nXMTIxfIWvfnA6uVudEOMtY3I4YKFK6XvnBssv50LTuD4k5ezOLd
         +fl5ozLjvA7y8JD87TR/9pQ62JWWsVKkqzaIxPDYfM/4AxEByHEW2B58wM3Zm2ExKjdN
         L0Cj5sw1tmKXCbZw09RI2eBQ/QRvQllhr3Ukwa0ltbo712Kj7kSDx2+mBa0pSA6yH3v0
         mf/Xlejx31L9sCdRrtRk4sCZEKmnfCDl4RTG3A4QC2pHjhvuzbfCPWV62Pz0SOoFUjRb
         l5+13gERX5Fcc+Fe9iKmi+NTizOSvpFDrAILyHupx4XQpaSiydXSLbnliiLX/aRvomY0
         2T/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=raPVEE+POqvqWKpHqKk8/hWTNW82CsKc6mZrTESP9RA=;
        b=mFLa3+6xPyX+oV/ApFxPNRyZ0krpSW58oUKGW/eyXj6drK2iByaN4PndlwdJOt/74v
         SlcVJbOitQfbE7PqPj76lNXokO/3KCOmRccZC8LOKcgv5OrMB7XYUrXqlJ0+H7TspoLp
         YJ5MHejOAue7l+LHwqj/arMx7GCCGIrQXi66W5w3GgEYuAypJ6lCsLQELqIsMDQAQMZp
         k3p9FWvUvOu/ZVuYkJ12vxq+jRV1392ovy1jdtAl1wBRlTzwpuei5yE5GeazOgHW34s0
         5V7g5XsHK3vDVsM5ZRc1F6QuQN2LU3yIbe4VYD4V8ZV4XIJZA15qKR/qqqYj2VJB0DPQ
         9Ksw==
X-Gm-Message-State: AOAM530pSdtOgPaQ2ackjjNxZmC7Cpe3QUWSL6zeYlqVbVP1S7XyaxL0
        fipyhT89iP9aELOR3S/0xOUWUPtG0Vtyx3IOQy8=
X-Google-Smtp-Source: ABdhPJykhQF7VHwuFZxf/QqbGBYjzbeMEW7pELCetcVAtZgzLt0ddOxMMeRCAWlrdd2paWS+4VsROWSCNQq2dplopTs=
X-Received: by 2002:a37:de14:: with SMTP id h20mr28014944qkj.34.1620187018114;
 Tue, 04 May 2021 20:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <478efe56-fb64-6987-f64c-f3d930a3b330@nvidia.com> <20210505021236.GA1244944@bjorn-Precision-5520>
In-Reply-To: <20210505021236.GA1244944@bjorn-Precision-5520>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 5 May 2021 13:56:47 +1000
Message-ID: <CAOSf1CFACC5V1OdA9i9APipTUE3GmXu487vt-btXWk5rP97UAQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Shanker R Donthineni <sdonthineni@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 5, 2021 at 12:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, May 03, 2021 at 09:07:11PM -0500, Shanker R Donthineni wrote:
> > On 5/3/21 5:42 PM, Bjorn Helgaas wrote:
> > > Obviously _RST only works for built-in devices, since there's no AML
> > > for plug-in devices, right?  So if there's a plug-in card with this
> > > GPU, neither SBR nor _RST will work?
> > These are not plug-in PCIe GPU cards, will exist on upcoming server
> > baseboards. ACPI-reset should wok for plug-in devices as well as long
> > as firmware has _RST method defined in ACPI-device associated with
> > the PCIe hot-plug slot.
>
> Maybe I'm missing something, but I don't see how _RST can work for
> plug-in devices.  _RST is part of the system firmware, and that
> firmware knows nothing about what will be plugged into the slot.  So
> if system firmware supplies _RST that knows how to reset the Nvidia
> GPU, it's not going to do the right thing if you plug in an NVMe
> device instead.
>
> Can you elaborate on how _RST would work for plug-in devices?

Power cycling the slot or just re-asserting #PERST probably. IBM has
been doing that on Power boxes since forever and it mostly works.
Mostly.
