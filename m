Return-Path: <linux-pci+bounces-4837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF2787C737
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 02:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFBB1C21A15
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 01:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D04E1A38CD;
	Fri, 15 Mar 2024 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="auvglMSR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00DC17C8
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 01:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710466198; cv=none; b=Ba+6xpDoG4BRX3tZUCkUL0z8j9oaYX/wKBbc6miMuzc4YCXOeRbNCj6XQcNH7YdU9nTaEYVaQT6iJbkHOOdI6DoAwepNEkTzl1P6cKDfFoZK05rgY9RQTC/rPFA9IAFP4bM5c0gpWtqDXZb3UTKBKV0eAwFI7D9eaADjjdCU6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710466198; c=relaxed/simple;
	bh=geH0oSt1mD4/uv12kxnX6ocJchVFRR6DxB6xg/nWAEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OS9EdPl/Za1eDX7QhFHadSiyfyIGgL69XHwch0rlFPpMcwstMu77dg081JEsx2EX5LXRPAoKLVgz1dHMJI0UnTgjex9la3tkYtVVYX0beCupjMAS4nHSi8IRNEJqg19rxffHSo+EKiWpSKC+cNRHpC9ses4f+nS9xRAhavgy5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=auvglMSR; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A878D3F682
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 01:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1710466186;
	bh=FsyR6dlmGFP/pAZ52gcF0MwsNUDo4NLrUHf6DChTcOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=auvglMSR0AGbgIRYh8Ym4RVzFH/6ZkgFqKEcOflezPXwD4qdbJwR3aolT5R08ZfRz
	 HitUY3RBRNl0Os4RiF1/bbkJ6RDUaYGP3ZeDYuu+qdrpDEOngD+a0Xw6Ckkt5OqCpM
	 unoOG/1+QQvDIVUcWYeANr7vmPsPR3cn8lBjZtSwFJjByTaMIRndrlN6YjMhQSNepl
	 tv78gXsvdVujrGKb0Smg4qZQxPQ9W11w9l93ZVruZN25CSfk7+1VWvBm0ovh6z89uf
	 WBOfkW+8kAQ6lSh0I2rldyTNqjaIjvjzJ5KErr4jSGbDBMnaJSqxjUMgKHWclYbS+v
	 IC9AomkPt1AOA==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e6a9ffaf3eso1591046b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 18:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710466185; x=1711070985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsyR6dlmGFP/pAZ52gcF0MwsNUDo4NLrUHf6DChTcOQ=;
        b=CoZsZW3pMQnOtv10s4OtNovXDPHhGJXzCUTAfNyjro0zKeomuWrdu5w58voENFwHpD
         K5p/JfG9m52WaxRpz3L/dNuzwDK9AOH9QuIQE529LsZek3rew8mlQOOUEof4EmjrIx9k
         q4m//l9Kig4lvOjrjrPZ9283NwSVLPoAiH74Z8frBTrRrSBi5x2/8DQH86AdYE2rl36a
         WuLO+Y19E0LwX+B1xje3enthR7pGaS7Ey6+t/2dRIuDDTECrauTDLQLy+IXHK40YWt+w
         SnNGC1hSd3g2rIDo1Gx0veRTP1FL2k5aKGvm3IHisSz9hFhVbp1bb2VDUk/PCY7V7hzW
         GuzA==
X-Forwarded-Encrypted: i=1; AJvYcCX7q5gqzKr2K6UKggsEliERH56X5bNIBsi7ZGd4xBrxmz/jrLbuiY0oVCG5cREwVBKY8aIJBHJGJ+caBkQ9YKoQ6pwQZFgZ15Tq
X-Gm-Message-State: AOJu0YzSoeblUEr9Yw6T1WBumRhvndRDwT0xftZyc3Dhmz+7dBa4zVrI
	ZfBU0Ya5+LJU7C4Gfmg+WsmyA/0HVMPLphih7K75EW/l3LZdfDE/biyD5UhV3/UVcWG7VEWthf0
	jv++zo0a58U2LBSjgPQ55ig3XFLMuqyMToc2FOjXZP5ZRak+e+fMTZUgNf0M/5mzWfpvp7egQrJ
	FQ3YGynuDwK4UbUCnbC1sM66mJNKztTPTz7D3/8OsEsZO2N5My
