Return-Path: <linux-pci+bounces-19191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F720A001DE
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 00:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4F1162890
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 23:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62661ABEC7;
	Thu,  2 Jan 2025 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCcAe/Pf"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B05149E00
	for <linux-pci@vger.kernel.org>; Thu,  2 Jan 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735861811; cv=none; b=hIrUVajCNiHttKc4oKI39i9v7p4ORLtM2BVN6IIz8nfwh0CdvybadnOYG8rM4GvTH1RTf1i9ZJPOVWHWewxpa0pfpgUQofB1GyV+BKSvacGIE3FxNYmiHRSupOFgk7IcMzpMWO3axT+gfoBfr2EIFz9vWUQ2eWvoULeYoHJqBwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735861811; c=relaxed/simple;
	bh=P3f0e0KsZC3uxVFqjTtm1/WBjQsByv+LK7vD91x80rY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+7OvjT1pSpOZxsUbvINOS8qfUncZ2/4//P0vmucQjAjkvKPLVL43iueLBKhZyp4YGdcXafbdgRjhfns7fORGxp3Gn6psXQbCZrl4Cb6450/+wqEZ7ogCcFo+iq2fIXptTFWgoIqZdHGn5KaYboKyOBWVJ4H8PoSWkT7/n2lmDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCcAe/Pf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735861808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+31JuwM03Y6EdVp3v3LgbQg7ZDKiY/lu+6/XlJPbttk=;
	b=KCcAe/PfoPWaSIVFsAXUJsR3lRT8YRsA0y4vKju122nzh8MeNe0fKNUkEeO941c+Wf5zbP
	4lvvh+Y0LKSKqe6LbgJ0xT1SRBAXk+4x963dTQRKMdOPUC5QYPkQbhQWJXcvoI+v5zBLaN
	ukC8ftGO6WIdGuUg5mn3swXwUp88r6k=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-ak22uXrjOIaDoVGfXZXjNQ-1; Thu, 02 Jan 2025 18:50:07 -0500
X-MC-Unique: ak22uXrjOIaDoVGfXZXjNQ-1
X-Mimecast-MFC-AGG-ID: ak22uXrjOIaDoVGfXZXjNQ
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a78fc19e2aso13709505ab.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Jan 2025 15:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735861807; x=1736466607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+31JuwM03Y6EdVp3v3LgbQg7ZDKiY/lu+6/XlJPbttk=;
        b=bWawQQmAYnrGwcdV+lNoA3jqho9WKWqn/vIgyuxSmFu6BBI0BmnugusAW8mJQjNrRD
         MFfopopM7asvPoHPCwlSNtMlx93peHuTlenhhAtGSdoN+7UKDh4zF7URTdrxfu3xrVYs
         4D6y3Qa4JxMCTNT63UNFKYogVDuRIS4hy8FUYk6ywx4xQYEyko8wYTEjMQIs+p5nstAy
         KBqqZ4+87FAvI0gFtkzzSCc8w/jp7TEILCKnfFsTVHi36RkH9PPsxh0JAnnGGbMGekWp
         LWiljcr2q/0Y/l4IICcLuO9mMZBs6TDtO+vhncXo+YEouHTxqgGvpPd10+ObuWn1/vlz
         OPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPVLahx7ABIKTg8ccG4efiUBRaz4+ayY2yHxiOZPwqD12rve4Uah6unl4X1Ed6cFi3UmxPHlL2SvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4xI097HpTmg6aTswjmC3pLwEXrh1RBVuAXOx63kTGuZ1Cv+Lx
	14hfpQDinoUNHVb/UjbHJGGCGVbTRWINoAiighRHoPJP2qUPoesibr6D7Y0mypyOr+8MXtTuVUK
	EMBGcv1vdZeGfRkL5ZESm1tVD+U9cnI0mp/8+5mr1zPQTFnvaULTwyuTRxg==
