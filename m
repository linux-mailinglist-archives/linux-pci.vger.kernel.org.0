Return-Path: <linux-pci+bounces-18980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECE59FB3E4
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 19:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FC8188428F
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 18:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBAF1B393A;
	Mon, 23 Dec 2024 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTlLp5aH"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A187838F82
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734977733; cv=none; b=R18K+ojlTr/pF/j/6UsXLw1zLN5Qo2n4TyZpS6X1yLnckfCOyZ7LIcEgpOG5As4eylr/IZ6N6M2aVqdyZwwqtRLoik1ed5lwLQSKsrlOyf1woX9rssLGND8OElFU0L048Q+8ocos5h+AiA5dSjQYiwF7z31BA+pjeDp24+Y5WtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734977733; c=relaxed/simple;
	bh=8pDFmu8/1sF75hrfCbh9g3oxXjJ5jWjyvYPRTNtqsUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkgltFkJYSXcMYSKJ2T4jZlNGYFFxnbUrK3RDdNoFoGuCVEogVGIsSMR/IZn7Z6V73sPJojbUI/9nxD5Z0CXiL5oPDj43jQz3bAfoldUJguANDikN13/4WPeZUYt2ScQbOdQ5FRFw10zZsTfy7zN8ZHBHxL0TC3JBcvl3g1RCDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTlLp5aH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734977730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i779kwZKwslACzFfkM+4lV0vJyXdo9Mbz+mQvKzFbgg=;
	b=PTlLp5aHnAsmdorl96AwAGAWQgbWGJpYB5yuFVEZg/wL0WT/0JutW25xhakLax8MvgyKUh
	/fpbTB+c6Fu76DV8uVCeeoKkVJqRc5fhBc9eBkrp+3Qw52JFXLuaoAsghR0F4Ooz3MQTaw
	1BsUugxQniZOIFzXV+p8itg49cV9IaE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-s737_W10MwKOALCpRpkjEg-1; Mon, 23 Dec 2024 13:15:29 -0500
X-MC-Unique: s737_W10MwKOALCpRpkjEg-1
X-Mimecast-MFC-AGG-ID: s737_W10MwKOALCpRpkjEg
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-71e222441b7so26637a34.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 10:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734977728; x=1735582528;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i779kwZKwslACzFfkM+4lV0vJyXdo9Mbz+mQvKzFbgg=;
        b=p4vLp5+Upf42p9cLfsRAOI4RBYXcP0KNUKaEf77wZ4li7OelW051OzwgaRTNOAIkgE
         CplyMwxNEPI5qtRoVNKue72E9GQx99qnFjDQrbdCdSGVAG6nuLo2mfmW49KSn25P2CLs
         xTPMmt/4mmzcBWAC4zmq3JpbU9HjqsUUlrMiCPpFXWD1nNZCqgPwg08h5UptWiIM8AMd
         pEaaw8LpoIS+M9zk2UJmAbEn3LfyDBJ+vy0ZPxWcDfScpjHbflsXJERAgqCsEBxggCS3
         URa0k7RPRiauzuT5i34X811MRYsq6BhBrGLfgd2FFD6RnAGuPH8vSZ7R4mU38s/KIW+s
         W0hg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ6BOBUDaa1c4O9X23OtabTmgxZN7oTwpiNHXWiDafXSP4C+PgKBL+XYrjPsg8lvP928G7Ro/KLxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLGyowCuH5KZtaPex+beG4FKiBzVZdB+R8yQduC9NLYY3IXl6P
	LG3BEmx6R2ehGInzntK+XG30+kWJ1IPom0KK1fSvhpkgcRh+rxilZ9U3GErPWWIwy2dHS72oOiQ
	LXLdWdoA5m/k+zSGbxGYxH0i6TCLevFz+ULI+8npPUY2TEFYtkwnnkCjfiA==
