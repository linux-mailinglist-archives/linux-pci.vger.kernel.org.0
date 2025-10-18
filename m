Return-Path: <linux-pci+bounces-38585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE4FBED1D6
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 17:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C7CD34CE23
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8B4288C2B;
	Sat, 18 Oct 2025 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OkqYqVGK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB55E4317D
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760799599; cv=none; b=TRFSe9WdQ8GTOE4g3FqdDceLrx2npmHk8GrzAaHjaBYzI56PqJRwY/QJt9pkspnQnLm8vDtDlkWuHioi8eWiu3dakUp0ee0AP0myuM7onvQQRUmuHrEnAKjUk+v9lDvhfge1dkvs3zz9JcWaOgrA0hmg7wWcYIVfsJIByE0lwD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760799599; c=relaxed/simple;
	bh=RxRGGS34lOYtj1tSF3o9XGto7oo+cPrOhIqsrmS/Bwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPYLq8/t+feMlcUaoX23AAIJw95KZxcOpEJew4vFSaqRUDRGVkqpVA26k9rETGfeP9h02hB5rQl82d1LwuEwr8phlTAfypUdJm9841Nkxv3bGhDwaSxixGxDy08+4r9N2LJGDAxQLKL4YbaIsPTqhGY6c8TAG+ugoNSTUIyX828=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OkqYqVGK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290da96b37fso102105ad.1
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 07:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760799597; x=1761404397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SjKrzbC5Tx+d+FYfgi0Q+xGdmlz3Y5FBshE2AUsLRs=;
        b=OkqYqVGKYHwDdEwQJBt2VkDH5MaQIyGq3FtXkW08/OwuvvPJDWPWk5TwDvn7M3Aqtr
         IZQtMOCZ+F83AY4oBm0UOIBTTHJzCPB8/acfwSYbzppaujUrw5395lpEhzFcQaKGlqVq
         w+yOpAZYLzOE3iBSiZpzQuCDCbhyG3W6byh99Mf5XmLp7XhnP4sZgxu3o3px6Y6YvByz
         7i5rnuI5e4GHQ0wvyLh+d090sdS4MIwW+nTheFVi0jCE2xYE+0romD5W31sYPFBE+R/0
         1qyvW86n5PUnYpJIVkPwOqU/JyVV6f3r8480bWL7qqc/+QrhM5MvKzR5E6HtKrdIXQS2
         Q52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760799597; x=1761404397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SjKrzbC5Tx+d+FYfgi0Q+xGdmlz3Y5FBshE2AUsLRs=;
        b=Piujqj/nzE2F8HfUeuQpgznb2DiSWJFkhjz5XwZMiKNtIe3l2GngAIhskDjl9ZWLC1
         5Vk8EsfEwZLm2TFR8f3ImfppNrqD/ZW4ggmuPhAjFvsucx47K0KPpneei89nseYwUUpa
         OAn7s/f+BifL3VQbWlwx9n4e1ho6V/HFpWHi5NQyAvyPlwL/Ej+jp2KwMD0CbiycBu88
         kU0aZUJyZeFGNEIfYV7DzLP8sW4CJSvIUlQ3cuqRHx8COnK9+EYV5nZKVJ31GjzuVaAJ
         dio9tirZ1TktR4s6rFfCSr99tFOu6omGJnE9ze6Ri0DSjVbuet9vuItO6KbxLMYxWY3W
         VHBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIef2Eo2qKzZ8FswjSnYipBY+QOkEvTZQ+pQh8mJR7hud+LlWzqmHj9TDfEYcPlKpLT0/LTv6Z8Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze6OiBu7lLfArRx8ufs7S+zUbhMqUZlhW1ICOfHd0/AOb/U+ga
	ll0PUrIp4ADmfVjprzo31mipapxD47lFi8DUXFRsu9zxVEjzeUhi/CryntxulwyMoQ==
X-Gm-Gg: ASbGnctVcJKF+GDcrIJDp27cGNtOdIv8L6+JRBd6M+lDDHXuDS9xex+HpCK9qSG8JjH
	k19+DJ5Oy2JWDedL5kY5I7eLx+El7yhRP7e8pTe+O9597fRIfo3b1zuafram1audvC+ZEm1hHoU
	/C5CiFyp0q+EG4HvTz64MA6XulchLR+vlU/7TQEvXwtLaKBgD9ttCjqx86t299DTujHqeC5HNRB
	EEa9mjPzklEbsuM+eZOf/26ZrnV+yeN2G0niNmb8SgP0ERN+axVc5TmwGo/KU/d2z/EtNP9yTjd
	QkPH0LFkq0lYMfLMNo+XshH7R2LrDAcLfei9ntK8ymqsvbgb9MqPJSWaTwVJnu8fxsqqtmp14XM
	SScBYnMPPZFELBNinZip6+BZaCdgSDanBN7caiuR3w7VSL9qQpzMFawiN9QJ1M9gQOo/+U5YCwi
	8B8+EXvg5LPj/i1FXnoO3k/cOf+Y4qgF4CyQ==
X-Google-Smtp-Source: AGHT+IEO4meUUEecoQCQ1m49ew5u3IzhZQhIoa/TkD8EI1gJuwGpLMOCNbvdEHLSvt4FD9IHI/8J/w==
X-Received: by 2002:a17:903:2284:b0:26e:ac44:3b44 with SMTP id d9443c01a7336-290879ecc6bmr22769125ad.10.1760799596925;
        Sat, 18 Oct 2025 07:59:56 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010d818sm2994154b3a.53.2025.10.18.07.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:59:56 -0700 (PDT)
Date: Sat, 18 Oct 2025 07:59:51 -0700
From: Vipin Sharma <vipinsh@google.com>
To: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, dmatlack@google.com, jgg@ziepe.ca,
	graf@amazon.com
Cc: pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 13/21] vfio/pci: Preserve VFIO PCI config space
 through live update
Message-ID: <20251018145951.GA1034710.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-14-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018000713.677779-14-vipinsh@google.com>

On 2025-10-17 17:07:05, Vipin Sharma wrote:
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -109,8 +109,13 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>  
>  #ifdef CONFIG_LIVEUPDATE
>  void vfio_pci_liveupdate_init(void);
> +int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev);
>  #else
>  static inline void vfio_pci_liveupdate_init(void) { }
> +int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev)

This should be static inline

> +{
> +	return -EINVAL;
> +}
>  #endif /* CONFIG_LIVEUPDATE */
>  
>  #endif
> -- 
> 2.51.0.858.gf9c4a03a3a-goog
> 

