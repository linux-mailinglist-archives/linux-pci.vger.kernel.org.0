Return-Path: <linux-pci+bounces-12800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B05496CC6D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 03:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D66285ECC
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 01:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A1F2107;
	Thu,  5 Sep 2024 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZysaNHIt"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791AED515
	for <linux-pci@vger.kernel.org>; Thu,  5 Sep 2024 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725501415; cv=none; b=cbzrmWrFq55VwWD0/CTm2/XE/G2uEgPYUNBBeP+MnTt+43JMkqFrDoB21eqBitnc43yXjzPsJobiGMBJf2Zvxjtb+JVcBfzQNl6CTpX6zFZKi41Nmcp0qoX9fSZZS6gG2/4JX7znL4HGVHtNxSEkeM3j5RjT25YPBJ1BGmiVtWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725501415; c=relaxed/simple;
	bh=X2jg/CSCnac1SLcSoXZn4AwOgINNBSYi5/6aptGjVHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRwhUTtGSAosDnk1hqV6c3eZWrKG6r9o9SaJ0Z1hJ3FDPUzHOuChNQpI4hPIKzY1D4sUPApjaBqjvFm5PBObSEWMWwqEiepGziacHIpOcf/Y2S5aWMQm5eMRVRVILT91VRY7Jx3FhlwbZQBOhqa+7PDdfW+qhufnudyoNh4VgXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZysaNHIt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725501412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V9IyXZANepgCuS2Qn0I3+uCl4ttAlaIVhX5WX8XO7Eo=;
	b=ZysaNHItyhsTjUAioxkySxQNPo6/EMGGTqcJcN8RuRh6LLYLD5OhV0BYDdllqao5eQWySt
	lp94xBBIsNsJhA7WnEJAZz0sWksx9mTzZxoR4qT2oiFr10g0rMWam/Xt08FBkXkZkNpt59
	STUIQd3q2hqSpDhdd2VtflLoyuAjESU=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-tLozfJpEOrOxlUXi7sXYhA-1; Wed, 04 Sep 2024 21:56:51 -0400
X-MC-Unique: tLozfJpEOrOxlUXi7sXYhA-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d3416bccdso173865ab.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2024 18:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725501410; x=1726106210;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9IyXZANepgCuS2Qn0I3+uCl4ttAlaIVhX5WX8XO7Eo=;
        b=CJtlzZSkGS3fUChhGunitSQrqfUaHr+MMAat7oI8nuogA+CUXl//wXfutdofPcexTO
         AfPGOqqHP2rOlJND0JM9tRmWSy6HKZ0T8nuE8mBb2dU8MSbikOFYOh79ZSFdtwOWY3yr
         XHcctgDsEq6QfRKcltx/7igoqYOVSu/0QhtDvs41B1dLrU5KAT1dE5OmIb/Flt6Awbr0
         xrCE5Tzw2al0Qhw4ZtQcEz3OnlSD9bvCVo3nHGwnYGYDqhyNMo/++F8rVZCbpfELPi8k
         MX4C84BV2WAkpdyyDt8MWFmFnWKEAoHQcDOIKEmKaqI+y2DwjwlV0UeVk1Lkbz6z1Lvi
         3rMA==
X-Forwarded-Encrypted: i=1; AJvYcCUIcgXG2ECZ9B4/k4exa8QlARL/Cpfh2AAlDYKdX454M1Bu+kOiSIsni6TWz8b+oUH4B7PgaILFEro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7HrDMMr4LptK1b8TxNw+InbRHQMqCYmHKX4tOLVrRGKgvpSPh
	i9Whk7yuPoi5ueTcPbyuqFKWdPodyccFqOyowLBEWWwf2rip1jxmO/28MPsUHxu2Cm3zY94cmqD
	AreQtgkbMC3AEBHO2GFaOldT5txjvv3GyasV2CZaEPg3y/NAeqB1a5rjo/A==
X-Received: by 2002:a05:6e02:219b:b0:39d:2524:ecdd with SMTP id e9e14a558f8ab-39f410bee53mr124314275ab.3.1725501410488;
        Wed, 04 Sep 2024 18:56:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtuPTPL6JAs0Wyp1aEX6Xiq0niWVe1RJrweFcEntVVHv73mDCPuCPFOAe1ckf/tW8jFMjlBA==
