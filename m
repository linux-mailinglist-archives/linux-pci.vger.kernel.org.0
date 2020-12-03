Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBAC2CDACB
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 17:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbgLCQGj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 11:06:39 -0500
Received: from halon.esss.lu.se ([194.47.240.54]:27345 "EHLO halon.esss.lu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbgLCQGi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 11:06:38 -0500
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2020 11:06:27 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=mime-version:content-transfer-encoding:content-type:message-id:date:subject:
         to:from:from;
        bh=Abvk2McPkqLUXjqc/srJStkMgBq3+e4GJO00bkrEcVw=;
        b=ovIbWJ6m6WF7WUBVXTTAp/eDYmyCb0oxoI4qNr1Yc0rOvVMTUW+Sh5cu1TRppHwsjEw+3irMiwe6H
         INeO/TaXr5ExfJKVOLqPFSkhV2LPu8aa/1DywoMszp48rvu6rqfDC7rOfXs40LibSUaxQ1dAcprqC8
         Jk+QszR2W/dEqZFBuRrCRM66mwYCC1WFtMJG2oNL0AdZLq8T2pd66dlm+kHG5FD3DJHKyDAclItDR7
         fHuiAUrn+KGvyBad/mpBapcXtLAlaZYM8cj0DbBKIJZWoZ1k9h94Pb3NBYmf2qeU1o7RzIi8ORChDP
         JWmcOW0QkhnCip0L7bPj2sVPT7lkwlA==
Received: from mail.esss.lu.se (it-exch16-1.esss.lu.se [10.0.42.131])
        by halon.esss.lu.se (Halon) with ESMTPS
        id 9b8c6a40-3580-11eb-93c8-005056a66d10;
        Thu, 03 Dec 2020 17:00:04 +0100 (CET)
Received: from it-exch16-4.esss.lu.se (10.0.42.134) by it-exch16-1.esss.lu.se
 (10.0.42.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 3 Dec 2020
 17:00:04 +0100
Received: from it-exch16-4.esss.lu.se ([fe80::c5e0:cc1e:47fa:d859]) by
 it-exch16-4.esss.lu.se ([fe80::c5e0:cc1e:47fa:d859%5]) with mapi id
 15.01.2106.003; Thu, 3 Dec 2020 17:00:04 +0100
From:   Hinko Kocevar <Hinko.Kocevar@ess.eu>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Kernel oops while using AER inject
Thread-Topic: Kernel oops while using AER inject
Thread-Index: AQHWyYssMEbbF2p9bUyRB+WQNxKSCA==
Date:   Thu, 3 Dec 2020 16:00:04 +0000
Message-ID: <c4bf0e02cd7d4ec49462245a315f882f@ess.eu>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [194.47.241.248]
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

I'm trying to use AER inject module and the aer-inject tool to trigger AER =
handling on a micro TCA based system. The reason is that I'm seeing this pa=
rticular error appearing every now and then and is reported by the 00:01.0 =
PCI slot; happens to be root PCIe port on the CPU card. The system also con=
tains a MCH with a PEX 8748 PCIe switch that provides PCIe connectivity to =
the regular AMC cards inside the crate. There are 5 AMCs connected in the c=
rate , 4x use sis8300drv and one mrf kernel drivers (messages of those as t=
he recovery is happening are seen below).

lspci output:

00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core Process=
or Host Bridge/DRAM Registers (rev 05)
00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Co=
re Processor PCIe Controller (x16) (rev 05)
00:01.1 PCI bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Co=
re Processor PCIe Controller (x8) (rev 05)
00:02.0 VGA compatible controller: Intel Corporation HD Graphics P630 (rev =
04)
00:08.0 System peripheral: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v=
5 / 6th/7th Gen Core Processor Gaussian Mixture Model
00:14.0 USB controller: Intel Corporation 100 Series/C230 Series Chipset Fa=
mily USB 3.0 xHCI Controller (rev 31)
00:14.2 Signal processing controller: Intel Corporation 100 Series/C230 Ser=
ies Chipset Family Thermal Subsystem (rev 31)
00:15.0 Signal processing controller: Intel Corporation 100 Series/C230 Ser=
ies Chipset Family Serial IO I2C Controller #0 (rev 31)
00:15.1 Signal processing controller: Intel Corporation 100 Series/C230 Ser=
ies Chipset Family Serial IO I2C Controller #1 (rev 31)
00:16.0 Communication controller: Intel Corporation 100 Series/C230 Series =
Chipset Family MEI Controller #1 (rev 31)
00:17.0 SATA controller: Intel Corporation Q170/Q150/B150/H170/H110/Z170/CM=
236 Chipset SATA Controller [AHCI Mode] (rev 31)
00:1c.0 PCI bridge: Intel Corporation 100 Series/C230 Series Chipset Family=
 PCI Express Root Port #1 (rev f1)
00:1c.1 PCI bridge: Intel Corporation 100 Series/C230 Series Chipset Family=
 PCI Express Root Port #2 (rev f1)
00:1c.2 PCI bridge: Intel Corporation 100 Series/C230 Series Chipset Family=
 PCI Express Root Port #3 (rev f1)
00:1c.3 PCI bridge: Intel Corporation 100 Series/C230 Series Chipset Family=
 PCI Express Root Port #4 (rev f1)
00:1f.0 ISA bridge: Intel Corporation CM238 Chipset LPC/eSPI Controller (re=
v 31)
00:1f.2 Memory controller: Intel Corporation 100 Series/C230 Series Chipset=
 Family Power Management Controller (rev 31)
00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
00:1f.4 SMBus: Intel Corporation 100 Series/C230 Series Chipset Family SMBu=
s (rev 31)
01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
01:00.1 System peripheral: PLX Technology, Inc. Device 87d0 (rev ca)
01:00.2 System peripheral: PLX Technology, Inc. Device 87d0 (rev ca)
01:00.3 System peripheral: PLX Technology, Inc. Device 87d0 (rev ca)
01:00.4 System peripheral: PLX Technology, Inc. Device 87d0 (rev ca)
02:01.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
02:02.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
02:08.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
02:09.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
02:0a.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
03:00.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Expr=
ess Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ca)
04:00.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Expr=
ess Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ca)
04:01.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Expr=
ess Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ca)
04:02.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Expr=
ess Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ca)
04:03.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Expr=
ess Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ca)
04:08.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Expr=
ess Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ca)
04:09.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Expr=
ess Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ca)
04:0a.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Expr=
ess Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ca)
04:0b.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Expr=
ess Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ca)
04:10.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Expr=
ess Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ca)
04:11.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Expr=
ess Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ca)
04:12.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI Expr=
ess Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ca)
06:00.0 Signal processing controller: Research Centre Juelich Device 0024
08:00.0 Signal processing controller: Research Centre Juelich Device 0024
09:00.0 Signal processing controller: Research Centre Juelich Device 0024
0b:00.0 Signal processing controller: Research Centre Juelich Device 0024
0e:00.0 Signal processing controller: Xilinx Corporation Device 7011
15:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connect=
ion (rev 03)
16:00.0 Ethernet controller: Intel Corporation I210 Gigabit Backplane Conne=
ction (rev 03)
17:00.0 Ethernet controller: Intel Corporation I210 Gigabit Backplane Conne=
ction (rev 03)
18:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connect=
ion (rev 03)

