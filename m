Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E684FC7D0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 00:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiDKWsh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 18:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiDKWsh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 18:48:37 -0400
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Apr 2022 15:46:10 PDT
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C7A2ED73;
        Mon, 11 Apr 2022 15:46:10 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1649716733; bh=eHIYved+gls8iq5JSt/1c0VpMtou2nqFl3j4XieDeA4=;
        h=From:To:Cc:Subject:Date:From;
        b=EYSSdfnN8IrceqDNsN4P1BsqR7NU/29OV0MjYcVR60E4+kKe6Zv8nbouy7SVyjSG0
         Uv4G+GIMhWdnB8fea1SZHnDP2nNhEezw8BSBvX7ilJveim5IR1mnpulZ1OfKfZz6QV
         h/oEmfFNunfdHjDLlwsmKBhBs9UtssszdzspHR6Y4bmtDis+eW0ESowUq+g6GJ6UUq
         GCnEM/iO3fr5XR1N8QGvsnCA2FFE5dtqq195UfsA7jMjE9HYCyriM/8WYxRK2vnE/Y
         FmVU4PodMMz3hu2ctQtkRJ8d3JjlqROaUMmnloscjTHNoktbVVuezV8bTFe9BQhKPQ
         AAiaGoBU6gnVQ==
To:     wendy.wang@intel.com, david.e.box@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: PCIE ASPM-related trouble with S0ix on Thinkpad X1 (NVME-related?)
Date:   Tue, 12 Apr 2022 00:38:52 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87k0bvutxf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi folks

I'm trying to get S0ix idle to work properly on my Thinkpad X1 (9th
gen), and am having some trouble which leads to high battery usage on
suspend. I've been using the S0ixSelftestTool[0] which is telling me
that it's related to PCI ASPM, so I'm hoping to reach some people who
might be able to help me debug this.

Specifically, the selftest script is telling me that:

"The pcieroot port 0000:00:06.0 ASPM setting is Enabled, its D state and
Link PM are not expected."

This appears to be the slot my NVME is in:

Checking PCI Devices tree diagram:
-[0000:00]-+-00.0  Intel Corporation 11th Gen Core Processor Host Bridge/DR=
AM Registers
           +-02.0  Intel Corporation TigerLake-LP GT2 [Iris Xe Graphics]
           +-04.0  Intel Corporation TigerLake-LP Dynamic Tuning Processor =
Participant
           +-06.0-[04]----00.0  Seagate Technology PLC FireCuda 530 SSD

[snip - full output below]

According to the manufacturer[1], the NVME device in question should
support suspending to L1.2. The S0ix troubleshooting guide[2] mentions
that the 5.3 kernel added special handling for NVME devices, but I'm
trying this on a 5.17 kernel, so that should already be there?

Anyone has any ideas and/or more things to try? I'm including the full
output of the s0ixSelftestTool below.

-Toke

[0] https://github.com/intel/S0ixSelftestTool
[1] https://www.seagate.com/files/www-content/datasheets/pdfs/firecuda-530-=
ssd-DS2059-3-2112GB-en_GB.pdf
[2] https://01.org/blogs/qwang59/2020/linux-s0ix-troubleshooting


---Check S2idle path S0ix Residency---:

The system OS Kernel version is:
Linux alrua-x1 5.17.1-arch1-1 #1 SMP PREEMPT Mon, 28 Mar 2022 20:55:33 +000=
0 x86_64 GNU/Linux

---Check whether your system supports S0ix or not---:

Low Power S0 Idle is:1
Your system supports low power S0 idle capability.



---Check whether intel_pmc_core sysfs files exit---:

The pmc_core debug sysfs files are OK on your system.



---Judge PC10, S0ix residency available status---:

Test system supports S0ix.y substate

S0ix substate before S2idle:
  S0i2.0 S0i3.0

S0ix substate residency before S2idle:
  0 0

