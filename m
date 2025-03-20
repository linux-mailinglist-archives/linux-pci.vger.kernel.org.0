Return-Path: <linux-pci+bounces-24239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B73A6A970
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 16:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F833B6886
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 15:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746361E47A5;
	Thu, 20 Mar 2025 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqhnBccL"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34D1E231E
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483447; cv=none; b=S5jAshWCb8J8KbXbgTXodVHNzORxZjGPJRx1BpT0RTxW2sP3P5xZJF+7N4pWsH3QtvPEtCI2hHYmiDW61G+cGvBrfg/4egiOZjEm+y3eUpoWcdc+vBqBAe6FvkxO7tlWAQoQVk4e8VYVQ7cMTa+eIz4fJd8Kh9w9vr5A7U8qqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483447; c=relaxed/simple;
	bh=wPzCW++mf4BmPY5ZUsq+1T2Ca14nuU9d4Jf4myQk9qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqKI+EWzWU6M9NPLPpmLZrnoHML7OrmgTJbAniAIRr4Q2HzWvK/NmxKoMOzHgwtewuHe9SZ2tFNOHk8cfLw+aTBohK5YqIzTfZXkeyZj9imUZ7Cwng9O4ybbhjok/htHJoyQhGEsdXaIGZ9qUcAPwib9bVLyckrfB6U62xV9OuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqhnBccL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742483444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9pdXhnbmPzOM0AIBWql2puAsWwJXN4dUsFoBkqLS8U=;
	b=UqhnBccLtMHGVgjigIf16ZMjz1eK5+LSICLJJjLvlPBVRVoqqA4YVIiTKlvNhzTNkHSy1R
	99u3xqLGfVxmsfHZ+OlfuWvx4618LYp5CYgUVwhx3YWjqSml5kFNZDwJOjlmRITPawcy/W
	J7fBctl5+1xS6Jbp9Olb2sqIkURoojM=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-73R7Y6tFON2GjMcU8229UA-1; Thu, 20 Mar 2025 11:10:43 -0400
X-MC-Unique: 73R7Y6tFON2GjMcU8229UA-1
X-Mimecast-MFC-AGG-ID: 73R7Y6tFON2GjMcU8229UA_1742483442
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d48e11525fso976115ab.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742483442; x=1743088242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9pdXhnbmPzOM0AIBWql2puAsWwJXN4dUsFoBkqLS8U=;
        b=Jxg2IekX3jfr9NZXd4iQg7zKoVEfWCYRBGxePcWIRPXF9poI+7F4IBzh0Ty7I/5Qyb
         6SzVc74AOaLwscP35AJCdAKA7lS8lB3cOA/NL1bK+Gh7YeT12MnZ76Xm5Tvk0Jjmj/fQ
         rj//etAu8xQZFUr1FJnfA6XDAVjJIrkD/iBIZ2t+OgxNa1kBEAMRHlk+E/PazKIcxcwj
         zUUCP7+2hp9ukwOER8Mp3JzJedWwvGd9JTrgP7GbmUY2qWkDH3L7bBhnLT7aEbBmle15
         wsiyGJYmzyFeNeageEGovXTJEsmWxMyUJDIYpQiygCTJsD2bu9QOicHxOXKWj+z9PX8M
         X5nA==
X-Forwarded-Encrypted: i=1; AJvYcCUpLjhTz3ECa53bvefMSL/x+w6X/jJpx5UwTXgukQQCj8b+6yRr08BKOhCiy8Q/b1+jPMTJh2D4+s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6buSEjL8QxVlmFwtfGRJe6ebuPW97vsxGAKTmss+wcWZPhVj
	pq5AUS0NXEcBTKHVMYjWK8w9mKj+r8D/hquKPS9P329uXUnuBTaZqQbe649hIWYk0Zekg04zEqS
	fFtnBcVOTAWqaanaHmkffJqWeMk/jhhRUviailF9p7BZ5zXelzMWCgyZ8LA==
