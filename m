Return-Path: <linux-pci+bounces-27280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3077AAC32A
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 13:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DB51C07999
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 11:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F01F27B515;
	Tue,  6 May 2025 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQ0KpD6D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D527C150
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746532634; cv=none; b=NQc8FHNjLhfrKmLtcu7CRrCg+l0YxY/3mt8WAA7CghvjzabOsLMoLNGRBdWf/gFl4QieRaCL7lJY+e/chQono2PyvLQzCA7bA4/XUssVxL0lp/n4/hK2vAf+8st7eQYXimwPyem73NU0NjL2c6To8MA5RtgLIeP2/JkjN5p8Ufg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746532634; c=relaxed/simple;
	bh=oMgKDWwDO8gtcd9BQgq6BoBW5LI0XEFTHsbTR9BjmmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dnujn07Tbs9PUJFmty2zWu8HTYc/PInf9lfgpfhXwvkjppRpvHl8k9Xx8CrVSlmtdumKjBUb85cB/k0/PXf21/0s7lOwb76KH03uGvo5jFlz/Ee1wDROOXu37DjJ/04h01fszgSVwPnvfbSU9ZorcLg9W7VJ2Dhy/xFIIF/I/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQ0KpD6D; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so4759438a91.1
        for <linux-pci@vger.kernel.org>; Tue, 06 May 2025 04:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746532632; x=1747137432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7XEhCL5nQobgF8fw4LS0v6wzAbBJRdtDt3WWRzigH8=;
        b=FQ0KpD6D57m6YFDGyy3yt+ZegZg2wTtbVlQiqTUDGL1fRpVCdtzEAUvie+L9e6Rewe
         Oas3R8exSyU/iJJ+h09LRyeun4fkaZXLBcIFPHDWfDPQcipi6y5WxgyV+XAvyBQRH0LS
         aOuJlP9MjzzthrPB9iqjWe+qk7+UJe+DFZGY1xBg5TlFbXAevOqfoH4pWa9Zh+FrT56t
         Lsv6sJpku2aq/lqI9CO+nx78M0ZL1TwmHJmydYnSEj+bIBW04Z162zGdYjPpFztc4LVN
         JJ3F2d8hrD/e1FPfS4Z/QCh99F675Bl8zTgEAZOe5I+8eh1DBlc+MlLWmouPzDdFti6c
         m2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746532632; x=1747137432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7XEhCL5nQobgF8fw4LS0v6wzAbBJRdtDt3WWRzigH8=;
        b=W3MeP3u401b0K/Ddd1IqOydOr60khjPm0EDPWjIj7rMDmzXhIhvZ3AM8EFqQNEDrWg
         M79BMg98nkNEfcwmasXCqUgUVyW8vN4IdhrJuxYrATU1/h+2MZ4jcIG8zsnc4rz6IfKT
         Lgy0ODFYSsqSWU6kV+FruOBkEvGexUDHsccuYWCMiIDEmkfE/jciPvWW7blCPAMjCXyO
         73z8S+YgNPY303lBVetk+hFpzccainhtyMBqZ4HxZsYtHZ8nGLpvvMWso7o87Svt8kqa
         ol5+Suk4LDAPJYliM+vEJ+zn7prPcRBep2Mpya1RAlbdj3P/vWll06PBYxvVDNAhJBrT
         WOIA==
X-Forwarded-Encrypted: i=1; AJvYcCXREIAh7kpKMpuIWjMz87GCrbqQGdi/ZdLT0/hQS2xBhXViXb3yZcqIJ3td4vYEBqStr1XbIzync+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp7aZ5xjUV+HY9PuzJ0o1ULXj5XHhcWAkpuvN09O6t19TeIA9F
	vcJ+8YMPtdd5raXkFqYuJwwmNrcN3y4O3gM40UrZJMGj5fU/2n7qQUq1YCO+lO5IjAYnJGR5Lph
	w69OuL7ZXHu0+GFtKpVpi+baC41M=