X-Received: by 2002:a05:6a21:6d8a:b0:1a3:494f:605 with SMTP id wl10-20020a056a216d8a00b001a3494f0605mr2330863pzb.9.1710466184741;
        Thu, 14 Mar 2024 18:29:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWVKI4JGdvQTO74Bd4FOgDOy9/TTvd/X4fT+N7k2sePJvYjZ8mwHiwSCzR8PSnjBYTA8GgWgPdEp1mFzfuR3M=
X-Received: by 2002:a05:6a21:6d8a:b0:1a3:494f:605 with SMTP id
 wl10-20020a056a216d8a00b001a3494f0605mr2330844pzb.9.1710466184355; Thu, 14
 Mar 2024 18:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207185549.GA910460@bhelgaas> <af071f45513778a9392efb1a9f41f1e18d2670f0.camel@linux.intel.com>
 <46b737db266f08c6dc98c77044bab12491a4d971.camel@linux.intel.com>
 <CAAd53p4j3MwigsFXpftuDdSfhn7EH_-cOOjP2DqnqeAuD+Fb=Q@mail.gmail.com> <20240307170904.00001cd4@linux.intel.com>
In-Reply-To: <20240307170904.00001cd4@linux.intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 15 Mar 2024 09:29:32 +0800
Message-ID: <CAAd53p79uvaY7QOQCBP=ztnyzsXaiKAiR8-A5sCDXmqnr-3LrA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD rootports
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, paul.m.stillwell.jr@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 8:09=E2=80=AFAM Nirmal Patel
<nirmal.patel@linux.intel.com> wrote:
>
> On Thu, 7 Mar 2024 14:44:23 +0800
> Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
> > Hi Nirmal,
> >
> > On Thu, Mar 7, 2024 at 6:20=E2=80=AFAM Nirmal Patel
> > <nirmal.patel@linux.intel.com> wrote:
> > >
> > > On Tue, 2024-02-13 at 10:47 -0700, Nirmal Patel wrote:
> > > > On Wed, 2024-02-07 at 12:55 -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Feb 06, 2024 at 05:27:29PM -0700, Nirmal Patel wrote:
> > > > > > ...
> > > > > > Did you have a chance to look at my response on January 16th
> > > > > > to your
> > > > > > questions? I tried to summarize all of the potential problems
> > > > > > and issues with different fixes. Please let me know if it is
> > > > > > easier if
> > > > > > I
> > > > > > resend the explanation. Thanks.
> > > > >
> > > > > I did see your Jan 16 response, thanks.
> > > > >
> > > > > I had more questions after reading it, but they're more about
> > > > > understanding the topology seen by the host and the guest:
> > > > >   Jan 16:
> > > > > https://lore.kernel.org/r/20240117004933.GA108810@bhelgaas
> > > > >   Feb  1:
> > > > > https://lore.kernel.org/r/20240201211620.GA650432@bhelgaas
> > > > >
> > > > > As I mentioned in my second Feb 1 response
> > > > > (https://lore.kernel.org/r/20240201222245.GA650725@bhelgaas),
> > > > > the usual plan envisioned by the PCI Firmware spec is that an
> > > > > OS can use
> > > > > a
> > > > > PCIe feature if the platform has granted the OS ownership via
> > > > > _OSC and
> > > > > a device advertises the feature via a Capability in config
> > > > > space.
> > > > >
> > > > > My main concern with the v2 patch
> > > > > (
> > > > > https://lore.kernel.org/r/20231127211729.42668-1-nirmal.patel@lin=
ux.intel.com
> > > > > )
> > > > > is that it overrides _OSC for native_pcie_hotplug, but not for
> > > > > any of
> > > > > the other features (AER, PME, LTR, DPC, etc.)
> > > > >
> > > > > I think it's hard to read the specs and conclude that PCIe
> > > > > hotplug is
> > > > > a special case, and I think we're likely to have similar issues
> > > > > with
> > > > > other features in the future.
> > > > >
> > > > > But if you think this is the best solution, I'm OK with merging
> > > > > it.
> > > Hi Bjorn,
> > >
> > > We tried some other ways to pass the information about all of the
> > > flags but I couldn't retrieve it in guest OS and VMD hardware
> > > doesn't have empty registers to write this information. So as of
> > > now we have this solution which only overwrites Hotplug flag. If
> > > you can accept it that would be great.
> >
> > My original commit "PCI: vmd: Honor ACPI _OSC on PCIe features" was a
> > logically conclusion based on VMD ports are just apertures.
> > Apparently there are more nuances than that, and people outside of
> > Intel can't possibly know. And yes VMD creates lots of headaches
> > during hardware enablement.
> >
> > So is it possible to document the right way to use _OSC, as Bjorn
> > suggested?
> >
> > Kai-Heng
> Well we are stuck here with two issues which are kind of chicken and egg
> problem.
> 1) VMD respects _OSC; which works excellent in Host but _OSC gives
> wrong information in Guest OS which ends up disabling Hotplug, AER,
> DPC, etc. We can live with AER, DPC disabled in VM but not the Hotplug.
>
> 2) VMD takes ownership of all the flags. For this to work VMD needs to
> know these settings from BIOS. VMD hardware doesn't have empty register
> where VMD UEFI driver can write this information. So honoring user
> settings for AER, Hotplug, etc from BIOS is not possible.
>
> Where do you want me to add documentation? Will more information in
> the comment section of the Sltcap code change help?
>
> Architecture wise VMD must own all of these flags but we have a
> hardware limitation to successfully pass the necessary information to
> the Host OS and the Guest OS.

