Return-Path: <linux-pci+bounces-39871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB248C22A8E
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 00:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6FED4EBAA8
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 23:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFF133B96C;
	Thu, 30 Oct 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veMub3IL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4C20DD48
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865811; cv=none; b=PjET34sgDZs337fSAC7TE7+0EK+c+awizJYG7o6dyIw8Y+sv815iYQRejxPXyqfASp0I5ltoNTk5cpUtvP0U/4dLB2Dp+rZ7lLkhWfD2Zc+O/ddtytyFN+tfIaPAJIp8NeEcjcy6WvC1WxGm8qDtzdxQjUqd7c5ulEtCrUSPT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865811; c=relaxed/simple;
	bh=3c8fubCSOMv120xOPHfvgzA84Hedn11zJ/B3Ut3CdEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GntA+Gvn8yNyN/XxAQQr8DRyWoRUy2sAh4r7rDg2CcST3CSrjhsNw+IDhIgNKyYrUgfQspI8SE2HCQyWs3Wq0gFiRvgLEUZfrd9Mli1CXVsWCz7/yfvgNlLgM4M87+arD5NuTkh0XXUvAMZEJl/QuQWKgbds3ZQ3R1GaHnH/DO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=veMub3IL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f67ba775aso2055628b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761865808; x=1762470608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVrBZIo4jViBqFI34xTRu6DdRHmaa8XjkF8JPCjoQvA=;
        b=veMub3IL6/IzVwVBTVxovKgfQ48ftr9Zb1gFb2xlhnmYqV7gs5wTh/Qkpgd1/MAJqp
         CinbTODC4ksv2ffWtVGxWpWRYjXJhKlaQuXYSa+VgYzFVcJMV3KSISioCzjfHjbQt6p3
         nUcb2R3dQfSMN+FzOlPIzs6w1bBknLxmJPlgp4FZhVvhe2ezsYk5fXwNZikM5Nsdkj/9
         Hss/oy10N/xNwt+RPSKw5XZ6s+JyWVuCfktuU84bx5PJBY6+scLUo7V5XqGy7s7OXZlh
         CC5xj5s96JqHbCRc4aiHVVQm4jbMXEazmypQrf8CIq9XAFZahwQKpE45ENATZYcBgHL3
         d+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761865808; x=1762470608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVrBZIo4jViBqFI34xTRu6DdRHmaa8XjkF8JPCjoQvA=;
        b=iKp4EaQg8nWNkrM9LuFsbIeI/AvFN/6NNdCeqYuVTTprVIZiJ6Xml7HK+rSGGDFKxN
         Anr00tCY7wwVQJFd4WhhjgFuFKXK1pu5kr9XBU0JR3aCDBkLVrOuxo4X5fNhplM6tGxQ
         kskkjmBnywXs/gsr+FEt26D2FT+zJKrctsDgI3nc0U8DZfMaFq+C6ZH+f/Y2IiPwK89l
         qPBwqSj2kUm4Mk5SN0+gk/RvaFi9u+AqRBwG8q67OdpvDdkmN8RgI224TzgPqBRzg9SY
         sZ3aKUaJnJWeSRkjGZjLzwm6Z+SCyF/a+0qdX9JuwHJ4Lv+U9LDcCeZyKMwGyCguMhnh
         gvQw==
X-Forwarded-Encrypted: i=1; AJvYcCXb9MhYPmIYoL6ZiN5rb5u8uLP1iF+KdsIvUpyEIcq1ogsZTptpYs7uR+koW7Vbko7NIs+5qWLSnAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAmjov+KR7RtYcPmgTfnqxxxCwY8D+9/xFrT8BNoP27uWWM2bx
	ISRFpVczwSpg6ZiXg406pWnrIA2B2v0+ZDEP9dpcvKA49b0sjIMMO1oOYG6bxh8ODA==
