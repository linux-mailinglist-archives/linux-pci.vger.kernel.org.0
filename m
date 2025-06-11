Return-Path: <linux-pci+bounces-29499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED31AD6349
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 00:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1FD188323C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 22:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6122E2F01;
	Wed, 11 Jun 2025 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBB/rgfh"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C72D660E
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682077; cv=none; b=Ozk1odXTYJG32+CVEDdP8rod82LOa/brsLp+0vWGnEWL3AVnVmc7Q8sXpHYRD1xtWqNcPaA6Zx8yH/Z/YV+1nKt79HClpafSfiLhpzbjz1grnwDB3XGw6SYfPU47OKEyZhzlWPCPOXtYDvX/Vv7LozIs/Jj67cacok2vKo5pBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682077; c=relaxed/simple;
	bh=sIpzRkdTxsbHJgrut6pwJ6tRTox9gduNk6XpJW9lr4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cD7gRLE+h9f7cqxkiVxKGz63vffcNPcFa6GrieR4mIw8+dyCXHSl4V0GHLeRB608RwJAEh1ldSHjtyEcdptVJTk3/XXuasAF/6YwoBwJm/Tbuwm1Xk1eR5jbahGDZucf8/TD4fiIsus/mO2QWeDX7JkIM2Ncm1Vq2Ab1QRB9IM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBB/rgfh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749682074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBt/kG3nbyh/rysySP4pwHeZzwQNZPCiCCde+Rjc0O4=;
	b=QBB/rgfhrXbqflvb//VpaZFBhxSvZAhCc7A8cMpq253Um83PfbGhFdqj/JQTKASQGFV2NC
	FX9k9kNbA2NUsY1dWgRBxK3rjW3balPAcKOYyzY6I0iD2htVOuTI9N47yb3gXbzFInJxxt
	objsU0l0rOl7SWTmw/BMsGVwtQHjq28=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-PNrBIbN9PzSDQfeRn1f88Q-1; Wed, 11 Jun 2025 18:47:53 -0400
X-MC-Unique: PNrBIbN9PzSDQfeRn1f88Q-1
X-Mimecast-MFC-AGG-ID: PNrBIbN9PzSDQfeRn1f88Q_1749682072
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86cab5d8ccaso8788139f.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 15:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682072; x=1750286872;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBt/kG3nbyh/rysySP4pwHeZzwQNZPCiCCde+Rjc0O4=;
        b=nzwejs2AdSzPKt09HiuVDX7N1BG/psHd+b5Kbcsru/lSdkYpU0h6JpwxsXlmD8wmgG
         oCyVFm3XBLo+8X/AP/g16B/ofr0Gex3OjS0c+ahEK9VVC86VEJpgR9/iwd1tufWaUa2b
         f0SmFIa3rc0TWj2Twu1NqRxldK1uZruiggaufkpWR6zXybbTZfpc2dRN54qq1x6Q6MXm
         TR4vXz2Ch10VjlDivTJRLMN/bjsHp5bCDJ8xjil0JT9Q6pfNRghy79/eC1jhXAEJzjTX
         3IaMt/tRUWq+iN8sjeB+Wp8cHRpZWaA40IUVIM8rYB44eDQoWsUxOrwp4r8bbcJWEVLx
         4Ubg==
X-Forwarded-Encrypted: i=1; AJvYcCW4vA5doTJE4p0wyOYVLrlhMsjEAcRtbY8l2gPTId682uFWvHBlAAk2lhdp99FOJ81QxdN3E4pCMtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw45zLLEla2qhHY/3fiT2kJ31htectyh7yNwYH4Su3PyJ8drVgP
	5X4h2SFuRz+T7rvTKwzBHr9zwM0PXhsyAemFhy6FeHGj+CS/6oRkmDSI+GayAirsdqtRUoAfEEw
	8MxwH1dvXp6p+4Hv6+Xhq/IakSgK3gGQJIxUPfrHmWtDQE7nmbaFItcOVYv0SVA==
