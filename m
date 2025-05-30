Return-Path: <linux-pci+bounces-28729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C81FEAC953E
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 19:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0266F1C22BA7
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 17:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C4627585F;
	Fri, 30 May 2025 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDQQciQZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCE1275112;
	Fri, 30 May 2025 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627379; cv=none; b=iUdW9BkRm9n+NNRjpPTGWSNwbpCeB2yuW0sZJ5Xx78RY2UkEgfQPq0MyB2+ZgY4Wx2f64RKwRtgTJpTL5keckoCpC1rAd3gAIszl5uUK2kUb/YD+TVy/xZySWJ1O/cEYyr6QC6diVYvhQBOgbidj9EdNuMdtwoD2FS/fOySWa7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627379; c=relaxed/simple;
	bh=y+10RZWz6zoadWKC+zVFEmiFYnxzeDW9gSiy8K4NqHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcFbDqUulrOYsVPnKFXmoBZG+RgHt2ntSSCXvCKolRCKAzIIEiAad2HcF39K1t+NLbxdrTFcy2hPu8KtyUZrCckEXO64dG+oqHAvy6l9lE85bXqg/siaZXA9Vwy57XrKZYx7ZUeDrDJIpy+94U6aHduB92FHrpv0bKV68wC3/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDQQciQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C8EC4CEF2;
	Fri, 30 May 2025 17:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748627378;
	bh=y+10RZWz6zoadWKC+zVFEmiFYnxzeDW9gSiy8K4NqHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UDQQciQZEbj2lngYr9GwZeyIHDKHMVrRWNtkA4s3IejUDWfFKN6zQIgK4Hi6QuLoh
	 VFye7VKfi2Ll1dWCzRe1nOvJqtmvWTDQ+CVyPk87gVvK9XNVmsBVR2vlQg8MYiuAFr
	 6D7bb0Kv60IlaYyQxvUK68sP3pWa7pQVr1Pq4cxfotsFST4tE/2Ob1VUaui8DPPBX4
	 Tyh3qJnXs6eHs6Rdq7k0whD7R1ITOCnuTY5nD3kXDto6zT4jTotSZ5+w3zXv9it9E5
	 +g3fg3uOQhwXY3IWempIJHAB/BEpodlHBRsQcipm6JstmvyruCdSk2BHb+IGRqmrv4
	 XqzcBsIWWAQGQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-60be2256b4dso691867eaf.0;
        Fri, 30 May 2025 10:49:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTMehNXSrRkUMZ4DJ0JSR1Va0i7dcos7YHmdstkEAIEB0MRjL+FeXBvGTwhOjg1w2415wYVE5TA3LI3sY=@vger.kernel.org, AJvYcCVUBmvAt4QM4llW4uz6YWTg8w3pPzYF/ZGeDYL5wRmm0W2GZe5uE92N6cAM0MESBqBIurj4LcewDKo3@vger.kernel.org, AJvYcCVsrcRg8ILWUFbKWezgIBRQkQwPSM8PWfLH8YLztUIO9Rn01qHHrA8LlteTa1R7IfumYO54tLxPmUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqZzw2hpqTqnESP1Q54+Ws9ixlsCDVo0R1H9tOyc7/1Zwr57kV
	X/RH4laYRuaOCxNE7SMariEuoC/BMgcdpQoxz9d742bDNqQNLVETpV4ISXx1SRy4McqYmxKmjDS
	oDg3OvjdRcoUke9MLgNVSfepX6lSOoS0=
X-Google-Smtp-Source: AGHT+IEn3VsdNdBPmXXtl8J+vGUTQAVp9IIGlr7kp2TrR3YQowlP5EZjhxQp5HT64kdNvldBCJFwFJL5XnXjTuZQGGo=
X-Received: by 2002:a4a:ee08:0:b0:60d:63fe:245e with SMTP id
 006d021491bc7-60d63fe24e9mr1072147eaf.2.1748627377711; Fri, 30 May 2025
 10:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a8c83435-4c91-495c-950c-4d12b955c54c@kernel.org>
 <aCyj9nbnIRet93O-@black.fi.intel.com> <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
 <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com> <6f23d82c-10cc-4d70-9dce-41978b05ec9a@kernel.org>
 <aCzNL9uXGbBSdF2S@black.fi.intel.com> <fea86161-2c47-4b0f-ac07-b3f9b0f10a03@kernel.org>
 <aC2UzG-eycjqYQep@black.fi.intel.com> <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
 <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com> <aDnpfKvLwRZsKxhH@black.fi.intel.com>
