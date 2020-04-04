Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F66819E723
	for <lists+linux-pci@lfdr.de>; Sat,  4 Apr 2020 20:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgDDSmN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Apr 2020 14:42:13 -0400
Received: from mout.web.de ([217.72.192.78]:49281 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgDDSmN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 4 Apr 2020 14:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586025717;
        bh=trCALmJZseGACsClEdyAIz3NMsZceSEOXCi9yrgcNQs=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=sTbZanwSbwh6vReBP4BkKqrp7ZOjpXmptcnFPi5ADLqpp49BkB+OLkgyHYh6kDKkj
         xTqQQb5YLd5s8Yn6dTj2pWN97LTBTJvt31XQgvsjQheuJzokJXHWaIKjbqGXQt+M9r
         CconQOuVhX+4G50Z/U7XfA5QgRe2zQdRiFSEYruI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.43.108] ([89.204.138.81]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcgZv-1iwDsw1e0F-00k4OB; Sat, 04
 Apr 2020 20:41:57 +0200
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Soeren Moch <smoch@web.de>
Subject: [BUG] PCI: rockchip: rk3399: pcie switch support
Message-ID: <4d03dd8c-14f9-d1ef-6fd2-095423be3dd3@web.de>
Date:   Sat, 4 Apr 2020 20:41:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:u8HfsDqQbXgpehXSoYFpxfi5/sgKOSigN7n7MgtbB5C25j4rBZE
 eGE3jCmubCFLRVXY5ow9YfrzR1y4iEx3+lCqq+xLpcfF/ysc4vcQA/sp5JvR9K6Ho4Ndwdi
 OoR9afTkZ1UrRAQEMSsLvwbxOkVMrl3dZejumepGQdhiC1BQ/bdk46ji4wAAS+iT13ga2wH
 hefwuPZ4NAj8oKdppUY7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vc8nQLqxyRM=:3XRlLs7Uzjecv1ItVf27yu
 daFevHFaCZTD6uB8dMGSlAlPpkjoegDMXZCdiCu8CnxRlJWnfm5ncblZI4aVdC8ySgKe+Yxnx
 BAtYH8eDB6WqeHpwEUiwPxckjACEkhAk8M8NbCNPTJcEaMlVU12j3exvNV5jPkFcucugmzqE+
 k5mlg9ro2elqx/7oo1sTsIBAkPnjURsS2vFvOBsbp11be5auGhrTl3vjC4MwjrYDAvW+Cb3e8
 zUFUZ10/4JqZgzd69LmCTdOaczh5bDQ9ExXA5V1Vk+KYXQg3sW3QRGg2DJioP1i/rHsg45ugB
 RFWCRmczSWC7DzHALi+3WjVZkzegMAi+RzBsKaQmNM9U0z1SC5cGkqOXuTM0U45kDF4D2QGjJ
 eBOJDoo+x2/O+T2HPHNGAgW8egP+COEHQUJQyng4yQbbWOZIvW706vjC+iQdW4Jb3MoYS6xko
 XGyIgLuD7k3aBgRfg4GIclWpLtczGyPtakEF0t51SYKDwxS2ciIc+AzBrqIA9NW2woP52GhPg
 537lZu0qDlmY/wQegcAjt5utLahU9DbcgiO3pSSzWscxAxM6rG5Vab5B+t06vTAidfnLdD35V
 t9WtjCQJ6f8ql7TrCqGVYZXNvk1ehVdcjxd0QI7e3U13bZTXjiCMV2/A478Lv1VOyQyaU2XIS
 80g3O7XAPP3uSlfw4QTJnSPahRP0nsGXwjnHBX/GprDDXuUAjQVN7MyWBWsHuO9HMWBl6huAc
 aFC+5QM4XK61vxQCsmtfuvGaiqH/OCf2yzYOo2BMPtxdgK1g8lWn8YpsnXGghMXP1u8JwL1db
 PYvS8yalTcQkYTHF2N03SH21/G4IShUNvTVJo7PD0c9s6SbnO3VFhQxUBjO/7q13XmUGTESen
 usOLjlc4SzFlvqcYfBO2ESMOmmsMI/3QxO++WCYXh3nMymf8hPYO9a8NogILIJ44BdsA5gEme
 R+dE8iaUFwWNW+tcEz5zfiwRL1oXoAe/zdW//siMtKFvZOwvqrz/mAVr+oD7NwQExvQVKsnNo
 XPMq0JbYHs9AWM0ccNQ9SrlM7qvKT5kOeg1SVmAvY/cyu1WhY8fEryNQvLSLAo6ZoPQ/JoWFU
 xKAum9PFS/UF+nLzIGw9apo6ZctN/t0P16WWAhxUOTU9iIyK1Kv+9EAZPJnS322tcm6wsN+wv
 +Y4801YFXKglwlBfJEXUX5Sa/gPJwb1P91tpZRhyxgF4Wa1ZlAhCqcf4Fwi8lB16POnwplm1q
 2iCdYJpL2qA5vGT6T
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I want to use a PCIe switch on a RK3399 based RockPro64 V2.1 board.
"Normal" PCIe cards work (mostly) just fine on this board. The PCIe
switches (I tried Pericom and ASMedia based switches) also work fine on
other boards. The RK3399 PCIe controller with pcie_rockchip_host driver
also recognises the switch, but fails to initialize the buses behind the
bridge properly, see syslog from linux-5.6.0.

Any ideas what I do wrong, or any suggestions what I can test here?

Thanks,
Soeren


Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.501951] rockchip-p=
cie
f8000000.pcie: f8000000.pcie supply vpcie1v8 not found, using dummy
regulator
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.502906] rockchip-p=
cie
f8000000.pcie: f8000000.pcie supply vpcie0v9 not found, using dummy
regulator
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.572050] rockchip-p=
cie
f8000000.pcie: host bridge /pcie@f8000000 ranges:
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.573018] rockchip-p=
cie
f8000000.pcie: Parsing ranges property...
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.573040] rockchip-p=
cie
f8000000.pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MEM 0x00fa000000..0x00fbdffff=
f -> 0x00fa000000
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.574080] rockchip-p=
cie
f8000000.pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IO 0x00fbe00000..0x00fb=
efffff -> 0x00fbe00000
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.575420] rockchip-p=
cie
f8000000.pcie: PCI host bridge to bus 0000:00
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.576247] pci_bus 00=
00:00: root
bus resource [bus 00-1f]
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.576930] pci_bus 00=
00:00: root
bus resource [mem 0xfa000000-0xfbdfffff]
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.577739] pci_bus 00=
00:00: root
bus resource [io=C2=A0 0x0000-0xfffff] (bus address [0xfbe00000-0xfbefffff=
])
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.578876] pci_bus 00=
00:00:
scanning bus
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.578918] pci 0000:0=
0:00.0:
[1d87:0100] type 01 class 0x060400
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.579734] pci 0000:0=
0:00.0:
supports D1
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.580252] pci 0000:0=
0:00.0: PME#
supported from D0 D1 D3hot
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.580952] pci 0000:0=
0:00.0: PME#
disabled
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.585475] pci_bus 00=
00:00: fixups
for bus
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.585491] pci 0000:0=
0:00.0:
scanning [bus 00-00] behind bridge, pass 0
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.585497] pci 0000:0=
0:00.0:
bridge configuration invalid ([bus 00-00]), reconfiguring
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.586562] pci 0000:0=
0:00.0:
scanning [bus 00-00] behind bridge, pass 1
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.586725] pci_bus 00=
00:01:
scanning bus
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.586792] pci 0000:0=
1:00.0:
[1b21:1182] type 01 class 0x060400
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.587785] pci 0000:0=
1:00.0: Max
Payload Size set to 256 (was 128, max 256)
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.588625] pci 0000:0=
1:00.0:
enabling Extended Tags
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.589487] pci 0000:0=
1:00.0: PME#
supported from D0 D3hot D3cold
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.590199] pci 0000:0=
1:00.0: PME#
disabled
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.590344] pci 0000:0=
1:00.0: 2.000
Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at
0000:00:00.0 (capable of 4.000 Gb/s with 5 GT/s x1 link)
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.598206] pci_bus 00=
00:01: fixups
for bus
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.598226] pci 0000:0=
1:00.0:
scanning [bus 00-00] behind bridge, pass 0
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.598231] pci 0000:0=
1:00.0:
bridge configuration invalid ([bus 00-00]), reconfiguring
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.599163] pci 0000:0=
1:00.0:
scanning [bus 00-00] behind bridge, pass 1
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.599443] pci_bus 00=
00:02:
scanning bus
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.599460] Internal e=
rror:
synchronous external abort: 96000210 [#1] PREEMPT SMP
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.600271] Modules li=
nked in:
pcie_rockchip_host(+) brcmfmac brcmutil
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.600978] CPU: 3 PID=
: 565 Comm:
modprobe Not tainted 5.6.0 #1
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.601607] Hardware n=
ame: Pine64
RockPro64 v2.1 (DT)
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.602147] pstate: 60=
000085 (nZCv
daIf -PAN -UAO)
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.602666] pc :
rockchip_pcie_rd_conf+0x120/0x228 [pcie_rockchip_host]
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.603373] lr :
rockchip_pcie_rd_conf+0x94/0x228 [pcie_rockchip_host]
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.604064] sp : fffff=
fc011003500
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.604419] x29: fffff=
fc011003500
x28: 0000000000000000
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.604986] x27: 00000=
00000000001
x26: 0000000000000000
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.605552] x25: 00000=
00000000000
x24: ffffffc011003644
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.606117] x23: fffff=
f80f1792000
x22: ffffffc011003584
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.606683] x21: fffff=
f80e98313c0
x20: 0000000000000004
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.607249] x19: fffff=
fc012200000
x18: 00000000fffffff0
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.607815] x17: 00000=
00000000000
x16: 0000000000000000
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.608381] x15: fffff=
fc010b77c00
x14: ffffffc010be2e28
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.608947] x13: 00000=
00000000000
x12: ffffffc010be2000
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.609512] x11: fffff=
fc010b77000
x10: ffffffc010be2470
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.610079] x9 : 00000=
00011821b21
x8 : 0000000000000001
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.615455] x7 : 00000=
00000000000
x6 : 0000000000000000
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.621487] x5 : 00000=
00000200000
x4 : 0000000000000000
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.627519] x3 : 00000=
00000c00008
x2 : 000000000080000b
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.633551] x1 : fffff=
fc015c00008
x0 : ffffffc012000000
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.639583] Call trace=
:
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.645785]=C2=A0
rockchip_pcie_rd_conf+0x120/0x228 [pcie_rockchip_host]
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.656354]=C2=A0
pci_bus_read_config_dword+0x80/0xd0
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.665083]=C2=A0
pci_bus_generic_read_dev_vendor_id+0x30/0x1a8
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.674722]=C2=A0
pci_bus_read_dev_vendor_id+0x48/0x68
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.683382]=C2=A0
pci_scan_single_device+0x7c/0xd8
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.691690]=C2=A0 pci_=
scan_slot+0x34/0x118
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.699155]=C2=A0
pci_scan_child_bus_extend+0x60/0x2cc
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.707774]=C2=A0
pci_scan_bridge_extend+0x340/0x578
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.716224]=C2=A0
pci_scan_child_bus_extend+0x20c/0x2cc
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.724943]=C2=A0
pci_scan_bridge_extend+0x340/0x578
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.733320]=C2=A0
pci_scan_child_bus_extend+0x20c/0x2cc
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.741998]=C2=A0
pci_scan_child_bus+0x10/0x18
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.749739]=C2=A0
pci_scan_root_bus_bridge+0x78/0xd0
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.757988]=C2=A0
rockchip_pcie_probe+0x830/0xb90 [pcie_rockchip_host]
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.768042]=C2=A0
platform_drv_probe+0x50/0xa0
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.775758]=C2=A0 real=
ly_probe+0xd8/0x300
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.782939]=C2=A0
driver_probe_device+0x54/0xe8
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.790661]=C2=A0
device_driver_attach+0x6c/0x78
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.798461]=C2=A0 __dr=
iver_attach+0x54/0xd0
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.805744]=C2=A0 bus_=
for_each_dev+0x70/0xc0
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.813119]=C2=A0 driv=
er_attach+0x20/0x28
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.820101]=C2=A0 bus_=
add_driver+0x178/0x1d8
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.827249]=C2=A0 driv=
er_register+0x60/0x110
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.834308]=C2=A0
__platform_driver_register+0x44/0x50
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.842299]=C2=A0
rockchip_pcie_driver_init+0x20/0x1000 [pcie_rockchip_host]
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.852443]=C2=A0 do_o=
ne_initcall+0x74/0x1a8
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.859430]=C2=A0 do_i=
nit_module+0x50/0x1f0
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.866276]=C2=A0 load=
_module+0x1c0c/0x2158
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.873100]=C2=A0
__do_sys_finit_module+0xd0/0xe8
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.880480]=C2=A0
__arm64_sys_finit_module+0x1c/0x28
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.888157]=C2=A0
el0_svc_common.constprop.1+0x7c/0xe8
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.896000]=C2=A0 do_e=
l0_svc+0x18/0x20
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.902285]=C2=A0
el0_sync_handler+0x12c/0x1b0
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.909380]=C2=A0 el0_=
sync+0x114/0x140
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.915692] Code: a8c3=
7bfd d65f03c0
f94002a0 8b130013 (b9400273)
Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.925210] ---[ end t=
race
181d7993f92f3f3d ]---