X-Gm-Gg: ASbGncv49kx+SeZmZur8XS3hyyqqx1uw2iVZQ8ADw8UCm7AHhRl13hQFirxor8yWvmP
	U5MTGBpX2cYDUVGaowO2qen4PxRCxHZMV9BoU+gmCG+0uNjQBivbyynxqLv/Vyb3w1ZOjKD9IxE
	8Amt6I5TDH36EJdrGIzTdWJdn7Sp2YgCiM0lnaJLsQdSc/yCfU+TSbdIh/L4F6C8QthZNkTEyJR
	ugtWcrdnFVogcfoJ5BrtQt6jh+WMp0+9bZU6zGrzVmmva39JMHqZw/zAtgm
X-Received: by 2002:a05:6830:34a9:b0:71e:48b1:ad29 with SMTP id 46e09a7af769-720ff691e28mr2341872a34.2.1734977728569;
        Mon, 23 Dec 2024 10:15:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHL84ulGDZQJL2507Y3H15s+slqjLTXHJpf42Oh15OEYbs2ukq1so9LGjZjnTqyXM9iw8VcMg==
X-Received: by 2002:a05:6830:34a9:b0:71e:48b1:ad29 with SMTP id 46e09a7af769-720ff691e28mr2341863a34.2.1734977728249;
        Mon, 23 Dec 2024 10:15:28 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc97642e8sm2400002a34.5.2024.12.23.10.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 10:15:27 -0800 (PST)
Date: Mon, 23 Dec 2024 11:15:25 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>, Athul Krishna
 <athul.krishna.kr@protonmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 219619] New: vfio-pci: screen
 graphics artifacts after 6.12 kernel upgrade]
Message-ID: <20241223111525.0249057e.alex.williamson@redhat.com>
In-Reply-To: <Z2mW2k8GfP7S0c5M@x1n>
References: <20241222223604.GA3735586@bhelgaas>
	<Hb6kvXlGizYbogNWGJcvhY3LsKeRwROtpRluHKsGqRcmZl68J35nP60YdzW1KSoPl5RO_dCxuL5x9mM13jPBbU414DEZE_0rUwDNvzuzyb8=@protonmail.com>
	<Z2mW2k8GfP7S0c5M@x1n>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Dec 2024 11:59:06 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Mon, Dec 23, 2024 at 07:37:46AM +0000, Athul Krishna wrote:
> > Can confirm. Reverting f9e54c3a2f5b from v6.13-rc1 fixed the problem.  
> 
> I suppose Alex should have some more thoughts, probably after the holidays.
> Before that, one quick question to ask..

Yeah, apologies in advance for latency over the next couple weeks.

> > -------- Original Message --------
> > On 23/12/24 04:06, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >   
> > >  Forwarding since not everybody follows bugzilla.  Apparently bisected
> > >  to f9e54c3a2f5b ("vfio/pci: implement huge_fault support").
> > >  
> > >  Athul, f9e54c3a2f5b appears to revert cleanly from v6.13-rc1.  Can you
> > >  verify that reverting it is enough to avoid these artifacts?
> > >  
> > >  #regzbot introduced: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> > >  
> > >  ----- Forwarded message from bugzilla-daemon@kernel.org -----
> > >  
> > >  Date: Sat, 21 Dec 2024 10:10:02 +0000
> > >  From: bugzilla-daemon@kernel.org
> > >  To: bjorn@helgaf9e54c3a2f5bas.com
> > >  Subject: [Bug 219619] New: vfio-pci: screen graphics artifacts after 6.12 kernel upgrade
> > >  Message-ID: <bug-219619-41252@https.bugzilla.kernel.org/>
> > >  
> > >  https://bugzilla.kernel.org/show_bug.cgi?id=219619
> > >  
> > >              Bug ID: 219619
> > >             Summary: vfio-pci: screen graphics artifacts after 6.12 kernel
> > >                      upgrade
> > >             Product: Drivers
> > >             Version: 2.5
> > >            Hardware: AMD
> > >                  OS: Linux
> > >              Status: NEW
> > >            Severity: normal
> > >            Priority: P3
> > >           Component: PCI
> > >            Assignee: drivers_pci@kernel-bugs.osdl.org
> > >            Reporter: athul.krishna.kr@protonmail.com
> > >          Regression: No
> > >  
> > >  Created attachment 307382  
> > >    --> https://bugzilla.kernel.org/attachment.cgi?id=307382&action=edit  
> > >  dmesg  
> 
> vfio-pci 0000:03:00.0: vfio_bar_restore: reset recovery - restoring BARs