X-Gm-Gg: ASbGncsREaMDtH7ADdItNNO7qCVKAkjKixECSjqg1jqMqNWz+ZgM3vZ8cLXanA7+yM0
	ncJy9l7kxt6VcGj+cOaB1mTqkiDz0zs5rlrtnPGO7aO5Z5SLGZPMCDxWKzm4NpfVtgGKMIaFsAP
	k5UjVuQqeF9U67stMJIq/EX9BG8tV6R5S8w7oPSQB2vzYd61Dp2XYHAlJsaYzl0qwZsDBR4QbHt
	3S1JG6GhPeOz4Lo0pqQQ5WcEGx7+jj/SyQnJmgRImYnMsVpmaXXmrtA2SWPZQaOqA4YtZTWvLV4
	ebYFoV+mpXLrvPULyh3/kk/qUpBy12o+wfG/RBV4XJEwjv86No8+DMh8NRCFu+OhP+gCD7kr+pz
	UcN6nCvlSKDYlrPRPyW1YDiLfr01A7Llsjl1hwCciRFHN2RvrgmDumZVlaHW+cjlb+PyaoGKZLw
	VcvljcCaxve0+W4QiXAP1DJA5/lfyX7qWmrpQQ6zb+IhfnUXHOP6DJ
X-Google-Smtp-Source: AGHT+IEM9Vd0HVjov8boWovrq63avSdAuwijp306wSVuatfQyJg281aFDD9T6kwljFFF6SpZOGU8uQ==
X-Received: by 2002:a17:902:d505:b0:290:c0ed:de42 with SMTP id d9443c01a7336-2951a4dfc4fmr19563065ad.36.1761865807920;
        Thu, 30 Oct 2025 16:10:07 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699b791sm833815ad.75.2025.10.30.16.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 16:10:06 -0700 (PDT)
Date: Thu, 30 Oct 2025 23:10:02 +0000
From: David Matlack <dmatlack@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Vipin Sharma <vipinsh@google.com>, bhelgaas@google.com,
	alex.williamson@redhat.com, pasha.tatashin@soleen.com, jgg@ziepe.ca,
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org,
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com,
	parav@nvidia.com, saeedm@nvidia.com, kevin.tian@intel.com,
	jrhilke@google.com, david@redhat.com, jgowans@amazon.com,
	dwmw2@infradead.org, epetron@amazon.de, junaids@google.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 06/21] vfio/pci: Accept live update preservation
 request for VFIO cdev
Message-ID: <aQPwSltoH7rRsnV9@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-7-vipinsh@google.com>
 <20251027134430.00007e46@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027134430.00007e46@linux.microsoft.com>

On 2025-10-27 01:44 PM, Jacob Pan wrote:
> On Fri, 17 Oct 2025 17:06:58 -0700 Vipin Sharma <vipinsh@google.com> wrote:
> >  static int vfio_pci_liveupdate_retrieve(struct
> > liveupdate_file_handler *handler, u64 data, struct file **file)
> >  {
> > @@ -21,10 +28,17 @@ static int vfio_pci_liveupdate_retrieve(struct
> > liveupdate_file_handler *handler, static bool
> > vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler
> > *handler, struct file *file) {
> > -	return -EOPNOTSUPP;
> > +	struct vfio_device *device = vfio_device_from_file(file);
> > +
> > +	if (!device)
> > +		return false;
> > +
> > +	guard(mutex)(&device->dev_set->lock);
> > +	return vfio_device_cdev_opened(device);
>
> IIUC, vfio_device_cdev_opened(device) will only return true after
> vfio_df_ioctl_bind_iommufd(). Where it does:
> 	device->cdev_opened = true;
> 
> Does this imply that devices not bound to an iommufd cannot be
> preserved?

Event if being bound to an iommufd is required, it seems wrong to check
it in can_preserve(), as the device can just be unbound from the iommufd
before preserve().

I think can_preserve() just needs to check if this is a VFIO cdev file,
i.e. vfio_device_from_file() returns non-NULL.

> 
> If so, I am confused about your cover letter step #15
> > 15. It makes usual bind iommufd and attach page table calls.
> 
> Does it mean after restoration, we have to bind iommufd again?

This is still being discussed. These are the two options currently:

 - When userspace retrieves the iommufd from LUO after kexec, the kernel
   will internally restore all VFIO cdevs and bind them to the iommufd
   in a single step.

 - Userspace will retrieve the iommufd and cdevs from LUO separately,
   and then bind each cdev to the iommufd like they were before kexec.