X-Gm-Gg: ASbGncvVYqw+PlQ8bkiMAOOhN/1n/zsIT4+KFtvt1hKXkS9K3wgakz51883KzQBo8xq
	cfs2zUG2nXKHkB6msKmW8JL6c9TBH3i5esi0JQDqNrZLAqNm53Z0R+pXijQ4Od7/gvYvoB2vx/L
	vm6xvSc5bIKT8Y0TqcWfq81fz2xBxE2hidiozmIKPKhv4LKtRiBgjbUX1zkC2aDVwmu+tpVUUcO
	6mvy5WhRvs4QRobdOQjoqTKttDalD02TPIGGy3Cpef8buc4LiJa96nzmOeVIWkAsmVk/RLOisai
	sn1g/ASLUTSUCRIVr4io4f5nmw==
X-Received: by 2002:a05:6e02:190a:b0:3dd:b7da:5254 with SMTP id e9e14a558f8ab-3ddf433db79mr16363235ab.7.1749682072269;
        Wed, 11 Jun 2025 15:47:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY9a6wD35TVkF8MOc9XWu0FMxi+spYWw9qJpcyVefsf+HWS6rquTNFxHZXjMPwL0rOAVr0Nw==
X-Received: by 2002:a05:6e02:190a:b0:3dd:b7da:5254 with SMTP id e9e14a558f8ab-3ddf433db79mr16363155ab.7.1749682071873;
        Wed, 11 Jun 2025 15:47:51 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ddfbace90fsm600085ab.40.2025.06.11.15.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:47:51 -0700 (PDT)
Date: Wed, 11 Jun 2025 16:47:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, rafael@kernel.org,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Nicolas Dichtel
 <nicolas.dichtel@6wind.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Set up runtime PM on devices that don't support
 PCI PM
Message-ID: <20250611164749.6262b0c7.alex.williamson@redhat.com>
In-Reply-To: <20250611222832.4067200-1-superm1@kernel.org>
References: <20250611222832.4067200-1-superm1@kernel.org>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 17:28:28 -0500
Mario Limonciello <superm1@kernel.org> wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
> initializing") intended to put PCI devices into D0, but in doing so
> unintentionally changed runtime PM initialization not to occur on
> devices that don't support PCI PM.  This caused a regression in vfio-pci
> due to an imbalance with it's use.
> 
> Adjust the logic in pci_pm_init() so that even if PCI PM isn't supported
> runtime PM is still initialized.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Reported-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Closes: https://lore.kernel.org/linux-pci/20250424043232.1848107-1-superm1@kernel.org/T/#m7e8929d6421690dc8bd6dc639d86c2b4db27cbc4
> Reported-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Closes: https://lore.kernel.org/linux-pci/20250424043232.1848107-1-superm1@kernel.org/T/#m40d277dcdb9be64a1609a82412d1aa906263e201
> Tested-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3dd44d1ad829b..c495c3c692f5f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3221,15 +3221,17 @@ void pci_pm_init(struct pci_dev *dev)
>  
>  	/* find PCI PM capability in list */
>  	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
> -	if (!pm)
> +	if (!pm) {
> +		goto poweron;
>  		return;

Unreachable return.  Thanks,

Alex

> +	}
>  	/* Check device's ability to generate PME# */
>  	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
>  
>  	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
>  		pci_err(dev, "unsupported PM cap regs version (%u)\n",
>  			pmc & PCI_PM_CAP_VER_MASK);
> -		return;
> +		goto poweron;
>  	}
>  
>  	dev->pm_cap = pm;
> @@ -3274,6 +3276,7 @@ void pci_pm_init(struct pci_dev *dev)
>  	pci_read_config_word(dev, PCI_STATUS, &status);
>  	if (status & PCI_STATUS_IMM_READY)
>  		dev->imm_ready = 1;
> +poweron:
>  	pci_pm_power_up_and_verify_state(dev);
>  	pm_runtime_forbid(&dev->dev);
>  	pm_runtime_set_active(&dev->dev);


