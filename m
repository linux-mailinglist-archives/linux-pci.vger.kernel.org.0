Return-Path: <linux-pci+bounces-5043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF698898BE
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 10:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AF42A6639
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDAE82C96;
	Mon, 25 Mar 2024 05:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="y/OJEo3R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZf8j4k4"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E8143878;
	Mon, 25 Mar 2024 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711329704; cv=none; b=MPWTke8MkndcSyX7gf6QRcgdtcTe1WdapLE4uwLFtHNGa77HoEuYE0uVJXdu5oP+bZPH7+IDByP8NlHGgWig7sAAhMf3f2osX+Xodx3k1R93lBw1JafgHt/1EHk8zly9FsWCa+EM8iTAGAJZBUWNSUuiukRwRb3gO+IhRUlgLQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711329704; c=relaxed/simple;
	bh=3DyUC4KeQmUIkxMmdA3c4sX5XUh4DpFW6As1PmRc2Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zl89go6U98RDdjSoRpfA0FxGf/y8FoXvd87LWCrBOWrxjgcWgnpzoIdORLqD6rz48YbIbW5Gk1qv3kiqzdwqcQWvvy0fewE3JazYFtPQhS8829JGHFZhDbrmd3u+QrD9Imvh328KKO2ZCck7nmqdFwzEkxJ64OK0k9jbvEAtSHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=y/OJEo3R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EZf8j4k4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4651E13800CA;
	Sun, 24 Mar 2024 21:21:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 24 Mar 2024 21:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1711329701; x=
	1711416101; bh=O/03a8VUsvCu5Ho2lWofHPeYJCGruXQzjVj9uGmC/bY=; b=y
	/OJEo3ROdrpCl7D1hrNXl7DSKLX9FD1WJkyUa+0KSMIzJ0YEh+PKbx+EYAUp9WgX
	i1xk+2Pwnb7xfvvrOVJlkAcx63RnI6Zqgty+gpDsWRs8a6QUrDV1fOIb8+1nmTJ2
	eP/YE/nbFP30xxkxt/ROpUHyti2F4wrODIV7pvPC/eCFCK0n0S86LSb3VbQHGYl9
	gJZTSJBQqkSbRIBejT0U3prYVxW6U+4oVdu4vHEY+uLKWnhNwGZXXlWX/S66qW7c
	jce75nhEvXhuBaUB2y35X8He8yTZOVKP85XIC8v6lGp7G/XZKIFQOEnQ8r7S7wzf
	o3fjAHSnxosjuDk46SHdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711329701; x=
	1711416101; bh=O/03a8VUsvCu5Ho2lWofHPeYJCGruXQzjVj9uGmC/bY=; b=E
	Zf8j4k4eUdifg3IS1Yaqfm187P578wbwEV++ixbC9d5YbPUEgweuNPWKk3uGW3zF
	H9u/7uWDIDEHWsnNFA9TOLWbnXnZIhyD0H5SLcpivFFU9PEUbTPfyuOOzP6wnm2G
	weRHeI3crgu4TgvS+PJESpNLavxI7pvIuvkmyk+8nT/UqRHHd4UEQjfzd8NoyV6C
	2moG2xBCq2NJHWblarhelQVjtSpPmCPlT4nIVOQ1mNiK7F3CmP1BntAHbWjQXcPC
	aPPEeqbhVJ8ssvGzwQVZynvPii+n6+JDY1YbnAuxjtOq7yPs0Cf5LmR9GOda5P0Y
	eGV2KsLKWukIBOLIC3usA==
X-ME-Sender: <xms:pdEAZtxasYvljIvamxA5bdUkcgTtCEWJAKlKZEB6q8T5tH4mQ1fwbA>
    <xme:pdEAZtRz66QLj3WqwaXB2S2_MQz3bobFyKeH4PB_LFw5J9jCgWneexWBUi2OhBE01
    xMhewZvxxRYT2BqKZ8>
X-ME-Received: <xmr:pdEAZnUhIVmVbf2E6MOecKYA2LPuVyNiBWUJHXGFiAas1foKC1vVJGh-bnYWbco3EkY7N_MkYv11rawLIvqVzmdCC3Jlb42T6K0sKfFdrmkAyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:pdEAZvjI6UkRMGqDA56AYdcjkx2E2t9-ptwnHB6Jx-cjpbZxzPpblQ>
    <xmx:pdEAZvAl_RMjVzVaA0CTDho29A8axqxZlZaHXWcJWF0VUgfzSXx5Vw>
    <xmx:pdEAZoJjBY0S_doiRlJnn4RvVPNekpI7FN--hQRzElaq4NUD6P1IYw>
    <xmx:pdEAZuC7J80cl9yvKyXEwMS2qqcWX9PwjQQmlPYI3dw4Oc3LR7a2OA>
    <xmx:pdEAZh0v2zFFBSbDAV_oi1fAvIozFOZW4PO0PZn5hsZa_TTGCRp8mw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Mar 2024 21:21:39 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: helgaas@kernel.org
