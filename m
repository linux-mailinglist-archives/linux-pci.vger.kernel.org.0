Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC00C3E8A3D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 08:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhHKGeO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 02:34:14 -0400
Received: from ni.piap.pl ([195.187.100.5]:57836 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234674AbhHKGeN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Aug 2021 02:34:13 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 13AA7C369544;
        Wed, 11 Aug 2021 08:33:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 13AA7C369544
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1628663629; bh=Rf3odP/2nQECwS2Q8rkyDShCByYgbf9l8DET/R9ZeuI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PG9r9ci/4uNLJolzAy/+VBc3IwaHJqEKkx0rOEW6Secoed7Ue5mVl4TkV7ZsGOK08
         i58+H3clBaqfjuw14aY51OCDPGHKdliwlu9F3PQVOskwAyXtoTlagyO6aynfMf+fht
         r0IUDBmMCUxf86HuYKG8GyItW+ZuuPiD6R7HoPo4=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Artem Lapkin <email2tema@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: ARM Max Read Req Size and PCIE_BUS_PERFORMANCE stories
References: <20210810232736.GA2315513@bjorn-Precision-5520>
Sender: khalasa@piap.pl
Date:   Wed, 11 Aug 2021 08:33:48 +0200
In-Reply-To: <20210810232736.GA2315513@bjorn-Precision-5520> (Bjorn Helgaas's
        message of "Tue, 10 Aug 2021 18:27:36 -0500")
Message-ID: <m3r1f08p83.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 165505 [Aug 10 2021]
X-KLMS-AntiSpam-Version: 5.9.20.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c, {Tracking_uf_ne_domains}, {Tracking_marketers, three}, {Tracking_from_domain_doesnt_match_to}, t19.piap.pl:7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;piap.pl:7.1.1;127.0.0.199:7.1.2
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2021/08/11 05:40:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2021/08/10 18:48:00 #17010874
X-KLMS-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Bjorn Helgaas <helgaas@kernel.org> writes:

> Super.  IIUC, i.MX6 is another DWC-based controller, so this looks
> like another case of the issue that afflicts amlogic, keystone,
> loongson (weirdly apparently *not* DWC-based), meson, and probably
> others.
>
> Some previous discussion here:
> https://lore.kernel.org/linux-pci/20210707155418.GA897940@bjorn-Precision=
-5520/

Ok. So I guess the fix for i.MX6 is a simple PCI fixup, limiting MRRS to
512 (while MPS =3D 128).

Now the Kconfig states that MRRS=3DMPS is the "best performance" case. Is
it really true? One could think requesting 512 bytes (memory read)
completed with 4 response packets 128 bytes each could be faster than
4 requests and 4 responses. Various docs suggest that lowering MRRS is
good for "interactivity", but not exactly for throughput.
Should I do some benchmarking?

> This sounds like a defect in the CPU/PCI host adapter.  If the device
> initiates a 4096-byte read and the CPU or whatever can't deal with it,
> the host adapter should break it up into whatever the CPU *can*
> handle.  I don't think this is the device's problem or the device
> driver's problem.

As I see it, this is not a CPU (ARM core, IXI bus etc) problem. This is
DWC PCIe thing, and the cause is apparently the size of its buffers.
That's why the max number of tags (which I assume is a number of
individual read requests) depends on the MRRS size.

The PCIe 3 docs state:
Max_Read_Request_Size =E2=80=93 This field sets the maximum Read
Request size for the Function as a Requester. The Function
must not generate Read Requests with a size exceeding the set
value.

Not sure about the "set value", but perhaps a limit (lower than 4096) is
permitted - e.g. for the whole system or bus.

The i.MX6 errata list states:
"ERR003754 PCIe: 9000403702=E2=80=94AHB/AXI Bridge Master responds with UR
status instead of CA status for inbound MRd requesting greater than
CX_REMOTE_RD_REQ_SIZE

Description:
         The AHB/AXI Bridge RAM is sized at configuration time to support i=
nbound read requests with a
         maximum size of CX_REMOTE_RD_REQ_SIZE. When this limit is violated=
 the core responds
         with UR status, when it should respond with CA status."

The above suggests that aborting an oversized read request is ok. It
should be done with a CA (Completer Abort) code rather than UR
(Unsupported Request), but that's just a difference in the error code.

>> 2. should the PCI code limit MRRS to MPS by default?
>> 3. should the PCI code limit MRRS to the maximum safe value (512 on
>>    this CPU)?
>
> How do we learn the maximum safe value?  Is this something a native
> driver could read from PCIE_PL_MRCCR0 (see below)?

It will read "512" by default (unless maybe some boot loader etc.
changed it).
I think, for these particular SoCs, a fixed 512 would do.
But perhaps we could experiment with larger values, which need to be
*written* to this register before use.

I will think about it.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