If there's an official document on intel.com, it can make many things
clearer and easier.
States what VMD does and what VMD expect OS to do can be really
helpful. Basically put what you wrote in an official document.

Kai-Heng

>
> Thanks
> nirmal
> >
> > > > In the host OS, this overrides whatever was negotiated via _OSC, I
> > > > guess on the principle that _OSC doesn't apply because the host
> > > > BIOS doesn't know about the Root Ports below the VMD.  (I'm not
> > > > sure it's 100% resolved that _OSC doesn't apply to them, so we
> > > > should mention that assumption here.)
> > > _OSC still controls every flag including Hotplug. I have observed
> > > that slot capabilities register has hotplug enabled only when
> > > platform has enabled the hotplug. So technically not overriding it
> > > in the host. It overrides in guest because _OSC is passing
> > > wrong/different information than the _OSC information in Host.
> > > Also like I mentioned, slot capabilities registers are not changed
> > > in Guest because vmd is passthrough.
> > > >
> > > > In the guest OS, this still overrides whatever was negotiated via
> > > > _OSC, but presumably the guest BIOS *does* know about the Root
> > > > Ports, so I don't think the same principle about overriding _OSC
> > > > applies there.
> > > >
> > > > I think it's still a problem that we handle
> > > > host_bridge->native_pcie_hotplug differently than all the other
> > > > features negotiated via _OSC.  We should at least explain this
> > > > somehow.
> > > Right now this is the only way to know in Guest OS if platform has
> > > enabled Hotplug or not. We have many customers complaining about
> > > Hotplug being broken in Guest. So just trying to honor _OSC but also
> > > fixing its limitation in Guest.
> > >
> > > Thanks
> > > nirmal.
> > >
> > > > I sincerely apologize for late responses. I just found out that my
> > > > evolution mail client is automatically sending linux-pci emails to
> > > > junk
> > > > since January 2024.
> > > >
> > > > At the moment Hotplug is an exception for us, but I do share your
> > > > concern about other flags. We have done lot of testing and so far
> > > > patch
> > > > v2 is the best solution we have.
> > > >
> > > > Thanks
> > > > nirmal
> > > > > Bjorn
> > >
>

