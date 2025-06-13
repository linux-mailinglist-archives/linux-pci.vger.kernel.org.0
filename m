Return-Path: <linux-pci+bounces-29678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E4AAD8B29
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 13:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBE8171880
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 11:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BC82F3649;
	Fri, 13 Jun 2025 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvz6J9l6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA1C2ED873;
	Fri, 13 Jun 2025 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814975; cv=none; b=fDtXGdtJysQAlkawrRuSlWu1IOGGERvDEMtwosM82unm4qY+WzuVSWRLOJZ3MFkZ3gAzFjMSHWlRq+DfmtTNeYaOhs6MiWzmkGzLOeKuq2k9m6nk84IABn2SAaL6q3KsVO6wYl3ZALPMgoe+xy7mPdH88OHnuZ6wxTRHdGh+aRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814975; c=relaxed/simple;
	bh=pCBlCuG9Neif5IPi1RmChNHeLoVqg6sWDPGO2L3rdng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBNJNhTX3N9w7Cpitd68ES3hArJgAVgRoyjdmJJaVYWN5SEzpb4PF31fZ3h/+2/WLpyfiHEOcbAAcZGJG/UefsQ+A41dku+YWX1Z/iVVPFbSJdhuF4SdPsSj2Rvc4Fut5RMQlEroh3cVBHsb6U0xl75Nm5SJYpIIcd8HqUICSI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvz6J9l6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5871AC4CEE3;
	Fri, 13 Jun 2025 11:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749814975;
	bh=pCBlCuG9Neif5IPi1RmChNHeLoVqg6sWDPGO2L3rdng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvz6J9l61wbBCQv3BuKWM9TEx1ApP+hCbHvp9m6ZDvH+nkMvLxD02kCYauL4MOrX2
	 /Pm2kofSDJn2ZLpRDuC1RLr3zB2dWuzrehvtqe/PPhNrAEs5R8nVZ4ZZJqK3vM5bm5
	 fXZl78J2QwO+Zptb7Oxn7sODSQ7jPwl48e6Bh8YtWG1JnsQmXFx5kHE4SXclLpxowp
	 zUceEWFeMTK+QqaQx/ynqmxycQotIZYSahdp0kFE4I5FCT9CVCHfFo15vwAsvAIT96
	 GPXHtJwXtN0UuRAUA3ZieY0+delpZXtnr+D5yLkPf02wC9URgQnR/f26LG9t5wYEkH
	 FFLXlewdNLsdA==
Date: Fri, 13 Jun 2025 17:12:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: grwhyte@linux.microsoft.com
Cc: linux-pci@vger.kernel.org, shyamsaini@linux.microsoft.com, 
	code@tyhicks.com, Okaya@kernel.org, bhelgaas@google.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: Reduce FLR delay to 10ms for MSFT devices
Message-ID: <ccclacbxzdarqy27wlwqqcsogbrodwwslt7t5sp64xvqpa3wsl@xs5cllh7a6ft>
References: <20250611000552.1989795-1-grwhyte@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611000552.1989795-1-grwhyte@linux.microsoft.com>

On Wed, Jun 11, 2025 at 12:05:50AM +0000, grwhyte@linux.microsoft.com wrote:
> From: Graham Whyte <grwhyte@linux.microsoft.com>
> 
> Add a new flr_delay member of the pci_dev struct to allow customization of
> the delay after FLR for devices that do not support immediate readiness
> or readiness time reporting. The main scenario this addresses is VF
> removal and rescan during runtime repairs and driver updates, which,
> if fixed to 100ms, introduces significant delays across multiple VFs.
> These delays are unnecessary for devices that complete the FLR well
> within this timeframe.
> 

I don't think it is acceptable to *reduce* the standard delay just because your
device completes it more quickly. Proper way to reduce the timing would be to
support FRS as you said, but we cannot have arbitrary delays for random devices.

- Mani

> Patch 1 adds the flr_delay member to the pci_dev struct
> Patch 2 adds the msft device specific quirk to utilize the flr_delay
> 
> ---
> v2->v3:
> - Removed Microsoft specific pcie reset reset, replaced with customizable flr_delay parameter
> - Changed msleep in pcie_flr to usleep_range to support flr delays of under 20ms 
> v1->v2:
> - Removed unnecessary EXPORT_SYMBOL_GPL for function pci_dev_wait
> - Link to thread:https://lore.kernel.org/linux-pci/?q=f%3Agrwhyte&x=t#m7453647902a1b22840f5e39434a631fd7b2515ce'
> 
> Link to V1: https://lore.kernel.org/linux-pci/20250522085253.GN7435@unreal/T/#m7453647902a1b22840f5e39434a631fd7b2515ce  
> 
> Graham Whyte (2):
>   PCI: Add flr_delay parameter to pci_dev struct
>   PCI: Reduce FLR delay to 10ms for MSFT devices
> 
>  drivers/pci/pci.c    |  8 ++++++--
>  drivers/pci/pci.h    |  2 ++
>  drivers/pci/quirks.c | 20 ++++++++++++++++++++
>  include/linux/pci.h  |  1 +
>  4 files changed, 29 insertions(+), 2 deletions(-)
> 
> -- 
> 2.25.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