Turbostat output:=20
16.006725 sec
CPU%c1	CPU%c6	CPU%c7	GFX%rc6	Pkg%pc2	Pkg%pc3	Pkg%pc6	Pkg%pc7	Pkg%pc8	Pkg%pc=
9	Pk%pc10	SYS%LPI
2.41	0.00	96.53	15717.64	21.13	71.28	0.00	0.00	0.00	0.00	0.00	0.00
2.44	0.00	96.99	15717.57	21.13	71.28	0.00	0.00	0.00	0.00	0.00	0.00
2.47
2.13	0.00	95.57
2.89
2.86	0.00	96.09
3.27
1.64	0.00	97.46
1.59

CPU Core C7 residency after S2idle is: 96.53
GFX RC6 residency after S2idle is: 15717.64
CPU Package C-state 2 residency after S2idle is: 21.13
CPU Package C-state 3 residency after S2idle is: 71.28
CPU Package C-state 8 residency after S2idle is: 0.00
CPU Package C-state 9 residency after S2idle is: 0.00
CPU Package C-state 10 residency after S2idle is: 0.00
S0ix residency after S2idle is: 0.00

Your system achieved PC3 residency: 71.28, but no PC8 residency during S2id=
le: 0.00

---Debug no PC8 residency scenario---:

Turbostat output:=20

turbostat: cpu3 jitter 1232 6150
16.634450 sec
CPU%c1	CPU%c6	CPU%c7	GFX%rc6	Pkg%pc2	Pkg%pc3	Pkg%pc6	Pkg%pc7	Pkg%pc8	Pkg%pc=
9	Pk%pc10	SYS%LPI
1.61	0.00	97.51	15283.84	21.80	71.84	0.00	0.00	0.00	0.00	0.00	0.00
1.44	0.00	98.09	15283.74	21.80	71.84	0.00	0.00	0.00	0.00	0.00	0.00
1.43
1.04	0.00	96.83
2.50
1.45	0.00	97.95
1.52
1.22	0.00	97.16
2.29

Your CPU Core C7 residency is available: 97.51

Your system Intel graphics RC6 residency is available:15283.84

Checking PCIe Device D state and Bridge Link state:


The PCIe bridge link power management state is:
0000:00:06.0 Link is in L0

The link power management state of PCIe bridge: 0000:00:06.0 is not expecte=
d.=20
which is expected to be L1.1 or L1.2, or user would run this script again.


The L1SubCap of the failed 0000:00:06.0 is:
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+

The L1SubCtl1 of the failed 0000:00:06.0 is:
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+


Checking PCI Devices tree diagram:
-[0000:00]-+-00.0  Intel Corporation 11th Gen Core Processor Host Bridge/DR=
AM Registers
           +-02.0  Intel Corporation TigerLake-LP GT2 [Iris Xe Graphics]
           +-04.0  Intel Corporation TigerLake-LP Dynamic Tuning Processor =
Participant
           +-06.0-[04]----00.0  Seagate Technology PLC FireCuda 530 SSD
           +-07.0-[20-49]--
           +-07.2-[50-79]--
           +-08.0  Intel Corporation GNA Scoring Accelerator module
           +-0a.0  Intel Corporation Tigerlake Telemetry Aggregator Driver
           +-0d.0  Intel Corporation Tiger Lake-LP Thunderbolt 4 USB Contro=
ller
           +-0d.2  Intel Corporation Tiger Lake-LP Thunderbolt 4 NHI #0
           +-0d.3  Intel Corporation Tiger Lake-LP Thunderbolt 4 NHI #1
           +-14.0  Intel Corporation Tiger Lake-LP USB 3.2 Gen 2x1 xHCI Hos=
t Controller
           +-14.2  Intel Corporation Tiger Lake-LP Shared SRAM
           +-14.3  Intel Corporation Wi-Fi 6 AX201
           +-15.0  Intel Corporation Tiger Lake-LP Serial IO I2C Controller=
 #0
           +-16.0  Intel Corporation Tiger Lake-LP Management Engine Interf=
