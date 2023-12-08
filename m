Return-Path: <linux-pci+bounces-708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5367880ABB0
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 19:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4289A1C20AE3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 18:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5B31F61F;
	Fri,  8 Dec 2023 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eei2E4b+"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C90AA3
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 10:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702059139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRPGGJT3L2nskXf0DpDITrIYnHsXPHPWACprYkXS8AI=;
	b=Eei2E4b+sRqXQCTkX6HfyNupy8fHdIwgHBfyY6JAfwlJQ5XiA8deqdYDKkdkYq1sBSXNF2
	R/tetP9wIBcIny1t/8wg/lTCD7zrzyvvInfMeNc1UrDHjxOG0kzcGN+upe7dyHGiWBR5kw
	kPLba8zU7qsw6+JAqYA6wq1AueaO3aQ=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-8DVBTQcPMqq1vejng45oDQ-1; Fri, 08 Dec 2023 13:12:17 -0500
X-MC-Unique: 8DVBTQcPMqq1vejng45oDQ-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35d62f23044so22885755ab.1
        for <linux-pci@vger.kernel.org>; Fri, 08 Dec 2023 10:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059137; x=1702663937;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRPGGJT3L2nskXf0DpDITrIYnHsXPHPWACprYkXS8AI=;
        b=BbTMF/Ib9wgdxOQTMm6/UJJ4jaoHt7z+++y/WTp5+hJprpy33L9OZXGx4pKAIEtuKw
         aRLuFPY4FGBMOSaryYFJG5wlwJ3VEH9uGkMj/ckNnTOkK9SvFEGbzcIWb5BFTejLYdMK
         3ntpOYwpSmyw6Nhdb3iBcmK/VMren6YevjPHMbfm4zc+9/AvDIpP+zkfNBx+a2ontwuZ
         PfAqk2faXOx3kJ/6/E0EcobmtivzAy/lWm2kwb0wF5hJMOPUThCYNx4PnoECAAxndQYl
         xhT/NeNTVi26DDzcOVuip2RbEzYfVsi0v+eiwOUJCZLnR1bgcWsxbuCJTOAQ5SV5umzO
         LyKg==
X-Gm-Message-State: AOJu0YwAL7ckmI9oozwv0QbJ1X5F7H3kcrkzHZ+Gsa/pOwvvwFHqBwmw
	yhq4e5KLMvheXFXf1gYDWFJuehn2/gC8CVI+GFL8Oxi73HWwYS0QWa9MqEYVoPSdjXW6DykX6sZ
	2vnh0MwIZpRawMtaFTOCF
X-Received: by 2002:a05:6e02:16c8:b0:35d:5220:8eb5 with SMTP id 8-20020a056e0216c800b0035d52208eb5mr870094ilx.11.1702059137042;
        Fri, 08 Dec 2023 10:12:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNT/qwx2NwZS2n7PFtjpCL8A3JWB2z9aBM2WpuL1CUpLEt3y15nJUti/RVXGeFmO4HMmKFhA==
X-Received: by 2002:a05:6e02:16c8:b0:35d:5220:8eb5 with SMTP id 8-20020a056e0216c800b0035d52208eb5mr870082ilx.11.1702059136810;
        Fri, 08 Dec 2023 10:12:16 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id cn6-20020a056e02388600b003594b40e4e2sm679952ilb.0.2023.12.08.10.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:12:16 -0800 (PST)
Date: Fri, 8 Dec 2023 11:12:15 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jim Harris <jim.harris@samsung.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "ben@nvidia.com" <ben@nvidia.com>
Subject: Re: Locking between vfio hot-remove and pci sysfs sriov_numvfs
Message-ID: <20231208111215.5a47090e.alex.williamson@redhat.com>
In-Reply-To: <20231208180157.GR2692119@nvidia.com>
References: <CGME20231207223824uscas1p27dd91f0af56cda282cd28046cc981fe9@uscas1p2.samsung.com>
	<ZXJI5+f8bUelVXqu@ubuntu>
	<20231207162148.2631fa58.alex.williamson@redhat.com>
	<20231207234810.GN2692119@nvidia.com>
	<ZXNUqoLgKLZLDluH@bgt-140510-bm01.eng.stellus.in>
	<20231208174109.GQ2692119@nvidia.com>
	<ZXNZdXgw0xwGtn4g@bgt-140510-bm01.eng.stellus.in>
	<20231208180157.GR2692119@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Dec 2023 14:01:57 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Dec 08, 2023 at 05:59:17PM +0000, Jim Harris wrote:
> > On Fri, Dec 08, 2023 at 01:41:09PM -0400, Jason Gunthorpe wrote:  
> > > On Fri, Dec 08, 2023 at 05:38:51PM +0000, Jim Harris wrote:  
> > > > On Thu, Dec 07, 2023 at 07:48:10PM -0400, Jason Gunthorpe wrote:  
> > > > > 
> > > > > The mechanism of waiting in remove for userspace is inherently flawed,
> > > > > it can never work fully correctly. :( I've hit this many times.
> > > > > 
> > > > > Upon remove VFIO should immediately remove itself and leave behind a
> > > > > non-functional file descriptor. Userspace should catch up eventually
> > > > > and see it is toast.  
> > > > 
> > > > One nice aspect of the current design is that vfio will leave the BARs
> > > > mapped until userspace releases the vfio handle. It avoids some rather
> > > > nasty hacks for handling SIGBUS errors in the fast path (i.e. writing
> > > > NVMe doorbells) where we cannot try to check for device removal on
> > > > every MMIO write. Would your proposal immediately yank the BARs, without
> > > > waiting for userspace to respond? This is mostly for my curiosity - SPDK
> > > > already has these hacks implemented, so I don't think it would be
> > > > affected by this kind of change in behavior.  
> > > 
> > > What we did in RDMA was map a dummy page to the BARs so the sigbus was
> > > avoided. But in that case RDMA knows the BAR memory is used only for
> > > doorbell write so this is a reasonable thing to do.  
> > 
> > Yeah, this is exactly what SPDK (and DPDK) does today.  
> 
> To be clear, I mean we did it in the kernel.
> 
> When the device driver is removed we zap all the VMAs and install a
> fault handler that installs the dummy page instead of SIGBUS
> 
> The application doesn't do anything, and this is how SPDK already will
> be supporting device hot unplug of the RDMA drivers.

But I think you can only do that in the kernel because you understand
the device uses those pages for doorbells and it's not a general
purpose solution, right?

Perhaps a variant driver could do something similar for NVMe devices
doorbell pages, but a device agnostic driver like vfio-pci would need
to SIGBUS on access or else we risk significant data integrity issues.
Thanks,

Alex


