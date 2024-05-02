Return-Path: <linux-pci+bounces-7029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2B48BA30D
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 00:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73FCEB2372C
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 22:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0239A57CA4;
	Thu,  2 May 2024 22:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bICtA7Ao"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF34257C87;
	Thu,  2 May 2024 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714688320; cv=none; b=asvP3sulsoyd/uli66NGiQFUqT8RFVqf8eaoLSstKP1AdwomXBoTM+6aE/ZOCBGeOGCiCJ4u9Nqo54qxRH07fTZdVtjdGEBVFs2x43+zvAvhWxRgiChWAtkxn/GtML/tZKME1ld/oYwSyrq10BP12D/vw1q4RcrQb0XyGJ6Ee0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714688320; c=relaxed/simple;
	bh=PTqyU1X60PHvmFURUHoOiLjIZmosyMr4g0VIq2oIjSU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qymj6kdAgcP4usrHCC1e1jnBvX+pUBCJOoO8D6DCY0h4VX8ophPM2/LX9iqK8uZDRvT7WFvBPKxjG7SuDrL2W7rmLTvISondKJSg+Sksoo7qKDirR9J2AteJB35wmrUhSWONFYI4diOur/xJfEgMKrYEd4ybLQDimUAvOTI3Oj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bICtA7Ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212A6C113CC;
	Thu,  2 May 2024 22:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714688320;
	bh=PTqyU1X60PHvmFURUHoOiLjIZmosyMr4g0VIq2oIjSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bICtA7AoCD5dDRhPzN+5H+MBpDnhewXyaCocV615di6ogh5b2XDVKqsiUYWkZYqt4
	 Mtx0lujpZl7KqxDroSJ9O2+P8drd5PMwUsZBmFCkBEaUlrtrGXNKQSVzJuWZ179xNl
	 iqk+Ynntg2h630d81Tn7WSk6BenaAo+5APFCwDIYq8De9+o9MQWn8iZpt8sS0EOaQG
	 HVwsqmpgmcw1YbdcfsCLNJuhFtZWuINrM7DyxD7XFot/VOzEF2TEamnLhv9oPd//vJ
	 vRXjsYkJfuAWH2HxMz+UsIudZUdd3JpGibtYPIZFZ4TW55BbYkW/8s7UuqQnHplNzn
	 g9ku4SC/f82hQ==
Date: Thu, 2 May 2024 17:18:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, Lizhi Hou <lizhi.hou@amd.com>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] PCI: of_property: handle int_map allocation failure
Message-ID: <20240502221838.GA1550875@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303105729.78624-1-duoming@zju.edu.cn>

[+cc Lizhi (when you post a fix to a commit, please always cc the
author of that original commit), Rob]

On Sun, Mar 03, 2024 at 06:57:29PM +0800, Duoming Zhou wrote:
> The kcalloc() in of_pci_prop_intr_map() will return null if
> the physical memory has run out. As a result, both int_map
> and mapp will point to the null area. If we dereference mapp,
> the null pointer dereference bugs will happen.
> 
> Return -ENOMEM from of_pci_prop_intr_map() if kcalloc() fails
> for int_map.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Applied to pci/of for v6.10, thanks!

Lizhi and Rob, let me know if you have any objections.

> ---
>  drivers/pci/of_property.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index c2c7334152b..03539e50537 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -238,6 +238,8 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
>  		return 0;
>  
>  	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
> +	if (!int_map)
> +		return -ENOMEM;
>  	mapp = int_map;
>  
>  	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
> -- 
> 2.17.1
> 

