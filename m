Return-Path: <linux-pci+bounces-24636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD01A6ED7F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2A418906EB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29A01C84A6;
	Tue, 25 Mar 2025 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="V2yuKrpF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9A71FDD
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898128; cv=none; b=PxCarXeBbBqCiO1kTPYk8lJLvN7d4DbgXw8uo5sLVOkX9A3h2YEwjWtJJx9tJPoPqS9Dr9bC18LEdtMdazl+tSLxGMGin9EputcM7WcAsvlnxgRyUlvIITMyzXRnPAcdGwx/FQcysh18XRXB5o6EdGf9PyNbYmG0FooVdTqZc1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898128; c=relaxed/simple;
	bh=M5S7ZLwakXniYp0byHlo43iXNWTTXi2KKHi/LjIwHNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQVtMIJRXnu4eyfM+Px/KC4M5BfGQIhLzmhUESnQZEWFMulfmISjaKt1Dcy8paeYcPHOU5soU5qKpr8ThN39Kz4X16iII1X91YU2BPMpbChGQ69pt66vU+5CoM6sqa4Lcl8RwrAuLfMDnNcnqvyLCbFGPrnYqvXtDdjdUIEf/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=V2yuKrpF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224171d6826so32635895ad.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 03:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1742898126; x=1743502926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gQs2MQ7qVRbNMJHbCM5bWSarB3xGRHf2C0jjYhuIPRM=;
        b=V2yuKrpFbJdb+5Z6fYE4yRWPf/bmkNiIrps1haTVXMIPT//OUoJEB71IgfJiJpwEjp
         PtLVtltCwiXCDfrKHY1n6AJdjCDcd8C4ZVmIrEAc6N3QhcjnBfztYQyHp5WWQKdK25zC
         9oakLTTUkFaMdmICKztIObpeG7ored4A0z8Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742898126; x=1743502926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQs2MQ7qVRbNMJHbCM5bWSarB3xGRHf2C0jjYhuIPRM=;
        b=Qm73tYxHm8bPNd13LS2lBVzLv7W/sjoRdFAIwyWBjm/Fc7h3qQIAfLBq+zMIXPqJGx
         nn4ZPCV/P/LNe0B3ly94coCh28Z2G8NkqLXk2ovmXJCdlf0nQ9AxvIIynKk8E5XOpXJ1
         KZWkUSLjEELVU/BVovu4t3QBPHKN3xKBJMjxhXkp6l+6hyDL8I7So4NjKGnJphyamNWB
         llNzMgXrQ6IC+5WBtG042LxgIepnmSgXMen+AehRB8sfGBSX55aRJpAL6PNpDgJ3xzLI
         0a7sJPiL+deupenLpKgvqGa7IwCCd/yrmHw47lfREFc1D1mNOhbvb3liptfdXLI+8jfX
         zxew==
X-Forwarded-Encrypted: i=1; AJvYcCUznI8r72BhcJf/0wNIfceXDH3TjouxuWnh5t3/mdrE36HUcFoYQYSt17fvN6RC6JoEHilPt/yJNXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpDkL8kxBYDyC4hIklFxbIyG1bPZfloszclJoJlBEP9DN10M9e
	S68yDWNI6WDKhkutvpao6jobtYnMGxiHiNMgIXqUPupSwiSSfmwSrU2/tjgMwV4=
X-Gm-Gg: ASbGnctLLgYwKO8+pEJyIjiWA2aaGcbn3MVF7aLy4KzHCCZRwy6/AZYIWuSQ6AUsNq4
	lJnaqUOn8eGzzfgqrYb4NsUbhgCfTig8vnh6MRjAbAFyp2ZlrGX68Uo1gN3Ek0eM0M5P7EHyWMP
	5T/lzTrh+WyIz95LAP4aKtkJ+h/2j+2OQqmrFyIezGLR2R+ce5bCKp5r/tY45+9Y1TyCDqf6Ugy
	HH5VNhYAI2Ir18YFFMTv2guGiVfdH+xebCWG0+ZppRZl0CjNtC2T+vcvAYA4fIL1F35LAEJLNT8
	aIL3jpjtWyJByJ40asNS+sGdItV7ilouogAw4ATWzdGPd7vOOQ==
X-Google-Smtp-Source: AGHT+IF85xhWKCrs08RP4P7IKWzeGYUYqC72eXPjEagDGhBRZZgGX/BU+7NeI+5hClPwqyJM9bhKWA==
X-Received: by 2002:a17:902:ef11:b0:224:c46:d166 with SMTP id d9443c01a7336-22780e14e84mr295978445ad.40.1742898126108;
        Tue, 25 Mar 2025 03:22:06 -0700 (PDT)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811c0cb8sm86079655ad.122.2025.03.25.03.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:22:05 -0700 (PDT)
Date: Tue, 25 Mar 2025 11:22:00 +0100
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
Message-ID: <Z-KDyCzeovpFGiVu@macbook.local>
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

I'm a bit confused by what msi_create_device_irq_domain() does, as it
does allocate an irq_domain with an associated msi_domain_info
structure, however that irq_domain is set in
dev->msi.data->__domains[domid].domain rather than dev->msi.domain,
and doesn't override the default irq_domain set by
pcibios_device_add().

And the default x86 irq_domain (set by pcibios_device_add()) doesn't
have an associated msi_domain_info.

> So none of the suggested pointer checks will cover it correctly. Though
> there is already a function which allows to query MSI domain flags
> independent of the underlying insanity. Sorry for not catching it in
> review.

Oh, that's nice, I didn't know about that helper.

> Untested patch below.

LGTM, but (as you can see) I'm not expert on that area.

Thanks, Roger.

