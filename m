Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9680863109E
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 21:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiKSUJQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Nov 2022 15:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiKSUJN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Nov 2022 15:09:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACA019C01
        for <linux-pci@vger.kernel.org>; Sat, 19 Nov 2022 12:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668888496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8fvEvbhezyhAD/JaVvzpm35s4e3Vo4GoAsKe1XU2BY=;
        b=RIhx0HOw/BU54kL4KxVDbPbS0xyNGn+9gAa43oTaIdzqAJYdI1XMprzxQAJa+mlYIFfIcI
        DYBddzqhtHRLdMK3KO8CicKRCh0it/oNe+ioeDLzxNt6KyCmXvvm4l8ZCSm4mzLdrXeH2x
        7ZhqFkraId5HjimWovYIVfToM1dMbgg=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-ofth3IFeMy25SpGcEKXFBw-1; Sat, 19 Nov 2022 15:08:14 -0500
X-MC-Unique: ofth3IFeMy25SpGcEKXFBw-1
Received: by mail-il1-f198.google.com with SMTP id 13-20020a056e0216cd00b003023e8b7d03so5566581ilx.7
        for <linux-pci@vger.kernel.org>; Sat, 19 Nov 2022 12:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8fvEvbhezyhAD/JaVvzpm35s4e3Vo4GoAsKe1XU2BY=;
        b=I1waEiAaSOGaB7FhyCa4FAJa7krJPmn8BIfms90lC7p/3Id3y7IRZhayZA2MpSRAvn
         yn15MGZuTzafO6XfqoMAAumiYBOXt001rgv6HCkNSm0TNXx2o5h74ItsD2MhvWbZyvsR
         2RUGutNl2C8UGfjtCRshDYBzW45N0+z5132/zkT8mpr1qioxd4KUQGSU0cv5z1uaBdxr
         cqXmSaaxdcUXgmVTEjatzai77dghPxYS3gr371+w87W36fX1AW82R2GuVxP76lOSIDvl
         zS2diBNIuLcigE79Ht3jfhUdCfdaoBD43rA1KRrOc3lcwf2saUatgzMhzfuAOmdSCUCQ
         bMzA==
X-Gm-Message-State: ANoB5pnC2cajzf2TZgfygOcmr0lK9XfI8P1QmDQj0X8tkYuN9LJCLiq0
        ZVPPPUSITknChaczgsOYe2kKdVYfWuQUnmuFUWhBa3qK1rXD+f835Yy0vRte5FopX5AhCal/PEd
        62c+whqiKTeq6ugptye6A
X-Received: by 2002:a02:cb58:0:b0:375:978b:53b with SMTP id k24-20020a02cb58000000b00375978b053bmr5474075jap.218.1668888493729;
        Sat, 19 Nov 2022 12:08:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6+jR8Ngnfrt+h4llJ6DicydOAxJ/sZSHHCxlVRnzOAhlghFuX9CeICiWlJI/VW/jiZOrM+gw==
X-Received: by 2002:a02:cb58:0:b0:375:978b:53b with SMTP id k24-20020a02cb58000000b00375978b053bmr5474069jap.218.1668888493356;
        Sat, 19 Nov 2022 12:08:13 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id e32-20020a026d60000000b003733e2ce4e8sm2459211jaf.59.2022.11.19.12.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 12:08:12 -0800 (PST)
Date:   Sat, 19 Nov 2022 13:08:11 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Resizable BARs vs bridges with BARs
Message-ID: <20221119130811.718920ec.alex.williamson@redhat.com>
In-Reply-To: <e10c6093-6ca5-e669-af0b-bd91514b6371@amd.com>
References: <20221118160916.7e165306.alex.williamson@redhat.com>
        <fe0e40cb-b982-2aba-b622-8534c174ea39@amd.com>
        <20221119070741.7038464f.alex.williamson@redhat.com>
        <e10c6093-6ca5-e669-af0b-bd91514b6371@amd.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christian,