X-Gm-Gg: ASbGnctGxPSQpPptHjYA7Rdor746MyJxjaUK5CN013V7DhJ+bSZFW1+IgicHo4fjGbc
	9HqW2pb36TAmMZrqw2T8O5r6Akz6czNlGdFw0J3FkHhO6+mh0EgJL6mGN7MhrOOlgIutbPaaciH
	sn9D2d2ZBnVjOhiVBl2x7A
X-Google-Smtp-Source: AGHT+IHAdq/2RhXAzz8vwCKoL7J43G79ZdvDL9huAzBn7/BSfXPY48Gn5lzxrR+4krUz4HYYp4YzsrW9vSnXHKDGv6M=
X-Received: by 2002:a17:90b:4d0f:b0:309:f67c:aa8a with SMTP id
 98e67ed59e1d1-30a6195831amr14192689a91.5.1746532631466; Tue, 06 May 2025
 04:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410220915.GA326095@bhelgaas> <2f33f07841d5a20a1eb14c73b2c3000dd45a031b.camel@linux.intel.com>
In-Reply-To: <2f33f07841d5a20a1eb14c73b2c3000dd45a031b.camel@linux.intel.com>
From: Sergey Dolgov <sergey.v.dolgov@gmail.com>
Date: Tue, 6 May 2025 12:57:00 +0100
X-Gm-Features: ATxdqUHPCEE0T9HwBdaXk3aAMcaEa8BaRgerPQXuSzbpaxEIMReg1O22Qdelp2Y
Message-ID: <CAONYan-arCi710Fz1VFwRd75=1YM+hPCDnMJa17sffPzzoMR7Q@mail.gmail.com>
Subject: Re: [Bug 219984] New: [BISECTED] High power usage since 'PCI/ASPM:
 Correct LTR_L1.2_THRESHOLD computation'
To: david.e.box@linux.intel.com
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Artem S. Tashkinov" <aros@gmx.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear David,

I've seen only the following SOUTHPORT LTR values in different
combinations depending on device activity:

######## No disk activity but varying workload otherwise (idle CPU,
NVIDIA GPU sleeping or not, glxgears on either Intel or NVIDIA GPU,
audio playback or not): LTR values fluctuate between
0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0
1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0
8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x90039003
         Non-Snoop(ns): 3145728          Snoop(ns): 3145728
  LTR_IGNORE: 0
12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0
13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0

and

0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0
1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0
8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x90039003
         Non-Snoop(ns): 3145728          Snoop(ns): 3145728
  LTR_IGNORE: 0
12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x88b688b6
         Non-Snoop(ns): 186368           Snoop(ns): 186368
  LTR_IGNORE: 0
13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0


SOUTHPORT_D is probably connected to the wifi:

######## ping -A `ip route list default | awk '{print $3}'` : LTR
values are constant at
0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0
1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0
8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x90039003
         Non-Snoop(ns): 3145728          Snoop(ns): 3145728
  LTR_IGNORE: 0
12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x88b688b6
         Non-Snoop(ns): 186368           Snoop(ns): 186368
  LTR_IGNORE: 0
13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0

In contrast, with RFKILL'd wifi and bluetooth SOUTHPORT_D LTRs are all 0.

SOUTHPORT_C is probably connected to the NVMes:

########  du -ch /
0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0
1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0
8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x88468846
         Non-Snoop(ns): 71680            Snoop(ns): 71680
  LTR_IGNORE: 0
12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0
13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0

0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0
1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0
8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x880a880a
         Non-Snoop(ns): 10240            Snoop(ns): 10240
  LTR_IGNORE: 0
12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x88b688b6
         Non-Snoop(ns): 186368           Snoop(ns): 186368
  LTR_IGNORE: 0
13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0

0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0
1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0
8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x880a880a
         Non-Snoop(ns): 10240            Snoop(ns): 10240
  LTR_IGNORE: 0
