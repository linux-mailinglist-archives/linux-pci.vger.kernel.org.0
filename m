Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727614183A1
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 19:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhIYRf3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 13:35:29 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:54679 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhIYRf3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 13:35:29 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MA844-1maGNO3dJC-00BgBI; Sat, 25 Sep 2021 19:33:52 +0200
Received: by mail-wr1-f45.google.com with SMTP id w17so37285832wrv.10;
        Sat, 25 Sep 2021 10:33:52 -0700 (PDT)
X-Gm-Message-State: AOAM530ZxIXgn+94K8OkUS3qgxpNjXaw1PECyK32l9rK61LMql4g20ss
        OEvlSJIpdQ0rVJ2CwLaWAyH2do7aDi8DcX+DuzA=
X-Google-Smtp-Source: ABdhPJxHilNyrhkKldS3YRZ1E4Ye2gk1OmIUNcWp41Uyl1sY+smAmPNinSd9bb4kF6SjiPUsqd5p9aU8s9o12e2ei/c=
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr17718929wru.336.1632591232505;
 Sat, 25 Sep 2021 10:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210924211139.3477-1-sergio.paracuellos@gmail.com> <20210924211139.3477-3-sergio.paracuellos@gmail.com>
In-Reply-To: <20210924211139.3477-3-sergio.paracuellos@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 25 Sep 2021 19:33:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3gHsNoyaNjyn3e8=+4YqnAM6YHNna_yKUxf7k8O_od=Q@mail.gmail.com>
Message-ID: <CAK8P3a3gHsNoyaNjyn3e8=+4YqnAM6YHNna_yKUxf7k8O_od=Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] Revert "staging: mt7621-pci: set end limit for 'ioport_resource'"
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
X-Provags-ID: V03:K1:qr3SJ2McwjGt/CKAiShOSBztgFfRRYKJbfdyfSItsPnPikDwzvc
 zpWWw2tj7R4dDxv2UfswJ7YvwYk1U6/DL4gNNsZDAEvBBuuNrrrGTtyG2/T9Kn4K28/xBll
 wvUpeuohTOdvkE2+20NwvfQzjPLdlvK3F7/HklpBoaL3ePW22O4JbnDQEwyPR93hdhPa/Uv
 k+V0MipXtYHKOTNPrufYg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2PEUUVajbpg=:BcGZEcdYDoOMjMUT4ApLMI
 OkqVxKKxPHfPZ/XRjng2Tjh2VMt0TEx/P7xU5Bi+gc/45jURFiudicTK2YXetlgTYsHNKyoSx
 0Sr0U+5paTkl17qe6Ag1Wb5j5+tk4hQQ3KMVObhMCkF9i8S/PCJHk7tQDAI+CkEZyc2YjRtPy
 tsstaehQ7rCuxRuZlJXBQGfwgHM6UvvFDvAqMdsS5ROQU3Ax6dXSz2928/GXiJaIDRpycnz5H
 841BAZ3Ox3QIFpVfIzIGKvVt31+H8aV8y+VoiK67IrLpD2fR5/sjpFKCHjF+Ge9R6q0fBpcgs
 nOzkCofEEvwSIxYZkUeAlhXt9A+aUPLd6xZA95jLmmqnH37UBKUiDuNp8eh0H2p2w55TxzLng
 qWrZGW2EVXilLeq8k9zmjr+OrLTuYdF+gqKJdwO+x6XiaATllwhL8HBhSW1IM5RI4pyvdB3yV
 jKxk7EHM38szl+hPqX+HXqj2icRGxzaLjaD4NRZKSOj2kb8SXp2uYJzaCs8C1zOQ24ThR+URx
 9T0LEs99r7j6DQYrsAHH53HY2nh2reVRaAJW9MnPsk8cYozhfwgCt11aIyzFOcmBr+cy/AVgS
 fWcVe6CmHWXz9WZZcJPMbKk4S0OeVfuuRPgA1f98RRpfJN7U04bEsi/3Z/MkJA0nTMTP7kebE
 uHnbYCMml3QKeBRq1IgXB2RoWX9AZ+NlsaZV/59ZRL+7d2DWRjrStFmqvbufOOrJUrUqituj5
 KNANRNOFBTaFkNC25PwDS6T7gHWKFJLNjUzDbhsNeiKT7/OmxZpMTDPvdQXj9DaCqJIj1INIg
 HfEnHUzp8mAAWTlDBv6/3TrvddPe65/D1ht8u0Nq0jYBPl8mbtMvOlWa4DNGdBr0goqZm1SYK
 86VFg3b0ejVAd2SsMonw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 24, 2021 at 11:11 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> This reverts commit 50fb34eca2944fd67493717c9fbda125336f1655.
>
> Since IO_SPACE_LIMIT is not really being changed there is no
> real need to adjust the ioport_resource end limit.
>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
