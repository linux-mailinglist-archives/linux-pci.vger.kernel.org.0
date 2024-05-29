Return-Path: <linux-pci+bounces-7958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A428D2EE0
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 09:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A68828C34D
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 07:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC805169391;
	Wed, 29 May 2024 07:48:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67D4169ACE
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968888; cv=none; b=c6/es2rM3jsJjVyfXVNBDR18DVKgcK1SK208B76uB0nxfOvpAdKA5SeZJVC9nbxtzgEjxJJK2ElQIqOyjnqqiiWaiUziAjaRq37OlmQs/f+dCbirDlXpdJJyaBVksd857+F/GCKuG0r0ZPZ82+rNofSHj278rjz6W71NUoJc4Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968888; c=relaxed/simple;
	bh=2tGAgjxZrLAxYVFU97kplp8b3wqFhZU1hIVNNF+AZ6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KBBqRxm46szLg0CKHDXyE4uIYBxxboXP7e5ISVVTHaQS8HHK52MkWUmfxxdiC9BjXwPP8Guutgy+B64fq2R72aA7CI4XPNAwIGffqvAlbkPmLXPGS3vf/SHVPxguJ0cBY6weIaP4KkheH7/BnRIS1yShkN/e17ImQtcBzOQu4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44T7lD5t93351131, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44T7lD5t93351131
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 15:47:13 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 15:47:14 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 29 May 2024 15:47:13 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::d5b2:56ba:6b47:9975]) by
 RTEXMBS01.realtek.com.tw ([fe80::d5b2:56ba:6b47:9975%5]) with mapi id
 15.01.2507.035; Wed, 29 May 2024 15:47:13 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Lukas Wunner <lukas@wunner.de>
CC: "scott@spiteful.org" <scott@spiteful.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Mika
 Westerberg" <mika.westerberg@linux.intel.com>
Subject: RE: [bug report] nvme not re-recognize when changed M.2 SSD in S3 mode
Thread-Topic: [bug report] nvme not re-recognize when changed M.2 SSD in S3
 mode
Thread-Index: AdqKP+LQtoSsBN9ZRz2XBQWf3XU8AwAq/q8AAAon9QAC8Ap+oAZFPNwAAGl8ipA=
Date: Wed, 29 May 2024 07:47:13 +0000
Message-ID: <94918684e6a84122a6373ef45b3c117c@realtek.com>
References: <a608b5930d0a48f092f717c0e137454b@realtek.com>
 <ZhZk7MMt_dm6avBJ@wunner.de> <ZhapFF3393xuIHwM@wunner.de>
 <8c3d00850e7449c184e4c45a3c9b9dfa@realtek.com> <ZlR0grWLqO9nch8Q@wunner.de>
In-Reply-To: <ZlR0grWLqO9nch8Q@wunner.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Hi Lukas,

We use SDEX card replace M.2 nvme card because we don't have enough M.2 nvm=
e card=20
We tried this patch as below situation:=20
1.keep the SDEX card enter S3 then resume ->PASS=20
the video can continue playing, not see the msg "device replace during syst=
em sleep"=20

2. on S3 mode insert the SDEX card then resume -> PASS
Can identify the card and can see the msg "device replace during system sle=
ep"

3.on S3 mode remove the SDEX card then resume -> PASS
No card show on system and can see the msg "device replace during system sl=
eep"

4.replace card on S3 mode (different brand) ->PASS
Can identify the second card and can see the msg "device replace during sys=
tem sleep"

5.replace card on S3 mode (same brand and same capacity) ->FAIL
Can not see the msg "device replace during system sleep"
Against 5 we found a issue, most card not declare capability "PCI_EXT_CAP_I=
D_DSN",
even if there is the capability the config space value are 0, cause pci_get=
_dsn() return 0 normally.
However these cards can show the SN on CrystalDiskInfo.=20

below is the card pci config space log and lsblk disk info.
Sandisk Corp Device 5007 (prog-if 02 [NVM Express]) this card can see the "=
PCI_EXT_CAP_ID_DSN" capability
But value is 0
---------------------------------------------------------------------------=
-----------------------------------------
cr@cr-desktop:~$ sudo lspci -s 02:00.0 -vvv
02:00.0 Non-Volatile memory controller: Sandisk Corp Device 5007 (prog-if 0=
2 [NVM Express])
	Subsystem: Sandisk Corp Device 5007
	Physical Slot: 8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at a3b00000 (64-bit, non-prefetchable) [size=3D16K]
	Region 4: Memory at a3b04000 (64-bit, non-prefetchable) [size=3D256]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [90] MSI: Enable- Count=3D1/32 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [b0] MSI-X: Enable+ Count=3D17 Masked-
		Vector table: BAR=3D0 offset=3D00002000
		PBA: BAR=3D4 offset=3D00000000
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x1, ASPM L1, Exit Latency L1 <8us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+, NROPrPrP-, LTR+
			 10BitTagComp-, 10BitTagReq-, OBFF Not Supported, ExtFmt+, EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-, TPHComp-, ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabl=
