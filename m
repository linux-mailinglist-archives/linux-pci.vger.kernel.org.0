Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C3E6C231B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 21:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCTUql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 16:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjCTUqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 16:46:39 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA94B399E8
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 13:46:24 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54184571389so246043777b3.4
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 13:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112; t=1679345183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvHha9wSD1fQqYC3lzPkLUdi1kxXg/U4D34GpYJTOw4=;
        b=GFVSGrieeWz6Ho6yjG5W4fXgbzcpi7VNgVmVYBkUYXvjAVshDdyEz46iFkfBn7bRB7
         ZdLcLpHZmNfQz8UivzGzhFwykZ2yVvLjPUbRD2J4wySd0kYICGYZrgeZJdM7rpQNGPAN
         ZR8tBu4iYFBXWuUOzVidDecVLKNFitcdh1H68t61lITT60RSgGJuyv2mDPQ9xNOhJOlJ
         OvwQJA16oa8ltPRW14kZGES3rH/UdkRGvBr4B47ho/BC3Mjgsaa20jJzT3CkoX5EV2ot
         aT39uY3B4FbsJMkgLfERcqvUgVHlymdii3S/qga66aeDdrN9Jh9cU80yzyv21hkF58JX
         j0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679345183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvHha9wSD1fQqYC3lzPkLUdi1kxXg/U4D34GpYJTOw4=;
        b=WRJFvOjEW/7vSTIveU1tap1xbR1LlAajwILFIzDF5a/TqpP/1c+qFcDd8sC2Iac8uo
         +gfOAdkeBNzWBhWH445anZA2+kXcu6myKyfFeuwcQ4YE4h89WHbhDUTqLlp/9IOgsI2v
         utOYLjg/2bhnH0EujFYpEEPulfSyagR3UgBDsOE6NA4w+NILfnbkWBJc/L1lP799Anty
         jCRCvxceqcha/mv+1z/s18D/UILROSFLC3wxId7SBpApLhTzyMdqYo01ZnimV1Tb4ZIl
         gIK819MErDC85VGVQSkaUyaQOtv1Y2v4ua6bfoDYrPLaXfac5Y1jHAk9/SkoIZb2wYsv
         t1ag==
X-Gm-Message-State: AO0yUKViXn1YXziRN2iwrhfppXCDmHmrv268lOnann3UopnCYWU4UCDT
        SnFX4lEZe17Q5cF8WA2yjtkhO5YJ4R7TmRfJ54x6lg==
X-Google-Smtp-Source: AK7set9JGEDkY6BDS/NQvGLvkJ430CNENf4ntJ/lwEne0WK+mgXq3NihcF+5WhM0Wvp6ZpMJpqMTDtZQQ9977n9Rziw=
X-Received: by 2002:a81:aa0c:0:b0:530:b21f:d604 with SMTP id
 i12-20020a81aa0c000000b00530b21fd604mr10448638ywh.9.1679345183383; Mon, 20
 Mar 2023 13:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU0TuNA26F+hFwTRGc2pVvW34-7Sc7oQ9EW8V+2cVFgcag@mail.gmail.com>
 <CAD8Lp44c1k-xP1U9X8PR_kw=8joMY8RUwcKVBvuWaV7faNhWZg@mail.gmail.com>
In-Reply-To: <CAD8Lp44c1k-xP1U9X8PR_kw=8joMY8RUwcKVBvuWaV7faNhWZg@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 20 Mar 2023 13:46:11 -0700
Message-ID: <CAJ+vNU2S6L8wFj-uFOhZOn7gpriq9rGpGV6nfJL9AL+SaAeMkg@mail.gmail.com>
Subject: Re: ath9k legacy vs MSI interrupt issue on imx8mm soc
To:     Daniel Drake <drake@endlessos.org>,
        Fabio Estevam <festevam@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        rhu@qti.qualcomm.com, ryanhsu@qti.qualcomm.com,
        rwchang@qti.qualcomm.com, aeolus@qti.qualcomm.com,
        "Valo, Kalle" <kvalo@qca.qualcomm.com>,
        ath9k-devel <ath9k-devel@qca.qualcomm.com>, linux@endlessm.com,
        rafael.j.wysocki@intel.com, andy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