In-Reply-To: <aDnpfKvLwRZsKxhH@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 May 2025 19:49:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gjA2B4AnaYpfYpaNDo49k4LM2FGSrPFFuOCJ62bCMmkA@mail.gmail.com>
X-Gm-Features: AX0GCFvFCy5Alia3Vh9wkK8F9X_DM8F_OY5MBvV6J99UFrhVtA-b4g_8T7Tzzhs
Message-ID: <CAJZ5v0gjA2B4AnaYpfYpaNDo49k4LM2FGSrPFFuOCJ62bCMmkA@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous device
To: Raag Jadav <raag.jadav@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mario Limonciello <superm1@kernel.org>, 
	Denis Benato <benato.denis96@gmail.com>, mahesh@linux.ibm.com, oohall@gmail.com, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com, lukas@wunner.de, 
	aravind.iddamsetty@linux.intel.com, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 7:23=E2=80=AFPM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> On Fri, May 23, 2025 at 05:23:10PM +0200, Rafael J. Wysocki wrote:
> > On Wed, May 21, 2025 at 1:27=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > > On Wed, May 21, 2025 at 10:54=E2=80=AFAM Raag Jadav <raag.jadav@intel=
.com> wrote:
> > > > On Tue, May 20, 2025 at 01:56:28PM -0500, Mario Limonciello wrote:
> > > > > On 5/20/2025 1:42 PM, Raag Jadav wrote:
> > > > > > On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonciello wro=
te:
> > > > > > > On 5/20/2025 12:22 PM, Denis Benato wrote:
> > > > > > > > On 5/20/25 17:49, Mario Limonciello wrote:
> > > > > > > > > On 5/20/2025 10:47 AM, Raag Jadav wrote:
> > > > > > > > > > On Tue, May 20, 2025 at 10:23:57AM -0500, Mario Limonci=
ello wrote:
> > > > > > > > > > > On 5/20/2025 4:48 AM, Raag Jadav wrote:
> > > > > > > > > > > > On Mon, May 19, 2025 at 11:42:31PM +0200, Denis Ben=
ato wrote:
> > > > > > > > > > > > > On 5/19/25 12:41, Raag Jadav wrote:
> > > > > > > > > > > > > > On Mon, May 19, 2025 at 03:58:08PM +0530, Raag =
Jadav wrote:
> > > > > > > > > > > > > > > If error status is set on an AER capable devi=
ce, most likely either the
> > > > > > > > > > > > > > > device recovery is in progress or has already=
 failed. Neither of the
> > > > > > > > > > > > > > > cases are well suited for power state transit=
ion of the device, since
> > > > > > > > > > > > > > > this can lead to unpredictable consequences l=
ike resume failure, or in
> > > > > > > > > > > > > > > worst case the device is lost because of it. =
Leave the device in its
> > > > > > > > > > > > > > > existing power state to avoid such issues.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Signed-off-by: Raag Jadav <raag.jadav@intel.c=
om>
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > v2: Synchronize AER handling with PCI PM (Raf=
ael)
> > > > > > > > > > > > > > > v3: Move pci_aer_in_progress() to pci_set_low=
_power_state() (Rafael)
> > > > > > > > > > > > > > >         Elaborate "why" (Bjorn)
> > > > > > > > > > > > > > > v4: Rely on error status instead of device st=
atus
> > > > > > > > > > > > > > >         Condense comment (Lukas)
> > > > > > > > > > > > > > Since pci_aer_in_progress() is changed I've not=
 included Rafael's tag with
> > > > > > > > > > > > > > my understanding of this needing a revisit. If =
this was a mistake, please
> > > > > > > > > > > > > > let me know.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Denis, Mario, does this fix your issue?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > Hello,
> > > > > > > > > > > > >
> > > > > > > > > > > > > Unfortunately no, I have prepared a dmesg but had=
 to remove the bootup process because it was too long of a few kb: https://=
pastebin.com/1uBEA1FL
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks for the test. It seems there's no hotplug ev=
ent this time around
> > > > > > > > > > > > and endpoint device is still intact without any PCI=
 related failure.