X-Gm-Gg: ASbGncsFzqJkDB4mmuZbRRsJHofL2cEfPzm1YA1hD/M7STnbXZfg+Ua1fHILsiU4v1K
	fXrmzRmV/9qLLU8OWFsIjqSkK2NBC/WlXm+pPuu42PD4pr8oqZWnB6YRvgsy1hVE2TRgGYVp3UY
	Eh06y+8pIrCDU5iRgqppZO41GzRWkrQ/j9A44TyPCl9rcQbRDJ+HiQJMGKXRe8rKEKQHxUGqwOf
	M9goKj/B0qHBKMvfX6WYg20xLB8YJe/v+LgN+7pl6UMfpL6a6CzyyXDQeVO
X-Received: by 2002:a05:6e02:2198:b0:3a7:bc95:bae5 with SMTP id e9e14a558f8ab-3c2d5247952mr101091335ab.5.1735861806821;
        Thu, 02 Jan 2025 15:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPdiuvD3nbQOVUd7KLLxbQIFjMW4WTn8Dgh4Oc4yWHhIFUQMePiqwfOYLyExiaxztN6ea8Zg==
X-Received: by 2002:a05:6e02:2198:b0:3a7:bc95:bae5 with SMTP id e9e14a558f8ab-3c2d5247952mr101091245ab.5.1735861806487;
        Thu, 02 Jan 2025 15:50:06 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf4f405sm7075401173.6.2025.01.02.15.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 15:50:05 -0800 (PST)
Date: Thu, 2 Jan 2025 16:50:04 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: zhangdongdong@eswincomputing.com
Cc: bhelgaas@google.com, yishaih@nvidia.com, avihaih@nvidia.com,
 yi.l.liu@intel.com, ankita@nvidia.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Remove redundant macro
Message-ID: <20250102165004.2470fbb0.alex.williamson@redhat.com>
In-Reply-To: <20241216013536.4487-1-zhangdongdong@eswincomputing.com>
References: <20241216013536.4487-1-zhangdongdong@eswincomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 09:35:36 +0800
zhangdongdong@eswincomputing.com wrote:

> From: Dongdong Zhang <zhangdongdong@eswincomputing.com>
> 
> Removed the duplicate macro `PCI_VSEC_HDR` and its related macro
> `PCI_VSEC_HDR_LEN_SHIFT` from `pci_regs.h` to avoid redundancy and
> inconsistencies. Updated VFIO PCI code to use `PCI_VNDR_HEADER` and
> `PCI_VNDR_HEADER_LEN()` for consistent naming and functionality.
> 
> These changes aim to streamline header handling while minimizing
> impact, given the niche usage of these macros in userspace.
> 
> Signed-off-by: Dongdong Zhang <zhangdongdong@eswincomputing.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 5 +++--

Acked-by: Alex Williamson <alex.williamson@redhat.com>

Let me know if this is expected to go through the vfio tree.  Given
that vfio is just collateral to a PCI change and it's touching PCI
uapi, I'm assuming it'll go through the PCI tree.  Thanks,

Alex

>  include/uapi/linux/pci_regs.h      | 3 ---
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index ea2745c1ac5e..5572fd99b921 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1389,11 +1389,12 @@ static int vfio_ext_cap_len(struct vfio_pci_core_device *vdev, u16 ecap, u16 epo
>  
>  	switch (ecap) {
>  	case PCI_EXT_CAP_ID_VNDR:
> -		ret = pci_read_config_dword(pdev, epos + PCI_VSEC_HDR, &dword);
> +		ret = pci_read_config_dword(pdev, epos + PCI_VNDR_HEADER,
> +					    &dword);
>  		if (ret)
>  			return pcibios_err_to_errno(ret);
>  
> -		return dword >> PCI_VSEC_HDR_LEN_SHIFT;
> +		return PCI_VNDR_HEADER_LEN(dword);
>  	case PCI_EXT_CAP_ID_VC:
>  	case PCI_EXT_CAP_ID_VC9:
>  	case PCI_EXT_CAP_ID_MFVC:
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 1601c7ed5fab..bcd44c7ca048 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1001,9 +1001,6 @@
>  #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
>  #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */
>  
> -#define PCI_VSEC_HDR		4	/* extended cap - vendor-specific */
> -#define  PCI_VSEC_HDR_LEN_SHIFT	20	/* shift for length field */
> -
>  /* SATA capability */
>  #define PCI_SATA_REGS		4	/* SATA REGs specifier */
>  #define  PCI_SATA_REGS_MASK	0xF	/* location - BAR#/inline */


