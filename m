Return-Path: <linux-pci+bounces-28079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7877ABD34C
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 11:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3630E163272
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 09:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407FE2641EA;
	Tue, 20 May 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZmQL4qo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE0C25DD18;
	Tue, 20 May 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733118; cv=none; b=b+Tchzcibelh8iRHEkgjj4nKTZEt/hC2YcItX+IAjdRNDkUhr36vdhFmzY7AJbfEjbIK1qNC157mH1NjLJjTAwWQkr3kR9JnmfBCt9Z3ND/8OXbX5W48i/2UwPxjGTJNbb8zrmYjjY9KTyKBF6KC1IQnKg3sMzHkBxETv5j6Qsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733118; c=relaxed/simple;
	bh=syLi3+nLFiEkErIkSF2SB2/M2ELgSIug80hxjccCA0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nke0iqsEI3qO3OgnQJ2tWIUfCqRphR05rJx4mzM5ublQ5RA3l4Z5SXq2mXosYVAdVKsUr5a4HJ6Z1qcr9uUpqrSSXnt2d3Bxwc6wQ3r1PEEntRmXKLkrTCtOKjy6jmmadVU031rvTOPMW6vJqucyRwfdgsbOITaF8y3k4DGAmXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZmQL4qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97389C4CEEB;
	Tue, 20 May 2025 09:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747733115;
	bh=syLi3+nLFiEkErIkSF2SB2/M2ELgSIug80hxjccCA0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WZmQL4qo2/IR86fycFhPOErzPxTa+ulL0ZuP3SaVpnmG/s5AuEJQ+4QUblwbtaIfs
	 4EZsL7xRKsg008DAAAsZw2g7MMQY/B/FC8IADoVqbDFoggdjnnNtv4I2ScsgvtMfLi
	 hjll37mGws75wpJkI5a7y47Km66J2Br5/qQ8U+2m8lW+68tSKLICNxpfd1knso04IH
	 T8ihzB2OYWPMY9kgrM2Konx74FsFPytrNal+f4pPe40Ud04gr4ywgZQgy0i/HiTgMl
	 SSZbN1aFCmrjnsfbW3JvHojcmuhLbUQxBeHjdyYPhEaHd/yeWOHWuug7TO3A8IXKTj
	 0bifDOt9PGiag==
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
Date: Tue, 20 May 2025 14:55:08 +0530
Message-ID: <yq5att5f4osr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> From: Xu Yilun <yilun.xu@linux.intel.com>
> 
 .....

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

Can we do the below?

modified   include/linux/pci-tsm.h
@@ -38,7 +38,6 @@ enum pci_tsm_type {
  */
 struct pci_tdi {
 	struct pci_dev *pdev;
-	struct pci_dev *dsm_dev;
 	struct kvm *kvm;
 };
 
@@ -56,6 +55,7 @@ struct pci_tdi {
  */
 struct pci_tsm {
 	struct pci_dev *pdev;
+	struct pci_dev *dsm_dev;
 	enum pci_tsm_type type;
 	struct pci_tdi *tdi;
 };

And update dsm_dev during ->probe(). That will avoid these get/put()
operations in these functions.


-aneesh