Note that I had to manually remove following devices to make the recovery r=
eport success:

echo 1 > /sys/bus/pci/devices/0000\:02\:02.0/remove=20
echo 1 > /sys/bus/pci/devices/0000\:02\:08.0/remove=20
echo 1 > /sys/bus/pci/devices/0000\:02\:09.0/remove=20
echo 1 > /sys/bus/pci/devices/0000\:02\:0a.0/remove=20
echo 1 > /sys/bus/pci/devices/0000\:01\:00.1/remove=20
echo 1 > /sys/bus/pci/devices/0000\:01\:00.2/remove=20
echo 1 > /sys/bus/pci/devices/0000\:01\:00.3/remove=20
echo 1 > /sys/bus/pci/devices/0000\:01\:00.4/remove=20

After that, the PCI device tree looks like this:

00:01.0 root_port, "J6B2", slot 1, device present, speed 8GT/s, width x8
 =84=8001:00.0 upstream_port, PLX Technology, Inc. (10b5), device 8725
    =84=8002:01.0 downstream_port, slot 1, device present, power: Off, spee=
d 8GT/s, width x4
       =84=8003:00.0 upstream_port, PLX Technology, Inc. (10b5) PEX 8748 48=
-Lane, 12-Port PCI Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (8748)
          =86=8004:00.0 downstream_port, slot 10, power: Off
          =86=8004:01.0 downstream_port, slot 4, device present, power: Off=
, speed 8GT/s, width x4
          =81  =84=8006:00.0 endpoint, Research Centre Juelich (1796), devi=
ce 0024
          =86=8004:02.0 downstream_port, slot 9, power: Off
          =86=8004:03.0 downstream_port, slot 3, device present, power: Off=
, speed 8GT/s, width x4
          =81  =84=8008:00.0 endpoint, Research Centre Juelich (1796), devi=
ce 0024
          =86=8004:08.0 downstream_port, slot 5, device present, power: Off=
, speed 2.5GT/s, width x4
          =81  =84=8009:00.0 endpoint, current speed 2.5GT/s target speed 8=
GT/s, Research Centre Juelich (1796), device 0024
          =86=8004:09.0 downstream_port, slot 11, power: Off
          =86=8004:0a.0 downstream_port, slot 6, device present, power: Off=
, speed 2.5GT/s, width x4
          =81  =84=800b:00.0 endpoint, current speed 2.5GT/s target speed 8=
GT/s, Research Centre Juelich (1796), device 0024
          =86=8004:0b.0 downstream_port, slot 12, power: Off
          =86=8004:10.0 downstream_port, slot 8, power: Off
          =86=8004:11.0 downstream_port, slot 2, device present, power: Off=
, speed 2.5GT/s, width x1
          =81  =84=800e:00.0 endpoint, Xilinx Corporation (10ee), device 70=
11
          =84=8004:12.0 downstream_port, slot 7, power: Off
00:01.1 root_port, slot 2, device present
00:1c.0 root_port, slot 4, device present, speed 2.5GT/s, width x1
 =84=8015:00.0 endpoint, Intel Corporation (8086) I210 Gigabit Network Conn=
ection (1533)
00:1c.1 root_port, slot 5, device present, speed 2.5GT/s, width x1
 =84=8016:00.0 endpoint, Intel Corporation (8086) I210 Gigabit Backplane Co=
nnection (1537)
00:1c.2 root_port, slot 6, device present, speed 2.5GT/s, width x1
 =84=8017:00.0 endpoint, Intel Corporation (8086) I210 Gigabit Backplane Co=
nnection (1537)
00:1c.3 root_port, "J6B1", slot 7, device present, speed 2.5GT/s, width x1
 =84=8018:00.0 endpoint, Intel Corporation (8086) I210 Gigabit Network Conn=
ection (1533)

Finally, here is the result of the AER recovery taking place upon injecting=
 the fatal uncorrectable error into the 00:01.0 slot.

Dec  3 15:25:30 bd-cpu18 kernel: aer 0000:00:01.0:pcie002: aer_inject: Inje=
cting errors 00000000/00004000 into device 0000:00:01.0
Dec  3 15:25:30 bd-cpu18 kernel: pcieport 0000:00:01.0: AER: Uncorrected (F=
atal) error received: id=3D0008
Dec  3 15:25:30 bd-cpu18 kernel: pcieport 0000:00:01.0: PCIe Bus Error: sev=
erity=3DUncorrected (Fatal), type=3DTransaction Layer, id=3D0008(Requester =
ID)
Dec  3 15:25:30 bd-cpu18 kernel: pcieport 0000:00:01.0:   device [8086:1901=
] error status/mask=3D00004000/00000000
Dec  3 15:25:30 bd-cpu18 kernel: pcieport 0000:00:01.0:    [14] Completion =
Timeout   =20
Dec  3 15:25:30 bd-cpu18 kernel: sis8300 0000:06:00.0: [aer_error_detected]=
 called .. state=3D2
Dec  3 15:25:30 bd-cpu18 kernel: sis8300 0000:08:00.0: [aer_error_detected]=
 called .. state=3D2
Dec  3 15:25:30 bd-cpu18 kernel: sis8300 0000:09:00.0: [aer_error_detected]=
 called .. state=3D2
Dec  3 15:25:30 bd-cpu18 kernel: sis8300 0000:0b:00.0: [aer_error_detected]=
 called .. state=3D2
