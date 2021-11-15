Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5065845061D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 14:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhKON7M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 15 Nov 2021 08:59:12 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:52651 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbhKON7M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 08:59:12 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M4JiJ-1mmta92BST-000I5W; Mon, 15 Nov 2021 14:56:12 +0100
Received: by mail-wr1-f51.google.com with SMTP id u1so30887459wru.13;
        Mon, 15 Nov 2021 05:56:12 -0800 (PST)
X-Gm-Message-State: AOAM5319m8vghGPTjZGBTb6s6MI+Eh6K4M3/BjL28kuf3UgbdHBGRyt5
        QNDNGKcHTDB94iVtF5+ZSWQACARgEhOFtwxitmQ=
X-Google-Smtp-Source: ABdhPJwZu1Y0NQaJduThy0FATNKQ7q57R8j31tpZxHMuJRrVI5TgHIDpuqzbH7XhZV1NVo7L4AeuZOFUGvZ90zQokAs=
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr47933601wrd.369.1636984572170;
 Mon, 15 Nov 2021 05:56:12 -0800 (PST)
MIME-Version: 1.0
References: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
 <20211115070809.15529-5-sergio.paracuellos@gmail.com> <YZJWM33dXqW1BsuV@rocinante>
 <CAK8P3a0A9xAcwDLFbUk--X2+7gFpOL7HJw-9Sk8KZxfoidcxuw@mail.gmail.com> <CAMhs-H9ox3qeAKCN7ug1BxJArmvjDBSqgubOvr_tK1hasPNs3A@mail.gmail.com>
In-Reply-To: <CAMhs-H9ox3qeAKCN7ug1BxJArmvjDBSqgubOvr_tK1hasPNs3A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Nov 2021 14:55:56 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2-C1zo81hHcua6d7+XE8Gm=s6h0JTR9Q71DbDU9f2WwA@mail.gmail.com>
Message-ID: <CAK8P3a2-C1zo81hHcua6d7+XE8Gm=s6h0JTR9Q71DbDU9f2WwA@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: mt7621: Add missing 'MODULE_LICENSE()' definition
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:wb8B/5taonV8CMaacygLepBOELSZjLqzcgYsoB/1BAukZjP9EjL
 2drXOxYrtTbMH7gwoKdRgcAxzYs2DsKzLj7fey1I+TVc5d0cTG5H2agR5lpgFUwyYOCwp82
 tjYfqpe74j/zRyPODutwGJZdGfMIhRu9Qm9KM0HMAoTWfepDyx5QFnR/rPJYXi/QgxqYlR9
 gPp8wHwY3nI0JietAreHA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2aQuj2BncJE=:WQ9r1Cjeg/6FpsXaSyXKMs
 hN2i4azc5OwbArKFJ95gGrAUGSna6BpZIjxETqTz94FhnDkxLsZtq7Tq5VVRf6s783UqsO0cn
 FgIc/GFBk6UTB1NVoRqEUF6NNIdWr9h0QqyRl/ceAxCv/fi3JUCzrc6uFrTQ51NgFIESlOe1F
 +rrVYewgP39ASKviGP7bEg/5AiMQkZ10nxDOIQQBFxrfi6bJSzqeqJm8+aCJio1ujKapNci3I
 t8SLDJpWYHT8KSrrZlkWUiqnDwpgYT15uFrBonYb71uglgwcPdt1ZieYMtxU/TGdWeX36/+oI
 zLB4yxOYLCs7z6Hs/BQaCitpRYBzI7bIUOG+i+fdSPCV2cufHSFnv0b+DBLBPcbDbANJ+h2Fm
 T5AUJ+SNlGtm8gC0OFsX5L5BcTj92gfXvRLX+ovVTamvsaFhKts5FSjVmzf3Frnv6iUfY57OA
 QOTSYg4zJgquHM1xE/LCEaiL6aGyyScdiUTMoFcLU+hFsm5Ryyjh2K8KSATwuxCXxKtrakAjQ
 GA1GSTQ1MfYk2hUMGZuPDw0cpZAsE9itp9gV8ei8Qe8m7M8BieaB21sa7jTU0Ct6MgXhgxPyC
 i3WSly7eLOmW+kt36gjTm11ULf9DuciwlYohVIZ8xlLfSOCAzS/XuEz1FzNph8DWyR9TeRVUn
 TpAPbHH9pNGXy5XuPo6azY2GxvkQp+9TAF+LVJZohGXDufmVckFJK4PP7+3kzOlVc+a5lWUgJ
 j/TiWjmjzKyEGUrJu82+C9fm5FeWyxRbzJ/c+0a3wxpj4H3rzbe3p5Ls8qIFsJ1vF5ezzgkz9
 IGDHJLRUPEAGcpZAzg4Svo3PftsVwrzZ2C8lMEtugh8GQnQGZE=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 15, 2021 at 2:51 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
> On Mon, Nov 15, 2021 at 2:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Nov 15, 2021 at 1:44 PM Krzysztof Wilczyński <kw@linux.com> wrote:
> > This is often use for PCI drivers, but after Rob reworked this code a while
> > back, it should actually be possible to reliably remove and reload PCI
> > host bridge drivers, and it would be good to eventually lift the restriction
> > here as well.
>
> I see. Thanks for letting me know. I will search for a way to
> accomplish this but that will be a different patch series.

Right, that is what I meant. I don't think it will be difficult, but
there is no point
intermixing it with your current work.

       Arnd
