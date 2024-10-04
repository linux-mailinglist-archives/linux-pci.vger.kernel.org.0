Return-Path: <linux-pci+bounces-13794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5863598FCBD
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 06:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D393B1F22FA8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 04:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B58E26281;
	Fri,  4 Oct 2024 04:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9cNpvhZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928828F3;
	Fri,  4 Oct 2024 04:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728016405; cv=none; b=Wg3UqfJYicZWUMCX9BiefR4PmJ2gguikZw1ANQJDixf5y5hPsBPNnTDHzAoczhaKYIpfzTyRlFaH/9DqGZtl98nsYBG9j42UGbXGwUrN3ANkCgUF7PeomzeFLLg3DqjGMM0n1vcE/5l825TCckI1ioMwJf0g7sxfe7uxi6Wyqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728016405; c=relaxed/simple;
	bh=F2URxu3+s9T4/haLxi1mElRi/bRX+TcMYZp/lHnLGIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppkNLe+Nv43KoHbUypl3pxwfRDx50pKl0eJdxFE/bj1W4pC12fH/bNC9gB249xc8VXWUy+9DLoTD3e/uR8d1dgRAJiGSh+m3h4CHsHMRQzWfF2Pi00oEBX6ss6WXLrLvYIe/ib/vdgOjl4veMJHUH1uBGmD0aRmx7ZJRF/s+Ylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9cNpvhZ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718d6ad6050so1500444b3a.0;
        Thu, 03 Oct 2024 21:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728016402; x=1728621202; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4H3N+8kws/awip/ldfxoLN4w9GM+lHkkjqCa2TtcbMw=;
        b=H9cNpvhZoPFe1x5nh9lZtv/rYrmRzg0BUoC0LpPjPizC4JjkjFJTWwnTuAiHQizAMs
         Izh6e7AAlGFDaav9grDaHYnG7kG4oxQSySWczLGeq39Qpr0D3jmIBT28ZmJ4piIDgCQ1
         EEW8Qg7rxv8OvIw5zJ9FnQqdkeRZRMi4icCVn7TwmBdfb7M0HYfwhB+C0uhhB/drehvb
         ffUNIqlBpni1I6H8pu14pNUQ91AGX8WpDGJke7akVX0S8t7N08wBXEtEGgXPTgJBnG9R
         uk2jR/GuzsMYO3rPbdDIEha1wNodHgIF2ODQp70oLuICAg6rAejF1oV+WjjbY3yUNtyc
         9sLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728016402; x=1728621202;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4H3N+8kws/awip/ldfxoLN4w9GM+lHkkjqCa2TtcbMw=;
        b=YB14CJ4oFAY8F8NPs9OEMC10MBZH75Gkr33r+b23icFCfoGzbPY5WWcxb+3j1jseBD
         dtr/+zmirK+j32YyyJzHdlnhhJihfWMGiuIb4r+MxXPHHFEmgysc+JdW449n1XVh5rbc
         uNrkY5jmXZM3Y7QgpwV3zAqkuCL7q//4+sgAB26HJyIORRfhJ79B86YfZOqurr425jpS
         Z0fqayv8LiCinwyb8FgW23z+SLaRHZqZ7iyUuQaN999+Q5cnpn4xwuUh98z1OuOM2lX2
         iUH2sDKLkz01YMFmZWtcRG+1JZM1STMZkecA1w9exIDLKwLzSpvxwzMRSmDJ9xd536H2
         FGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLTWga3hUz+JGqMi/uGK01kEscVyAgMXZlXAuxUj4Lbu/Th1JGVgIx8B+I6POE0uWqqq0feT2Ge2GNejo=@vger.kernel.org, AJvYcCXg9w00+4w1ItHFgwzrA0hJkqFVpJsISTnBo4S7SshA2FvoYSj9Q4+s7dr6CtEKnGpzkj4hRvsT+fE=@vger.kernel.org, AJvYcCXs63Rx6hhBm2hlCrsmykasYGHqx4RJp9qEg+lnZ2czzGf5q5z6I4Yx9dpxvmSBfFn+x60q2ia61j7M@vger.kernel.org
X-Gm-Message-State: AOJu0YzUYStziQlAu4uCB3uy3SRyCY3qLcgFMZrrOsJ0w/pQssDmQit2
	Q5okx1Des20Sr8JIngvWNOqZqvYPXOm+2mRJBVLAR/DDVurr1QaH
X-Google-Smtp-Source: AGHT+IHZ/dlDw1HTSCwlBso46egI2fiF3PmvQAr4tfWTXWWWlKdvB8u+56cni/cWhWAl+GoC/F8YYA==
X-Received: by 2002:a05:6a00:a470:b0:71d:ea77:e954 with SMTP id d2e1a72fcca58-71dea7814b1mr315163b3a.14.1728016402200;
        Thu, 03 Oct 2024 21:33:22 -0700 (PDT)
