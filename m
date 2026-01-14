Return-Path: <linux-pci+bounces-44792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D39D20B8C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7E253045CC0
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341BE275AF0;
	Wed, 14 Jan 2026 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwzPfrKH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F10276058;
	Wed, 14 Jan 2026 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413730; cv=none; b=u43nXllPaFg23acC4+DLbb1YyPhoaCENWaESDIGEzS+mtywFnvcUur5Yj/VnAImIoNmiX5uziDyxVijyYLBHrINjc4Y8umFKwpKTLWzEE13FSqUhCPCtK69aNcebknbwXHmw1QAjmfnlmY85mPa7PVUMCrLuGMt7YJtfjJNhTv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413730; c=relaxed/simple;
	bh=03qS3bEIZhBcsL33wysjp+9lW6mY7rBmKOOtBceuzRU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qiW+zmLKwOATNFuLbdIBV9v3VX2ad335dmKAwq6dcdIOB1ePXz0Dwv2QiWLJwPolN2rmfgpK4bdY2ySimes0P1qpdJORd4ifYP02sfi3B7fWPD11U14iGrL0WjChdiHtf6VBiE4eTD1M9pmdici1y80nJpsbYcy4eDbY1Vs8UJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwzPfrKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A47DC4CEF7;
	Wed, 14 Jan 2026 18:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768413729;
	bh=03qS3bEIZhBcsL33wysjp+9lW6mY7rBmKOOtBceuzRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uwzPfrKHNdlfFNVkF8Usm5tyQsllnoZS/9vyMwttur7NmY40ROvLW+2R9uYvfMeWO
	 tZQ3jBEfKYPJO4uz+J6Prt0gIxfIKSdpmstR/D6bQiC9NA0ixIwz3ZHUFiHB2TondZ
	 pcl6Wpua5S9DosnotknCB2jM1O+5GUPj4KR71ii56BDKrz+0GYi6G9iExEUlxcJIgc
	 Kk4oBJi4S2GmtXZTAKf1yKokER7ZCIdPLbtRs8OGCYiQWTUdc+F3KTWZ7z6OzP4Yb9
	 ZCXtPq3dhAcblnDMSrX+cGtZI8pOs5CQq1H32VeX66LJHCIgm4kOiPSBJibNmKLJEz
	 gFdje8pAX5xrw==
Date: Wed, 14 Jan 2026 12:02:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, anshuman.gupta@intel.com,
	rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, rodrigo.vivi@intel.com,
	varun.gupta@intel.com, ville.syrjala@linux.intel.com,
	uma.shankar@intel.com, karthik.poosa@intel.com,
	matthew.auld@intel.com, sk.anirban@intel.com, raag.jadav@intel.com
Subject: Re: [PATCH v6 10/12] drm/xe/vrsr: Enable VRSR
Message-ID: <20260114180208.GA827276@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113164200.1151788-24-badal.nilawar@intel.com>

On Tue, Jan 13, 2026 at 10:12:11PM +0530, Badal Nilawar wrote:
> From: Anshuman Gupta <anshuman.gupta@intel.com>
> 
> Enable VRSR in runtime suspend and also in System wide suspend.
> Also fix couple of typo in xe_pm.c.

>  	 * Enabling D3Cold is needed for S2Idle/S0ix.
> -	 * It is save to allow here since xe_pm_suspend has evicted
> +	 * It is safe to allow here since xe_pm_suspend has evicted
>  	 * the local memory and the direct complete optimization is disabled.
>  	 */
>  	d3cold_toggle(pdev, D3COLD_ENABLE);
> @@ -1158,7 +1158,7 @@ static int xe_pci_resume(struct device *dev)
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	int err;
>  
> -	/* Give back the D3Cold decision to the runtime P M*/
> +	/* Give back the D3Cold decision to the runtime PM */

Hahahaha, just change the previous patch so these typos are never
introduced :)

