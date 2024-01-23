Return-Path: <linux-pci+bounces-2485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758F18393E0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 16:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2FC1C2397B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC7360ECD;
	Tue, 23 Jan 2024 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5JmPDOA"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C7B60DD1
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025343; cv=none; b=LiH67KBp3cdJ4S53ISvxVEsEjIWIPueVO8GghzUzm5Cc1771pTD+Lq4Jdd5l9goPD7A4Fg6tFRj3UdX8faqOZ9Ia5FsZz2q8WzxHRlLRoucGDw6x7DnHOGSM8Hidlh1fVXi/eUI+eKLEGAMr/HrFN1V27evtfOL8fJYW2Aai0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025343; c=relaxed/simple;
	bh=szUZSkb5KkY1XXTL2ydXpMJbCb8a3hnlpzYn5FWYKKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGy3y++mT4/DIiBvf4rutUsoKJvPH14jZ1gbO/wuoEKpv8jiS5sQzmwuAfZryLJ2Aiyk13nqocnLQbYxWxp/Hy5r+h2LWWeOuVBfunTuUgxrakZIQFZIwtINxjYKtvQPF2hWU8uXL2IJjx5cNz9EwgC1eF7s52W3k2CeXUfRjAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5JmPDOA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706025338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sCueOm7+YIV1uypCrFlqek9GTnabxDJ4c738N9GAnY4=;
	b=e5JmPDOAL+vw2jF6mvSR2R10awCM2Sd6puKaTCSYJlUp9CjhpXhnETpwpNFxIZF9yrtprB
	ST//a/gNCHaxERZKjvJnNYD4IkaHXdbFHU/1/R7MpQ44OCSAgucCI2z/GNrxjA68uB7lsl
	F7PMftTS0x2VnwbVhbKaGje6mCeJYV8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-e13B8aloMtKa_KTtRnOk-g-1; Tue, 23 Jan 2024 10:55:35 -0500
X-MC-Unique: e13B8aloMtKa_KTtRnOk-g-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7baa66ebd17so473298539f.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 07:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025323; x=1706630123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCueOm7+YIV1uypCrFlqek9GTnabxDJ4c738N9GAnY4=;
        b=NoDZT9gPHpcSyr/yc73eBkmdqP8f12cpzYhlZjUIuleQD0QcWs6mB0OLLcdJI0Lr+q
         y50O7ucVfKFtcjKs+9lrHHkNTTCsR+Da5LZZ3/uiJ6ZKcmpopMo7O93IEH+EPsrUUI1c
         8POxrPCxb3ChgUswEVymL20QMT1QGDvpk5pTcE2sda07wsSVW+vBemCVzXsXbNXFXVWb
         PqexFtNsHFClIbtiAGsXQmU93T/hD3wlFUBuFG/uFuo2xJPGC9GhPpQpMl6po1g+GaCV
         Avnge2p9nFX9Tqa7lrJG4WYnq9iIWWMiz0V8Swl/xXVHnq/1VgN5NXP3gOg84JNr5SMt
         ITMA==
X-Gm-Message-State: AOJu0YzbGIeX7Gaz5e/hUQXVEb8edGe4aWsBriLxbrrXGngTmIqijWiH
	TC6JPm/mhTgFXlpAqD1C8l8wLMvDlFGGttHanDdP33JFHGQYt6EyG3cSLvvHrlDK8CZTwfvq7FM
	sKtHrjbxJA4yviCbOKnplwsDYza0Yy/mfujuETDkP1RLu5nW/2gFpAWm20Q==
X-Received: by 2002:a6b:6515:0:b0:7bf:705c:f9cd with SMTP id z21-20020a6b6515000000b007bf705cf9cdmr99564iob.38.1706025323699;
        Tue, 23 Jan 2024 07:55:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH38iCjX+AEd64T4UT/2KKdkE95022H/qcfVu2tE/vKCgVvGn5gfiViiWPx9v0cG2g2zKjB3g==
X-Received: by 2002:a6b:6515:0:b0:7bf:705c:f9cd with SMTP id z21-20020a6b6515000000b007bf705cf9cdmr99549iob.38.1706025323389;
        Tue, 23 Jan 2024 07:55:23 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id x2-20020a029482000000b0046d17aff31bsm3738272jah.157.2024.01.23.07.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:55:22 -0800 (PST)
