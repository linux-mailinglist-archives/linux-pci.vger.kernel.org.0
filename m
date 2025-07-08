Return-Path: <linux-pci+bounces-31719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0E4AFD5E8
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 20:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B88F3B98B8
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28957BE5E;
	Tue,  8 Jul 2025 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED1Wl1eo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D38B1E521B
	for <linux-pci@vger.kernel.org>; Tue,  8 Jul 2025 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997755; cv=none; b=lxOw4bBrJ24YNqzq2clNQO1yWACY7YUi13KVu6K+llDLJcF7mTQLU9KDljxB7VDmKRpF0TPfAiu8CWKWd8L9ClJ3fs62AG9yn61F2TlRk6cbspbDaVcFU9Os2MahISTHaUyBliuML8EnxKvKnP4up/9+55fI0ov0kVMxQe/MGRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997755; c=relaxed/simple;
	bh=cx0wuwTK8eva4iuN07a/PvNxXVlH//x01vZIIXeKm6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfkY+x+/S4LvvM8VMUObr4feiFwkg/bqzzG1EtdlQaXAudbZcsPBz0TjtnC9ixoX9jib2hg+f7cqDIxLo7ndyxZTNux3SXR38PtU37b5iThxaPV37gJQ0pjz9Ss/oKwn/VzRKTK46UGcFKXbnh8ZZ7yJIVelfD/likMlVNmgIek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED1Wl1eo; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31393526d0dso3248862a91.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Jul 2025 11:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751997752; x=1752602552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUgMjypplR5JlyXrFKfyizTu2WJedl6fSp8GL4wsqfs=;
        b=ED1Wl1eoxwIVOOUjBjk1ivrvb+gIouWboGIAUnHtZWRD+QYxU1wkE+d8MIfPqwJNyK
         HoOccZObBB22dv8eRu0o+fn4uSmHt7rjlSmL6pcalTzLrXHbXrFUIR0c82qDbEisJCav
         B2BdPjZL0FVmeHy2UTCl3UpyLAh+LTBjx88t5+0xwU/vR8tVjS7xIv/4+J4st6VmvBe7
         lHsl5zE3WKESgheG3zuZxDThgN1F84doZDfVxEzuzxaMRzNGjLoy+s5iN7sQkkIQg9ZW
         CKWKgrnXJjwdiqkYvdMaVXt46NBrVFDJY83lUQSSbEvVPnfl1D4pmpczhh5kIo+LpK+1
         oaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997752; x=1752602552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUgMjypplR5JlyXrFKfyizTu2WJedl6fSp8GL4wsqfs=;
        b=M4JXrS8SRWdGVM+z7TxRQn6LDEnq73t5RQzE+pjtW3BF0oCImBOZerTXuE4p6Y7Jta
         Bs/axWldQBL+ec03St6Kw34shOZLKEkInuSrQxerqVx0JmuF3sPZWYPZxumzP3xcF0gp
         TYqE5ur8fta1gM73vIf1ChNqH7jlanFKrr/8+MQCQciWQCRYyZp4YMRmW1wDMZc/jOGD
         l7wHZd1m8XHoI644nXIncD0SVAdJ1ccpUvexQSd6e+zRpZG61/PanzyFWIbYPjod3I4b
         Tk9zNxQutdL2GwPjyZooqViyGeBic+curhxXFG3u8kcJuEBVyoj96ZyuyTAl5FLsGsq/
         rMNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXguJJ1K0C3V/Bwe82flHHbibBvDn20AhqEDHxUS0mS5R/BvfQ2F10dPHw4j/ZYBqsEE65m2yLRiDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOELxctKZg1WYXJXvuM2z/NoUw9GqF35NNmmN/cRDj3fACeY/Y
	kr31bAj3ePtWLR6WX/+I03TXUFpEi/ogpdV8FGSrnBWp4QrFE8yARM+uz6CdtmTACA96hRRSyxn
	AmpCwV0XSJA/huHXo1Tr1EXuF5IGAgjI=
X-Gm-Gg: ASbGnctgbaBwmUO6DWrTCrcABtKMYrt1RS5CPPplXMz2eobfKcN8CJ/9pnxpIahKmiJ
	rJpuQHetfSqcEfle0q49UE3C1GjQI8cLod/B0hvEqU655gAMjafFsljHm6Qz2q4fW1+DItAFpLG
	Kyh91CqTRLXDoKfZ6RExn4ma3ezz9T91gBAWMgCS2o