(+linux-pci, Fabio, Richard)

Daniel,

I may have two different issues going on here:
1) issues with ath9k MSI interrupts
2) issues with ath9k legacy interrupts on IMX8MM

To rule out the PCIe switch being an issue for me I moved to an
imx8mm-venice-gw71xx-0x which has an IMX8MM and no PCIe switch.

I've found that with MSI enabled globally, but ath9k not using MSI I
fail to get any interrupts from the radio with nothing abnormal from
dmesg:
# uname -r
6.2.0-09243-ge911eb7b8ec1
# cat /proc/cmdline

# lspci -n
00:00.0 0604: 16c3:abcd (rev 01)
01:00.0 0280: 168c:0036 (rev 01)
# dmesg | grep pci
[    1.524560] imx6q-pcie 33800000.pcie: host bridge
/soc@0/pcie@33800000 ranges:
[    1.531870] imx6q-pcie 33800000.pcie:       IO
0x001ff80000..0x001ff8ffff -> 0x0000000000
[    1.544109] imx6q-pcie 33800000.pcie:      MEM
0x0018000000..0x001fefffff -> 0x0018000000
[    1.767610] imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib,
align 64K, limit 4G
[    1.875571] imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
[    1.881241] imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
[    1.886843] imx6q-pcie 33800000.pcie: Link up, Gen1
[    1.891746] imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
[    1.897674] imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
[    1.904078] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.909585] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    1.915784] pci_bus 0000:00: root bus resource [mem 0x18000000-0x1feffff=
f]
[    1.922706] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    1.928746] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    1.935043] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    1.941820] pci 0000:00:00.0: supports D1
[    1.945849] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    1.954254] pci 0000:01:00.0: [168c:0036] type 00 class 0x028000
[    1.960394] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0007ffff 64bit=
]
[    1.967342] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    1.974389] pci 0000:01:00.0: supports D1 D2
[    1.978681] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.995483] pci 0000:00:00.0: BAR 0: assigned [mem 0x18000000-0x180fffff=
]
[    2.002334] pci 0000:00:00.0: BAR 14: assigned [mem 0x18100000-0x181ffff=
f]
[    2.009240] pci 0000:00:00.0: BAR 15: assigned [mem
0x18200000-0x182fffff pref]
[    2.016576] pci 0000:00:00.0: BAR 6: assigned [mem
0x18300000-0x1830ffff pref]
[    2.023833] pci 0000:01:00.0: BAR 0: assigned [mem
0x18100000-0x1817ffff 64bit]
[    2.031214] pci 0000:01:00.0: BAR 6: assigned [mem
0x18200000-0x1820ffff pref]
[    2.038462] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    2.043711] pci 0000:00:00.0:   bridge window [mem 0x18100000-0x181fffff=
]
[    2.050518] pci 0000:00:00.0:   bridge window [mem
0x18200000-0x182fffff pref]
[    2.058205] pcieport 0000:00:00.0: PME: Signaling with IRQ 205
# dmesg | grep ath
[    2.064379] ath9k 0000:01:00.0: enabling device (0000 -> 0002)
[    2.070445] ath: phy0: WB335 2-ANT card detected
[    2.075092] ath: phy0: Set BT/WLAN RX diversity capability
[    2.088891] ath: phy0: Enable LNA combining
[    2.094278] ath: EEPROM regdomain: 0x6a
[    2.094285] ath: EEPROM indicates we should expect a direct regpair map
[    2.094293] ath: Country alpha2 being used: 00
[    2.094297] ath: Regpair used: 0x6a
[   14.228284] ath9k 0000:01:00.0 wlp1s0: renamed from wlan0
# wpa_supplicant -i wlp1s0 -c wpa_supplicant.conf
Successfully initialized wpa_supplicant
<snip authentication details>
# grep ath /proc/interrupts
204:          0          0          0          0     GICv3 157 Level     at=
h9k
# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 11:       2196       1753       1883       3509     GICv3  30 Level
  arch_timer
 14:          0          0          0          0     GICv3  79 Level
  timer@306a0000
 15:          0          0          0          0     GICv3  23 Level     ar=