X-Gm-Gg: ASbGncvcaHA4nNM1XV3SVM518l0Yk+ZVvj0lf6+VswZ5TyjTE8GEVkpTEzkMN5+Ov+s
	SfMhfU50V0hK+4DL3Y8QIgazrcc5x68llhl4Idsld8Wk9Vt+rsQcxgw0c5RkGR3KIY8FUZTgPu/
	SdnN5ctqLOW6t6I3XTQT5K2vTuUk4i4VcxvmSnBg4s80TxoF/JPmvTPZmT2T58PWX7jH/AUN5oK
	SBY7c5Ign813IDxgOtQWpbakiA0jmqajY91RKPK8Jts53Z7E3bPeu0A9m65ajE5LGy2AFCTebkz
	u7HXmfaMs6o+CSIKUuc=
X-Received: by 2002:a05:6602:3fcf:b0:85a:e406:5836 with SMTP id ca18e2360f4ac-85e13a1a699mr239604239f.5.1742483442462;
        Thu, 20 Mar 2025 08:10:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEudBv7Mx9Yq9q7Bszz6bRWBRPdReFNojD+/x4jBOY4Ws/hoEASf13aNS02c75grP2Hs+mc4Q==
X-Received: by 2002:a05:6602:3fcf:b0:85a:e406:5836 with SMTP id ca18e2360f4ac-85e13a1a699mr239601539f.5.1742483442071;
        Thu, 20 Mar 2025 08:10:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85db8777e19sm348840239f.16.2025.03.20.08.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:10:40 -0700 (PDT)
Date: Thu, 20 Mar 2025 09:10:38 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?TWljaGHFgg==?= Winiarski
 <michal.winiarski@intel.com>
Subject: Re: [PATCH v3 1/1] PCI: Fix BAR resizing when VF BARs are assigned
Message-ID: <20250320091038.219fe7d1.alex.williamson@redhat.com>
In-Reply-To: <20250320142837.8027-1-ilpo.jarvinen@linux.intel.com>
References: <20250320142837.8027-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Mar 2025 16:28:37 +0200
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> __resource_resize_store() attempts to release all resources of the
> device before attempting the resize. The loop, however, only covers
> standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs that are
> assigned, pci_reassign_bridge_resources() finds the bridge window still
> has some assigned child resources and returns -NOENT which makes
> pci_resize_resource() to detect an error and abort the resize.
>=20
> Change the release loop to cover all resources up to VF BARs which
> allows the resize operation to release the bridge windows and attempt
> to assigned them again with the different size.
>=20
> If SR-IOV is enabled, disallow resize as it requires releasing also IOV
> resources.
>=20
> Fixes: 91fa127794ac ("PCI: Expose PCIe Resizable BAR support via sysfs")
> Reported-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>=20
> v3:
> - Check that SR-IOV is not enabled before resizing
>=20
> v2:
> - Removed language about expansion ROMs
>=20
>  drivers/pci/pci-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index b46ce1a2c554..0e7eb2a42d88 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1556,7 +1556,7 @@ static ssize_t __resource_resize_store(struct devic=
e *dev, int n,
>  		return -EINVAL;
> =20
>  	device_lock(dev);
> -	if (dev->driver) {
> +	if (dev->driver || pci_num_vf(pdev)) {
>  		ret =3D -EBUSY;
>  		goto unlock;
>  	}
> @@ -1578,7 +1578,7 @@ static ssize_t __resource_resize_store(struct devic=
e *dev, int n,
> =20
>  	pci_remove_resource_files(pdev);
> =20
> -	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> +	for (i =3D 0; i < PCI_BRIDGE_RESOURCES; i++) {
>  		if (pci_resource_len(pdev, i) &&
>  		    pci_resource_flags(pdev, i) =3D=3D flags)
>  			pci_release_resource(pdev, i);
>=20
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


