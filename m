Return-Path: <linux-pci+bounces-18979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC7F9FB360
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 17:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D9487A1936
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 16:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357D01B3939;
	Mon, 23 Dec 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6Kz5ET4"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616521AA1D5
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734973155; cv=none; b=nklsTdCFEUmoawz2sQCzUqJCECjU0t9LOYxpj5ernYWoSLGkUJh42C9O0+4RpqWvsZNEEguNVN+PiTKO91tM3rhs4bpEpPJmvA6O9r6SRSzyHlGNTAW6qelRHaZqCUHSDEAQrEidftwKvIBpJn0moT0/XL5kuN+CVWMz9AkMX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734973155; c=relaxed/simple;
	bh=/eXm46f1zqFCIapOpV+LJv6AU7meQGgq4bWoJc1Vl4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrRqgDgrDiw7fDmCrrttkAdyacLtqnxgANvv/IxN3Hqh8OAc6bgh18qaReblD2V6zaetbYs5e8PnkEii7JKfB9ecbrbbDfK6fmczST9pINGSt7dDa+Vi9rMNWdDyt38FffyiZ/KmuDEqVFaX/b1L38BKUumFHki4epgLaujfKSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6Kz5ET4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734973152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYhwmX9VYIzFjXFoGAhiV3rOfBz1b4KM/wduvPShNVk=;
	b=b6Kz5ET40IEoVsGyCA86Q7MKc/zznKMmDGr0USlxBKBf+S0xpH/SrHsVTyj88YaphR8HPB
	O6CANUh6GYJtI2BOxjElzDn4gqAPz7hLdChcT6FtuXOIekGpIdmlmNjsUZx6kxkzi9gJB1
	oxvMiO5+pgZ9cfpcUZvOL3YwV9bx2vk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-CIdGUugkPy2gYfHZfx8tJw-1; Mon, 23 Dec 2024 11:59:10 -0500
X-MC-Unique: CIdGUugkPy2gYfHZfx8tJw-1
X-Mimecast-MFC-AGG-ID: CIdGUugkPy2gYfHZfx8tJw
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8f6903d2eso72862546d6.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 08:59:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734973150; x=1735577950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYhwmX9VYIzFjXFoGAhiV3rOfBz1b4KM/wduvPShNVk=;
        b=b2ej4lOe8umj6TpnsTsGT+dES/MjyOz5RnpSrQqqp3N/nZVWFDis2bQw1+NnobWZg8
         SJ+zADIqITQS9/qk526Ds6ohbv8IGH2H5GiK+KndoQYVkF+idUZ/N0ozzylw0fMZwOEX
         7GBQ8t7xKb9g8TjC5IlFRfgXZWGzb7lGx4bax8xt3VRVcxu0ezhfaLl3EJFnxah7yNGy
         QF0g6XVBAWTbTTm/pk0xFMe185sU9qoe32N8HPGzYE6vD0FS8MIKDH4do2bD8vYtCHH7
         oIEM0ozgVLT8T+gN/7YTr7Z20rubhZhA/sEr1vbIow/TKjzZhrFDLNeBCIq7PUa8lRpi
         kYUg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+/df5mPwBKh2MVhOrpDjWvm/PfD4fDfFfbHqD6qgYcnLpaR18BTGN4h1zW4iFLXwbXCDzB1vcGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbSGfZpfjShEnpl+NgNnIQDcWj6Edtgc8ubqI+L6HiN82E+LBo
	dkNEIJ737sDH+60lkGSgWkSD0dZlmv0WYjkfi9sdschVd6wtOJ5Nx+QIVlY34ieO9L9opIDPopX
	3CFL9kIlZ4K1eIYfW0PEF4CKpJQsE5E/ANaDlh0mIPa03TE3IAY1WNtuVhw==
X-Gm-Gg: ASbGncsjEgkO//Tq1hZ/FrKZQRx/h/NgMqI30pHdgDEB0vx1Q9fYb5INYO4UfNvPj7k
	lGguReNpLpjm6l7Otuzg699ull1rNWd3UyaFozbWEoix6y4libglgNPwuvFULzIljkNv7LyqAGS
	m4yBlrKv9AGf7AyE1VKV4iqNeMUtH/8TAqvqEOcRYKP8PIC/7Sx7eiYt6AlBjSMg1w4AEJLH0ww
	7sFTvAZslQEjNMJkKzNB8k9U/UzMvz5t9YEfVjLsrTy9xrnP56k5A+rNUAshcsLaR0nU0aflHhe
	wGbK/5+Xb3rCRBT3lg==
X-Received: by 2002:a05:6214:27eb:b0:6d8:f612:e27d with SMTP id 6a1803df08f44-6dd2339ff38mr220808616d6.32.1734973149768;
        Mon, 23 Dec 2024 08:59:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiyg9xnnEYGXGK2rAB5forgSszecTTud5B0dq/EWmsMFf8C8vl0ZI9iiiIPpJtiZdzHVnwOw==
X-Received: by 2002:a05:6214:27eb:b0:6d8:f612:e27d with SMTP id 6a1803df08f44-6dd2339ff38mr220808336d6.32.1734973149413;
        Mon, 23 Dec 2024 08:59:09 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181c0fc5sm45137506d6.92.2024.12.23.08.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 08:59:08 -0800 (PST)
Date: Mon, 23 Dec 2024 11:59:06 -0500
From: Peter Xu <peterx@redhat.com>
To: Athul Krishna <athul.krishna.kr@protonmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 219619] New: vfio-pci: screen
 graphics artifacts after 6.12 kernel upgrade]
