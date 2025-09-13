Return-Path: <linux-pci+bounces-36086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 828A8B55FBC
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 11:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208FF586A78
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 09:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A942EA74D;
	Sat, 13 Sep 2025 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiAHel96"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75412EA177
	for <linux-pci@vger.kernel.org>; Sat, 13 Sep 2025 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754389; cv=none; b=GJJ8RyQ9hH9VcdzJwy0Tw2eZE6OX4OUqNIqR7w66Ezu4msTQjd415rX4yXSex9RmIjgd9DIugZRm5o/BBuPsMQzZKALkfAuW3MMlKmMyfVGUmgwYCtBUNoed3pRbn6SP1oONQZYjVIMYAoxh6JgjvDw6MKVODdY2iRPGYK6v1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754389; c=relaxed/simple;
	bh=8dEp1AU6wmo+g+BbWCezxqlLsb7zc0IB8g7OnuHFGSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUjsn9xaZxSG8U4IPOyp1dsFyUm1nuyu13CtBYZqti3OekklW5He+Pvw640t60xa8ypJ/IqRd7kWdDlClMBYVdyA/n8yr/efwvODn3ZQk4nURCog8+IR27dCMhhbFgxtYM2oG9tsUSzmCGv1GpjM9d0cUGgmJRTFOsq1aR73Oa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiAHel96; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757754385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOsyKEsT4d7f0MxqTpsXQLTyDPQ6JiWR10VEY3czRBY=;
	b=OiAHel96hdSqvygMwcXVsT10EtcUCX9BpTXezygfuP/jBvNclpxulxObdAR4cRtSCnhfK0
	eOS8zfg4mS4hHcUwKXOXeMIDgoPV3qMpsU3qLttR/OXuilFYddzyAYRgzbuDMDkkFN7uaG
	eALZPTwooHpmZAyA1bBp835V1xmHMj4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-lO0tcqk4OseiJW1GIUxqQQ-1; Sat, 13 Sep 2025 05:06:24 -0400
X-MC-Unique: lO0tcqk4OseiJW1GIUxqQQ-1
X-Mimecast-MFC-AGG-ID: lO0tcqk4OseiJW1GIUxqQQ_1757754383
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4223e391be2so3474085ab.0
        for <linux-pci@vger.kernel.org>; Sat, 13 Sep 2025 02:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757754383; x=1758359183;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uOsyKEsT4d7f0MxqTpsXQLTyDPQ6JiWR10VEY3czRBY=;
        b=kChhXzTJD1pb8LFOHwyqDX41sysZ4QPTkbvaSl7xaTmveM7FZ1/Im+JDHhv27eufuI
         nqiTygsKBHyLQwRyEpBIrWjENutWZ++GGGv1t8KsALkqzgUeFyv3SLVwsfO4lmXJwdmS
         w2YsX0Wtz340ubXJep3SLgSZdVcZo7pLWsrBVWPrYdY1I0eojygPYdBri8BDOiq19gxh
         MX1G23D5ZVJsm6Gfr2KLCQgWrULXx47/BCBbnSwbqAyZGDI3vB8GduL1UEqQCEvTkoZ5
         2GR5jKdgVXL8jSdq5f63IYYzARi2BoCPwq94yxN3kwiwx+GX9J0cf2SiFsaXDpKb9LLk
         i/AA==
X-Forwarded-Encrypted: i=1; AJvYcCUAfOfGzSbTQIx7dVGqdoSa3t8oNIgJLifYf+fTFOKVxqOzBm38opjMVwet2FBFIQ1wqfZPZ911x3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNsf3eoDE/B+nBf1kSyN93LeySgCqtenPm52VzTxu+vJI3B4uz
	PRpWq27CJ+aCWaloQRGpsELNebeEAuDEHHd/hEV9BjjiWC7BIyoZuiYrgHNa7NNQ4MzEZ34IaEp
	R9y05osGBAwtiLmC5wzbbBdi2oCNYUHBgXtzOVa5q/CHnvOgipk3o37ypf+rhbg==
