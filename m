Return-Path: <linux-pci+bounces-43299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D362CCBE99
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 14:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C282A304E8D2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D93301002;
	Thu, 18 Dec 2025 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgTVwP5V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964E27145F;
	Thu, 18 Dec 2025 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063168; cv=none; b=nULbdwQD1dBEaR+RteoFna3a2ROFzYL4DHNXusALgMH5nLoXQZp2k5XzlQlh1ofCMy4VVpyL8EQmvmGrCN78Ju77sU/+Mn4sth7Mh/hdxP9FNrs5olt0pAhg7vu3YurjmBfY13McTK8Tw5g7OY6XYA0QwO4k5Z8VMN1xc8daU/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063168; c=relaxed/simple;
	bh=9nRcyrH16K66ewcgkmsIyJrhP3YxLhzzmY3Xpb7BH/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zgo3mA6plU/48wSjWzYoXkTA8oAVdl+MUO3vUszOzHkBK9v9KR2SOYleaXj8Girg4UGFNJpq4DqXCux4VAChLV2SLsSVRMlmO9eSIjnyHIeKbVRSAfI3nWAjX7Enu5nSm7bKNAjgf7uSWFz+3LPsjrTxF477znBD7hz3kMGKsbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgTVwP5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132B9C4CEFB;
	Thu, 18 Dec 2025 13:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766063167;
	bh=9nRcyrH16K66ewcgkmsIyJrhP3YxLhzzmY3Xpb7BH/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lgTVwP5VhlEHzWbRIqnE3NNeZAF9yjlXM86ew00CRCZBkB1lxbrzK1pHTKny1dRft
	 zRn0Z8X0k35cE9GTdUHVv5zfyFOoeG8sahwzm3tPi22hdTO67g6JPEYOuwmYx1/Len
	 mhGunn+gOvDcuFHMt/8uHN0Nqf8wXyxtc/LQw7tnGFtKSNTUgKb7YJ2E+lRfhot+D5
	 afmsOa5HLmzmI7SODGArpK9n1elkoMWsgjupquscE9Q2j4uAJiWLEQZZU5Qtfv/iJ/
	 gmAzhylQg24fo4s0WWr+4zX2kop8g4jY5VMyZWfEjA0Hw80Y5/8y3DaM3aRQ0leYP5
	 7X5EGrUN6W4xw==
Date: Thu, 18 Dec 2025 18:36:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] PCI: of: Remove max-link-speed generation
 validation
Message-ID: <vpnjb4tip76yiy4uhn3frun6forrb57bq5czjvkx77uxt7ooc3@twemnyweabv6>
References: <20251218125909.305300-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251218125909.305300-1-18255117159@163.com>

On Thu, Dec 18, 2025 at 08:59:09PM +0800, Hans Zhang wrote:
> The current implementation of of_pci_get_max_link_speed() validates
> max-link-speed property values to be in the range 1~4 (Gen1~Gen4).
> However, this creates maintenance overhead as each new PCIe generation
> requires updating this validation logic.
> 
> Since device tree binding validation already enforces the allowed
> values through the schema, and the callers of this function perform
> their own validation checks, this intermediate validation becomes
> redundant.
> 
> Furthermore, with upcoming SOCs using Synopsys/Cadence IP requiring
> Gen5/Gen6 support, removing this hardcoded check enables seamless
> support for future PCIe generations without requiring kernel updates
> for each new speed grade.
> 
> Remove the max-link-speed > 4 validation check while retaining the
> property existence and non-zero check. This simplifies maintenance
> and aligns with the existing validation architecture where DT binding
> and driver-level checks provide sufficient validation.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes for v5:
> - Delete the check for speed. (Mani)
> 
> Changes for v4:
> https://patchwork.kernel.org/project/linux-pci/patch/20251105134701.182795-1-18255117159@163.com/
> 
> - Add pcie_max_supported_link_speed.(Ilpo)
> 
> Changes for v3:
> https://patchwork.kernel.org/project/linux-pci/patch/20251101164132.14145-1-18255117159@163.com/
> 
> - Modify the commit message.
> - Add Reviewed-by tag.
> 
> Changes for v2:
> https://patchwork.kernel.org/project/linux-pci/cover/20250529021026.475861-1-18255117159@163.com/
> - The following files have been deleted:
>   Documentation/devicetree/bindings/pci/pci.txt
> 
>   Update to this file again:
>   dtschema/schemas/pci/pci-bus-common.yaml
> ---
>  drivers/pci/of.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..1f8435780247 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -889,8 +889,7 @@ int of_pci_get_max_link_speed(struct device_node *node)
>  {
>  	u32 max_link_speed;
>  
> -	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
> -	    max_link_speed == 0 || max_link_speed > 4)
> +	if (of_property_read_u32(node, "max-link-speed", &max_link_speed))
>  		return -EINVAL;

It'd be good to return the actual errno as of_property_read_u32() can return
-EINVAL, -ENODATA and -EOVERFLOW.

With that change,

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்

