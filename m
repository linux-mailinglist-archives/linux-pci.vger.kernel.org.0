Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5F841839B
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 19:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhIYRe7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 13:34:59 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56305 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhIYRe6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 13:34:58 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M76jv-1mUQo92PS3-008eqj; Sat, 25 Sep 2021 19:33:22 +0200
Received: by mail-wr1-f41.google.com with SMTP id t8so37511493wri.1;
        Sat, 25 Sep 2021 10:33:22 -0700 (PDT)
X-Gm-Message-State: AOAM532WNakjyL3ZvQX8Bu0q+nKLKEoLLsBcs1qGxaP5y5f8K8gut0Z7
        3qxvJ34QfBfMcjzQjy0ErPzZsaN8kBOjQv9WYQE=
X-Google-Smtp-Source: ABdhPJz71+W5QKw02u9tzKycAUfeIQyFgilizU1qNL0MVKu7i8r/pw9Qp17Rg7H+KND57HeXcwT7x94QOx8SGQmJwGI=
X-Received: by 2002:a1c:7413:: with SMTP id p19mr7959099wmc.98.1632591202155;
 Sat, 25 Sep 2021 10:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210924211139.3477-1-sergio.paracuellos@gmail.com> <20210924211139.3477-7-sergio.paracuellos@gmail.com>
In-Reply-To: <20210924211139.3477-7-sergio.paracuellos@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 25 Sep 2021 19:33:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0LXzyC1y4QapdjvtC2WRu8hU_0hENzZrz14ufoVP3ceQ@mail.gmail.com>
Message-ID: <CAK8P3a0LXzyC1y4QapdjvtC2WRu8hU_0hENzZrz14ufoVP3ceQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] staging: mt7621-pci: properly adjust base address for
 the IO window
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
X-Provags-ID: V03:K1:jrQkC6XM1UQQPxoAghMY4Q2F/h1sU5wN/PVN6YbA4qAq0PYAFGx
 Yhx1wWTzgkwSmL/NcvP9NomZASc3xBzsHfc5tfswikNQIgx8FujqZ7Ofpw2LvYbRPTJXHFA
 9RGnymj6aYew/Lg7hFw5yxg8Xmok8yHedhVfL856tuRLq57ywjr869T492UHgGCXW650Eo8
 MYU01jEH3dq/BqGKe+cBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3QApOtBy+IM=:iH1RqHz9NUzJKyDtzn8evv
 kIXGIYG2ubQYOPWHZ+Ex1+bDSidDlfOiHCHXvJijVVR0sWkosuf5fKpZy2bxo5fg5jlkujG/2
 KbMq9wqlmYhNMT4cB7l2Tdmk8d4koKTJsdCtSvvKxP+zv6S1roFMDXqD7Uc3vQY9XH8NJK9mh
 VFaCcpjys/2heH6Xa0kbQhPyQv9Lcv08WyV5HH2mVKZZG+tyW5KMjh6HkDQUWmTNJlRN74ikD
 Juf9jk9Bf/kWgfzgWps/tWXC4QA5Tqgp6zKZDdiEIKWkwhrxJZLR8GkgsE7TklFvZok/bICL0
 k62jO5dMFmqvp+EtWNsymZs3nsbxpzIYRie+LmhYwlYte8YOsZ4D3X5y24FafqmSdy4JBnoEX
 fC8cT2NWQTl6UQMobVxPzxDpiXbnuE6N9P0sjNv9rWbgoFMKzeMGFBWMcL21hAFlCxAVN2Lh6
 BoolaKDT1m+00R3kIyTUH2BcAKd2HHaPJdqoEfKQQimhctjF0w+EP9J5z9IVIVZCsvBdtgAxE
 54kM9fjR0i7iYFv8mj/5Jmn1UdZkK++SVPTlcyl3cmtdasZFwlzF/g+uGBXpZKRsio5ZeBicB
 rliQhXPJC7l3EIQ6gtWwgkTayc0eOKOgU7iWwlYthrX9MAEIIVD+Or4CrAtAReWbKsZXkeZqg
 LZgZnQPX76nHcvxraRIuASKgcweH7nZY65oaAVvIbErXRVQOmUqoAUQKvME+2fAM7jRMV8geS
 AVw8KVRsk8+q86M5SVsd009pHOVBILa07YA/0Bm/bCa+NbU3rngvb7xt20ZCErc0u04Q4YLiI
 tlcsmQPyeanZL4HzDjo0vMgRkp6cRQF1OeyhlobkQlL9SaHz0BAEnD/xX6M0O9S4JVA3YCYuU
 AdrGAplyfj+HIjhV1QIg==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 24, 2021 at 11:11 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> The value to adjust in the bridge register RALINK_PCI_IOBASE must take into
> account the raw value from DT, not only the translated linux port number.
> As long as io_offset is zero, the two are the same, but if you were to use
> multiple host bridge in the system, or pick a different bus address in DT,
> you can have a nonzero io_offset. At this means to take into account the
> bus address which is used to calculate this offset, substracting it from
> the IO resource start address.
>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