On Sat, 19 Nov 2022 20:14:15 +0100
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
> Am 19.11.22 um 15:07 schrieb Alex Williamson:
> > On Sat, 19 Nov 2022 12:02:55 +0100
> > Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
> >> Am 19.11.22 um 00:09 schrieb Alex Williamson: =20
> >>> I'm trying to get resizable BARs working in a configuration where my
> >>> root bus resources provide plenty of aperture for the BAR:
> >>>
> >>> pci_bus 0000:5d: root bus resource [io  0x8000-0x9fff window]
> >>> pci_bus 0000:5d: root bus resource [mem 0xb8800000-0xc5ffffff window]
> >>> pci_bus 0000:5d: root bus resource [mem 0xb000000000-0xbfffffffff win=
dow] <<<
> >>> pci_bus 0000:5d: root bus resource [bus 5d-7f]
> >>>
> >>> But resizing fails with -ENOSPC.  The topology looks like this:
> >>>
> >>>    +-[0000:5d]-+-00.0-[5e-61]----00.0-[5f-61]--+-01.0-[60]----00.0  I=
ntel Corporation DG2 [Arc A380]
> >>>                                                \-04.0-[61]----00.0  I=
ntel Corporation Device 4f92
> >>>
> >>> The BIOS is not fluent in resizable BARs and only programs the root
> >>> port with a small aperture:
> >>>
> >>> 5d:00.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Por=
t A (rev 07) (prog-if 00 [Normal decode])
> >>>           Bus: primary=3D5d, secondary=3D5e, subordinate=3D61, sec-la=
tency=3D0
> >>>           I/O behind bridge: 0000f000-00000fff [disabled]
> >>>           Memory behind bridge: b9000000-ba0fffff [size=3D17M]
> >>>           Prefetchable memory behind bridge: 000000bfe0000000-000000b=
ff07fffff [size=3D264M]
> >>>           Kernel driver in use: pcieport
> >>>
> >>> The trouble comes on the upstream PCIe switch port:
> >>>
> >>> 5e:00.0 PCI bridge: Intel Corporation Device 4fa1 (rev 01) (prog-if 0=
0 [Normal decode]) =20
> >>>      >>>  Region 0: Memory at b010000000 (64-bit, prefetchable) =20
> >>>           Bus: primary=3D5e, secondary=3D5f, subordinate=3D61, sec-la=
tency=3D0
> >>>           I/O behind bridge: 0000f000-00000fff [disabled]
> >>>           Memory behind bridge: b9000000-ba0fffff [size=3D17M]
> >>>           Prefetchable memory behind bridge: 000000bfe0000000-000000b=
fefffffff [size=3D256M]
> >>>           Kernel driver in use: pcieport
> >>>
> >>> Note region 0 of this bridge, which is 64-bit, prefetchable and
> >>> therefore conflicts with the same type for the resizable BAR on the G=
PU:
> >>>
> >>> 60:00.0 VGA compatible controller: Intel Corporation DG2 [Arc A380] (=
rev 05) (prog-if 00 [VGA controller])
> >>>           Region 0: Memory at b9000000 (64-bit, non-prefetchable) [di=
sabled] [size=3D16M]
> >>>           Region 2: Memory at bfe0000000 (64-bit, prefetchable) [disa=
bled] [size=3D256M]
> >>>           Expansion ROM at <ignored> [disabled]
> >>>           Capabilities: [420 v1] Physical Resizable BAR
> >>>                   BAR 2: current size: 256MB, supported: 256MB 512MB =
1GB 2GB 4GB 8GB
> >>>
> >>> It's a shame that the hardware designers didn't mark the upstream port
> >>> BAR as non-prefetchable to avoid it living in the same resource
> >>> aperture as the resizable BAR on the downstream device. =20
> >> This is expected. Bridges always have a 32bit non prefetchable and a
> >> 64bit prefetchable BAR. This is part of the PCI(e) spec. =20
> > To be clear, the issue is a bridge implementing a 64-bit, prefetchable
> > BAR at config offset 0x10 & 0x14, not the limit/base registers that
> > define the bridge windows for prefetchable and non-prefetchable
> > downstream resources. =20
>=20
> WHAT? I've never heard of a bridge with this configuration. I don't=20
> fully remember the spec, but I'm pretty sure that this isn't something=20
> standard.

Type1 config space allows for two standard BARs.

> Can you give me the output of "sudo lspci -vvvv -s $busID" for this devic=
e.