Dec  3 15:25:30 bd-cpu18 kernel: mrf-pci 0000:0e:00.0: [aer_error_detected]=
 called .. state=3D2
Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:06:00.0: [aer_result_none] ca=
lled..
Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:08:00.0: [aer_result_none] ca=
lled..
Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:09:00.0: [aer_result_none] ca=
lled..
Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:0b:00.0: [aer_result_none] ca=
lled..
Dec  3 15:25:31 bd-cpu18 kernel: mrf-pci 0000:0e:00.0: [aer_result_none] ca=
lled..
Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:06:00.0: [aer_resume] called.=
.
Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:06:00.0: [aer_resume] UC erro=
rs cleared!
Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:08:00.0: [aer_resume] called.=
.
Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:08:00.0: [aer_resume] UC erro=
rs cleared!
Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:09:00.0: [aer_resume] called.=
.
Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:09:00.0: [aer_resume] UC erro=
rs cleared!
Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:0b:00.0: [aer_resume] called.=
.
Dec  3 15:25:31 bd-cpu18 kernel: sis8300 0000:0b:00.0: [aer_resume] UC erro=
rs cleared!
Dec  3 15:25:31 bd-cpu18 kernel: mrf-pci 0000:0e:00.0: [aer_resume] called.=
.
Dec  3 15:25:31 bd-cpu18 kernel: pcieport 0000:00:01.0: AER: Device recover=
y successful
Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:08:00.0: [sis8300_open] avail=
able =3D 1
Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:08:00.0: [sis8300_release] av=
ailable =3D 1, count =3D 0
Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:06:00.0: [sis8300_open] avail=
able =3D 1
Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:06:00.0: [sis8300_release] av=
ailable =3D 1, count =3D 0
Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:09:00.0: [sis8300_open] avail=
able =3D 1
Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:09:00.0: [sis8300_release] av=
ailable =3D 1, count =3D 0
Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:0b:00.0: [sis8300_open] avail=
able =3D 1
Dec  3 15:25:33 bd-cpu18 kernel: sis8300 0000:0b:00.0: [sis8300_release] av=
ailable =3D 1, count =3D 0
Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:08:00.0: [sis8300_open] avail=
able =3D 1
Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:08:00.0: [sis8300_release] av=
ailable =3D 1, count =3D 0
Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:06:00.0: [sis8300_open] avail=
able =3D 1
Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:06:00.0: [sis8300_release] av=
ailable =3D 1, count =3D 0
Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:09:00.0: [sis8300_open] avail=
able =3D 1
Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:09:00.0: [sis8300_release] av=
ailable =3D 1, count =3D 0
Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:0b:00.0: [sis8300_open] avail=
able =3D 1
Dec  3 15:25:34 bd-cpu18 kernel: sis8300 0000:0b:00.0: [sis8300_release] av=
ailable =3D 1, count =3D 0
Dec  3 15:25:47 bd-cpu18 dbus[1266]: [system] Activating service name=3D'or=
g.freedesktop.problems' (using servicehelper)
Dec  3 15:25:47 bd-cpu18 dbus[1266]: [system] Successfully activated servic=
e 'org.freedesktop.problems'

At this point the PCI space reads for the AMCs returns 0xFFFFFFFF.

