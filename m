Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560C94183AB
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 19:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhIYRkQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 13:40:16 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:53689 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhIYRkP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 13:40:15 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MIMKq-1mgIaR1vUK-00EJlc; Sat, 25 Sep 2021 19:38:39 +0200
Received: by mail-wr1-f48.google.com with SMTP id t8so37463889wrq.4;
        Sat, 25 Sep 2021 10:38:39 -0700 (PDT)
X-Gm-Message-State: AOAM5305o1us1cVdOyw6jwzw/ObA1yPXl+lsbc82ksAWysonURx6SulH
        5/LAXaKt395O/lC+1dJJlecoaKo8SCAh07avzw0=
X-Google-Smtp-Source: ABdhPJzy03N7tVhfn6aBkr45ZQOyfoDC04by9fsZmXLOn/y0W1o8uKfR6dX6QCxoxxGwp2bNJq5CkcHyUSMV7fPDOXk=
X-Received: by 2002:a05:600c:3209:: with SMTP id r9mr7825038wmp.35.1632591519149;
 Sat, 25 Sep 2021 10:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210924211139.3477-1-sergio.paracuellos@gmail.com> <20210924211139.3477-5-sergio.paracuellos@gmail.com>
In-Reply-To: <20210924211139.3477-5-sergio.paracuellos@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 25 Sep 2021 19:38:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2YiGm=2TSKGotXRR3vJjfv+xhyZuD-Law57UDiagHZxg@mail.gmail.com>
Message-ID: <CAK8P3a2YiGm=2TSKGotXRR3vJjfv+xhyZuD-Law57UDiagHZxg@mail.gmail.com>
Subject: Re: [PATCH 4/6] PCI: allow architecture specific implementation of pci_remap_iospace()
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, neil@brown.name,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:N2Km3/CVfpY7kGN0gFj5hrzELBxMHtdH8vi/mAvJmwP2A7o5vVS
 aZ5qsHDdRCHjSn+su6ITGrjgV0Rswn+ny5RPaZ9p2gZHRoIhR+PxTXIW++osE1bMMg3p/cB
 i7tfkWDQcipygMb4s754JNYzAv6G82tAQmUwKHutUiHm1xjaE2/c9BLbT36swDv3a5YIhwb
 y2UbhIb3VHA6Vb2iO4DyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ukpurn3eWjI=:A7h5tBNzIex7QkhOnuBAqF
 sdPYQF70XNJ4DkC9CJS7OfKsgkYhd9Ew0gD/BEXEsJkTwmZhy45jB0ZSuIzw64TwfqargXLT7
 5kIkOdW4fH6y8Fpd3X73hhw5+Z1zYH6SV+Hx60+o8aNY/vJFQSQPvy+K6382t+B5ACEE5nSfd
 eIVWtM3Y4LMeSuh8z/V+8/kRypTYXH1lRSKv10VDpzlll/ajQOGi1tAHuxvrvgcqgAtXHVAL+
 iaEU5AYbPJXgsj9V5w25bThcdsCo4ztT6UvpT4GKM/MkOQ2tV713DWZX2D3+zIG4YSu2NcgOe
 twRA2gXQLsq8QL5sZmCy25H0JpClzpCnAbnKu4uvDSN3EtH5/KQLWVCXrg8GCA0AJe7srFPPV
 02b8FDcdH96+b02EAooOQwl9oA98D29xlsILqgeIw4akFr2lfWdbb9R565QeJsWBi+AnyiBlK
 fnm4L6pkKXa5X6SBT6e0ecIRh2gVV7pQ8Uwi4+m7M5Deq9mfwHFlB80fZkUPw3fuKLaAwqURy
 yaXC1fQTfcBDKsXLZD2xiV7gIkZP1KJd8D9Rqxt6T6xzrLTIX0EqPFcINSOjfqpAT3/Ib7zMq
 d1B/wQaV6mUos9VCN/Z4VL/8dh5AhJu9qKeZxybYIcwmf4T34mYuvXdZ86i7RISSVDId/ZVtR
 GHm+DQeZabpJe8zF2dxTkHoOuSrXUktap5djdXlVVOwT2VKVTRp7JCG7cfEhnXHaPa8d7mdSC
 +l7YBCG3OcKJRZjv9P7lgO/D6iZ3jchnspevebPzV8GHgW8EQCoXzpHiMtEj5Ep5CImY+vcnA
 n3THvd/AGQ+m208C7a3XzS8EjRImMmuZ5qo/62t4JEYq0bQjchKWU+CaYflScWO6/K90rolap
 LVwZeECtvO1QPg/kmsNQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 24, 2021 at 11:11 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> pci_remap_iospace() was originally meant as an architecture specific helper,
> but it moved into generic code after all architectures had the same requirements.
> MIPS has different requirements so it should not be shared. The way for doing
> this will be using a macro 'pci_remap_iospace' defined for those architectures
> that need a special treatement. Hence, put core api function inside preprocesor
> conditional code for 'pci_remap_iospace' definition.
>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
