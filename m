Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5446081E8B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 16:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfHEOB5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 10:01:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:35221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729108AbfHEOB0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 10:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565013672;
        bh=jSkhPYZ2d0UOHGwQYXaBOmk/S07rcgz6dBX4+i3s/os=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hmpjruNfBhEWqmAPTWnz8tWlD1BZ0yWL4gt7pGMCBehc7FZkC+fXQEsfs8RJMcO5B
         gC0um+UjcuwfXNvKfAZc8dvbSr0ljvqImgJpDuBNNzRQFJWzq9UDHeN+d2oyPX9rKZ
         XqwM4hdguzknsKL4524G0Sb0x7DglBSwGXDQyKlk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mandree.no-ip.org ([79.229.32.156]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhTjQ-1ih7Rg2njM-00mX99; Mon, 05
 Aug 2019 16:01:12 +0200
Received: from ryzen.an3e.de (localhost [IPv6:::1])
        by ryzen.an3e.de (Postfix) with ESMTP id 7D6D8120172;
        Mon,  5 Aug 2019 16:01:11 +0200 (CEST)
Subject: Re: regression: PCIe resume from suspend stalls I/O and causes
 interrupt storms in Linux 5.3-rc2 (5.2.5, 5.1.20) on Ryzen 7 1700/AMD X370
 MSI board since 5817d78eba34f6c86f5462ae2c5212f80a013357, 5.2/5.3 w/ pcieIRQ
 loop.
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <935c6fd8-c606-836a-9e59-772b9111d5d6@gmx.de>
 <20190805122751.GL2640@lahna.fi.intel.com>
 <20190805124704.GP151852@google.com>
 <20190805130039.GP2640@lahna.fi.intel.com>
From:   Matthias Andree <matthias.andree@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.andree@gmx.de; prefer-encrypt=mutual; keydata=
 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
 H29L93g/7fa+B3v7
Message-ID: <0d234153-3c30-c0da-7419-220528897fbf@gmx.de>
Date:   Mon, 5 Aug 2019 16:01:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805130039.GP2640@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:TPC/+TYwX1szOBr3W8eWzyOxnClYAtl/gfeDE18Odc6l2GrZSbz
 IR7YKBMXbDj2nU5F/+opqOIehJGav1ej+16pHN6N2wE2SPsQejiTziq44NzYi8PiCXjeDzK
 VmZniiSHXY55IBa9X5cd5GYeQzkryvl+8nfPX33Phhpe/KHa/k0jmmmNF8A1Rx+0UJ+5tNq
 R+G9nMdSmOsIAB9EyFaCg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ka2k8x24Gu4=:XVWK15iJK5593RdXUoZ252
 zcJpGF1rPvTWrhUA5C2Ni92pPBompZV8YB0IyHyf6PMrZbEErEXV3O/Pgy8QSFEbhjzL8rm/d
 /ul+hgrw6/XbnB4Y4jFL8bpW7OhpTauUZbVpML/GBSPT66M/14BVbH3IOMgTDRqAfR+t6GiHh
 vF4xQs+PuE8w1+eud5cpPM4CG6fXuABJmp/zpCbhDyIMs6lvrFm4v3Nh6OrT8g1r0czuhsiyS
 uRsLa7FgUh7trt13Q1KJqrxMmNDBmlPaYdic66DPiorQpFCb2yWRkjnP47dQUJ/AvQ3WpQLcA
 dQm0Eiof4Fo/iDlinK/Tnhl2kbx9bDz+45+CmGTOJTe5/DrBsR2JYDjQv5HvFEG82rKT4RtH0
 8szTQAWY0ddt6Oh437f5jSOHbUMD4AlQoh/Hs+Nga/YBZ8uHs3fA4j+6v5V8SL7tIw0wIvRJm
 QUzzidOrZ3+uhYoGrtYf5GiiN8xRIdy82s4Gq6OyZ9Wnwq+uDiN2NFJtc9X9FeW/V6ZlgffnJ
 Wgp8zdu5TsdrqQ+TOKzuqsxBRFMhvZibFVPpMfn09Cem5digh4/vX31dubmwKbD+LdaoF9jSF
 buaTX5scRUCTnM4SQGJlMmr3C/mFBmN2i/KNUwgpb0VP/BAHDjuFt+Z5dvT2k9LUX01H+OfX5
 8HfpWfo45P1j8Y/0Ye60+GvCTHxPDckLX8cJQC/QZpYD12zz4p1ULeQnT7Cm6n9X7+EAkOQL+
 tVYRW1AZ57Fh/+uJFjd7RXWtEEvVW6RORdBnVBEy94KMUwb55jJ+20o27mY8qQ6iq1shSCv/o
 HYwycOkhU2swptBHDrg8m1heAbRc0UEePH+nVfDuDbMlumi+uRarwofjmyVb/bvuMDNBsV+ok
 z0EHyHnNZmlB31Za1VoQoFMrEwiFJb17lRvRWwuQTJR0V/1tVFmCpDEkjFAMAwr1bXjT3H8tV
 pEF3k/kEIN/AtS2PPxGD4NDrofwDXbSg3mobSTzHuZZQwH28AECqj2ejleCCszpreWL/i44So
 g9Yxuf/59EYRVs5lz3NtM1A+lCUQhRiNQNfx36fR8yhNXclCnDHJCUmUfTFJEEaaEZsPMlv7A
 TzwE7V7c1cxz6A9QzxC10q+7d+ZxN0WAemjbqScWZmuH+MfYR0fhSVsvRjavQ9IiCXyx6Ec0I
 7Z8S8=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 05.08.19 um 15:00 schrieb Mika Westerberg:
> On Mon, Aug 05, 2019 at 07:47:05AM -0500, Bjorn Helgaas wrote:
>> On Mon, Aug 05, 2019 at 03:27:51PM +0300, Mika Westerberg wrote:
>>> Are you able to get dmesg after resume or is it completely dead? It
>>> would help you we could see how long it tries to wait for the downstre=
am
>>> link by passing "pciepordrv.dyndbg" to the kernel command line.
>> "pcieportdrv.dyndbg" (with "t"), I think.
> Right, thanks for the correction.

Hi Mika, Bjorn,

thanks for picking this up. I have used pcieportdrv.dyndbg=3D+p (not sure
if something else would have worked) and was lucky that I could transfer
dmesg to a USB stick before the machine went completely unusable.

$ grep pcieport dmesg.txt

[=C2=A0=C2=A0=C2=A0 0.698739] pcieport 0000:00:01.3: Signaling PME with IR=
Q 28
[=C2=A0=C2=A0=C2=A0 0.698799] pcieport 0000:00:01.3: AER: enabled with IRQ=
 28
[=C2=A0=C2=A0=C2=A0 0.698966] pcieport 0000:00:03.1: Signaling PME with IR=
Q 29
[=C2=A0=C2=A0=C2=A0 0.699017] pcieport 0000:00:03.1: AER: enabled with IRQ=
 29
[=C2=A0=C2=A0=C2=A0 0.699188] pcieport 0000:00:07.1: Signaling PME with IR=
Q 30
[=C2=A0=C2=A0=C2=A0 0.699230] pcieport 0000:00:07.1: AER: enabled with IRQ=
 30
[=C2=A0=C2=A0=C2=A0 0.699816] pcieport 0000:00:08.1: Signaling PME with IR=
Q 31
[=C2=A0=C2=A0=C2=A0 0.699860] pcieport 0000:00:08.1: AER: enabled with IRQ=
 31
[=C2=A0 119.637492] pcieport 0000:00:03.1: waiting downstream link for 100=
 ms
[=C2=A0 119.649285] pcieport 0000:00:08.1: waiting downstream link for 100=
 ms
[=C2=A0 119.649287] pcieport 0000:00:07.1: waiting downstream link for 100=
 ms
[=C2=A0 119.649376] pcieport 0000:00:01.3: waiting downstream link for 100=
 ms
[=C2=A0 119.803025] pcieport 0000:16:08.0: waiting downstream link for 100=
 ms
[=C2=A0 119.803031] pcieport 0000:16:01.0: waiting downstream link for 100=
 ms

sudo lspci -vv # uploaded to Kernel bug, see

(deep link:) https://bugzilla.kernel.org/attachment.cgi?id=3D284193

(bug:) https://bugzilla.kernel.org/show_bug.cgi?id=3D204413

