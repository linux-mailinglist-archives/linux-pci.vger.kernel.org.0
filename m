Return-Path: <linux-pci+bounces-4593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A35874848
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 07:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0915CB20A14
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 06:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8146E1CD09;
	Thu,  7 Mar 2024 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="SBN5fwh3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2A3256A
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709793888; cv=none; b=VOGROA9nvMXz9lSf8/hZzkQMfa6a206VE8VRDTuoRBlCIp+0CSX7cI8gAk0xB6bjM2PPyZVSBjoxb2D/uK5wMcS5d8+igwdJHYT4i/1f+r7OBz6W2VNYcNuRowfFHWzNwT5iUXcgDg+0tJPQI/0F0H2h2AZyUUHfyHODVTywMSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709793888; c=relaxed/simple;
	bh=RvaQ/rqz0h0hGm7Ip9nUcdbSeubLqYN3nVLxvSCw0HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syCGm753hEcBtQvWdpgYBOkvECy9bG0/D2ybaf4HOuMhoo33h2hTD3H7ISqcnXPHgMrx34qNaD/g4iUH0Nqn6x75mkXW0plOAw0hfuZ9xyJxhL/QFwcdUxqVma1DPAtKvR7UIGK6jh04ATxSUw4fnPHSHS0XXnCGlmg53+Kjfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=SBN5fwh3; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 84FA5411A1
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 06:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1709793878;
	bh=55f1xLPrkCtLuH/FjoNWluAZNUICe/QcdEqP5aG3yUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=SBN5fwh3aEPJwCzpTFZFZLBwRpN3pVlUJxh5jQlhBLbzpMLahtqXgOhWx0Df7f3+i
	 c6f/+dltXaL+doUc9TGdr0lXXEmuFmXnRV9BCZvNgU/IDe1GyvBPmji9R9axxO+G24
	 pFsELoinISmXEmdunyc3Nc4Pg65/fikC7M2a8wvkSkSTppe6VEXTDQhOWQotOGWlPf
	 WNVpOVav2b0P8yAujHedVOZ/dszTkoMGVAbcPuMQAYRA3nWu3x+VJxe5GDCjf++CK/
	 PaLDYAipgtdkqFLuYmA+5sgpd6dCrMEbT0faJSftrDCOQ+zrj9x40t72+yHISe7uR6
	 rZHjsE9fEHs+A==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e532ea6c51so463578b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 06 Mar 2024 22:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709793877; x=1710398677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55f1xLPrkCtLuH/FjoNWluAZNUICe/QcdEqP5aG3yUI=;
        b=hRYtpoxTByGTLYCFTbODYTck2EfxjTrI0ZJXr7OYDmzzvQ2sZHflgARBEwrFMHZx4W
         VVjqyezF4LqF1RWqB0Lp4irqMc8B8/evgJpESl3yzWkVHB1AR2GO4qpJ6ellFjmjS+Tg
         yQlZDE94SBcJSbx1oC/ayuq3YV6DS4o5HpShDiBlSu1upGn9Cg4yb8ZzagDH4XXbRCsw
         Bb7hyZEn+tjdcu80BJXnlrhyjr6NsrN32mRNsxElVXAKh9o3Y2mZsorsYsF2jl9UcToG
         an2Q2Ee+4wPiClG+sCcr9STBRuGsPcRSWhxxuryykOIWlPle3++8keMDA+mzlF/lxN8F
         0YrA==
X-Forwarded-Encrypted: i=1; AJvYcCVaNHenAiaCQFMfct6r8EmrNqNdyAPWVZ1BRhCk+tbuiCj9kxcSTRESsqaWYWDWCnvD04Y5h1H86yJFh1Q/5PCxZzjIQpLOtTQF
X-Gm-Message-State: AOJu0YzNeGIzOiCLlFDDWCSWYWTPhObrOeFvtT6SdBvR2WgqkrkpuwVc
	Ct501lJQSKzg13R3EGmWLoKLHUC5jTSevs2l+YR1FXtB+noMG7bW0jvnF7GDBE01OyiZETtRyPi
	QW8k1+/nEq74zRpSwLtO0yOL72l0WJHclCrvyssMCW9rnElOMLqJrpTYBc7obgibWfJeZqcUMKg
	9Dvpk7jEClDELaTeNNXRQ88kOwUfHEOje2Yyjd5WwzDdpYRQXb
X-Received: by 2002:a05:6a20:ae93:b0:1a1:44c8:e625 with SMTP id do19-20020a056a20ae9300b001a144c8e625mr5763111pzb.40.1709793877030;
        Wed, 06 Mar 2024 22:44:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH13IqNVfWB5anXcBekUlbwbdHm1ZH7y7xOmxo5CKgmqvsAI0+LbVGJI5awyokbYrh9LvxFX5cdP4+UXsjL85k=
