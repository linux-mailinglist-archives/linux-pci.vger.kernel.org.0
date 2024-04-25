Return-Path: <linux-pci+bounces-6674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8348B27C9
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 19:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C731DB220CC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 17:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED3714EC53;
	Thu, 25 Apr 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7L1yjXF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1FC14D6FF;
	Thu, 25 Apr 2024 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714067781; cv=none; b=XSowiPiKiWpQWNZk9EslurLFlg7sdz1MET90V3sRey12ByeaIZNzCjkFbzFTYQIQMqdLSx+KKVWJZjlBOMvueEsYeA60sg1/9Lce8blFJkZEKOYfm0DDhBQcsRrdgF0nIMORmy4t2lRu2qI5JdiNMakk7IVdbDjMjpV5udl9mAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714067781; c=relaxed/simple;
	bh=LzVZdtoDNDGly+8PBQMcPIG4Y9obGJckn9Ntux3+3YE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LbcotmbqkuAFD+t0ImgXulGB8dFQ8C2uB99eg3D9KYtalkUnzJtXjdBKFA3GNjg8cKJYoKjyqAaihIURfWdaLFRx0ffsPxyvMsEivhpBGxLJcIVklsK1GQI3TsirkwmKZcuj8OvnEcjrsZD0sDdW85H83KqeU6agFOg/NeFn4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7L1yjXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28E9C113CC;
	Thu, 25 Apr 2024 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714067780;
	bh=LzVZdtoDNDGly+8PBQMcPIG4Y9obGJckn9Ntux3+3YE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=W7L1yjXFVr+sUGcyNJGli/Ed2KyJbBOW4PrazHyYXikteDh3zl4z1fztGROA9eKIv
	 kaYdlgXzG58GZNm5aqCYFYWLKmpyvvUOXmi9ERYeWzm7MRLwCDhfFldY5a8C7StoI5
	 bMt3lTHWWoO+2GxNz73u3NvUmmKa/e+RwPXcrBnY5/QgYtyx0F13BQImqUVe3O4/Ua
	 R2M0esvSdvDMiIH3BOYD3Q7gIXyrRldLBrUb/ZZ+lD/sFJ9k17rQogcfwPBjeJRZTV
	 T5bICW8B92YpQLI220XnOkoAE5RpVB1Vsj9xpv+923bfEbE4DcFpZUbC1Dyn9rhs4w
	 GoPSWJz0w8SXQ==
Date: Thu, 25 Apr 2024 12:56:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Use the correct bit in Link Training not
 active check
Message-ID: <20240425175617.GA536953@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423130820.43824-1-ilpo.jarvinen@linux.intel.com>

On Tue, Apr 23, 2024 at 04:08:19PM +0300, Ilpo Järvinen wrote:
> Two changes were made into link retraining logic independent of each
> other.
> 
> The commit e7e39756363a ("PCI/ASPM: Avoid link retraining race") added
> check to ensure no Link Training is currently active into
> pcie_retrain_link() to address the Implementation Note in PCIe r6.1 sec
> 7.5.3.7. At that time pcie_wait_for_retrain() only checked for Link
> Training (LT) bit being cleared.
> 
> The commit 680e9c47a229 ("PCI: Add support for polling DLLLA to
> pcie_retrain_link()") generalized pcie_wait_for_retrain() into
> pcie_wait_for_link_status() which can wait either for LT or Data Link
> Layer Link Active (DLLLA) bit with 'use_lt' argument and supporting
> waiting for either cleared or set using 'active' argument.
> 
> In the merge commit commit 1abb47390350 ("Merge branch
> 'pci/enumeration'"), those two divergent branches converged. The merge
> changed LT bit checking added in the commit e7e39756363a ("PCI/ASPM:
> Avoid link retraining race") to now wait for completion of any ongoing
> Link Training using DLLLA bit being set if 'use_lt' is false.
> 
> When 'use_lt' is false, the pseudo-code steps of what occurs in
> pcie_retrain_link():
> 
> 	1. Wait for DLLLA=1
> 	2. Trigger link to retrain
> 	3. Wait for DLLLA=1
> 
> Step 3 waits for the link to come up from the retraining triggered by
> Step 2. As Step 1 is supposed to wait for any ongoing retraining to
> end, using DLLLA also for it does not make sense because link training
> being active is still indicated using LT bit, not with DLLLA.
> 
> Correct the pcie_wait_for_link_status() parameters in Step 1 to only
> wait for LT=0 to ensure there is no ongoing Link Training.
> 
> This only impacts the Target Speed quirk, which is the only case where
> waiting for DLLLA bit is used. It currently works in the problematic
> case by means of link training getting initiated by hardware repeatedly
> and respecting the new link parameters set by the caller, which then
> make training succeed and bring the link up, setting DLLLA and causing
> pcie_wait_for_link_status() to return success. We are not supposed to
> rely on luck and need to make sure that LT transitioned through the
> inactive state though before we initiate link training by hand via RL
> (Retrain Link) bit.
> 
> Fixes: 1abb47390350 ("Merge branch 'pci/enumeration'")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

I applied both of these with minor typo fixes to pci/enumeration for
v6.10, thanks!

  73cb3a35f94d ("PCI: Wait for Link Training==0 before starting Link retrain")
  cdc6c4abcb31 ("PCI: Clarify intent of LT wait")

We can update if needed based on feedback from Maciej.

> ---
> 
> v2:
> - Improve commit message
> 
> NOTE: Maciej NAK'ed the v1 of this patch but has since retracted his
> NAK.
> 
> Maciej, if possible, could you please test this with your HW?
> 
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e5f243dd4288..70b8c87055cb 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4629,7 +4629,7 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
>  	 * avoid LTSSM race as recommended in Implementation Note at the
>  	 * end of PCIe r6.0.1 sec 7.5.3.7.
>  	 */
> -	rc = pcie_wait_for_link_status(pdev, use_lt, !use_lt);
> +	rc = pcie_wait_for_link_status(pdev, true, false);
>  	if (rc)
>  		return rc;
>  
> -- 
> 2.39.2
> 