5e:00.0 PCI bridge: Intel Corporation Device 4fa1 (rev 01) (prog-if 00 [Nor=
mal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 42
	NUMA node: 0
	IOMMU group: 1
	Region 0: Memory at bff0000000 (64-bit, prefetchable) [size=3D8M]
	Bus: primary=3D5e, secondary=3D5f, subordinate=3D61, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff [disabled]
	Memory behind bridge: b9000000-ba0fffff [size=3D17M]
	Prefetchable memory behind bridge: 000000bfe0000000-000000bfefffffff [size=
=3D256M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] Express (v2) Upstream Port, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 75.000W
		DevCtl:	CorrErr- NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 16GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <4=
us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (downgraded), Width x8 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP+ LTR+
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS+
			 AtomicOpsCap: Routing+ 32bit+ 64bit+ 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: EgressBlck+
		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 2Retimers=
+ DRS+
		LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ Equaliz=
ationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: Upstream Port
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+ RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP+ FCP+ CmpltTO+ CmpltAbrt+ UnxCmplt- RxOF+ MalfTLP+=
 ECRC+ UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr+ BadTLP+ BadDLLP+ Rollover+ Timeout+ AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCC=
hkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [148 v1] Power Budgeting <?>
	Capabilities: [158 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [178 v1] Physical Layer 16.0 GT/s <?>
	Capabilities: [1a0 v1] Lane Margining at the Receiver <?>
	Capabilities: [1d4 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [1dc v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=3D10us PortTPowerOnTime=3D14us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
		L1SubCtl2: T_PwrOn=3D10us
	Capabilities: [1f8 v1] Vendor Specific Information: ID=3D0002 Rev=3D4 Len=
=3D100 <?>
	Capabilities: [2f8 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D038 <?>
	Capabilities: [330 v1] Data Link Feature <?>
	Kernel driver in use: pcieport

> >>> In any case, it's my understanding that our bridge drivers don't gene=
rally make use
> >>> of bridge BARs.  I think we can test whether a driver has done a
> >>> pci_request_region() or equivalent by looking for the IORESOURCE_BUSY
> >>> flag, but I also suspect this is potentially racy. =20
> >> That sounds like we have a misunderstanding here how those bridges wor=
k.
> >> The upstream bridges should include all the resources of the downstream
> >> devices/bridges in their BARs. =20
> > Correct, and the issue is that the bridge at 5e:00.0 _consumes_ a
> > portion of the window we need to resize at the root port.
> >
> > Root port:
> > Prefetchable memory behind bridge: 000000bfe0000000-000000bff07fffff [s=
ize=3D264M]
> >
> > Upstream switch port:
> > Region 0: Memory at b010000000 (64-bit, prefetchable)
> > Prefetchable memory behind bridge: 000000bfe0000000-000000bfefffffff [s=
ize=3D256M]
> >
> > It's that Region 0 resource that prevents resizing. =20
>=20
> Could it be that some of the ACPI tables are broken and because of this=20
> we add a fixed resource to this device?

The switch is part of a plug-in card, I'd not expect ACPI to be
involved.  It's just a standard BAR:

# setpci -s 5e:00.0 BASE_ADDRESS_0
f000000c
# setpci -s 5e:00.0 BASE_ADDRESS_1
000000bf
# setpci -s 5e:00.0 BASE_ADDRESS_0=3Dffffffff
# setpci -s 5e:00.0 BASE_ADDRESS_1=3Dffffffff
# setpci -s 5e:00.0 BASE_ADDRESS_0
ff80000c
# setpci -s 5e:00.0 BASE_ADDRESS_1
ffffffff

All this would have transparently worked if they would have chosen to
implement a non-prefetchable BAR.

> Otherwise I have a hard time coming up with a way for a bridge to have a=
=20
> BAR in the config space.

It's a standard part of the Type1 config header.

> >>> The patch below works for me, allowing the new resourceN_resize sysfs
> >>> attribute to resize the root port window within the provided bus
> >>> window.  Is this the right answer?  How can we make it feel less
> >>> sketchy?  Thanks, =20
> >> The correct approach is to remove all the drivers (EFI, vesafb etc...)
> >> which are using the PCI(e) devices under the bridge in question. Then
> >> release the resources and puzzle everything back together.
> >>
> >> See amdgpu_device_resize_fb_bar() how to do this correctly. =20
> > Resource resizing in pci-sysfs is largely modeled after the amdgpu
> > code, but I don't see any special provisions for handling conflicting
> > resources consumed on intermediate devices.  The driver attached to the
> > upstream switch port is pcieport and removing it doesn't resolve the
> > problem.  The necessary resource on the root port still reports a
> > child.
> >
> > Is amdgppu resizing known to work in cases where the GPU is downstream
> > of a PCIe switch that consumes resources of the same type and the root
> > port aperture needs to be resized?  I suspect it does not.  Thanks, =20
>=20
> Well we have the possibility to add extra space to bridges on the kernel=
=20
> command line for this.
>=20
> This is used for things like hotplug behind bridges with limited address=
=20
> space.

AFAIK, this is only for hotplug slots, my root port is HotPlug-.

I'd also like to make pci=3Drealloc aware of resizable BARs, but it hits
the same problem.  Thanks,

Alex

