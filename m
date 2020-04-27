Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2A21BAE02
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 21:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgD0Tcr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 15:32:47 -0400
Received: from mout.web.de ([212.227.15.14]:54133 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgD0Tcp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 15:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588015951;
        bh=yriEMMSw+mJO9UE3z78SkastypBUctvQc/BJwAY/K4I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Pg6N2DaRHMhT1lufSSwrpSjQulFWPHLusHx2KYsgA1AstCjKQCU37JxSq57fBen5O
         mkcNuvp2Y9hug36QYI2/BkDdI+r4UkAN/FZjBUv9PhBHA2r+Vf3DRrTsJoX92AS86m
         JSbVr9O1gLzWmbMNFqyHzL5I+35tU0Vobvs6VfRc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.31] ([89.12.68.2]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lmu5s-1izaV90Loi-00h2Py; Mon, 27
 Apr 2020 21:32:31 +0200
Subject: Re: [BUG] PCI: rockchip: rk3399: pcie switch support
To:     Robin Murphy <robin.murphy@arm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <4d03dd8c-14f9-d1ef-6fd2-095423be3dd3@web.de>
 <3e9d2c53-4f0d-0c97-fbfa-6d799e223747@arm.com>
 <b088ad0e-bab1-0cff-dc43-eb5709555902@web.de>
 <1f180d4b-9e5d-c829-555b-c9750940361e@web.de>
 <d02e0b72-5fb3-dd47-468c-08b86db07a9a@arm.com>
From:   Soeren Moch <smoch@web.de>
Message-ID: <213ff8e4-0921-6e06-a98e-e7d955ca279d@web.de>
Date:   Mon, 27 Apr 2020 21:32:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d02e0b72-5fb3-dd47-468c-08b86db07a9a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:egsP99ZUL8Q+NhjQ+Y0Iq7o0uFlAWiM0eMjSXXzuHmfsXEl14dK
 U+SWHY1f5u+fSuvX1bzSu9vM8qM9x4WbC7UKxeiyUDxrX0H3bR+c3qytIupN6N4fiUGsfyP
 xob3RNlqojne4h78YczVbCiQxUE33jECVf0HPYdAowDfEMU7a+9vSMQLH+/Tx+LOh0+6Fio
 ET093r0Woc7k+juuvDXPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y5F9Zlf49Qc=:1ioKBA093oWxuGDt9c4A2E
 p/qMSJASroWOWPbQc/Z59EoXV03oc4p9t/klcXOEbGaeh55bxbSCCZ9y4Wl3BvnI916xQv5NF
 o3ULvV7wCbFURDG1VwnSKPYMsPlEIPmHUXCojGwopZ37EflqIg5DJeS1vsCh1ZX1//Uczbkqb
 U0MKh0b1gcQOln/XrSrHmnC9UWsbmv5W84OeKr9BqyFqbXoE0BnbqocnN9K7EOMY++aMQrt/S
 NkUIudEWyHz4SmFjEdHapCKkyVqlTifSjaOlx97Z+iaX+DOBYXKpcmIUH+rshr24iJoBDsCGR
 /IVw1vPp2qqb9hpd6vtVX9k2wlXu06WBHPcZpOm9SmcJ2aJQIXTDjJfspNycBCQVmeOBEeAkT
 nB8Ku7wdcAK/dkUs5LzkZ88GJ+Cmx9quOtEK8FBSzpo00XpP1339fbqVuqF5Poa6CkeOVaNFT
 gvNVBqQjq2HH+PYA8ZZX+yR8OTv+BlAalrGpQPysBGUUdMI1LF+0FCs33T+/rvDZZ/0VVXc0I
 qj6hL56m3b4w1OW3sWoE5j0VdM3ZkS2XxdFoPcnmjFUJAW73yrvyA4kroeOJWlYNPZjVWwwJg
 ebFvYfAFD0L67b5pI7+idEWKJiBnkzBow+nXPo6NJiN4PPxNfCgAn9sRHb8X0d/3/iBQxy/Kz
 MEKHJMHhs6KoDAPMO0mKcQxmbE9W74i/UnKI1FWWF8nuH4XcXLN74wcR/Y3jO8xcIsi/lnnEg
 +GEEwkH0+meGkRtyRG+LU8kFAwQJvAErPaDLetVzTdv3fwi1pbTAiEmngtLsaL3Ysd4tODFp4
 xGrVsiaY7ebrZ/+JELnb+IsIHq2Ez0qKudErn01vwaftQKoRCxtB1pQErDKKgO0AXLypLJisA
 rEDkU8fO0d+JTACZeXrUNzuloNHFo61IbBBVLVlqu+Xu5UU1o9s/F0iYN0ePsTEzBW1sWM+Fe
 UE9Q6iVtSL5GZ3p3X2+VUVGnpgGCSTxKJrBcdLdbZce957fg0jU1pIf11pIbhu085pLNqVz95
 cpe9pmUlgaL7hd/g1gLu3mXyyEnJnq1Wg/RIXS/qDV8fASdLCnaDHq309ajeSSgYX3H7Sh2ML
 IgV7O5+lt4q70BzLUDhQjZohr1oCooliHekSIjJ5W/KtpEu4Q29dm7bvFr1xXZxNI/WidsSji
 6LTVl6wI7oJTnqdBh9WU++h0CRw5Tjx+lW23wFhh1gx4T77raKEeRnx+sCC5RNPHCIdMp4OpF
 5RVZo2UFFJWwx9B3Y
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14.04.20 14:28, Robin Murphy wrote:
> On 2020-04-14 12:35 pm, Soeren Moch wrote:
>> On 06.04.20 19:12, Soeren Moch wrote:
>>> On 06.04.20 14:52, Robin Murphy wrote:
>>>> On 2020-04-04 7:41 pm, Soeren Moch wrote:
>>>>> I want to use a PCIe switch on a RK3399 based RockPro64 V2.1 board.
>>>>> "Normal" PCIe cards work (mostly) just fine on this board. The PCIe
>>>>> switches (I tried Pericom and ASMedia based switches) also work
>>>>> fine on
>>>>> other boards. The RK3399 PCIe controller with pcie_rockchip_host
>>>>> driver
>>>>> also recognises the switch, but fails to initialize the buses
>>>>> behind the
>>>>> bridge properly, see syslog from linux-5.6.0.
>>>>>
>>>>> Any ideas what I do wrong, or any suggestions what I can test here?
>>>> See the thread here:
>>>>
>>>> https://lore.kernel.org/linux-pci/CAMdYzYoTwjKz4EN8PtD5pZfu3+SX+68JL+=
dfvmCrSnLL=3DK6Few@mail.gmail.com/
>>>>
>>>>
>>> Thanks Robin!
>>>
>>> I also found out in the meantime that device enumeration fails in this
>>> fatal way when probing non-existent devices. So if I hack my complete
>>> bus topology into rockchip_pcie_valid_device, then all existing device=
s
>>> come up properly. Of course this is not how PCIe should work.
>>>> The conclusion there seems to be that the RK3399 root complex just
>>>> doesn't handle certain types of response in a sensible manner, and
>>>> there's not much that can reasonably be done to change that.
>>> Hm, at least there is the promising suggestion to take over the SError
>>> handler, maybe in ATF, as workaround.
>> Unfortunately it seems to be not that easy. Only when PCIe device
>> probing runs on one of the Cortex-A72 cores of rk3399 we see the SError=
.
>> When probing runs on one of the A53 cores, we get a synchronous externa=
l
>> abort instead.
>>
>> Is this expected to see different error types on big.LITTLE systems? Or
>> is this another special property of the rk3399 pcie controller?
>
> As far as I'm aware, the CPU microarchitecture is indeed one of the
> factors in whether it takes a given external abort synchronously or
> asynchronously, so yes, I'd say that probably is expected. I wouldn't
> necessarily even rely on a single microarchitecture only behaving one
> way, since in principle it's possible that surrounding instructions
> might affect whether the core still has enough context left to take
> the exception synchronously or not at the point the abort does come back=
.
>
> In general external aborts are a "should never happen" kind of thing,
> so they're not necessarily expected to be recoverable (I think the RAS
> extensions might add a more robustness in terms of reporting, but
> aren't relevant here either way).
>
Okay. In an ideal world we would not need software workarounds for
hardware bugs.

@Shawn: Can you point me to the rk3399 errata you mentioned in commit
712fa1777207c2f2703a6eb618a9699099cbe37b ?

Thanks.


> At this point I'm starting to wonder whether it might be possible to
> do something similar to the Arm N1SDP workaround using the Cortex-M0,
> albeit with the complication that probing would realistically have to
> be explicitly invoked from the Linux driver due to clocks and external
> regulators... :/
>
Sounds complicated.
For me I use the patch below. Of course this hack is not intended for
merging, just as reference to conclude this discussion.

If someone comes up with a better solution, I'm happy to test this.

Thanks,
Soeren


=2D-----------------------8<------------------------------------
=46rom 9f2e26186bbf867f1baada057bcbd843c465c381 Mon Sep 17 00:00:00 2001
From: Soeren Moch <smoch@web.de>
Date: Fri, 17 Apr 2020 12:14:04 +0200
Subject: [PATCH] PCI: rockchip: rk3399: pcie switch support

Due to a hardware bug the rk3399 PCIe controller signals error conditions
to the cpu when scanning for PCIe devices, which are not available. So
PCIe bridges are not supported.

The rk3399 Cortex-A72 cores generate SError interrupts for these false
PCIe errors, Cortex-A53 cores generate Synchronuos External Aborts.

This hack enables PCIe device probing on buses behind bridges by
ignoring the generated SError. Device probing needs to be done on
Cortex-A72 cores, e.g. use
taskset -c 4 modprobe pcie_rockchip_host

Signed-off-by: Soeren Moch <smoch@web.de>
=2D--
=C2=A0arch/arm64/kernel/traps.c | 10 +++++++++-
=C2=A01 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cf402be5c573..da2b64d2613f 100644
=2D-- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -906,8 +906,16 @@ bool arm64_is_fatal_ras_serror(struct pt_regs
*regs, unsigned int esr)
=C2=A0
=C2=A0asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
=C2=A0{
-=C2=A0=C2=A0=C2=A0 const bool was_in_nmi =3D in_nmi();
+=C2=A0=C2=A0=C2=A0 bool was_in_nmi;
=C2=A0
+=C2=A0=C2=A0=C2=A0 /* ignore SError to enable rk3399 PCIe bus enumeration=
 */
+=C2=A0=C2=A0=C2=A0 if (esr >> ESR_ELx_EC_SHIFT =3D=3D ESR_ELx_EC_SERROR) =
{
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 pr_debug("ignoring SError Interrupt=
 on CPU%d\n",
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 smp_processor_id());
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return;
+=C2=A0=C2=A0=C2=A0 }
+
+=C2=A0=C2=A0=C2=A0 was_in_nmi =3D in_nmi();
=C2=A0=C2=A0=C2=A0=C2=A0 if (!was_in_nmi)
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 nmi_enter();
=C2=A0
=2D-
2.17.1