Date: Tue, 23 Jan 2024 08:55:21 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
 linux-kernel@vger.kernel.org, eric.auger@redhat.com,
 mika.westerberg@linux.intel.com, rafael.j.wysocki@intel.com,
 Sanath.S@amd.com
Subject: Re: [PATCH v2 2/2] PCI: Fix runtime PM race with PME polling
Message-ID: <20240123085521.07e2b978.alex.williamson@redhat.com>
In-Reply-To: <20240123104519.GA21747@wunner.de>
References: <20230803171233.3810944-1-alex.williamson@redhat.com>
	<20230803171233.3810944-3-alex.williamson@redhat.com>
	<20240118115049.3b5efef0.alex.williamson@redhat.com>
	<20240122221730.GA16831@wunner.de>
	<20240122155003.587225aa.alex.williamson@redhat.com>
	<20240123104519.GA21747@wunner.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 11:45:19 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> On Mon, Jan 22, 2024 at 03:50:03PM -0700, Alex Williamson wrote:
> > On Mon, 22 Jan 2024 23:17:30 +0100 Lukas Wunner <lukas@wunner.de> wrote:  
> > > On Thu, Jan 18, 2024 at 11:50:49AM -0700, Alex Williamson wrote:  
> > > > To do that I used pm_runtime_get_if_active(), but in retrospect this
> > > > requires the device to be in RPM_ACTIVE so we end up skipping anything
> > > > suspended or transitioning.    
> > > 
> > > How about dropping the calls to pm_runtime_get_if_active() and
> > > pm_runtime_put() and instead simply do:
> > > 
> > > 			if (pm_runtime_suspended(&pdev->dev) &&
> > > 			    pdev->current_state != PCI_D3cold)
> > > 				pci_pme_wakeup(pdev, NULL);  
> > 
> > Do we require that the polled device is in the RPM_SUSPENDED state?  
> 
> If the device is RPM_SUSPENDING, why immediately resume it for polling?
> It's sufficient to poll it the next time around, i.e. 1 second later.
> 
> Likewise, if it's already RPM_RESUMING or RPM_ACTIVE anyway, no need
> to poll PME.

I'm clearly not an expert on PME, but this is not obvious to me and
before the commit that went in through this thread, PME wakeup was
triggered regardless of the PM state.  I was trying to restore the
behavior of not requiring a specific PM state other than deferring
polling across transition states.

> This leaves RPM_SUSPENDED as the only state in which it makes sense to
> poll.
>
> > Also pm_runtime_suspended() can also only be trusted while holding the
> > device power.lock, we need a usage count reference to maintain that
> > state.  
> 
> Why?  Let's say there's a race and the device resumes immediately after
> we call pm_runtime_suspended() here.  So we might call pci_pme_wakeup()
> gratuitouly.  So what?  No biggie.

The issue I'm trying to address is that config space of the device can
become inaccessible while calling pci_pme_wakeup() on it, causing a
system fault on some hardware.  So a gratuitous pci_pme_wakeup() can be
detrimental.

We require the device config space to remain accessible, therefore the
instantaneous test against D3cold and that the parent bridge is in D0
is not sufficient.  I see traces where the parent bridge is in D0, but
the PM state is RPM_SUSPENDING and the endpoint device transitions to
D3cold while we're executing pci_pme_wakeup().

Therefore at a minimum, I think we need to enforce that the bridge is
in RPM_ACTIVE and remains in that state across pci_pme_wakeup(), which
means we need to hold a usage count reference, and that usage count
reference must be acquired under power.lock in RPM_ACTIVE state to be
effective.

> > +			if (bdev) {
> > +				spin_lock_irq(&bdev->power.lock);  
> 
> Hm, I'd expect that lock to be internal to the PM core,
> although there *are* a few stray users outside of it.

Right, there are.  It's possible that if we only need to hold a
reference on the bridge we can abstract this through
pm_runtime_get_if_active(), the semantics worked better to essentially
open code it in this iteration though.  Thanks,

Alex