Below are messages captured after issuing 'echo 1 > /sys/bus/pci/rescan'. A=
fter that the CPU card rebooted by itself.

Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:01:00.1: Max Payload Size set to =
256 (was 128, max 1024)
Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:01:00.2: Max Payload Size set to =
256 (was 128, max 1024)
Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:01:00.3: Max Payload Size set to =
256 (was 128, max 1024)
Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:01:00.4: Max Payload Size set to =
256 (was 128, max 1024)
Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:01:00.0: bridge configuratio=
n invalid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:02:01.0: bridge configuratio=
n invalid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:02:02.0: bridge configuration inv=
alid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:02:08.0: bridge configuration inv=
alid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:02:09.0: bridge configuration inv=
alid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pci 0000:02:0a.0: bridge configuration inv=
alid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:03:00.0: bridge configuratio=
n invalid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:00.0: bridge configuratio=
n invalid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:01.0: bridge configuratio=
n invalid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:02.0: bridge configuratio=
n invalid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:03.0: bridge configuratio=
n invalid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:08.0: bridge configuratio=
n invalid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:09.0: bridge configuratio=
n invalid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:0a.0: bridge configuratio=
n invalid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:0b.0: bridge configuratio=
n invalid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:10.0: bridge configuratio=
n invalid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:11.0: bridge configuratio=
n invalid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: pcieport 0000:04:12.0: bridge configuratio=
n invalid ([bus 00-00]), reconfiguring
Dec  3 15:25:59 bd-cpu18 kernel: BUG: unable to handle kernel NULL pointer =
dereference at           (null)
Dec  3 15:25:59 bd-cpu18 kernel: IP: [<ffffffffc0b182f7>] aer_inj_read_conf=
ig+0x87/0x160 [aer_inject]
Dec  3 15:25:59 bd-cpu18 kernel: PGD 80000001767c4067 PUD 431939067 PMD 0=20
Dec  3 15:25:59 bd-cpu18 kernel: Oops: 0000 [#1] SMP=20
Dec  3 15:25:59 bd-cpu18 kernel: Modules linked in: aer_inject sis8300drv(O=
E) xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable=
_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_co=
nntrack ipt_REJECT nf_reject_ipv4 devlink tun bridge stp llc ebtable_filter=
 ebtables ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror dm_reg=
ion_hash dm_log dm_mod iTCO_wdt iTCO_vendor_support mei_wdt intel_wmi_thund=
erbolt intel_pmc_core snd_hda_codec_hdmi intel_powerclamp coretemp intel_ra=
pl kvm_intel snd_hda_intel snd_hda_codec kvm snd_hda_core irqbypass crc32_p=
clmul snd_hwdep ghash_clmulni_intel snd_seq snd_seq_device aesni_intel lrw =
gf128mul snd_pcm glue_helper ablk_helper cryptd pcspkr snd_timer snd i2c_i8=
01 soundcore sg i2c_designware_platform i2c_designware_core mei_me mei ie31=
200_edac
Dec  3 15:25:59 bd-cpu18 kernel: wmi pinctrl_sunrisepoint pinctrl_intel tpm=
_crb acpi_pad ip_tables xfs libcrc32c sd_mod crc_t10dif crct10dif_generic i=
915 iosf_mbi drm_kms_helper ahci syscopyarea sysfillrect sysimgblt fb_sys_f=
ops crct10dif_pclmul igb libahci crct10dif_common crc32c_intel drm libata s=
erio_raw ptp pps_core dca i2c_algo_bit drm_panel_orientation_quirks mrf(OE)=
 parport uio i2c_hid video [last unloaded: sis8300drv]
Dec  3 15:25:59 bd-cpu18 kernel: CPU: 4 PID: 8150 Comm: bash Kdump: loaded =
Tainted: G           OE  ------------   3.10.0-1160.6.1.el7.x86_64.debug #1
Dec  3 15:25:59 bd-cpu18 kernel: Hardware name: AMI AM G6x/msd/AM G6x/msd, =
BIOS 4.08.01 02/19/2019
Dec  3 15:25:59 bd-cpu18 kernel: task: ffff9b22b5f88000 ti: ffff9b22b5bc400=
0 task.ti: ffff9b22b5bc4000
Dec  3 15:25:59 bd-cpu18 kernel: RIP: 0010:[<ffffffffc0b182f7>]  [<ffffffff=
c0b182f7>] aer_inj_read_config+0x87/0x160 [aer_inject]
Dec  3 15:25:59 bd-cpu18 kernel: RSP: 0018:ffff9b22b5bc7a30  EFLAGS: 000100=
46
Dec  3 15:25:59 bd-cpu18 kernel: RAX: 0000000000000000 RBX: 000000000000000=
0 RCX: 0000000000000004
Dec  3 15:25:59 bd-cpu18 kernel: RDX: 0000000000000000 RSI: 000000000000000=
0 RDI: ffff9b25718ab000
Dec  3 15:25:59 bd-cpu18 kernel: RBP: ffff9b22b5bc7a68 R08: ffff9b22b5bc7a8=
4 R09: ffffffffc0b1a0b0
Dec  3 15:25:59 bd-cpu18 kernel: R10: 0000000000000001 R11: 69c1fefdd26da26=
d R12: 0000000000000000
Dec  3 15:25:59 bd-cpu18 kernel: R13: ffffffffc0b1a050 R14: ffff9b22b5bc7a8=
4 R15: ffff9b25718ab000
Dec  3 15:25:59 bd-cpu18 kernel: FS:  00007f3d00e8b740(0000) GS:ffff9b259ce=
00000(0000) knlGS:0000000000000000
Dec  3 15:25:59 bd-cpu18 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
Dec  3 15:25:59 bd-cpu18 kernel: CR2: 0000000000000000 CR3: 000000017579600=
0 CR4: 00000000003607e0
Dec  3 15:25:59 bd-cpu18 kernel: DR0: 0000000000000000 DR1: 000000000000000=
0 DR2: 0000000000000000
Dec  3 15:25:59 bd-cpu18 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff=
0 DR7: 0000000000000400
Dec  3 15:25:59 bd-cpu18 kernel: Call Trace:
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c61a9c>] pci_bus_read_config_d=
word+0x8c/0xb0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c63a68>] pci_bus_read_dev_vend=
or_id+0x28/0xe0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65e04>] pci_scan_single_devic=
e+0x74/0xf0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65eba>] pci_scan_slot+0x3a/0x=
140
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c6711d>] pci_scan_child_bus_ex=
tend+0x4d/0x2f0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c62bcb>] ? pci_bus_write_confi=
g_dword+0x6b/0x80
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c66f4b>] pci_scan_bridge_exten=
d+0x47b/0x5e0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65e04>] ? pci_scan_single_dev=
ice+0x74/0xf0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c67286>] pci_scan_child_bus_ex=
tend+0x1b6/0x2f0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c66f4b>] pci_scan_bridge_exten=
d+0x47b/0x5e0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c67286>] pci_scan_child_bus_ex=
tend+0x1b6/0x2f0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c673d0>] pci_scan_child_bus+0x=
10/0x20
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c66f01>] pci_scan_bridge_exten=
d+0x431/0x5e0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65e04>] ? pci_scan_single_dev=
ice+0x74/0xf0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c671e7>] pci_scan_child_bus_ex=
tend+0x117/0x2f0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c674b6>] pci_rescan_bus+0x16/0=
x40
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c70d78>] bus_rescan_store+0x78=
/0xa0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2d56909>] bus_attr_store+0x29/0=
x30
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2b5272a>] sysfs_kf_write+0x4a/0=
x60
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2b51ff6>] kernfs_fop_write+0x10=
6/0x190
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2aaf3fc>] vfs_write+0xdc/0x240
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2ad5984>] ? fget_light+0x3c4/0x=
550
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2ab029a>] SyS_write+0x8a/0x100
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa3098b12>] system_call_fastpath+=
0x25/0x2a
Dec  3 15:25:59 bd-cpu18 kernel: Code: 81 f9 b0 a0 b1 c0 74 5c 4d 3b 79 10 =
75 ee 49 8b 41 18 4d 8b af b8 00 00 00 89 de 49 89 87 b8 00 00 00 4d 89 f0 =
44 89 e2 4c 89 ff <48> 8b 00 e8 41 f3 10 e2 48 8b 75 d0 89 c3 4d 89 af b8 0=
0 00 00=20
Dec  3 15:25:59 bd-cpu18 libvirtd: 2020-12-03 14:25:59.711+0000: 2132: info=
 : libvirt version: 4.5.0, package: 23.el7_7.6 (CentOS BuildSystem <http://=
bugs.centos.org>, 2020-03-17-23:39:10, x86-01.bsys.centos.org)
Dec  3 15:25:59 bd-cpu18 libvirtd: 2020-12-03 14:25:59.711+0000: 2132: info=
 : hostname: bd-cpu18.cslab.esss.lu.se