X-Google-Smtp-Source: AGHT+IGOUnzpA8m5jxLXYRNVyWbyKUlYurVGlDrUizwY+JnNnjxhk+JEMeIPxV/aGAe/3tzxgfqGUFnugHspToT9/eg=
X-Received: by 2002:a17:90b:5345:b0:312:e8ed:758 with SMTP id
 98e67ed59e1d1-31c2ee1df22mr64845a91.13.1751997751798; Tue, 08 Jul 2025
 11:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410220915.GA326095@bhelgaas> <2f33f07841d5a20a1eb14c73b2c3000dd45a031b.camel@linux.intel.com>
 <CAONYan-arCi710Fz1VFwRd75=1YM+hPCDnMJa17sffPzzoMR7Q@mail.gmail.com>
In-Reply-To: <CAONYan-arCi710Fz1VFwRd75=1YM+hPCDnMJa17sffPzzoMR7Q@mail.gmail.com>
From: Sergey Dolgov <sergey.v.dolgov@gmail.com>
Date: Tue, 8 Jul 2025 19:02:20 +0100
X-Gm-Features: Ac12FXz2CzBYsKcNb158TTJVybieczEFYJaHBoJcSWx61W-uvlLHLY3JD4DrRyg
Message-ID: <CAONYan_vwFo8QHUAcNCccmMFVzRgLmRw1NZMSf5-FtbuJio0Tg@mail.gmail.com>
Subject: Re: [Bug 219984] New: [BISECTED] High power usage since 'PCI/ASPM:
 Correct LTR_L1.2_THRESHOLD computation'
To: david.e.box@linux.intel.com
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Artem S. Tashkinov" <aros@gmx.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Bjorn,

so, any interest in sending your patch upstream? Have you tested it on
other devices? I have no other laptops I can boot Linux on, but I have
upgraded the SSD a month ago, and the new one works fine without
errors in SMART or DevSta at width x4 (max at my PCIe 3.0 port) with
the same LTR1.2_Threshold of 81920ns.

Thanks.
Sergey.



Sergey.

