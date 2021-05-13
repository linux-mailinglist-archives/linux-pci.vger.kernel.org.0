Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3562937FA6B
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 17:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhEMPQr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 11:16:47 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhEMPQp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 11:16:45 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N9MYu-1lT2ED3p5A-015FyW for <linux-pci@vger.kernel.org>; Thu, 13 May 2021
 17:15:33 +0200
Received: by mail-wr1-f54.google.com with SMTP id s8so27254962wrw.10
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 08:15:33 -0700 (PDT)
X-Gm-Message-State: AOAM5322poaRTzCAILJ2gUpYmssZxefIqhMIThD3+GPdqJrjf7Aoli02
        H8UAU3w8PCwO1qpG5gX/hKecXU+usD58POK9Xi4=
X-Google-Smtp-Source: ABdhPJwQIsBT9n8Qkj2JRhpEkNMCgRHl4RyaQVCnBwy+J0RrUs+Tqidp+lcBJmgQJZwvMw73SnrC55cVRHiizLTT1rk=
X-Received: by 2002:a5d:6dc4:: with SMTP id d4mr53976888wrz.105.1620918933677;
 Thu, 13 May 2021 08:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <E1lhCAV-0002yb-50@rmk-PC.armlinux.org.uk> <CAK8P3a0TxtWn7Ua05=XsG5QK853C9SMDLdTOV_6rLB8cE49qXg@mail.gmail.com>
 <20210513151341.GZ1336@shell.armlinux.org.uk>
In-Reply-To: <20210513151341.GZ1336@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 May 2021 17:14:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0n8VdfNhCETC-D4D2R16mKKYfMcYsTtywDLWAKabb9Ww@mail.gmail.com>
Message-ID: <CAK8P3a0n8VdfNhCETC-D4D2R16mKKYfMcYsTtywDLWAKabb9Ww@mail.gmail.com>
Subject: Re: [PATCH] PCI: dynamically map ECAM regions
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Qvgt6NwUS4CiGVW3xFjYqkuZPlvglmjxfbe5lZbBPF8qVAg3sRn
 9Lt0LAcGYKehyzqprWkRjSHDOfX5jfI0mBlMfZYfjIeocyudOHYXcwjcp/oqCzszgoYz/vW
 +RS6eIMnm3MgKA+ptm3nmWXsiyoqBHQPz47QwUW3H7GFXWDHi45GnmlzqBhU5tq1BMQuZEp
 +cRHGThLlVUAckhcEHWUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E82Yh9uBhCk=:Lf4hu0bgRfnMmcHNaR++kq
 LpQKy2peHKoWqwPtqtrBd0mGCAXXUh3JuElsanXS6GpKy/wMSB/M99DsxKSqus6NnRZNX41PK
 OS8nDYqS0qca2F+sYRsc4Gav0FZGVWqWBfhq+NguyPAJIldDRgTVES1xMgV1+eI1V483lItf3
 BVVdkKnZHcooXWRuqu0xJwYqPOs3NeoOhvLGFZTQHCigk6fp1PFcFa7+fruXARXXGL39qhS2d
 zsyoqnPtyZcn4IidwfInZlUrtq+lcsorCW3r2LoCfshNUYUg+O4ol6lr8QmdARznlc0SuFV3e
 EebvmU+YidRs70aY+EFWK5l3ghYqBMVnFplfFD70+7iqfSHa2Bn+OFnHnvGxdOdqnMwQz81ai
 vhcn5ok0vpP27n1V5MZllJhhzAP5Yrpf6dJoF5Udy7ojoNyKIPe4oPONS4goVIKi89iNetrf0
 haBQhFZiL/L7kDHZtnDHgH+EntlPnOt0kfNnLPPsXVjZy/5TUOBlptpd2IOkl7o9S1WsOA1ns
 YucwfotS+tpPAlJOnLcufM=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 5:13 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> >
> > Looks good to me. I wonder if we should actually mark this for stable
> > backports. It is a somewhat invasive change, so there is a regression
> > risk, but it's also likely that others will run into this problem on distro
> > kernels.
>
> Maybe merge it first, wait a release cycle, and then request it for
> stable if we think it's of benefit?

Yes, sounds good.

        Arnd