m-pmu
 16:          0          0          0          0     GICv3 135 Level
  302c0000.dma-controller
 17:          0          0          0          0     GICv3  66 Level
  302b0000.dma-controller
 18:          0          0          0          0     GICv3  34 Level
  30bd0000.dma-controller
 19:          0          0          0          0     GICv3  58 Level
  30860000.serial
 20:          0          0          0          0     GICv3  60 Level
  30880000.serial
 21:        503          0          0          0     GICv3  59 Level
  30890000.serial
 22:          0          0          0          0     GICv3 110 Level
  30280000.watchdog
 23:        418          0          0          0     GICv3  56 Level     mm=
c2
 41:          0          0          0          0  gpio-mxc  15 Edge      pp=
s.-1
 66:          0          0          0          0  gpio-mxc   6 Level
  gateworks-gsc
194:        750          0          0          0     GICv3  67 Level
  30a20000.i2c
195:          0          0          0          0  gateworks-gsc   4
Edge      0-0023
196:         25          0          0          0     GICv3  68 Level
  30a30000.i2c
197:          0          0          0          0     GICv3  69 Level
  30a40000.i2c
198:          0          0          0          0     GICv3  64 Level
  30830000.spi
199:          0          0          0          0     GICv3 150 Level
  30be0000.ethernet
200:          0          0          0          0     GICv3 151 Level
  30be0000.ethernet
201:          0          0          0          0     GICv3 152 Level
  30be0000.ethernet
202:          0          0          0          0     GICv3 153 Level
  30be0000.ethernet
204:          0          0          0          0     GICv3 157 Level     at=
h9k
205:          0          0          0          0   PCI-MSI   0 Edge
  PCIe PME
206:          0          0          0          0     GICv3  72 Level
  32e40000.usb
207:         18          0          0          0     GICv3  73 Level
  32e50000.usb
208:          0          0          0          0  gateworks-gsc   0
Edge      user_pb1x
209:          0          0          0          0  gateworks-gsc   1
Edge      key_erased
210:          0          0          0          0  gateworks-gsc   2
Edge      eeprom_wp
211:          0          0          0          0  gateworks-gsc   5
Edge      tamper
212:          0          0          0          0  gateworks-gsc   7
Edge      switch_hold
213:          0          0          0          0 0-0023   2 Edge      user_=
pb
IPI0:       620        751        665        109       Rescheduling interru=
pts
IPI1:       361       1387       1285        509       Function call interr=
upts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for
crash dump) interrupts
IPI4:         0          0          0          0       Timer broadcast
interrupts
IPI5:         5          9         10          2       IRQ work interrupts
IPI6:         0          0          0          0       CPU wake-up interrup=
ts
Err:          0
^^^ no interrupts from ath9k radio
^^^ is MSI enabled for the controller but ath9k electing to use legacy
INT's a valid configuration?

With MSI disabled globally via pci=3Dnomsi ath9k gets interrupts and works =
fine:
# cat /proc/cmdline
pci=3Dnomsi
# dmesg | grep ath
[    2.052527] ath9k 0000:01:00.0: enabling device (0000 -> 0002)
[    2.058556] ath: phy0: WB335 2-ANT card detected
[    2.063199] ath: phy0: Set BT/WLAN RX diversity capability
[    2.077381] ath: phy0: Enable LNA combining
[    2.082799] ath: EEPROM regdomain: 0x6a
[    2.082805] ath: EEPROM indicates we should expect a direct regpair map
[    2.082813] ath: Country alpha2 being used: 00
[    2.082818] ath: Regpair used: 0x6a
[   11.620093] ath9k 0000:01:00.0 wlp1s0: renamed from wlan0
# wpa_supplicant -i wlp1s0 -c wpa_supplicant.conf
Successfully initialized wpa_supplicant
<snip authentication details>
#
# grep ath /proc/interrupts
203:        379          0          0          0     GICv3 157 Level
  PCIe PME, ath9k
# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 11:       1622       2152       3288       2005     GICv3  30 Level
  arch_timer
 14:          0          0          0          0     GICv3  79 Level
  timer@306a0000
 15:          0          0          0          0     GICv3  23 Level     ar=
m-pmu
 16:          0          0          0          0     GICv3 135 Level
  302c0000.dma-controller
 17:          0          0          0          0     GICv3  66 Level
  302b0000.dma-controller
 18:          0          0          0          0     GICv3  34 Level
  30bd0000.dma-controller
 19:          0          0          0          0     GICv3  58 Level
  30860000.serial
 20:          0          0          0          0     GICv3  60 Level
  30880000.serial
 21:        597          0          0          0     GICv3  59 Level
  30890000.serial
 22:          0          0          0          0     GICv3 110 Level
  30280000.watchdog
 23:        414          0          0          0     GICv3  56 Level     mm=
c2
 41:          0          0          0          0  gpio-mxc  15 Edge      pp=
s.-1
 66:          0          0          0          0  gpio-mxc   6 Level
  gateworks-gsc
194:        978          0          0          0     GICv3  67 Level
  30a20000.i2c
195:          0          0          0          0  gateworks-gsc   4
Edge      0-0023
196:         25          0          0          0     GICv3  68 Level
  30a30000.i2c
197:          0          0          0          0     GICv3  69 Level
  30a40000.i2c
198:          0          0          0          0     GICv3  64 Level
  30830000.spi
199:          0          0          0          0     GICv3 150 Level
  30be0000.ethernet
200:          0          0          0          0     GICv3 151 Level
  30be0000.ethernet
201:          0          0          0          0     GICv3 152 Level
  30be0000.ethernet
202:          0          0          0          0     GICv3 153 Level
  30be0000.ethernet
203:        379          0          0          0     GICv3 157 Level
  PCIe PME, ath9k
204:          0          0          0          0     GICv3  72 Level
  32e40000.usb
205:         18          0          0          0     GICv3  73 Level
  32e50000.usb
206:          0          0          0          0  gateworks-gsc   0
Edge      user_pb1x
207:          0          0          0          0  gateworks-gsc   1
Edge      key_erased
208:          0          0          0          0  gateworks-gsc   2
Edge      eeprom_wp
209:          0          0          0          0  gateworks-gsc   5
Edge      tamper
210:          0          0          0          0  gateworks-gsc   7
Edge      switch_hold
211:          0          0          0          0 0-0023   2 Edge      user_=
pb
IPI0:       501        506         73        759       Rescheduling interru=
pts
IPI1:       878        846        718       1169       Function call interr=
upts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for
crash dump) interrupts
IPI4:         0          0          0          0       Timer broadcast
interrupts
IPI5:         5          4          9         20       IRQ work interrupts
IPI6:         0          0          0          0       CPU wake-up interrup=
ts
Err:          0
^^^ legacy interrupts working as long as I disable MSI globally for IMX8MM

And with MSI enabled globally as well as ath9k (ath9k.use_msi=3D1) ath9k
fails to get interrupts and shows the interrupt error I ran into
previously:
# cat /proc/cmdline
ath9k.use_msi=3D1
# dmesg | grep ath
[    0.000000] Kernel command line: ath9k.use_msi=3D1
[    2.056381] ath9k 0000:01:00.0: enabling device (0000 -> 0002)
[    2.062571] ath9k 0000:01:00.0: Using MSI
[    2.066651] ath: phy0: WB335 2-ANT card detected
[    2.071288] ath: phy0: Set BT/WLAN RX diversity capability
[    2.085083] ath: phy0: Enable LNA combining
[    2.090470] ath: EEPROM regdomain: 0x6a
[    2.090476] ath: EEPROM indicates we should expect a direct regpair map
[    2.090484] ath: Country alpha2 being used: 00
[    2.090489] ath: Regpair used: 0x6a
[   13.999159] ath9k 0000:01:00.0 wlp1s0: renamed from wlan0
# wpa_supplicant -i wlp1s0 -c wpa_supplicant.conf
Successfully initialized wpa_supplicant
[   66.790178] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0x6A0C=
9C8
[   66.798000] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0x6A0C=
9C8
[   66.811551] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0x6A0C=
9C8
[   66.937204] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0x6A0C=
9C8
[   66.950679] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0x6A0C=
9C8
[   67.020994] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA0C=
9C8
[   67.092917] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA0C=
9C8
[   67.164905] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA0C=
9C8
[   67.236957] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA0C=
9C8
[   67.308928] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA0C=
9C8
[   67.380902] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA0C=
9C8
[   67.452954] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA0C=
9C8
[   67.524881] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA0C=
9C8
[   67.596917] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA0C=
9C8
[   67.668907] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA0C=
9C8
[   67.740908] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA0C=
9C8
[   67.860948] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg =3D 0xEA0C=
9C8
...
<snip authentication details>
# grep ath /proc/interrupts
206:          0          0          0          0   PCI-MSI 524288 Edge
     ath9k
# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 11:       1421       3067       1999       2767     GICv3  30 Level
  arch_timer
 14:          0          0          0          0     GICv3  79 Level
  timer@306a0000
 15:          0          0          0          0     GICv3  23 Level     ar=
m-pmu
 16:          0          0          0          0     GICv3 135 Level
  302c0000.dma-controller
 17:          0          0          0          0     GICv3  66 Level
  302b0000.dma-controller
 18:          0          0          0          0     GICv3  34 Level
  30bd0000.dma-controller
 19:          0          0          0          0     GICv3  58 Level
  30860000.serial
 20:          0          0          0          0     GICv3  60 Level
  30880000.serial
 21:        289          0          0          0     GICv3  59 Level
  30890000.serial
 22:          0          0          0          0     GICv3 110 Level
  30280000.watchdog
 23:        390          0          0          0     GICv3  56 Level     mm=
c2
 41:          0          0          0          0  gpio-mxc  15 Edge      pp=
s.-1
 66:          0          0          0          0  gpio-mxc   6 Level
  gateworks-gsc
194:       1054          0          0          0     GICv3  67 Level
  30a20000.i2c
195:          0          0          0          0  gateworks-gsc   4
Edge      0-0023
196:         25          0          0          0     GICv3  68 Level
  30a30000.i2c
197:          0          0          0          0     GICv3  69 Level
  30a40000.i2c
198:          0          0          0          0     GICv3  64 Level
  30830000.spi
199:          0          0          0          0     GICv3 150 Level
  30be0000.ethernet
200:          0          0          0          0     GICv3 151 Level
  30be0000.ethernet
201:          0          0          0          0     GICv3 152 Level
  30be0000.ethernet
202:          0          0          0          0     GICv3 153 Level
  30be0000.ethernet
205:       6891          0          0          0   PCI-MSI   0 Edge
  PCIe PME
206:          0          0          0          0   PCI-MSI 524288 Edge
     ath9k
207:          0          0          0          0     GICv3  72 Level
  32e40000.usb
208:         18          0          0          0     GICv3  73 Level
  32e50000.usb
209:          0          0          0          0  gateworks-gsc   0
Edge      user_pb1x
210:          0          0          0          0  gateworks-gsc   1
Edge      key_erased
211:          0          0          0          0  gateworks-gsc   2
Edge      eeprom_wp
212:          0          0          0          0  gateworks-gsc   5
Edge      tamper
213:          0          0          0          0  gateworks-gsc   7
Edge      switch_hold
214:          0          0          0          0 0-0023   2 Edge      user_=
pb
IPI0:       646         64        692        808       Rescheduling interru=
pts
IPI1:      1211        893        503       1097       Function call interr=
upts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for
crash dump) interrupts
IPI4:         0          0          0          0       Timer broadcast
interrupts
IPI5:         9         13         12          8       IRQ work interrupts
IPI6:         0          0          0          0       CPU wake-up interrup=
ts
Err:          0
^^^ It looks to me like when using MSI above the interrupts are going
to the PME driver MSI 0 and the ath9k MSI interrupt shows as 524288
which aligns to 4 but seems strange that its so large.

