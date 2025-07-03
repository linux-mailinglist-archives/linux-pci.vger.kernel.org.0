Return-Path: <linux-pci+bounces-31390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78031AF748B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 14:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA60E1C80101
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B01D78F20;
	Thu,  3 Jul 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CarC+4mP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412302F29;
	Thu,  3 Jul 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546922; cv=none; b=bxr8dnw3RBkzGQYT9l+VsstGyYmIvXXaopGNzuVLrEvfrJKMjWFTwYC5u2eNb2m0Fdskoewq26PGNUfV91clXMH7+Q7sgz8ysDpZG7IqWqovGHm7c+hCbkjpiksWxplH4j8f+k+jZbp3OmT3FJVtbOW4fKP/mv7lQsJxHyCUGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546922; c=relaxed/simple;
	bh=Y1DqRawhBq29ZVz3sU79OAmlDRQXWLGIEbRJABK9Y3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHKrfx4bundoMREvfQvSNe4FZLkQS+iawVavGuh72co/UbKbWPDgHHHhFVt1sTdtajR/kDJxjkcRMNE+VFUyFg0K/nIlAJLPz9wyYdBp5lubjxB2kUD25u93kwePAO+tsDR62Cy5+OpO0StX4h8B8180y9P6qq51FBfVYnSgYpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CarC+4mP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A18C4CEE3;
	Thu,  3 Jul 2025 12:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751546921;
	bh=Y1DqRawhBq29ZVz3sU79OAmlDRQXWLGIEbRJABK9Y3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CarC+4mPf4sC/yG9N5GybD+SMbh2fMT+bby42KGcc/ntfzXXW/gkxEx2N4Hs63h2S
	 HeRDG0EpGV2pfmjrQbQRY8JKE/0bVpDDm8Mss5iNGAKc7OT1N+1K/VPaOXUbUQV6xm
	 IlnDcLTaPyhK83oN1IAMoxkXvozWiSKyeMctZftpmqyIop4BhBxSkhc8cJl7f8vpna
	 wyqoY8WyTv6F39qCQ90JpeK8W4ZEMIjBvDrhVbEu0/LHd1+sFVaWM4fvEhqmhbs6yW
	 4cIl//VGMeqQD+jX0v8VhelTaC+fhIg+4mZuZgrzFgEGA1+EbOPvRnmewg01us/Hmj
	 OxC1E6lpOkgdA==
Date: Thu, 3 Jul 2025 18:18:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?B?5ou05L2V?= <heshuan@bytedance.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, bhelgaas@google.com, 
	cuiyunhui@bytedance.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [RFC 0/1] PCI: Fix pci devices double register
 WARNING in the kernel starting process
Message-ID: <r7fgb5xrn6ocstq6ctq4q7r4o2esgh4rqr44c3u234kcep6thk@bge2vzl33ptb>
References: <20250702155112.40124-1-heshuan@bytedance.com>
 <aGYkx4a4eJUJorYp@sunil-laptop>
 <CAKmKDKksSTrT=wMBpnqGupe4WRnHosYZLunw0FdVbhW_dyym+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmKDKksSTrT=wMBpnqGupe4WRnHosYZLunw0FdVbhW_dyym+A@mail.gmail.com>

On Thu, Jul 03, 2025 at 07:31:10PM GMT, 拴何 wrote:
> Hi Sunil,
> Thanks for your reply! (really appricate it).
> This WARNING truly occurred. Through the added debug info, I found
> that the device was registered to proc via pci_proc_init and
> acpi_pci_root_add paths respectively, which ultimately triggered
> the warning message.
> Let me try to reproduce it on qemu first. I'll keep you updated.
> Thanks again.
> 

I think you have uncovered a valid bug. There is nothing preventing (except the
blessings of the initcall order) the occurence of the race between
pci_proc_init() and pci_bus_add_device(). I think it went mostly unnoticed
because, pci_proc_init() gets called very early before any PCI devices were
registered. So for_each_pci_dev() loop never gets executed.

But in your case, looks like the PCI device is available somehow before
pci_proc_init() gets executed. Now, it is not very clear to me how the device
becomes available at this point. It might be due to some other issue. But in
anycase, I think we need to get rid of calling pci_proc_attach_device() from
pci_proc_init() as I don't see a reason to call this function from two
different places. pci_bus_add_device() should be the one calling this function
as it is the one adding the PCI device.

Ironically, I do see a similar pattern for sysfs also. Maybe there is (or was) a
reason to create these files from two different places?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