Dec  3 15:25:59 bd-cpu18 libvirtd: 2020-12-03 14:25:59.711+0000: 2132: erro=
r : virPCIDeviceNew:1784 : Device 0000:01:00.1 not found: could not access =
/sys/bus/pci/devices/0000:01:00.1/config: No such file or directory
Dec  3 15:25:59 bd-cpu18 libvirtd: 2020-12-03 14:25:59.713+0000: 2132: erro=
r : virPCIDeviceNew:1784 : Device 0000:01:00.2 not found: could not access =
/sys/bus/pci/devices/0000:01:00.2/config: No such file or directory
Dec  3 15:25:59 bd-cpu18 libvirtd: 2020-12-03 14:25:59.714+0000: 2132: erro=
r : virPCIDeviceNew:1784 : Device 0000:01:00.3 not found: could not access =
/sys/bus/pci/devices/0000:01:00.3/config: No such file or directory
Dec  3 15:25:59 bd-cpu18 libvirtd: 2020-12-03 14:25:59.714+0000: 2132: erro=
r : virPCIDeviceNew:1784 : Device 0000:01:00.4 not found: could not access =
/sys/bus/pci/devices/0000:01:00.4/config: No such file or directory
Dec  3 15:25:59 bd-cpu18 libvirtd: 2020-12-03 14:25:59.715+0000: 2132: erro=
r : virPCIDeviceNew:1784 : Device 0000:02:02.0 not found: could not access =
/sys/bus/pci/devices/0000:02:02.0/config: No such file or directory
Dec  3 15:25:59 bd-cpu18 libvirtd: 2020-12-03 14:25:59.715+0000: 2132: erro=
r : virPCIDeviceNew:1784 : Device 0000:02:09.0 not found: could not access =
/sys/bus/pci/devices/0000:02:09.0/config: No such file or directory
Dec  3 15:25:59 bd-cpu18 libvirtd: 2020-12-03 14:25:59.715+0000: 2132: erro=
r : virPCIDeviceNew:1784 : Device 0000:02:08.0 not found: could not access =
/sys/bus/pci/devices/0000:02:08.0/config: No such file or directory
Dec  3 15:25:59 bd-cpu18 libvirtd: 2020-12-03 14:25:59.716+0000: 2132: erro=
r : virPCIDeviceNew:1784 : Device 0000:02:0a.0 not found: could not access =
/sys/bus/pci/devices/0000:02:0a.0/config: No such file or directory
Dec  3 15:25:59 bd-cpu18 kernel: RIP  [<ffffffffc0b182f7>] aer_inj_read_con=
fig+0x87/0x160 [aer_inject]
Dec  3 15:25:59 bd-cpu18 kernel: RSP <ffff9b22b5bc7a30>
Dec  3 15:25:59 bd-cpu18 kernel: CR2: 0000000000000000
Dec  3 15:25:59 bd-cpu18 kernel: ---[ end trace 452aceb2952fc499 ]---
Dec  3 15:25:59 bd-cpu18 kernel: BUG: sleeping function called from invalid=
 context at kernel/rwsem.c:21
Dec  3 15:25:59 bd-cpu18 kernel: in_atomic(): 1, irqs_disabled(): 1, pid: 8=
150, name: bash
Dec  3 15:25:59 bd-cpu18 kernel: INFO: lockdep is turned off.
Dec  3 15:25:59 bd-cpu18 kernel: irq event stamp: 87980
Dec  3 15:25:59 bd-cpu18 kernel: hardirqs last  enabled at (87979): [<fffff=
fffa308bcd6>] _raw_spin_unlock_irqrestore+0x36/0x70
Dec  3 15:25:59 bd-cpu18 kernel: hardirqs last disabled at (87980): [<fffff=
fffa308c55b>] _raw_spin_lock_irqsave+0x2b/0xa0
Dec  3 15:25:59 bd-cpu18 kernel: softirqs last  enabled at (87300): [<fffff=
fffa28ba134>] __do_softirq+0x1a4/0x470
Dec  3 15:25:59 bd-cpu18 kernel: softirqs last disabled at (87281): [<fffff=
fffa309c2bc>] call_softirq+0x1c/0x30
Dec  3 15:25:59 bd-cpu18 kernel: CPU: 4 PID: 8150 Comm: bash Kdump: loaded =
Tainted: G      D    OE  ------------   3.10.0-1160.6.1.el7.x86_64.debug #1
Dec  3 15:25:59 bd-cpu18 kernel: Hardware name: AMI AM G6x/msd/AM G6x/msd, =
BIOS 4.08.01 02/19/2019
Dec  3 15:25:59 bd-cpu18 kernel: Call Trace:
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa3080c37>] dump_stack+0x19/0x1b
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa28f500b>] __might_sleep+0x17b/0=
x240
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa3087aba>] down_read+0x2a/0xb0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa28ccad3>] exit_signals+0x33/0x1=
50
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa28b5f6c>] do_exit+0xcc/0xb80
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa28b2390>] ? kmsg_dump+0x130/0x1=
d0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa28b2294>] ? kmsg_dump+0x34/0x1d=
0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa308f910>] oops_end+0xa0/0xe0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa28836a4>] no_context+0x144/0x31=
0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa293eac3>] ? __bfs+0x103/0x280
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa288398a>] __bad_area_nosemaphor=
e+0x11a/0x230
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2883ab4>] bad_area_nosemaphore+=
0x14/0x20
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa3092ce8>] __do_page_fault+0x358=
/0x5a0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2944229>] ? __lock_acquire+0xa4=
9/0x1630
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa3092f65>] do_page_fault+0x35/0x=
90
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa308e818>] page_fault+0x28/0x30
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffc0b182f7>] ? aer_inj_read_config=
+0x87/0x160 [aer_inject]
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c61a9c>] pci_bus_read_config_d=
word+0x8c/0xb0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c63a68>] pci_bus_read_dev_vend=
or_id+0x28/0xe0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65e04>] pci_scan_single_devic=
e+0x74/0xf0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65eba>] pci_scan_slot+0x3a/0x=
140
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c6711d>] pci_scan_child_bus_ex=
tend+0x4d/0x2f0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c62bcb>] ? pci_bus_write_confi=
g_dword+0x6b/0x80
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c66f4b>] pci_scan_bridge_exten=
d+0x47b/0x5e0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65e04>] ? pci_scan_single_dev=
ice+0x74/0xf0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c67286>] pci_scan_child_bus_ex=
tend+0x1b6/0x2f0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c66f4b>] pci_scan_bridge_exten=
d+0x47b/0x5e0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c67286>] pci_scan_child_bus_ex=
tend+0x1b6/0x2f0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c673d0>] pci_scan_child_bus+0x=
10/0x20
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c66f01>] pci_scan_bridge_exten=
d+0x431/0x5e0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65e04>] ? pci_scan_single_dev=
ice+0x74/0xf0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c671e7>] pci_scan_child_bus_ex=
tend+0x117/0x2f0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c674b6>] pci_rescan_bus+0x16/0=
x40
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c70d78>] bus_rescan_store+0x78=
/0xa0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2d56909>] bus_attr_store+0x29/0=
x30
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2b5272a>] sysfs_kf_write+0x4a/0=
x60
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2b51ff6>] kernfs_fop_write+0x10=
6/0x190
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2aaf3fc>] vfs_write+0xdc/0x240
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2ad5984>] ? fget_light+0x3c4/0x=
550
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2ab029a>] SyS_write+0x8a/0x100
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa3098b12>] system_call_fastpath+=
0x25/0x2a
Dec  3 15:25:59 bd-cpu18 kernel: BUG: scheduling while atomic: bash/8150/0x=
10000003
Dec  3 15:25:59 bd-cpu18 kernel: INFO: lockdep is turned off.
Dec  3 15:25:59 bd-cpu18 kernel: Modules linked in: aer_inject sis8300drv(O=
E) xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable=
_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_co=
nntrack ipt_REJECT nf_reject_ipv4 devlink tun bridge stp llc ebtable_filter=
 ebtables ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror dm_reg=
