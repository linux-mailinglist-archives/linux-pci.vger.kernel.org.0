Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD0DF8030C
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2019 01:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392490AbfHBXLX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Aug 2019 19:11:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:55679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbfHBXLX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Aug 2019 19:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564787474;
        bh=V24GlG12kkB+1dfyf8O7F0vjRDyHppfb1gzsH5KSgGk=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=GkI4yNiMCYHMf2aai+SCwAa0LVdquF/q9cLeo99drcu8EpW11hDTO+KuqaPbcylWP
         l2ULSDkiPdcV+iX1f+mjM4aHXcmtTKIZGqBU9DY2e3T5u4uBQhS2pBDEQEN+mJx+oc
         0ybQSGkmAyvSVDbiLHLKd+epGCqdyTvXiPORPwYE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mandree.no-ip.org ([79.229.32.156]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LomuB-1iaCBl00VP-00gs4v; Sat, 03
 Aug 2019 01:11:14 +0200
Received: from ryzen.an3e.de (localhost [IPv6:::1])
        by ryzen.an3e.de (Postfix) with ESMTP id 48023120DDE;
        Sat,  3 Aug 2019 01:11:13 +0200 (CEST)
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20190802220816.GM151852@google.com>
From:   Matthias Andree <matthias.andree@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.andree@gmx.de; prefer-encrypt=mutual; keydata=
 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
 H29L93g/7fa+B3v7
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 204413] New: "PCI: Add
 missing link delays" causes regression on resume from suspend to ram]
Message-ID: <506e7010-ee7c-1bc2-8148-430fa7fa2415@gmx.de>
Date:   Sat, 3 Aug 2019 01:11:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802220816.GM151852@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:psVKpY8LqpKAzyD/dxezKHRQ7Lry/eLCK/2XoHJN6VX4Sr7cT7E
 xzljPoLNs324mmPODDrzWZdtQ8fMcumF34u1gY8kntOqTWbmDt7p9ebwZE6j4OdwpSu/17H
 qvZaDxRwrOsqU5rSKjrqWbP7bv6IXe5QmWCCaiOsO1ANKNadWICSDRmClF//2LchHpsdzel
 Lgm0pvN35alrPMlowADZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KJEtMAclr5s=:buq2mvfixYsbIfm/6vyLto
 nd9t+DP/RJxwmGtDGIGKOc7lidqozSWAr84IG/TaHvnzt3bDyWGYnuzsTdyKE/ta+2azKNtFe
 0WxijUq7ZhtDqbYKWA3g1Ev1UAZwXBZgYPYXoObY+mUJ3bPVYdGCmmRzJsts9550c0uJV6TmO
 P0MXFQZdhOanhZECkbOrY0dsShSXkLyEj3mm4mDuvYtTSxIuDkSX3nqg2zyq33Nxn9NEK19Mz
 dsRBA8KZka2kLaQkNvaSIRYVGcpDZMUDPEXa5TqfT0r3clkC+x74Dvtxc01yZMiWktvKtRQow
 gS+QyXDDlc2KTEsb9efmQxV3F7EjEqgylwU4LHGq8O5EaEn/AkGzmuiwUW4U7e6ZPK1E7iNFE
 6FfGUl0i4Vt5XsOgjebCudUCAj4f9hd4+DnM3x4MEuNbt6z4jLjqi0Xwovtyx4EkzIo+kRK9S
 YCPHPwOPlZaFfPJBfkWDvHpdCRkbqMAGCtNBUjlEJFiKV3A8UaksRl5dso2WIecx4HfwLGqbU
 aUnWGjqY6AeHtbJz+0BCE7sojtDE4GujrqYc4+IEi9VsIuHu5bNo+ciKVhjNfSgsQfTc8d50L
 ZuJ+AO7vYD08VnT8i1kJL+7JriIeXUh/lrUkLlLl4zqlf5PsVPodY2ZUuSVqkIuUufrer6j9D
 Km5Y5daeNDfdnswloShMIOy0rBouZHQ7up8n0DZ6JkfHruAYF40edLCf80gvFAQgYw746vu0W
 gB39+kRGn+THxq87/ea/zpK3dQZ4P8FwzPU7wAIkha6WexfN+9+XLGDCQ3CETugQV6fQlNdi9
 szYx6d5Jv6plhWhbUEnMrkTx80y3naIKHiBKrZFHtfFoCWgvKuTEsZnmb8VopntiYplvJS/Oh
 BPMKm7Zcdr+dOw5zXBhfHMRksMNlWA7F4UEINE5oHJUn3SGRa8hzMhWURIR7roptjzgo3Z9OG
 NT0qyPluNz08Uhfp4qRB0epCECj+O2Tqbe9rAWyiffUskNM+moSZq354MZNX/BuXohBN1UYf7
 Pg9Gsf1QaRk100hRNywXLTAFSPw1+wCAJYoKFKe5OBuZfDqN3GSEVTCcVKG0jpTangLxfG5RS
 q85mtT6vFwPMwq6Vn5+1XEmNi7HNUHXAgKpLUk55uhFjs/x3Eq2lwgd46O6WtRdUE40nqruLS
 afDGk=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 03.08.19 um 00:08 schrieb Bjorn Helgaas:
> [+cc Mika, Rafael, linux-pci]
>
> Hi Matthias,
>
> Thanks a lot for this report!
>
> Mika, this bisected to upstream c2bf1fc212f7 ("PCI: Add missing link
> delays required by the PCIe spec").
>
> Matthias, would you mind opening a separate report for the spurious
> PME issue you mentioned with 5.2.5?  Seems like we should try to
> figure that one out, too.
>
>
> ----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----
>
> Date: Fri, 02 Aug 2019 16:26:45 +0000
> From: bugzilla-daemon@bugzilla.kernel.org
> To: bugzilla.pci@gmail.com
> Subject: [Bug 204413] New: "PCI: Add missing link delays" causes regres=
sion on resume from suspend to ram
> Message-ID: <bug-204413-193951@https.bugzilla.kernel.org/>
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D204413
>
Hi Bjorn,

thanks for the prompt reaction and interest in the bug. I am loathe to
file a different report /now/ because it seems that on my hardware, all
three of Linux 5.1.20, 5.2.5, 5.3-rc2 mess up I/O (disk/net) in the same
way (which is the big thing), only 5.1.20 remains mute and 5.2.5 and
5.3-rc2 log the PME IRQ storms from the AMD PCI bridge at 0000:00:01.3
which might just be another consequence.

Let's see if you/Mika can figure out what the AMD B350/X370 chipsets
need to be catered for with WRT PCI link delays/handling when waking up
from STR and I'll happily see if that fixes the IRQ storm, or else file
that 2nd bug report.

Regards,
Matthias


