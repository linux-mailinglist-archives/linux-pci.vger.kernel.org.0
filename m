Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D276C38B8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 18:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCUR4y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 13:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCUR4Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 13:56:24 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9D3515FD
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 10:56:09 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id l16so8639933ybe.6
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112; t=1679421369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5R0FXl4M7xSgPJvS5SVA0w188wiPw+2OaAN+S9F4Zg=;
        b=j4qpOAxUUPGqUs7B0WbBr7FnAW0LQ+ak+rlpU1PaxtRKsOQ8VZWsOJA10OS1+nrXrI
         64t+FOiKLl0lpzjUoX5FpROAm974j1tJTVTA3r4/U/XREClEUy4srqmCUwfOw8ffWZFL
         0bLcb/fDlMD4mj7QUKGnHFQEry6x53EsyHlJwG1BS9uAkdytzF5fGtDPNwYIny/18xj9
         wpkXAuxcogfpTK3nKjSePe/3VxSH0FQtq9HUHvFrB3JIQf6vpRy5z5mm78OxKKPoJpq5
         7i/OGfguOOptstHUwHjSnuKsWcBKHOUAySM3xV9xk9PDtM7e6s+eiN1/elydII9cyGx+
         k0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679421369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5R0FXl4M7xSgPJvS5SVA0w188wiPw+2OaAN+S9F4Zg=;
        b=etTQ7sg13aqWF1EulfQBGJFzNJcPmqOrpwHwEo0jsB4d9riiuGL5BZDwCoSN0uRA++
         GD57ei1kmPjIpibK5WKHyea7sy8P0QMaVoWb52fFBQsxQ/R6GoU/hXnG+NDvIJ4IrtJE
         4+qLTt6wlsWGIL3ef4SkIqHZwD3x0Nk1ZRKc+5tVWPvvbMoGXR1+o3RvLMJDmuQPiR+z
         1j7ipDsHjecyYzdQY0FY7F+3ZHxHOwmfEZom/d7EEg6KJSQ2w658uQo7Lhalln8O4wR2
         spWNzaxQBVQCSCV+PsPtUXVcFAD8cpWaDL4Y7fie9waoIZY8w7Eum+EYXDQUni1eqdxS
         9voA==
X-Gm-Message-State: AAQBX9c2/W5bcMvAo+nHovUtVMlj7nrqw6uSey3eR7a0DoROxTxvatTq
        BuFpLOxQF07FEtTyuHK0tdoYiDEkFuKQQooPDXKa5A==
X-Google-Smtp-Source: AKy350adqiQ42DSQXEMg4x9EKLnHXO2ZwT210bYkp3eJe8I8NL4TM7GJ2BvitOUARQZ/TnV7smmoZMbyQNRJcEQuOzs=
X-Received: by 2002:a05:6902:1545:b0:af6:9419:60bc with SMTP id
 r5-20020a056902154500b00af6941960bcmr2314122ybu.0.1679421368616; Tue, 21 Mar
 2023 10:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU0TuNA26F+hFwTRGc2pVvW34-7Sc7oQ9EW8V+2cVFgcag@mail.gmail.com>
 <CAD8Lp44c1k-xP1U9X8PR_kw=8joMY8RUwcKVBvuWaV7faNhWZg@mail.gmail.com> <CAJ+vNU2S6L8wFj-uFOhZOn7gpriq9rGpGV6nfJL9AL+SaAeMkg@mail.gmail.com>
In-Reply-To: <CAJ+vNU2S6L8wFj-uFOhZOn7gpriq9rGpGV6nfJL9AL+SaAeMkg@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 21 Mar 2023 10:55:56 -0700
Message-ID: <CAJ+vNU2RqM_++mE8FL_Kh=0hWHwjZq1EFfOft4Xr9vD3sMfaHA@mail.gmail.com>
Subject: Re: ath9k legacy vs MSI interrupt issue on imx8mm soc
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        rhu@qti.qualcomm.com, ryanhsu@qti.qualcomm.com,
        rwchang@qti.qualcomm.com, aeolus@qti.qualcomm.com,
        "Valo, Kalle" <kvalo@qca.qualcomm.com>,
        ath9k-devel <ath9k-devel@qca.qualcomm.com>, linux@endlessm.com,
        rafael.j.wysocki@intel.com, andy@infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Daniel Drake <drake@endlessos.org>, linux-pci@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 20, 2023 at 1:46=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> (+linux-pci, Fabio, Richard)