On Tue, May 6, 2025 at 12:57=E2=80=AFPM Sergey Dolgov <sergey.v.dolgov@gmai=
l.com> wrote:
>
> Dear David,
>
> I've seen only the following SOUTHPORT LTR values in different
> combinations depending on device activity:
>
> ######## No disk activity but varying workload otherwise (idle CPU,
> NVIDIA GPU sleeping or not, glxgears on either Intel or NVIDIA GPU,
> audio playback or not): LTR values fluctuate between
> 0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
> 1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
> 8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x90039003
>          Non-Snoop(ns): 3145728          Snoop(ns): 3145728
>   LTR_IGNORE: 0
> 12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
> 13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
>
> and
>
> 0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
> 1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
> 8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x90039003
>          Non-Snoop(ns): 3145728          Snoop(ns): 3145728
>   LTR_IGNORE: 0
> 12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x88b688b6
>          Non-Snoop(ns): 186368           Snoop(ns): 186368
>   LTR_IGNORE: 0
> 13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
>
>
> SOUTHPORT_D is probably connected to the wifi:
>
> ######## ping -A `ip route list default | awk '{print $3}'` : LTR
> values are constant at
> 0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
> 1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
> 8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x90039003
>          Non-Snoop(ns): 3145728          Snoop(ns): 3145728
>   LTR_IGNORE: 0
> 12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x88b688b6
>          Non-Snoop(ns): 186368           Snoop(ns): 186368
>   LTR_IGNORE: 0
> 13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
>
> In contrast, with RFKILL'd wifi and bluetooth SOUTHPORT_D LTRs are all 0.
>
> SOUTHPORT_C is probably connected to the NVMes:
>
> ########  du -ch /
> 0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
> 1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
> 8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x88468846
>          Non-Snoop(ns): 71680            Snoop(ns): 71680
>   LTR_IGNORE: 0
> 12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
> 13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
>
> 0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
> 1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
> 8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x880a880a
>          Non-Snoop(ns): 10240            Snoop(ns): 10240
>   LTR_IGNORE: 0
> 12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x88b688b6
>          Non-Snoop(ns): 186368           Snoop(ns): 186368
>   LTR_IGNORE: 0
> 13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
>
> 0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
> 1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
> 8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x880a880a
>          Non-Snoop(ns): 10240            Snoop(ns): 10240
>   LTR_IGNORE: 0
> 12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
> 13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
>          Non-Snoop(ns): 0                Snoop(ns): 0
>   LTR_IGNORE: 0
>
>
> These values are independent of the kernel (original 6.14.0 or that
> with Bjorn's patch skipping L1.2 config).
>
> Thanks.
> Sergey.
>
>
> On Fri, May 2, 2025 at 10:30=E2=80=AFPM David E. Box
> <david.e.box@linux.intel.com> wrote:
> >
> > Hi all,
> >
> > On Thu, 2025-04-10 at 17:09 -0500, Bjorn Helgaas wrote:
> > > On Thu, Apr 10, 2025 at 02:59:41PM +0100, Sergey Dolgov wrote:
> > > > Dear Bjorn,
> > > >
> > > > one (probably the main) power user is the CPU at shallow C states p=
ost
> > > > 7afeb84d14ea. Even at some load (like web browsing) the CPU spends
> > > > most time in C7 after reverting 7afeb84d14ea, in contrast to C3 eve=
n
> > > > at idle in the original 6.14.0. So the main question is what can ma=
ke
> > > > the CPU busy with larger LTR_L1.2_THRESHOLDs?
> > >
> > > That's a good question and I have no idea what the answer is.
> > > Obviously a larger LTR_L1.2_THRESHOLD means less time in L1.2, but I
> > > don't know how that translates to CPU C states.
> > >
> > > These bugs:
> > >
> > >   https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> > >   https://bugzilla.kernel.org/show_bug.cgi?id=3D215832
> > >
> > > mention C states and ASPM.  I added some of those folks to cc.
> > >
> > > > I do have Win10 too, but neither Win binaries of pciutils nor Devic=
e
> > > > Manager show LTR_L1.2_THRESHOLD. lspci -vv run as Administrator doe=
s
> > > > report some "latencies" though. Some of them are significantly
> > > > smaller, e.g. "Exit Latency L0s <1us, L1 <16us" for the bridge
> > > > 00:1d.6, others are significantly larger, e.g. "Exit Latency L1
> > > > unlimited" for the NVMe 6e:00.0, than the LTR_L1.2_THRESHOLDs
> > > > calculated by Linux. The full log is attached.
> > >
> > > I think I'm missing your point here.  The L0s/L1 Acceptable Latencies
> > > and the L0s/L1 Exit Latencies I see in your Win10 lspci are the same
> > > as in Windows, which is what I would expect because these are
> > > read-only Device and Link Capability registers and the OS can't
> > > influence them:
> > >
> > >   00:1d.6 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express R=
oot Port
> > > #15
> > >     LnkCap: Port #15, Speed 8GT/s, Width x1, ASPM L0s L1, Exit Latenc=
y L0s
> > > <1us, L1 <16us
> > >
> > >   6e:00.0 Non-Volatile memory controller: Intel Corporation Optane NV=
ME SSD
> > > H10
> > >     DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited,=
 L1
> > > unlimited
> > >     LnkCap: Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit Latency L1 =
unlimited
> > >
> > > The DevCap L0s and L1 Acceptable Latencies are "the acceptable total
> > > latency that an Endpoint can withstand due to transition from L0s or
> > > L1 to L0.  It is essentially an indirect measure of the Endpoint's
> > > internal buffering."
> > >
> > > The LnkCap L0s and L1 Exit Latencies are the "time the Port requires
> > > to complete transitions from L0s or L1 to L0."
> > >
> > > I don't know how to relate LTR_L1.2_THRESHOLD to L1.  I do know that
> > > L0s and L1 were part of PCIe r2.1, but it wasn't until r3.1 that the
> > > L1.1 and L1.2 substates were added and L1 was renamed to L1.0.  So I
> > > expect the L1 latencies to be used to enable L1.0 by itself, and I
> > > assume LTR and LTR_L1.2_THRESHOLD are used separately to further
> > > enable L1.2.
> > >
> > > > But do we need to care about precise values? At least we know now t=
hat
> > > > 7afeb84d14ea has only increased the thresholds, slightly. What happ=
ens
> > > > if they are underestimated? Can this lead to severe problems, e.g.
> > > > data corruption on NVMes?
> > >
> > > IIUC, LTR messages are essentially a way for the device to say "I hav=
e
> > > enough local buffer space to hold X ns worth of traffic while I'm
> > > waiting for the link to return to L0."
> > >
> > > Then we should only put the link in L1.2 if we can get to L1.2 and
> > > back to L0 in X ns or less, and LTR_L1.2_THRESHOLD is basically the
> > > minimum L0 -> L1.2 -> L0 time.
> > >
> > > If we set LTR_L1.2_THRESHOLD lower than it should be, it seems like
> > > we're at risk of overrunning the device's local buffer.  Maybe that's
> > > OK and the device needs to be able to tolerate that, but it does feel
> > > risky to me.
> > >
> > > There's also the LTR Capability that "specifies the maximum latency a
> > > device is permitted to request.  Software should set this to the
> > > platform's maximum supported latency or less."  Evidently drivers can
> > > set this (only amdgpu does, AFAICS), but I have no idea how to use it=
.
> > >
> > > I suppose setting it to something less than LTR_L1.2_THRESHOLD might
> > > cause L1.2 to be used more?  This would be writable via setpci, and i=
t
> > > looks like it can be updated any time.  If you want to play with it,
> > > the value and scale are encoded the same way as
> > > encode_l12_threshold(), and PCI_EXT_CAP_ID_LTR and related #defines
> > > show the register layouts.
> > >
> > > > If not (and I've never seen one using 5.15 kernels for 4 years), ca=
n
> > > > we reprogram LTR_L1.2_THRESHOLDs at runtime?  Like for the CPU,
> > > > introduce 'performance' and 'powersave' governors for the PCI, whic=
h
> > > > set the thresholds to, say, 2x and 0.5x (2 + 4 + t_common_mode +
> > > > t_power_on), respectively.
> > >
> > > I don't think I would support a sysfs or similar interface to tweak
> > > this.  Right now computing LTR_L1.2_THRESHOLD already feels like a bi=
t
> > > of black magic, and tweaking it would be farther down the road of
> > > "well, it seems to help this situation, but we don't really know why.=
"
> > >
> > > > On Wed, Apr 9, 2025 at 12:18=E2=80=AFAM Bjorn Helgaas <helgaas@kern=
el.org> wrote:
> > > > >
> > > > > On Tue, Apr 08, 2025 at 09:02:46PM +0100, Sergey Dolgov wrote:
> > > > > > Dear Bjorn,
> > > > > >
> > > > > > here are both dmesg from the kernels with your info patch.
> > > > >
> > > > > Thanks again!  Here's the difference:
> > > > >
> > > > >   - pre  7afeb84d14ea
> > > > >   + post 7afeb84d14ea
> > > > >
> > > > >    pci 0000:02:00.0: parent CMRT 0x28 child CMRT 0x00
> > > > >    pci 0000:02:00.0: parent T_POWER_ON 0x2c usec (val 0x16 scale =
0)
> > > > >    pci 0000:02:00.0: child  T_POWER_ON 0x0a usec (val 0x5 scale 0=
)
> > > > >    pci 0000:02:00.0: t_common_mode 0x28 t_power_on 0x2c l1_2_thre=
shold
> > > > > 0x5a
> > > > >   -pci 0000:02:00.0: encoded LTR_L1.2_THRESHOLD value 0x02 scale =
3
> > > > >   +pci 0000:02:00.0: encoded LTR_L1.2_THRESHOLD value 0x58 scale =
2
> > > > >
> > > > > We computed LTR_L1.2_THRESHOLD =3D=3D 0x5a =3D=3D 90 usec =3D=3D =
90000 nsec.
> > > > >
> > > > > Prior to 7afeb84d14ea, we computed *scale =3D 3, *value =3D (9000=
0 >> 15)
> > > > > =3D=3D 0x2.  But per PCIe r6.0, sec 6.18, this is a latency value=
 of only
> > > > > 0x2 * 32768 =3D=3D 65536 ns, which is less than the 90000 ns we r=
equested.
> > > > >
> > > > > After 7afeb84d14ea, we computed *scale =3D 2, *value =3D
> > > > > roundup(threshold_ns, 1024) / 1024 =3D=3D 0x58, which is a latenc=
y value
> > > > > of 90112 ns, which is almost exactly what we requested.
> > > > >
> > > > > In essence, before 7afeb84d14ea we tell the Root Port that it can
> > > > > enter L1.2 and get back to L0 in 65536 ns or less, and after
> > > > > 7afeb84d14ea, we tell it that it may take up to 90112 ns.
> > > > >
> > > > > It's possible that the calculation of LTR_L1.2_THRESHOLD itself i=
n
> > > > > aspm_calc_l12_info() is too conservative, and we don't actually n=
eed
> > > > > 90 usec, but I think the encoding done by 7afeb84d14ea itself is =
more
> > > > > correct.  I don't have any information about how to improve 90 us=
ec
> > > > > estimate.  (If you happen to have Windows on that box, it would b=
e
> > > > > really interesting to see how it sets LTR_L1.2_THRESHOLD.)
> > > > >
> > > > > If the device has sent LTR messages indicating a latency requirem=
ent
> > > > > between 65536 ns and 90112 ns, the pre-7afeb84d14ea kernel would =
allow
> > > > > L1.2 while post 7afeb84d14ea would not.  I don't think we can act=
ually
> > > > > see the LTR messages sent by the device, but my guess is they mus=
t be
> > > > > in that range.  I don't know if that's enough to account for the =
major
> > > > > difference in power consumption you're seeing.
> >
> > If the Root Port is attached to a controller in the South Complex =E2=
=80=94 which would
> > be the case on a Cannon Lake=E2=80=93based platform =E2=80=94 you can o=
bserve the resulting LTR
> > value sent from the Port using the pmc_core driver:
> >
> >     cat /sys/kernel/debug/pmc_core/ltr_show | grep SOUTHPORT
> >
> > Needs CONFIG_INTEL_PMC_CORE which the major distros set.
> >
> > The SOUTHPORTs correspond to Root Ports. Unfortunately, we don=E2=80=99=
t currently have
> > a mapping between the internal PMC SOUTHPORT_X designation and the PCI =
Bus
> > enumeration. However, since this behavior clearly affects C-state entry=
, you
> > should be able to narrow it down by monitoring this file =E2=80=94 idea=
lly capturing
> > several snapshots, as the values can change depending on device activit=
y.
> >
> > Note that the value shown may not exactly match what was sent in the LT=
R
> > message, but it won=E2=80=99t be smaller. My current assumption (pendin=
g confirmation)
> > is that simply entering L1.2 increases the effective LTR value observed=
 by the
> > CPU, since it=E2=80=99s unlikely that the LTR message value itself chan=
ges solely as a
> > result of modifying the threshold.
> >
> > Incidentally, you can also ignore the LTR from the Port by writing the =
bit value
> > (first column) to the ltr_ignore file in the same folder. This is for t=
esting
> > only as it ignores device activity. But you should see deeper C state r=
esidency
> > after ignoring the problem Port, which would be a way to narrow down th=
e
> > SOUTHPORT as well. The LTR consideration can be restored by writing the=
 same bit
> > value to the ltr_restore file.
> >
> > David
> >
> > > > >
> > > > > The AX200 at 6f:00.0 is in exactly the same situation as the
> > > > > Thunderbolt bridge at 02:00.0 (LTR_L1.2_THRESHOLD 90 usec, RP set=
 to
> > > > > 65536 ns before 7afeb84d14ea and 90112 ns after).
> > > > >
> > > > > For the NVMe devices at 6d:00.0 and 6e:00.0, LTR_L1.2_THRESHOLD i=
s
> > > > > 3206 usec (!), and we set the RP to 3145728 ns (slightly too smal=
l)
> > > > > before, 3211264 ns after.
> > > > >
> > > > > For the RTS525A at 70:00.0, LTR_L1.2_THRESHOLD is 126 usec, and w=
e set
> > > > > the RP to 98304 ns before, 126976 ns after.
> > > > >
> > > > > Sorry, no real answers here yet, still puzzled.
> > > > >
> > > > > Bjorn
> > >
> > >
> >