X-Received: by 2002:a05:6e02:219b:b0:39d:2524:ecdd with SMTP id e9e14a558f8ab-39f410bee53mr124314155ab.3.1725501410091;
        Wed, 04 Sep 2024 18:56:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2e92976sm3397323173.119.2024.09.04.18.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 18:56:49 -0700 (PDT)
Date: Wed, 4 Sep 2024 19:56:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Philipp Stanner
 <pstanner@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
Message-ID: <20240904195647.6489fedd.alex.williamson@redhat.com>
In-Reply-To: <65fe5c47-e420-4b4d-a575-2bb90e13482c@kernel.org>
References: <20240725120729.59788-2-pstanner@redhat.com>
	<20240903094431.63551744.alex.williamson@redhat.com>
	<2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
	<24c1308a-a056-4b5b-aece-057d54262811@kernel.org>
	<dcbf9292616816bbce020994adb18e2c32597aeb.camel@redhat.com>
	<20240904120721.25626da9.alex.williamson@redhat.com>
	<ZtjCFR3kd5GfV_6m@surfacebook.localdomain>
	<20240904151020.486f599e.alex.williamson@redhat.com>
	<65fe5c47-e420-4b4d-a575-2bb90e13482c@kernel.org>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Sep 2024 09:33:35 +0900
Damien Le Moal <dlemoal@kernel.org> wrote:

> On 2024/09/05 6:10, Alex Williamson wrote:
> > On Wed, 4 Sep 2024 23:24:53 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >   
> >> Wed, Sep 04, 2024 at 12:07:21PM -0600, Alex Williamson kirjoitti:  
> >>> On Wed, 04 Sep 2024 15:37:25 +0200
> >>> Philipp Stanner <pstanner@redhat.com> wrote:    
> >>>> On Wed, 2024-09-04 at 17:25 +0900, Damien Le Moal wrote:    
> >>
> >> ...
> >>  
> >>>> If vfio-pci can get rid of pci_intx() alltogether, that might be a good
> >>>> thing. As far as I understood Andy Shevchenko, pci_intx() is outdated.
> >>>> There's only a hand full of users anyways.    
> >>>
> >>> What's the alternative?    
> >>
> >> From API perspective the pci_alloc_irq_vectors() & Co should be used.  
> > 
> > We can't replace a device level INTx control with a vector allocation
> > function.
> >    
> >>> vfio-pci has a potentially unique requirement
> >>> here, we don't know how to handle the device interrupt, we only forward
> >>> it to the userspace driver.  As a level triggered interrupt, INTx will
> >>> continue to assert until that userspace driver handles the device.
> >>> That's obviously unacceptable from a host perspective, so INTx is
> >>> masked at the device via pci_intx() where available, or at the
> >>> interrupt controller otherwise.  The API with the userspace driver
> >>> requires that driver to unmask the interrupt, again resulting in a call
> >>> to pci_intx() or unmasking the interrupt controller, in order to receive
> >>> further interrupts from the device.  Thanks,    
> >>
> >> I briefly read the discussion and if I understand it correctly the problem here
> >> is in the flow: when the above mentioned API is being called. Hence it's design
> >> (or architectural) level of issue and changing call from foo() to bar() won't
> >> magically make problem go away. But I might be mistaken.  
> > 
> > Certainly from a vector allocation standpoint we can change to whatever
> > is preferred, but the direct INTx manipulation functions are a
> > different thing entirely and afaik there's nothing else that can
> > replace them at a low level, nor can we just get rid of our calls to
> > pci_intx().  Thanks,  
> 
> But can these calls be moved out of the spinlock context ? If not, then we need
> to clarify that pci_intx() can be called from any context, which will require
> changing to a GFP_ATOMIC for the resource allocation, even if the use case
> cannot trigger the allocation. This is needed to ensure the correctness of the
> pci_intx() function use. Frankly, I am surprised that the might sleep splat you
> got was not already reported before (fuzzying, static analyzers might eventually
> catch that though).
> 
> The other solution would be a version of pci_intx() that has a gfp flags
> argument to allow callers to use the right gfp flags for the call context.

In vfio-pci we're trying to achieve mutual exclusion of the device
interrupt masking between IRQ context and userspace context, so the
problem really does not lend itself to pulling the pci_intx() call out
of an atomic context.  I'll also note again that from a non-devres
perspective, pci_intx() is only setting or clearing a bit in the
command register, so it's a hefty imposition to restrict the function
in general for an allocation in the devres path.  Thanks,

Alex