Received: from acelan-precision5470 (220-135-95-34.hinet-ip.hinet.net. [220.135.95.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d8bfcdsm2258221b3a.80.2024.10.03.21.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 21:33:21 -0700 (PDT)
Sender: AceLan Kao <acelan@gmail.com>
Date: Fri, 4 Oct 2024 12:33:16 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com,
	mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
Message-ID: <Zv9wDGp-7-lC8FhZ@acelan-precision5470>
References: <20240911190516.GA644336@bhelgaas>
 <319e5419-3b12-4672-9f51-f90c5e142e29@amd.com>
 <fa504022-acb3-4930-b6b8-87a8dcb912c3@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa504022-acb3-4930-b6b8-87a8dcb912c3@amd.com>

On Wed, Sep 11, 2024 at 02:38:20PM -0500, Mario Limonciello wrote:
> On 9/11/2024 14:16, Mario Limonciello wrote:
> > On 9/11/2024 14:05, Bjorn Helgaas wrote:
> > > On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
> > > > Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> > > > connected.
> > > > 
> > > > The following error message can be found during shutdown:
> > > > pcieport 0000:00:1d.0: AER: Correctable error message received
> > > > from 0000:09:04.0
> > > > pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable,
> > > > type=Data Link Layer, (Receiver ID)
> > > > pcieport 0000:09:04.0:   device [8086:0b26] error
> > > > status/mask=00000080/00002000
> > > > pcieport 0000:09:04.0:    [ 7] BadDLLP
> > > > 
> > > > Calling aer_remove() during shutdown can quiesce the error message,
> > > > however the spurious wakeup still happens.
> > > > 
> > > > The issue won't happen if the device is in D3 before system shutdown, so
> > > > putting device to low power state before shutdown to solve the issue.
> > > > 
> > > > I don't have a sniffer so this is purely guesswork, however I believe
> > > > putting device to low power state it's the right thing to do.
> > > 
> > > My objection here is that we don't have an explanation of why this
> > > should matter or a pointer to any spec language about this situation,
> > > so it feels a little bit random.
> > > 
> > > I suppose the problem wouldn't happen if AER interrupts were disabled?
> > > We already do disable them in aer_suspend(), but maybe that's not used
> > > in the shutdown path?
> > > 
> > > My understanding is that .shutdown() should turn off device interrupts
> > > and stop DMA.  So maybe we need an aer_shutdown() that disables
> > > interrupts?
> > > 
> > 
> > IMO I see this commit as two problems with the same solution.
> > 
> > I don't doubt that cleaning up AER interrupts in the shutdown path would
> > help AER messages, but you really don't "want" devices to be in D0 when
> > the system is "off" because even if the system is off some rails are
> > still active and the device might still be powered.
> > 
> > A powered device could cause interrupts (IE a spurious wakeup).
> 
> It's a bit of a stretch, but ACPI 7.4.2.5 and 7.4.2.6 are the closest
> corollary to a spec I can find.
> 
> "Devices states are compatible with the current Power Resource states. In
> other words, all devices are in the D3 state when the system state is S4."
> 
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/oem-supplied-system-level-control-methods.html
Hi,

I'd like to revive this thread and support this description from the
ACPI spec.

In ACPI 7.4.2.5, it states: "All devices are in the D3 state when the
system state is S4," and in ACPI 7.4.2.6, it says: "The S5 state is
similar to the S4 state except that OSPM does not save any context."

I believe this implies that devices should also be in D3 when the
system is in S5.

> 
> > 
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > >   drivers/pci/pci-driver.c | 8 ++++++++
> > > >   1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > > index af2996d0d17f..4c6f66f3eb54 100644
> > > > --- a/drivers/pci/pci-driver.c
> > > > +++ b/drivers/pci/pci-driver.c
> > > > @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
> > > >       if (drv && drv->shutdown)
> > > >           drv->shutdown(pci_dev);
> > > > +    /*
> > > > +     * If driver already changed device's power state, it can mean the
> > > > +     * wakeup setting is in place, or a workaround is used.
> > > > Hence keep it
> > > > +     * as is.
> > > > +     */
> > > > +    if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
> > > > +        pci_prepare_to_sleep(pci_dev);
> > > > +
> > > >       /*
> > > >        * If this is a kexec reboot, turn off Bus Master bit on the
> > > >        * device to tell it to not continue to do DMA. Don't touch
> > > > -- 
> > > > 2.43.0
> > > > 
> > 
> 