>
> Daniel,
>
> I may have two different issues going on here:
> 1) issues with ath9k MSI interrupts
> 2) issues with ath9k legacy interrupts on IMX8MM

Lucas,

I've found an old thread [1] where you state that Designware PCIe core
(not just IMX6) has an issue where as soon as any MSI interrupt is
enabled the core does not forward legacy IRQs anymore so if any card
in your system needs legacy interrupts you must disable MSI
completely.

I assume this is still the understanding and also applies then to
IMX8MM/IMX8MP? This would explain why I'm unable to get legacy
interrupts working without pci=3Dnomsi as the PME driver requests an MSI
interrupt.

Do you know any reason why I can get legacy IRQ's to work with
pci=3Dnomsi on IMX6Q/DL with and without a bridge but on IMX8MM I can
only get it to work without a bridge?

Best Regards,

Tim
[1] https://patchwork.kernel.org/project/linux-pci/patch/20181120165626.264=
24-2-stefan@agner.ch/#22345435

>
> To rule out the PCIe switch being an issue for me I moved to an
> imx8mm-venice-gw71xx-0x which has an IMX8MM and no PCIe switch.
>
> I've found that with MSI enabled globally, but ath9k not using MSI I
> fail to get any interrupts from the radio with nothing abnormal from
> dmesg:
> # uname -r
> 6.2.0-09243-ge911eb7b8ec1
> # cat /proc/cmdline
>
> # lspci -n
> 00:00.0 0604: 16c3:abcd (rev 01)
> 01:00.0 0280: 168c:0036 (rev 01)
> # dmesg | grep pci
> [    1.524560] imx6q-pcie 33800000.pcie: host bridge
> /soc@0/pcie@33800000 ranges:
> [    1.531870] imx6q-pcie 33800000.pcie:       IO
> 0x001ff80000..0x001ff8ffff -> 0x0000000000
> [    1.544109] imx6q-pcie 33800000.pcie:      MEM
> 0x0018000000..0x001fefffff -> 0x0018000000
> [    1.767610] imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib,
> align 64K, limit 4G
> [    1.875571] imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> [    1.881241] imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> [    1.886843] imx6q-pcie 33800000.pcie: Link up, Gen1
> [    1.891746] imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> [    1.897674] imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
> [    1.904078] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    1.909585] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    1.915784] pci_bus 0000:00: root bus resource [mem 0x18000000-0x1feff=
fff]
> [    1.922706] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> [    1.928746] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> [    1.935043] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pre=
f]
> [    1.941820] pci 0000:00:00.0: supports D1
> [    1.945849] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> [    1.954254] pci 0000:01:00.0: [168c:0036] type 00 class 0x028000
> [    1.960394] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0007ffff 64b=
it]
> [    1.967342] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pre=
f]
> [    1.974389] pci 0000:01:00.0: supports D1 D2
> [    1.978681] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3col=
d
> [    1.995483] pci 0000:00:00.0: BAR 0: assigned [mem 0x18000000-0x180fff=
ff]
> [    2.002334] pci 0000:00:00.0: BAR 14: assigned [mem 0x18100000-0x181ff=
fff]
> [    2.009240] pci 0000:00:00.0: BAR 15: assigned [mem
> 0x18200000-0x182fffff pref]
> [    2.016576] pci 0000:00:00.0: BAR 6: assigned [mem
> 0x18300000-0x1830ffff pref]
> [    2.023833] pci 0000:01:00.0: BAR 0: assigned [mem
> 0x18100000-0x1817ffff 64bit]
> [    2.031214] pci 0000:01:00.0: BAR 6: assigned [mem
> 0x18200000-0x1820ffff pref]
> [    2.038462] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    2.043711] pci 0000:00:00.0:   bridge window [mem 0x18100000-0x181fff=
ff]
> [    2.050518] pci 0000:00:00.0:   bridge window [mem
> 0x18200000-0x182fffff pref]
> [    2.058205] pcieport 0000:00:00.0: PME: Signaling with IRQ 205
> # dmesg | grep ath
> [    2.064379] ath9k 0000:01:00.0: enabling device (0000 -> 0002)
> [    2.070445] ath: phy0: WB335 2-ANT card detected
> [    2.075092] ath: phy0: Set BT/WLAN RX diversity capability
> [    2.088891] ath: phy0: Enable LNA combining
> [    2.094278] ath: EEPROM regdomain: 0x6a
> [    2.094285] ath: EEPROM indicates we should expect a direct regpair ma=
p
> [    2.094293] ath: Country alpha2 being used: 00
> [    2.094297] ath: Regpair used: 0x6a
> [   14.228284] ath9k 0000:01:00.0 wlp1s0: renamed from wlan0
> # wpa_supplicant -i wlp1s0 -c wpa_supplicant.conf
> Successfully initialized wpa_supplicant
> <snip authentication details>
> # grep ath /proc/interrupts
> 204:          0          0          0          0     GICv3 157 Level     =
ath9k
> # cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>  11:       2196       1753       1883       3509     GICv3  30 Level
>   arch_timer
>  14:          0          0          0          0     GICv3  79 Level
>   timer@306a0000
>  15:          0          0          0          0     GICv3  23 Level     =
arm-pmu
>  16:          0          0          0          0     GICv3 135 Level
>   302c0000.dma-controller
>  17:          0          0          0          0     GICv3  66 Level
>   302b0000.dma-controller
>  18:          0          0          0          0     GICv3  34 Level
>   30bd0000.dma-controller
>  19:          0          0          0          0     GICv3  58 Level
>   30860000.serial
>  20:          0          0          0          0     GICv3  60 Level
>   30880000.serial
>  21:        503          0          0          0     GICv3  59 Level
>   30890000.serial
>  22:          0          0          0          0     GICv3 110 Level
>   30280000.watchdog
>  23:        418          0          0          0     GICv3  56 Level     =
mmc2
>  41:          0          0          0          0  gpio-mxc  15 Edge      =
pps.-1
>  66:          0          0          0          0  gpio-mxc   6 Level
>   gateworks-gsc
> 194:        750          0          0          0     GICv3  67 Level
>   30a20000.i2c
> 195:          0          0          0          0  gateworks-gsc   4
> Edge      0-0023
> 196:         25          0          0          0     GICv3  68 Level
>   30a30000.i2c
> 197:          0          0          0          0     GICv3  69 Level
>   30a40000.i2c
> 198:          0          0          0          0     GICv3  64 Level
>   30830000.spi
> 199:          0          0          0          0     GICv3 150 Level
>   30be0000.ethernet
> 200:          0          0          0          0     GICv3 151 Level
>   30be0000.ethernet
> 201:          0          0          0          0     GICv3 152 Level
>   30be0000.ethernet
> 202:          0          0          0          0     GICv3 153 Level
>   30be0000.ethernet
> 204:          0          0          0          0     GICv3 157 Level     =
ath9k
> 205:          0          0          0          0   PCI-MSI   0 Edge
>   PCIe PME
> 206:          0          0          0          0     GICv3  72 Level
>   32e40000.usb
> 207:         18          0          0          0     GICv3  73 Level
>   32e50000.usb
> 208:          0          0          0          0  gateworks-gsc   0
> Edge      user_pb1x
> 209:          0          0          0          0  gateworks-gsc   1
> Edge      key_erased
> 210:          0          0          0          0  gateworks-gsc   2
> Edge      eeprom_wp
> 211:          0          0          0          0  gateworks-gsc   5
> Edge      tamper
> 212:          0          0          0          0  gateworks-gsc   7
> Edge      switch_hold
> 213:          0          0          0          0 0-0023   2 Edge      use=
r_pb
> IPI0:       620        751        665        109       Rescheduling inter=
rupts
> IPI1:       361       1387       1285        509       Function call inte=
rrupts
> IPI2:         0          0          0          0       CPU stop interrupt=
s
> IPI3:         0          0          0          0       CPU stop (for
> crash dump) interrupts
> IPI4:         0          0          0          0       Timer broadcast
> interrupts
> IPI5:         5          9         10          2       IRQ work interrupt=
s
> IPI6:         0          0          0          0       CPU wake-up interr=
upts
> Err:          0
> ^^^ no interrupts from ath9k radio
> ^^^ is MSI enabled for the controller but ath9k electing to use legacy
> INT's a valid configuration?
>
> With MSI disabled globally via pci=3Dnomsi ath9k gets interrupts and work=
s fine:
> # cat /proc/cmdline
> pci=3Dnomsi
> # dmesg | grep ath
> [    2.052527] ath9k 0000:01:00.0: enabling device (0000 -> 0002)
> [    2.058556] ath: phy0: WB335 2-ANT card detected
> [    2.063199] ath: phy0: Set BT/WLAN RX diversity capability
> [    2.077381] ath: phy0: Enable LNA combining
> [    2.082799] ath: EEPROM regdomain: 0x6a
> [    2.082805] ath: EEPROM indicates we should expect a direct regpair ma=
p
> [    2.082813] ath: Country alpha2 being used: 00
> [    2.082818] ath: Regpair used: 0x6a
> [   11.620093] ath9k 0000:01:00.0 wlp1s0: renamed from wlan0
> # wpa_supplicant -i wlp1s0 -c wpa_supplicant.conf
> Successfully initialized wpa_supplicant
> <snip authentication details>
> #
> # grep ath /proc/interrupts
> 203:        379          0          0          0     GICv3 157 Level
>   PCIe PME, ath9k
> # cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>  11:       1622       2152       3288       2005     GICv3  30 Level
>   arch_timer
>  14:          0          0          0          0     GICv3  79 Level
>   timer@306a0000
>  15:          0          0          0          0     GICv3  23 Level     =
arm-pmu
>  16:          0          0          0          0     GICv3 135 Level
>   302c0000.dma-controller
>  17:          0          0          0          0     GICv3  66 Level
>   302b0000.dma-controller
>  18:          0          0          0          0     GICv3  34 Level
>   30bd0000.dma-controller
>  19:          0          0          0          0     GICv3  58 Level
>   30860000.serial
>  20:          0          0          0          0     GICv3  60 Level
>   30880000.serial
>  21:        597          0          0          0     GICv3  59 Level
>   30890000.serial
>  22:          0          0          0          0     GICv3 110 Level
>   30280000.watchdog
>  23:        414          0          0          0     GICv3  56 Level     =
mmc2
>  41:          0          0          0          0  gpio-mxc  15 Edge      =
pps.-1
>  66:          0          0          0          0  gpio-mxc   6 Level
>   gateworks-gsc
> 194:        978          0          0          0     GICv3  67 Level
>   30a20000.i2c
> 195:          0          0          0          0  gateworks-gsc   4
> Edge      0-0023
> 196:         25          0          0          0     GICv3  68 Level
>   30a30000.i2c
> 197:          0          0          0          0     GICv3  69 Level
>   30a40000.i2c
> 198:          0          0          0          0     GICv3  64 Level
>   30830000.spi
> 199:          0          0          0          0     GICv3 150 Level
>   30be0000.ethernet
> 200:          0          0          0          0     GICv3 151 Level
>   30be0000.ethernet
> 201:          0          0          0          0     GICv3 152 Level
>   30be0000.ethernet
> 202:          0          0          0          0     GICv3 153 Level
>   30be0000.ethernet
> 203:        379          0          0          0     GICv3 157 Level
>   PCIe PME, ath9k
> 204:          0          0          0          0     GICv3  72 Level
>   32e40000.usb
> 205:         18          0          0          0     GICv3  73 Level
>   32e50000.usb
> 206:          0          0          0          0  gateworks-gsc   0
> Edge      user_pb1x
> 207:          0          0          0          0  gateworks-gsc   1
> Edge      key_erased
> 208:          0          0          0          0  gateworks-gsc   2
> Edge      eeprom_wp
> 209:          0          0          0          0  gateworks-gsc   5
> Edge      tamper
> 210:          0          0          0          0  gateworks-gsc   7
> Edge      switch_hold
> 211:          0          0          0          0 0-0023   2 Edge      use=
r_pb
> IPI0:       501        506         73        759       Rescheduling inter=
rupts
> IPI1:       878        846        718       1169       Function call inte=
rrupts
> IPI2:         0          0          0          0       CPU stop interrupt=
s
> IPI3:         0          0          0          0       CPU stop (for
> crash dump) interrupts
> IPI4:         0          0          0          0       Timer broadcast
> interrupts
> IPI5:         5          4          9         20       IRQ work interrupt=
s
> IPI6:         0          0          0          0       CPU wake-up interr=
upts
> Err:          0
> ^^^ legacy interrupts working as long as I disable MSI globally for IMX8M=
M
>
> And with MSI enabled globally as well as ath9k (ath9k.use_msi=3D1) ath9k
> fails to get interrupts and shows the interrupt error I ran into
> previously:
> # cat /proc/cmdline
> ath9k.use_msi=3D1
> # dmesg | grep ath
> [    0.000000] Kernel command line: ath9k.use_msi=3D1
> [    2.056381] ath9k 0000:01:00.0: enabling device (0000 -> 0002)
> [    2.062571] ath9k 0000:01:00.0: Using MSI
> [    2.066651] ath: phy0: WB335 2-ANT card detected
> [    2.071288] ath: phy0: Set BT/WLAN RX diversity capability
> [    2.085083] ath: phy0: Enable LNA combining
> [    2.090470] ath: EEPROM regdomain: 0x6a
> [    2.090476] ath: EEPROM indicates we should expect a direct regpair ma=
p
> [    2.090484] ath: Country alpha2 being used: 00
> [    2.090489] ath: Regpair used: 0x6a
> [   13.999159] ath9k 0000:01:00.0 wlp1s0: renamed from wlan0
> # wpa_supplicant -i wlp1s0 -c wpa_supplicant.conf
> Successfully initialized wpa_supplicant
> [   66.790178] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0x6A=
0C9C8
> [   66.798000] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0x6A=
0C9C8
> [   66.811551] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0x6A=
0C9C8
> [   66.937204] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0x6A=
0C9C8
> [   66.950679] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0x6A=
0C9C8
> [   67.020994] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA=
0C9C8
> [   67.092917] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA=
0C9C8
> [   67.164905] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA=
0C9C8
> [   67.236957] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA=
0C9C8
> [   67.308928] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA=
0C9C8
> [   67.380902] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA=
0C9C8
> [   67.452954] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA=
0C9C8
> [   67.524881] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA=
0C9C8
> [   67.596917] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA=
0C9C8
> [   67.668907] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA=
0C9C8
> [   67.740908] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA=
0C9C8
> [   67.860948] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA=
0C9C8
> ...
> <snip authentication details>
> # grep ath /proc/interrupts
> 206:          0          0          0          0   PCI-MSI 524288 Edge
>      ath9k
> # cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>  11:       1421       3067       1999       2767     GICv3  30 Level
>   arch_timer
>  14:          0          0          0          0     GICv3  79 Level
>   timer@306a0000
>  15:          0          0          0          0     GICv3  23 Level     =
arm-pmu
>  16:          0          0          0          0     GICv3 135 Level
>   302c0000.dma-controller
>  17:          0          0          0          0     GICv3  66 Level
>   302b0000.dma-controller
>  18:          0          0          0          0     GICv3  34 Level
>   30bd0000.dma-controller
>  19:          0          0          0          0     GICv3  58 Level
>   30860000.serial
>  20:          0          0          0          0     GICv3  60 Level
>   30880000.serial
>  21:        289          0          0          0     GICv3  59 Level
>   30890000.serial
>  22:          0          0          0          0     GICv3 110 Level
>   30280000.watchdog
>  23:        390          0          0          0     GICv3  56 Level     =
mmc2
>  41:          0          0          0          0  gpio-mxc  15 Edge      =
pps.-1
>  66:          0          0          0          0  gpio-mxc   6 Level
>   gateworks-gsc
> 194:       1054          0          0          0     GICv3  67 Level
>   30a20000.i2c
> 195:          0          0          0          0  gateworks-gsc   4
> Edge      0-0023
> 196:         25          0          0          0     GICv3  68 Level
>   30a30000.i2c
> 197:          0          0          0          0     GICv3  69 Level
>   30a40000.i2c
> 198:          0          0          0          0     GICv3  64 Level
>   30830000.spi
> 199:          0          0          0          0     GICv3 150 Level
>   30be0000.ethernet
> 200:          0          0          0          0     GICv3 151 Level
>   30be0000.ethernet
> 201:          0          0          0          0     GICv3 152 Level
>   30be0000.ethernet
> 202:          0          0          0          0     GICv3 153 Level
>   30be0000.ethernet
> 205:       6891          0          0          0   PCI-MSI   0 Edge
>   PCIe PME
> 206:          0          0          0          0   PCI-MSI 524288 Edge
>      ath9k
> 207:          0          0          0          0     GICv3  72 Level
>   32e40000.usb
> 208:         18          0          0          0     GICv3  73 Level
>   32e50000.usb
> 209:          0          0          0          0  gateworks-gsc   0
> Edge      user_pb1x
> 210:          0          0          0          0  gateworks-gsc   1
> Edge      key_erased
> 211:          0          0          0          0  gateworks-gsc   2
> Edge      eeprom_wp
> 212:          0          0          0          0  gateworks-gsc   5
> Edge      tamper
> 213:          0          0          0          0  gateworks-gsc   7
> Edge      switch_hold
> 214:          0          0          0          0 0-0023   2 Edge      use=
r_pb
> IPI0:       646         64        692        808       Rescheduling inter=
rupts
> IPI1:      1211        893        503       1097       Function call inte=
rrupts
> IPI2:         0          0          0          0       CPU stop interrupt=
s
> IPI3:         0          0          0          0       CPU stop (for
> crash dump) interrupts
> IPI4:         0          0          0          0       Timer broadcast
> interrupts
> IPI5:         9         13         12          8       IRQ work interrupt=
s
> IPI6:         0          0          0          0       CPU wake-up interr=
upts
> Err:          0
> ^^^ It looks to me like when using MSI above the interrupts are going
> to the PME driver MSI 0 and the ath9k MSI interrupt shows as 524288
> which aligns to 4 but seems strange that its so large.
>
> Does this jive with what you encountered?
>
> Note that ath10k which require MSI interrupts are working fine on this
> platform and the MSI interrupt is also 524288:
> 205:          0          0          0          0   PCI-MSI   0 Edge
>   PCIe PME
> 206:        632          0          0          0   PCI-MSI 524288 Edge
>      ath10k_pci
>
> Note that ath11k which requires MSI interrupts is also working fine on
> this board:
> 205:          0          0          0          0   PCI-MSI   0 Edge
>   PCIe PME
> 206:          4          0          0          0   PCI-MSI 524288 Edge   =
   bhi
