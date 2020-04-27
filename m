Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17E21BA1F0
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 13:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgD0LHj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 27 Apr 2020 07:07:39 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:53233 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgD0LHi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 07:07:38 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MFL8J-1jR2ae1iy9-00FkXe; Mon, 27 Apr 2020 13:07:37 +0200
Received: by mail-lj1-f176.google.com with SMTP id u6so17077661ljl.6;
        Mon, 27 Apr 2020 04:07:37 -0700 (PDT)
X-Gm-Message-State: AGi0PuapPICmTv287KFlG+YM5PTCZdyNoXH5kaCf3ni8yuAQfM7JN6s2
        4SkQn6SQN1YbP0PSM+CRaBlw8+GwRs1weiGiF2Q=
X-Google-Smtp-Source: APiQypLEwej04i8uRQkN6Os5zVhqOy0KYDZKX7ZU73wocL/7Eot2m5MXEJljClTt8r5GBUfCRD/dvpvefJ0BiIfXQKE=
X-Received: by 2002:a05:651c:1104:: with SMTP id d4mr13802729ljo.128.1587985656882;
 Mon, 27 Apr 2020 04:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <1587864346-3144-1-git-send-email-rui_feng@realsil.com.cn>
 <20200427061426.GA11270@infradead.org> <2A308283684ECD4B896628E09AF5361E028BCA26@RS-MBS01.realsil.com.cn>
In-Reply-To: <2A308283684ECD4B896628E09AF5361E028BCA26@RS-MBS01.realsil.com.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Apr 2020 13:07:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0EY=FOu5j5DG1BzMEoy_6nEy129kniWCjMYDEdO1o_Jw@mail.gmail.com>
Message-ID: <CAK8P3a0EY=FOu5j5DG1BzMEoy_6nEy129kniWCjMYDEdO1o_Jw@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: Add SD Express mode support for RTS5261
To:     =?UTF-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:/bHdil9bGL23Dk1uJFy9rOfFlosRrSRbDsxECtLF6FKH7Xn0lgJ
 AOi2O2l1kEDRsPcfoJ2ebvzqax9d3tsrSjBwxlNvdYIRjXdefDce+lmzWR+Ymg6e9qTceSr
 1dPOX1XCsCUuOdLHgUqOGTrgwND7pozADZJECXWECaNbYEYr5Y0de+lGgnkPWGGOw582tcI
 c+FAqayrgwvDHxdjvn6ig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t28ZbJbSjVI=:wr2fiLP5medmHY0bYSM1N8
 khfesN3HZcJjv1NbpcmYBCRZg9F6ZBa8s4BPS3LwERrVkV+ZXznQfvr0KVN3XHDdqv3WVV329
 T4tbI5x9GiYWCKfLVmA+mYf8EoMjq/ChIbIo9Yjm6ADrVpde6fQw3yd426qduvS4IMOOfbPze
 ICvfwPzgAwqmyNzkn6ppPQyGuxPHnJ9TDwiNSEwtFiBGYnrnX7hFKme61Vsfz/uNE009wh7OA
 5OpIU/oU8BclkesmE3aKx9zhkn411/2UoD+pCrwIFFPkoENfPMFUibyQTHn303Xgzxxey+VDM
 g9xilZao1To+YauOC14h170jCzT5vTMZKNqAGhazH4hSt+ViaFeT473UgL0ASEMFVIE0oemqv
 7luM1syhXa6PQoh+HUyFr39AlenCLuhY5IUckKffgkkRO5rr2A+c/fD3YVIcUL+G4vkBWnPx/
 iY6+7wrhcNPM/bZ/x8GiavUr7U9236dYmka+m1ahysV+5i+efyYtWTzDu16vDUN4OYuRCA8G2
 Op87fWdTHLyqccRZjb1HpexSb3GRmmaLg7mw7516XpE/+4yFfrmTis6SA7ba9gdw6AYkE7DE+
 8+K118lPNVFQnIGxhBg4QbEVcK6H9H6Z0LS9Qc9HQDyCKJzo8Kr84KEqkzu2s/LGgW8hxH70N
 0fdwqG0683XCotiITJzCVpgL/devADv26A3L27h7PxxT0AFFl+sSd5jjtIt916L345ObC+8Tu
 /DVnkSj6oHiZMxM6dVzcx7UN2Up+tlTWsWJQRViC981yslWoEHuFgeSNvQpnalRH3s3+BUIj4
 WUtJn0byEUw0KS9LIx1g9MZ9A2OS05eSPKp3PZE9EGjfJx1wWU=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 27, 2020 at 11:41 AM 冯锐 <rui_feng@realsil.com.cn> wrote:
>
>
> > On Sun, Apr 26, 2020 at 09:25:46AM +0800, rui_feng@realsil.com.cn wrote:
> > > From: Rui Feng <rui_feng@realsil.com.cn>
> > >
> > > RTS5261 support legacy SD mode and SD Express mode.
> > > In SD7.x, SD association introduce SD Express as a new mode.
> > > SD Express mode is distinguished by CMD8.
> > > Therefore, CMD8 has new bit for SD Express.
> > > SD Express is based on PCIe/NVMe.
> > > RTS5261 uses CMD8 to switch to SD Express mode.
> >
> > So how does this bit work?  They way I imagined SD Express to work is that
> > the actual SD Card just shows up as a real PCIe device, similar to say
> > Thunderbolt.
>
> New SD Express card has dual mode. One is SD mode and another is PCIe mode.
> In PCIe mode, it act as a PCIe device and use PCIe protocol not Thunderbolt protocol.

I think what Christoph was asking about is why you need to issue any commands at
all in SD mode when you want to use PCIe mode instead. What happens if you load
the NVMe driver before loading the rts5261 driver?

       Arnd
