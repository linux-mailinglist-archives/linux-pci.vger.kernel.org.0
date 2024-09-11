Return-Path: <linux-pci+bounces-13063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F80D975CEF
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 00:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9A61F23B59
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 22:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B530D176AA9;
	Wed, 11 Sep 2024 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bnj97R6S"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C315098F
	for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2024 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726092774; cv=none; b=k+/TRyWDubUIiCfFChDb2yiOH/KIHqBl/h15Obkt23T3iQtWEmKOr/PjiPHxufGcZ5QNVzcoXbRt9jaPPQTjbzsHosJmMI2NVamJXxQRESeAMMbW6PLkCkIwWZMMXJrazjpvqVvgqPh6wFA5FlGGyFdVNV6cFDG+dQt8Iiy7D/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726092774; c=relaxed/simple;
	bh=NYXgSuA+0WFfcSQnsHH6qp6vrNapxzh7jzPSICAhUQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2yVkxfXu62Yx+jRtrZ8DL4GTZ6Q/8+O9bjRcCLL1K8gJuorJ8GEc59B0+qv+S4wyQ/sC8M0Us8wdnNTElJUKT37yYb/y1XOmouwASyLSiWe3Edik2OrefpjobXM25KsBRcdaMO5+XW3PuFgeZtuomGKKvHn6EJfh9mh8S1yxlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bnj97R6S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726092772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1pCeESPNBVhMgdnisZiLl5MZQpZJwy5Dpq1bGy51vA=;
	b=Bnj97R6SXrgZQEDfe+FFvpvxFEvwQSxuk3R22hHCywp6PaHclbpDZLG8gUGKjvmLGnRsjS
	A9tWC5kNU/OvdbrSv3W7WIMJA5ESjGfbdTjT1qmUmdc/lIgPEgtphbqXiqC9J2EMdF7cUp
	fKEs+vlgCHDZrbFRcJZtatdpkbV58Os=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549--RVios3vO6uOR9GzrXzv1g-1; Wed, 11 Sep 2024 18:12:50 -0400
X-MC-Unique: -RVios3vO6uOR9GzrXzv1g-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82d2218c6b3so3106139f.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2024 15:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726092770; x=1726697570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1pCeESPNBVhMgdnisZiLl5MZQpZJwy5Dpq1bGy51vA=;
        b=FG2dzSzG8hGLtpusY4Vz1u4034sTVgiUsU2HqgGES2qTE6/CTFBYryQlfOB1N4M4n6
         /BTfTGRpk8n3Kt09SY6AohKCQZS8yFiQ5z4IZEO2T/sQEXOi1v2vh5j8DrtpY0i1WqJV
         gvq7wuW0ETCvofDgbYuM4TnovqY0McpEbfok12DVJmMHlMgdU4dNdmumemXOK/8IpZNP
         wGTepcwmguex70c001UmU8Rl7+e2Y796fDZ7X+rWUQXXAwl2QqdmVpkhnhkHOdty9WKL
         EJnUuav8YWKMQHF0bc4rnQWn8ikVIgJPhlZC8JSaOAi/+xck/bcf7n5dX2yyVC3fA87B
         SWUw==
X-Forwarded-Encrypted: i=1; AJvYcCUSDg6R0MPWn+JxxDjwBTfIW21gqJeAzxpXbZcxs7TnhiNuDkrKXSu0mSrOWh9XivoHMqFRFpGJyAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0SPVib6sM7DImCDCwhgPUDZ2bpl2srpPGOmhA9nv+Zc3kyNBJ
	wCHrfno3LemaObalT9o2hud/G5ap+Ygol6d0NKRRX6mOD4jHBtF89MJls7mtAMgCVybhgnGw6Xn
	TArg7aWAS9jTP8kHNPtjR8zIHm5xmHhv+hr6A27mfcW4W02d7CNZlqi1YTg==
X-Received: by 2002:a5e:8b4a:0:b0:82a:a4f0:963b with SMTP id ca18e2360f4ac-82d1f98ef7amr33380439f.4.1726092769821;
        Wed, 11 Sep 2024 15:12:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL62LzYYJxiLBBcLdGSSWST2aHzY8lEq9OoEMEiSMhL0W7j0UVnM9d4Z/oSt5KgckbdhFkog==
X-Received: by 2002:a5e:8b4a:0:b0:82a:a4f0:963b with SMTP id ca18e2360f4ac-82d1f98ef7amr33379739f.4.1726092769392;
        Wed, 11 Sep 2024 15:12:49 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82aa736e212sm284495239f.26.2024.09.11.15.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 15:12:48 -0700 (PDT)
Date: Wed, 11 Sep 2024 16:12:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: zdravko delineshev <delineshev@outlook.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, kvm@vger.kernel.org
Subject: Re: nointxmask device
Message-ID: <20240911161248.1f05d7da.alex.williamson@redhat.com>
In-Reply-To: <20240910134918.GA579571@bhelgaas>
References: <VI1PR10MB8207C507DB5420AB4C7281E0DB9A2@VI1PR10MB8207.EURPRD10.PROD.OUTLOOK.COM>
	<20240910134918.GA579571@bhelgaas>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Sep 2024 08:49:18 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex, kvm]