> 207:          4          0          0          0   PCI-MSI 524289 Edge   =
   mhi
> 208:         39          0          0          0   PCI-MSI 524290 Edge   =
   mhi
> 209:          3          0          0          0   PCI-MSI 524291 Edge   =
   ce0
> 210:         26          0          0          1   PCI-MSI 524292 Edge   =
   ce1
> 211:        267          0          0          1   PCI-MSI 524293 Edge   =
   ce2
> 212:         88          0          0          0   PCI-MSI 524294 Edge   =
   ce3
> 213:          0          0          0          1   PCI-MSI 524295 Edge   =
   ce5
> 214:          2          0          0          0   PCI-MSI 524296 Edge
>      DP_EXT_IRQ
> 215:          0          0          0          0   PCI-MSI 524297 Edge
>      DP_EXT_IRQ
> 216:          0          0          0          0   PCI-MSI 524298 Edge
>      DP_EXT_IRQ
> 217:         15          0          0          0   PCI-MSI 524299 Edge
>      DP_EXT_IRQ
> 218:          0          0          0          0   PCI-MSI 524300 Edge
>      DP_EXT_IRQ
> 219:          2          0          0          0   PCI-MSI 524301 Edge
>      DP_EXT_IRQ
> 220:          0          0          0          0   PCI-MSI 524302 Edge
>      DP_EXT_IRQ
> 221:          0          0          0          0   PCI-MSI 524303 Edge
>      DP_EXT_IRQ
>
> Now, if I move back to an imx8mm-venice-gw73xx-0x which has an IMX8MM
> and a PCI bridge I can't even get the legacy IRQ configuration to work
> (no interrupts):
> # cat /proc/cmdline
> pci=3Dnomsi
> # lspci
> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> 01:00.0 PCI bridge: Pericom Semiconductor Device b404 (rev 01)
> 02:01.0 PCI bridge: Pericom Semiconductor Device b404 (rev 01)
> 02:02.0 PCI bridge: Pericom Semiconductor Device b404 (rev 01)
> 02:03.0 PCI bridge: Pericom Semiconductor Device b404 (rev 01)
> 04:00.0 Network controller: Qualcomm Atheros QCA9565 / AR9565 Wireless
> Network Adapter (rev 01)
> 05:00.0 Ethernet controller: Microchip Technology / SMSC Device 7430 (rev=
 11)