Cc: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	edmund.raile@proton.me
Subject: Re: [PATCH v2] PCI: Mark LSI FW643 to avoid bus reset
Date: Mon, 25 Mar 2024 10:21:35 +0900
Message-ID: <20240325012135.36861-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229230013.GA369538@bhelgaas>
References: <20240229230013.GA369538@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bjorn Helgaas,

(C.C.ed to linux1394-devel@lists.sourceforge.net)

I have an objection to applying the change.

I've been using the issued 1394 OHCI hardware in my development for recent
years, while I have never faced the reported trouble. I think there are
any misunderstanding or misjudge somwhow in the review process to apply it.

Would I ask your precise advice to regenerate the reported issue in my
local?

This is my 1394 OHCI hardware.

```
$ sudo lspci -vvvnns 06:00.0
06:00.0 FireWire (IEEE 1394) [0c00]: LSI Corporation FW643 [TrueFire] PCIe 1394b Controller [11c1:5901] (rev 06) (prog-if 10 [OHCI])
        Subsystem: LSI Corporation FW643 [TrueFire] PCIe 1394b Controller [11c1:5900]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 255
        IOMMU group: 17
        Region 0: Memory at fc700000 (64-bit, non-prefetchable) [disabled] [size=4K]
        Capabilities: [44] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
        Capabilities: [4c] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0W
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable- ID=1 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending- InProgress-
        Capabilities: [170 v1] Device Serial Number 12-34-56-10-12-30-00-86
        Kernel driver in use: vfio-pci
        Kernel modules: firewire_ohci
```

I use it in the following environment at present:

* Host system
    * AMD Ryzen 5 2400G
    * TUF GAMING X570-PLUS with BIOS 5003 (AGESA ComboV2PI 1.2.0.B)
        * SMT enabled
        * SVM enabled
        * IOMMU enabled
        * Secure boot disabled
    * Ubuntu 24.04 LTS amd64
        * linux-image-6.8.0-11-generic (6.8.0-11.11)
            * default kernel cmdline
        * QEMU 8.2.1 (1:8.2.1+ds-1ubuntu1)
        * Libvert 10.0.0 (10.0.0-2ubuntu1)
* Guest system
    * UEFI using OVMF
        * Seecure boot enabled
    * Ubuntu 24.04 LTS amd64 (the same as above)
        * default kernel cmdline

> Using LSI / Agere FW643 with vfio-pci will exhaust all
> pci_reset_fn_methods, the bus reset at the end causes a broken link
> only recoverable by removing power
> (power-off / suspend + rescan).
> Prevent this bus reset.
> With this change, the device can be assigned to VMs with VFIO.
> Note that it will not be reset, resulting in leaking state between VMs
> and host.
> 
> Signed-off-by: Edmund Raile <edmund.raile@proton.me>
> 
> I sincerely thank you for your patience and explaining
> the background of pci resets which I lacked.
> The commit message and comment now describe it correctly.
> The comment on leaking states was added.
> 
> Usefulness:
> 
> The LSI FW643 PCIe->FireWire 800 interface may be EOL but it is
> the only one that does not use a PCIe->PCI bridge.
> It is reliable and enables FireWire audio interfaces to be used
> on modern machines.
> 
> Virtualization allows for flexible access to professional audio
> software.
> 
> It has been used in at least the following Apple machines:
> MacBookPro10,1
> MacBookPro9,2
> MacBookPro6,2
> MacBookPro5,1
> Macmini6,1
> Macmini3,1
> iMac12,2
> iMac9,1
> iMac8,1
> 
> Implementation:
> 
> PCI_VENDOR_ID_ATT was reused as they are identical.
> 
>  drivers/pci/quirks.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d797df6e5f3e..e0e4ad9e6d50 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3765,6 +3765,19 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
>  
> +/*
> + * Using LSI / Agere FW643 with vfio-pci will exhaust all
> + * pci_reset_fn_methods, the bus reset at the end causes a broken link
> + * only recoverable by removing power
> + * (power-off / suspend + rescan).
> + * Prevent this bus reset.
> + * With this change, the device can be assigned to VMs with VFIO.
> + * Note that it will not be reset, resulting in leaking state between VMs
> + * and host.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5900, quirk_no_bus_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATT, 0x5901, quirk_no_bus_reset);
> +
>  /*
>   * Some TI KeyStone C667X devices do not support bus/hot reset.  The PCIESS
>   * automatically disables LTSSM when Secondary Bus Reset is received and


Regards

Takashi Sakamoto