X-Received: by 2002:a05:6a20:ae93:b0:1a1:44c8:e625 with SMTP id
 do19-20020a056a20ae9300b001a144c8e625mr5763105pzb.40.1709793876721; Wed, 06
 Mar 2024 22:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207185549.GA910460@bhelgaas> <af071f45513778a9392efb1a9f41f1e18d2670f0.camel@linux.intel.com>
 <46b737db266f08c6dc98c77044bab12491a4d971.camel@linux.intel.com>
In-Reply-To: <46b737db266f08c6dc98c77044bab12491a4d971.camel@linux.intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 7 Mar 2024 14:44:23 +0800
Message-ID: <CAAd53p4j3MwigsFXpftuDdSfhn7EH_-cOOjP2DqnqeAuD+Fb=Q@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD rootports
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nirmal,

On Thu, Mar 7, 2024 at 6:20=E2=80=AFAM Nirmal Patel
<nirmal.patel@linux.intel.com> wrote:
>
> On Tue, 2024-02-13 at 10:47 -0700, Nirmal Patel wrote:
> > On Wed, 2024-02-07 at 12:55 -0600, Bjorn Helgaas wrote:
> > > On Tue, Feb 06, 2024 at 05:27:29PM -0700, Nirmal Patel wrote:
> > > > ...
> > > > Did you have a chance to look at my response on January 16th to
> > > > your
> > > > questions? I tried to summarize all of the potential problems and
> > > > issues with different fixes. Please let me know if it is easier
> > > > if
> > > > I
> > > > resend the explanation. Thanks.
> > >
> > > I did see your Jan 16 response, thanks.
> > >
> > > I had more questions after reading it, but they're more about
> > > understanding the topology seen by the host and the guest:
> > >   Jan 16:
> > > https://lore.kernel.org/r/20240117004933.GA108810@bhelgaas
> > >   Feb  1:
> > > https://lore.kernel.org/r/20240201211620.GA650432@bhelgaas
> > >
> > > As I mentioned in my second Feb 1 response
> > > (https://lore.kernel.org/r/20240201222245.GA650725@bhelgaas), the
> > > usual plan envisioned by the PCI Firmware spec is that an OS can
> > > use
> > > a
> > > PCIe feature if the platform has granted the OS ownership via _OSC
> > > and
> > > a device advertises the feature via a Capability in config space.
> > >
> > > My main concern with the v2 patch
> > > (
> > > https://lore.kernel.org/r/20231127211729.42668-1-nirmal.patel@linux.i=
ntel.com
> > > )
> > > is that it overrides _OSC for native_pcie_hotplug, but not for any
> > > of
> > > the other features (AER, PME, LTR, DPC, etc.)
> > >
> > > I think it's hard to read the specs and conclude that PCIe hotplug
> > > is
> > > a special case, and I think we're likely to have similar issues
> > > with
> > > other features in the future.
> > >
> > > But if you think this is the best solution, I'm OK with merging it.
> Hi Bjorn,
>
> We tried some other ways to pass the information about all of the flags
> but I couldn't retrieve it in guest OS and VMD hardware doesn't have
> empty registers to write this information. So as of now we have this
> solution which only overwrites Hotplug flag. If you can accept it that
> would be great.

My original commit "PCI: vmd: Honor ACPI _OSC on PCIe features" was a
logically conclusion based on VMD ports are just apertures.
Apparently there are more nuances than that, and people outside of
Intel can't possibly know. And yes VMD creates lots of headaches
during hardware enablement.

So is it possible to document the right way to use _OSC, as Bjorn suggested=
?

Kai-Heng

> > In the host OS, this overrides whatever was negotiated via _OSC, I
> > guess on the principle that _OSC doesn't apply because the host BIOS
> > doesn't know about the Root Ports below the VMD.  (I'm not sure it's
> > 100% resolved that _OSC doesn't apply to them, so we should mention
> > that assumption here.)
> _OSC still controls every flag including Hotplug. I have observed that
> slot capabilities register has hotplug enabled only when platform has
> enabled the hotplug. So technically not overriding it in the host.
> It overrides in guest because _OSC is passing wrong/different
> information than the _OSC information in Host.
> Also like I mentioned, slot capabilities registers are not changed in
> Guest because vmd is passthrough.
> >
> > In the guest OS, this still overrides whatever was negotiated via
> > _OSC, but presumably the guest BIOS *does* know about the Root Ports,
> > so I don't think the same principle about overriding _OSC applies
> > there.
> >
> > I think it's still a problem that we handle
> > host_bridge->native_pcie_hotplug differently than all the other
> > features negotiated via _OSC.  We should at least explain this
> > somehow.
> Right now this is the only way to know in Guest OS if platform has
> enabled Hotplug or not. We have many customers complaining about
> Hotplug being broken in Guest. So just trying to honor _OSC but also
> fixing its limitation in Guest.
>
> Thanks
> nirmal.
>
> > I sincerely apologize for late responses. I just found out that my
> > evolution mail client is automatically sending linux-pci emails to
> > junk
> > since January 2024.
> >
> > At the moment Hotplug is an exception for us, but I do share your
> > concern about other flags. We have done lot of testing and so far
> > patch
> > v2 is the best solution we have.
> >
> > Thanks
> > nirmal
> > > Bjorn
>

