Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71FE2705F1
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 22:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIRUEO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 16:04:14 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44989 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIRUEO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 16:04:14 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 16:04:13 EDT
Received: from mail-qv1-f53.google.com ([209.85.219.53]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M7aqD-1kOa8H2TiH-0081tZ; Fri, 18 Sep 2020 21:59:08 +0200
Received: by mail-qv1-f53.google.com with SMTP id j3so3588296qvi.7;
        Fri, 18 Sep 2020 12:59:08 -0700 (PDT)
X-Gm-Message-State: AOAM530ZeA+inWt9/NUkL62YrpIHKAwi+jcnZKhF3N9L3B/PbdVnsya/
        oi0z+HavLMw4yRHXwDKid3mKo/SHozliPNXw794=
X-Google-Smtp-Source: ABdhPJytBHBh/fQMXo7+68dbrxEABzvlGs5A0AsCoE1YgJGiTA+FdkuyePsZid8ag08tntnusNEq5NJL9EnWegFjyH8=
X-Received: by 2002:a0c:b902:: with SMTP id u2mr33843869qvf.7.1600459147303;
 Fri, 18 Sep 2020 12:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
 <cover.1600254147.git.lorenzo.pieralisi@arm.com> <20200918114508.GA20110@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200918114508.GA20110@e121166-lin.cambridge.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Sep 2020 21:58:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1f9Qj+yhMB4QaAu36ZUQ1p6oKHm2MZQ3zU31q6xmymGA@mail.gmail.com>
Message-ID: <CAK8P3a1f9Qj+yhMB4QaAu36ZUQ1p6oKHm2MZQ3zU31q6xmymGA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix pci_iounmap() on !CONFIG_GENERIC_IOMAP
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        George Cherian <george.cherian@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VRIHA3kLYuVnqBOmVjZxDHpU5iuxIlHABaeAykjpWRJG87XIlvQ
 nzm3sJNPdfFThXmkqyLysreEc+3FT/n9/9a3iFPzE1VldoYL3pSVbI7xm1N5t0Ntdj2H3E5
 0wns+4uby2aVC8sMbV7XixaW/OoRhu52L49WST1aoWuqFsS75RJmLdKhgUHKZ4FxiCNF5oG
 IDiSkaNIyG8J5Sglb2QTQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:G9F+xbi+MqU=:exGgY1ouoMQEZ4yAwf+uXa
 2Q1fJPvb50BxhqrEM+YJHdjUuU18b3c2g+IvfMDQz+Tx0GT4imi5yFjvE8qAIullr/QCm5HlV
 m1Gz2WT30X+uKoSQJDxbCC3Rp3P9RwnpjKAZMy+IF3HhTwOOMe7cnMeDotJU8graVra85m7nT
 XDLgF3+tueOTNg57YfW+5BYYECCnb1tWZXhWCQYYzr5VuXq6OzT3izteijmKn+uG4StSntPt9
 F/FmkHjYcddBMbkn8bW/D2xHAamiRUhEUHsGqxx59GGDWR83CYfwcKzvHrzxATozYs6rOaxTX
 r+Q3Oa7ViSTWjQWzWn8pFiz6ZjsXrR/EucOC9mKqvIy9IwbpYT/cIs4QDmWUegEoI7u3uk/ZQ
 X/1bx3wZEGKtqba91G+R7CSw5mzZ3PgFfQ9Qf+SfBg67it76QLpXi/cZTsxCMZztW0jgAiGNx
 zbHu1Vx8DFRXkZD19VZhZxXLmhSnnF3dcO+MHzLwlO9iwenrVQdrImU9Cw3hfzL2JvZkaGWZD
 6wFXMT2NNFMBojWvG5CXk/6nKS7kFyICyWY5zGXj41pQPRc6/6s07M18kbpS961hhbfF4GGuY
 0HErbTDJ6cakbwfxxMMMhWbchA59BqdCIglMmBmCedAqDGzLnKybyfdC8jasbfqP/tIa+rsna
 8Yh5cg2zbOOT+UjYh0Jnr3V44VXjm8x9YTJUPumRDInvBMFmDEJrgtxIVUuDjaveatLjmK93Z
 4VQ4evBjoJdumU5BByvZNeqcjOFcpdEFu4HU8q17Nm7xQnVqql6XmVOWtVw5SsTT1iJ2zaFPy
 j9GLPI+4D7qo321L9X/60dhAJTLPEkdh/B4cW3HdJ1Djp1J0Xzuq9PO/yDIFq5WIDzfcjAm
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 18, 2020 at 1:45 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> >
> > Lorenzo Pieralisi (3):
> >   sparc32: Remove useless io_32.h __KERNEL__ preprocessor guard
> >   sparc32: Move ioremap/iounmap declaration before asm-generic/io.h
> >     include
> >   asm-generic/io.h: Fix !CONFIG_GENERIC_IOMAP pci_iounmap()
> >     implementation
> >
> >  arch/sparc/include/asm/io_32.h | 17 ++++++---------
> >  include/asm-generic/io.h       | 39 +++++++++++++++++++++++-----------
> >  2 files changed, 34 insertions(+), 22 deletions(-)
>
> Arnd, David, Bjorn,
>
> I have got review/test tags, is it OK if we merge this series please ?
>
> Can we pull it in the PCI tree or you want it to go via a different
> route upstream ?
>
> Please let me know.

Going through the PCI tree sounds good to me, but I can
take it through the asm-generic tree if Bjorn doesn't want to
pick it up there.

       Arnd
