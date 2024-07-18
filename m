Return-Path: <linux-pci+bounces-10529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47018935122
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 19:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2D12817A4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4181442FF;
	Thu, 18 Jul 2024 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mr1kQlb6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C3E13DBA2;
	Thu, 18 Jul 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322825; cv=none; b=BPSRPVfvqc/Wq9XhJmwk8g71qDkaWCYjlM8eHweEbgvttPjvoiJpxkQIbljQxkOgBE6a6ZvvbV6y028mRJ8nbLjG6N7PNk8unyGm2CoFraRCCtcrEIs2JIz+COri5di/tVH4v9shkx478ipWw4yi1zioM5L++X8NIef9hIYWwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322825; c=relaxed/simple;
	bh=U6vghfZXsKDNxxoo5h7FLigqzlJKZg2VsEsKvxx/DPY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pPnDH4UiyGNZR5xgqJ6+gUibJ8rPAaVxqv5PZNyAEo/3CZfP4et9sQZ1p0JZF9rLiK9fv4z519o95zmbzxDv2T9ZN0Nv8yprAs7RhzKG2zrY7158KHWRC1nX0zgCk3IlhrZ16yhdZy/weMyS0s0AcZb/n6ftgBDws277vU3G9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mr1kQlb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AC0C4AF11;
	Thu, 18 Jul 2024 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721322824;
	bh=U6vghfZXsKDNxxoo5h7FLigqzlJKZg2VsEsKvxx/DPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mr1kQlb6cKa6LRKRFqYdj4F7qJdGamMhx3hAYCJU1cOfBZ+k17UZiesiCmfVLSS2t
	 lIAoasQi+5dbGkq2RhRAUKHAseAZNyCPKeB50SmlP435r0IKUu8OQxwQ7vLEh4GCuX
	 wPi6stjWzTQg5AeZ2jzuk9Hqfz4+OGHWcPoGTNHnvLwhj4v54oO4K9BP43Kc2oDszB
	 jh3IfwQIuoOtSGvlBCZo6/HFmntGA3WW2FoE9QUuVwUSMF4FT2Bf9LPkm9cwuY5Gcc
	 +rgF5kl+hU3CkO6edfmIapfc7rXrP5IiFVv7K9MN5UDaTPXq6DjJvZDGjZ3bG2ZbwU
	 m5lHyzdUExS6A==
Date: Thu, 18 Jul 2024 12:13:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Anvin <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Avadhut Naik <Avadhut.Naik@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v1] x86/amd_nb: Add new PCI IDs for AMD family 0x1a model
 60h
Message-ID: <20240718171342.GA575689@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718140258.3425851-1-Shyam-sundar.S-k@amd.com>

On Thu, Jul 18, 2024 at 07:32:58PM +0530, Shyam Sundar S K wrote:
> Add the new PCI Device IDs to the root IDs and misc ids list to support
> new generation of AMD 1Ah family 60h Models of processors.
> 
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
> (As the amd_nb functions are used by PMC and PMF drivers, without these IDs
> being present AMD PMF/PMC probe shall fail.)

Is there any plan for making this generic so a kernel update is not
needed?  Obviously the *functionality* is not changed by this patch,
so having to add a device ID for every new processor just makes work
for distros and users.

>  arch/x86/kernel/amd_nb.c | 3 +++
>  include/linux/pci_ids.h  | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 059e5c16af05..61eadde08511 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -26,6 +26,7 @@
>  #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
>  #define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
>  #define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
> +#define PCI_DEVICE_ID_AMD_1AH_M60H_ROOT		0x1122
>  #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
>  #define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
>  
> @@ -63,6 +64,7 @@ static const struct pci_device_id amd_root_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_ROOT) },
>  	{}
> @@ -95,6 +97,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 76a8f2d6bd64..bbe8f3dfa813 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -580,6 +580,7 @@
>  #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
>  #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
>  #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
> +#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b

Why not add this in amd_nb.c, as you did for
PCI_DEVICE_ID_AMD_1AH_M60H_ROOT?  There's already a
PCI_DEVICE_ID_AMD_CNB17H_F4 definition there.  No need to update
pci_ids.h unless PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 is used in more than
one place.

Based on previous history, I suppose PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3
will someday be used by k10temp.c?  Ideally a pci_ids.h addition would
be in the same patch that adds uses in both amd_nb.c and k10temp.c so
it's clear that the new definition is used in two places.

>  #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
>  #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
>  #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
> -- 
> 2.25.1
> 

