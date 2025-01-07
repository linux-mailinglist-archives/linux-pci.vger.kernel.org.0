Return-Path: <linux-pci+bounces-19477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B74A04CBD
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E52F3A13D0
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 22:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947961DE8AF;
	Tue,  7 Jan 2025 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF3QcgTC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688BC190664;
	Tue,  7 Jan 2025 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290615; cv=none; b=QmLD2RecO2+KXOrq8OHK107zruc1iYTsZFLS2rDcBnP0skpxU8hcDEi/0hbIkqUrZ1y5JPIlmMwI7ak/rWBduEFjIBf7dAMpbZ2WHNZQTg5Yg8wqoxqmNPD5RUdir+PQDvcDVNZX+jroXgLqBepHM7w2lEypRMMtm/FaCrmQUf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290615; c=relaxed/simple;
	bh=Uu7xq9XM13IosmKAtUDCEJiXSNkbDjbe5WLOqFhn/vw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DsMkgmRJb03BFEMery20Z9uAiSs0PNr4wh8ctMJvhF3dPA67vwW1PvsYX7q9w5cX1zQ2OM36KpHPwFgUl+ovAkvRfB2dm5HuVEkFOOyp5FcL1F3IBI0+pNxT2eNWMla1gVZ2Mj0iekp8KX9wxVZ/DyP684D+bOTTWpvVlArq7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uF3QcgTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C828EC4CED6;
	Tue,  7 Jan 2025 22:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736290615;
	bh=Uu7xq9XM13IosmKAtUDCEJiXSNkbDjbe5WLOqFhn/vw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uF3QcgTCujONept9Uno7iOwTSNdvb905ueIhvbJ2edgfWaswKlRf/hIIPXDVQgNZc
	 AeQnR2xcsxHQDZgFFIEcYUP+ZpjBmLD1Q8Dv+CMPuPBingzlJoHtZv7t0NLXwt0RkI
	 z/ZQHhm/aD7MB2kqaQC1wX0l1gablp3pHVFuob7NS1oEYPYajnb7TfArEPSS43nIbU
	 a/SckdWNp1WmKSyGzWNiCqQMjgZC0ncsAh+lzKRd6xque3FQIYraenNmQtFL/0BAk0
	 5u/6r6rOOvvnieEFk1DbZDwgJ2ff2s661tmxeGP/ei3bcswuXeokSUpxg7yZ7p0Ahw
	 T59FhG9sxECWw==
Date: Tue, 7 Jan 2025 16:56:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kingdix10@qq.com
Cc: marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, prabhakar.csengg@gmail.com,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4] PCI: rcar-ep: Fix the issue of the name parameter
 when calling devm_request_mem_region
Message-ID: <20250107225653.GA189000@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F1132FBA08580D482F6A1EF7605710E5F005@qq.com>

On Tue, Jan 07, 2025 at 09:51:23PM +0800, kingdix10@qq.com wrote:
> From: King Dix <kingdix10@qq.com>
> 
> When using devm_request_mem_region to request a resource, if the passed
> variable is a stack string variable, it will lead to an oops issue when
> executing the command cat /proc/iomem.
> 
> Fix this by replacing outbound_name with the name of the previously
> requested resource.

Thanks a lot for doing this work!

Add "()" after function names in subject and commit log.

Please include a couple lines of the oops message to help people
connect the problem with the fix.

I suppose you found this by tripping over it.  Can you look through
the other callers of devm_request_mem_region() and similar interfaces,
at least in drivers/pci, and make sure there are no other similar
errors?

> Fixes: 2a6d0d63d999 ("PCI: rcar: Add endpoint mode support")
> 
> Signed-off-by: King Dix <kingdix10@qq.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Changes in v4:
>   - Add more information to the comment.
> Changes in v3:
>   - Fix the spelling issue in the comment.
> Changes in v2:
>   - Fix the code indentation issue.
> ---
>  drivers/pci/controller/pcie-rcar-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
> index 047e2cef5afc..c5e0d025bc43 100644
> --- a/drivers/pci/controller/pcie-rcar-ep.c
> +++ b/drivers/pci/controller/pcie-rcar-ep.c
> @@ -107,7 +107,7 @@ static int rcar_pcie_parse_outbound_ranges(struct rcar_pcie_endpoint *ep,
>  		}
>  		if (!devm_request_mem_region(&pdev->dev, res->start,
>  					     resource_size(res),
> -					     outbound_name)) {
> +					     res->name)) {
>  			dev_err(pcie->dev, "Cannot request memory region %s.\n",
>  				outbound_name);
>  			return -EIO;
> -- 
> 2.43.0
> 