Message-ID: <Z2mW2k8GfP7S0c5M@x1n>
References: <20241222223604.GA3735586@bhelgaas>
 <Hb6kvXlGizYbogNWGJcvhY3LsKeRwROtpRluHKsGqRcmZl68J35nP60YdzW1KSoPl5RO_dCxuL5x9mM13jPBbU414DEZE_0rUwDNvzuzyb8=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Hb6kvXlGizYbogNWGJcvhY3LsKeRwROtpRluHKsGqRcmZl68J35nP60YdzW1KSoPl5RO_dCxuL5x9mM13jPBbU414DEZE_0rUwDNvzuzyb8=@protonmail.com>

On Mon, Dec 23, 2024 at 07:37:46AM +0000, Athul Krishna wrote:
> Can confirm. Reverting f9e54c3a2f5b from v6.13-rc1 fixed the problem.

I suppose Alex should have some more thoughts, probably after the holidays.
Before that, one quick question to ask..

> 
> -------- Original Message --------
> On 23/12/24 04:06, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> >  Forwarding since not everybody follows bugzilla.  Apparently bisected
> >  to f9e54c3a2f5b ("vfio/pci: implement huge_fault support").
> >  
> >  Athul, f9e54c3a2f5b appears to revert cleanly from v6.13-rc1.  Can you
> >  verify that reverting it is enough to avoid these artifacts?
> >  
> >  #regzbot introduced: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> >  
> >  ----- Forwarded message from bugzilla-daemon@kernel.org -----
> >  
> >  Date: Sat, 21 Dec 2024 10:10:02 +0000
> >  From: bugzilla-daemon@kernel.org
> >  To: bjorn@helgaf9e54c3a2f5bas.com
> >  Subject: [Bug 219619] New: vfio-pci: screen graphics artifacts after 6.12 kernel upgrade
> >  Message-ID: <bug-219619-41252@https.bugzilla.kernel.org/>
> >  
> >  https://bugzilla.kernel.org/show_bug.cgi?id=219619
> >  
> >              Bug ID: 219619
> >             Summary: vfio-pci: screen graphics artifacts after 6.12 kernel
> >                      upgrade
> >             Product: Drivers
> >             Version: 2.5
> >            Hardware: AMD
> >                  OS: Linux
> >              Status: NEW
> >            Severity: normal
> >            Priority: P3
> >           Component: PCI
> >            Assignee: drivers_pci@kernel-bugs.osdl.org
> >            Reporter: athul.krishna.kr@protonmail.com
> >          Regression: No
> >  
> >  Created attachment 307382
> >    --> https://bugzilla.kernel.org/attachment.cgi?id=307382&action=edit
> >  dmesg

vfio-pci 0000:03:00.0: vfio_bar_restore: reset recovery - restoring BARs
pcieport 0000:00:01.1: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:03:00.1
vfio-pci 0000:03:00.0: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Requester ID)
vfio-pci 0000:03:00.0:   device [1002:73ef] error status/mask=00100000/00000000
vfio-pci 0000:03:00.0:    [20] UnsupReq               (First)
vfio-pci 0000:03:00.0: AER:   TLP Header: 60001004 000000ff 0000007d fe7eb000
vfio-pci 0000:03:00.1: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Requester ID)
vfio-pci 0000:03:00.1:   device [1002:ab28] error status/mask=00100000/00000000
vfio-pci 0000:03:00.1:    [20] UnsupReq               (First)
vfio-pci 0000:03:00.1: AER:   TLP Header: 60001004 000000ff 0000007d fe7eb000
vfio-pci 0000:03:00.1: AER:   Error of this Agent is reported first
pcieport 0000:02:00.0: AER: broadcast error_detected message
pcieport 0000:02:00.0: AER: broadcast mmio_enabled message
pcieport 0000:02:00.0: AER: broadcast resume message
pcieport 0000:02:00.0: AER: device recovery successful
pcieport 0000:02:00.0: AER: broadcast error_detected message
pcieport 0000:02:00.0: AER: broadcast mmio_enabled message
pcieport 0000:02:00.0: AER: broadcast resume message
pcieport 0000:02:00.0: AER: device recovery successful

> >  
> >  Device: Asus Zephyrus GA402RJ
> >  CPU: Ryzen 7 6800HS
> >  GPU: RX 6700S
> >  Kernel: 6.13.0-rc3-g8faabc041a00
> >  
> >  Problem:
> >  Launching games or gpu bench-marking tools in qemu windows 11 vm will cause
> >  screen artifacts, ultimately qemu will pause with unrecoverable error.

Is there more information on what setup can reproduce it?

For example, does it only happen with Windows guests?  Does the GPU
vendor/model matter?

> >  
> >  Commit:
> >  f9e54c3a2f5b79ecc57c7bc7d0d3521e461a2101 is the first bad commit
> >  commit f9e54c3a2f5b79ecc57c7bc7d0d3521e461a2101
> >  Author: Alex Williamson <alex.williamson@redhat.com>
> >  Date:   Mon Aug 26 16:43:53 2024 -0400
> >  
> >      vfio/pci: implement huge_fault support

Personally I have no clue yet on how this could affect it.  I was initially
worrying on any implicit cache mode changes on the mappings, but I don't
think any of such was involved in this specific change.

This commit majorly does two things: (1) allow 2M/1G mappings for BARs
instead of small 4Ks always, and (2) always lazy faults rather than
"install everything in the 1st fault".  Maybe one of the two could have
some impact in some way.

IIUC basic paths were covered and hopefully should work, so I wonder what's
the specialty. Might be relevant to above questions on the reproduceable
setups.

Thanks,

-- 
Peter Xu