X-Gm-Gg: ASbGnct42WT1+wpb3E4pSys0vfC3TQmodLL+Go0vg5Rz/XX/IU0RQAMaU5oMW17ipYe
	qgXu7YEBXzQniHx3iwk1vMRSy2q/FQCxxDV8ZxGyrJF5ZzHVv88ru4m46XXZ/JHsensru6sDN3c
	30e0Z5rP4RrbnPkdadQXAAfK1RQ0Q+I28tawfME6K8RECsAZoDVoChoM0SazVOwxD/7qoaUisIo
	xVMJqGOMp5ZiTSbTzJI3QU55R1E4ZZTC1Z+22o0+MivyPtNvtxP0V8/4HyEjUduZMQ2sGfNQjCA
	hm7+hqemXI4VwgMQ+MLMy0BgxI/T/uUkxrDWNJi6MJY=
X-Received: by 2002:a92:ca4d:0:b0:419:de32:2d01 with SMTP id e9e14a558f8ab-420a1bf0e2amr28604235ab.4.1757754383431;
        Sat, 13 Sep 2025 02:06:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENFwGsYCj5we8cqrgqcps0vU//BTqxnSv90KfRfiVLx0DBHmLiooNtsdQvyKhq4QCqGgNKww==
X-Received: by 2002:a92:ca4d:0:b0:419:de32:2d01 with SMTP id e9e14a558f8ab-420a1bf0e2amr28604185ab.4.1757754383024;
        Sat, 13 Sep 2025 02:06:23 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-41deede6d15sm31335025ab.7.2025.09.13.02.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 02:06:21 -0700 (PDT)
Date: Sat, 13 Sep 2025 10:04:57 +0100
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 helgaas@kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v3 08/10] vfio-pci/zdev: Add a device feature for error
 information
Message-ID: <20250913100457.1af13cd7.alex.williamson@redhat.com>
In-Reply-To: <20250911183307.1910-9-alifm@linux.ibm.com>
References: <20250911183307.1910-1-alifm@linux.ibm.com>
	<20250911183307.1910-9-alifm@linux.ibm.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 11:33:05 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> For zPCI devices, we have platform specific error information. The platform
> firmware provides this error information to the operating system in an
> architecture specific mechanism. To enable recovery from userspace for
> these devices, we want to expose this error information to userspace. Add a
> new device feature to expose this information.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c |  2 ++
>  drivers/vfio/pci/vfio_pci_priv.h |  8 ++++++++
>  drivers/vfio/pci/vfio_pci_zdev.c | 34 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h        | 14 +++++++++++++
>  4 files changed, 58 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 7dcf5439dedc..378adb3226db 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1514,6 +1514,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  		return vfio_pci_core_pm_exit(device, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_PCI_VF_TOKEN:
>  		return vfio_pci_core_feature_token(device, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
> +		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index a9972eacb293..a4a7f97fdc2e 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -86,6 +86,8 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  				struct vfio_info_cap *caps);
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
>  void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +			      void __user *arg, size_t argsz);
>  #else
>  static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  					      struct vfio_info_cap *caps)
> @@ -100,6 +102,12 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  
>  static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>  {}
> +
> +static int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +				     void __user *arg, size_t argsz);
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 2be37eab9279..261954039aa9 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -141,6 +141,40 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  	return ret;
>  }
>  
> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +			      void __user *arg, size_t argsz)
> +{
> +	struct vfio_device_feature_zpci_err err;
> +	struct vfio_pci_core_device *vdev =
> +		container_of(device, struct vfio_pci_core_device, vdev);
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +	int ret;
> +	int head = 0;
> +
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> +				 sizeof(err));
> +	if (ret != 1)
> +		return ret;
> +
> +	mutex_lock(&zdev->pending_errs_lock);
> +	if (zdev->pending_errs.count) {
> +		head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
> +		err.pec = zdev->pending_errs.err[head].pec;
> +		zdev->pending_errs.head++;
> +		zdev->pending_errs.count--;
> +		err.pending_errors = zdev->pending_errs.count;
> +	}
> +	mutex_unlock(&zdev->pending_errs_lock);
> +
> +	if (copy_to_user(arg, &err, sizeof(err)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 75100bf009ba..a950c341602d 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1478,6 +1478,20 @@ struct vfio_device_feature_bus_master {
>  };
>  #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
>  
> +/**
> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
> + * userspace for vfio-pci devices on s390x. On s390x PCI error recovery involves
> + * platform firmware and notification to operating system is done by
> + * architecture specific mechanism.  Exposing this information to userspace
> + * allows userspace to take appropriate actions to handle an error on the
> + * device.
> + */
> +struct vfio_device_feature_zpci_err {
> +	__u16 pec;
> +	int pending_errors;
> +};

This should have some explicit alignment.  Thanks,

Alex

> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 11
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**