> > > > > > > > > > > >
> > > > > > > > > > > > Also,
> > > > > > > > > > > >
> > > > > > > > > > > > amdgpu 0000:09:00.0: PCI PM: Suspend power state: D=
3hot
> > > > > > > > > > > >
> > > > > > > > > > > > Which means whatever you're facing is either not re=
lated to this patch,
> > > > > > > > > > > > or at best exposed some nasty side-effect that's no=
t handled correctly
> > > > > > > > > > > > by the driver.
> > > > > > > > > > > >
> > > > > > > > > > > > I'd say amdgpu folks would be of better help for yo=
ur case.
> > > > > > > > > > > >
> > > > > > > > > > > > Raag
> > > > > > > > > > >
> > > > > > > > > > > So according to the logs Denis shared with v4
> > > > > > > > > > > (https://pastebin.com/1uBEA1FL) the GPU should have b=
een going to BOCO. This
> > > > > > > > > > > stands for "Bus off Chip Off"
> > > > > > > > > > >
> > > > > > > > > > > amdgpu 0000:09:00.0: amdgpu: Using BOCO for runtime p=
m
> > > > > > > > > > >
> > > > > > > > > > > If it's going to D3hot - that's not going to be BOCO,=
 it should be going to
> > > > > > > > > > > D3cold.
> > > > > > > > > >
> > > > > > > > > > Yes, because upstream port is in D0 for some reason (mi=
ght be this patch
> > > > > > > > > > but not sure) and so will be the root port.
> > > > > > > > > >
> > > > > > > > > > pcieport 0000:07:00.0: PCI PM: Suspend power state: D0
> > > > > > > > > > pcieport 0000:07:00.0: PCI PM: Skipped
> > > > > > > > > >
> > > > > > > > > > and my best guess is the driver is not able to cope wit=
h the lack of D3cold.
> > > > > > > > >
> > > > > > > > > Yes; if the driver is configured to expect BOCO (D3cold) =
if it doesn't get it, chaos ensues.
> > > > > > > > >
> > > > > > > > > I guess let's double check the behavior with CONFIG_PCI_D=
EBUG to verify this patch is what is changing that upstream port behavior.
> > > > > > > >
> > > > > > > >
> > > > > > > > This is the very same exact kernel, minus the patch in ques=
tion:  https://pastebin.com/rwMYgG7C
> > > > > > > >
> > > > > > > >
> > > > > > > > Both previous kernel and this one have CONFIG_PCI_DEBUG=3Dy=
.
> > > > > > > >
> > > > > > > > Removed the initial bootup sequence to be able to use paste=
bin.
> > > > > > >
> > > > > > > Thanks - this confirms that the problem is the root port not =
going to D3.
> > > > > > > This new log shows:
> > > > > > >
> > > > > > > pcieport 0000:07:00.0: PCI PM: Suspend power state: D3hot
> > > > > > >
> > > > > > > So I feel we should fixate on solving that.
> > > > > >
> > > > > > Which means what you're looking for is error flag being set som=
ewhere in
> > > > > > the hierarchy that is preventing suspend.
> > > > >
> > > > > Is the issue perhaps that this is now gated on both correctable a=
nd
> > > > > uncorrectable errors?
> > > > >
> > > > > Perhaps should *correctable errors* be emitted with a warning and=
 the
> > > > > *uncorrectable errors* be fatal?
> > > >
> > > > That'd be more or less inline with hiding the issue, and it can als=
o race
> > > > with err_handler callback if driver has registered it.
> > > >
> > > > > > But regardless of it, my understanding is that root port suspen=
d depends
> > > > > > on a lot of factors (now errors flags being one of them with th=
is patch)
> > > > > > and endpoint driver can't possibly enforce or guarantee it - th=
e best it
> > > > > > can do is try.
> > > > > >
> > > > > > What's probably needed is D3cold failure handling on driver sid=
e, but I'm
> > > > > > no PCI PM expert and perhaps Rafael can comment on it.
> > > > > >
> > > > > > Raag
> > > > >
> > > > > From the driver perspective it does have expectations that the pa=
rts outside
> > > > > the driver did the right thing.  If the driver was expecting the =
root port
> > > > > to be powered down at suspend and it wasn't there are hardware co=
mponents
> > > > > that didn't power cycle and that's what we're seeing here.
> > > >
> > > > Which means the expectation set by the driver is the opposite of th=
e
> > > > purpose of this patch, and it's going to fail if any kind of error =
is
> > > > detected under root port during suspend.
> > >
> > > And IMV this driver's expectation is questionable at least.
> > >
> > > There is no promise whatsoever that the device will always be put int=
o
> > > D3cold during system suspend.
> >
> > For instance, user space may disable D3cold for any PCI device via the
> > d3cold_allowed attribute in sysfs.
> >
> > If the driver cannot handle this, it needs to be fixed.
>
> Thanks for confirming. So should we consider this patch to be valid
> and worth moving forward?

It doesn't do anything that would be invalid in principle IMV.

You need to consider one more thing, though: It may be necessary to
power-cycle the device in order to kick it out of the erroneous state
and the patch effectively blocks this if I'm not mistaken.

But admittedly I'm not sure if this really matters.

