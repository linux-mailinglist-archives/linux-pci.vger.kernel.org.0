Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C8829F771
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 23:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgJ2WJ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 18:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbgJ2WJ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 18:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604009395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JwBhtcTc/l0eqToVkJ91JRuAiJn/OT287WWKFybIVfI=;
        b=R4Rs6Y8hIzEroOCeMqbQIY5lxHAyd9gUzJEZ6usGEL2kivYOqlYdTCkEhx36BKLNHROt1k
        0dJ9RIMIVtA6PHGj//pO6u+arSUWmsbuj4HSQuG6Non9dkjkoZ6ayzTwWtuQxuHBFfzGfy
        u6F09hy9/dHUHZjpyO8W1eWKR5F36EA=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-Dx2fwtD0PYChBwzw2Jtl2Q-1; Thu, 29 Oct 2020 18:09:53 -0400
X-MC-Unique: Dx2fwtD0PYChBwzw2Jtl2Q-1
Received: by mail-il1-f198.google.com with SMTP id t1so2498386ilp.15
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 15:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JwBhtcTc/l0eqToVkJ91JRuAiJn/OT287WWKFybIVfI=;
        b=hYKcXUOZHmUDZYW2ClLC+5Bb3Y9Vo/Z1ubmMcbuxwPpEEn9kp1JNzP+aUVY2Xs3P0M
         TwPQi0RLDycvNSyQEcW1wJ1jjhtvxM+gD0JeXsLbrb+CuBTnZ2T/VHLzyd/HYuTq+vjm
         ENufzmRnQR8CBDLvRpMhSJ9tmswh1MO4td+YCIfJQ8jiYR8Pgx5QT07bO9c5ObYou285
         2ehQct4B+Dwmfw6svWjdi9wqdyiNVPPuKqNojWbPyjhbPpqcPxX7ZuiyuwKU0EPwuOD3
         SZkuDP23NprIXkZWUnh8bGyiYFrqUdi2KKoslgW16zHtAaONPjXkMwdyiSwRGidfK6LK
         uYqA==
X-Gm-Message-State: AOAM531LEmFvJQxPFo4JoURYyfyq6XxWl0z6WGDxj1I/i9OLoF4NEZoo
        qzn+KJbuNleH+loX/uFOP6nI0V3+svkL0c2X6+RM+w9hkip6iFMmLI62dkN0av9NNqhruP4JBL5
        VaYNxRLRNcBynsfybWGKM
X-Received: by 2002:a6b:ef11:: with SMTP id k17mr5243637ioh.210.1604009392199;
        Thu, 29 Oct 2020 15:09:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+SLcm9LjNhqR5rSrF4G+00pAhO8APMOJwOtcEEVEa6wzPv4zyUqSLSWE1tkoU6lUgAEPPhw==
X-Received: by 2002:a6b:ef11:: with SMTP id k17mr5243599ioh.210.1604009391710;
        Thu, 29 Oct 2020 15:09:51 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u1sm4078014ili.55.2020.10.29.15.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 15:09:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 28193181AD1; Thu, 29 Oct 2020 23:09:48 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>, vtolkm@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <871rhgpyzj.fsf@toke.dk>
References: <20201029193022.GA476048@bjorn-Precision-5520>
 <871rhgpyzj.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 29 Oct 2020 23:09:48 +0100
Message-ID: <87imasof9v.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Bjorn Helgaas <helgaas@kernel.org> writes:
>
>> Another experiment: build kernel without CONFIG_PCIEASPM, set $ROOT
>> and $NIC appropriately, and try the following:
>>
>>   # Set $ROOT and $NIC (update to match your system):
>>
>>     # ROOT=3D00:02.0
>>     # NIC=3D02:00.0
>
> (these matched the ath10k card, so just went with that)

And since Marek's latest email mentioned that the WLE900 is especially
problematic, I also tried with the other slot that has the mt76 in it:

# ROOT=3D00:03.0
# NIC=3D03:00.0
# setpci -s$ROOT CAP_EXP+0xc.l
0003ac12
# setpci -s$ROOT CAP_EXP+0x10.w
0040
# setpci -s$ROOT CAP_EXP+0x12.w
1011
# setpci -s$NIC CAP_EXP+0xc.l
0047dc11
# setpci -s$NIC CAP_EXP+0x10.w
0000
# setpci -s$NIC CAP_EXP+0x12.w
1011

# setpci -s$ROOT CAP_EXP+0x10.w=3D0x0020
# sleep 1
# setpci -s$ROOT CAP_EXP+0x12.w
1011
# setpci -s$NIC CAP_EXP+0x12.w
1011

# setpci -s$NIC CAP_EXP+0x10.w=3D0x0040
# setpci -s$ROOT CAP_EXP+0x10.w=3D0x0040
# setpci -s$ROOT CAP_EXP+0x10.w=3D0x0060
# sleep 1
# setpci -s$ROOT CAP_EXP+0x12.w
1011
# setpci -s$NIC CAP_EXP+0x12.w
1011

And based on this I went back and rebuilt the kernel with PCIEASPM
enabled, and now both the WLE200 and the MT76 works with this output:

[    1.544429] mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
[    1.544455] mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> =
0x0000080000
[    1.544471] mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> =
0x0000040000
[    1.544485] mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> =
0x0000044000
[    1.544500] mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> =
0x0000048000
[    1.544513] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0100000000
[    1.544527] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0100000000
[    1.544540] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0200000000
[    1.544552] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0200000000
[    1.544565] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0300000000
[    1.544577] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0300000000
[    1.544590] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00ffffff=
fe -> 0x0400000000
[    1.544599] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00ffffff=
fe -> 0x0400000000
[    1.544768] mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
[    1.544776] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.544783] pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081ff=
f] (bus address [0x00080000-0x00081fff])
[    1.544789] pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041ff=
f] (bus address [0x00040000-0x00041fff])
[    1.544795] pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045ff=
f] (bus address [0x00044000-0x00045fff])
[    1.544801] pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049ff=
f] (bus address [0x00048000-0x00049fff])
[    1.544806] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7fffff=
f]
[    1.544811] pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
[    1.544882] pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400
[    1.544896] pci 0000:00:01.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
[    1.545073] pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400
[    1.545085] pci 0000:00:02.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
[    1.545237] pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400
[    1.545250] pci 0000:00:03.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
[    1.546030] PCI: bus0: Fast back to back transfers disabled
[    1.546037] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    1.546045] pci 0000:00:02.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    1.546052] pci 0000:00:03.0: bridge configuration invalid ([bus 00-00])=
, reconfiguring
[    1.546132] pci 0000:01:00.0: [168c:002e] type 00 class 0x028000
[    1.546154] pci 0000:01:00.0: reg 0x10: [mem 0xe8000000-0xe800ffff 64bit]
[    1.546263] pci 0000:01:00.0: supports D1
[    1.546268] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
[    1.546377] pci 0000:00:01.0: ASPM: current common clock configuration i=
s inconsistent, reconfiguring
[    1.602042] PCI: bus1: Fast back to back transfers enabled
[    1.602052] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    1.602146] pci 0000:02:00.0: [168c:003c] type 00 class 0x028000
[    1.602169] pci 0000:02:00.0: reg 0x10: [mem 0xea000000-0xea1fffff 64bit]
[    1.602201] pci 0000:02:00.0: reg 0x30: [mem 0xea200000-0xea20ffff pref]
[    1.602280] pci 0000:02:00.0: supports D1 D2
[    1.602377] pci 0000:00:02.0: ASPM: current common clock configuration i=
s inconsistent, reconfiguring
[    1.632025] PCI: bus2: Fast back to back transfers enabled
[    1.632033] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[    1.632117] pci 0000:03:00.0: [14c3:7612] type 00 class 0x028000
[    1.632141] pci 0000:03:00.0: reg 0x10: [mem 0xec000000-0xec0fffff 64bit]
[    1.632175] pci 0000:03:00.0: reg 0x30: [mem 0xec100000-0xec10ffff pref]
[    1.632262] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    1.632373] pci 0000:00:03.0: ASPM: current common clock configuration i=
s inconsistent, reconfiguring
[    1.662037] PCI: bus3: Fast back to back transfers disabled
[    1.662045] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    1.662078] pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe00fffff]
[    1.662086] pci 0000:00:02.0: BAR 8: assigned [mem 0xe0200000-0xe04fffff]
[    1.662093] pci 0000:00:03.0: BAR 8: assigned [mem 0xe0600000-0xe07fffff]
[    1.662101] pci 0000:00:01.0: BAR 6: assigned [mem 0xe0100000-0xe01007ff=
 pref]
