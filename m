Return-Path: <linux-pci+bounces-36524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90452B8A9C8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36B517043D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B65262FFC;
	Fri, 19 Sep 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuDc0AtF"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF710A927
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300091; cv=none; b=XfjYJ1Y/XcwqsVUIHPyMno2wradob6FCex3uQQkhXaKUU7p2oHm3RqjyUkqUz/by9R+5Ccwk2t/j0pTrKNQ3uON20dPoneJtsdpgYvwCbwJmXkW3icOuJbscgnSdy9hQA2ks6dFdcI7FPPxbv5IKvR2dG/NEk5HX77OKEDP2Xv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300091; c=relaxed/simple;
	bh=rVG1xQvibf3lEN+xk9PEqhHrOBOZ5Fo6RcfcMfTCyW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4MdB3Oq6aSOOhupedRMKfLR5woj0yNIbX6jvlAm6DYGMgo+WyxUIKGBOsDrnKSUHLOu/zm65QTu3rBmg5TllENFj6BNTlKFcSJu/OB+QOwrtrS/Yl8wKmBH+85drpyMwuYCUB0W6zFF1W+O1e9oHuQgnoo0TeGK3eZkPcs0QNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BuDc0AtF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758300088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMnr0JjqCxt7L18nxDYBEj0PJo2Ui1h2PBmCBdsosf8=;
	b=BuDc0AtFp7r82FFlO8KIoi03Z4nOhwUecS2bDworll8OOY7wGtO+KDTOUHvsOhJVSKrlXx
	sF75Nwl6p/xh3MJLFeT0whqagyNzwCE2oGpcwjIIgH94taO7SJqvKvSyYyAkgY0n2BQzK9
	LR6E9j8c7jvFbVCHHfQw9FT3ZNZe8fo=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-oTX04VjOOY25I_12YaQR6w-1; Fri, 19 Sep 2025 12:41:27 -0400
X-MC-Unique: oTX04VjOOY25I_12YaQR6w-1
X-Mimecast-MFC-AGG-ID: oTX04VjOOY25I_12YaQR6w_1758300087
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-41179d41311so3708565ab.2
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 09:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758300086; x=1758904886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMnr0JjqCxt7L18nxDYBEj0PJo2Ui1h2PBmCBdsosf8=;
        b=ZejShrP+Vc6q+2ZXuBdhrwz3FAL+9V4FWYEMfouedpiLsZE/B5/1bHPBtuJrIF/Q7I
         bvXYOeJpjYsHRz9oIA/EGy8Ss3ZxhBiiZ4AMo1Xn0uaWEA/PlDRPVSpZ8Z6r8a0LzBA4
         8Z/vPA7S07dW+zMYEjf17dBFYr3Lu+X1eDDDHylGcilkcdJimt4Gd+LAHFxHjZmE3QHu
         RnCV7YBJHhsoeDkv3QzA9mnybe8X7HD/owam12ZPQR86kyDFtlm5jYabyKAqlKg84ata
         eGJYf8ZB7dux+l20lbEpGE15YmzFMLB9JU+Wus1x14yHJbUjFkA1MdSJS0cHFOKEN+4S
         L3fw==
X-Forwarded-Encrypted: i=1; AJvYcCUJywn7+mzKhUUuaOOV1uu/MXiiynGO4XOaQ7UOdtzkCZNUTD74/AfvN/XOhVJKEu/rXk/Ijm9f9UM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5cWhniB8boP9Te5bilhENS29/8aUKEaXnr8uB++iGTHhAW2sg
	vhrpx0XoytibP1ysyV7M8UKRY7sTLBGUgVMezKPRQANYbYGtzUvqvTIQKKgSgriPZOULmgEdukY
	WOiFGhOLajhiqM6Na5+M8a99UlKaFBh1DxhpD/Ka5r4s0WnyHMItklSFolqi3s94F4/7DaQ==
X-Gm-Gg: ASbGncvVZF4nUUR0I9YksgryTF0gyVUK7qpIGxhXjYMektjmqi4ThGM0gVnLs37CctZ
	eK1431pTy/sc4vSYzJ4f5CCZ1F9OFwAWZ5YbtWwGvyQjd3TeuUDJIAJJ/nNRbnALn8SjIDqr+aX
	ZKcmC+nmsRNI6lD1eGNnewz8Ai8KUzdgSglIGMTRAqr5C/D9JTr3+NGnKHO4IxE4IHwH8e8iGxK
	uFWqTkH4X+4gCJNOVQe8e3H7/KeFeySeVj974WI3RZBCg87rD5HYHug7imN/G5e+HZdtia7LmY6
	UvyYYQDeznE2/YpqYX8/+iNMKiGJCJq16S6pC9sNVcA=
X-Received: by 2002:a05:6e02:3a04:b0:424:1774:6908 with SMTP id e9e14a558f8ab-42481893889mr23313525ab.0.1758300086026;
        Fri, 19 Sep 2025 09:41:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEkGTze3pso8N67snGJkgIyPitGSBbhChUaN8MICDAEcvJ0w7oy/daTxW1tBJu43MkybRhvg==
X-Received: by 2002:a05:6e02:3a04:b0:424:1774:6908 with SMTP id e9e14a558f8ab-42481893889mr23313395ab.0.1758300085571;
        Fri, 19 Sep 2025 09:41:25 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244b2bafcfsm23752025ab.47.2025.09.19.09.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:41:24 -0700 (PDT)
Date: Fri, 19 Sep 2025 10:41:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ajay Garg <ajaygargnsit@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How are iommu-mappings set up in guest-OS for
 dma_alloc_coherent
Message-ID: <20250919104123.7c6ba069.alex.williamson@redhat.com>
In-Reply-To: <CAHP4M8W+uMHkzcx-fHJ0NxYf4hrkdFBQTGWwax5wHLa0Qf37Nw@mail.gmail.com>
References: <CAHP4M8W+uMHkzcx-fHJ0NxYf4hrkdFBQTGWwax5wHLa0Qf37Nw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 23:24:19 +0530
Ajay Garg <ajaygargnsit@gmail.com> wrote:

> Hi everyone.
> 
> Let's say we have a following setup :
> 
> i)
> x86_64 host-os, booted up with iommu enabled and pass-through mode.
> 
> ii)
> x86_64 guest-os, booted up using vfio+qemu+kvm and a pci-device attached to it.
> 
> iii)
> A guest-os-device-driver calls "dma_alloc_coherent", after which the
> returned dma-address / iova is programmed to the pci-device's
> mmio-register.
> 
> 
> In the above case, how are the IOMMU mappings set up during the
> guest-os-device-driver's "dma_alloc_coherent" call?
> Does :
> 
> a)
> The VMM / KVM intercept the "dma_alloc_coherent" call, and use the
> host-iommu to set up things?
> 
> OR
> 
> b)
> There is no interception from VMM / KVM, but rather the guest-OS
> itself has a view of the IOMMU (through the regular ACPI tables
> populated during guest boot up)?
> 
> OR
> 
> c)
> Anything else under the hood?
> 
> 
> Will be grateful for clearing the haze.


Depends on details not revealed about the VM configuration.

If the VM is configured without a vIOMMU or the vIOMMU is inactive in
the guest, all of the guest physical memory is pinned and mapped
through the physical IOMMU when the guest is started.  Nothing happens
regarding the IOMMU when a coherent mapping is created in the guest,
it's already setup.

If there is an active vIOMMU in the VM, then the guest act of
programming the IOMMU results in mappings through to the host IOMMU.
This is a result of the IOMMU emulation in the VM.  Thanks,

Alex