Does this jive with what you encountered?

Note that ath10k which require MSI interrupts are working fine on this
platform and the MSI interrupt is also 524288:
205:          0          0          0          0   PCI-MSI   0 Edge
  PCIe PME
206:        632          0          0          0   PCI-MSI 524288 Edge
     ath10k_pci

Note that ath11k which requires MSI interrupts is also working fine on
this board:
205:          0          0          0          0   PCI-MSI   0 Edge
  PCIe PME
206:          4          0          0          0   PCI-MSI 524288 Edge     =
 bhi
207:          4          0          0          0   PCI-MSI 524289 Edge     =
 mhi
208:         39          0          0          0   PCI-MSI 524290 Edge     =
 mhi
209:          3          0          0          0   PCI-MSI 524291 Edge     =
 ce0
210:         26          0          0          1   PCI-MSI 524292 Edge     =
 ce1
211:        267          0          0          1   PCI-MSI 524293 Edge     =
 ce2
212:         88          0          0          0   PCI-MSI 524294 Edge     =
 ce3
213:          0          0          0          1   PCI-MSI 524295 Edge     =
 ce5
214:          2          0          0          0   PCI-MSI 524296 Edge
     DP_EXT_IRQ
215:          0          0          0          0   PCI-MSI 524297 Edge
     DP_EXT_IRQ
216:          0          0          0          0   PCI-MSI 524298 Edge
     DP_EXT_IRQ
217:         15          0          0          0   PCI-MSI 524299 Edge
     DP_EXT_IRQ
218:          0          0          0          0   PCI-MSI 524300 Edge
     DP_EXT_IRQ
219:          2          0          0          0   PCI-MSI 524301 Edge
     DP_EXT_IRQ
220:          0          0          0          0   PCI-MSI 524302 Edge
     DP_EXT_IRQ
221:          0          0          0          0   PCI-MSI 524303 Edge
     DP_EXT_IRQ

Now, if I move back to an imx8mm-venice-gw73xx-0x which has an IMX8MM
and a PCI bridge I can't even get the legacy IRQ configuration to work
(no interrupts):
# cat /proc/cmdline
pci=3Dnomsi
# lspci
00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
01:00.0 PCI bridge: Pericom Semiconductor Device b404 (rev 01)
02:01.0 PCI bridge: Pericom Semiconductor Device b404 (rev 01)
02:02.0 PCI bridge: Pericom Semiconductor Device b404 (rev 01)
02:03.0 PCI bridge: Pericom Semiconductor Device b404 (rev 01)
04:00.0 Network controller: Qualcomm Atheros QCA9565 / AR9565 Wireless
Network Adapter (rev 01)
05:00.0 Ethernet controller: Microchip Technology / SMSC Device 7430 (rev 1=
1)
# dmesg | grep ath
[    2.475134] ath9k 0000:04:00.0: enabling device (0000 -> 0002)
[    2.481157] ath: phy0: WB335 2-ANT card detected
[    2.485797] ath: phy0: Set BT/WLAN RX diversity capability
[    2.499443] ath: phy0: Enable LNA combining
[    2.504837] ath: EEPROM regdomain: 0x6a
[    2.504845] ath: EEPROM indicates we should expect a direct regpair map
[    2.504853] ath: Country alpha2 being used: 00
[    2.504858] ath: Regpair used: 0x6a
[   10.237297] ath9k 0000:04:00.0 wlp4s0: renamed from wlan0
# wpa_supplicant -i wlp4s0 -c wpa_supplicant.conf
<snip failed auth>
# grep -i pci /proc/interrupts
204:          0          0          0          0     GICv3 157 Level
  PCIe PME, ath9k
# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 11:       1550       3047       2199       4301     GICv3  30 Level
  arch_timer
 14:          0          0          0          0     GICv3  79 Level
  timer@306a0000
 15:          0          0          0          0     GICv3  23 Level     ar=