ace
           +-1f.0  Intel Corporation Tiger Lake-LP LPC Controller
           +-1f.3  Intel Corporation Tiger Lake-LP Smart Sound Technology A=
udio Controller
           +-1f.4  Intel Corporation Tiger Lake-LP SMBus Controller
           \-1f.5  Intel Corporation Tiger Lake-LP SPI Controller


Checking PCI Devices D3 States:
[36580.351015] sof-audio-pci-intel-tgl 0000:00:1f.3: PCI PM: Suspend power =
state: D3hot
[36580.366546] i801_smbus 0000:00:1f.4: PCI PM: Suspend power state: D0
[36580.366614] i801_smbus 0000:00:1f.4: PCI PM: Skipped
[36580.369308] i915 0000:00:02.0: PCI PM: Suspend power state: D3hot
[36580.383006] mei_me 0000:00:16.0: PCI PM: Suspend power state: D3hot
[36580.384120] intel-lpss 0000:00:15.0: PCI PM: Suspend power state: D3hot
[36580.386213] proc_thermal 0000:00:04.0: PCI PM: Suspend power state: D3hot
[36580.387549] nvme 0000:04:00.0: PCI PM: Suspend power state: D3hot
[36580.387843] xhci_hcd 0000:00:14.0: PCI PM: Suspend power state: D3hot
[36580.388168] iwlwifi 0000:00:14.3: PCI PM: Suspend power state: D3hot
[36580.388210] pcieport 0000:00:06.0: PCI PM: Suspend power state: D0
[36580.388215] pcieport 0000:00:06.0: PCI PM: Skipped
[36580.389618] xhci_hcd 0000:00:0d.0: PCI PM: Suspend power state: D3cold
[36580.406682] thunderbolt 0000:00:0d.2: PCI PM: Suspend power state: D3cold
[36580.411535] thunderbolt 0000:00:0d.3: PCI PM: Suspend power state: D3cold


Checking PCI Devices tree diagram:
-[0000:00]-+-00.0  Intel Corporation 11th Gen Core Processor Host Bridge/DR=
AM Registers
           +-02.0  Intel Corporation TigerLake-LP GT2 [Iris Xe Graphics]
           +-04.0  Intel Corporation TigerLake-LP Dynamic Tuning Processor =
Participant
           +-06.0-[04]----00.0  Seagate Technology PLC FireCuda 530 SSD
           +-07.0-[20-49]--
           +-07.2-[50-79]--
           +-08.0  Intel Corporation GNA Scoring Accelerator module
           +-0a.0  Intel Corporation Tigerlake Telemetry Aggregator Driver
           +-0d.0  Intel Corporation Tiger Lake-LP Thunderbolt 4 USB Contro=
ller
           +-0d.2  Intel Corporation Tiger Lake-LP Thunderbolt 4 NHI #0
           +-0d.3  Intel Corporation Tiger Lake-LP Thunderbolt 4 NHI #1
           +-14.0  Intel Corporation Tiger Lake-LP USB 3.2 Gen 2x1 xHCI Hos=
t Controller
           +-14.2  Intel Corporation Tiger Lake-LP Shared SRAM
           +-14.3  Intel Corporation Wi-Fi 6 AX201
           +-15.0  Intel Corporation Tiger Lake-LP Serial IO I2C Controller=
 #0
           +-16.0  Intel Corporation Tiger Lake-LP Management Engine Interf=
ace
           +-1f.0  Intel Corporation Tiger Lake-LP LPC Controller
           +-1f.3  Intel Corporation Tiger Lake-LP Smart Sound Technology A=
udio Controller
           +-1f.4  Intel Corporation Tiger Lake-LP SMBus Controller
           \-1f.5  Intel Corporation Tiger Lake-LP SPI Controller

The pcieport 0000:00:06.0 ASPM enable status:
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+

Pcieport is not in D3cold=EF=BC=9A=20=20=20=20
m0000:00:06.0


The pcieroot port 0000:00:06.0 ASPM setting is Enabled, its D state and Lin=
k PM are not expected,
please investigate or report a bug.

