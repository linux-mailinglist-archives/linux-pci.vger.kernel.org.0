Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C218B465057
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 15:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbhLAOuj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 09:50:39 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:47189 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351223AbhLAOtr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 09:49:47 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MOV26-1nF3nz0A0s-00Ps8U; Wed, 01 Dec 2021 15:46:25 +0100
Received: by mail-wr1-f53.google.com with SMTP id t9so35841005wrx.7;
        Wed, 01 Dec 2021 06:46:24 -0800 (PST)
X-Gm-Message-State: AOAM5309hPNORYq8XaR4PUYMO4EuFCCJIaT0bDNbnfSuVOIf5OPzTG5C
        n6VsVjrwA0wxHxtd7AxBAQWJ0gzw4tFAhhTBzzg=
X-Google-Smtp-Source: ABdhPJxEg5r/1w/gDfBKUHkMFSPBJmkzNLxv5dteXMnmB0X88uwuOvhFFjwMxR4Q+HIIdILvI8+vwRNxXRYIqdS7qwQ=
X-Received: by 2002:a5d:4107:: with SMTP id l7mr7152804wrp.209.1638369984034;
 Wed, 01 Dec 2021 06:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20211123180636.80558-1-maz@kernel.org> <20211123180636.80558-3-maz@kernel.org>
 <3ba6ece5-9fa5-1bd8-5d11-47e2c6bda9ec@lucaceresoli.net>
In-Reply-To: <3ba6ece5-9fa5-1bd8-5d11-47e2c6bda9ec@lucaceresoli.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 1 Dec 2021 15:46:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0jvtpJWo_ruS4zvTNox-1ekX=UKFzHMOZWNCHz=nEyOQ@mail.gmail.com>
Message-ID: <CAK8P3a0jvtpJWo_ruS4zvTNox-1ekX=UKFzHMOZWNCHz=nEyOQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: apple: t8103: Fix PCIe #PERST polarity
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Android Kernel Team <kernel-team@android.com>,
        Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:SZuEMn2n6b1B+CAIBFqbzkRWvF0uBoAwl0gxMuz6W576pYAOAe4
 CajDcI/5dWLRD1MsLmAUId5G0ye4/52SXQi6j6Cd3s47cGjwPHFX6lKvkSjzH1KwWncgeFR
 srIF+NnHsTxOVkAwuNLktlQ2xVU90O9x7opUwxysKX5Pr0F5QB5jfAoku+L8qg8S5EGSVje
 XprV3DIhFShhiEgByhUWQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UbtqTtIGwXA=:9vRQexDLo0qW7WwI4sIZqB
 J4GvLFb13EwUhVXYNXDXx72iQGAQKNJ5kzE/wwxB4KwWR5A8q7soNfs050OP7TjzY9wwzkDZ7
 Bx3y0Ob9SS5KbCSOk1CzpqRDBHTvhMshyq7Pz45Qf5nQ8fXMZIA3T00FZIdZDnt/F9HWzQBoP
 rLyz4xGljKs1z4CU5YT2qarPRnCEv0OyF/HggypASriwfsTgXi0y178owRlQRxm6evZ2LkyD/
 G7gz9tyq2p//arawBwMhkbl+D9Ih1MxrgHtAWKm78OmFcstcwpSz0Yqv1ENOEgoKZTrB258E7
 7rzyQaOEblf4O58NyrM4X2YMO/GBOfyO906/fT2JJYnSvYSZOejntzcYBd5FcwWffsgH9vlQ9
 B0VTTIjns5qJPu9ZvfNy43gg7AvgKRkGwZlqO6N0fZ6/selAPWidxVdbK1CBG350HsXsJatYA
 sp2kN4aeAuiJPsbHnd4D5PWDn3mK8O1FuSZ06ssAwFkrL+j3UNaGmN4sZeTnwdGUHiM4co6hy
 Ur3z5QI1U61KxHlbualFV0hNJGdJAMXWyIHSyNNzpWqKI+kfypgJWOsHlNb21ryRO5hV31kGd
 69vP/aFvWmnnniqxK9ic3pkDtrF57zanciK8r+k3np330hZuAz+j6EcpSViYY0TD378m1ittI
 UNTwtyrmOfv7pccOPrbcnPU6BteHa89Y0QYtRflqgm4ySK4O3jlTltStOkpMCkP2ZHB7ovCbe
 Zjgmx27UREwkgsu3WbSZyGPOECeiaqxD1MBeMnqRpQSuuhtqctYV00LaWFlbKg/77j4b8rWqG
 dFPiZLcBJVblBpNR1KDdMAaMh+2M9GzDeh+GMDImqS6Rz3jqg8=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 24, 2021 at 10:17 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
> On 23/11/21 19:06, Marc Zyngier wrote:
> > As the name indicates, #PERST is active low. So fix the DT description
> > to match the HW behaviour.
> >
> > Fixes: ff2a8d91d80c ("arm64: apple: Add PCIe node")
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
>
> Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

Acked-by: Arnd Bergmann <arnd@arndb.de>

If the driver changes are not yet forwarded to Linus, feel free to add
this one as well. Otherwise please send it to Hector Martin so he can
add it to the other Apple DT fixes for 5.16.

      Arnd
