Return-Path: <linux-pci+bounces-29967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7E3ADDBB0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 20:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A027401DD9
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001CC2EAB78;
	Tue, 17 Jun 2025 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjnF0Fac"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2677F2EA755
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750186369; cv=none; b=KvMXc3+FwYCBMAbf3T5QattC6CFe/QV0WRmpOJhcMt5I0jumfgXDnP2FYZEGiWGoDIlEANRwqsnfP8OUsgTpd2U/x7oPf15Mgto9iSfsypxjxdh+bpiUboKAaJIUUlm7TfdH6IRgPvXEL12Q66rkwbytOsTam130XhUp81975No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750186369; c=relaxed/simple;
	bh=+toRoMC/6o3ABSZSoj6kwUB+0AHRoQQb9StmVaDTJuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKu+rEpRn/t6eYbRk3zfrBFRok6NQQ4c4i2EJs8mlkceHNncmzwtMM4FOEc1+H65XVpFNhwKOWNo3wHHozaUgqkKT3CbgBmke8AkIiHB75ILzjZXnxw12hglkuwOmBjrar8sG/jfb721FX5skkR+Lr4diRaZ+MYbwgkx70QjMmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KjnF0Fac; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750186366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7GR8b6oq+VKsS7zEblPcoLobXIu9Z0EZdf91JZ1evE=;
	b=KjnF0FacFNS3kwjlYbB5TB4KoNiQtrU+vxF2xhfJk8l5//W9iG8MdjCxuYUByZ1ag7FCGX
	7YOlu/y5HVVPlOuBiTJZeZZ2nonwP9keXGv6UX9hiaPA647Yi1LnpQH4c3k//9Y7d+THEb
	NbfGv5nmAKXiTmESxy5GD3rBjhaE10M=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-uiQvb7k_POq8sGc-DK0Dyw-1; Tue, 17 Jun 2025 14:52:44 -0400
X-MC-Unique: uiQvb7k_POq8sGc-DK0Dyw-1
X-Mimecast-MFC-AGG-ID: uiQvb7k_POq8sGc-DK0Dyw_1750186363
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86cf803792dso44669239f.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 11:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750186362; x=1750791162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7GR8b6oq+VKsS7zEblPcoLobXIu9Z0EZdf91JZ1evE=;
        b=iHNUoItuyXbjGKS61axRgAFhQhDOJEuTWWsbC8Ak48ulCuOVmIpH0Ne9ViKyZ5hqT8
         BCHHe62OCtiPz6aTsiVxBIY9CDv3K8IJxVYg66k83YeIsRwR5a3pVcVjJj+0DNtVnmtR
         H8YJBeji5SJdqES6Y0iyZLI5c2UbDSfR6XZPQgaYxYDPlbyKdDSKuD+ZSLNlqJLrYSTA
         f/syPq3Y8Iee2qqSkXX8kNYohzgGrbQjK3zNEXBl2Q3/+OkqvSd37ZhVDXQXrppKYP9/
         14RcLHnE+YLbrny9Mh6D1tZDNA8TJRVkk4N49qe5hHGaK4ABo9oRE1jIj+xGt6KKXFQS
         l0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUHcbTWPbx4SJYu000UkEB01fRIzaisFSOEsHEgLnhhr3etjOvNy3l7mfwXPfkyoHByoyW+3136op4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaRz9opEw/rvorkek2EpXdV0MTPO0ENzW+U51U2pztjt3cEeyB
	mYV/fkFAeue50s/Wac6RLHvUtATTo6IxdXcCLLfFwiMgl1dgtsIkhVCxUY55m5Q9JuXL/mdCDBk
	cfX0Vsjj6xWwQgMSX72DjsniDIartc9sUDNlrQ/rY+DFM3wt2mSdjpXWd7ZJC5g==
X-Gm-Gg: ASbGnctf9YaFqxu8A/tgwWLObDL0dJgabNXFt6Flnok5wrPsuGFd452EDWgknA8W7nV
	7gCOufZWJxpTwoRG1gkyhHjsgsm6JldLt74wqUVXZj9S6olr7+frllcn2MKOUQUxKKGLndftpEJ
	+CdJV//p3zRqnU88uIA4ReTWh3EAlF1IpSSLDj2x5K79qkvryIWXl3hXl6U4XlAEUh7T6QCNv8H
	noyxKTjTIjW02hBgcP50CzNkprzZ7FbOFA70QpLS9URKmLEAjThgn8oxulMJFZAoWJYo5ZM6Shl
	Hfa9hR940Q0jQlDB664ElzzZxA==
X-Received: by 2002:a05:6602:3414:b0:86a:24c0:8829 with SMTP id ca18e2360f4ac-87601391479mr183502139f.0.1750186362590;
        Tue, 17 Jun 2025 11:52:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKthDmryWBtQYhqN8X3vXXpFX6gedZAuw/STdWF8X1NR60JiUUJho0FZmRHCrhQiS9JYovUQ==
X-Received: by 2002:a05:6602:3414:b0:86a:24c0:8829 with SMTP id ca18e2360f4ac-87601391479mr183500639f.0.1750186362211;
        Tue, 17 Jun 2025 11:52:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875d5842a19sm225353839f.44.2025.06.17.11.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 11:52:40 -0700 (PDT)
Date: Tue, 17 Jun 2025 12:52:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list), iommu@lists.linux.dev (open
 list:INTEL IOMMU (VT-d)), linux-pci@vger.kernel.org (open list:PCI
 SUBSYSTEM), kvm@vger.kernel.org (open list:VFIO DRIVER),
 linux-sound@vger.kernel.org (open list:SOUND), Daniel Dadap
 <ddadap@nvidia.com>, Mario Limonciello <mario.limonciello@amd.com>, Bjorn
 Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 2/6] vfio/pci: Use pci_is_display()
Message-ID: <20250617125235.13017540.alex.williamson@redhat.com>
In-Reply-To: <20250617175910.1640546-3-superm1@kernel.org>
References: <20250617175910.1640546-1-superm1@kernel.org>
	<20250617175910.1640546-3-superm1@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 12:59:06 -0500
Mario Limonciello <superm1@kernel.org> wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The inline pci_is_display() helper does the same thing.  Use it.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/vfio/pci/vfio_pci_igd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_igd.c b/drivers/vfio/pci/vfio_pci_igd.c
> index ef490a4545f48..988b6919c2c31 100644
> --- a/drivers/vfio/pci/vfio_pci_igd.c
> +++ b/drivers/vfio/pci/vfio_pci_igd.c
> @@ -437,8 +437,7 @@ static int vfio_pci_igd_cfg_init(struct vfio_pci_core_device *vdev)
>  
>  bool vfio_pci_is_intel_display(struct pci_dev *pdev)
>  {
> -	return (pdev->vendor == PCI_VENDOR_ID_INTEL) &&
> -	       ((pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY);
> +	return (pdev->vendor == PCI_VENDOR_ID_INTEL) && pci_is_display(pdev);
>  }
>  
>  int vfio_pci_igd_init(struct vfio_pci_core_device *vdev)

Acked-by: Alex Williamson <alex.williamson@redhat.com>