> # dmesg | grep ath
> [    2.475134] ath9k 0000:04:00.0: enabling device (0000 -> 0002)
> [    2.481157] ath: phy0: WB335 2-ANT card detected
> [    2.485797] ath: phy0: Set BT/WLAN RX diversity capability
> [    2.499443] ath: phy0: Enable LNA combining
> [    2.504837] ath: EEPROM regdomain: 0x6a
> [    2.504845] ath: EEPROM indicates we should expect a direct regpair ma=
p
> [    2.504853] ath: Country alpha2 being used: 00
> [    2.504858] ath: Regpair used: 0x6a
> [   10.237297] ath9k 0000:04:00.0 wlp4s0: renamed from wlan0
> # wpa_supplicant -i wlp4s0 -c wpa_supplicant.conf
> <snip failed auth>
> # grep -i pci /proc/interrupts
> 204:          0          0          0          0     GICv3 157 Level
>   PCIe PME, ath9k
> # cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>  11:       1550       3047       2199       4301     GICv3  30 Level
>   arch_timer
>  14:          0          0          0          0     GICv3  79 Level
>   timer@306a0000
>  15:          0          0          0          0     GICv3  23 Level     =
arm-pmu
>  16:          0          0          0          0     GICv3 135 Level
>   302c0000.dma-controller
>  17:          0          0          0          0     GICv3  66 Level
>   302b0000.dma-controller
>  18:        332          0          0          0     GICv3  34 Level
>   30bd0000.dma-controller
>  19:          0          0          0          0     GICv3  58 Level
>   30860000.serial
>  20:        773          0          0          0     GICv3  59 Level
>   30890000.serial
>  21:          0          0          0          0     GICv3  61 Level
>   30a60000.serial
>  22:          0          0          0          0     GICv3 110 Level
>   30280000.watchdog
>  23:        433          0          0          0     GICv3  56 Level     =
mmc2
>  41:          0          0          0          0  gpio-mxc  15 Edge      =
pps.-1
>  66:          0          0          0          0  gpio-mxc   6 Level
>   gateworks-gsc
>  72:          0          0          0          0  gpio-mxc  12 Edge
>   30b50000.mmc cd
> 170:          4          0          0          0  gpio-mxc   8 Edge
>   30880000.serial
> 194:       1282          0          0          0     GICv3  67 Level
>   30a20000.i2c
> 195:          0          0          0          0  gateworks-gsc   4
> Edge      0-0023
> 196:         25          0          0          0     GICv3  68 Level
>   30a30000.i2c
> 197:          0          0          0          0     GICv3  69 Level
>   30a40000.i2c
> 198:          0          0          0          0     GICv3  60 Level
>   30880000.serial
> 199:          0          0          0          0     GICv3  64 Level
>   30830000.spi
> 200:          0          0          0          0     GICv3 150 Level
>   30be0000.ethernet
> 201:          0          0          0          0     GICv3 151 Level
>   30be0000.ethernet
> 202:          0          0          0          0     GICv3 152 Level
>   30be0000.ethernet
> 203:          0          0          0          0     GICv3 153 Level
>   30be0000.ethernet
> 204:          0          0          0          0     GICv3 157 Level
>   PCIe PME, ath9k
> 205:          0          0          0          0     GICv3  72 Level
>   32e40000.usb
> 206:        105          0          0          0     GICv3  73 Level
>   32e50000.usb
> 207:       6244          0          0          0     GICv3  54 Level     =
mmc0
> 208:          0          0          0          0     GICv3  55 Level     =
mmc1
> 209:          0          0          0          0  gateworks-gsc   0
> Edge      user_pb1x
> 210:          0          0          0          0  gateworks-gsc   1
> Edge      key_erased
> 211:          0          0          0          0  gateworks-gsc   2
> Edge      eeprom_wp
> 212:          0          0          0          0  gateworks-gsc   5
> Edge      tamper
> 213:          0          0          0          0  gateworks-gsc   7
> Edge      switch_hold
> 214:          0          0          0          0 0-0023   2 Edge      use=
r_pb
> IPI0:       367        486        444        286       Rescheduling inter=
rupts
> IPI1:       972       1283       1202       1630       Function call inte=
rrupts
> IPI2:         0          0          0          0       CPU stop interrupt=
s
> IPI3:         0          0          0          0       CPU stop (for
> crash dump) interrupts
> IPI4:         0          0          0          0       Timer broadcast
> interrupts
> IPI5:         5          6          7         36       IRQ work interrupt=
s
> IPI6:         0          0          0          0       CPU wake-up interr=
upts
> Err:          0
> ^^^ why no interrupts on this board when disabling MSI globally and
> using ath9k legacy interrupts.... something to do with the bridge?
>
> Best Regards,
>
> Tim
>
>
>
> On Mon, Mar 20, 2023 at 4:29=E2=80=AFAM Daniel Drake <drake@endlessos.org=
> wrote:
> >
> > On Sat, Mar 18, 2023 at 8:17=E2=80=AFAM Tim Harvey <tharvey@gateworks.c=
om> wrote:
> > > It seems that Daniel may have been running into something similar bac=
k
> > > when commit 7368160f0ab0 ("ath9k: add MSI support") was merged
> > > [1][2][3]
> > >
> > > Does anyone have any advice here about what can be going on?
> >
> > The issue we found earlier was that ath9k MSI is broken unless the MSI
> > IRQ number coincidentally is aligned to 4.
> >
> > Worked around with:
> > https://github.com/endlessm/linux/commit/0a2d86a2b9da8f936d873addf0a97e=
341177fe8a
> > https://github.com/endlessm/linux/commit/970d2b4b59465cd926e5213e0feb63=
3f6b623447
> >
> > IIRC the PCI patch wasn't accepted upstream at the time and I never
> > got any response from Atheros/Qualcomm about this device
> > hardware/firmware bug.
> >
> > Daniel