ion_hash dm_log dm_mod iTCO_wdt iTCO_vendor_support mei_wdt intel_wmi_thund=
erbolt intel_pmc_core snd_hda_codec_hdmi intel_powerclamp coretemp intel_ra=
pl kvm_intel snd_hda_intel snd_hda_codec kvm snd_hda_core irqbypass crc32_p=
clmul snd_hwdep ghash_clmulni_intel snd_seq snd_seq_device aesni_intel lrw =
gf128mul snd_pcm glue_helper ablk_helper cryptd pcspkr snd_timer snd i2c_i8=
01 soundcore sg i2c_designware_platform i2c_designware_core mei_me mei ie31=
200_edac
Dec  3 15:25:59 bd-cpu18 kernel: wmi pinctrl_sunrisepoint pinctrl_intel tpm=
_crb acpi_pad ip_tables xfs libcrc32c sd_mod crc_t10dif crct10dif_generic i=
915 iosf_mbi drm_kms_helper ahci syscopyarea sysfillrect sysimgblt fb_sys_f=
ops crct10dif_pclmul igb libahci crct10dif_common crc32c_intel drm libata s=
erio_raw ptp pps_core dca i2c_algo_bit drm_panel_orientation_quirks mrf(OE)=
 parport uio i2c_hid video [last unloaded: sis8300drv]
Dec  3 15:25:59 bd-cpu18 kernel: irq event stamp: 87980
Dec  3 15:25:59 bd-cpu18 kernel: hardirqs last  enabled at (87979): [<fffff=
fffa308bcd6>] _raw_spin_unlock_irqrestore+0x36/0x70
Dec  3 15:25:59 bd-cpu18 kernel: hardirqs last disabled at (87980): [<fffff=
fffa308c55b>] _raw_spin_lock_irqsave+0x2b/0xa0
Dec  3 15:25:59 bd-cpu18 kernel: softirqs last  enabled at (87300): [<fffff=
fffa28ba134>] __do_softirq+0x1a4/0x470
Dec  3 15:25:59 bd-cpu18 kernel: softirqs last disabled at (87281): [<fffff=
fffa309c2bc>] call_softirq+0x1c/0x30
Dec  3 15:25:59 bd-cpu18 kernel: CPU: 4 PID: 8150 Comm: bash Kdump: loaded =
Tainted: G      D    OE  ------------   3.10.0-1160.6.1.el7.x86_64.debug #1
Dec  3 15:25:59 bd-cpu18 kernel: Hardware name: AMI AM G6x/msd/AM G6x/msd, =
BIOS 4.08.01 02/19/2019
Dec  3 15:25:59 bd-cpu18 kernel: Call Trace:
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa3080c37>] dump_stack+0x19/0x1b
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa3078933>] __schedule_bug+0x7d/0=
x8c
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa30887ec>] __schedule+0x7cc/0x81=
0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa28f98e6>] __cond_resched+0x26/0=
x30
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa3088b7a>] _cond_resched+0x3a/0x=
50
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa3087abf>] down_read+0x2f/0xb0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa28ccad3>] exit_signals+0x33/0x1=
50
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa28b5f6c>] do_exit+0xcc/0xb80
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa28b2390>] ? kmsg_dump+0x130/0x1=
d0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa28b2294>] ? kmsg_dump+0x34/0x1d=
0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa308f910>] oops_end+0xa0/0xe0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa28836a4>] no_context+0x144/0x31=
0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa293eac3>] ? __bfs+0x103/0x280
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa288398a>] __bad_area_nosemaphor=
e+0x11a/0x230
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2883ab4>] bad_area_nosemaphore+=
0x14/0x20
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa3092ce8>] __do_page_fault+0x358=
/0x5a0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2944229>] ? __lock_acquire+0xa4=
9/0x1630
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa3092f65>] do_page_fault+0x35/0x=
90
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa308e818>] page_fault+0x28/0x30
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffc0b182f7>] ? aer_inj_read_config=
+0x87/0x160 [aer_inject]
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c61a9c>] pci_bus_read_config_d=
word+0x8c/0xb0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c63a68>] pci_bus_read_dev_vend=
or_id+0x28/0xe0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65e04>] pci_scan_single_devic=
e+0x74/0xf0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65eba>] pci_scan_slot+0x3a/0x=
140
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c6711d>] pci_scan_child_bus_ex=
tend+0x4d/0x2f0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c62bcb>] ? pci_bus_write_confi=
g_dword+0x6b/0x80
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c66f4b>] pci_scan_bridge_exten=
d+0x47b/0x5e0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65e04>] ? pci_scan_single_dev=
ice+0x74/0xf0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c67286>] pci_scan_child_bus_ex=
tend+0x1b6/0x2f0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c66f4b>] pci_scan_bridge_exten=
d+0x47b/0x5e0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c67286>] pci_scan_child_bus_ex=
tend+0x1b6/0x2f0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c673d0>] pci_scan_child_bus+0x=
10/0x20
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c66f01>] pci_scan_bridge_exten=
d+0x431/0x5e0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c65e04>] ? pci_scan_single_dev=
ice+0x74/0xf0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c671e7>] pci_scan_child_bus_ex=
tend+0x117/0x2f0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c674b6>] pci_rescan_bus+0x16/0=
x40
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2c70d78>] bus_rescan_store+0x78=
/0xa0
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2d56909>] bus_attr_store+0x29/0=
x30
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2b5272a>] sysfs_kf_write+0x4a/0=
x60
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2b51ff6>] kernfs_fop_write+0x10=
6/0x190
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2aaf3fc>] vfs_write+0xdc/0x240
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2ad5984>] ? fget_light+0x3c4/0x=
550
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa2ab029a>] SyS_write+0x8a/0x100
Dec  3 15:25:59 bd-cpu18 kernel: [<ffffffffa3098b12>] system_call_fastpath+=
0x25/0x2a
Dec  3 15:25:59 bd-cpu18 kernel: note: bash[8150] exited with preempt_count=
 2
