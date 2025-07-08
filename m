Return-Path: <linux-pci+bounces-31721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 903CBAFD694
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 20:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD501C260B9
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 18:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB682DD5EF;
	Tue,  8 Jul 2025 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j27D+KZV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA71DE2A7
	for <linux-pci@vger.kernel.org>; Tue,  8 Jul 2025 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751999868; cv=none; b=UhVoFxrAsn+a/9P7qWfxJglFwOTLtdmrvl6LU7pSPN7kqF6P+NXurlnNJhUMzy8Gz+hD60Je0kJ3UC5H1w64YTcsfNX/cpjuIOXSZdRzoCKTdUSo9XLlQBWlLQCfmS7uv1XmGPX+267vSvJANP9box3ejxliGGMH/YJzreBTB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751999868; c=relaxed/simple;
	bh=6NmTztYsHpC2nlU60K2D7i4Zr4Hi7aSjlsT10sI7UwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Rc/IrnfT/49NS+dn9zw56WBWb9TUcFBljG4nx6Cwos89dkq/14P7BzsPLxmvEE4sLm7eCgS/olW/W2zHDrmVG6QlT6I7pRf3ANZijAmmyioVU/qQNYQcW2XPXc/b3H/JQZex5n55ePBy3ZEiY83Pz04Q7e2DvOfttC/6TVDJbnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j27D+KZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7015C4CEED;
	Tue,  8 Jul 2025 18:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751999867;
	bh=6NmTztYsHpC2nlU60K2D7i4Zr4Hi7aSjlsT10sI7UwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=j27D+KZVWXnHp9jr9IFsRXwrHlDhn5AAlepnPKsPfzoQtj2XjZd+hj4Uj87SaSZ4u
	 E1NWegxqjECWADNypBw+MflGQ4sdPpICiTm5YXz6TbIT5/vg/kWWIFsSw51nqmxVVQ
	 dgmkUrWtXb6dtWe/nfcYuZEzxuLfH1pCQX4wo8Xw0bawL8Igjv4+iofujnHQObkhvJ
	 TqgHr2BiMsuy1ZuUTbVp22eC4Tpl6gqBy9m90L5EIajGh7uaIo8sDkcdk8AiA4bBVD
	 z4RJPMED9Y89X4wDbGjBOKGpoLnzP5uNz6maLSBRyznm7xDtOJAhWhVUY2qE+ODcLI
	 wf6UMVrqOM0pA==
Date: Tue, 8 Jul 2025 13:37:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Dolgov <sergey.v.dolgov@gmail.com>
Cc: david.e.box@linux.intel.com, linux-pci@vger.kernel.org,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Artem S. Tashkinov" <aros@gmx.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Alex Huang <huangalex409@gmail.com>
Subject: Re: [Bug 219984] New: [BISECTED] High power usage since 'PCI/ASPM:
 Correct LTR_L1.2_THRESHOLD computation'
Message-ID: <20250708183746.GA2156025@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAONYan_vwFo8QHUAcNCccmMFVzRgLmRw1NZMSf5-FtbuJio0Tg@mail.gmail.com>

[+cc Alex]

On Tue, Jul 08, 2025 at 07:02:20PM +0100, Sergey Dolgov wrote:
> Dear Bjorn,
> 
> so, any interest in sending your patch upstream? Have you tested it on
> other devices? I have no other laptops I can boot Linux on, but I have
> upgraded the SSD a month ago, and the new one works fine without
> errors in SMART or DevSta at width x4 (max at my PCIe 3.0 port) with
> the same LTR1.2_Threshold of 81920ns.