[    1.662109] pci 0000:00:02.0: BAR 6: assigned [mem 0xe0500000-0xe05007ff=
 pref]
[    1.662116] pci 0000:00:03.0: BAR 6: assigned [mem 0xe0800000-0xe08007ff=
 pref]
[    1.662124] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0000000-0xe000ffff=
 64bit]
[    1.662135] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.662142] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00fffff]
[    1.662151] pci 0000:02:00.0: BAR 0: assigned [mem 0xe0200000-0xe03fffff=
 64bit]
[    1.662158] pci 0000:02:00.0: BAR 0: error updating (0xe0200004 !=3D 0xf=
fffffff)
[    1.662164] pci 0000:02:00.0: BAR 0: error updating (high 0x000000 !=3D =
0xffffffff)
[    1.662170] pci 0000:02:00.0: BAR 6: assigned [mem 0xe0400000-0xe040ffff=
 pref]
[    1.662176] pci 0000:00:02.0: PCI bridge to [bus 02]
[    1.662182] pci 0000:00:02.0:   bridge window [mem 0xe0200000-0xe04fffff]
[    1.662190] pci 0000:03:00.0: BAR 0: assigned [mem 0xe0600000-0xe06fffff=
 64bit]
[    1.662202] pci 0000:03:00.0: BAR 6: assigned [mem 0xe0700000-0xe070ffff=
 pref]
[    1.662207] pci 0000:00:03.0: PCI bridge to [bus 03]
[    1.662212] pci 0000:00:03.0:   bridge window [mem 0xe0600000-0xe07fffff]


This has me somewhat puzzled. Investigating further, it turns out that
if I *remove* the MT76 card, the WLE200 starts failing again. So with
just the WLE* cards plugged in, I went back and tried the setpci
sequence again with the WLE200 (with PCIEASPM disabled):

# ROOT=3D00:01.0
# NIC=3D01:00.0
# setpci -s$ROOT CAP_EXP+0xc.l
0003ac12
# setpci -s$ROOT CAP_EXP+0x10.w
0040
# setpci -s$ROOT CAP_EXP+0x12.w
1011
# setpci -s$NIC CAP_EXP+0xc.l
00033c11
# setpci -s$NIC CAP_EXP+0x10.w
0000
# setpci -s$NIC CAP_EXP+0x12.w
1011
# setpci -s$ROOT CAP_EXP+0x10.w=3D0x0020
# sleep 1
# setpci -s$ROOT CAP_EXP+0x12.w
1011
# setpci -s$NIC CAP_EXP+0x12.w
1011
# setpci -s$NIC CAP_EXP+0x10.w=3D0x0040
# setpci -s$ROOT CAP_EXP+0x10.w=3D0x0040
# setpci -s$ROOT CAP_EXP+0x10.w=3D0x0060
# sleep 1
# setpci -s$ROOT CAP_EXP+0x12.w
1011
# setpci -s$NIC CAP_EXP+0x12.w
1011

-Toke