Dec  3 15:26:00 bd-cpu18 sh: abrt-dump-oops: Found oopses: 2
Dec  3 15:26:00 bd-cpu18 sh: abrt-dump-oops: Creating problem directories
Dec  3 15:26:00 bd-cpu18 sh: abrt-dump-oops: Not going to make dump directo=
ries world readable because PrivateReports is on
Dec  3 15:26:01 bd-cpu18 abrt-server: '/var/spool/abrt/oops-2020-12-03-14:4=
2:51-4266-0' is not a problem directory
Dec  3 15:26:01 bd-cpu18 abrt-server: '/var/spool/abrt/oops-2020-12-03-14:4=
2:51-4266-0' is not a problem directory
Dec  3 15:26:02 bd-cpu18 abrt-server: '/var/spool/abrt/oops-2020-12-03-14:4=
2:51-4266-0' is not a problem directory
Dec  3 15:26:02 bd-cpu18 abrt-server: '/var/spool/abrt/oops-2020-12-03-14:4=
2:51-4266-0' is not a problem directory
Dec  3 15:26:02 bd-cpu18 abrt-server: Looking for kernel package
Dec  3 15:26:02 bd-cpu18 abrt-dump-oops: Reported 2 kernel oopses to Abrt
Dec  3 15:26:02 bd-cpu18 abrt-server: Kernel package kernel-debug-3.10.0-11=
60.6.1.el7.x86_64 found
Dec  3 15:26:04 bd-cpu18 abrt-server: '/var/spool/abrt/oops-2020-12-03-14:4=
2:51-4266-0' is not a problem directory
Dec  3 15:26:04 bd-cpu18 abrt-server: Email address of sender was not speci=
fied. Would you like to do so now? If not, 'user@localhost' is to be used [=
y/N]=20
Dec  3 15:26:04 bd-cpu18 abrt-server: Email address of receiver was not spe=
cified. Would you like to do so now? If not, 'root@localhost' is to be used=
 [y/N]=20
Dec  3 15:26:04 bd-cpu18 abrt-server: Sending an email...
Dec  3 15:26:04 bd-cpu18 abrt-server: Sending a notification email to: root=
@localhost
Dec  3 15:26:04 bd-cpu18 abrt-server: Email was sent to: root@localhost
Dec  3 15:26:05 bd-cpu18 abrt-server: '/var/spool/abrt/oops-2020-12-03-14:4=
2:51-4266-0' is not a problem directory
Dec  3 15:26:05 bd-cpu18 abrt-server: '/var/spool/abrt/oops-2020-12-03-14:4=
2:51-4266-0' is not a problem directory
Dec  3 15:26:05 bd-cpu18 abrt-server: '/var/spool/abrt/oops-2020-12-03-14:4=
2:51-4266-0' is not a problem directory
Dec  3 15:26:06 bd-cpu18 abrt-server: '/var/spool/abrt/oops-2020-12-03-14:4=
2:51-4266-0' is not a problem directory
Dec  3 15:26:06 bd-cpu18 abrt-server: Looking for kernel package
Dec  3 15:26:06 bd-cpu18 abrt-server: Kernel package kernel-debug-3.10.0-11=
60.6.1.el7.x86_64 found
Dec  3 15:26:07 bd-cpu18 rtkit-daemon[1338]: The canary thread is apparentl=
y starving. Taking action.
Dec  3 15:26:07 bd-cpu18 rtkit-daemon[1338]: Demoting known real-time threa=
ds.
Dec  3 15:26:07 bd-cpu18 rtkit-daemon[1338]: Successfully demoted thread 25=
94 of process 2591 (/usr/bin/pulseaudio).
Dec  3 15:26:07 bd-cpu18 rtkit-daemon[1338]: Successfully demoted thread 25=
91 of process 2591 (/usr/bin/pulseaudio).
Dec  3 15:26:07 bd-cpu18 rtkit-daemon[1338]: Demoted 2 threads.
Dec  3 15:26:08 bd-cpu18 abrt-server: '/var/spool/abrt/oops-2020-12-03-14:4=
2:51-4266-0' is not a problem directory
Dec  3 15:26:08 bd-cpu18 abrt-server: Email address of sender was not speci=
fied. Would you like to do so now? If not, 'user@localhost' is to be used [=
y/N]=20
Dec  3 15:26:08 bd-cpu18 abrt-server: Email address of receiver was not spe=
cified. Would you like to do so now? If not, 'root@localhost' is to be used=
 [y/N]=20
Dec  3 15:26:08 bd-cpu18 abrt-server: Sending an email...
Dec  3 15:26:08 bd-cpu18 abrt-server: Sending a notification email to: root=
@localhost


I guess this is the root cause of oops:

Dec  3 15:25:59 bd-cpu18 kernel: BUG: unable to handle kernel NULL pointer =
dereference at           (null)
Dec  3 15:25:59 bd-cpu18 kernel: IP: [<ffffffffc0b182f7>] aer_inj_read_conf=
ig+0x87/0x160 [aer_inject]

Looking at the actual source code of the running kernel this is the source =
of the offending  aer_inj_read_config():


static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
			       int where, int size, u32 *val)
{
	u32 *sim;
	struct aer_error *err;
	unsigned long flags;
	struct pci_ops *ops;
	struct pci_ops *my_ops;
	int domain;
	int rv;

	spin_lock_irqsave(&inject_lock, flags);
	if (size !=3D sizeof(u32))
		goto out;
	domain =3D pci_domain_nr(bus);
	if (domain < 0)
		goto out;
	err =3D __find_aer_error(domain, bus->number, devfn);
	if (!err)
		goto out;

	sim =3D find_pci_config_dword(err, where, NULL);
	if (sim) {
		*val =3D *sim;
		spin_unlock_irqrestore(&inject_lock, flags);
		return 0;
	}
out:
	ops =3D __find_pci_bus_ops(bus);
	/*
	 * pci_lock must already be held, so we can directly
	 * manipulate bus->ops.  Many config access functions,
	 * including pci_generic_config_read() require the original
	 * bus->ops be installed to function, so temporarily put them
	 * back.
	 */
	my_ops =3D bus->ops;
	bus->ops =3D ops;
	rv =3D ops->read(bus, devfn, where, size, val);
	bus->ops =3D my_ops;
	spin_unlock_irqrestore(&inject_lock, flags);
	return rv;
}


Here is 'objdump -D aer_inject.ko':