I definitely want to pursue this in some form.  My first thought is to
just leave L1.2 config untouched because despite my hand-waving in
80d7d7a904fa ("PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device
characteristics"), I'm unconvinced that Linux has enough information
to configure L1.2 correctly.

I raised this in the PCI-SIG firmware working group yesterday and
there was some feeling that we actually *do* know enough (with the
help of an LTR _DSM), so maybe it's just that I don't understand it
well enough.

Alex recently reported an ASPM issue, and I point him at the debug
patch but haven't had a chance to look at his results yet:
https://lore.kernel.org/r/20250705134201.GA2004436@bhelgaas
Possibly completely unrelated.

Bjorn

> On Tue, May 6, 2025 at 12:57 PM Sergey Dolgov <sergey.v.dolgov@gmail.com> wrote:
> >
> > Dear David,
> >
> > I've seen only the following SOUTHPORT LTR values in different
> > combinations depending on device activity:
> >
> > ######## No disk activity but varying workload otherwise (idle CPU,
> > NVIDIA GPU sleeping or not, glxgears on either Intel or NVIDIA GPU,
> > audio playback or not): LTR values fluctuate between
> > 0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> > 1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> > 8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x90039003
> >          Non-Snoop(ns): 3145728          Snoop(ns): 3145728
> >   LTR_IGNORE: 0
> > 12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> > 13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> >
> > and
> >
> > 0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> > 1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> > 8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x90039003
> >          Non-Snoop(ns): 3145728          Snoop(ns): 3145728
> >   LTR_IGNORE: 0
> > 12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x88b688b6
> >          Non-Snoop(ns): 186368           Snoop(ns): 186368
> >   LTR_IGNORE: 0
> > 13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> >
> >
> > SOUTHPORT_D is probably connected to the wifi:
> >
> > ######## ping -A `ip route list default | awk '{print $3}'` : LTR
> > values are constant at
> > 0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> > 1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> > 8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x90039003
> >          Non-Snoop(ns): 3145728          Snoop(ns): 3145728
> >   LTR_IGNORE: 0
> > 12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x88b688b6
> >          Non-Snoop(ns): 186368           Snoop(ns): 186368
> >   LTR_IGNORE: 0
> > 13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> >
> > In contrast, with RFKILL'd wifi and bluetooth SOUTHPORT_D LTRs are all 0.
> >
> > SOUTHPORT_C is probably connected to the NVMes:
> >
> > ########  du -ch /
> > 0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> > 1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> > 8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x88468846
> >          Non-Snoop(ns): 71680            Snoop(ns): 71680
> >   LTR_IGNORE: 0
> > 12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> > 13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> >
> > 0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> > 1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> > 8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x880a880a
> >          Non-Snoop(ns): 10240            Snoop(ns): 10240
> >   LTR_IGNORE: 0
> > 12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x88b688b6
> >          Non-Snoop(ns): 186368           Snoop(ns): 186368
> >   LTR_IGNORE: 0
> > 13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> >
> > 0       PMC0:SOUTHPORT_A                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> > 1       PMC0:SOUTHPORT_B                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> > 8       PMC0:SOUTHPORT_C                        LTR: RAW: 0x880a880a
> >          Non-Snoop(ns): 10240            Snoop(ns): 10240
> >   LTR_IGNORE: 0
> > 12      PMC0:SOUTHPORT_D                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> > 13      PMC0:SOUTHPORT_E                        LTR: RAW: 0x0
> >          Non-Snoop(ns): 0                Snoop(ns): 0
> >   LTR_IGNORE: 0
> >
> >
> > These values are independent of the kernel (original 6.14.0 or that
> > with Bjorn's patch skipping L1.2 config).
> >
> > Thanks.
> > Sergey.
> >
> >
> > On Fri, May 2, 2025 at 10:30 PM David E. Box
> > <david.e.box@linux.intel.com> wrote:
> > >
> > > Hi all,
> > >
> > > On Thu, 2025-04-10 at 17:09 -0500, Bjorn Helgaas wrote:
> > > > On Thu, Apr 10, 2025 at 02:59:41PM +0100, Sergey Dolgov wrote:
> > > > > Dear Bjorn,
> > > > >
> > > > > one (probably the main) power user is the CPU at shallow C states post
> > > > > 7afeb84d14ea. Even at some load (like web browsing) the CPU spends
> > > > > most time in C7 after reverting 7afeb84d14ea, in contrast to C3 even
> > > > > at idle in the original 6.14.0. So the main question is what can make
> > > > > the CPU busy with larger LTR_L1.2_THRESHOLDs?
> > > >
> > > > That's a good question and I have no idea what the answer is.
> > > > Obviously a larger LTR_L1.2_THRESHOLD means less time in L1.2, but I
> > > > don't know how that translates to CPU C states.
> > > >
> > > > These bugs:
> > > >
> > > >   https://bugzilla.kernel.org/show_bug.cgi?id=218394
> > > >   https://bugzilla.kernel.org/show_bug.cgi?id=215832
> > > >
> > > > mention C states and ASPM.  I added some of those folks to cc.
> > > >
> > > > > I do have Win10 too, but neither Win binaries of pciutils nor Device
> > > > > Manager show LTR_L1.2_THRESHOLD. lspci -vv run as Administrator does
> > > > > report some "latencies" though. Some of them are significantly
> > > > > smaller, e.g. "Exit Latency L0s <1us, L1 <16us" for the bridge
> > > > > 00:1d.6, others are significantly larger, e.g. "Exit Latency L1
> > > > > unlimited" for the NVMe 6e:00.0, than the LTR_L1.2_THRESHOLDs
> > > > > calculated by Linux. The full log is attached.
> > > >
> > > > I think I'm missing your point here.  The L0s/L1 Acceptable Latencies
> > > > and the L0s/L1 Exit Latencies I see in your Win10 lspci are the same
> > > > as in Windows, which is what I would expect because these are
> > > > read-only Device and Link Capability registers and the OS can't
> > > > influence them:
> > > >
> > > >   00:1d.6 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port
> > > > #15
> > > >     LnkCap: Port #15, Speed 8GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
> > > > <1us, L1 <16us
> > > >
> > > >   6e:00.0 Non-Volatile memory controller: Intel Corporation Optane NVME SSD
> > > > H10
> > > >     DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1
> > > > unlimited
> > > >     LnkCap: Port #0, Speed 8GT/s, Width x2, ASPM L1, Exit Latency L1 unlimited
> > > >
> > > > The DevCap L0s and L1 Acceptable Latencies are "the acceptable total
> > > > latency that an Endpoint can withstand due to transition from L0s or
> > > > L1 to L0.  It is essentially an indirect measure of the Endpoint's
> > > > internal buffering."
> > > >
> > > > The LnkCap L0s and L1 Exit Latencies are the "time the Port requires
> > > > to complete transitions from L0s or L1 to L0."
> > > >
> > > > I don't know how to relate LTR_L1.2_THRESHOLD to L1.  I do know that
> > > > L0s and L1 were part of PCIe r2.1, but it wasn't until r3.1 that the
> > > > L1.1 and L1.2 substates were added and L1 was renamed to L1.0.  So I
> > > > expect the L1 latencies to be used to enable L1.0 by itself, and I
> > > > assume LTR and LTR_L1.2_THRESHOLD are used separately to further
> > > > enable L1.2.
> > > >
> > > > > But do we need to care about precise values? At least we know now that
> > > > > 7afeb84d14ea has only increased the thresholds, slightly. What happens
> > > > > if they are underestimated? Can this lead to severe problems, e.g.
> > > > > data corruption on NVMes?
> > > >
> > > > IIUC, LTR messages are essentially a way for the device to say "I have
> > > > enough local buffer space to hold X ns worth of traffic while I'm
> > > > waiting for the link to return to L0."
> > > >
> > > > Then we should only put the link in L1.2 if we can get to L1.2 and
> > > > back to L0 in X ns or less, and LTR_L1.2_THRESHOLD is basically the
> > > > minimum L0 -> L1.2 -> L0 time.
> > > >
> > > > If we set LTR_L1.2_THRESHOLD lower than it should be, it seems like
> > > > we're at risk of overrunning the device's local buffer.  Maybe that's
> > > > OK and the device needs to be able to tolerate that, but it does feel
> > > > risky to me.
> > > >
> > > > There's also the LTR Capability that "specifies the maximum latency a
> > > > device is permitted to request.  Software should set this to the
> > > > platform's maximum supported latency or less."  Evidently drivers can
> > > > set this (only amdgpu does, AFAICS), but I have no idea how to use it.
> > > >
> > > > I suppose setting it to something less than LTR_L1.2_THRESHOLD might
> > > > cause L1.2 to be used more?  This would be writable via setpci, and it
> > > > looks like it can be updated any time.  If you want to play with it,
> > > > the value and scale are encoded the same way as
> > > > encode_l12_threshold(), and PCI_EXT_CAP_ID_LTR and related #defines
> > > > show the register layouts.
> > > >
> > > > > If not (and I've never seen one using 5.15 kernels for 4 years), can
> > > > > we reprogram LTR_L1.2_THRESHOLDs at runtime?  Like for the CPU,
> > > > > introduce 'performance' and 'powersave' governors for the PCI, which
> > > > > set the thresholds to, say, 2x and 0.5x (2 + 4 + t_common_mode +
> > > > > t_power_on), respectively.
> > > >
> > > > I don't think I would support a sysfs or similar interface to tweak
> > > > this.  Right now computing LTR_L1.2_THRESHOLD already feels like a bit
> > > > of black magic, and tweaking it would be farther down the road of
> > > > "well, it seems to help this situation, but we don't really know why."
> > > >
> > > > > On Wed, Apr 9, 2025 at 12:18 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, Apr 08, 2025 at 09:02:46PM +0100, Sergey Dolgov wrote:
> > > > > > > Dear Bjorn,
> > > > > > >
> > > > > > > here are both dmesg from the kernels with your info patch.
> > > > > >
> > > > > > Thanks again!  Here's the difference:
> > > > > >
> > > > > >   - pre  7afeb84d14ea
> > > > > >   + post 7afeb84d14ea
> > > > > >
> > > > > >    pci 0000:02:00.0: parent CMRT 0x28 child CMRT 0x00
> > > > > >    pci 0000:02:00.0: parent T_POWER_ON 0x2c usec (val 0x16 scale 0)
> > > > > >    pci 0000:02:00.0: child  T_POWER_ON 0x0a usec (val 0x5 scale 0)
> > > > > >    pci 0000:02:00.0: t_common_mode 0x28 t_power_on 0x2c l1_2_threshold
> > > > > > 0x5a
> > > > > >   -pci 0000:02:00.0: encoded LTR_L1.2_THRESHOLD value 0x02 scale 3
> > > > > >   +pci 0000:02:00.0: encoded LTR_L1.2_THRESHOLD value 0x58 scale 2
> > > > > >
> > > > > > We computed LTR_L1.2_THRESHOLD == 0x5a == 90 usec == 90000 nsec.
> > > > > >
> > > > > > Prior to 7afeb84d14ea, we computed *scale = 3, *value = (90000 >> 15)
> > > > > > == 0x2.  But per PCIe r6.0, sec 6.18, this is a latency value of only
> > > > > > 0x2 * 32768 == 65536 ns, which is less than the 90000 ns we requested.
> > > > > >
> > > > > > After 7afeb84d14ea, we computed *scale = 2, *value =
> > > > > > roundup(threshold_ns, 1024) / 1024 == 0x58, which is a latency value
> > > > > > of 90112 ns, which is almost exactly what we requested.
> > > > > >
> > > > > > In essence, before 7afeb84d14ea we tell the Root Port that it can
> > > > > > enter L1.2 and get back to L0 in 65536 ns or less, and after
> > > > > > 7afeb84d14ea, we tell it that it may take up to 90112 ns.
> > > > > >
> > > > > > It's possible that the calculation of LTR_L1.2_THRESHOLD itself in
> > > > > > aspm_calc_l12_info() is too conservative, and we don't actually need
> > > > > > 90 usec, but I think the encoding done by 7afeb84d14ea itself is more
> > > > > > correct.  I don't have any information about how to improve 90 usec
> > > > > > estimate.  (If you happen to have Windows on that box, it would be
> > > > > > really interesting to see how it sets LTR_L1.2_THRESHOLD.)
> > > > > >
> > > > > > If the device has sent LTR messages indicating a latency requirement
> > > > > > between 65536 ns and 90112 ns, the pre-7afeb84d14ea kernel would allow
> > > > > > L1.2 while post 7afeb84d14ea would not.  I don't think we can actually
> > > > > > see the LTR messages sent by the device, but my guess is they must be
> > > > > > in that range.  I don't know if that's enough to account for the major
> > > > > > difference in power consumption you're seeing.
> > >
> > > If the Root Port is attached to a controller in the South Complex — which would
> > > be the case on a Cannon Lake–based platform — you can observe the resulting LTR
> > > value sent from the Port using the pmc_core driver:
> > >
> > >     cat /sys/kernel/debug/pmc_core/ltr_show | grep SOUTHPORT
> > >
> > > Needs CONFIG_INTEL_PMC_CORE which the major distros set.
> > >
> > > The SOUTHPORTs correspond to Root Ports. Unfortunately, we don’t currently have
> > > a mapping between the internal PMC SOUTHPORT_X designation and the PCI Bus
> > > enumeration. However, since this behavior clearly affects C-state entry, you
> > > should be able to narrow it down by monitoring this file — ideally capturing
> > > several snapshots, as the values can change depending on device activity.
> > >
> > > Note that the value shown may not exactly match what was sent in the LTR
> > > message, but it won’t be smaller. My current assumption (pending confirmation)
> > > is that simply entering L1.2 increases the effective LTR value observed by the
> > > CPU, since it’s unlikely that the LTR message value itself changes solely as a
> > > result of modifying the threshold.
> > >
> > > Incidentally, you can also ignore the LTR from the Port by writing the bit value
> > > (first column) to the ltr_ignore file in the same folder. This is for testing
> > > only as it ignores device activity. But you should see deeper C state residency
> > > after ignoring the problem Port, which would be a way to narrow down the
> > > SOUTHPORT as well. The LTR consideration can be restored by writing the same bit
> > > value to the ltr_restore file.
> > >
> > > David
> > >
> > > > > >
> > > > > > The AX200 at 6f:00.0 is in exactly the same situation as the
> > > > > > Thunderbolt bridge at 02:00.0 (LTR_L1.2_THRESHOLD 90 usec, RP set to
> > > > > > 65536 ns before 7afeb84d14ea and 90112 ns after).
> > > > > >
> > > > > > For the NVMe devices at 6d:00.0 and 6e:00.0, LTR_L1.2_THRESHOLD is
> > > > > > 3206 usec (!), and we set the RP to 3145728 ns (slightly too small)
> > > > > > before, 3211264 ns after.
> > > > > >
> > > > > > For the RTS525A at 70:00.0, LTR_L1.2_THRESHOLD is 126 usec, and we set
> > > > > > the RP to 98304 ns before, 126976 ns after.
> > > > > >
> > > > > > Sorry, no real answers here yet, still puzzled.
> > > > > >
> > > > > > Bjorn
> > > >
> > > >
> > >