Is the reset recovery message seen even with the suspect commit
reverted?  Timestamps here would be useful for correlation.

> pcieport 0000:00:01.1: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:03:00.1
> vfio-pci 0000:03:00.0: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Requester ID)
> vfio-pci 0000:03:00.0:   device [1002:73ef] error status/mask=00100000/00000000
> vfio-pci 0000:03:00.0:    [20] UnsupReq               (First)
> vfio-pci 0000:03:00.0: AER:   TLP Header: 60001004 000000ff 0000007d fe7eb000
> vfio-pci 0000:03:00.1: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Requester ID)
> vfio-pci 0000:03:00.1:   device [1002:ab28] error status/mask=00100000/00000000
> vfio-pci 0000:03:00.1:    [20] UnsupReq               (First)
> vfio-pci 0000:03:00.1: AER:   TLP Header: 60001004 000000ff 0000007d fe7eb000
> vfio-pci 0000:03:00.1: AER:   Error of this Agent is reported first
> pcieport 0000:02:00.0: AER: broadcast error_detected message
> pcieport 0000:02:00.0: AER: broadcast mmio_enabled message
> pcieport 0000:02:00.0: AER: broadcast resume message
> pcieport 0000:02:00.0: AER: device recovery successful
> pcieport 0000:02:00.0: AER: broadcast error_detected message
> pcieport 0000:02:00.0: AER: broadcast mmio_enabled message
> pcieport 0000:02:00.0: AER: broadcast resume message
> pcieport 0000:02:00.0: AER: device recovery successful
> 
> > >  
> > >  Device: Asus Zephyrus GA402RJ
> > >  CPU: Ryzen 7 6800HS
> > >  GPU: RX 6700S
> > >  Kernel: 6.13.0-rc3-g8faabc041a00
> > >  
> > >  Problem:
> > >  Launching games or gpu bench-marking tools in qemu windows 11 vm will cause
> > >  screen artifacts, ultimately qemu will pause with unrecoverable error.  
> 
> Is there more information on what setup can reproduce it?
> 
> For example, does it only happen with Windows guests?  Does the GPU
> vendor/model matter?

And the CPU vendor, this was predominately tested by me on Intel +
NVIDIA.  I'm also not seeing any similar reports on r/VFIO, which is a
bit strange as there are a lot of bleeding edge users there.  The bz is
reported against 6.13.0-rc3-g8faabc041a00 and a revert against
v6.13-rc1 was reported as stable.  Has this actually been confirmed on
v6.12, or might something in v6.13-rc have introduced a new issue?

> > >  Commit:
> > >  f9e54c3a2f5b79ecc57c7bc7d0d3521e461a2101 is the first bad commit
> > >  commit f9e54c3a2f5b79ecc57c7bc7d0d3521e461a2101
> > >  Author: Alex Williamson <alex.williamson@redhat.com>
> > >  Date:   Mon Aug 26 16:43:53 2024 -0400
> > >  
> > >      vfio/pci: implement huge_fault support  
> 
> Personally I have no clue yet on how this could affect it.  I was initially
> worrying on any implicit cache mode changes on the mappings, but I don't
> think any of such was involved in this specific change.
> 
> This commit majorly does two things: (1) allow 2M/1G mappings for BARs
> instead of small 4Ks always, and (2) always lazy faults rather than
> "install everything in the 1st fault".  Maybe one of the two could have
> some impact in some way.

Athul, can you test reverting both f9e54c3a2f5b and d71a989cf5d9?  That
would provide the faulting behavior without yet making use of huge
pfnmaps.  Thanks,

Alex


