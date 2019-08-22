Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3BBB99EBF
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 20:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389872AbfHVSaB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 14:30:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:33105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389478AbfHVSaA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 14:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566498552;
        bh=FYVNo5/bQvqqmz05d9b0+Cgq3pxGeQgfQ86xDlvmyjY=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=C0yY62Czp2RdOZxxmBKdkN26nqr08KeIy+C0QO/ZZopQF1crVDhHPy7T37ovSSpVR
         XOi3Bl5KHMP31oyIIUowpD3o/WrFkKNIY2FyIBttmBKp1Dkwv7MflcclYwjfCjMRf4
         SznRgusPDonaPxYt61LhzFD4nV5nZ6EXAa3vy13A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mandree.no-ip.org ([84.160.52.178]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGz1f-1i50YG4BTX-00E1dH; Thu, 22
 Aug 2019 20:29:12 +0200
Received: from ryzen.an3e.de (localhost [IPv6:::1])
        by ryzen.an3e.de (Postfix) with ESMTP id B664D12009D;
        Thu, 22 Aug 2019 20:29:09 +0200 (CEST)
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Justin Forbes <jmforbes@linuxtx.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190821124519.71594-1-mika.westerberg@linux.intel.com>
From:   Matthias Andree <matthias.andree@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.andree@gmx.de; prefer-encrypt=mutual; keydata=
 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
 H29L93g/7fa+B3v7
Subject: Re: [PATCH] PCI: Add missing link delays required by the PCIe spec
Message-ID: <9f741e3a-0878-b914-39d8-a64a02484cb5@gmx.de>
Date:   Thu, 22 Aug 2019 20:29:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821124519.71594-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:hk71wlO6wHk8mOv0a69PKHx142otvggbuv+k51ibu+NiWz5Ojiu
 pbq4VpA2cnC7Fyo7oNjB/zJ5XntOpoXXxqtQaDMfwzt6F4VhAdW01Fopsq2/kHnveh2jA2G
 bX25G4SQjQ9W6Sy1JYHTaHnTc4CxhJWRRekCzJNB0lrQoxPEOwaTSXhhsNpceThadvXgh6z
 yQaIbK+b9NLYHjJkEMzPw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:j7ypu0fgU5o=:5XuwDIRsRBqap8u6ho2+Ax
 gOG1J2X4lS6jBIFQprbobYz04Qr7n/CRu2AhByaLXV0C4pgzpgE3e86J5oyBkliT40n2KZPry
 jHbIRjtRm3gI22NpSvmVxjJ9ZbuHnIFbBLm1uE4Ob3kFjZqUHV/1ohRHB0qmmtY7v53JLI5vx
 J4D39Ehrq3DZB+c2DsmSWOybBCHrPZQhxvze3zxDhWejuj5KNS2NZVl6bmgEzsKpbfGQtYUk9
 BWhQVA3krD+GAJlsJ4yFI7kkOdrYGv1tp1QPBUxgrAobMvMxxz2+EC7U6c7z3wIgUhHqRztSi
 OEuI+Mw1qk1yP6FuKuvzZIVOblzmjXY8wRO5E3Bn9jPzkmE4OJlqg/HV6Y1okzOij63gLI6Bc
 EFk29pyuOcc6FnApwL1LSV7tQWrul81BHLXDUzL7SrV/hzVPlOWHNJIA6rCC24JbEYdU1DJL0
 LfSWxY/BxH4NwhjUp9WlAUsMtZavT3YKl1HzLtrsDvDg+/dro6y4AsoUhy0YNKNWZfnK9WFve
 m2wKSTKRzuj5UuQ4PLINSWnsm9L4lVGa4q415VOPuoAQU69AcwC7+6KK/hR0ISLAOKgC58GI7
 ugCdyh9AF3OcWLebaPoRDZUyUlG4i2hnpD+N115bfqN9C3+JQKwJSPkHiPM63Jn2sH3brfFxs
 6B7cYOENMGoaEooldiXkczLJ/YMNKiKh32odZIGAsQTOjTan0ZG+czZCxp37EMfasgfnXRK7V
 M9XC+QxfQXNECoOZ4uEWtoahQlftfkyby9vN5YUnzjPFJ9pupCw8ZZ9YP5nJwyc7ixhZ9sZvu
 fd3fgbj9PU9YVgHEfWXjLilxRg73MimpUvjc84myIpkU4NvLOXO628JUQ6gNRcwBucVK3TPyy
 lL0D7sUVCxJJ/n6grhPwyaZqHs65a4l/V0F4A1M/xgPcKmmGQrxc7D1rmqYbo8QZnQyo6ffkR
 DFxTlZAn7vzGoTOvb25rj5Bpbbh1MYycl784XmR3cmVlcb6IVZoC+OCz6bI+VTyYYvwll2QGZ
 ed6ABHTBtzTYz3DukNR7DGP3F0kLdkTfCFhB6zexdLxkDpBKQBHneL5tcMcm4VHX3jBvm4UZp
 LqHUkYcxdWqwA4u0qPAtrzxGGp80CjGwF0oS8L0PpC0fn9yeVrunwAx2SLW6ZboaXrtR3SkmH
 N3cMc=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 21.08.19 um 14:45 schrieb Mika Westerberg:
> Hi all,
>
> As the changelog says this is reworked version that tries to avoid repo=
rted
> issues while at the same time fix the missing delays so we can get ICL
> systems and at least the one system with Titan Ridge controller working=

> properly.
>
> @Matthias, @Paul and @Nicholas: it would be great if you could try the
> patch on top of v5.4-rc5+ and verify that it does not cause any issues =
on
> your systems.
>
>  drivers/pci/pci-driver.c |  19 ++++++
>  drivers/pci/pci.c        | 127 ++++++++++++++++++++++++++++++++++++---=

>  drivers/pci/pci.h        |   1 +
>  3 files changed, 137 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index a8124e47bf6e..9aec78ed8907 100644

=2E..

Mika, Bjorn, Rafael,

quick smoke test, this test applied with git-am on top
v5.3-rc5-149-gbb7ba8069de9, reboot, suspend, wake, suspend, wake,
hibernate, wake, looks good to me. The top of git log --pretty-short is
shown below.

Couldn't test on v5.4-rc5 though as I've handed off my time machine for
repairs,
I seem to recall they said something about the flux compensator.

Thanks.

Regards,
Matthias

> commit 0fa4a33a010bdd24edb50b9179109c6639d5f6b5 (HEAD -> master)
> Author: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> =C2=A0=C2=A0=C2=A0 PCI: Add missing link delays required by the PCIe sp=
ec
>
> commit bb7ba8069de933d69cb45dd0a5806b61033796a3 (origin/master,
> origin/HEAD)
> Merge: 2babd34df229 e4427372398c
> Author: Linus Torvalds <torvalds@linux-foundation.org>
>
> =C2=A0=C2=A0=C2=A0 Merge tag 'for-linus' of git://git.kernel.org/pub/sc=
m/virt/kvm/kvm
>


