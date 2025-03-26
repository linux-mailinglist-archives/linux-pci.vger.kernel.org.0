Return-Path: <linux-pci+bounces-24739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C143FA7121A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955A83BBF93
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15411A0BD0;
	Wed, 26 Mar 2025 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="tt/oHxaa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C748119DF53
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976628; cv=none; b=Fk2DWNBUu794jpqilFwvpVYv7js26uBH70z7CGH9hjCArJRl7Ff9aG6pY8PFYyQY4ylY1rONMBS0X8LYw7MnmBsLbiMu2RyGX5SWPWscljCOIrq/ci05RpOrp944m1xwovQs4wVvUvjpXXUKmr4IN+pm0ABzy4QWPa4FP4PnROA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976628; c=relaxed/simple;
	bh=tPcx2OUnS88u4uZ3rmQxImoG8Yl21ahza5/N7F+fo5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsonvxrK7KzXJjXz+ghp86jNdtXS2vExSyVJawu0hrHy2DI5e8/FUIx0Iuql6Lvm1Uh/dgW8GTrfa5BBokXyE0N1t+nmnbY/u9o6tmBa2egFt20dxdj762qxDjiK6EBIpes5LLbb5NBkMFQIyz7tRHfw9+HrdUC8OUzNV445/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=tt/oHxaa; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so10700503a12.3
        for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 01:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1742976625; x=1743581425; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zvoZdGIIh0nptv4x2hyk3srE7837z4cLxs0snnCK7ls=;
        b=tt/oHxaaLS5vdqiomQt4scANeIjqufBGAtuWUEomqpWNHU9ZlDHAN4SW2yhbliKvLn
         ucZscRnTojdHVTsAaDVQO7MhBcokgUv8WKSUvqQCcB5FA0bvUlcA8dXXC4Z7Qwe1K7Mh
         Yc1vbWc3P1hADUCVMx8IQyKHg7hSxNkXgrDNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742976625; x=1743581425;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvoZdGIIh0nptv4x2hyk3srE7837z4cLxs0snnCK7ls=;
        b=Fn8TPRnm8sNqIEWRhEfeh9DRARyYEP0QOBBiW0+rD+QqHnWnPE3FzYe9ou8lTNglnS
         h7M1vvWcfv/bLIkRnieRx+ERf+lCMutRMiGkjM8q550HtcenY++QglarjYrUFAL3qT1H
         WfDW5RGfa85eQliBhaxWUdl1g8eXELLK2twK7LeRWw31Uu1nYGQv1pOFaS3Yhd0Rwso3
         FnRy290NT4MZqkR603zNY3F4P51i/127BF3/YkvuAv4r2UAKO5KHPmHnqvrghTRpPTIf
         sVTBQ47v7j8Akik/x+zfwg7GDbQeIrdtWlBfOZEbuYt3bIZGKIQ9cUdq/x5j/QuyN34E
         bi3w==
X-Forwarded-Encrypted: i=1; AJvYcCWztfNj+74RQsySreDdfoM1PY981Rb74bRRnuDbsIcrfFZlOVkLIcvcvYGLUk9gJap03mOAlaSxvxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPW+IqgRycy2KYL1FrvsfWUwbjB9S+TQD9rNb0GotVUdoNYtzW
	5TjUHUDjVPcUxuWNHGc0EJVxy2ae7bcIaFTnxzYLGUE7X7XiXffj4flkhfV8IoU=
X-Gm-Gg: ASbGncv0FgDo8A5gU9n4uBt38Jz5uT1wt7Fx9Ad1DwNQq9tk6KIxsOMgCsASjshZuDx
	D8VNsHIGNsy7KmxKQBS9jPOM7ZV8MYV5Hy+yXqeEWG/965WgSifn7ihzReOjvd16AjVYXaTe4pQ
	hurDNrmH98oJAJTTBs9lE7SZwmPoUYRUnww6chBk9yBbwXkQ/3jpD/JR1UA9JCWbnnlsl/UNzY1
	fsmcEgk3gzGf/mfTZiS2LdiCQy855qZOisCeshfkUe5m/WSptDDaJluKkezQN6pYW6+siPoOfLI
	5gEIAPW6XVWeIb8xL5UJNvI6BrqH3rjIB2taKFoKnebfswY6Og==
X-Google-Smtp-Source: AGHT+IFk/oQ4dEeG6SP1NjnX7dgOQ//K7a8iza3+Ms4rsYBb+Te5rd3AJ8dLKHMNssy8DXdKiQsVgA==
X-Received: by 2002:a05:6402:4306:b0:5dc:c531:e5c0 with SMTP id 4fb4d7f45d1cf-5ebcd519e7fmr18000389a12.27.1742976624991;
        Wed, 26 Mar 2025 01:10:24 -0700 (PDT)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5ebccfb0e97sm9080244a12.45.2025.03.26.01.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 01:10:24 -0700 (PDT)
Date: Wed, 26 Mar 2025 09:10:23 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Gomez <da.gomez@kernel.org>,
	=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 3/3] PCI/MSI: Convert pci_msi_ignore_mask to per MSI
 domain flag
Message-ID: <Z-O2bwbYFvOzZw0t@macbook.local>
References: <20250320210741.GA1099701@bhelgaas>
 <846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>
 <qn7fzggcj6qe6r6gdbwcz23pzdz2jx64aldccmsuheabhmjgrt@tawf5nfwuvw7>
 <Z-GbuiIYEdqVRsHj@macbook.local>
 <kp372led6jcryd4ubpyglc4h7b3erramgzsjl2slahxdk7w575@jganskuwkfvb>
 <Z-Gv6TG9dwKI-fvz@macbook.local>
 <87y0wtzg0z.ffs@tglx>
 <87v7rxzct0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7rxzct0.ffs@tglx>

On Tue, Mar 25, 2025 at 10:20:43AM +0100, Thomas Gleixner wrote:
> On Tue, Mar 25 2025 at 09:11, Thomas Gleixner wrote:
> 
> > On Mon, Mar 24 2025 at 20:18, Roger Pau Monné wrote:
> >> On Mon, Mar 24, 2025 at 07:58:14PM +0100, Daniel Gomez wrote:
> >>> The issue is that info appears to be uninitialized. So, this worked for me:
> >>
> >> Indeed, irq_domain->host_data is NULL, there's no msi_domain_info.  As
> >> this is x86, I was expecting x86 ot always use
> >> x86_init_dev_msi_info(), but that doesn't seem to be the case.  I
> >> would like to better understand this.
> >
> > Indeed. On x86 this should not happen at all. On architectures, which do
> > not use (hierarchical) interrupt domains, it will return NULL.
> >
> > So I really want to understand why this happens on x86 before such a
> > "fix" is deployed.
> 
> So after staring at it some more it's clear. Without XEN, the domain
> returned is the MSI parent domain, which is the vector domain in that
> setup. That does not have a domain info set. But on legacy architectures
> there is not even a domain.
> 
> It's really wonderful that we have a gazillion ways to manage the
> backends of PCI/MSI....
> 
> So none of the suggested pointer checks will cover it correctly. Though
> there is already a function which allows to query MSI domain flags
> independent of the underlying insanity. Sorry for not catching it in
> review.
> 
> Untested patch below.

As I'm getting reports of other people hitting this issue, is there
anything that needs to be done from my side to get the fix into
linux-next?

Thanks, Roger.