>=20
> On Tue, Sep 10, 2024 at 01:13:41PM +0000, zdravko delineshev wrote:
> >=20
> > Hello,
> >=20
> > i found a note in the vfio-pci parameters to email devices fixed by the=
 nointxmask parameter.
> >=20
> > Here is the one i have and i am trying to pass trough. it is currently =
working fine, with nointxmask=3D1 .

What are the symptoms without using nointxmask=3D1?  Please provide any
dmesg snippets in the host related to using this device.

> > 81:00.0 Audio device: Creative Labs EMU20k2 [Sound Blaster X-Fi Titaniu=
m Series] (rev 03)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Subsystem: Creative Labs EMU20k2 [Sound Bla=
ster X-Fi Titanium Series]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Control: I/O- Mem+ BusMaster+ SpecCycle- Me=
mWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- D=
EVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Latency: 0, Cache Line Size: 32 bytes
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Interrupt: pin A routed to IRQ 409
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 NUMA node: 1
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 IOMMU group: 23
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Region 0: Memory at d3200000 (64-bit, non-p=
refetchable) [size=3D64K]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Region 2: Memory at d3000000 (64-bit, non-p=
refetchable) [size=3D2M]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Region 4: Memory at d2000000 (64-bit, non-p=
refetchable) [size=3D16M]
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [40] Power Management version=
 3
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Flags: PMEClk- =
DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: D0 NoSo=
ftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [48] MSI: Enable- Count=3D1/1=
 Maskable- 64bit+
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Address: 000000=
0000000000 =C2=A0Data: 0000

The device supports MSI, but the snd-ctxfs driver we have in the Linux
kernel has no support for it, therefore reporting zero for the INTx pin
is not an option.

Are you able to verify a kernel patch?

Adding it to the existing broken INTx quirk should simply be:

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a2ce4e08edf5..c7596e9aabb0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3608,6 +3608,8 @@ DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2=
800 802.11n PCI */
 			quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(0x1b7c, 0x0004, /* Ceton InfiniTV4 */
 			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CREATIVE, PCI_DEVICE_ID_CREATIVE_20K=
2,
+			quirk_broken_intx_masking);
=20
 /*
  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)


Thanks,
Alex

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [58] Express (v2) Endpoint, M=
SI 00
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DevCap: MaxPayl=
oad 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimi=
t 0W
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DevCtl: CorrErr=
- NonFatalErr- FatalErr+ UnsupReq-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 MaxPayload 128 bytes, MaxReadReq 512 bytes
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DevSta: CorrErr=
- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LnkCap: Port #0=
, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LnkCtl: ASPM Di=
sabled; RCB 64 bytes, Disabled- CommClk-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LnkSta: Speed 2=
.5GT/s, Width x1
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DevCap2: Comple=
tion Timeout: Range ABCD, TimeoutDis- NROPrPrP- LTR-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A010BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- =
EETLPPrefix-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0EmergencyPowerReduction Not Supported, EmergencyPowerRe=
ductionInit-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0FRS- TPHComp- ExtTPHComp-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DevCtl2: Comple=
tion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AtomicOpsCtl: ReqEn-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LnkCtl2: Target=
 Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Transmit Margin: Normal Operating Range, EnterModifiedC=
ompliance- ComplianceSOS-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB pr=
eshoot
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LnkSta2: Curren=
t De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0EqualizationPhase2- EqualizationPhase3- LinkEqualizatio=
nRequest-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Retimer- 2Retimers- CrosslinkRes: unsupported
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [100 v1] Device Serial Number=
 ff-ff-ff-ff-ff-ff-ff-ff
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [300 v1] Advanced Error Repor=
ting
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 UESta: =C2=A0DL=
P- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- Unsup=
Req- ACSViol-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 UEMsk: =C2=A0DL=
P- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- Unsup=
Req+ ACSViol-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 UESvrt: DLP+ SD=
ES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- =
ACSViol-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CESta: =C2=A0Rx=
Err- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CEMsk: =C2=A0Rx=
Err- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AERCap: First E=
rror Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HeaderLog: 0000=
0000 00000000 00000000 00000000
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Kernel driver in use: vfio-pci
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Kernel modules: snd_ctxfi
> > 00: 02 11 0b 00 46 01 10 00 03 00 03 04 08 00 00 00
> > 10: 04 00 20 d3 00 00 00 00 04 00 00 d3 00 00 00 00
> > 20: 04 00 00 d2 00 00 00 00 00 00 00 00 02 11 44 00
> > 30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
> > 40: 01 48 03 00 00 00 00 00 05 58 80 00 00 00 00 00
> > 50: 00 00 00 00 00 00 00 00 10 00 02 00 00 80 00 00
> > 60: 14 2c 20 00 11 0c 00 00 00 00 11 00 00 00 00 00
> > 70: 00 00 00 00 00 00 00 00 00 00 00 00 0f 00 00 00
> > 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =20
>=20


