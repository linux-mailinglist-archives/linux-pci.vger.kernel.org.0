Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C11874EC
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 22:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbgCPVnT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 17:43:19 -0400
Received: from newsaf.bio.caltech.edu ([131.215.12.41]:36748 "EHLO
        saf.bio.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732731AbgCPVnT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 17:43:19 -0400
X-Greylist: delayed 1933 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 17:43:17 EDT
Received: from apache by saf.bio.caltech.edu with local (Exim 4.92.3)
        (envelope-from <apache@saf.bio.caltech.edu>)
        id 1jDx0p-0005aW-Rx
        for linux-pci@vger.kernel.org; Mon, 16 Mar 2020 14:11:03 -0700
To:     linux-pci@vger.kernel.org
Subject: lspci shpchp and /sys vs /lib/modules questions
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_3b128d48692a74d4fd51ecdf54a84cd2"
Date:   Mon, 16 Mar 2020 14:11:03 -0700
From:   David Mathog <mathog@caltech.edu>
Reply-To: mathog@caltech.edu
Mail-Reply-To: mathog@caltech.edu
In-Reply-To: <a3d09c2b013e08d7d0eaa3799a00593f@saf.bio.caltech.edu>
References: <a3d09c2b013e08d7d0eaa3799a00593f@saf.bio.caltech.edu>
Message-ID: <50c91fec35004aa29a7553f255214531@saf.bio.caltech.edu>
X-Sender: mathog@caltech.edu
User-Agent: Roundcube Webmail/1.1.12
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--=_3b128d48692a74d4fd51ecdf54a84cd2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

(Apologies to "mj" for duplicate send, the mailing list subscription was 
finally sorted out.)

The attached perl script tries to use lspci -n and the information in 
/sys/devices and /lib/modules/$kernel/modules.alias to describe the PCI 
devices on the system. I'm trying to make it tease out what drivers are 
built in (from /sys/devices) and which are loaded as modules (from 
/lib/modules). While overall this resembles the output of "lspci -k" 
there are a few differences I cannot explain yet.

On an old IBM server the outputs are:

lspci -k
00:01.0 PCI bridge: Broadcom BCM5785 [HT1000] PCI/PCI-X Bridge
         Kernel modules: shpchp
00:02.0 Host bridge: Broadcom BCM5785 [HT1000] Legacy South Bridge
         Subsystem: IBM BCM5785 [HT1000] Legacy South Bridge
         Kernel driver in use: piix4_smbus
         Kernel modules: i2c_piix4
00:02.1 IDE interface: Broadcom BCM5785 [HT1000] IDE
         Subsystem: IBM BCM5785 [HT1000] IDE
         Kernel driver in use: pata_serverworks
         Kernel modules: pata_serverworks, pata_acpi
00:02.2 ISA bridge: Broadcom BCM5785 [HT1000] LPC
         Subsystem: IBM BCM5785 [HT1000] LPC
00:03.0 USB controller: Broadcom BCM5785 [HT1000] USB (rev 01)
         Subsystem: IBM BCM5785 [HT1000] USB
         Kernel driver in use: ohci-pci
00:03.1 USB controller: Broadcom BCM5785 [HT1000] USB (rev 01)
         Subsystem: IBM BCM5785 [HT1000] USB
         Kernel driver in use: ohci-pci
00:03.2 USB controller: Broadcom BCM5785 [HT1000] USB (rev 01)
         Subsystem: IBM BCM5785 [HT1000] USB
         Kernel driver in use: ehci-pci
00:05.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] ES1000 (rev 02)
         Subsystem: IBM ES1000
         Kernel driver in use: radeon
         Kernel modules: radeonfb, radeon
00:06.0 PCI bridge: Broadcom HT2100 PCI-Express Bridge (rev a2)
         Kernel driver in use: pcieport
         Kernel modules: shpchp
00:07.0 PCI bridge: Broadcom HT2100 PCI-Express Bridge (rev a2)
         Kernel driver in use: pcieport
         Kernel modules: shpchp
00:08.0 PCI bridge: Broadcom HT2100 PCI-Express Bridge (rev a2)
         Kernel driver in use: pcieport
         Kernel modules: shpchp
00:09.0 PCI bridge: Broadcom HT2100 PCI-Express Bridge (rev a2)
         Kernel driver in use: pcieport
         Kernel modules: shpchp
