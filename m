Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A183C82F22
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 11:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbfHFJ5a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 05:57:30 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:45073 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732290AbfHFJ5a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Aug 2019 05:57:30 -0400
Received: from rabammel.molgen.mpg.de (rabammel.molgen.mpg.de [141.14.30.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B4F42201A3C24;
        Tue,  6 Aug 2019 11:57:27 +0200 (CEST)
Subject: Re: [Regression] pcie_wait_for_link_delay (1132.853 ms @ 5039.414431)
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Matthias Andree <matthias.andree@gmx.de>
References: <2857501d-c167-547d-c57d-d5d24ea1f1dc@molgen.mpg.de>
 <20190806093626.GF2548@lahna.fi.intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <acca5213-7d8b-7db1-ff3c-cb5b4a704f04@molgen.mpg.de>
Date:   Tue, 6 Aug 2019 11:57:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806093626.GF2548@lahna.fi.intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020103030907090607060902"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms020103030907090607060902
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Mika,


Thank you for your quick reply.


On 06.08.19 11:36, Mika Westerberg wrote:
> +Nicholas and Matthias
>=20
> On Tue, Aug 06, 2019 at 11:20:37AM +0200, Paul Menzel wrote:

>> Commit c2bf1fc2 (PCI: Add missing link delays required by the PCIe spe=
c) [1]=20
>> increases the resume time from ACPI S3 on a desktop system Dell OptiPl=
ex 5040
>> by one second. It looks like this is expected from the commit message,=
 but
>> breaks existing systems with boot time requirements. I measured this w=
ith the
>> help of the pm-graph script `sleepgraph.py` [2].
>>
>>     0000:00:01.0 resume_noirq (1134.715 ms @ 5039.412578 to 5040.54729=
3)
>>         =E2=80=A6
>>             pcie_wait_for_link_delay (1132.853 ms @ 5039.414431)

By the way, here is the trace excerpt with the interesting comments.

```
 5040.547284 |   1)  kworker-3594  |   1132852 us  |              } /* sc=
hedule_timeout */
 5040.547284 |   1)  kworker-3594  |   1132853 us  |            } /* msle=
ep */
 5040.547284 |   1)  kworker-3594  |   1132853 us  |          } /* pcie_w=
ait_for_link_delay */
 5040.547284 |   1)  kworker-3594  |   1132856 us  |        } /* wait_for=
_downstream_link */
 5040.547285 |   1)  kworker-3594  |               |        device_for_ea=
ch_child() {
 5040.547285 |   1)  kworker-3594  |   0.185 us    |          _raw_spin_l=
ock_irqsave();
 5040.547286 |   1)  kworker-3594  |   0.136 us    |          _raw_spin_u=
nlock_irqrestore();
 5040.547286 |   1)  kworker-3594  |   0.190 us    |          pm_iter();
 5040.547286 |   1)  kworker-3594  |   0.129 us    |          _raw_spin_l=
ock_irqsave();
 5040.547287 |   1)  kworker-3594  |   0.134 us    |          _raw_spin_u=
nlock_irqrestore();
 5040.547287 |   1)  kworker-3594  |   0.194 us    |          pm_iter();
 5040.547287 |   1)  kworker-3594  |   0.134 us    |          _raw_spin_l=
ock_irqsave();
 5040.547288 |   1)  kworker-3594  |   0.133 us    |          _raw_spin_u=
nlock_irqrestore();
 5040.547288 |   1)  kworker-3594  |   0.187 us    |          pm_iter();
 5040.547288 |   1)  kworker-3594  |   0.135 us    |          _raw_spin_l=
ock_irqsave();
 5040.547289 |   1)  kworker-3594  |   0.135 us    |          _raw_spin_u=
nlock_irqrestore();
 5040.547289 |   1)  kworker-3594  |   0.271 us    |          pm_iter();
 5040.547289 |   1)  kworker-3594  |   0.132 us    |          _raw_spin_l=
ock_irqsave();
 5040.547290 |   1)  kworker-3594  |   0.137 us    |          _raw_spin_u=
nlock_irqrestore();
 5040.547290 |   1)  kworker-3594  |   5.036 us    |        } /* device_f=
or_each_child */
 5040.547290 |   1)  kworker-3594  |   1132862 us  |      } /* pcie_port_=
device_resume_noirq */
 5040.547290 |   1)  kworker-3594  |   1134709 us  |    } /* pci_pm_resum=
e_noirq */
```

>> $ lspci -nn
>> 00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v5/E3-1500 =
v5/6th Gen Core Processor Host Bridge/DRAM Registers [8086:191f] (rev 07)=

>> 00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v5/E3-1500 v=
5/6th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 07)
>> 00:14.0 USB controller [0c03]: Intel Corporation Sunrise Point-H USB 3=
=2E0 xHCI Controller [8086:a12f] (rev 31)
>> 00:14.2 Signal processing controller [1180]: Intel Corporation Sunrise=
 Point-H Thermal subsystem [8086:a131] (rev 31)
>> 00:16.0 Communication controller [0780]: Intel Corporation Sunrise Poi=
nt-H CSME HECI #1 [8086:a13a] (rev 31)
>> 00:17.0 SATA controller [0106]: Intel Corporation Sunrise Point-H SATA=
 controller [AHCI mode] [8086:a102] (rev 31)
>> 00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-H PCI Expre=
ss Root Port #1 [8086:a110] (rev f1)
>> 00:1f.0 ISA bridge [0601]: Intel Corporation Sunrise Point-H LPC Contr=
oller [8086:a146] (rev 31)
>> 00:1f.2 Memory controller [0580]: Intel Corporation Sunrise Point-H PM=
C [8086:a121] (rev 31)
>> 00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-H HD Audi=
o [8086:a170] (rev 31)
>> 00:1f.4 SMBus [0c05]: Intel Corporation Sunrise Point-H SMBus [8086:a1=
23] (rev 31)
>> 00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connect=
ion (2) I219-V [8086:15b8] (rev 31)
>> 01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.=
 [AMD/ATI] Oland XT [Radeon HD 8670 / R7 250/350] [1002:6610] (rev 81)
>> 01:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Ca=
pe Verde/Pitcairn HDMI Audio [Radeon HD 7700/7800 Series] [1002:aab0]
>> 02:00.0 PCI bridge [0604]: Texas Instruments XIO2001 PCI Express-to-PC=
I Bridge [104c:8240]
>>
>> So, it=E2=80=99s about the internal Intel graphics device, which is no=
t used on this=20
>> system, as there is an external AMD graphics device plugged in.
>>
>> As far as I understand it, it=E2=80=99s a bug in the firmware, that a =
one second delay
>> is specified?

How can I read out the delay from the system as done in?

```
static int get_downstream_delay(struct pci_bus *bus)
{
        struct pci_dev *pdev;
        int min_delay =3D 100;
        int max_delay =3D 0;

        list_for_each_entry(pdev, &bus->devices, bus_list) {
                if (!pdev->imm_ready)
                        min_delay =3D 0;
                else if (pdev->d3cold_delay < min_delay)
                        min_delay =3D pdev->d3cold_delay;
                if (pdev->d3cold_delay > max_delay)
                        max_delay =3D pdev->d3cold_delay;
        }

        return max(min_delay, max_delay);
}
```

>> Anyway, there is such firmware out there, so I=E2=80=99d like to avoid=
 the time
>> increases.
>>
>> As a first step, the commit should be extended to print a warning (may=
be if
>> `initcall_debug` is specified), when the delay is higher than let=E2=80=
=99s say 50(?)
>> ms. Also better documentation how to debug these delays would be appre=
ciated.

As your commit message says the standard demands a delay of at least 100 =
ms, 50 ms
is of course too short, and maybe 150 ms or so should be used as the thre=
shold.

>> If there is no easy solution, it=E2=80=99d be great if the commit coul=
d be reverted for
>> now, and a better solution be discussed for the next release.
>=20
> There is also kernel bugzilla entry about another regression this cause=
s
> here:
>=20
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D204413
>=20
> I agree we should revert c2bf1fc2 now. I'll try to come up alternative
> solution to these missing delays that hopefully does not break existing=

> setups.
>=20
> Rafael, Bjorn,
>=20
> Can you revert the commit or do you want me to send a revert patch?
>=20
> Thanks and sorry about the breakage.

No worries.


Kind regards,

Paul


PS:

```
$ sudo lspci -vvv -s 00:00.0
00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen=
 Core Processor Host Bridge/DRAM Registers (rev 07)
	Subsystem: Dell Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Host B=
ridge/DRAM Registers
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=3D10 <?>
	Kernel driver in use: skl_uncore

$ sudo lspci -vvv -s 00:01
00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen =
Core Processor PCIe Controller (x16) (rev 07) (prog-if 00 [Normal decode]=
)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 120
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000e000-0000efff [size=3D4K]
	Memory behind bridge: f7e00000-f7efffff [size=3D1M]
	Prefetchable memory behind bridge: 00000000e0000000-00000000efffffff [si=
ze=3D256M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [88] Subsystem: Dell Xeon E3-1200 v5/E3-1500 v5/6th Gen Co=
re Processor PCIe Controller (x16)
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee04004  Data: 4021
	Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 256 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s =
<256ns, L1 <8us
			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt+=
 ABWMgmt+
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #2, PowerLimit 75.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-=

			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-=

		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF Via=
 WAKE# ARIFwd-
			 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Via =
WAKE# ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Com=
plianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, Equali=
zationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
			Status:	NegoPending- InProgress-
	Capabilities: [140 v1] Root Complex Link
		Desc:	PortNumber=3D02 ComponentID=3D01 EltType=3DConfig
		Link0:	Desc:	TargetPort=3D00 TargetComponent=3D01 AssocRCRB- LinkType=3D=
MemMapped LinkValid+
			Addr:	00000000fed19000
	Capabilities: [d94 v1] #19
	Kernel driver in use: pcieport
```


--------------ms020103030907090607060902
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xOTA4MDYwOTU3MjdaMC8GCSqGSIb3DQEJBDEiBCDzVgL7fIFNsg04litg
U0/Y+pojmXaf5YYikmaiNOspmTBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAKh7
IOeBkUpiQVD9Qxw5ML7UomuvMihPKqCUSvyJHOHKwMsf7cnZLcLgszJZjN1KnweHAHyLDsFZ
ftfp9Cp4tfPcbCHZknaV0OcdU4X1xmkTm+Q9qlAmibA8bJEhwIiTWvBT6HoRr+QQa+YxBtuk
LmMW0r7Dj3RZ5Xjb7uc86N+i4QPLT1+L3hnT+Oz3zime3yRjbYyIHsLIt5KEAREPV/x/L6JF
1n6IPdhDInIzl0F82Glv0Yzn1rHnq1nD/EQRuINWzrNEm7VI2bvKoKYmZqj/JV4N+H4xRA/z
AA+jvszafOZMgzOOpaHYnsihR3jmIJs54fDnTF1UHS8t9IHdWlAAAAAAAAA=
--------------ms020103030907090607060902--
