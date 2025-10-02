Return-Path: <linux-pci+bounces-37482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E96BB59DF
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 01:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4D93B8128
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 23:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F35254B1B;
	Thu,  2 Oct 2025 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joTEh4HX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62929AAFD
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 23:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759448279; cv=none; b=U5s3Antv/m85ss+PjqSrApQzaBENtNVrChb0Cr11/GELkrxgT0sVaFVuSXlgr/aAABid2/8Q7MMtk8ys7A7+06/mmRE0hPpFZMsa1TeVsmHWjk3sne7tthbNzzu8f9rfbM6wrzRex3EAoGFuwWes+8WV+SaIM0ambE4zAtDIH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759448279; c=relaxed/simple;
	bh=ndbE5SRdJa387iex1CvMrbVJTg5ThSIu66ZRM8wfuxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tf/kglN4fjrXnyhTye6merb9H/E2ojokAQopUC37ibnrANAZUIdBtIeI7M6wcTjAtwpaNAlegLLYCi88uVtl38NeQuFubbTU7j0Fl8KOeEkbCfH0+HqFQuC2I8KXcvRikE6iuoBi6jQPVSGQmuUjTrLpNOY2lfZ+JvBbpsiDMuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joTEh4HX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781001e3846so1602993b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 16:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759448277; x=1760053077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yo4OOQ2Gn9UZ1SZQ1NtxFnlTa/5sG7I7sfhvuSyr5sY=;
        b=joTEh4HXXP2P/oM4BkQRLmyMB9XyhK0R9HJwXshr/FMltOWqVf/it53O9BauYe6XGn
         UQvQ7GjTJlTjS/u0lIfJNZQ0jgPNOoV8P5m6sYEs0j1SbMS8TByF313Ohw3Y4LY2EmoB
         nqPIkw2Xedc9FCC04G1xufk5nMB0GFxgA0pm9ysmtKz0dsMbG62Fw48/BN48f07+nWuZ
         Sy/iY5hYhrZWwLcXfI8PLIblan4qDFqaTe20oozSVCjvmuxnx22lk4dQcypp5zAD4okA
         GBabNBY90W2XNX3uc/AGun4MzFWsT9SrQmpq1G910/204VbS+O0z/WX1yci8cBSuQ11k
         qvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759448277; x=1760053077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yo4OOQ2Gn9UZ1SZQ1NtxFnlTa/5sG7I7sfhvuSyr5sY=;
        b=FAUS2B6eRY05Ys4Bz3fedK1qk0pfSVA70F5av6KAtv2Cxe5/PVaBJ8K7SIIuGpqcKw
         ulS3nZjWxGRx+oWKm4A4arCUmWMPkFrtD8Y57+ffPFKDiaZ2qA55bjUVxl79NRj6hDvo
         U3/0zItV1l06yxZHHnlDUG8KoX82D3VPkIMUMarwDZfOBw6+87UXXrOr7xiTV9FtqRuu
         8PFMiMflTHLK23tyhtRAjHhxzwgBbWXyvA5I9mOnnf7m2SAcwJyGJoiiUHD5dx4gGR87
         btURM4yFb6oBwlwN+ibi4Ttq/dA6D/pTrKOxcwHZ/SfxngKsWgscPP9+i0W5Apb+7hfg
         XcDg==
X-Forwarded-Encrypted: i=1; AJvYcCVVdjg3d7fp7ejmLruwBYm7VMwju7WBXXhqbxV7XD8nyWtHAkWbIFKEvYyzNDAg31Kf/nqBGaC/FqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+TXw0QW8zfXecgIdhuF6+eVNoGmiFPQ07MSGYEGGR3yrgrxFc
	ptAK70GJN/jN5c75ubsQO09JNHdfeJ5lN9W8OefvSvwuF6v5uHytzG5x
X-Gm-Gg: ASbGncs4FqLCdxeMPK1g5nAe1CIq1Wva5daVxttFPg2qVPBjFTf7rTFs172cZA4j1ae
	HYoFljAX12C0pVX38X7gX9PInjf1+DXk5Ldlbcp266PI6N4HfS29ZgfGwXzj08YKQRhDVOdyV5B
	fZ///ItXocW0336tGEmGHaWc7WMiU+d0gnH/yXF41o5/EwsRG4+d5WfNd2i9NTuhAg6AZqc7res
	t2EeGMJfKbHxsnPzThLG6VEGyV2uYiwEJQgWmWJPciGOilwKlJjEyUrdVJ2X0upueFABoAFWLmh
	/t0MZrJEuRg2di+6lZtCD6jzCQFrrvFXmeDZ/JIW7zwjS6Ltc5ZTWCIAjxkXhG2a5wr9qt89Eqn
	7ZlIMf5XpsV1PUaBXo55oZhV19lTPMk4fZ6aIB7fvLhqcmQ==
X-Google-Smtp-Source: AGHT+IHZgIaYVQ/Otn93VxKlra2VwVcQbCOZX1PdrjE1EEOi3AxPBUBHUwTifqQ/jIsvUT72XjIdxw==
X-Received: by 2002:a17:90b:1b49:b0:335:2d4:8b3d with SMTP id 98e67ed59e1d1-339c27bda3emr1069294a91.31.1759448277454;
        Thu, 02 Oct 2025 16:37:57 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-339c4a19fe4sm193905a91.8.2025.10.02.16.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 16:37:55 -0700 (PDT)
Date: Fri, 3 Oct 2025 07:37:21 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Kenneth Crudup <kenny@panix.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com, 
	linux-pci@vger.kernel.org
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Message-ID: <rmfs32rqwiwergekmikednlm2zikakhvdtjnx54b4q3neznghl@3pqvqralvofd>
References: <af5f1790-c3b3-4f43-97d5-759d43e09c7b@panix.com>
 <c6yky4m3ziocmvgblepbdr33j4irwlzew7z4ch2hnhj44otpwf@n2yo5sselj73>
 <e5c6756b-898e-475a-a390-391edfdc0943@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c6756b-898e-475a-a390-391edfdc0943@panix.com>

On Thu, Oct 02, 2025 at 03:50:11PM -0700, Kenneth Crudup wrote:
> 
> > > I bisected it to the above named commit (but had to back out ba9d484ed3
> > > (""PCI/MSI: Remove the conditional parent [un]mask logic") and then
> > > 727e914bbfbbd ("PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
> > > cond_[startup|shutdown]_parent()") first for a clean revert.)
> 
> On 10/2/25 15:28, Inochi Amaoto wrote:
> > I think this has been fixed and the patch is merged in the latest
> > mainline. Can you try
> > https://lore.kernel.org/all/20250827230943.17829-1-inochiama@gmail.com
> 
> But isn't this 727e914bbfbbda9e, which exists already in Linus' master RN?
> 

Right, I failed to recall the right commit. And that's the fixed one.

> I have a Dell XPS-9320 laptop, and booting would hang before it switched to
> the xe video driver from the EFI FB driver (not sure if this is a symptom or
> partial cause) and I'd see a message akin to "not being able to set up DP
> tunnels, destroying" as the last thing printed before it hangs. (If it's
> important to see those messages I believe I can force a pstore crash to get
> them where they can be saved off, let me know). 

I think it is good to have some more information like call trace to know
whether is caused by this change, or the side effect from other commit.

I also suggest adding someone related to the xe driver or create an issue
for it. It is pretty weird as my x86 machine with AMD card has no problem.
I will try to reproduce it if I can find a idle board.

Regards,
Inochi

