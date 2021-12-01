Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA199465060
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 15:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbhLAOwH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 09:52:07 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:47583 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241314AbhLAOwG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 09:52:06 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MHGPA-1mo5L118fg-00DFo4; Wed, 01 Dec 2021 15:48:43 +0100
Received: by mail-wr1-f50.google.com with SMTP id u1so52801192wru.13;
        Wed, 01 Dec 2021 06:48:43 -0800 (PST)
X-Gm-Message-State: AOAM532k9tbxxA2pf+yWrYPd1j4hgCkjtRis1VXWVCXZJddRzvx+YOhG
        pzPipVYfuhjdf18xWm7O8ijyBMeyk7fXhLqInw4=
X-Google-Smtp-Source: ABdhPJzo2pMWE4T6XNg8FA0+pXNoUCDZCXkh9eo9Ar1pSsX/C/rQBtRN77mPrv8JrJZTJtKGbN+WSmlFuKU2r4FOWPY=
X-Received: by 2002:adf:d091:: with SMTP id y17mr7656798wrh.418.1638370122901;
 Wed, 01 Dec 2021 06:48:42 -0800 (PST)
MIME-Version: 1.0
References: <20211123180636.80558-1-maz@kernel.org> <20211130115632.GA3355@lpieralisi>
 <b2a06abf476b3e89504a227b3d1bea7c@kernel.org> <20211130121237.GB3355@lpieralisi>
 <87ee6xn76w.wl-maz@kernel.org>
In-Reply-To: <87ee6xn76w.wl-maz@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 1 Dec 2021 15:48:26 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2WxO4vEAKbp92dA7SDCxdtSdMeFi+rJ8WJWqcHYYqksA@mail.gmail.com>
Message-ID: <CAK8P3a2WxO4vEAKbp92dA7SDCxdtSdMeFi+rJ8WJWqcHYYqksA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] PCI: apple: Assorted #PERST fixes
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Android Kernel Team <kernel-team@android.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:p4L5zIWucwairGWiVXCqZuS2AC2PIyh/X5XtfHlTCQ3Tt38Ofmz
 dVrvPEnmg5QUv5hp2hrGwDEWSQAtX3cxbNQlkivFmPHJ8PFopJtjRO247wxp69FEwWb/3kK
 Q1pW/JmAYdoMArX6rXmeBjaW8pGjjC9+11U5/Fe+zh7pLiyFqVg767krOjqG2WJJcMJ7HL8
 pY0uQyjC2Zn5B00xrN15g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ArW6EmOkN8I=:Wn9m2vE7YkezfkwNN06UVB
 52RycsfIY2De/6a9FxqjpO1CDzAQhp1BUfvb4fBr9ADeg0Oygv+zdRIXyVXQOOOcPdLl0BGy5
 o0onHwR13mawsFocn/h24Kj5wDMph/H0oOJLV+3ZsE+pmdqdfSf2gzv/4GXphje8k1wgasdwH
 qZhG5xFA7GCEaADYTEk9Vs1TqbBD9BevB2Po7NCm6urGC/2s+ZOlsOEHLn0u5H/Sw1vkMsbBz
 0SlPIvCspgC9aCh/iGTmvS+MdTMwKUZW7jWFcbKSHXpTWclyOQIpaEt4sCzrJL25t++S81QUX
 S2EQY/+sXbUClg4ww6H/SC6DTds0T7e7csvEbQsj67HWqUrJ9KMcCcBmT0Pcbs5f/znifLlyR
 olBzK06hQ7Si8zUNkTTnckET/hAzeKySE5XlUqgQOLQhHoXmR9aO3vc5KM0hoiLJqxRJJy8Km
 3UfD/KKmHGc/rSm2wkCHRhqEKHgNtg+jsxMOu2wfGnZykc2AVS0CVF1+LIqGjLYx81xeQ3Ynn
 pcL1Qz0rI+kkSf6JHe1DHqkube5NcK/Jb+JhpBVy3zk2KmPPEqGOa5NfhBZ53N1y+ydpmtRBw
 l3tKhhH2bqa6eot7Ijp0VoESTU6jk3pwLkdd2wTAQButdYEc7aPdqzA2XNhNSElKiBGkUx9jd
 31I1DVz1dNURDJB77VcO1TWrlEAQ+q8+ygkaD9Daf82HCXsvH3o/qlsfw+H2iKsNhL0j1uEdE
 RYL9M3FXt+cYOy7EhNHiZLazwAWegC2bOsLSe5A8hOHbQ3bwkg9TKMLTndr7gEmOnA91YDMvZ
 b6EO4mPiGavOi4+XRixlh3gi2hmN09qIiQoDSFSAFXcO1MrWcw=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 30, 2021 at 1:45 PM Marc Zyngier <maz@kernel.org> wrote:
> On Tue, 30 Nov 2021 12:12:37 +0000, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > On Tue, Nov 30, 2021 at 11:59:32AM +0000, Marc Zyngier wrote:
> > > On 2021-11-30 11:56, Lorenzo Pieralisi wrote:
> >
> > We were told that we should not pick up dts changes, they would normally
> > go via the ARM SOC team, not sure whether the fixes policy is different
> > though but I suspect that's not the case.
>
> OK. Doesn't really help with keeping these two commit close together,
> but hey, if that can't be helped...
>
> Arnd, do you mind picking up patch #2 as a 5.16 fix?

I try not to bypass the platform maintainers, I'd prefer if this came
my way through
the asahi tree (just replied to the patch as well). In this case it
sounds like there
is a good reason to have it go in along with the driver change, so that's fine
as well, and I provided an Ack for that.

       Arnd
