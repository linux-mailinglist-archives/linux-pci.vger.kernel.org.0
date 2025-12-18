Return-Path: <linux-pci+bounces-43291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EEECCBD39
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 376F43016377
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88819331A44;
	Thu, 18 Dec 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bThJxrlA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4532E748;
	Thu, 18 Dec 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766061869; cv=none; b=sL4nwKQ2+2QPGeNfNJtD2W3efgScr8TmyfKBGF1ZNyuQH3r/+rp7ws70YxIyVOywOnDjfCOKTqDjOgYAVzr15B1vR/RR2o/zMHhIM4lvXReBoZrW6Ly/nR79SFQrYusaMVetC+LnlK4ar0jCKzA37Kx9mOSkE7oJ3Yr76tlvZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766061869; c=relaxed/simple;
	bh=xHIlkzft5f3tKi5DHJRcKpkVJc2siZf63SbQ3UPMfnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfHZipzihfkmXPj/8g8yhK2WtuORLP4dk147fLxSnf2h0DzNL569BhAlhZSIN/RDq2Hn4kMO35abd5ePFGhrdxrY6N2HMsCiJysvWJOfBadjhDkbXc9aNb+xhW29gsAqAn3ig80xnrNczAaBwxwxrwC5dFz7+D5FI/pUInr7GQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bThJxrlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9934FC4CEFB;
	Thu, 18 Dec 2025 12:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766061868;
	bh=xHIlkzft5f3tKi5DHJRcKpkVJc2siZf63SbQ3UPMfnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bThJxrlAiFr0X4QVedXtw0UMnMRCVOHmHrAw7adIjXoZfl/UqSEV/gwSb0ZGE2o9Y
	 PXpqlt9O59ES2SOe9xw93RRXfd+NjKZBtEQtNjSjC6JuhsuPTd8vkeIBaWT6lMIV2R
	 G9imDxrmlIHNFWNC6gGFJOzWizglo9/Cdll4/X8va561ia2YLQARcpK4Mbk3Sku3IG
	 UlDiAyNbwXg5pbVXQkwUCbpKFG4z/l8FoPaRnaxi2MJ+kxu0Wek14PYZuFpIVYr4b4
	 YhWva/1CNZfpwxXYXynv108+kyMM+gPP4l3ILKYOqgueqxGPyDrhSVP1EfcYfQZHbG
	 qJ1y2Nqr+QZpA==
Date: Thu, 18 Dec 2025 18:14:16 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] PCI: of: Relax max-link-speed check to support
 PCIe Gen5/Gen6
Message-ID: <jwyze44q3dte4ac3ajythb7mxy7sp2hcidugp2kowxubcp6knm@fcixtanjn2ss>
References: <20251105134701.182795-1-18255117159@163.com>
 <hsfa7kxvhrjcth3pabsrid2bzzjch7thu2uxggrg32tt54ipaq@lj7nbweoaj35>
 <b4c24074-0898-40d8-8cf0-ff5f95e2a8a9@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4c24074-0898-40d8-8cf0-ff5f95e2a8a9@163.com>

On Thu, Dec 18, 2025 at 07:56:14PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/12/18 14:31, Manivannan Sadhasivam wrote:
> > On Wed, Nov 05, 2025 at 09:47:01PM +0800, Hans Zhang wrote:
> > > The existing code restricted max-link-speed to values 1~4 (Gen1~Gen4),
> > > but current SOCs using Synopsys/Cadence IP may require Gen5/Gen6 support.
> > > While DT binding validation already checks this property, the code-level
> > > validation in of_pci_get_max_link_speed still lags behind, needing an
> > > update to accommodate newer PCIe generations.
> > > 
> > > Hardcoded literals in such validation logic create maintainability
> > > challenges, as they are difficult to track and update when adding
> > > support for future PCIe link speeds.  To address this, a helper function
> > > pcie_max_supported_link_speed() is added in drivers/pci/pci.h, which
> > > calculates the maximum supported link speed generation using existing
> > > PCIe capability macros (PCI_EXP_LNKCAP_SLS_*). This ensures alignment
> > > with the kernel's generic PCIe link speed definitions and avoids
> > > standalone hardcoded values.
> > > 
> > > The previous hardcoded "4" in the validation check is replaced with a
> > > call to this helper function, eliminating the need to modify this specific
> > > code path when extending support for future PCIe generations.
> > 
> > How can you not modify this function when PCIe 7.0 gets added? It still requires
> > an update.
> > 
> > I'd prefer to just drop the check altogether as the callers already have checks
> > on their own.
> 
> Hi Mani,
> 
> 
> Thank you very much for your reply. Do you mean the following modification?
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..9d3980e425b4 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -890,7 +890,7 @@ int of_pci_get_max_link_speed(struct device_node *node)
>  	u32 max_link_speed;
> 
>  	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
> -	    max_link_speed == 0 || max_link_speed > 4)
> +	    max_link_speed == 0)
>  		return -EINVAL;
> 
>  	return max_link_speed;
> 

Yes! But you could remove the 0 check also.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

