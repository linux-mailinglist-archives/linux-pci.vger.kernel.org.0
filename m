Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64C219FB1A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Apr 2020 19:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgDFRMx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Apr 2020 13:12:53 -0400
Received: from mout.web.de ([212.227.17.11]:42867 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728863AbgDFRMx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Apr 2020 13:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586193155;
        bh=rnSA5q/A3F7Si92rJ3NKVxcS5InX2AzoZTUDqKDUaAw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aghbyhQj5EpvoS5xpm27AOMbiEguoRHCx+q/MKj7vZSNYKcx8DOPOoezKWvlXRit/
         n39mlsPy05J6tOBNd+Yy+4DWOfbNHcCfApiyZ7NMG8INVPqwufuxuzCCJ3Wu9A7g6y
         mN3ApxZKnVCpW6D6EMlZh5E81oHCFw71201Blm0U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.43.108] ([89.204.138.192]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6DuI-1j5eFE2rwA-00yCwd; Mon, 06
 Apr 2020 19:12:34 +0200
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
From:   Soeren Moch <smoch@web.de>
Autocrypt: addr=smoch@web.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b088ad0e-bab1-0cff-dc43-eb5709555902@web.de>
Date:   Mon, 6 Apr 2020 19:12:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3e9d2c53-4f0d-0c97-fbfa-6d799e223747@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:IG3ILwHimTqFpZrjG2V0Q80umcmQEynvlbwvqVf7wdUi+cbfwN+
 Yx81YHgxLLxk3WrYQEf9tp+aQqkjSL+uePALxHuDqq8NAe1syeTutjdd3t2Usb/jf/HuHQV
 KBGEbcO4Ada+F6KgvMCtPj23vjIp3QSSfSb8EroLA1k14eGdg1t5nqR7ofMKBekxoscck07
 l3PHMZlt51Sdvg0Lo3pqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:c+klp4xMIMY=:N3VJfPKj2t+KAtcJ/yNYkK
 wm8gFhwNz5FBpsvdBCHYwexit/P6IV/SGObNBb6CB+TysqmDQDmFDi05MVv9XhCrnciUDiAlZ
 9sOezm+8MOG9wnGUiyAdI1070hk4Yr+Prhinb1xHCl8QgndqdNCSHJPHeaRg/r1wcSkoB00IC
 sQ5sGQbI9YbOFb8C4eYD6sh1630MZqppSdS7aMJydpn+EJfPfNZ7YJMLBZXebeXGq6pDHxkw+
 NcvFkeWGVuZTqWA7TcVUHnuDr2Tm6SFZTn7Vw+NkhS4sqXFuJRP8VIHCELchVo2a4ddqQETRm
 VnU1BJCvMl/o65p0ZEXMPFHY1fJtNglpL2eM3njIT/zLXYoGhSXTrDdvY+Yr3fgcpR7jIsgay
 0ZjSDwEV66CVjEbJPJsN9y6nuEOpqlYj2u3FfVRVzbM5MvoDLCNANqEXY8cmF1wCJ1dDm7CRM
 Ogl8MVTOAi4BgIlZ274262nfjBeD20ZR1s62bqZV0UwW1t/ly1mM37bl2LRZakq8YKTzG/O4A
 wYsL+DFBKpjJ3A+BGHyIbS/lMYKirrjxuN46Cvf/rkuENwH4rwtqQT/DQ20NMEihxiUeTKU08
 3I079YJACniGQaEpeB0OQXS+/zuQLSMdWaQ3ypiEpdFn+2fz2VoZcGxIo9PdKwYSB7HQ7ATMi
 tsQTGhGM3Ru/zq33eGLPkWLAFHLYb4HnrqmoZFzJt51fCN8Ee0DMdS/Ljoe3YaYuWvGdZuH+2
 PbtSq1JF3HkQR/e2Yp3HY8k/BHcpzy+CgNXwm5FyGrpHJT/AMggc9v12vDkwl83l9yGO+mQIT
 WKcxLC8FrOQ1T1Rrr7XjbEfW1WxFW7mMAF7dXWhn74YF8jTJqKmy3AJWYToSRm2yYRplae/bf
 SNTTpuPfjDqCU/6gl+IyTvUfdgbATAoWMuDHEi4zLX1R33bmhgSVRldsRdRkSk/6NuvcogzDv
 YQ4t8UkAXoRjY6Ealy2gKxBwbRRjNjTftmPWae0yofPA3KkRBKjK9L9LEsh4oy/BEtrDElgdq
 JHEVRGnmdwriWuiOYjtgiGL6nnxcP6DRopEsacgG9vETL40ssNnTv6P7nGyKzZT60sbVVj6Hp
 9X460jkZo5qdTqHRtWMEcibBEIpz1SGoMe8XNY9As1+xwyoWq4RnpuH723ndn6nOTEZ2UFNRR
 pfcjnk37CVF/S1PZCgMqOWsUtUaTV996Bzf0qr+IR+p+YOiZFlDHA94mDi+ilcpc0IOcRuMFa
 9kMfffMQPq/SisUvQ
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06.04.20 14:52, Robin Murphy wrote:
> On 2020-04-04 7:41 pm, Soeren Moch wrote:
>> I want to use a PCIe switch on a RK3399 based RockPro64 V2.1 board.
>> "Normal" PCIe cards work (mostly) just fine on this board. The PCIe
>> switches (I tried Pericom and ASMedia based switches) also work fine o=
n
>> other boards. The RK3399 PCIe controller with pcie_rockchip_host drive=
r
>> also recognises the switch, but fails to initialize the buses behind t=
he
>> bridge properly, see syslog from linux-5.6.0.
>>
>> Any ideas what I do wrong, or any suggestions what I can test here?
>
> See the thread here:
>
> https://lore.kernel.org/linux-pci/CAMdYzYoTwjKz4EN8PtD5pZfu3+SX+68JL+df=
vmCrSnLL=3DK6Few@mail.gmail.com/
>
Thanks Robin!

I also found out in the meantime that device enumeration fails in this
fatal way when probing non-existent devices. So if I hack my complete
bus topology into rockchip_pcie_valid_device, then all existing devices
come up properly. Of course this is not how PCIe should work.
>
> The conclusion there seems to be that the RK3399 root complex just
> doesn't handle certain types of response in a sensible manner, and
> there's not much that can reasonably be done to change that.
Hm, at least there is the promising suggestion to take over the SError
handler, maybe in ATF, as workaround.
I'm happy to test whatever becomes available.

Thanks,
Soeren
>
> Robin.
>
>>
>> Thanks,
>> Soeren
>>
>>
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.501951] rockch=
ip-pcie
>> f8000000.pcie: f8000000.pcie supply vpcie1v8 not found, using dummy
>> regulator
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.502906] rockch=
ip-pcie
>> f8000000.pcie: f8000000.pcie supply vpcie0v9 not found, using dummy
>> regulator
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.572050] rockch=
ip-pcie
>> f8000000.pcie: host bridge /pcie@f8000000 ranges:
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.573018] rockch=
ip-pcie
>> f8000000.pcie: Parsing ranges property...
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.573040] rockch=
ip-pcie
>> f8000000.pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MEM 0x00fa000000..0x00fbd=
fffff -> 0x00fa000000
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.574080] rockch=
ip-pcie
>> f8000000.pcie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IO 0x00fbe00000..0x=
00fbefffff -> 0x00fbe00000
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.575420] rockch=
ip-pcie
>> f8000000.pcie: PCI host bridge to bus 0000:00
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.576247] pci_bu=
s 0000:00: root
>> bus resource [bus 00-1f]
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.576930] pci_bu=
s 0000:00: root
>> bus resource [mem 0xfa000000-0xfbdfffff]
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.577739] pci_bu=
s 0000:00: root
>> bus resource [io=C2=A0 0x0000-0xfffff] (bus address [0xfbe00000-0xfbef=
ffff])
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.578876] pci_bu=
s 0000:00:
>> scanning bus
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.578918] pci 00=
00:00:00.0:
>> [1d87:0100] type 01 class 0x060400
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.579734] pci 00=
00:00:00.0:
>> supports D1
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.580252] pci 00=
00:00:00.0: PME#
>> supported from D0 D1 D3hot
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.580952] pci 00=
00:00:00.0: PME#
>> disabled
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.585475] pci_bu=
s 0000:00: fixups
>> for bus
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.585491] pci 00=
00:00:00.0:
>> scanning [bus 00-00] behind bridge, pass 0
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.585497] pci 00=
00:00:00.0:
>> bridge configuration invalid ([bus 00-00]), reconfiguring
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.586562] pci 00=
00:00:00.0:
>> scanning [bus 00-00] behind bridge, pass 1
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.586725] pci_bu=
s 0000:01:
>> scanning bus
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.586792] pci 00=
00:01:00.0:
>> [1b21:1182] type 01 class 0x060400
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.587785] pci 00=
00:01:00.0: Max
>> Payload Size set to 256 (was 128, max 256)
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.588625] pci 00=
00:01:00.0:
>> enabling Extended Tags
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.589487] pci 00=
00:01:00.0: PME#
>> supported from D0 D3hot D3cold
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.590199] pci 00=
00:01:00.0: PME#
>> disabled
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.590344] pci 00=
00:01:00.0: 2.000
>> Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at
>> 0000:00:00.0 (capable of 4.000 Gb/s with 5 GT/s x1 link)
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.598206] pci_bu=
s 0000:01: fixups
>> for bus
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.598226] pci 00=
00:01:00.0:
>> scanning [bus 00-00] behind bridge, pass 0
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.598231] pci 00=
00:01:00.0:
>> bridge configuration invalid ([bus 00-00]), reconfiguring
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.599163] pci 00=
00:01:00.0:
>> scanning [bus 00-00] behind bridge, pass 1
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.599443] pci_bu=
s 0000:02:
>> scanning bus
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.599460] Intern=
al error:
>> synchronous external abort: 96000210 [#1] PREEMPT SMP
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.600271] Module=
s linked in:
>> pcie_rockchip_host(+) brcmfmac brcmutil
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.600978] CPU: 3=
 PID: 565 Comm:
>> modprobe Not tainted 5.6.0 #1
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.601607] Hardwa=
re name: Pine64
>> RockPro64 v2.1 (DT)
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.602147] pstate=
: 60000085 (nZCv
>> daIf -PAN -UAO)
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.602666] pc :
>> rockchip_pcie_rd_conf+0x120/0x228 [pcie_rockchip_host]
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.603373] lr :
>> rockchip_pcie_rd_conf+0x94/0x228 [pcie_rockchip_host]
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.604064] sp : f=
fffffc011003500
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.604419] x29: f=
fffffc011003500
>> x28: 0000000000000000
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.604986] x27: 0=
000000000000001
>> x26: 0000000000000000
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.605552] x25: 0=
000000000000000
>> x24: ffffffc011003644
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.606117] x23: f=
fffff80f1792000
>> x22: ffffffc011003584
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.606683] x21: f=
fffff80e98313c0
>> x20: 0000000000000004
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.607249] x19: f=
fffffc012200000
>> x18: 00000000fffffff0
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.607815] x17: 0=
000000000000000
>> x16: 0000000000000000
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.608381] x15: f=
fffffc010b77c00
>> x14: ffffffc010be2e28
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.608947] x13: 0=
000000000000000
>> x12: ffffffc010be2000
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.609512] x11: f=
fffffc010b77000
>> x10: ffffffc010be2470
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.610079] x9 : 0=
000000011821b21
>> x8 : 0000000000000001
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.615455] x7 : 0=
000000000000000
>> x6 : 0000000000000000
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.621487] x5 : 0=
000000000200000
>> x4 : 0000000000000000
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.627519] x3 : 0=
000000000c00008
>> x2 : 000000000080000b
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.633551] x1 : f=
fffffc015c00008
>> x0 : ffffffc012000000
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.639583] Call t=
race:
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.645785]
>> rockchip_pcie_rd_conf+0x120/0x228 [pcie_rockchip_host]
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.656354]
>> pci_bus_read_config_dword+0x80/0xd0
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.665083]
>> pci_bus_generic_read_dev_vendor_id+0x30/0x1a8
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.674722]
>> pci_bus_read_dev_vendor_id+0x48/0x68
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.683382]
>> pci_scan_single_device+0x7c/0xd8
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.691690]=C2=A0
>> pci_scan_slot+0x34/0x118
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.699155]
>> pci_scan_child_bus_extend+0x60/0x2cc
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.707774]
>> pci_scan_bridge_extend+0x340/0x578
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.716224]
>> pci_scan_child_bus_extend+0x20c/0x2cc
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.724943]
>> pci_scan_bridge_extend+0x340/0x578
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.733320]
>> pci_scan_child_bus_extend+0x20c/0x2cc
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.741998]
>> pci_scan_child_bus+0x10/0x18
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.749739]
>> pci_scan_root_bus_bridge+0x78/0xd0
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.757988]
>> rockchip_pcie_probe+0x830/0xb90 [pcie_rockchip_host]
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.768042]
>> platform_drv_probe+0x50/0xa0
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.775758]=C2=A0
>> really_probe+0xd8/0x300
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.782939]
>> driver_probe_device+0x54/0xe8
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.790661]
>> device_driver_attach+0x6c/0x78
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.798461]=C2=A0
>> __driver_attach+0x54/0xd0
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.805744]=C2=A0
>> bus_for_each_dev+0x70/0xc0
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.813119]=C2=A0
>> driver_attach+0x20/0x28
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.820101]=C2=A0
>> bus_add_driver+0x178/0x1d8
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.827249]=C2=A0
>> driver_register+0x60/0x110
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.834308]
>> __platform_driver_register+0x44/0x50
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.842299]
>> rockchip_pcie_driver_init+0x20/0x1000 [pcie_rockchip_host]
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.852443]=C2=A0
>> do_one_initcall+0x74/0x1a8
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.859430]=C2=A0
>> do_init_module+0x50/0x1f0
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.866276]=C2=A0
>> load_module+0x1c0c/0x2158
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.873100]
>> __do_sys_finit_module+0xd0/0xe8
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.880480]
>> __arm64_sys_finit_module+0x1c/0x28
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.888157]
>> el0_svc_common.constprop.1+0x7c/0xe8
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.896000]=C2=A0 =
do_el0_svc+0x18/0x20
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.902285]
>> el0_sync_handler+0x12c/0x1b0
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.909380]=C2=A0 =
el0_sync+0x114/0x140
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.915692] Code: =
a8c37bfd d65f03c0
>> f94002a0 8b130013 (b9400273)
>> Apr=C2=A0 4 19:50:38 rockpro64 kernel: [=C2=A0=C2=A0 74.925210] ---[ e=
nd trace
>> 181d7993f92f3f3d ]---
>>