m-pmu
 16:          0          0          0          0     GICv3 135 Level
  302c0000.dma-controller
 17:          0          0          0          0     GICv3  66 Level
  302b0000.dma-controller
 18:        332          0          0          0     GICv3  34 Level
  30bd0000.dma-controller
 19:          0          0          0          0     GICv3  58 Level
  30860000.serial
 20:        773          0          0          0     GICv3  59 Level
  30890000.serial
 21:          0          0          0          0     GICv3  61 Level
  30a60000.serial
 22:          0          0          0          0     GICv3 110 Level
  30280000.watchdog
 23:        433          0          0          0     GICv3  56 Level     mm=
c2
 41:          0          0          0          0  gpio-mxc  15 Edge      pp=
s.-1
 66:          0          0          0          0  gpio-mxc   6 Level
  gateworks-gsc
 72:          0          0          0          0  gpio-mxc  12 Edge
  30b50000.mmc cd
170:          4          0          0          0  gpio-mxc   8 Edge
  30880000.serial
194:       1282          0          0          0     GICv3  67 Level
  30a20000.i2c
195:          0          0          0          0  gateworks-gsc   4
Edge      0-0023
196:         25          0          0          0     GICv3  68 Level
  30a30000.i2c
197:          0          0          0          0     GICv3  69 Level
  30a40000.i2c
198:          0          0          0          0     GICv3  60 Level
  30880000.serial
199:          0          0          0          0     GICv3  64 Level
  30830000.spi
200:          0          0          0          0     GICv3 150 Level
  30be0000.ethernet
201:          0          0          0          0     GICv3 151 Level
  30be0000.ethernet
202:          0          0          0          0     GICv3 152 Level
  30be0000.ethernet
203:          0          0          0          0     GICv3 153 Level
  30be0000.ethernet
204:          0          0          0          0     GICv3 157 Level
  PCIe PME, ath9k
205:          0          0          0          0     GICv3  72 Level
  32e40000.usb
206:        105          0          0          0     GICv3  73 Level
  32e50000.usb
207:       6244          0          0          0     GICv3  54 Level     mm=
c0
208:          0          0          0          0     GICv3  55 Level     mm=
c1
209:          0          0          0          0  gateworks-gsc   0
Edge      user_pb1x
210:          0          0          0          0  gateworks-gsc   1
Edge      key_erased
211:          0          0          0          0  gateworks-gsc   2
Edge      eeprom_wp
212:          0          0          0          0  gateworks-gsc   5
Edge      tamper
213:          0          0          0          0  gateworks-gsc   7
Edge      switch_hold
214:          0          0          0          0 0-0023   2 Edge      user_=
pb
IPI0:       367        486        444        286       Rescheduling interru=
pts
IPI1:       972       1283       1202       1630       Function call interr=
upts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for
crash dump) interrupts
IPI4:         0          0          0          0       Timer broadcast
interrupts
IPI5:         5          6          7         36       IRQ work interrupts
IPI6:         0          0          0          0       CPU wake-up interrup=
ts
Err:          0
^^^ why no interrupts on this board when disabling MSI globally and
using ath9k legacy interrupts.... something to do with the bridge?

Best Regards,

Tim



On Mon, Mar 20, 2023 at 4:29=E2=80=AFAM Daniel Drake <drake@endlessos.org> =
wrote:
>
> On Sat, Mar 18, 2023 at 8:17=E2=80=AFAM Tim Harvey <tharvey@gateworks.com=
> wrote:
> > It seems that Daniel may have been running into something similar back
> > when commit 7368160f0ab0 ("ath9k: add MSI support") was merged
> > [1][2][3]
> >
> > Does anyone have any advice here about what can be going on?
>
> The issue we found earlier was that ath9k MSI is broken unless the MSI
> IRQ number coincidentally is aligned to 4.
>
> Worked around with:
> https://github.com/endlessm/linux/commit/0a2d86a2b9da8f936d873addf0a97e34=
1177fe8a
> https://github.com/endlessm/linux/commit/970d2b4b59465cd926e5213e0feb633f=
6b623447
>
> IIRC the PCI patch wasn't accepted upstream at the time and I never
> got any response from Atheros/Qualcomm about this device
> hardware/firmware bug.
>
> Daniel