12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0
13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
         Non-Snoop(ns): 0                Snoop(ns): 0
  LTR_IGNORE: 0


These values are independent of the kernel (original 6.14.0 or that
with Bjorn's patch skipping L1.2 config).

Thanks.
Sergey.


On Fri, May 2, 2025 at 10:30=E2=80=AFPM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Hi all,
>
> On Thu, 2025-04-10 at 17:09 -0500, Bjorn Helgaas wrote:
> > On Thu, Apr 10, 2025 at 02:59:41PM +0100, Sergey Dolgov wrote:
> > > Dear Bjorn,
> > >
> > > one (probably the main) power user is the CPU at shallow C states pos=
t
> > > 7afeb84d14ea. Even at some load (like web browsing) the CPU spends
> > > most time in C7 after reverting 7afeb84d14ea, in contrast to C3 even
> > > at idle in the original 6.14.0. So the main question is what can make
> > > the CPU busy with larger LTR_L1.2_THRESHOLDs?
> >
> > That's a good question and I have no idea what the answer is.
> > Obviously a larger LTR_L1.2_THRESHOLD means less time in L1.2, but I
> > don't know how that translates to CPU C states.
> >
> > These bugs:
> >
> >   https://bugzilla.kernel.org/show_bug.cgi?id=3D218394
> >   https://bugzilla.kernel.org/show_bug.cgi?id=3D215832
> >
> > mention C states and ASPM.  I added some of those folks to cc.
> >
> > > I do have Win10 too, but neither Win binaries of pciutils nor Device
> > > Manager show LTR_L1.2_THRESHOLD. lspci -vv run as Administrator does
> > > report some "latencies" though. Some of them are significantly
> > > smaller, e.g. "Exit Latency L0s <1us, L1 <16us" for the bridge
> > > 00:1d.6, others are significantly larger, e.g. "Exit Latency L1
> > > unlimited" for the NVMe 6e:00.0, than the LTR_L1.2_THRESHOLDs
> > > calculated by Linux. The full log is attached.
> >
> > I think I'm missing your point here.  The L0s/L1 Acceptable Latencies
> > and the L0s/L1 Exit Latencies I see in your Win10 lspci are the same
> > as in Windows, which is what I would expect because these are
> > read-only Device and Link Capability registers and the OS can't
> > influence them:
> >
> >   00:1d.6 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Roo=
t Port
> > #15
> >     LnkCap: Port #15, Speed 8GT/s, Width x1, ASPM L0s L1, Exit Latency =
L0s
> > <1us, L1 <16us
> >
> >   6e:00.0 Non-Volatile memory controller: Intel Corporation Optane NVME=
 SSD
> > H10
> >     DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L=
1
> > unlimited
> >     LnkCap: Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit Latency L1 un=
limited
> >
> > The DevCap L0s and L1 Acceptable Latencies are "the acceptable total
> > latency that an Endpoint can withstand due to transition from L0s or
> > L1 to L0.  It is essentially an indirect measure of the Endpoint's
> > internal buffering."
> >
> > The LnkCap L0s and L1 Exit Latencies are the "time the Port requires
> > to complete transitions from L0s or L1 to L0."
> >
> > I don't know how to relate LTR_L1.2_THRESHOLD to L1.  I do know that
> > L0s and L1 were part of PCIe r2.1, but it wasn't until r3.1 that the
> > L1.1 and L1.2 substates were added and L1 was renamed to L1.0.  So I
> > expect the L1 latencies to be used to enable L1.0 by itself, and I
> > assume LTR and LTR_L1.2_THRESHOLD are used separately to further
> > enable L1.2.
> >
> > > But do we need to care about precise values? At least we know now tha=
t
> > > 7afeb84d14ea has only increased the thresholds, slightly. What happen=
s
> > > if they are underestimated? Can this lead to severe problems, e.g.
> > > data corruption on NVMes?
> >
> > IIUC, LTR messages are essentially a way for the device to say "I have
> > enough local buffer space to hold X ns worth of traffic while I'm
> > waiting for the link to return to L0."
> >
> > Then we should only put the link in L1.2 if we can get to L1.2 and
> > back to L0 in X ns or less, and LTR_L1.2_THRESHOLD is basically the
> > minimum L0 -> L1.2 -> L0 time.
> >
> > If we set LTR_L1.2_THRESHOLD lower than it should be, it seems like
> > we're at risk of overrunning the device's local buffer.  Maybe that's
> > OK and the device needs to be able to tolerate that, but it does feel
> > risky to me.
> >
> > There's also the LTR Capability that "specifies the maximum latency a
> > device is permitted to request.  Software should set this to the
> > platform's maximum supported latency or less."  Evidently drivers can
> > set this (only amdgpu does, AFAICS), but I have no idea how to use it.
> >
> > I suppose setting it to something less than LTR_L1.2_THRESHOLD might
> > cause L1.2 to be used more?  This would be writable via setpci, and it
> > looks like it can be updated any time.  If you want to play with it,
> > the value and scale are encoded the same way as
> > encode_l12_threshold(), and PCI_EXT_CAP_ID_LTR and related #defines
> > show the register layouts.
> >
> > > If not (and I've never seen one using 5.15 kernels for 4 years), can
> > > we reprogram LTR_L1.2_THRESHOLDs at runtime?  Like for the CPU,
> > > introduce 'performance' and 'powersave' governors for the PCI, which
> > > set the thresholds to, say, 2x and 0.5x (2 + 4 + t_common_mode +
> > > t_power_on), respectively.
> >
> > I don't think I would support a sysfs or similar interface to tweak
> > this.  Right now computing LTR_L1.2_THRESHOLD already feels like a bit
> > of black magic, and tweaking it would be farther down the road of
> > "well, it seems to help this situation, but we don't really know why."
> >
> > > On Wed, Apr 9, 2025 at 12:18=E2=80=AFAM Bjorn Helgaas <helgaas@kernel=
.org> wrote:
> > > >
> > > > On Tue, Apr 08, 2025 at 09:02:46PM +0100, Sergey Dolgov wrote:
> > > > > Dear Bjorn,
> > > > >
> > > > > here are both dmesg from the kernels with your info patch.
> > > >
> > > > Thanks again!  Here's the difference:
> > > >
> > > >   - pre  7afeb84d14ea
> > > >   + post 7afeb84d14ea
> > > >
> > > >    pci 0000:02:00.0: parent CMRT 0x28 child CMRT 0x00
> > > >    pci 0000:02:00.0: parent T_POWER_ON 0x2c usec (val 0x16 scale 0)
> > > >    pci 0000:02:00.0: child  T_POWER_ON 0x0a usec (val 0x5 scale 0)
> > > >    pci 0000:02:00.0: t_common_mode 0x28 t_power_on 0x2c l1_2_thresh=
old
> > > > 0x5a
> > > >   -pci 0000:02:00.0: encoded LTR_L1.2_THRESHOLD value 0x02 scale 3
> > > >   +pci 0000:02:00.0: encoded LTR_L1.2_THRESHOLD value 0x58 scale 2
> > > >
> > > > We computed LTR_L1.2_THRESHOLD =3D=3D 0x5a =3D=3D 90 usec =3D=3D 90=
000 nsec.
> > > >
> > > > Prior to 7afeb84d14ea, we computed *scale =3D 3, *value =3D (90000 =
>> 15)
> > > > =3D=3D 0x2.  But per PCIe r6.0, sec 6.18, this is a latency value o=
f only
> > > > 0x2 * 32768 =3D=3D 65536 ns, which is less than the 90000 ns we req=
uested.
> > > >
> > > > After 7afeb84d14ea, we computed *scale =3D 2, *value =3D
> > > > roundup(threshold_ns, 1024) / 1024 =3D=3D 0x58, which is a latency =
value
> > > > of 90112 ns, which is almost exactly what we requested.
> > > >
> > > > In essence, before 7afeb84d14ea we tell the Root Port that it can
> > > > enter L1.2 and get back to L0 in 65536 ns or less, and after
> > > > 7afeb84d14ea, we tell it that it may take up to 90112 ns.
> > > >
> > > > It's possible that the calculation of LTR_L1.2_THRESHOLD itself in
> > > > aspm_calc_l12_info() is too conservative, and we don't actually nee=
d
> > > > 90 usec, but I think the encoding done by 7afeb84d14ea itself is mo=
re
> > > > correct.  I don't have any information about how to improve 90 usec
> > > > estimate.  (If you happen to have Windows on that box, it would be
> > > > really interesting to see how it sets LTR_L1.2_THRESHOLD.)
> > > >
> > > > If the device has sent LTR messages indicating a latency requiremen=
t
> > > > between 65536 ns and 90112 ns, the pre-7afeb84d14ea kernel would al=
low
> > > > L1.2 while post 7afeb84d14ea would not.  I don't think we can actua=
lly
> > > > see the LTR messages sent by the device, but my guess is they must =
be
> > > > in that range.  I don't know if that's enough to account for the ma=
jor
> > > > difference in power consumption you're seeing.
>
> If the Root Port is attached to a controller in the South Complex =E2=80=
=94 which would
> be the case on a Cannon Lake=E2=80=93based platform =E2=80=94 you can obs=
erve the resulting LTR
> value sent from the Port using the pmc_core driver:
>
>     cat /sys/kernel/debug/pmc_core/ltr_show | grep SOUTHPORT
>
> Needs CONFIG_INTEL_PMC_CORE which the major distros set.
>
> The SOUTHPORTs correspond to Root Ports. Unfortunately, we don=E2=80=99t =
currently have
> a mapping between the internal PMC SOUTHPORT_X designation and the PCI Bu=
s
> enumeration. However, since this behavior clearly affects C-state entry, =
you
> should be able to narrow it down by monitoring this file =E2=80=94 ideall=
y capturing
> several snapshots, as the values can change depending on device activity.
>
> Note that the value shown may not exactly match what was sent in the LTR
> message, but it won=E2=80=99t be smaller. My current assumption (pending =
confirmation)
> is that simply entering L1.2 increases the effective LTR value observed b=
y the
> CPU, since it=E2=80=99s unlikely that the LTR message value itself change=
s solely as a
> result of modifying the threshold.
>
> Incidentally, you can also ignore the LTR from the Port by writing the bi=
t value
> (first column) to the ltr_ignore file in the same folder. This is for tes=
ting
> only as it ignores device activity. But you should see deeper C state res=
idency
> after ignoring the problem Port, which would be a way to narrow down the
> SOUTHPORT as well. The LTR consideration can be restored by writing the s=
ame bit
> value to the ltr_restore file.
>
> David
>
> > > >
> > > > The AX200 at 6f:00.0 is in exactly the same situation as the
> > > > Thunderbolt bridge at 02:00.0 (LTR_L1.2_THRESHOLD 90 usec, RP set t=
o
> > > > 65536 ns before 7afeb84d14ea and 90112 ns after).
> > > >
> > > > For the NVMe devices at 6d:00.0 and 6e:00.0, LTR_L1.2_THRESHOLD is
> > > > 3206 usec (!), and we set the RP to 3145728 ns (slightly too small)
> > > > before, 3211264 ns after.
> > > >
> > > > For the RTS525A at 70:00.0, LTR_L1.2_THRESHOLD is 126 usec, and we =
set
> > > > the RP to 98304 ns before, 126976 ns after.
> > > >
> > > > Sorry, no real answers here yet, still puzzled.
> > > >
> > > > Bjorn
> >
> >
>

