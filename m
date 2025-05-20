Return-Path: <linux-pci+bounces-28092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64069ABD5B5
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 13:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA157AB4B7
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A3A27510C;
	Tue, 20 May 2025 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG1nKKbO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093892571C5;
	Tue, 20 May 2025 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747738809; cv=none; b=Q73sFuYfGTd9JAIH5Yqh1WEj5zM639cBPxHhWfAuO3x3xwlX+UxEWOg8IGFHHVDz6oHlmFUCiHTfBYJ1N35eqoDifbMhRTRWqmXeSTrCmLWTN48C3R5gGINkSvKPEaImkmCaTY8GtMuFlnqFOYEeKp83BdjavRqwfPY91RwBkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747738809; c=relaxed/simple;
	bh=fNBNOvnSO4ornS7Fqdg0T7Vkbw0XCVVCOgfGhmlue7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qCLC+pwdSH9dKXYDB3rxKy2VPRwvLJWZUcPYadiC3H9IK8yFdl2qWq9SzRQbuYxp+iw9YOpuiG2NoXZpDOMX9SmfaLcTEZDuufQypPfkucXgt43MBfjPjCMevmw5TisJeZaPT2RSgZPZztV66Uz3ZIPUTBHSntwfYiv0oYtAxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG1nKKbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA21CC4CEE9;
	Tue, 20 May 2025 11:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747738808;
	bh=fNBNOvnSO4ornS7Fqdg0T7Vkbw0XCVVCOgfGhmlue7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nG1nKKbOcAmw5B3/IKd7g/gctFDAdEv5GEt3hh2DYkvwUWvB+8OpOLDjVpKajOMHC
	 L8C9V4Jl9j91txRCH3hFePZj+pwb/VG0Ay7afMeWJK04u3vGZyjWM1gUHmsGUQ3XN2
	 FoObhNOvkEqka1CQUS16QOeihfdcbkvbnC3tVi7I/yPK6dDET8NiRjXKrw7gFYx20A
	 +KTXizLpTwlcKQ53PYFfei4xJp5k70jrSBJQTfNXCJ+szBiiHW4pA1s3IXxXcKv8HU
	 E1gSHTm1U2GuuiNm1tuPzL2dWHKAeriRQFF3qtv7bXEyeV62cC+Fell62xEHmM8xvG
	 OSNU6y1Gik/tA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, suzuki.poulose@arm.com,
	sameo@rivosinc.com, aik@amd.com, jgg@nvidia.com, zhiw@nvidia.com,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 13/13] PCI/TSM: Add Guest TSM Support
In-Reply-To: <20250516054732.2055093-14-dan.j.williams@intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-14-dan.j.williams@intel.com>
Date: Tue, 20 May 2025 16:30:01 +0530
Message-ID: <yq5ar00j4kem.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> From: Xu Yilun <yilun.xu@linux.intel.com>
...

> @@ -558,11 +675,11 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
>  	if (!pdev->tsm)
>  		return -EINVAL;
>  
> -	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> -	if (!pf0_dev)
> +	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
> +	if (!dsm_dev)
>  		return -EINVAL;
>  
> -	struct mutex *ops_lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
> +	struct mutex *ops_lock __free(tdi_ops_unlock) = tdi_ops_lock(dsm_dev);
>  	if (IS_ERR(ops_lock))
>  		return PTR_ERR(ops_lock);
>  
> @@ -573,10 +690,13 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
>  			return -EBUSY;
>  	}
>  
> -	tdi = tsm_ops->bind(pdev, pf0_dev, kvm, tdi_id);
> +	tdi = tsm_ops->bind(pdev, dsm_dev, kvm, tdi_id);
>  	if (!tdi)
>  		return -ENXIO;
>  
> +	tdi->pdev = pdev;
> +	tdi->dsm_dev = dsm_dev;
> +	tdi->kvm = kvm;
>  	pdev->tsm->tdi = tdi;
>

should that be no_free_ptr(dsm_dev)? Also unbind needs to drop that
device reference? 

modified   drivers/pci/tsm.c
@@ -697,7 +697,7 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
 		return -ENXIO;
 
 	tdi->pdev = pdev;
-	tdi->dsm_dev = dsm_dev;
+	tdi->dsm_dev = no_free_ptr(dsm_dev);
 	tdi->kvm = kvm;
 	pdev->tsm->tdi = tdi;
 
@@ -714,10 +714,6 @@ static int __pci_tsm_unbind(struct pci_dev *pdev)
 	if (!pdev->tsm)
 		return -EINVAL;
 
-	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
-	if (!dsm_dev)
-		return -EINVAL;
-
 	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(dsm_dev);
 	if (IS_ERR(lock))
 		return PTR_ERR(lock);
@@ -726,6 +722,10 @@ static int __pci_tsm_unbind(struct pci_dev *pdev)
 	if (!tdi)
 		return 0;
 
+	struct pci_dev *dsm_dev __free(pci_dev_put) = tdi->dsm_dev;
+	if (!dsm_dev)
+		return -EINVAL;
+
 	tsm_ops->unbind(tdi);
 	pdev->tsm->tdi = NULL;
 


>  
>  	return 0;
> @@ -592,11 +712,11 @@ static int __pci_tsm_unbind(struct pci_dev *pdev)
>  	if (!pdev->tsm)
>  		return -EINVAL;
>  
> -	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> -	if (!pf0_dev)
> +	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
> +	if (!dsm_dev)
>  		return -EINVAL;
>  
> -	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
> +	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(dsm_dev);
>  	if (IS_ERR(lock))
>  		return PTR_ERR(lock);
>  
> @@ -641,11 +761,11 @@ int pci_tsm_guest_req(struct pci_dev *pdev, struct pci_tsm_guest_req_info *info)
>  	if (!pdev->tsm)
>  		return -ENODEV;
>  
> -	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> -	if (!pf0_dev)
> +	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
> +	if (!dsm_dev)
>  		return -EINVAL;
>  
> -	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
> +	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(dsm_dev);
>  	if (IS_ERR(lock))
>  		return -ENODEV;
>  

...

-aneesh

