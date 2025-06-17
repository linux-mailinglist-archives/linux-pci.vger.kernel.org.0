Return-Path: <linux-pci+bounces-29956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9731CADD98C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 19:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D431BC21CB
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184202DFF2E;
	Tue, 17 Jun 2025 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sfj9yeEq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05AA2FA630;
	Tue, 17 Jun 2025 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179056; cv=none; b=bww0aHdg07VX8yBHKE1W7dXxBebXx8GXiRGcqq7DALjFGkTwZd5XMTANXXJhiwA1XQKO826r/KUk1k2LLizfiDYkFKGdB0Xv/ESvbael/2NG4smBzTSe3O2f9jRlO0MDRJu1HnFdRCBxwCh4kg4DW2sk6UShXctYPJ3TyT5UKqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179056; c=relaxed/simple;
	bh=G8asLFykMSjJ6bSeXKgxGkckfXh721m/A50zrFfuCvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjAy9+GfX/5dVstOdXPI8mTdNc8417Dce/1pmf39CiCSXoGogVgFY/O0j7yaxQN2qlTlgU1XbFzd56gnyHYWS4hm1pN5mXsKhp3Ea+lZ4gko0cGD3OWn8ziua8Mnzi03FXa7dpM/6zlh1bILHgyypYIDDeAv7B7W9GLhJwwCimI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sfj9yeEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CD9C4CEF0;
	Tue, 17 Jun 2025 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750179055;
	bh=G8asLFykMSjJ6bSeXKgxGkckfXh721m/A50zrFfuCvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sfj9yeEq9P+YpxAmAbKAVH7IF2WhEg1gPyAZRAHMZAai/ch6Qsx0d2WHEbH6XQEDU
	 sQYlcEHIy/F9RvDvyb5RT9K/ZKU408kOQ0jT9NGCcTzfiZj97j0lZnBZGNarDs4swp
	 TJYcyEC2WqKZNPxaTfSHYKR6PeReSifYaMHsLwQEGW1gXXabeKQTYHJ6YFMfwp0Sb7
	 AQgsmOhqBGqFrvP55yRUXeH/7slVuUtrLDpqnskCLtl8CEZAo06QBWdwaDlaySZkLZ
	 kdE6OSfSDPIx1rA/9T/Js+tVz/W+TgXoLbRnuRBjRVu7s7be5KOvvyHZLZkbmBtXyR
	 0D+GROoncHVPA==
Date: Tue, 17 Jun 2025 22:20:47 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	krzk+dt@kernel.org, manivannan.sadhasivam@linaro.org, conor+dt@kernel.org, 
	robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] PCI: of: Relax max-link-speed check to support
 PCIe Gen5/Gen6
Message-ID: <5baxv7vnmm46ye6egf6i54letsl6c6zcsle4aoaigxnve33pfk@qn33xy5wfghv>
References: <20250529021026.475861-1-18255117159@163.com>
 <20250529021026.475861-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250529021026.475861-4-18255117159@163.com>

On Thu, May 29, 2025 at 10:10:26AM +0800, Hans Zhang wrote:
> The existing code restricted `max-link-speed` to values 1~4 (Gen1~Gen4),
> but current SOCs using Synopsys/Cadence IP may require Gen5/Gen6 support.
> This patch updates the validation in `of_pci_get_max_link_speed` to allow
> values up to 6, ensuring compatibility with newer PCIe generations.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

DT binding validation should be sufficient. But still...

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index ab7a8252bf41..379d90913937 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -890,7 +890,7 @@ int of_pci_get_max_link_speed(struct device_node *node)
>  	u32 max_link_speed;
>  
>  	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
> -	    max_link_speed == 0 || max_link_speed > 4)
> +	    max_link_speed == 0 || max_link_speed > 6)
>  		return -EINVAL;
>  
>  	return max_link_speed;
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