00:0a.0 PCI bridge: Broadcom HT2100 PCI-Express Bridge (rev a2)
         Kernel driver in use: pcieport
         Kernel modules: shpchp
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 
[Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 
[Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 
[Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 
[Athlon64/Opteron] Miscellaneous Control
         Kernel driver in use: k8temp
         Kernel modules: k8temp
00:19.0 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 
[Athlon64/Opteron] HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 
[Athlon64/Opteron] Address Map
00:19.2 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 
[Athlon64/Opteron] DRAM Controller
00:19.3 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 
[Athlon64/Opteron] Miscellaneous Control
         Kernel driver in use: k8temp
         Kernel modules: k8temp
01:0d.0 PCI bridge: Broadcom BCM5785 [HT1000] PCI/PCI-X Bridge (rev c0)
         Kernel modules: shpchp
01:0e.0 RAID bus controller: Broadcom BCM5785 [HT1000] SATA (Native SATA 
Mode)
         Subsystem: IBM BCM5785 [HT1000] SATA (Native SATA Mode)
         Kernel driver in use: sata_svw
         Kernel modules: sata_svw
02:01.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme 
BCM5704 Gigabit Ethernet (rev 10)
         Subsystem: IBM NetXtreme BCM5704 Gigabit Ethernet
         Kernel driver in use: tg3
         Kernel modules: tg3
02:01.1 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme 
BCM5704 Gigabit Ethernet (rev 10)
         Subsystem: IBM NetXtreme BCM5704 Gigabit Ethernet
         Kernel driver in use: tg3
         Kernel modules: tg3
03:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA 
Raid II Controller (rev 01)
         Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II 
Controller
         Kernel driver in use: sata_sil24
         Kernel modules: sata_sil24
06:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet 
Controller (Copper) (rev 06)
         Subsystem: Intel Corporation PRO/1000 PT Desktop Adapter
         Kernel driver in use: e1000e
         Kernel modules: e1000e
root@keyserver3:/tmp# lspci -k | head
00:01.0 PCI bridge: Broadcom BCM5785 [HT1000] PCI/PCI-X Bridge
         Kernel modules: shpchp
00:02.0 Host bridge: Broadcom BCM5785 [HT1000] Legacy South Bridge
         Subsystem: IBM BCM5785 [HT1000] Legacy South Bridge
         Kernel driver in use: piix4_smbus
         Kernel modules: i2c_piix4
00:02.1 IDE interface: Broadcom BCM5785 [HT1000] IDE
         Subsystem: IBM BCM5785 [HT1000] IDE
         Kernel driver in use: pata_serverworks
         Kernel modules: pata_serverworks, pata_acpi

vs.

  ./map_hardware_to_drivers.pl /tmp/pci.ids
Checking this machine for drivers
Getting Device ID list from https://pci-ids.ucw.cz/v2.2/pci.ids
Getting PCI ID to builtin mappings from /sys/bus/pci/drivers
Getting PCI ID to kernel module name mappingsChecking pci and device IDs 
from lspci -n
pci_id  dev_id    driver description
00:01.0 1166:0036 <none> "BCM5785 [HT1000] PCI/PCI-X Bridge"
00:02.0 1166:0205 i2c_piix4(module)/piix4_smbus(builtin) "BCM5785 
[HT1000] Legacy South Bridge"
00:02.1 1166:0214 pata_serverworks(module)/pata_serverworks(builtin) 
"BCM5785 [HT1000] IDE"
00:02.2 1166:0234 <none> "BCM5785 [HT1000] LPC"
00:03.0 1166:0223 ohci-pci(builtin) "BCM5785 [HT1000] USB"
00:03.1 1166:0223 ohci-pci(builtin) "BCM5785 [HT1000] USB"
00:03.2 1166:0223 ehci-pci(builtin) "BCM5785 [HT1000] USB"
00:05.0 1002:515E radeonfb(module)/radeon(builtin) "ES1000"
00:06.0 1166:0140 pcieport(builtin) "HT2100 PCI-Express Bridge"
00:07.0 1166:0142 pcieport(builtin) "HT2100 PCI-Express Bridge"
00:08.0 1166:0144 pcieport(builtin) "HT2100 PCI-Express Bridge"
00:09.0 1166:0142 pcieport(builtin) "HT2100 PCI-Express Bridge"
00:0a.0 1166:0144 <none> "HT2100 PCI-Express Bridge"
00:18.0 1022:1100 <none> "K8 [Athlon64/Opteron] HyperTransport 
Technology Configuration"
00:18.1 1022:1101 <none> "K8 [Athlon64/Opteron] Address Map"
00:18.2 1022:1102 <none> "K8 [Athlon64/Opteron] DRAM Controller"
00:18.3 1022:1103 k8temp(module)/k8temp(builtin) "K8 [Athlon64/Opteron] 
Miscellaneous Control"
00:19.0 1022:1100 <none> "K8 [Athlon64/Opteron] HyperTransport 
Technology Configuration"
00:19.1 1022:1101 <none> "K8 [Athlon64/Opteron] Address Map"
00:19.2 1022:1102 <none> "K8 [Athlon64/Opteron] DRAM Controller"
00:19.3 1022:1103 k8temp(module)/k8temp(builtin) "K8 [Athlon64/Opteron] 
Miscellaneous Control"
01:0d.0 1166:0104 <none> "BCM5785 [HT1000] PCI/PCI-X Bridge"
01:0e.0 1166:024A sata_svw(module) "BCM5785 [HT1000] SATA (Native SATA 
Mode)"
02:01.0 14E4:1648 tg3(module)/tg3(builtin) "NetXtreme BCM5704 Gigabit 
Ethernet"
02:01.1 14E4:1648 tg3(module)/tg3(builtin) "NetXtreme BCM5704 Gigabit 
Ethernet"
03:00.0 1095:3132 sata_sil24(module)/sata_sil24(builtin) "SiI 3132 
Serial ATA Raid II Controller"
06:00.0 8086:10B9 e1000e(module)/e1000e(builtin) "82572EI Gigabit 
Ethernet Controller (Copper)"
Done


Things I do not understand:

1.  Devices 00:01.0 and 01:0d.0 show "Kernel modules: shpchp" in "lspci 
-k".
Where is "lspci -k" getting that information?
"ls /sys/module/shpch" does not indicate any links to those devices, nor
do those devices have any links to that module/driver.  The others 
devices do link to their
drivers (and vice versa), for instance:

ls -al /sys/devices/pci0000:00/0000:00:02.1 | grep drivers
lrwxrwxrwx  1 root root    0 Mar 16 13:47 driver -> 
../../../bus/pci/drivers/pata_serverworks

ls -al /sys/bus/pci/drivers/pata_serverworks | grep devices
lrwxrwxrwx  1 root root    0 Mar 16 13:48 0000:00:02.1 -> 
../../../../devices/pci0000:00/0000:00:02.1

2.  I describe the /sys/module heirarchy as "builtin", assuming that all 
the drivers in it are compiled into the running kernel.  Is that 
actually true or will modules from /lib/modules/<kernel> show up in 
there too when they are loaded?  If the latter is the case, how does one 
determine what is actually built into the kernel and what was added 
later?

3.  lsmod shows which modules are loaded.  Is there anything similar to 
show which builtin kernel drivers are being used?  Or is deterimining 
which driver is in use an either/or sort of thing.  For instance, for 
06:00.0 the driver is e1000e for both builtin and module, and lsmod 
shows e1000e, so that is the module and not the builtin in use.  If 
lsmod did not show it then it would be the builtin.  That seems to be 
the case for these two:

   00:03.1 1166:0223 ohci-pci(builtin) "BCM5785 [HT1000] USB"
   00:03.2 1166:0223 ehci-pci(builtin) "BCM5785 [HT1000] USB"

Thank you,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech

--=_3b128d48692a74d4fd51ecdf54a84cd2
Content-Transfer-Encoding: base64
Content-Type: text/x-perl; charset=us-ascii;
 name=map_hardware_to_drivers.pl
Content-Disposition: attachment;
 filename=map_hardware_to_drivers.pl;
 size=5703

IyEvdXNyL2Jpbi9wZXJsCiNOYW1lOiAgICBtYXBfaGFyZHdhcmVfdG9fZHJpdmVycy5wbAojdmVy
c2lvbjogMS4wLjAKI0RhdGU6ICAgIDIwMjAtMDMtMTIKI0F1dGhvcjogIERhdmlkIE1hdGhvZwoj
CiMgIE1hcCB0aGUgcGNpIGhhcmR3YXJlIGxpc3QgdG8gZHJpdmVycyBmb3IgdGhlIHJ1bm5pbmcg
a2VybmVsCiMKIyAgYXNzdW1lcyB3Z2V0LCBsc3BjaSwgYW5kIGFjY2VzcyB0byB0aGUgaW50ZXJu
ZXQgYXJlIGF2YWlsYWJsZQojICBJZiBhY2Nlc3MgaXMgbm90IGF2YWlsYWJsZSBzcGVjaWZ5IG9u
ZSBwYXJhbWV0ZXIgdG8gdGhlIGFscmVhZHkgZG93bmxvYWRlZAojICBQQ0kgSURzIGZpbGUuCiMK
Iwp1c2Ugc3RyaWN0Owp1c2Ugd2FybmluZ3M7Cm15ICRJRExJU1Q9Imh0dHBzOi8vcGNpLWlkcy51
Y3cuY3ovdjIuMi9wY2kuaWRzIjsKbXkgJHJlYWxfZmlsZW5hbWU9Ii90bXAvcGNpLmlkcyI7Cm15
ICRrZXJuZWw9YHVuYW1lIC1yYDsKY2hvbXAgJGtlcm5lbDsKbXkgJE1PREFMSUFTPSIvbGliL21v
ZHVsZXMvJGtlcm5lbC9tb2R1bGVzLmFsaWFzIjsKbXkgJWRldl9oYXNoX2xvbmduYW1lOwpteSAl
ZGV2X2hhc2hfbW9kdWxlOwpteSAlcGNpX2hhc2hfYnVpbHRpbjsKbXkgJGNvdW50PTA7Cm15ICR2
ZW5kb3I9IiI7Cm15ICRkZXZpY2U9IiI7Cm15ICRsb25nX25hbWU9IiI7Cm15ICRtb2R1bGVfbmFt
ZT0iIjsKbXkgJHBjaV9pZDsKbXkgJGRldl9pZDsKbXkgJGlnbm9yZTsKCm15ICRudW1fYXJncyA9
ICQjQVJHVjsKaWYgKCRudW1fYXJncyAhPSAwKSB7CiAgICBwcmludCAKICAgICAiVXNhZ2U6IG1h
cF9oYXJkd2FyZV90b19kcml2ZXJzLnBsIFBjaUlEc0ZpbGVcblxuIiwKICAgICAiSWYgaW50ZXJu
ZXQgYWNjZXNzIGlzIGF2YWlsYWJsZSBsZXQgUGNpSURzRmlsZSA9IFwiLVwiIGFuZCBpdCB3aWxs
IGJlIGRvd25sb2FkZWRcbiIsCiAgICAgImF1dG9tYXRpY2FsbHkuICBPdGhlcndpc2Ugb24gc29t
ZSBtYWNoaW5lIGRvOlxuXG4iLAogICAgICIgICB3Z2V0IC1PIFBjaUlEc0ZpbGUgJElETElTVFxu
XG4iLAogICAgICJUaGVuIGNvcHkgdGhhdCBmaWxlIGJ5IHNvbWUgbWVhbnMgdG8gdGhlIHRhcmdl
dCBhbmQgc3BlY2lmeVxuIiwKICAgICAidGhlIGZpbGUgbmFtZSBvbiB0aGUgY29tbWFuZCBsaW5l
LlxuIjsKICAgIGV4aXQ7Cn0KbXkgJGZpbGVuYW1lPSRBUkdWWzBdOwoKCgppZigkZmlsZW5hbWUg
ZXEgJy0nKXsKICAgbXkgJG1lc3NhZ2VzID0gYHdnZXQgLXEgLU8gJHJlYWxfZmlsZW5hbWUgJElE
TElTVCAyPi9kZXYvbnVsbGA7CiAgIGlmKCRtZXNzYWdlcyl7CiAgICAgIHByaW50CiAgICAgICAg
IlNvbWUgcHJvYmxlbSBydW5uaW5nOlxuXG4iLAogICAgICAgICIgIHdnZXQgLXEgLU8gJHJlYWxf
ZmlsZW5hbWUgMj4vZGV2L251bGxcblxuIiwKCSJyZXR1cm5lZDpcbiIsCgkiJG1lc3NhZ2VzXG4i
OwogICAgICBleGl0OwogICB9Cn0KZWxzZSB7CiAgICRyZWFsX2ZpbGVuYW1lID0gJGZpbGVuYW1l
Owp9CgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpvcGVuKEZILCAkcmVhbF9maWxlbmFtZSkgb3Ig
ZGllICJjb3VsZCBub3Qgb3BlbiBmaWxlICRyZWFsX2ZpbGVuYW1lIjsKCnByaW50ICJDaGVja2lu
ZyB0aGlzIG1hY2hpbmUgZm9yIGRyaXZlcnNcbiI7CnByaW50ICJHZXR0aW5nIERldmljZSBJRCBs
aXN0IGZyb20gJElETElTVFxuIjsKIyBTeW50YXggaW4gdGhpcyBmaWxlOgojICAgI2NvbW1lbnQg
bGluZQojICAgPGJsYW5rIGxpbmVzPgojICAgdmVuZG9yICB2ZW5kb3JfbmFtZQojCWRldmljZSAg
ZGV2aWNlX25hbWUJCQkJPC0tIHNpbmdsZSB0YWIKIwkJc3VidmVuZG9yIHN1YmRldmljZSAgc3Vi
c3lzdGVtX25hbWUJPC0tIHR3byB0YWJzCiMgICBPbmx5IHRoZSB2ZW5kb3IgYW5kIGRldmljZSBs
aW5lcyBhcmUgcmV0YWluZWQKIyhUaGlzIHdpbGwgb2J0YWluIGFsbCBQQ0kgSUQgLT4gbG9uZyBu
YW1lIG1hcHBpbmdzIGV2ZW4gaWYgdGhlIGN1cnJlbnQga2VybmVsIGRvZXMKI25vdCBoYXZlIHRo
ZSBpbmZvcm1hdGlvbi4pCndoaWxlIChteSAkbGluZSA9IDxGSD4pewogICAgY2hvbXAgJGxpbmU7
CiAgICBpZighICRsaW5lKXsgbmV4dDsgfQogICAgaWYoc3Vic3RyKCRsaW5lLDAsMSkgZXEgIiMi
KXsgbmV4dDsgfQogICAgaWYoc3Vic3RyKCRsaW5lLDAsMikgZXEgIlx0XHQiKXsgbmV4dDsgfQog
ICAgaWYoc3Vic3RyKCRsaW5lLDAsMSkgZXEgIlx0Iil7ICNkZXZpY2UgbGluZQogICAgICAgJGRl
dmljZSA9IHN1YnN0cigkbGluZSwxLDQpOwogICAgICAgJGxvbmdfbmFtZSA9IHN1YnN0cigkbGlu
ZSw3KTsKICAgICAgICRkZXZfaWQgPSAkdmVuZG9yIC4gIjoiIC4gdWMgJGRldmljZTsKICAgICAg
ICRkZXZfaGFzaF9sb25nbmFtZXskZGV2X2lkfSA9ICRsb25nX25hbWU7CiAgICB9CiAgICBlbHNl
IHsgI3ZlbmRvciBsaW5lCiAgICAgICAkdmVuZG9yID0gdWMgc3Vic3RyKCRsaW5lLDAsNCk7CiAg
ICB9Cn0KY2xvc2UoRkgpOwojICAgICAgIG15ICgkZGV2X3R5cGUsICRkZXZfaWQsICRkZXZfZHJp
dmVyKSA9IHNwbGl0KC9ccysvLCRsaW5lKTsKCiNwcmludCAiR2V0dGluZyBwY2kgSURzIGFuZCBs
b25nIG5hbWVzIGZyb20gbHNwY2lcbiI7CiNmb3JlYWNoIG15ICRsaW5lIChgbHNwY2lgKXsKIyAg
ICBjaG9tcCAkbGluZTsKIyAgICBteSAkc3RhcnRzID0gaW5kZXgoJGxpbmUsIiAiKTsKIyAgICBt
eSAkcGNpX2lkID0gdWMgc3Vic3RyKCRsaW5lLDAsJHN0YXJ0cyk7CiMgICAgbXkgJGxuID0gc3Vi
c3RyKCRsaW5lLCRzdGFydHMrMSk7CiMgICAgJGRldl9oYXNoX2xvbmduYW1leyRwY2lfaWR9PSRs
bjsKI30KCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCiMgZ2V0IGFsbCB0aGUgUENJIElEIHRvIGJ1
aWx0aW4gbWFwcGluZ3MuCnByaW50ICJHZXR0aW5nIFBDSSBJRCB0byBidWlsdGluIG1hcHBpbmdz
IGZyb20gL3N5cy9idXMvcGNpL2RyaXZlcnNcbiI7CmZvcmVhY2ggbXkgJGxpbmUgKGBmaW5kIC9z
eXMvYnVzL3BjaS9kcml2ZXJzYCl7CiAgICBjaG9tcCAkbGluZTsKICAgIG15ICRzdGFydHMgPSBp
bmRleCgkbGluZSwiLzAwMDA6Iik7CiAgICBpZigkc3RhcnRzICE9IC0xKXsKICAgICAgIG15ICRw
Y2lfaWQgPSB1YyBzdWJzdHIoJGxpbmUsJHN0YXJ0cyArIDYpOwogICAgICAgbXkgJGRlbGltID0g
cmluZGV4KHN1YnN0cigkbGluZSwwLCRzdGFydHMtMSksIi8iKTsKICAgICAgIG15ICRkcml2ZXI9
IHN1YnN0cigkbGluZSwkZGVsaW0rMSwkc3RhcnRzIC0gJGRlbGltIC0xKTsKIyAgICAgICBwcmlu
dCAicGNpX2lkID4kcGNpX2lkPCBkcml2ZXIgPiRkcml2ZXI8XG4iOwogICAgICAgJHBjaV9oYXNo
X2J1aWx0aW57JHBjaV9pZH09JGRyaXZlciAuICIoYnVpbHRpbikiOwogICAgfQp9CgojIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIwojIGdldCBhbGwgdGhlIFBDSSBJRCB0byBtb2R1bGUgbmFtZSBtYXBw
aW5ncy4gIElnbm9yZSBzdWJ2ZW5kb3IgYW5kIHN1YmRldmljZSBpbmZvcm1hdGlvbi4KIyBUaGlz
IHVzZXMgdGhlICJhbGlhcyBwY2k6IiBsaW5lcyB3aGljaCBoYXZlIHRoZSBzeW50YXg6CiMgICBh
bGlhcyBwY2k6dlZFTkRPUmRERVZJQ0VzdlNVQlZFTkRPUnNkU1VCREVWSUNFc2NJR05PUkVpSUdO
T1JFIG1vZHVsZV9uYW1lCiMgZXh0cmFjdCB0aGUgVkVORE9SIGFuZCBERVZJQ0UgZmlsZXMgdG8g
Y29uc3RydWN0IGEgUENJIElEIGxpa2UgMTIzNDpBQkNECiMgVXNlIHRoYXQgdG8gc3RvcmUgdGhl
IG1vZHVsZV9uYW1lIHZhbHVlIGluIGEgaGFzaC4KIwoKb3BlbihGSCwgJE1PREFMSUFTKSBvciBk
aWUgImNvdWxkIG5vdCBvcGVuIGZpbGUgJE1PREFMSUFTIjsKcHJpbnQgIkdldHRpbmcgUENJIElE
IHRvIGtlcm5lbCBtb2R1bGUgbmFtZSBtYXBwaW5ncyI7CgpteSAkbmV4dF9kZWxpbTsKd2hpbGUg
KG15ICRsaW5lID0gPEZIPil7CiAgICBjaG9tcCAkbGluZTsKICAgIGlmKHN1YnN0cigkbGluZSww
LDEwKSBlcSAnYWxpYXMgcGNpOicpewojICAgICAgIHByaW50ICJsaW5lOiAkbGluZVxuIjsKICAg
ICAgIGlmKHN1YnN0cigkbGluZSwxMSwxKSBlcSAiKiIpeyBuZXh0OyB9CiAgICAgICAkbmV4dF9k
ZWxpbT1pbmRleCgkbGluZSwiZCIsMTEpOwogICAgICAgaWYoJG5leHRfZGVsaW0gPT0gLTEpeyBk
aWUgIkZpbGUgJE1PREFMSUFTIGhhcyBwY2k6IGxpbmUgd2l0aCB1bmV4cGVjdGVkIHN5bnRheDog
JGxpbmUiOyB9CiAgICAgICAkdmVuZG9yID0gc3Vic3RyKCRsaW5lLDE1LDQpOwogICAgICAgJG5l
eHRfZGVsaW09aW5kZXgoJGxpbmUsInN2IiwyMCk7CiAgICAgICBpZigkbmV4dF9kZWxpbSA9PSAt
MSl7IGRpZSgiRmlsZSAkTU9EQUxJQVMgaGFzIHBjaTogbGluZSB3aXRoIHVuZXhwZWN0ZWQgc3lu
dGF4OiAkbGluZSIpOyB9CiAgICAgICAkZGV2aWNlID0gc3Vic3RyKCRsaW5lLDI0LDQpOwogICAg
ICAgJGRldl9pZCA9ICR2ZW5kb3IgLiAiOiIgLiAkZGV2aWNlOwogICAgICAgJG5leHRfZGVsaW09
aW5kZXgoJGxpbmUsIiAiLDI4KTsKICAgICAgIGlmKCRuZXh0X2RlbGltID09IC0xKXsgZGllICJG
aWxlICRNT0RBTElBUyBoYXMgcGNpOiBsaW5lIHdpdGggdW5leHBlY3RlZCBzeW50YXg6ICRsaW5l
IjsgfQogICAgICAgJG1vZHVsZV9uYW1lID0gc3Vic3RyKCRsaW5lLCRuZXh0X2RlbGltICsgMSk7
CiAgICAgICBpZihkZWZpbmVkKCRkZXZfaGFzaF9tb2R1bGV7JGRldl9pZH0pKXsgbmV4dDsgfSAj
c3VidmVuZG9yL3N1YmRldmljZSBsaW5lcwogICAgICAgJGRldl9oYXNoX21vZHVsZXskZGV2X2lk
fSA9ICRtb2R1bGVfbmFtZSAuICIobW9kdWxlKSI7CiAgICAgICAkY291bnQrKzsKIyAgICAgICBw
cmludCAiICBwYXJzZWQgJGRldl9pZCAkbW9kdWxlX25hbWVcbiI7CiAgICB9Cn0KY2xvc2UoRkgp
OwoKcHJpbnQgIkNoZWNraW5nIHBjaSBhbmQgZGV2aWNlIElEcyBmcm9tIGxzcGNpIC1uXG4iOwpw
cmludCAicGNpX2lkICBkZXZfaWQgICAgZHJpdmVyIGRlc2NyaXB0aW9uXG4iOwpmb3JlYWNoIG15
ICRsaW5lIChgbHNwY2kgLW5gKXsKICAgIGNob21wICRsaW5lOwogICAgKCRwY2lfaWQsICRpZ25v
cmUsICRkZXZfaWQpPSBzcGxpdCAvXHMvLCRsaW5lOwogICAgJGRldl9pZCA9IHVjICRkZXZfaWQ7
CiAgICBteSAkZGVzY3JpcHRpb24gPSAoZGVmaW5lZCgkZGV2X2hhc2hfbG9uZ25hbWV7JGRldl9p
ZH0pID8gJGRldl9oYXNoX2xvbmduYW1leyRkZXZfaWR9IDogInVua25vd24iKTsKICAgIG15ICRt
b2R1bGUgPSAoZGVmaW5lZCgkZGV2X2hhc2hfbW9kdWxleyRkZXZfaWR9KSA/ICRkZXZfaGFzaF9t
b2R1bGV7JGRldl9pZH0gOiAiIik7CiAgICBteSAkYnVpbHRpbiA9IChkZWZpbmVkKCRwY2lfaGFz
aF9idWlsdGlueyRwY2lfaWR9KSA/ICRwY2lfaGFzaF9idWlsdGlueyRwY2lfaWR9IDogIiIpOwog
ICAgaWYoISRtb2R1bGUpewogICAgICAgaWYoJGJ1aWx0aW4pewogICAgICAgICAgJG1vZHVsZSA9
ICRidWlsdGluOwogICAgICAgfQogICAgICAgZWxzZSB7CiAgICAgICAgICAkbW9kdWxlID0gIjxu
b25lPiI7CiAgICAgICB9CiAgICB9CiAgICBlbHNlIHsKICAgICAgIGlmKCRidWlsdGluKXsKICAg
ICAgICAgICRtb2R1bGUgLj0gIi8iIC4gJGJ1aWx0aW47CiAgICAgICB9CiAgICB9CiAgICBwcmlu
dCAiJHBjaV9pZCAkZGV2X2lkICRtb2R1bGUgXCIkZGVzY3JpcHRpb25cIlxuIjsKfQppZigkZmls
ZW5hbWUgZXEgIi0iKXsKICAgdW5saW5rKCRyZWFsX2ZpbGVuYW1lKTsKfQpwcmludCAiRG9uZVxu
IjsK
--=_3b128d48692a74d4fd51ecdf54a84cd2--