0000000000000270 <aer_inj_read_config>:
 270:   e8 00 00 00 00          callq  275 <aer_inj_read_config+0x5>
 275:   55                      push   %rbp
 276:   48 89 e5                mov    %rsp,%rbp
 279:   41 57                   push   %r15
 27b:   49 89 ff                mov    %rdi,%r15
 27e:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 285:   41 56                   push   %r14
 287:   4d 89 c6                mov    %r8,%r14
 28a:   41 55                   push   %r13
 28c:   41 54                   push   %r12
 28e:   41 89 d4                mov    %edx,%r12d
 291:   53                      push   %rbx
 292:   89 f3                   mov    %esi,%ebx
 294:   48 83 ec 10             sub    $0x10,%rsp
 298:   89 4d cc                mov    %ecx,-0x34(%rbp)
 29b:   e8 00 00 00 00          callq  2a0 <aer_inj_read_config+0x30>
 2a0:   8b 4d cc                mov    -0x34(%rbp),%ecx
 2a3:   48 89 45 d0             mov    %rax,-0x30(%rbp)
 2a7:   83 f9 04                cmp    $0x4,%ecx
 2aa:   0f 84 88 00 00 00       je     338 <aer_inj_read_config+0xc8>
 2b0:   4c 8b 0d 00 00 00 00    mov    0x0(%rip),%r9        # 2b7 <aer_inj_=
read_config+0x47>
 2b7:   49 81 f9 00 00 00 00    cmp    $0x0,%r9
 2be:   75 14                   jne    2d4 <aer_inj_read_config+0x64>
 2c0:   eb 6e                   jmp    330 <aer_inj_read_config+0xc0>
 2c2:   66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
 2c8:   4d 8b 09                mov    (%r9),%r9
 2cb:   49 81 f9 00 00 00 00    cmp    $0x0,%r9
 2d2:   74 5c                   je     330 <aer_inj_read_config+0xc0>
 2d4:   4d 3b 79 10             cmp    0x10(%r9),%r15
 2d8:   75 ee                   jne    2c8 <aer_inj_read_config+0x58>
 2da:   49 8b 41 18             mov    0x18(%r9),%rax
 2de:   4d 8b af b8 00 00 00    mov    0xb8(%r15),%r13
 2e5:   89 de                   mov    %ebx,%esi
 2e7:   49 89 87 b8 00 00 00    mov    %rax,0xb8(%r15)
 2ee:   4d 89 f0                mov    %r14,%r8
 2f1:   44 89 e2                mov    %r12d,%edx
 2f4:   4c 89 ff                mov    %r15,%rdi
 2f7:   48 8b 00                mov    (%rax),%rax
 2fa:   e8 00 00 00 00          callq  2ff <aer_inj_read_config+0x8f>
 2ff:   48 8b 75 d0             mov    -0x30(%rbp),%rsi
 303:   89 c3                   mov    %eax,%ebx
 305:   4d 89 af b8 00 00 00    mov    %r13,0xb8(%r15)
 30c:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 313:   e8 00 00 00 00          callq  318 <aer_inj_read_config+0xa8>
 318:   89 d8                   mov    %ebx,%eax
 31a:   48 83 c4 10             add    $0x10,%rsp
 31e:   5b                      pop    %rbx
 31f:   41 5c                   pop    %r12
 321:   41 5d                   pop    %r13
 323:   41 5e                   pop    %r14
 325:   41 5f                   pop    %r15
 327:   5d                      pop    %rbp
 328:   c3                      retq  =20
 329:   0f 1f 80 00 00 00 00    nopl   0x0(%rax)
 330:   31 c0                   xor    %eax,%eax
 332:   eb aa                   jmp    2de <aer_inj_read_config+0x6e>
 334:   0f 1f 40 00             nopl   0x0(%rax)
 338:   49 8b 87 c8 00 00 00    mov    0xc8(%r15),%rax
 33f:   8b 00                   mov    (%rax),%eax
 341:   85 c0                   test   %eax,%eax
 343:   0f 88 67 ff ff ff       js     2b0 <aer_inj_read_config+0x40>
 349:   48 8b 3d 00 00 00 00    mov    0x0(%rip),%rdi        # 350 <aer_inj=
_read_config+0xe0>
 350:   41 0f b6 97 d8 00 00    movzbl 0xd8(%r15),%edx
 357:   00=20
 358:   48 81 ff 00 00 00 00    cmp    $0x0,%rdi
 35f:   0f 84 4b ff ff ff       je     2b0 <aer_inj_read_config+0x40>
 365:   3b 47 10                cmp    0x10(%rdi),%eax
 368:   74 1b                   je     385 <aer_inj_read_config+0x115>
 36a:   66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
 370:   48 8b 3f                mov    (%rdi),%rdi
 373:   48 81 ff 00 00 00 00    cmp    $0x0,%rdi
 37a:   0f 84 30 ff ff ff       je     2b0 <aer_inj_read_config+0x40>
 380:   3b 47 10                cmp    0x10(%rdi),%eax
 383:   75 eb                   jne    370 <aer_inj_read_config+0x100>
 385:   3b 57 14                cmp    0x14(%rdi),%edx
 388:   75 e6                   jne    370 <aer_inj_read_config+0x100>
 38a:   3b 5f 18                cmp    0x18(%rdi),%ebx
 38d:   75 e1                   jne    370 <aer_inj_read_config+0x100>
 38f:   48 85 ff                test   %rdi,%rdi
 392:   0f 84 18 ff ff ff       je     2b0 <aer_inj_read_config+0x40>
 398:   31 d2                   xor    %edx,%edx
 39a:   44 89 e6                mov    %r12d,%esi
 39d:   89 4d cc                mov    %ecx,-0x34(%rbp)
 3a0:   e8 5b fc ff ff          callq  0 <find_pci_config_dword>
 3a5:   48 85 c0                test   %rax,%rax
 3a8:   8b 4d cc                mov    -0x34(%rbp),%ecx
 3ab:   0f 84 ff fe ff ff       je     2b0 <aer_inj_read_config+0x40>
 3b1:   8b 00                   mov    (%rax),%eax
 3b3:   48 8b 75 d0             mov    -0x30(%rbp),%rsi
 3b7:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 3be:   41 89 06                mov    %eax,(%r14)
 3c1:   e8 00 00 00 00          callq  3c6 <aer_inj_read_config+0x156>
 3c6:   31 c0                   xor    %eax,%eax
 3c8:   e9 4d ff ff ff          jmpq   31a <aer_inj_read_config+0xaa>
 3cd:   0f 1f 00                nopl   (%rax)




Thank you!

