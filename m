Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5595821DFAA
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 20:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGMS3s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 14:29:48 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59107 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgGMS3r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 14:29:47 -0400
Received: from mail-qv1-f53.google.com ([209.85.219.53]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M7JvQ-1jwACL2XAy-007jq4; Mon, 13 Jul 2020 20:29:45 +0200
Received: by mail-qv1-f53.google.com with SMTP id t11so6252212qvk.1;
        Mon, 13 Jul 2020 11:29:45 -0700 (PDT)
X-Gm-Message-State: AOAM533j3JPy3Ncsg/8q6JhWZdRrSaQksOF+12rtD69PyFnWA5POxaKL
        Fq7Kj5YaMpqYckG/HXhGsXlpvRJbHwr/bTXKaRQ=
X-Google-Smtp-Source: ABdhPJwfhnh/6z+B3GNkz2O7U2CT1SIj0CHjYLjBXDThJSFXF+6qowbSkHtAc8ui9FKSnAQealaXP5kFF1JbDar0pbQ=
X-Received: by 2002:a0c:f802:: with SMTP id r2mr733004qvn.197.1594664984224;
 Mon, 13 Jul 2020 11:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200713122247.10985-1-refactormyself@gmail.com>
 <20200713122247.10985-3-refactormyself@gmail.com> <70e57af0-6a8c-a893-67c9-0181af16ae2b@lwfinger.net>
 <78b52ad5-015f-4452-0cd0-dbb2c8597672@gmail.com>
In-Reply-To: <78b52ad5-015f-4452-0cd0-dbb2c8597672@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 13 Jul 2020 20:29:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Qfojg==hiAGx0BvS1zmOEy+1vchXzcudw4EQZ4YwU4A@mail.gmail.com>
Message-ID: <CAK8P3a0Qfojg==hiAGx0BvS1zmOEy+1vchXzcudw4EQZ4YwU4A@mail.gmail.com>
Subject: Re: [RFC PATCH 02/35] ssb: Change PCIBIOS_SUCCESSFUL to 0
To:     Saheed Bolarinwa <refactormyself@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Bjorn Helgaas <helgaas@kernel.org>, Michael Buesch <m@bues.ch>,
        bjorn@helgaas.com, Shuah Khan <skhan@linuxfoundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:cwA87ZKTx/TqHmtu2pquWpCsnWi683BgVk2yjLlCYf4OdS0eGfN
 yZwspqV8na9IQ8+uOCpzSsHWSja9Xdlt53kL4dTJdWyauKsdyeEU1yPdFYBkjlXz43W3zHl
 WW7npIH8I3q8Q/xlRy8jUirCrTdMs2NG7b1rTErVgGrN1/2eg8cDnwK0vNNibl2GEkC0Wk9
 aphjnw2M2VoWjOySne/mQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sJBJH9zz6SY=:Q34SfpS+Nis/J66pNVL/X3
 06d27R9niq5bvN1nzFR7zhF0iomgrxl2Ff8SRacEZ7jR+l5XipT2gVuv5kf1FNf+uJOngFLHx
 6HjSb2PedGfo33Og5N9pKNDEGhiqzqqZ9+QsOCZqzLwxge7M8zW/ydQmiZq3nzY/Lojv/KA2v
 9/ElgzPJx7Uh1xhR3lp0++SUfxNKG9+S02eusiJ0984C18jWAcY48ab3uWgl/5tOdtSHQS5tz
 SB8LrcEfHjJkiDHczrQzHNqIWtJvIwv/x1Fr7K0mD8pbvs5uTd+Ja3Sw8J2PjWULfzV5pw0fd
 SzgDxjm+iO/sZbjdeUKunG2AKvemrrSYhuMVgRNpOoqINUntKorYyfULOh3MYt0ErYakRS8HY
 4BU/yzgU1DRuaXrmDnEWWjOh/v2co8yv7AH5D/7pw36Jdl0H9aCtYhSrCsn2pFVTgeniBSY1c
 mLWZKV0o4xi7YXByFBg2r5FeeT/0EMUaWQBzBZLariRRQGm8hbfQKu+gPhqir/79cUV18VQuG
 kHpTRycq4zQby6+VfTnl0pH2PQDn5VrTBsl7cXXy+wmFArNbFfasdRqlwwlSpZU4K/DTkWCsl
 3Y6qUWebUTqkwHxXoctiGZV94lV0xV69SKLm4iKGDw/P8c2eNLEtX6GEXXxIutYkfMtOXUHYb
 oKfoVdn/WYHCxk5G63oC2CzgSR2PLOmvXCJ/u6Q4JKg54moMcs1LUWelbxrOasLhbzR8MdhY3
 3h2/hy5xR3haS2XfqVqfij7nRTaP5ODbSD4MytXEYWf7sMbani3U/w0CjqTVU13cJP6KFx4wz
 43vq8dEyoGQA5uWMU39cc5aBbxcTQJwQBXI9E61Di1vJIeQvongxJNFYmuOhr8ZXP9EUmNckK
 k548JTyIka6Ft32t10zoAJjxxPbJ/r0dJ8lYlgVC3het7Yr7KLMqYLPCRxvEWycZ2O4FVq6fZ
 YFbrtqq55DEPflZZPmIloyx7e80Czg6dw4KlCq+AhIzAiUjg3UttM
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 8:13 PM Saheed Bolarinwa
<refactormyself@gmail.com> wrote:
> On 7/13/20 7:16 PM, Larry Finger wrote:
>
> > Why is your name inside quotes in your s-o-b?
> >
> To keep me company before I get to know my way within the kernel.
>
> I saw people with >2 names do it, so I did! Please let me know if it is odd.

It's required for a proper email header if you have a dor (.) in your cleartext
name, but it is not required in a Signed-off-by tag, though a number of people
still do it out of habit. I'm sure it's fine either way.

     Arnd