ed
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, Equaliza=
tionPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCC=
hkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [150 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [1b8 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [300 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
		LaneErrStat: 0
	Capabilities: [900 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates=
+
			  PortCommonModeRestoreTime=3D32us PortTPowerOnTime=3D10us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
			   T_CommonMode=3D0us LTR1.2_Threshold=3D90112ns
		L1SubCtl2: T_PwrOn=3D44us
	Kernel driver in use: nvme
	Kernel modules: nvme
---------------------------------------------------------------------------=
-----------------------------------------

Here can see the Serial Number is "03969d74164000000000"
---------------------------------------------------------------------------=
-----------------------------------------
cr@cr-desktop:~$ lsblk --nodeps -o name,size,type,mountpoint,serial
NAME      SIZE TYPE MOUNTPOINT                   SERIAL
loop0       4K loop /snap/bare/5                =20
loop1    55.7M loop /snap/core18/2785           =20
loop2    55.7M loop /snap/core18/2790           =20
loop3    63.5M loop /snap/core20/1974           =20
loop4    91.7M loop /snap/gtk-common-themes/1535=20
loop5    53.3M loop /snap/snapd/19457           =20
loop6   485.5M loop /snap/gnome-42-2204/120     =20
loop7    65.1M loop /snap/gtk-common-themes/1515=20
loop8    73.9M loop /snap/core22/858            =20
loop9    12.3M loop /snap/snap-store/959        =20
loop10  485.5M loop /snap/gnome-42-2204/126     =20
loop11    219M loop /snap/gnome-3-34-1804/72    =20
loop12     51M loop /snap/snap-store/547        =20
loop13  218.4M loop /snap/gnome-3-34-1804/93    =20
loop14   63.9M loop /snap/sublime-text/122      =20
loop15  321.1M loop /snap/vlc/3721              =20
loop16   65.2M loop /snap/sublime-text/118      =20
sda     232.9G disk                              210350450505
nvme0n1 236.1G disk                              03969d74164000000000=20
---------------------------------------------------------------------------=
-----------------------------------------

we tried the 4 SDEX cards and 2 M.2 Nvme,=20
either it is not declared or the value is 0 all the cards I have.=20

RIcky

> Below please find a reworked patch which checks the Device Serial Number =
in
> addition to various other device identity information in config space.
>=20
> I've moved the check for a replaced device to the ->resume_noirq phase, i=
.e.
> before the device driver's first access to the device.
> I'm also marking the device removed to prevent the driver from accessing =
it.
>=20
> Does this fix the issue for you?
>=20
> If it does reliably detect a replaced device, could you also double-check=
 the
> opposite case, i.e. if the device is *not* replaced during system sleep?
>=20
> I think this is about as much as we can do at the PCI layer to detect a r=
eplaced
> device.  Drivers may have additional ways to identify a device (such as
> reading a WWID from some register) and we could consider providing a libr=
ary
> function which drivers could call if they detect a replaced device on res=
ume.
>=20
> If you set CONFIG_DYNAMIC_DEBUG=3Dy and add the following to the command
> line...
>=20
> pciehp.pciehp_debug=3D1 dyndbg=3D"file pciehp* +p" log_buf_len=3D10M
> ignore_loglevel
>=20
> ...you should see "device replaced during system sleep" messages on resum=
e if
> a replaced device is detected.
>=20
> -- >8 --
>=20
> From: Lukas Wunner <lukas@wunner.de>
> Subject: [PATCH] PCI: pciehp: Detect device replacement during system sle=
ep
>=20
> Ricky reports that replacing a device in a hotplug slot during ACPI sleep=
 state
> S3 does not cause re-enumeration on resume, as one would expect.  Instead=
,
> the new device is treated as if it was the old one.
>=20
> There is no bulletproof way to detect device replacement, but as a heuris=
tic,
> check whether the device identity in config space matches cached data in
> struct pci_dev (Vendor ID, Device ID, Class Code, Revision ID, Subsystem
> Vendor ID, Subsystem ID).  Additionally, cache and compare the Device Ser=
ial
> Number (PCIe r6.2 sec 7.9.3).  If a mismatch is detected, mark the old de=
vice
> disconnected (to prevent its driver from accessing the new device) and
> synthesize a Presence Detect Changed event.
>=20
> Reported-by: Ricky Wu <ricky_wu@realtek.com>
> Closes:
> https://lore.kernel.org/r/a608b5930d0a48f092f717c0e137454b@realtek.com
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/hotplug/pciehp.h      |  4 ++++
>  drivers/pci/hotplug/pciehp_core.c | 42
> ++++++++++++++++++++++++++++++++++++++-
>  drivers/pci/hotplug/pciehp_hpc.c  |  5 +++++
> drivers/pci/hotplug/pciehp_pci.c  |  4 ++++
>  4 files changed, 54 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h =
index
> e0a614a..273dd8c 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -46,6 +46,9 @@
>  /**
>   * struct controller - PCIe hotplug controller
>   * @pcie: pointer to the controller's PCIe port service device
> + * @dsn: cached copy of Device Serial Number of Function 0 in the hotplu=
g
> slot
> + *     (PCIe r6.2 sec 7.9.3); used to determine whether a hotplugged dev=
ice
> + *     was replaced with a different one during system sleep
>   * @slot_cap: cached copy of the Slot Capabilities register
>   * @inband_presence_disabled: In-Band Presence Detect Disable supported
> by
>   *     controller and disabled per spec recommendation (PCIe r5.0,
> appendix I
> @@ -87,6 +90,7 @@
>   */
>  struct controller {
>         struct pcie_device *pcie;
> +       u64 dsn;
>=20
>         u32 slot_cap;                           /* capabilities and
> quirks */
>         unsigned int inband_presence_disabled:1; diff --git
> a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index ddd55ad..ff458e6 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -284,6 +284,32 @@ static int pciehp_suspend(struct pcie_device *dev)
>         return 0;
>  }
>=20
> +static bool pciehp_device_replaced(struct controller *ctrl) {
> +       struct pci_dev *pdev __free(pci_dev_put);
> +       u32 reg;
> +
> +       pdev =3D pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0,=
 0));
> +       if (!pdev)
> +               return true;
> +
> +       if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
> +           reg !=3D (pdev->vendor | (pdev->device << 16)) ||
> +           pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
> +           reg !=3D (pdev->revision | (pdev->class << 8)))
> +               return true;
> +
> +       if (pdev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL &&
> +           (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID,
> &reg) ||
> +            reg !=3D (pdev->subsystem_vendor | (pdev->subsystem_device
> << 16))))
> +               return true;
> +
> +       if (pci_get_dsn(pdev) !=3D ctrl->dsn)
> +               return true;
> +
> +       return false;
> +}
> +
>  static int pciehp_resume_noirq(struct pcie_device *dev)  {
>         struct controller *ctrl =3D get_service_data(dev); @@ -293,9 +319=
,23
> @@ static int pciehp_resume_noirq(struct pcie_device *dev)
>         ctrl->cmd_busy =3D true;
>=20
>         /* clear spurious events from rediscovery of inserted card */
> -       if (ctrl->state =3D=3D ON_STATE || ctrl->state =3D=3D BLINKINGOFF=
_STATE)
> +       if (ctrl->state =3D=3D ON_STATE || ctrl->state =3D=3D BLINKINGOFF=
_STATE)
> + {
>                 pcie_clear_hotplug_events(ctrl);
>=20
> +               /*
> +                * If hotplugged device was replaced with a different one
> +                * during system sleep, mark the old device disconnected
> +                * (to prevent its driver from accessing the new device)
> +                * and synthesize a Presence Detect Changed event.
> +                */
> +               if (pciehp_device_replaced(ctrl)) {
> +                       ctrl_dbg(ctrl, "device replaced during system
> sleep\n");
> +                       pci_walk_bus(ctrl->pcie->port->subordinate,
> +                                    pci_dev_set_disconnected,
> NULL);
> +                       pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
> +               }
> +       }
> +
>         return 0;
>  }
>  #endif
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c
> b/drivers/pci/hotplug/pciehp_hpc.c
> index b1d0a1b3..061f01f 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -1055,6 +1055,11 @@ struct controller *pcie_init(struct pcie_device
> *dev)
>                 }
>         }
>=20
> +       pdev =3D pci_get_slot(subordinate, PCI_DEVFN(0, 0));
> +       if (pdev)
> +               ctrl->dsn =3D pci_get_dsn(pdev);
> +       pci_dev_put(pdev);
> +
>         return ctrl;
>  }
>=20
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pcieh=
p_pci.c
> index ad12515..65e50be 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -72,6 +72,10 @@ int pciehp_configure_device(struct controller *ctrl)
>         pci_bus_add_devices(parent);
>         down_read_nested(&ctrl->reset_lock, ctrl->depth);
>=20
> +       dev =3D pci_get_slot(parent, PCI_DEVFN(0, 0));
> +       ctrl->dsn =3D pci_get_dsn(dev);
> +       pci_dev_put(dev);
> +
>   out:
>         pci_unlock_rescan_remove();
>         return ret;
> --
> 2.43.0


