Return-Path: <linux-pci+bounces-27834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3FFAB962D
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 08:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994291B66197
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 06:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BA61361;
	Fri, 16 May 2025 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="kQKAcxKs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF164A0C;
	Fri, 16 May 2025 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747377932; cv=none; b=bGy5iYdqHxqrvXAsNudy4zhbowyTBD68CzqIOehxI2Tn8TZR+jqcyMa8zWGE6tJM7wRy2inEJYcceUyn2xk5PlHuUz447Tn19aoQ0WC2h782lOIPpOcSVY+Lnz6NfnFchKD+5SzqW8gMevslgItFDGCSG9KKiIvNCnTNI8v6pEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747377932; c=relaxed/simple;
	bh=4PqGR88p/sS4l3DEwVrJvao/LMbDQhYsWmLuThxyg3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPX8JyBZkMCSKVGxLPrkce0V+37F37uF9sLiW2KLia7R8dnVA5W9aeZJIiKZHTm/sfVUwvYaBlhTEiIBx/4Cqf/L7qNRY8eyyO3FplE7UPfLA7aJDbxYIRf9vKtz4nKplUOXlCQ9fNfuAEHI3oYptmNT3rqIsZiOSi7C3S0VZfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=kQKAcxKs; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 016414B65F;
	Fri, 16 May 2025 08:45:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1747377928;
	bh=4PqGR88p/sS4l3DEwVrJvao/LMbDQhYsWmLuThxyg3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQKAcxKsFPco0m28bnXz2F5leyXo9CnHTkcYL8qBTwXhpEQMM7SXUTpKbCxnts6Rj
	 Ise9D+crSeRxaKpcLsPFEvmC2uH7Lff5FBe64QQ/YpfBKFG15LTiHkhVGM2jKhCAhj
	 xaYPRbCen5ROusk5ZNwXyiXL/7YfxRYJR/3lHBs9T/DSKufE+ByKzdTr0aO/Rb5N/l
	 saX6fZrg/GP0lfbQYEoUfuZcIkQabR67fr+nUqhuB+EJVmrJlzgPueWgXo/Jf1oMKc
	 W2w1A06khpq9iNfJocAm+Ays7eDv35Nu+qIgUA9pbby+Nmw2+SqyeKSdaHBgukepx9
	 7691hl/E2sVaw==
Date: Fri, 16 May 2025 08:45:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Tushar Dave <tdave@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	jgg@nvidia.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 rc] iommu: Skip PASID validation for devices without
 PASID capability
Message-ID: <aCbfBqVu1C9Jtk7F@8bytes.org>
References: <20250505211524.1001511-1-tdave@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505211524.1001511-1-tdave@nvidia.com>

Hi Tushar,

On Mon, May 05, 2025 at 02:15:24PM -0700, Tushar Dave wrote:
>  drivers/iommu/iommu.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)

This doesn't apply to v6.15-rc6, can you please rebase and send a new
version?

Thanks,

	Joerg
> 

