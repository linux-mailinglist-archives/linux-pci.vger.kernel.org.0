Return-Path: <linux-pci+bounces-23755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 168D8A61450
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 15:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064EE463BCE
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 14:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517D91DD0F6;
	Fri, 14 Mar 2025 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZe/xTMI"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815FA201027
	for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964217; cv=none; b=UBwfmXzw5QQnUM3/qFETWM8b6aNa+nJR5aNjv3g2uoj7pqWvjhmSBDlWc6xUxDh1u614txv7VTvQ9c4RuRFijH8wa62O3t+9ThydBEJuHuXdh6t8dh4fnPC8gctzb6RGYfPP/7G5+xPvHILkBxeYbbTicy8Nzxg3kjvpnvBN27M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964217; c=relaxed/simple;
	bh=tZ3aq/CqtI9LEuKu/oITcS3koxM8zmb4/pga8QNlXiY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYy/Dt3WyyjS54yyw5xoQ5eJFqbSpXdxfq+UgHGe/EYfPTCNl1DKdIU9suZXATaYS+8+5uQWEUTZntHDSvzwG9ZJriOYEwAtfAoJO6ApDDxuGEciFruvvOxhbUWUVE0sU+3YSjrgm2GPzKXRB3oX5iwPHkPus1tSlUaDTJrDdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZe/xTMI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741964214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlLbRQBxXXDhyAGBx3ZpRwbhQHfFzpByYsCXiv2nj+A=;
	b=LZe/xTMINsGGCPBmoJeAEqvma1IcVtcsXxIcUoi+r2AnxyUYYc/D447y7ey3MzqoOyUrnB
	08kCrL8CFWkFatmYpC6l93Ow9D6VSwIhpK97c2wTwoermyADbSO6tghRo67lidx6lL4Qv4
	iwAFSWHIAaUKJi9xDYETly77+aG8SNw=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-7P4e3ChpO1W2obd-gYZsZg-1; Fri, 14 Mar 2025 10:56:53 -0400
X-MC-Unique: 7P4e3ChpO1W2obd-gYZsZg-1
X-Mimecast-MFC-AGG-ID: 7P4e3ChpO1W2obd-gYZsZg_1741964212
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8560646c7c2so30278339f.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 07:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741964212; x=1742569012;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PlLbRQBxXXDhyAGBx3ZpRwbhQHfFzpByYsCXiv2nj+A=;
        b=cvsiRiG6dkrffPs3xRoHDoOmTg6RMXGoq7+3MzZ24XIgwGE7iZioOHyTdtyncQdv4u
         G3gmTay8Et+LX6iOUDc41uPOL/BxXpNa41NmuBN+rE3mJ9MgYKnZvmQzayf1fKCwMMY7
         zYx/gCtzPbiStD082EaJyhDh60kuzwryRvZt9MOYnCslNqmKHy+GwajNVyGtAExK5QSE
         F1Zgg/u2l/CnFfkIo5/Unk1giqM6D+wbVIAOmuEvXRNJ5ZFrAWbfGvfuOcatHVTu+zDX
         9i/foaxFZkzjWFpaw/EAiagF199pfPbrj55E7bJDy1GEddjx+3ZwY9hiTbigwd7vn0wE
         Im+g==
X-Forwarded-Encrypted: i=1; AJvYcCVnPkT9bxmCzaA06PXEX9TPzPolnhnzPIYGCTUVVgmAQKkX9GGO+VWlOvYEHcDdtXj8HLBaYgbz9Es=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9btM9mBK9qL2yLss1peqY4aMkOvnjpYRtR0wypyjOhZlj7b2h
	MtO6x77+FXwvz/M1l5G83nF0zI+UFaU80D4PWe+/UKg39ja6xle/S4J1sP1ekcsNqaZ0s4VkfNt
	vlJ6JTawSPpndayV1/mquvvzFEN6X8zVUmIjpCgwX0x6AlWGhrhh1wkqawA==
X-Gm-Gg: ASbGncu8pFRk4SyzcHKvKmOLzMaT2FuYiQoKIYImeX9scGf1jIe7a7fK9kC1M1M25lb
	jF9YbsO9chtasCxKs/w/UljjUqqmlgRlNiXuSItlp48O8fRWYp7ayP25aToUKxzNvMRMKwo4xOD
	zMLWYPW8XDB7t6kvIX0SlPLG8tnraYustE5EfLgrVwD9yF68ax4lOLSqRMG2HSJRPtApyKlcEw4
	wyaxoSpnzq/5rHppeX1Z1m9d9IugckH2h9hbK0aKMpceeS8jKxxvqOvKbJoBSI13BwNvBCiOjqQ
	aX+DTg2YH2lr1tPoPj8=
X-Received: by 2002:a05:6e02:3188:b0:3d1:9236:ca49 with SMTP id e9e14a558f8ab-3d483985596mr7894095ab.0.1741964212438;
        Fri, 14 Mar 2025 07:56:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0TnXNtM95cSC0zsNjgkP0enen7RRVJxKsA6Xlp8a+oLFTIu0ca2olQqG/k7wlr6lKNf2GyA==
X-Received: by 2002:a05:6e02:3188:b0:3d1:9236:ca49 with SMTP id e9e14a558f8ab-3d483985596mr7893995ab.0.1741964212116;
        Fri, 14 Mar 2025 07:56:52 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263816d80sm877731173.124.2025.03.14.07.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:56:51 -0700 (PDT)
Date: Fri, 14 Mar 2025 08:56:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?TWljaGHFgg==?= Winiarski
 <michal.winiarski@intel.com>
Subject: Re: [PATCH v2 1/1] PCI: Fix BAR resizing when VF BARs are assigned
Message-ID: <20250314085649.4aefc1b5.alex.williamson@redhat.com>
In-Reply-To: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com>
References: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  7 Mar 2025 16:03:49 +0200
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
> As __resource_resize_store() checks first that no driver is bound to
> the PCI device before resizing is allowed, SR-IOV cannot be enabled
> during resize so it is safe to release also the IOV resources.

Is this true?  pci-pf-stub doesn't teardown SR-IOV on release, which I
understand is done intentionally.  Thanks,

Alex
=20
> Fixes: 91fa127794ac ("PCI: Expose PCIe Resizable BAR support via sysfs")
> Reported-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>=20
> v2:
> - Removed language about expansion ROMs
>=20
>  drivers/pci/pci-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index b46ce1a2c554..0c16751bab40 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
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


